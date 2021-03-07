unit ufrmPaket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IB_Components, ComCtrls, Mask,
  IB_Controls, Grids, IB_Grid;

type
  TfrmPaket = class(TForm)
    qry_Paket: TIB_Query;
    dts_Paket: TIB_DataSource;
    qry_Paket_Detay: TIB_Query;
    dts_Paket_Detay: TIB_DataSource;
    pg: TPageControl;
    tabRecete: TTabSheet;
    txtReceteKodu: TIB_Edit;
    IB_Edit1: TIB_Edit;
    IB_Edit3: TIB_Edit;
    Panel5: TPanel;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnYeni: TBitBtn;
    btnTRN_KAYDET: TButton;
    btnTRN_IPTAL: TButton;
    btnReceteSil: TBitBtn;
    tabMamul: TTabSheet;
    Panel1: TPanel;
    txtMamulKod: TIB_Edit;
    IB_Currency7: TIB_Currency;
    IB_Edit8: TIB_Edit;
    btnMamulEKLE: TButton;
    btnMamulKaydet: TButton;
    btnMamulIptal: TButton;
    btnMamulSil: TButton;
    txtOlcuBirim: TIB_Edit;
    Panel2: TPanel;
    IB_Grid1: TIB_Grid;
    IB_Edit2: TIB_Edit;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    procedure Form_Open(Menu: Boolean; PAKET_KOD: String; PAKET_SID: Integer; ISLEM: Byte);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCikisClick(Sender: TObject);
    procedure qry_PaketAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dts_PaketStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure dts_Paket_DetayStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure pgChange(Sender: TObject);
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure btnMamulEKLEClick(Sender: TObject);
    procedure btnMamulKaydetClick(Sender: TObject);
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure qry_Paket_DetayAfterInsert(IB_Dataset: TIB_Dataset);
    procedure txtMamulKodButtonClick(Sender: TObject);
    procedure txtOlcuBirimButtonClick(Sender: TObject);
    procedure btnMamulIptalClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure txtMamulKodExit(Sender: TObject);
    procedure qry_Paket_DetayBeforePost(IB_Dataset: TIB_Dataset);
    procedure pgChanging(Sender: TObject; var AllowChange: Boolean);
    procedure btnReceteSilClick(Sender: TObject);
    procedure btnMamulSilClick(Sender: TObject);
    procedure txtMamulKodEnter(Sender: TObject);
    procedure IB_Edit2Enter(Sender: TObject);
    procedure IB_Edit2Exit(Sender: TObject);
    procedure txtMamulKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtOlcuBirimKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
    procedure txtOlcuBirimExit(Sender: TObject);
    procedure txtOlcuBirimEnter(Sender: TObject);
    procedure qry_PaketBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Grid1CellDblClick(Sender: TObject; ACol, ARow: Integer; AButton: TMouseButton; AShift: TShiftState);
    procedure txtReceteKoduKeyPress(Sender: TObject; var Key: Char);
    procedure btnAraClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);


  private
    { Private declarations }
    prv_CanUpdate,prv_CanDelete:Boolean;
    my_Active_Comp:TWinControl;
    prv_OlcuBirim_Kontrol:Boolean;
    procedure FormatDisplays;
    procedure DataSet_Open(PAKET_Kod:String;PAKET_SID:Integer;ISLEM:Byte);
    function PaketNo(Paket_SAYAC: INTEGER): String;
    function Form_Before_Delete: Boolean;
    function Form_Before_Post: Boolean;
    procedure Geri_AL;

  public
    { Public declarations }
  end;
  const cns_paket=33;
var
  frmPaket: TfrmPaket;

implementation

uses unDataMod, unLogger, ufrmUrunSDLG, main, unFunc, 
  ufrmRaporCiktisi, ufrmUrunTanA;

{$R *.dfm}

procedure TfrmPaket.Form_Open(Menu:Boolean;PAKET_KOD:String;PAKET_SID:Integer;ISLEM:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin

  if not DataMod.Modul_Hak(cns_Paket,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni Paket yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;


//****************************************************************************//
  if not MainForm.FindChildFrm( Application, 'frmPAKET') then
  begin
    Application.CreateForm (TfrmPaket,frmPaket);
    frmPaket.prv_CanUpdate := local_can_update;
    frmPaket.prv_CanDelete := local_can_delete;
  end
  else
  begin
    Application.MessageBox('Paket formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
//****************************************************************************//


  frmPaket.pg.ActivePage:=frmPaket.tabRecete;

  frmPaket.DataSet_Open(PAKET_KOD,PAKET_SID,Islem);

  FormatDisplays;

end;


procedure TfrmPaket.DataSet_Open(PAKET_KOD:String;PAKET_SID:Integer;ISLEM:Byte);
begin
  if ((ISLEM = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  qry_Paket.Active := False;
  qry_Paket.ParambyName('PAKET_KOD').AsString :=PAKET_KOD;
//  qry_Paket.ParambyName('PAKET_SID').AsInteger :=PAKET_SID;
  qry_Paket.Active := True;
  case Islem of
    0:
      begin
        qry_Paket.Insert;
      end;
    1:
      begin
        qry_Paket.Edit;
      end;
    end;
end;


Procedure TfrmPaket.FormatDisplays;
begin
{  with frmRECETEA.qry_Recete do
  begin
    FieldByName('URETIM_SURE').DisplayFormat := '#';
    FieldByName('ISCI_SAYISI').DisplayFormat := '#';
  end;
  with frmRECETEA.qry_ReceteDetay do
  begin
    FieldByName('MIKTAR').DisplayFormat := glb_DOV_KUR_PF;
  end;

  with frmRECETEA.qry_ReceteDetay do
  begin
    FieldByName('MIKTAR').DisplayFormat := glb_DOV_KUR_PF;
  end; }

end;



procedure TfrmPaket.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPaket.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPaket.qry_PaketAfterInsert(IB_Dataset: TIB_Dataset);
begin
  qry_Paket.FieldByName('PAKET_SID').AsInteger := glb_SID;
  qry_Paket.FieldByName('PAKET_KOD').AsString :=PaketNo(qry_Paket.Gen_ID('GEN_PAKET',1));
  txtReceteKodu.SetFocus;
end;


function TfrmPaket.PaketNo(Paket_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(Paket_SAYAC,TRIM(DataMod.GetParam(cns_Paket,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Paket,'KOD_LENGTH',0)));
end;

procedure TfrmPaket.dts_PaketStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled:=False;
    if ADataset.State = dssEDIT then
    begin
      btnReceteSil.Enabled := True;
    end
    else
    begin
      btnReceteSil.Enabled := False;
    end;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnTRN_KAYDET.Enabled := True;
    btnTRN_IPTAL.Enabled := True;
  end
  else
  begin
    btnYeni.Enabled:=True;
    {if ADataset.RecordCount > 0 then
    begin
      btnFaturaSil.Enabled := True
    end
    else
    begin
      btnFaturaSil.Enabled := False;
    end;  }

    if Length(Trim(ADataset.FieldByName('PAKET_KOD').AsString))<=0 then
    begin
      btnReceteSil.Enabled := False;
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;
    end
    else
    begin
      btnReceteSil.Enabled := True;
      Btn_Onceki.Enabled := True;
      Btn_Sonraki.Enabled := True;
    end;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
  end;

end;

procedure TfrmPaket.dts_Paket_DetayStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (Sender as TIB_DataSource).State in [dssEdit,dssInsert] then Begin
   btnMamulEKLE.Enabled := False;
   btnMamulKaydet.Enabled := True;
   btnMamulIptal.Enabled := True;
   btnMamulSil.Enabled:= false;
 End
 Else Begin

   btnMamulEKLE.Enabled := True;
   btnMamulKaydet.Enabled := False;
   btnMamulIptal.Enabled := False;
   //if qry_ReceteMamul.RecordCount<>0 then btnMamulSil.Enabled := True else btnMamulSil.Enabled := False;
    if ADataset.FieldByName('PAKET_D_ID').AsInteger<=0 then
      btnMamulSil.Enabled := False
    else
      btnMamulSil.Enabled := True;
 End;
end;

procedure TfrmPaket.pgChange(Sender: TObject);
begin
   if pg.ActivePage = tabMamul then begin
      qry_Paket_Detay.Active := False;
      qry_Paket_Detay.ParamByName('PAKET_KOD').AsString := qry_Paket.FieldbyName('PAKET_KOD').AsString;
      //qry_Paket_Detay.ParamByName('PAKET_SID').AsInteger := qry_Paket.FieldbyName('PAKET_SID').AsInteger;
      qry_Paket_Detay.Active := True;
   end
end;

procedure TfrmPaket.btnTRN_IPTALClick(Sender: TObject);
begin
  if Application.MessageBox('Ýptal etmek istediðinizden emin misiniz?','Dikkat',MB_YESNO+MB_ICONQUESTION)=ID_YES then
  qry_Paket.Cancel;
end;

procedure TfrmPaket.btnMamulEKLEClick(Sender: TObject);
begin
   qry_Paket_Detay.Insert;
   txtMamulKod.SetFocus;
end;

procedure TfrmPaket.btnMamulKaydetClick(Sender: TObject);
begin
   qry_Paket_Detay.Post;
end;

procedure TfrmPaket.btnTRN_KAYDETClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;

    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Paket.Post;

      dmLOGGER.dbaMain_StopMonitoringWrite2log('PAKET,',0,0,0,0,1,'PAKET');

      dmLOGGER.dbaMain_CancelMonitoring;
    end;

  except
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;

end;

procedure TfrmPaket.qry_Paket_DetayAfterInsert(IB_Dataset: TIB_Dataset);
begin
   qry_Paket_Detay.FieldByName('PAKET_KOD').AsString := qry_Paket.Fieldbyname('PAKET_KOD').AsString;
   qry_Paket_Detay.FieldByName('PAKET_D_SID').AsInteger := qry_Paket.Fieldbyname('PAKET_SID').AsInteger;
   qry_Paket_Detay.FieldByName('PAKET_D_ID').AsInteger :=  qry_Paket_Detay.Gen_ID('GEN_PAKET_D',1);
   qry_Paket_Detay.FieldByName('MIKTAR').AsCurrency:= 0;
   txtMamulKod.SetFocus;
end;

procedure TfrmPaket.txtMamulKodButtonClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad:String;
begin
  if not (qry_Paket_Detay.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_AD,True) then
  begin
    qry_Paket_Detay.FieldByName('URUN_KOD').AsString := Urun_Kod;
    qry_Paket_Detay.FieldByName('URUN_ADI').AsString := Urun_Ad;
    qry_Paket_Detay.FieldByName('OLCU_BIRIM').AsString :=
    DataMod.Planlama_Urun_Olcu_Birim(Urun_Kod);
  end;
end;

procedure TfrmPaket.txtOlcuBirimButtonClick(Sender: TObject);
var
  OlcuBir,strSQL:String;
begin
  if not (qry_Paket_Detay.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if qry_Paket_Detay.FieldByName('URUN_KOD').AsString <> '' Then
  begin
    strSQL:='SELECT OLCU_TIP FROM URUN WHERE URUN_KOD='+ SQL_Katar(qry_Paket_Detay.FieldByName('URUN_KOD').AsString);
    with DataMod.qryGENEL do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True ;
    end;

    if DataMod.LS_OlcuBrm(DataMod.qryGenel.FieldByname('OLCU_TIP').AsString  ,OlcuBir) then
    begin
      if not (qry_Paket_Detay.State in [dssEdit,dssInsert])then qry_Paket_Detay.Edit;
      qry_Paket_Detay.FieldByName('OLCU_BIRIM').AsString := OlcuBir;
    end;
  end
  else
  begin
     Application.MessageBox('Ürün Seçmeden Ölçü Birimi Seçemezsiniz','DÝKKAT',MB_ICONINFORMATION);
  end;
end;

procedure TfrmPaket.btnMamulIptalClick(Sender: TObject);
begin
  if Application.MessageBox('Ýptal etmek istediðinizden emin misiniz?','Dikkat',MB_YESNO+MB_ICONQUESTION)=ID_YES then
  qry_Paket_Detay.Cancel;
end;

procedure TfrmPaket.btnYeniClick(Sender: TObject);
begin
  DataSet_Open('',glb_SID,0);
end;

procedure TfrmPaket.txtMamulKodExit(Sender: TObject);
var
  Kissas,Urun_Ad:String;
begin
  if Length(Trim(txtMamulKod.Text))=0 then
  begin
    txtMamulKod.Color := clWindow;
    exit;
  end;


  if not DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',txtMamulKod.Text,Urun_Ad) then
  begin
    Application.MessageBox('Ürün Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
    qry_Paket_Detay.FieldByName('URUN_ADI').AsString := '';
    txtMamulKod.Clear;
    txtMamulKod.SetFocus;
  end
  else
  begin
    qry_Paket_Detay.FieldByName('URUN_ADI').AsString := Urun_Ad;
    txtMamulKod.Color := clWindow;
    qry_Paket_Detay.FieldByName('OLCU_BIRIM').AsString :=
    DataMod.Planlama_Urun_Olcu_Birim(txtMamulKod.Text);
    exit;
  end;
end;

procedure TfrmPaket.qry_Paket_DetayBeforePost(IB_Dataset: TIB_Dataset);
var
FuncDeger:String;
begin
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_Paket_Detay,'PAKET_D','URUN_KOD','');
  if funcDeger<>'' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Abort;
  end;

  if (qry_Paket_Detay.FieldByName('MIKTAR').AsVariant=Null)
  or (qry_Paket_Detay.FieldByName('MIKTAR').AsFloat=0)
   then
  begin
    Application.MessageBox('Miktar Giriniz ','Dikkat',MB_ICONWARNING);
    IB_Currency7.SetFocus;
    Abort;
  end;



  if Length(Trim(qry_Paket_Detay.FieldByName('OLCU_BIRIM').AsString))<=0  then
  begin
    Application.MessageBox('Ölçü Birimini Seçiniz.','Dikkat',MB_ICONWARNING);
    txtOlcuBirim.SetFocus;    
    Abort;
  end;

end;

procedure TfrmPaket.pgChanging(Sender: TObject; var AllowChange: Boolean);
begin

    if qry_Paket.RecordCount = 0 then
    begin
      Application.MessageBox('Kayýt üzerinde deðilken diðer bölümlere geçemezsiniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
      exit;
    end;

  if (pg.ActivePage = tabRecete) Then
  begin
    if qry_Paket.State in [dssEdit,dssInsert] Then
    begin
      Application.MessageBox('Paket bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end;
  end;

  if (pg.ActivePage = tabMamul) Then
  begin
    if qry_Paket_Detay.State in [dssEdit,dssInsert] Then
    begin
      Application.MessageBox('Paket detayý bilgilerini kaydediniz.','Dikkat',MB_ICONWARNING);
      AllowChange := False;
    end;
  end;

end;



function TfrmPaket.Form_Before_Post: Boolean;
var
  FuncDeger:String;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  FuncDeger:=DataMod.Before_Post_Kontrol(qry_Paket,'PAKET','PAKET_KOD,PAKET_ADI','PAKET_KOD');
  if funcDeger<> '' Then
  begin
    Application.MessageBox(PChar(FuncDeger),'Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Result := True;
end;

function TfrmPaket.Form_Before_Delete: Boolean;
var
  strMesaj:String;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if DataMod.Delete_Control('PAKET',qry_Paket.FieldByName('PAKET_KOD').AsString,strMesaj) then
  begin
    if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Exit;
  end
  else
  begin
    Application.MessageBox(PChar(strMesaj),'Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Result := True;
end;

procedure TfrmPaket.btnReceteSilClick(Sender: TObject);
begin
   //if Application.MessageBox('Kaydý silmek istiyor musunuz?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then ABORT;
    if not Form_Before_Delete then exit;

   try
    if not dmLOGGER.dbaMain_StartMonitoring then Exit;

      qry_Paket_Detay.Active := False;
      qry_Paket_Detay.ParamByName('PAKET_KOD').AsString := qry_Paket.FieldbyName('PAKET_KOD').AsString;
      //qry_Paket_Detay.ParamByName('PAKET_SID').AsInteger := qry_Paket.FieldbyName('PAKET_SID').AsInteger;
      qry_Paket_Detay.Active := True;

      qry_Paket_Detay.First;
      while not qry_Paket_Detay.Eof do
      begin
        qry_Paket_Detay.Delete;
        qry_Paket_Detay.First;
      end;
      
      qry_Paket.Delete;

      dmLOGGER.dbaMain_StopMonitoringWrite2log('PAKET,',0,0,0,0,2,'PAKET');
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure TfrmPaket.btnMamulSilClick(Sender: TObject);
begin
  qry_Paket_Detay.Delete;
end;

procedure TfrmPaket.txtMamulKodEnter(Sender: TObject);
begin
  txtMamulKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmPaket.IB_Edit2Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure TfrmPaket.IB_Edit2Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.color :=clWindow;
end;

procedure TfrmPaket.txtMamulKodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txtMamulKodButtonClick(Self);
end;

procedure TfrmPaket.txtOlcuBirimKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txtOlcuBirimButtonClick(Self);
end;

procedure TfrmPaket.txtOlcuBirimKeyPress(Sender: TObject; var Key: Char);
begin
  prv_OlcuBirim_Kontrol := True;
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmPaket.txtOlcuBirimExit(Sender: TObject);
var
  strSQL:string;
  OLCU_TIP:String;
begin
  txtOlcuBirim.Color := clWindow;
  if Trim(txtOlcuBirim.Text)<>'' then
  begin
    if prv_OlcuBirim_Kontrol=True then
    begin
      strSQL:='SELECT OLCU_TIP FROM URUN WHERE URUN_KOD='+SQL_Katar(qry_Paket_Detay.FieldByName('URUN_KOD').AsString);
//****************************************************************************//
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add(strSQL);
        Active := True;
      end;
//****************************************************************************//
      OLCU_TIP:=DataMod.qryGenel.FieldByname('OLCU_TIP').AsString;
//****************************************************************************//
      with DataMod.qryGENEL do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT * FROM OLCUBIR WHERE OLCU_TIP=' + SQL_Katar(OLCU_TIP)
              + ' AND OLCUBIRIM = '+ SQL_Katar(qry_Paket_Detay.FieldByName('OLCU_BIRIM').AsString));
        Active := True;
      end;
//****************************************************************************//
      if not ((DataMod.qryGENEL.Bof) And (DataMod.qryGENEL.Eof)) Then
      begin
        prv_OlcuBirim_Kontrol := False;
      end
      else
      begin
        prv_OlcuBirim_Kontrol := True;
        txtOlcuBirim.SetFocus;
      end;
//****************************************************************************//
    end;
  end
  else
  begin
    prv_OlcuBirim_Kontrol := True;
  end;
end;

procedure TfrmPaket.txtOlcuBirimEnter(Sender: TObject);
begin
  txtOlcuBirim.Color := glb_Art_Alan_Renk;
end;

procedure TfrmPaket.qry_PaketBeforePost(IB_Dataset: TIB_Dataset);
begin

  with DataMod.qryGENEL do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) As GELEN FROM PAKET WHERE '
           + ' PAKET_KOD='+ SQL_Katar(qry_Paket.FieldByName('PAKET_KOD').AsString));
    Active := True;
  end;

  if qry_Paket.State = DssInsert then
  if (DataMod.qryGENEL.FieldByName('GELEN').AsInteger>0) then
  begin
    Application.MessageBox('Bu Paket Kodundan Kayýt Yapýlmýþtýr. Farklý Bir Paket Kod Deneyiniz.','Dikkat',MB_ICONWARNING);
    txtReceteKodu.SetFocus;
    Abort;
  end;

  if qry_Paket.State = DssEdit then
  begin
    if qry_Paket.FieldByName('PAKET_KOD').OldAsString<>qry_Paket.FieldByName('PAKET_KOD').AsString then
    if (DataMod.qryGENEL.FieldByName('GELEN').AsInteger>=1) then
    begin
      Application.MessageBox('Bu Paket Kodundan Kayýt Yapýlmýþtýr. Farklý Bir Paket Kod Deneyiniz.','Dikkat',MB_ICONWARNING);
      txtReceteKodu.SetFocus;      
      Abort;
    end;
  end;

  if not DataMod.Post_Update('PAKET',qry_Paket.FieldByName('PAKET_KOD').OldAsString,qry_Paket.FieldByName('PAKET_KOD').AsString,nil) then Abort;
end;


procedure TfrmPaket.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (qry_Paket.State in [dssInsert,dssEdit]) or
  (qry_Paket_Detay.State in [dssInsert,dssEdit])  then

  begin
    Application.MessageBox('Deðiþiklikleri Kaydetmeli yada Ýptal Etmelisiniz..!','Dikkat',MB_ICONWARNING);

    if qry_Paket.State in [dssEdit,dssInsert] Then
    begin
        pg.ActivePage := tabRecete;
    end;

    if qry_Paket_Detay.State in [dssEdit,dssInsert] Then
    begin
        pg.ActivePage := tabMamul;
    end;

    CanClose := False;
  end
  else
  begin
    qry_Paket_Detay.Active := False;
    qry_Paket.Active := False;
  end;
end;

procedure TfrmPaket.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmPaket);
end;

procedure TfrmPaket.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmPaket.IB_Grid1CellDblClick(Sender: TObject; ACol, ARow: Integer; AButton: TMouseButton; AShift: TShiftState);
begin
    frmUrunTanA.Form_Open(True,qry_Paket.FieldByName('URUN_KOD').ASString,1);

end;

procedure TfrmPaket.txtReceteKoduKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmPaket.btnAraClick(Sender: TObject);
var
  PAKET_KOD,PAKET_ADI:String;
begin
  if datamod.LS_Paket(PAKET_KOD,PAKET_ADI) then
  begin
    DataSet_Open(PAKET_KOD,0,1);
  end;
end;


procedure TfrmPaket.Geri_AL;
begin
     if qry_Paket.State in [DssEdit,DssInsert] then qry_Paket.Cancel;
     qry_Paket_Detay.Close;
     qry_Paket.Close;
end;

procedure TfrmPaket.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
   Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 PAKET_KOD,PAKET_SID  FROM PAKET WHERE PAKET_KOD>:PAKET_KOD ORDER BY PAKET_KOD';
     qryDeg1.ParamByName('SOFOR_KOD').AsString:=qry_Paket.FieldByName('PAKET_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('PAKET_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('PAKET_KOD').AsString;
          Sid:=qryDeg1.FieldByName('PAKET_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmPaket.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:String;
   Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 PAKET_KOD,PAKET_SID FROM SOFOR WHERE PAKET_KOD<:PAKET_KOD ORDER BY PAKET_KOD DESC';
     qryDeg1.ParamByName('SOFOR_KOD').AsString:=qry_Paket.FieldByName('PAKET_KOD').AsString;
     qryDeg1.Open;
     if qryDeg1.FieldByName('PAKET_KOD').AsString<>'' then
     begin
          Id:=qryDeg1.FieldByName('PAKET_KOD').AsString;
          Sid:=qryDeg1.FieldByName('PAKET_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

end.


