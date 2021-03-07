unit Demo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_ActionTransaction, IB_ActionUpdate, ActnList, StdCtrls, IB_Components,
  IB_Constants, IB_Session, ExtCtrls, IB_DatasetBar, Grids, IB_Grid;

type
  TForm1 = class(TForm)
    cn: TIB_Connection;
    tr: TIB_Transaction;
    qr: TIB_Query;
    ds: TIB_DataSource;
    ActionList: TActionList;
    IB_ActionCancel1: TIB_ActionCancel;
    IB_ActionCommitRetaining1: TIB_ActionCommitRetaining;
    IB_ActionDelete1: TIB_ActionDelete;
    IB_ActionNew1: TIB_ActionNew;
    IB_ActionPost1: TIB_ActionPost;
    IB_ActionRollbackRetaining1: TIB_ActionRollbackRetaining;
    IB_Grid1: TIB_Grid;
    odGDB: TOpenDialog;
    Panel1: TPanel;
    IB_DatasetBar1: TIB_DatasetBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure cnBeforeConnect(Sender: TIB_Connection);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

uses
  Registry;

{$R *.DFM}

procedure TForm1.cnBeforeConnect(Sender: TIB_Connection);
var
  MyReg: TRegINIFile;
begin
  MyReg := TRegIniFile.Create( IB_BASEKEY + '\Samples\Connections' );
  with Sender, odGDB do
  try
    if ConnectionStatus = csConnectPending then
    begin
      Database := MyReg.ReadString( 'Connections', 'Employee', Database );
// Allow a quick change of path if the file about to be opened is not found.
// Do not try and supply a GDB file over a mapped drive! If you do be sure to
// change it's path so that the server process can resolve the file's location.
      if ( Protocol = cpLocal ) and not FileExists( Database ) then
      begin
        FileName := Database;
        if Execute then
          Database := FileName
        else
          SysUtils.Abort;
      end;
    end
    else
    if ConnectionStatus = csConnected then
      MyReg.WriteString( 'Connections', 'Employee', Database );
  finally
    MyReg.Free;
  end;
end;

end.
  
