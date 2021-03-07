unit
  ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ComCtrls, ExtCtrls, Grids,
  
  IB_Components,
  IB_Process,
  IB_Script,
  IB_ConnectionBar,
  IB_DatasetBar,
  IB_TransactionBar,
  IB_UpdateBar,
  IB_Grid,
  IB_Monitor,
  IB_UtilityBar,
  IB_Dialogs;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    pctl: TPageControl;
    TabSheet1: TTabSheet;
    meIntro: TMemo;
    TabSheet2: TTabSheet;
    meLesson1: TMemo;
    TabSheet3: TTabSheet;
    IB_DatasetBar1: TIB_DatasetBar;
    Label2: TLabel;
    IB_Grid1: TIB_Grid;
    Label4: TLabel;
    Label5: TLabel;
    IB_UpdateBar1: TIB_UpdateBar;
    IB_TransactionBar2: TIB_TransactionBar;
    meLesson2: TMemo;
    IB_DatasetBar2: TIB_DatasetBar;
    IB_Grid2: TIB_Grid;
    IB_UpdateBar2: TIB_UpdateBar;
    IB_TransactionBar4: TIB_TransactionBar;
    IB_DatasetBar3: TIB_DatasetBar;
    Label11: TLabel;
    Label12: TLabel;
    IB_Grid3: TIB_Grid;
    IB_UpdateBar3: TIB_UpdateBar;
    TabSheet4: TTabSheet;
    meLesson3: TMemo;
    IB_DatasetBar4: TIB_DatasetBar;
    IB_TransactionBar6: TIB_TransactionBar;
    IB_DatasetBar5: TIB_DatasetBar;
    Label18: TLabel;
    Label19: TLabel;
    IB_Grid4: TIB_Grid;
    IB_UpdateBar4: TIB_UpdateBar;
    IB_UpdateBar5: TIB_UpdateBar;
    IB_Grid5: TIB_Grid;
    TabSheet5: TTabSheet;
    IB_DatasetBar6: TIB_DatasetBar;
    IB_Grid6: TIB_Grid;
    ibub: TIB_UpdateBar;
    IB_TransactionBar8: TIB_TransactionBar;
    meLesson4: TMemo;
    Button1: TButton;
    TabSheet6: TTabSheet;
    meLesson5: TMemo;
    Label26: TLabel;
    Label28: TLabel;
    IB_DatasetBar7: TIB_DatasetBar;
    IB_Grid7: TIB_Grid;
    IB_UpdateBar6: TIB_UpdateBar;
    IB_TransactionBar10: TIB_TransactionBar;
    Label30: TLabel;
    IB_UpdateBar7: TIB_UpdateBar;
    IB_Grid8: TIB_Grid;
    IB_DatasetBar8: TIB_DatasetBar;
    IB_TransactionBar11: TIB_TransactionBar;
    rg1: TRadioGroup;
    rg2: TRadioGroup;
    Label1: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    md: TIB_MonitorDialog;
    MonitorSQL1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure rg2Click(Sender: TObject);
    procedure MonitorSQL1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  UdmMain, UdmLesson1, UdmLesson2, UdmLesson3, UdmLesson4, UdmLesson5;

{$R *.DFM}

procedure TfrmMain.MonitorSQL1Click(Sender: TObject);
begin
  md.Show;
end;

procedure TfrmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  pctl.ActivePage := pctl.Pages[0];
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  dmLesson4.ibsp.ExecProc;
end;

procedure TfrmMain.rg1Click(Sender: TObject);
begin
  with dmlesson5.trn1 do
    if CloseWithConfirm = mrOk then
      case rg1.itemindex of
        0: isolation := tiCommitted;
        1: isolation := tiConcurrency;
      end;
end;

procedure TfrmMain.rg2Click(Sender: TObject);
begin
  with dmlesson5.trn2 do
    if CloseWithConfirm = mrOk then
      case rg2.itemindex of
        0: isolation := tiCommitted;
        1: isolation := tiConcurrency;
      end;
end;

end.

