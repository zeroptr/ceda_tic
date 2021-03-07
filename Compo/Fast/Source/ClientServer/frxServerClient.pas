
{******************************************}
{                                          }
{             FastReport v4.0              }
{              Server Client               }
{                                          }
{         Copyright (c) 1998-2009          }
{          by Alexander Fediachov,         }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxServerClient;

{$I frx.inc}

interface

uses
  Windows, SysUtils, Classes, Forms, Controls,

  frxClass, ScktComp,
  frxVariables, frxGZip, frxHTTPClient, frxMD5,
  frxServerUtils, frxNetUtils, frxUnicodeUtils;

type

  TfrxServerConnection = class (TComponent)

  private
    FHost: String;
    FLogin: String;
    FMIC: Boolean;
    FPassword: String;
    FPort: Integer;
    FProxyPort: Integer;
    FProxyHost: String;
    FRetryCount: Integer;
    FRetryTimeout: Cardinal;
    FTimeout: Cardinal;
    FPath: String;
    FCompression: Boolean;
    procedure SetPath(const Value: String);

  public
    constructor Create(AOwner: TComponent); override;
  published
    property Compression: Boolean read FCompression write FCompression;
    property Host: String read FHost write FHost;
    property Login: String read FLogin write FLogin;
    property MIC: Boolean read FMIC write FMIC;
    property Password: String read FPassword write FPassword;
    property Port: Integer read FPort write FPort;
    property ProxyHost: String read FProxyHost write FProxyHost;
    property ProxyPort: Integer read FProxyPort write FProxyPort;
    property RetryCount: Integer read FRetryCount write FRetryCount;
    property RetryTimeout: Cardinal read FRetryTimeout write FRetryTimeout;
    property Timeout: Cardinal read FTimeout write FTimeout;
    property Path: String read FPath write SetPath;
  end;


  TfrxReportClient = class (TfrxReport)

  private
    FClient: TfrxHTTPClient;
    FConnection: TfrxServerConnection;
    FReportName: String;
    FSessionId: String;
    FSecondPass: Boolean;
    procedure FillPreviewPages;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function PrepareReport: Boolean;
    procedure LoadFromFile(FileName: String);
    procedure ShowReport;
    function GetServerVariable(const VariableName: String): String;
    procedure Close;

    property Client: TfrxHTTPClient read FClient write FClient;
  published
    property Connection: TfrxServerConnection read FConnection write FConnection;
    property ReportName: String read FReportName write FReportName;
  end;

implementation

uses frxUtils
{$IFDEF Delphi6}
, Variants
{$ENDIF};

type
  THackThread = class(TThread);

{ TfrxReportClient }

constructor TfrxReportClient.Create(AOwner: TComponent);
var
  FBlankPage: TfrxReportPage;
begin
  inherited;
  FBlankPage := TfrxReportPage.Create(Self);
  FBlankPage.PrintIfEmpty := True;
  EngineOptions.DestroyForms := False;
  if not Assigned(frxCompressorClass) then
  frxCompressorClass := TfrxGZipCompressor;
  FClient := TfrxHTTPClient.Create(nil);
  FSecondPass := False;
end;

destructor TfrxReportClient.Destroy;
begin
  if FClient.Active then
    FClient.Close;
  FClient.Free;

  inherited;
end;

procedure TfrxReportClient.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
    if AComponent = FConnection then
      FConnection := nil;
end;


procedure TfrxReportClient.ShowReport;
begin
  Clear;
  if PrepareReport then
    ShowPreparedReport;
end;




function TfrxReportClient.PrepareReport: Boolean;
var
  s: String;
  i: Integer;
  FPage: TfrxDialogPage;
  FBlankPage: TfrxReportPage;
begin
  Result := False;
  if not FSecondPass then
  begin
    Errors.Clear;
    PreviewPages.Clear;
    Objects.Clear;
    FBlankPage := TfrxReportpage.Create(Self);
    FBlankPage.Name := 'Page_1';
    Engine.TotalPages := Engine.TotalPages + 1;
  end;
  if Assigned(FConnection) then
  begin
    try
      if not EngineOptions.EnableThreadSafe then
        Screen.Cursor := crHourGlass;
      FClient.Host := FConnection.Host;
      FClient.Port := FConnection.Port;
      FClient.ProxyHost := FConnection.ProxyHost;
      FClient.ProxyPort := FConnection.ProxyPort;
      FClient.RetryCount := FConnection.RetryCount;
      FClient.RetryTimeOut := FConnection.RetryTimeout;
      FClient.TimeOut := FConnection.Timeout;
      FClient.MIC := FConnection.MIC;
      s := '';
      for i := 0 to Variables.Count - 1 do
        s := s + '&' + Variables.Items[i].Name + '=' +
{$IFDEF Delphi12}
          String(Str2HTML(UTF8Encode(VarToStr(Variables.Items[i].Value))));
{$ELSE}
          Str2HTML(UTF8Encode(VarToStr(Variables.Items[i].Value)));
{$ENDIF}
      if FClient.Stream.Size > 1 then
        s := s + '&sessionid=' + FSessionId;
{$IFDEF Delphi12}
      FClient.ClientFields.FileName := 'result?report=' + String(Str2HTML(AnsiString(FReportName))) + '&format=FRP' + s;
{$ELSE}
      FClient.ClientFields.FileName := 'result?report=' + Str2HTML(FReportName) + '&format=FRP' + s;
{$ENDIF}
      if Connection.Path <> '' then
        FClient.ClientFields.FileName := Connection.Path + StringReplace(FClient.ClientFields.FileName, ' ', '%20', [rfReplaceAll]);
      if FConnection.Compression then
        FClient.ClientFields.AcceptEncoding := 'gzip'
      else
        FClient.ClientFields.AcceptEncoding := '';
      if Length(FConnection.Login) > 0 then
      begin
        FClient.ClientFields.Login := FConnection.Login;
        FClient.ClientFields.Password := FConnection.Password;
      end;
      FClient.ClientFields.QueryType := qtGet;
      try
        FClient.Open;
      except
        FClient.Close;
      end;
      if not FClient.Breaked then
      begin
        if FClient.Errors.Count = 0 then
        begin
          if (ExtractFileExt(FClient.ClientFields.FileName) = '.frm') and
             (not EngineOptions.EnableThreadSafe) and
             (Connection.Path = '') then
          begin
            FSessionId := FClient.ServerFields.SessionId;
            FPage := TfrxDialogPage.Create(Self);
            FPage.LoadFromStream(FClient.Stream);
            inherited PrepareReport;
            FClient.Stream.Clear;
            Pages[1].SaveToStream(FClient.Stream);
            Pages[1].Free;
            FSecondPass := True;
            PrepareReport;
          end
          else
            try
              FillPreviewPages;
            except
            end;
          Result := True;
        end else
          Errors.AddStrings(FClient.Errors);
      end;
    finally
      if not EngineOptions.EnableThreadSafe then
        Screen.Cursor := crDefault;
    end;
  end;
  if (Engine.TotalPages >= 0) and (not FSecondPass) then
  begin
    Pages[0].Free;
    Engine.TotalPages := Engine.TotalPages - 1;
  end
  else
    FSecondPass := False;
  FClient.Stream.Clear;
end;


procedure TfrxReportClient.FillPreviewPages;
begin
  FClient.Stream.Position := 0;
  PreviewPages.LoadFromStream(FClient.Stream);
end;


procedure TfrxReportClient.LoadFromFile(FileName: String);
begin
  FReportName := FileName;
end;



function TfrxReportClient.GetServerVariable(const VariableName: String): String;
var
  Lines: TStringList;
begin

  FClient.Errors.Clear;
  Errors.Clear;
  if Assigned(FConnection) then
  begin
    Lines := TStringList.Create;
    try
      if not EngineOptions.EnableThreadSafe then
        Screen.Cursor := crHourGlass;
      FClient.Host := FConnection.Host;
      FClient.Port := FConnection.Port;
      FClient.ProxyHost := FConnection.ProxyHost;
      FClient.ProxyPort := FConnection.ProxyPort;
      FClient.RetryCount := FConnection.RetryCount;
      FClient.RetryTimeOut := FConnection.RetryTimeout;
      FClient.TimeOut := FConnection.Timeout;
      FClient.MIC := FConnection.MIC;
      FClient.ClientFields.FileName := 'result?getvariable=' + VariableName;
      if Connection.Path <> '' then
        FClient.ClientFields.FileName := Connection.Path + FClient.ClientFields.FileName;
      if FConnection.Compression then
        FClient.ClientFields.AcceptEncoding := 'gzip'
      else
        FClient.ClientFields.AcceptEncoding := '';
      if Length(FConnection.Login) > 0 then
      begin
        FClient.ClientFields.Login := FConnection.Login;
        FClient.ClientFields.Password := FConnection.Password;
      end;
      FClient.ClientFields.QueryType := qtGet;
      try
        FClient.Open;
      except
        FClient.Close;
      end;
      if not FClient.Breaked then
      begin
        if FClient.Errors.Count = 0 then
        begin
            if FClient.Stream.Size > 0 then
              Lines.LoadFromStream(FClient.Stream{$IFDEF Delphi12},TEncoding.ASCII{$ENDIF});
            FClient.Stream.Clear;
        end else
          Errors.AddStrings(FClient.Errors);
      end;
    finally

      Result := Lines.Text;

      Lines.Free;
      if not EngineOptions.EnableThreadSafe then
        Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrxReportClient.Close;
begin
  if FClient.Active then
    FClient.Close;
end;



{ TfrxServerConnection }

constructor TfrxServerConnection.Create(AOwner: TComponent);
begin
  inherited;
  FHost := '127.0.0.1';
  FPort := 80;
  FLogin := '';
  FPassword := '';
  FTimeout := 120;
  FRetryCount := 3;
  FProxyHost := '';
  FProxyPort := 8080;
  FRetryTimeout := 5;
  FMIC := True;
  FCompression := True;
end;



procedure TfrxServerConnection.SetPath(const Value: String);
begin
  if (Value = '') or (Value[Length(Value)] = '/') then
    FPath := Value
  else
    FPath := Value + '/';
end;

initialization
  RegisterClasses([TfrxServerConnection, TfrxReportClient]);


end.
