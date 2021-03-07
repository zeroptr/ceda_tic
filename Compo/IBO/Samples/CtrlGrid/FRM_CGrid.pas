unit
  FRM_CGrid;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls,

  IB_Session,
  IB_Constants,
  IB_Components,
  IB_CGrid,
  IB_Controls,
  IB_UpdateBar,
  IB_NavigationBar,
  IB_SearchBar,
  IB_DataSetBar;

type
  TfrmCGrid = class(TForm)
    cnCGrid: TIB_Connection;
    qrCGrid: TIB_Query;
    dsCGrid: TIB_DataSource;
    Panel1: TPanel;
    IB_DataSetBar1: TIB_DataSetBar;
    IB_SearchBar1: TIB_SearchBar;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    IB_CtrlGrid1: TIB_CtrlGrid;
    Label1: TLabel;
    Label2: TLabel;
    IB_Memo1: TIB_Memo;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    lbLastInvoice: TLabel;
    IB_Date1: TIB_Date;
    odGDB: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure cnOnConnect(Sender: TIB_Connection);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCGrid: TfrmCGrid;

implementation

{$R *.DFM}

uses
  Registry;
  
procedure TfrmCGrid.FormCreate(Sender: TObject);
begin
  qrCGrid.Search;
end;

procedure TfrmCGrid.cnOnConnect(Sender: TIB_Connection);
var
  MyReg: TRegINIFile;
begin
  MyReg := TRegIniFile.Create( IB_BASEKEY + '\Samples\Connections' );
  with Sender, odGDB do
  try
    if ConnectionStatus = csConnectPending then
    begin
      Database := MyReg.ReadString( 'Connections', 'MastSQL', Database );
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
      MyReg.WriteString( 'Connections', 'MastSQL', Database );
  finally
    MyReg.Free;
  end;
end;

end.


