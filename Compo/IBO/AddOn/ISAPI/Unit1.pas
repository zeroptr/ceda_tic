unit Unit1;
{ The TIB_Session component should be the First in the creation order }

{ This project uses the employee.gdb database that comes as part of the standard
  install for Interbase. Be sure to set the path to your configuration }

{ if the database resides on a remote machine be sure to give the IB_Connection
  component's Database property the correct format.
  The format should be:
  servername:C:/path/database.gdb
  This project's data comes from a remote machine. For local access please use
  localhost for the servername. }

{ This project assumes the username and password on your server are default:
  SYSDBA and masterkey. Be sure to change this to match your server. }  

interface

uses
  Windows, Messages, SysUtils, Classes, HTTPApp, IB_Components, IB_Session;

type
  TWebModule1 = class(TWebModule)
    se: TIB_Session;
    cn: TIB_Connection;
    tr: TIB_Transaction;
    cr: TIB_Cursor;
    procedure WebModule1waDefaultAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    function GetCustomerData: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WebModule1: TWebModule1;

implementation

{$R *.DFM}

function TWebModule1.GetCustomerData : string;
const
  bgColor1 = '#ccccff';
  bgColor2 = '#ffffcc';
var
  i       : Integer;
  bgColor : string;
  Row     : Integer;
begin
  if IB_Transaction1.InTransaction then
    IB_Transaction1.Commit;
  IB_Transaction1.StartTransaction;
  try
    Result :=
      '<html>'#13#10 +
      '  <head>'#13#10 +
      '    <link rel="stylesheet" type="text/css" href="http://www.matlus.com/home-styles.css" />'#13#10 +
      '  </head>'#13#10 +
      '  <title>IB Objects ISAPI Demo</title>'#13#10 +
      '<table border="1" cellpadding="2" cellspacing="2">'#13#10 +
      '  <tr bgcolor="silver">'#13#10;
    with IB_Cursor1 do
    begin
      Prepare;
      Open;
      for i := 0 to FieldCount -1 do
        Result := Result +
          '    <td><b>' + Fields[i].FieldName + '</b></td>'#13#10;
      Result := Result +
        '  </tr>'#3#10;
      Row := 0;
      while not Eof do
      begin
        if (Row mod 2 = 0) then
          bgColor := bgColor1
        else
          bgColor := bgColor2;
        inc(Row);
        Result := Result +
          '  <tr bgcolor="' + bgColor + '">'#13#10;
        for i := 0 to FieldCount -1 do
          Result := Result +
            '    <td>' + Fields[i].AsString + '</td>'#13#10;
        Result := Result +
          '  </tr>'#13#10;
        Next;
      end; { while not Eof }
      Unprepare;
      Close;
    end; { with IB_Cursor1 do }
    Result := Result +
      '</table>'#13#10 +
      '</html>'#13#10;
  except
    on E: Exception do
    begin
      Result := '<h1>Error</h1><br/><h2>' + E.Message + '</h2></html>';
      IB_Transaction1.Rollback;
    end;
  end;

  if IB_Transaction1.InTransaction then
    IB_Transaction1.Commit;
end;

procedure TWebModule1.WebModule1waDefaultAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content := GetCustomerData;
end;

end.
