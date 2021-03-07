unit ufrmSigorta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, IB_Components, Buttons, StdCtrls, Mask, IB_Controls,Variants;

type
  TfrmSigorta = class(TForm)
    Panel1: TPanel;
    qry_Sigorta: TIB_Query;
    dts_Sigorta: TIB_DataSource;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Edit3: TIB_Edit;
    IB_Edit9: TIB_Edit;
    btnCikis: TBitBtn;
    btnAra: TBitBtn;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qry_SigortaAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure qry_SigortaBeforeDelete(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure dts_SigortaStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
    procedure qry_SigortaBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean;SIGORTA_KOD:String;ISLEM_TIP:Byte);
    procedure DataSet_Open(SIGORTA_KOD:String;ISLEM_TIP:Byte);
    function SigortaNo(SIGORTA_SAYAC:INTEGER):String;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
  end;

  const cns_Sigorta = 61;

var
  frmSigorta: TfrmSigorta;

implementation

uses unDataMod,Main,unFunc, unLogger;

{$R *.DFM}

procedure TfrmSigorta.Form_Open(Menu:Boolean;SIGORTA_KOD:String;ISLEM_TIP:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Sigorta,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM_TIP = 1) and (not local_can_update)) then
    begin
      Application.MessageBox('Bu mod�lde yeni Sigorta �irketi tan�mlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
  if not MainForm.FindChildFrm(Application, 'frmSigorta') then
  begin
    Application.CreateForm(TfrmSigorta, frmSigorta);
    with frmSigorta do
    begin
      prv_CanUpdate := local_can_update;
      prv_CanDelete := local_can_delete;
      DataSet_Open(SIGORTA_KOD,ISLEM_TIP);
    end;
  end
  else
  begin
    Application.MessageBox('Sigorta �irketi formu a��k.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
end;

procedure TfrmSigorta.DataSet_Open(SIGORTA_KOD:String;ISLEM_TIP:Byte);
begin
  with qry_Sigorta do
  begin
    Active := False;
    ParamByName('PRM_SIGORTA_KOD').AsString := SIGORTA_KOD;
    Active := True;
  end;
  case ISLEM_TIP of
  0://edit
    begin
      qry_Sigorta.Edit;
    end;
  1://insert
    begin
      qry_Sigorta.Insert;
    end;
  end;
end;

procedure TfrmSigorta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmSigorta.qry_SigortaAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_Sigorta do
  begin
    FieldByName('SIGORTA_SID').AsInteger := glb_SID;
    FieldByName('SIGORTA_KOD').AsString := SigortaNo(Int64(DataMod.GET_SAYAC_NUM('SIGORTA',True,False,0)));
  end;
  IB_Edit1.SetFocus;
end;

procedure TfrmSigorta.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

procedure TfrmSigorta.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmSigorta.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmSigorta.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmSigorta.qry_SigortaBeforeDelete(IB_Dataset: TIB_Dataset);
var
 StrMesaj:String;
begin
  if DataMod.Delete_Control('SRV_ARAC_SIGORTA',qry_Sigorta.FieldByName('SIGORTA_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kayd� silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
end;

procedure TfrmSigorta.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Sigorta.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('De�i�iklikleri Kaydetmeli yada �ptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end
  else
  begin
    qry_Sigorta.Active := False;
    qry_Sigorta.Active := False;
  end;
end;

procedure TfrmSigorta.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmSigorta);
end;

function TfrmSigorta.SigortaNo(SIGORTA_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(SIGORTA_SAYAC,TRIM(DataMod.GetParam(cns_Sigorta,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Sigorta,'KOD_LENGTH',0)));
end;

procedure TfrmSigorta.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSigorta.btnAraClick(Sender: TObject);
var
  SIGORTA_KOD,SIGOTA_AD:String;
begin
  if DataMod.LS_Sigorta(SIGORTA_KOD,SIGOTA_AD) then
  begin
    DataSet_Open(SIGORTA_KOD,0);
  end;
end;

procedure TfrmSigorta.dts_SigortaStateChanged(Sender: TIB_DataSource;ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    btnSil.Enabled := False;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnKaydet.Enabled := True;
    btnIPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    if not ((ADataset.Eof) and (ADataset.Bof)) then btnSil.Enabled := True
    else btnSil.Enabled := False;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
end;

procedure TfrmSigorta.qry_SigortaBeforePost(IB_Dataset: TIB_Dataset);
var
  funcDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_Sigorta,'SRV_ARAC_SIGORTA','SIGORTA_KOD,ADI','SIGORTA_KOD');
  if funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;
  if not DataMod.Post_Update('SRV_ARAC_SIGORTA',qry_Sigorta.FieldByName('SIGORTA_KOD').OldAsString,qry_Sigorta.FieldByName('SIGORTA_KOD').AsString,Nil) then Abort;
end;

procedure TfrmSigorta.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu mod�lde yeni Sigorta �irketi tan�mlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataSet_Open('',1);
end;

procedure TfrmSigorta.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Sigorta.Post;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC_SIGORTA,',0,0,0,0,1,'SRV_ARAC_SIGORTA');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmSigorta.btnIPTALClick(Sender: TObject);
begin
  qry_Sigorta.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
end;

procedure TfrmSigorta.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Sigorta.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('SRV_ARAC_SIGORTA,',0,0,0,0,2,'SRV_ARAC_SIGORTA');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmSigorta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [ssCtrl] then
  begin
    case Key of
    83: //s kaydet
      begin
        if btnKAYDET.Enabled Then btnKAYDETClick(Self);
      end; //83 end
    80: //p iptal
      begin
        if btnIptal.Enabled Then btnIptalClick(Self);
      end;
    46: // del delete
      begin
        if btnSIL.Enabled Then btnSILClick(self);
      end;
    end; // case end;
  end//Shift = [ssCtrl] then end
  else
  if Shift = [] then
  begin
    case Key of
    45: //ins kaydet
      begin
        if btnYeni.Enabled then btnYeniClick(Self);
      end;
    VK_ESCAPE: if btnCikis.Enabled then Close;
    end;//acase end
  end; ///if Shift = [] then ENd
end;

function TfrmSigorta.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu mod�lde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

function TfrmSigorta.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu mod�lde de�i�iklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  Result := True;
end;

end.
