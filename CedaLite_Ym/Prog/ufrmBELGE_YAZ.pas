unit ufrmBELGE_YAZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Printers, StdCtrls, Grids, IB_Grid, Buttons, ExtCtrls,
  IB_Components, Mask, IB_Controls;

type
  TfrmBELGE_YAZ = class(TForm)
    qryBELGE_YAZ: TIB_Query;
    dtsBELGE_YAZ: TIB_DataSource;
    Panel1: TPanel;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    grdBELGE_YAZ: TIB_Grid;
    IB_Text1: TIB_Text;
    IB_Edit2: TIB_Edit;
    dlgBELGE: TOpenDialog;
    IB_Text2: TIB_Text;
    GroupBox1: TGroupBox;
    cboPRINTERS: TComboBox;
    Label1: TLabel;
    btnRegKaydet: TButton;
    txtPRINTER: TEdit;
    Label2: TLabel;
    chkPRNVARSAY: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    cboSUBE: TIB_LookupCombo;
    qrySUBE: TIB_Query;
    dtsSUBE: TIB_DataSource;
    function Form_Open(Menu:Boolean):Integer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IB_Edit2ButtonClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure dtsBELGE_YAZStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRegKaydetClick(Sender: TObject);
    procedure qryBELGE_YAZAfterScroll(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure qryBELGE_YAZBeforePost(IB_Dataset: TIB_Dataset);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBELGE_YAZ: TfrmBELGE_YAZ;

implementation

uses main,unDATAMOD,unYazici;

{$R *.dfm}

function TfrmBELGE_YAZ.Form_Open(Menu:Boolean):Integer;
var
  i:Byte;
begin
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if MainForm.FindChildFrm(Application, 'frmBELGE_YAZ') = False  then
  begin
    Application.CreateForm(TfrmBELGE_YAZ, frmBELGE_YAZ);
  end
  else
  begin
    Application.MessageBox('Belge - Yazýcý iþlemleri modülü açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if glb_SUBELI then
  begin
    with frmBELGE_YAZ.qrySUBE do
    begin
      Close;
      ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
      Open;
    end;
    frmBELGE_YAZ.cboSUBE.Visible := True;
  end
  else
  begin
    frmBELGE_YAZ.cboSUBE.Visible := False;
  end;


  with frmBELGE_YAZ do
  begin
    cboPRINTERS.Items.Assign(Printer.Printers);
    cboPRINTERS.ItemIndex := 0;
    dlgBELGE.InitialDir := glb_FILES_DIR;
    qryBELGE_YAZ.Active := True;
  end;

end;

procedure TfrmBELGE_YAZ.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  qryBELGE_YAZ.Active := False;
  Action := CaFree;
end;

procedure TfrmBELGE_YAZ.IB_Edit2ButtonClick(Sender: TObject);
begin
  if dlgBELGE.Execute then qryBELGE_YAZ.FieldByName('DOSYA_PATH').AsString := dlgBELGE.FileName;
end;

procedure TfrmBELGE_YAZ.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBELGE_YAZ.dtsBELGE_YAZStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) Then
  begin
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmBELGE_YAZ.btnKaydetClick(Sender: TObject);
begin
  qryBELGE_YAZ.Post;
end;

procedure TfrmBELGE_YAZ.btnIPTALClick(Sender: TObject);
begin
  qryBELGE_YAZ.Cancel;
end;

procedure TfrmBELGE_YAZ.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := btnCikis.Enabled;
end;

procedure TfrmBELGE_YAZ.btnRegKaydetClick(Sender: TObject);
begin
  Yazici.WriteBelgePrinter(qryBELGE_YAZ.FieldByName('BELGE_TUR').AsInteger,qryBELGE_YAZ.FieldByName('SIRA_NO').AsInteger,cboPRINTERS.Text);
  txtPRINTER.Text := cboPRINTERS.Text;
  if chkPRNVARSAY.Checked then Yazici.SetDefaultPrinter(cboPRINTERS.Text);
end;

procedure TfrmBELGE_YAZ.qryBELGE_YAZAfterScroll(IB_Dataset: TIB_Dataset);
begin
  txtPRINTER.Text := Yazici.GetBelgePrinter(qryBELGE_YAZ.FieldByName('BELGE_TUR').AsInteger,qryBELGE_YAZ.FieldByName('SIRA_NO').AsInteger);
end;

procedure TfrmBELGE_YAZ.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

procedure TfrmBELGE_YAZ.qryBELGE_YAZBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not glb_SUBELI then
  begin
    IB_Dataset.FieldByName('SUBE_ID').AsInteger := glb_SID;
  end;
end;

end.
