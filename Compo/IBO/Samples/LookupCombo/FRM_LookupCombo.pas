unit
  FRM_LookupCombo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, Mask, Grids, Registry,

  IB_Session,
  IB_Constants,
  IB_Components,
  IB_NavigationBar,
  IB_UpdateBar,
  IB_Controls,
  IB_Grid,
  IB_SearchBar,
  IB_UtilityBar,
  IB_Dialogs;

type
  TfrmLkCmb = class(TForm)
    cnDemo: TIB_Connection;
    IB_Edit1: TIB_Edit;
    dsMaster: TIB_DataSource;
    trDemo: TIB_Transaction;
    IB_Edit2: TIB_Edit;
    qrDept: TIB_Query;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_UpdateBar1: TIB_UpdateBar;
    dsLookup: TIB_DataSource;
    IB_Edit3: TIB_Edit;
    IB_Edit4: TIB_Edit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    IB_Edit5: TIB_Edit;
    Label6: TLabel;
    Label7: TLabel;
    IB_Edit6: TIB_Edit;
    Label8: TLabel;
    IB_Edit7: TIB_Edit;
    qrEmp: TIB_Query;
    IB_LookupCombo: TIB_LookupCombo;
    odGDB: TOpenDialog;
    IB_SearchBar1: TIB_SearchBar;
    cbAllowTimeout: TCheckBox;
    cbSearchKeyByKey: TCheckBox;
    cbSeekNearest: TCheckBox;
    cbAutoDropDown: TCheckBox;
    Memo1: TMemo;
    btRead: TButton;
    btWrite: TButton;
    md: TIB_MonitorDialog;
    SpeedButton1: TSpeedButton;
    IB_LookupList: TIB_LookupList;
    procedure FormCreate(Sender: TObject);
    procedure cnDemoConnect(Sender: TIB_Connection);
    procedure IB_LookupComboNotInList(Sender: TObject);
    procedure cbAllowTimeoutClick(Sender: TObject);
    procedure btReadClick(Sender: TObject);
    procedure btWriteClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  frmLkCmb: TfrmLkCmb;

implementation

{$R *.DFM}

procedure TfrmLkCmb.FormCreate(Sender: TObject);
begin
  qrEmp.Search;
//qrEmp.Open;
  qrDept.Open;
  cbAllowTimeout.Checked := IB_LookupCombo.AllowTimeout;
  cbSearchKeyByKey.Checked := IB_LookupCombo.SearchKeyByKey;
  cbSeekNearest.Checked := IB_LookupCombo.SeekNearest;
  cbAutoDropDown.Checked := IB_LookupCombo.AutoDropDown;
//IB_LookupCombo.PopupList.OrderingColor := clAqua;
end;

procedure TfrmLkCmb.cnDemoConnect(
  Sender: TIB_Connection);
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

procedure TfrmLkCmb.IB_LookupComboNotInList(Sender: TObject);
begin
  MessageBeep( 0 );
  ShowMessage( IB_LookupCombo.SearchText + ' was not found.' );
end;

procedure TfrmLkCmb.cbAllowTimeoutClick(Sender: TObject);
begin
  if Sender = cbAllowTimeout then
    IB_LookupCombo.AllowTimeout := cbAllowTimeout.Checked;
  if Sender = cbSearchKeyByKey then
    IB_LookupCombo.SearchKeyByKey := cbSearchKeyByKey.Checked;
  if Sender = cbSeekNearest then
    IB_LookupCombo.SeekNearest := cbSeekNearest.Checked;
  if Sender = cbAutoDropDown then
    IB_LookupCombo.AutoDropDown := cbAutoDropDown.Checked;
end;

procedure TfrmLkCmb.btReadClick(Sender: TObject);
begin
  qrEmp.ReadSearch( Memo1.Lines );
end;

procedure TfrmLkCmb.btWriteClick(Sender: TObject);
begin
  qrEmp.WriteSearch( Memo1.Lines );
end;

procedure TfrmLkCmb.FormDblClick(Sender: TObject);
begin
  md.Show;
end;

procedure TfrmLkCmb.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := trDemo.CloseWithConfirm = mrOk;
end;

end.


