unit UdmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, IB_Process, IB_Script;

type
  TdmMain = class(TDataModule)
    scrMakeDB: TIB_Script;
    cn: TIB_Connection;
    procedure dmMainCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

implementation

{$R *.DFM}

procedure TdmMain.dmMainCreate(Sender: TObject);
var
  theDB:  String;
begin
  // Check if database file exists, if not create it,
  // if so, connect to it and open it
  cn.Connected := false;
  theDB := extractFilePath(Application.Exename)+'test.gdb';
  if fileexists(theDB) then begin
    cn.Database := theDb;
    cn.Username := 'SYSDBA';
    cn.Password := 'masterkey'; // you may need to change this
    cn.LoginPrompt := False;
  end
  else begin
    scrMakeDb.Execute;
  end;

end;

end.
