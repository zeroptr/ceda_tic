{************************************************}
{   Tee Office -      Automatic Version Update   }
{   Copyright (c) 2001-2008 by David Berneda     }
{   All Rights Reserved.                         }
{************************************************}
unit TeeUpdateVersion;
{$I TeeDefs.inc}

interface

uses
  {$IFNDEF LINUX}
  Windows, Messages,
  {$ENDIF}
  {$IFDEF CLX}
  QGraphics, QControls, QForms, QDialogs, QExtCtrls, QStdCtrls,
  {$ELSE}
  Graphics, Controls, Forms, Dialogs, ExtCtrls, StdCtrls,
  {$ENDIF}
  SysUtils, Classes;

type
  TUpdateVersion = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    LabelVersion: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    LabelLatest: TLabel;
    ButtonOk: TButton;
    Button2: TButton;
    LabelMessage: TLabel;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FZIPURL     : String;
    FVersionURL : String;
    FTemp       : String;
    FMagic      : String;
    Procedure GetLatestVersion;
    Function GetVersionFromSteema:Boolean;
    Function HasLatestVersion:Boolean;
  public
    { Public declarations }
  end;

{ Show the Update Version dialog to retrieve a new release }
Procedure UpdateVersion(Const Version, VersionURL, Magic:String);

{ Download file from URL and return a memory stream }
Function TeeDownloadFile(Const URL,ErrorMessage:String):TMemoryStream;

implementation

{$IFNDEF CLX}
{$R *.DFM}
{$ELSE}
{$R *.xfm}
{$ENDIF}

Uses TeEngine,
     {$IFNDEF LINUX}
     ShellApi,
     {$ENDIF}
     {$IFDEF CLR}
     System.Text,
     {$ENDIF}
     TeeOfficeConstants, TeeURL, TeeConst, TeeProcs;

Procedure UpdateVersion(Const Version,VersionURL,Magic:String);
begin { show the Update Version dialog }
  With TUpdateVersion.Create(nil) do
  try
    FVersionURL:=VersionURL;
    FMagic:=Magic;
    LabelVersion.Caption:=Version;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TUpdateVersion.FormCreate(Sender: TObject);
begin
  LabelLatest.Caption:='';
  LabelMessage.Caption:='';
end;

procedure ExecuteFile(Const FileName:String);
var
  tmpFileName,
  tmpParams,
  tmpDir      : Array[0..79] of Char;
begin  { execute a file (exe file or any other type) }
  ShellExecute({$IFDEF CLX}0{$ELSE}Application.MainForm.Handle{$ENDIF},
               nil,
               {$IFDEF CLR}
               FileName,'','',
               {$ELSE}
               StrPCopy(tmpFileName, FileName),
               StrPCopy(tmpParams, ''),
               StrPCopy(tmpDir,''),
               {$ENDIF}
               SW_SHOWNORMAL);
end;

procedure TUpdateVersion.ButtonOkClick(Sender: TObject);
begin { check if we have the latest version of TeeChartOffice }
  if LabelMessage.Caption=TeeMsg_VersionReceived then
  begin
    ExecuteFile(FTemp);
    Application.Terminate;
  end
  else
  if ButtonOk.Caption=TeeMsg_OK then { we should close }
     Close
  else
  begin
    if ButtonOk.Caption=TeeMsg_UpdateButton then
    begin { lets get the latest version ... }
      ButtonOk.Caption:=TeeMsg_OK;
      LabelMessage.Caption:='';
      GetLatestVersion;
    end
    else
    begin { check the latest version ... }
      ButtonOk.Caption:=TeeMsg_OK;
      if GetVersionFromSteema then
      begin
        if HasLatestVersion then { already has latest }
           LabelMessage.Caption:=TeeMsg_HasLatestVersion
        else
        begin { change button to download latest }
          LabelMessage.Font.Color:=clGreen;
          LabelMessage.Caption:=TeeMsg_ClickToUpdateVersion;
          ButtonOk.Caption:=TeeMsg_UpdateButton;
        end;
      end;
    end;
  end;
end;

Function TeeDownloadFile(Const URL,ErrorMessage:String):TMemoryStream;
var tmp : Integer;
begin { retrieve a file from web URL into the resulting Stream }
  result:=TMemoryStream.Create;

  Screen.Cursor:=crHourGlass;
  try
    tmp:=DownloadURL({$IFNDEF CLR}{$IFDEF D12}PAnsiChar{$ELSE}PChar{$ENDIF}{$ENDIF}(URL),result);
  finally
    Screen.Cursor:=crDefault;
  end;

  if tmp<>0 then { show error message exception }
     Raise ChartException.CreateFmt(ErrorMessage,
           [tmp,URL+' '+TeeURLErrorMessage(tmp)]);
end;

Function TUpdateVersion.GetVersionFromSteema:Boolean;
var tmpS   : TStringList;
    Stream : TMemoryStream;
begin { retrieves the latest version number from Steema.com }
  result:=False;
  Stream:=TeeDownloadFile(FVersionURL,TeeMsg_CannotGetVersion);
  try
    tmpS:=TStringList.Create;
    try
      tmpS.LoadFromStream(Stream);
      if (tmpS.Count>4) and
         (UpperCase(tmpS[0])=FMagic) and
         (UpperCase(tmpS[1])='VERSION') then
      begin
        { show the latest version number and date }
        LabelLatest.Caption:=tmpS[2];
        LabelLatest.Caption:=LabelLatest.Caption+' '+tmpS[3];
        FZIPURL:=tmpS[4];

        result:=True;
      end
      else
         Raise ChartException.Create(TeeMsg_WrongVersion);
    finally
      tmpS.Free;
    end;
  finally
    Stream.Free;
  end;
end;

type
  TPathName=array[0..MAX_PATH] of Char;

procedure TUpdateVersion.GetLatestVersion;
var Stream : TMemoryStream;
    tmp    : Integer;
    tmpPath: {$IFDEF CLR}StringBuilder{$ELSE}TPathName{$ENDIF};
begin { retrieve the latest executable version of TeeChartOffice }
  Stream:=TeeDownloadFile(FZIPURL,TeeMsg_CannotGetNewVersion);
  try
    if Stream.Size>100000 then
    begin
      { create a temporary filename }
      FTemp:=FZIPURL;
      tmp:=LastDelimiter('/',FTemp);
      if tmp>0 then Delete(FTemp,1,tmp);

      {$IFDEF CLR}
      tmpPath:=StringBuilder.Create;
      {$ENDIF}

      GetTempPath(MAX_PATH,tmpPath);
      FTemp:={$IFDEF CLR}tmpPath.ToString{$ELSE}String(tmpPath){$ENDIF}+'\'+FTemp;

      { save file to disk }
      Stream.SaveToFile(FTemp);

      { notify user }
      LabelMessage.Font.Color:=clRed;
      LabelMessage.Caption:=TeeMsg_VersionReceived;
    end
    else
       Raise ChartException.Create(TeeMsg_WrongZip);
  finally
    Stream.Free;
  end;
end;

function TUpdateVersion.HasLatestVersion: Boolean;

  Function TeeStrToFloat(Const S:String):Double;
  var Old: {$IFDEF CLR}String{$ELSE}Char{$ENDIF};
  begin { convert a string with "." as decimal separator, to double }
    Old:=DecimalSeparator;
    DecimalSeparator:='.';
    try
      result:=StrToFloat(S);
    finally
      DecimalSeparator:=Old;
    end;
  end;

var tmpVersion : Double;
    tmpLatest  : Double;
    tmpS       : String;
begin { returns True if this version is the latest available }

  { current version }
  tmpS:=LabelVersion.Caption;
  While Pos(' ',tmpS)>0 do Delete(tmpS,1,Pos(' ',tmpS));
  tmpVersion:=TeeStrToFloat(tmpS);

  { latest version at Steema.com }
  tmpS:=LabelLatest.Caption;
  if Pos(' ',tmpS)>0 then Delete(tmpS,Pos(' ',tmpS),Length(tmpS));
  tmpLatest:=TeeStrToFloat(tmpS);

  { compare versions }
  result:=tmpVersion>=tmpLatest;
end;

procedure TUpdateVersion.FormShow(Sender: TObject);
begin
  { Translate }
  TeeTranslateControl(Self);
end;

end.
