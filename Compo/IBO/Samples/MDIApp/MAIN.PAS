unit Main;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls, Registry,

  IB_Session,
  IB_Constants,
  IB_Components,
  IB_UpdateBar,
  IB_SearchBar,
  IB_NavigationBar,
  IB_DataSetBar,
  IB_TransactionBar,
  IB_ConnectionBar;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileExitItem: TMenuItem;
    SpeedPanel: TPanel;
    ExitBtn: TSpeedButton;
    StatusBar: TStatusBar;
    Panel1: TPanel;
    IB_ConnectionBar1: TIB_ConnectionBar;
    IB_DataSetBar1: TIB_DataSetBar;
    IB_NavigationBar1: TIB_NavigationBar;
    IB_TransactionBar1: TIB_TransactionBar;
    IB_SearchBar1: TIB_SearchBar;
    IB_UpdateBar1: TIB_UpdateBar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    IB_Database: TIB_Database;
    SpeedButton1: TSpeedButton;
    odGDB: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure IB_DatabaseLoginFailure(Sender: TIB_Connection);
    procedure IB_SearchBar1RowCount(Sender: TObject; RowCount: Longint);
    procedure SpeedButton1Click(Sender: TObject);
    procedure IB_DatabaseConnect(Sender: TIB_Connection);
  private
    { Private declarations }
    procedure ShowHint(Sender: TObject);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  IBF_Monitor;

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  SetBounds( 0, 0, 600, 480 );
  Application.OnHint := ShowHint;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusBar.SimpleText := Application.Hint;
end;

procedure TMainForm.FileExitItemClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.IB_DatabaseLoginFailure(Sender: TIB_Connection);
begin
  Application.Terminate;
end;

procedure TMainForm.IB_SearchBar1RowCount(Sender: TObject;
  RowCount: Longint);
begin
  StatusBar.SimpleText := IntToStr( RowCount ) + ' Rows Counted';
end;

//  f:\Program Files\Borland\Delphi 2.0\Delphi 3\Demos\DATA\Mastsql.gdb

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  with TfrmMonitor.Create( Self ) do begin
    BaseKey := 'Software\MDIApp\Monitor';
    Show;
  end;
end;

procedure TMainForm.IB_DatabaseConnect(Sender: TIB_Connection);
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

