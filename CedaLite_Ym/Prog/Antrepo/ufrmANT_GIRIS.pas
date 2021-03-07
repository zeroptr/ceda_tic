unit ufrmANT_GIRIS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Mask, IB_Controls, Buttons, ExtCtrls, Grids,
  IB_Grid;

type
  TfrmANT_GIRIS = class(TForm)
    qryANT_MAIN: TIB_Query;
    dtsANT_MAIN: TIB_DataSource;
    trnANTREPO: TIB_Transaction;
    Panel1: TPanel;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_ComboBox1: TIB_ComboBox;
    IB_Date2: TIB_Date;
    IB_Edit3: TIB_Edit;
    Panel5: TPanel;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnTRN_KAYDET: TButton;
    btnTRN_IPTAL: TButton;
    btnFisSil: TBitBtn;
    Panel2: TPanel;
    qryANT_DETAIL: TIB_Query;
    dtsANT_DETAIL: TIB_DataSource;
    IB_Edit4: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Date3: TIB_Date;
    IB_Edit6: TIB_Edit;
    IB_CheckBox1: TIB_CheckBox;
    IB_Currency1: TIB_Currency;
    IB_Currency2: TIB_Currency;
    IB_Currency3: TIB_Currency;
    IB_Currency4: TIB_Currency;
    cboDOVKOD: TIB_ComboBox;
    cboHDOVKOD: TIB_ComboBox;
    btnKaydet: TButton;
    btnEKLE: TButton;
    btnIptal: TButton;
    btnSil: TButton;
    cboCARI_AD: TIB_ComboBox;
    cboESYA: TIB_ComboBox;
    IB_Grid1: TIB_Grid;
    btnYeni: TButton;
    IB_CheckBox2: TIB_CheckBox;
    txtDEFSIRANO: TIB_Edit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function Form_Open(Menu: Boolean; ANT_MAIN_ID, ANT_MAIN_SID: Integer): Boolean;
    function DataSet_Open(ANT_MAIN_ID, ANT_MAIN_SID: Integer): Boolean;
    Procedure FillTheCombos;
    procedure qryANT_MAINAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dtsANT_MAINStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    Function ANT_MAIN_BeforePostControl(FromDetail:Boolean):Boolean;
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure qryANT_DETAILAfterInsert(IB_Dataset: TIB_Dataset);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit6Exit(Sender: TObject);
    procedure dtsANT_DETAILStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    procedure btnEKLEClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIptalClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Function ANT_DETAIL_BeforePostControl:Boolean;
    procedure qryANT_DETAILBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryANT_MAINBeforePost(IB_Dataset: TIB_Dataset);
    procedure btnYeniClick(Sender: TObject);
    procedure qryANT_DETAILBeforeInsert(IB_Dataset: TIB_Dataset);
    procedure IB_Edit6ButtonClick(Sender: TObject);
    procedure IB_Edit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GetFiyat;
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure btnAraClick(Sender: TObject);
    procedure btnFisSilClick(Sender: TObject);
    procedure qryANT_MAINBeforeCancel(IB_Dataset: TIB_Dataset);
    procedure IB_CheckBox2Click(Sender: TObject);
    procedure txtDEFSIRANOKeyPress(Sender: TObject; var Key: Char);
  private
     prv_CanUpdate,prv_CanDelete:Boolean;
     my_Active_Comp:TWinControl;
     prv_DEF_SIRA_NO,prv_ISN:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_ANTREPO = 51;
var
  frmANT_GIRIS: TfrmANT_GIRIS;

implementation
uses Main,unDATAMOD, ufrmCariSDLG,unFUNC, ufrmANT_SDLG, ufrmANT_REPORT;

{$R *.dfm}

function TfrmANT_GIRIS.Form_Open(Menu: Boolean; ANT_MAIN_ID, ANT_MAIN_SID: Integer): Boolean;
var
  local_can_update,local_can_delete : Boolean;
begin
  Result := False;
  if not DataMod.Modul_Hak(cns_ANTREPO,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmANT_GIRIS') then
    begin
      Application.CreateForm(TfrmANT_GIRIS,frmANT_GIRIS);
      with frmANT_GIRIS do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;
        cboDOVKOD.Items.Assign(glb_DOV_LIST);
        cboHDOVKOD.Items.Assign(glb_DOV_LIST);
        {with qry do
        begin
          FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
          FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
          FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
        end;}
      end;
    end;
  end;
  frmANT_GIRIS.DataSet_Open(ANT_MAIN_ID,ANT_MAIN_SID);
  Result := True;
end;
Procedure TfrmANT_GIRIS.FillTheCombos;
var
   qryDeg:TIB_Query;
begin
  try
    DataMod.CreateQuery(qryDeg,Nil,False,DataMod.dbaMain);
    qryDeg.Active:=False;
    qryDeg.SQL.Clear;
    qryDeg.SQL.Text:='SELECT DISTINCT CARI_AD FROM ANT_DETAIL';
    qryDeg.Open;
    While not qryDeg.Eof do
    begin
      cboCARI_AD.Items.Add(qryDeg.FieldByName('CARI_AD').asString);
      qryDeg.Next;
    end;
    qryDeg.Active:=False;
    qryDeg.SQL.Clear;
    qryDeg.SQL.Text:='SELECT DISTINCT ESYA FROM ANT_DETAIL';
    qryDeg.Open;
    While not qryDeg.Eof do
    begin
      cboESYA.Items.Add(qryDeg.FieldByName('ESYA').asString);
      qryDeg.Next;
    end;
    DataMod.ReleaseQuery(qryDeg);
  except on E:  Exception do
    Application.MessageBox(PChar('Hatanýn oluþtuðu yer:TfrmANT_GIRIS.FillTheCombos Hata Mesajý:' + E.Message),'Dikkat',MB_ICONERROR);
  end;
end;

procedure TfrmANT_GIRIS.IB_CheckBox2Click(Sender: TObject);
begin
  txtDEFSIRANO.ReadOnly := not IB_CheckBox2.Checked;
end;

procedure TfrmANT_GIRIS.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmANT_GIRIS.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmANT_GIRIS.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmANT_GIRIS.GetFiyat;
var
 KDV_TUTAR,Fiyat:Currency;
 DOVKOD,Urun_Ad,OlcuBirim,Depo_Kod,Depo_Ad:String;
 KDV,KDV_DAHIL:Byte;
 ARDIYE_URUN_KOD,HAMMALIYE_URUN_KOD:string;
begin
  if not (qryANT_DETAIL.State in [dssEdit,dssInsert]) then exit;
  if qryANT_DETAIL.FieldByName('ARDIYE_FIY').AsCurrency = 0 then
  begin
      if qryANT_DETAIL.FieldByName('YANICI').AsInteger = 0 then
      begin
        ARDIYE_URUN_KOD := DataMod.GETPARAM(51,'ARD_URUN_KOD',0);
        HAMMALIYE_URUN_KOD := DataMod.GETPARAM(51,'HAM_URUN_KOD',0);
      end else
      begin
        ARDIYE_URUN_KOD := DataMod.GETPARAM(51,'Y_ARD_URUN_KOD',0);
        HAMMALIYE_URUN_KOD := DataMod.GETPARAM(51,'Y_HAM_URUN_KOD',0);
      end ;

      if DataMod.GET_URUN_FAT_BILGI(trnANTREPO,
                                    ARDIYE_URUN_KOD,
                                    qryANT_DETAIL.FieldByName('CARI_KOD').AsString,
                                    1,
                                    prv_ISN,
                                    Fiyat,
                                    DOVKOD,
                                    Urun_Ad,
                                    OlcuBirim,
                                    Depo_Kod,
                                    Depo_Ad,
                                    KDV,
                                    KDV_TUTAR,
                                    KDV_DAHIL) then
      begin
          with qryANT_DETAIL do
          begin
            FieldByName('ARDIYE_FIY').AsCurrency := Fiyat;
          end;
      end;
      if DataMod.GET_URUN_FAT_BILGI(trnANTREPO,
                                    HAMMALIYE_URUN_KOD,
                                    qryANT_DETAIL.FieldByName('CARI_KOD').AsString,
                                    1,
                                    prv_ISN,
                                    Fiyat,
                                    DOVKOD,
                                    Urun_Ad,
                                    OlcuBirim,
                                    Depo_Kod,
                                    Depo_Ad,
                                    KDV,
                                    KDV_TUTAR,
                                    KDV_DAHIL) then
      begin
          with qryANT_DETAIL do
          begin
            FieldByName('HAMMALIYE').AsCurrency := Fiyat;
          end;
      end;
  end;
end;

procedure TfrmANT_GIRIS.IB_Edit6ButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qryANT_DETAIL.State in [dssInsert,dssEdit]) then exit;
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
    qryANT_DETAIL.FieldByName('CARI_KOD').AsString := Cari_KOD;
    qryANT_DETAIL.FieldByName('CARI_AD').AsString := Cari_AD;
    GetFiyat;
  end;
end;

procedure TfrmANT_GIRIS.IB_Edit6Exit(Sender: TObject);
var CARI_AD:String;
begin
   my_Active_Comp.Brush.Color := clWindow;
   if Length(Trim(IB_Edit6.Text)) <> 0 then
   begin
     if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',Trim(IB_Edit6.Text),CARI_AD) then
     begin
       qryANT_DETAIL.FieldByName('CARI_AD').AsString := CARI_AD;
     end
     else
     begin
        IB_Edit6.SetFocus;
     end;
   end;
   GetFiyat;
end;

procedure TfrmANT_GIRIS.IB_Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit6ButtonClick(Self);
end;

function TfrmANT_GIRIS.DataSet_Open(ANT_MAIN_ID, ANT_MAIN_SID: Integer): Boolean;
begin
  with frmANT_GIRIS.qryANT_MAIN do
  begin
    Close;
    ParamByName('PRM_ANT_MAIN_ID').AsInteger := ANT_MAIN_ID;
    Open;
    if ANT_MAIN_ID = 0 then
       Append
    else
    begin
      prv_DEF_SIRA_NO := FieldByName('DEF_SIRA_NO').AsInteger;
      Edit;
    end;
  end;
  with frmANT_GIRIS.qryANT_DETAIL do
  begin
    Close;
    ParamByName('PRM_ANT_MAIN_ID').AsInteger := ANT_MAIN_ID;
    Open;
  end;
end;

procedure TfrmANT_GIRIS.qryANT_DETAILAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryANT_DETAIL do
  begin
    FieldByName('ANT_DETAIL_ID').AsInteger := qryANT_DETAIL.Gen_ID('GEN_ANT_DETAIL',1);
    FieldByName('ANT_MAIN_ID').AsInteger := qryANT_MAIN.FieldByName('ANT_MAIN_ID').AsInteger;
    FieldByName('KONSIMENTO').AsString := qryANT_MAIN.FieldByName('KONSIMENTO').AsString;
    FieldByName('KAP_ADET').AsInteger := 0;
    FieldByName('KILO').AsInteger := 0;
    FieldByName('YANICI').AsInteger := 0;
    FieldByName('ARDIYE_FIY').AsInteger := 0;
    FieldByName('ARD_DOVKOD').AsString := DataMod.GETPARAM(cns_ANTREPO,'ARD_DOVKOD',0);
    FieldByName('HAMMALIYE').AsInteger := 0;
    FieldByName('HAMM_DOVKOD').AsString := DataMod.GETPARAM(cns_ANTREPO,'HAM_DOVKOD',0);
    FieldByName('KALAN_KAP').AsInteger := 0;
    FieldByName('KALAN_KILO').AsInteger := 0;
  end;
end;

procedure TfrmANT_GIRIS.qryANT_DETAILBeforeInsert(IB_Dataset: TIB_Dataset);
begin
  if not ANT_MAIN_BeforePostControl(True) then Abort;
end;

procedure TfrmANT_GIRIS.qryANT_DETAILBeforePost(IB_Dataset: TIB_Dataset);
var qryTOPLAM:TIB_Query;
begin
  if not ANT_DETAIL_BeforePostControl then Abort;
  if (qryANT_DETAIL.FieldByName('KALAN_KAP').AsInteger = 0) and
     (qryANT_DETAIL.FieldByName('KALAN_KILO').AsCurrency = 0)  then
  begin
     qryANT_DETAIL.FieldByName('KALAN_KAP').AsInteger := qryANT_DETAIL.FieldByName('KAP_ADET').AsInteger;
     qryANT_DETAIL.FieldByName('KALAN_KILO').AsCurrency := qryANT_DETAIL.FieldByName('KILO').AsCurrency;
  end else
  begin
     DataMod.CreateQuery(qryTOPLAM,Nil,False,DataMod.dbaMain);
     qryTOPLAM.SQL.Add('SELECT SUM(CIK_KAP) as CIK_KAP_TOP, SUM(CIK_KILO) as CIK_KILO_TOP FROM ANT_MAIN WHERE ANT_MAIN.GIRIS_ANT_DETAIL_ID = '+ qryANT_DETAIL.FieldByName('ANT_DETAIL_ID').AsString);
     qryTOPLAM.Open;
     qryANT_DETAIL.FieldByName('KALAN_KAP').AsInteger := qryANT_DETAIL.FieldByName('KAP_ADET').AsInteger - qryTOPLAM.FieldByName('CIK_KAP_TOP').AsInteger;
     qryANT_DETAIL.FieldByName('KALAN_KILO').AsCurrency := qryANT_DETAIL.FieldByName('KILO').AsCurrency - qryTOPLAM.FieldByName('CIK_KILO_TOP').AsCurrency;
  end;

end;

procedure TfrmANT_GIRIS.qryANT_MAINAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryANT_MAIN do
  begin
    FieldByName('ANT_MAIN_ID').AsInteger := qryANT_MAIN.Gen_ID('GEN_ANT_MAIN',1);
    FieldByName('ANT_MAIN_SID').AsInteger  := glb_SID;
    prv_DEF_SIRA_NO := DataMod.GET_SAYAC_NUM('ANT_GIR_DEF_SN',True,True,glb_SID);
    FieldByName('DEF_SIRA_NO').AsInteger := prv_DEF_SIRA_NO;
    FieldByName('TARIH').AsDate := Date;
    FieldByName('GIRCIK').AsString := GIRIS;
    FieldByName('TASIYAN').AsInteger := 1;
    FieldByName('OZET_BEYAN_TAR').AsDate := Date;
    FieldByName('GIRIS_ANT_DETAIL_ID').AsInteger := 0;
    FieldByName('CIK_KAP').AsInteger := 0;
    FieldByName('CIK_KILO').AsInteger := 0;
    FieldByName('FATURA_ID').AsInteger := 0;
    FieldByName('KAP_BOL').AsInteger := 0;
    FieldByName('DEVIR').AsInteger := 0;
  end;
end;

procedure TfrmANT_GIRIS.qryANT_MAINBeforeCancel(IB_Dataset: TIB_Dataset);
begin
  if dtsANT_MAIN.State = dssINSERT then
  begin
    DataMod.Add_Sayaclar_Nu('ANT_GIR_DEF_SN',prv_DEF_SIRA_NO,glb_SID);
  end;
end;

procedure TfrmANT_GIRIS.qryANT_MAINBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not ANT_MAIN_BeforePostControl(False) then Abort;
end;

procedure TfrmANT_GIRIS.txtDEFSIRANOKeyPress(Sender: TObject; var Key: Char);
begin
   if not isDigit(Key) then Key := #0;
end;

Function TfrmANT_GIRIS.ANT_MAIN_BeforePostControl(FromDetail:Boolean):Boolean;
begin
  if Length(Trim(qryANT_MAIN.FieldByName('TASIYAN_ID').AsString)) = 0 then
  begin
    Application.MessageBox('Taþýyýcý Plaka / Ad / Seri bilgilerini girmediniz!','Dikkat',MB_ICONERROR);
    IB_Edit1.SetFocus;
    Result := False;
    Exit;
  end;

  if Length(Trim(qryANT_MAIN.FieldByName('KONSIMENTO').AsString)) = 0 then
  begin
    Application.MessageBox('Konþimento Bilgisini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Edit3.SetFocus;
    Result := False;
    Exit;
  end;

  if Length(Trim(qryANT_MAIN.FieldByName('OZET_BEYAN_NO').AsString)) = 0 then
  begin
    Application.MessageBox('Özet Beyan Numarasý Bilgisini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Edit2.SetFocus;
    Result := False;
    Exit;
  end;
  if not FromDetail then
  begin
    if qryANT_DETAIL.RecordCount = 0 then
    begin
      Application.MessageBox('Fiþ En Az 1 kalem içermelidir.','Dikkat',MB_ICONERROR);
      Result := False;
      Exit;
    end else
    begin
      if qryANT_DETAIL.State in [dssINSERT,dssEDIT] then
      begin
        if not ANT_DETAIL_BeforePostControl then
        begin
          Result := False;
          Exit;
        end else
        begin
          qryANT_DETAIL.Post;
        end;
      end;
    end;
  end;
  Result := True;
end;

procedure TfrmANT_GIRIS.btnAraClick(Sender: TObject);
var ANT_MAIN_ID,ANT_DETAIL_ID:Integer;
begin
  if frmANT_SDLG.Form_Open(False,ANT_MAIN_ID,ANT_DETAIL_ID,1) then
  begin
    DataSet_Open(ANT_MAIN_ID,glb_SID);
  end;
end;

procedure TfrmANT_GIRIS.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmANT_GIRIS.btnEKLEClick(Sender: TObject);
begin
   qryANT_DETAIL.Append;
   IB_Edit4.SetFocus;

end;

procedure TfrmANT_GIRIS.btnFisSilClick(Sender: TObject);
var qryKONTROL:TIB_Query;
begin
  if Application.MessageBox('Kaydý silmek istiyor musunuz?','Kayýt siliniyor',MB_ICONQUESTION+MB_YESNO)= ID_NO then Exit;
  try
    DataMod.CreateQuery(qryKONTROL,Nil,False,DataMod.dbaMain);
    qryKONTROL.SQL.Add('SELECT COUNT( ANT_MAIN.ANT_MAIN_ID ) COUNT_OF_ANT_MAIN_ID ');
    qryKONTROL.SQL.Add('FROM ANT_MAIN ');
    qryKONTROL.SQL.Add('INNER JOIN ANT_DETAIL ON (ANT_DETAIL.ANT_DETAIL_ID = ANT_MAIN.GIRIS_ANT_DETAIL_ID) ');
    qryKONTROL.SQL.Add('WHERE ANT_DETAIL.ANT_MAIN_ID=' + qryANT_MAIN.FieldByName('ANT_MAIN_ID').AsString );
    qryKONTROL.Open;
    if qryKONTROL.FieldByName('COUNT_OF_ANT_MAIN_ID').AsInteger <> 0 then
    begin
      Application.MessageBox('Bu giriþ fiþinde çýkýþý yapýlmýþ kalemler var, silme iþlemi yapýlamaz','Dikkat',MB_ICONERROR);
      Exit;
    end;

    trnANTREPO.StartTransaction;
    qryANT_MAIN.Delete;
    qryANT_MAIN.ApplyUpdates;
    trnANTREPO.Commit;
    DataMod.Add_Sayaclar_Nu('ANT_GIR_DEF_SN',prv_DEF_SIRA_NO,glb_SID);    
  except on E:  Exception do
    Application.MessageBox(PChar('Hatanýn oluþtuðu yer:TfrmANT_GIRIS.btnFisSilClick Hata Mesajý:' + E.Message),'Dikkat',MB_ICONERROR);
  end;
end;

procedure TfrmANT_GIRIS.btnIptalClick(Sender: TObject);
begin
  qryANT_DETAIL.Cancel;
end;

procedure TfrmANT_GIRIS.btnKaydetClick(Sender: TObject);
begin
  qryANT_DETAIL.Post;
end;

procedure TfrmANT_GIRIS.btnSilClick(Sender: TObject);
begin
  if Application.MessageBox('Kaydý Silmek Ýstediðinizden Emin misiniz?','Dikkat',MB_ICONQUESTION+MB_YESNO)= ID_NO then Exit;
  qryANT_DETAIL.Delete;
end;

procedure TfrmANT_GIRIS.btnTRN_IPTALClick(Sender: TObject);
begin
  if Application.MessageBox('Ýptal etmek istediðinizden emin misiniz?','Dikkat',MB_YESNO+MB_ICONQUESTION)=ID_YES then
  begin
    qryANT_MAIN.Cancel;
    qryANT_MAIN.CancelUpdates;
    qryANT_MAIN.CommitUpdates;

    if qryANT_DETAIL.State in [dssEDIT,dssINSERT] then qryANT_DETAIL.Cancel;
    qryANT_DETAIL.CancelUpdates;
    qryANT_DETAIL.CommitUpdates;
    if trnANTREPO.InTransaction then trnANTREPO.Rollback;
    qryANT_MAIN.Close;
    qryANT_DETAIL.Close;
  end;
end;

procedure TfrmANT_GIRIS.btnTRN_KAYDETClick(Sender: TObject);
begin
 if not ANT_MAIN_BeforePostControl(False) then Exit;
 if trnANTREPO.InTransaction then trnANTREPO.Rollback;
 try
   if (qryANT_MAIN.State = dssInsert) and (qryANT_MAIN.FieldByName('DEVIR').AsInteger = 1) then
   begin
       DataMod.Add_Sayaclar_Nu('ANT_GIR_DEF_SN',prv_DEF_SIRA_NO,glb_SID);
   end;
   qryANT_MAIN.Post;
   trnANTREPO.StartTransaction;
   qryANT_MAIN.ApplyUpdates;
   qryANT_DETAIL.ApplyUpdates;
   trnANTREPO.CommitRetaining;
   frmANT_REPORT.ANT_GIRIS_FISI(qryANT_MAIN.FieldByName('ANT_MAIN_ID').AsInteger,0,0);
   trnANTREPO.Commit;

  except
    trnANTREPO.RollbackRetaining;
    raise;
  end;
end;

procedure TfrmANT_GIRIS.btnYeniClick(Sender: TObject);
begin
  if trnANTREPO.InTransaction then trnANTREPO.Rollback;
  DataSet_Open(0,0);
end;

procedure TfrmANT_GIRIS.dtsANT_DETAILStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
 if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnEkle.Enabled:=False;
    if ADataset.State = dssEDIT then
    begin
      btnSil.Enabled := True;
    end
    else
    begin
      btnSil.Enabled := False;
    end;
    btnKaydet.Enabled := True;
    btnIptal.Enabled := True;
  end
  else
  begin
    btnEkle.Enabled:=True;
    if ADataset.FieldByName('ANT_DETAIL_ID').AsInteger<=0 then
    begin
      btnSil.Enabled := False;
    end
    else
    begin
      btnSil.Enabled := True;
    end;
    btnKaydet.Enabled := False;
    btnIptal.Enabled := False;
  end;
end;

procedure TfrmANT_GIRIS.dtsANT_MAINStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    btnYeni.Enabled := False;
    if ADataset.State = dssEDIT then
    begin
      btnFisSil.Enabled := True;
    end
    else
    begin
      btnFisSil.Enabled := False;
    end;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnTRN_KAYDET.Enabled := True;
    btnTRN_IPTAL.Enabled := True;
    //Btn_Onceki.Enabled := False;
    //Btn_Sonraki.Enabled := False;
  end
  else
  begin
    btnYeni.Enabled := True;
    if ADataset.FieldByName('ANT_MAIN_ID').AsInteger<=0 then
    begin
      btnFisSil.Enabled := False;
      //Btn_Onceki.Enabled := False;
      //Btn_Sonraki.Enabled := False;
    end
    else
    begin
      btnFisSil.Enabled := True;
      //Btn_Onceki.Enabled := True;
      //Btn_Sonraki.Enabled := True;
    end;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
  end;
end;

procedure TfrmANT_GIRIS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmANT_GIRIS.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmANT_GIRIS);
  with frmANT_GIRIS.qryANT_DETAIL do
  begin
    FieldByName('KILO').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ARDIYE_FIY').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('HAMMALIYE').DisplayFormat := glb_VPB_FIELD_PF;
  end;
  frmANT_GIRIS.FillTheCombos;
end;

procedure TfrmANT_GIRIS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if Shift = [ssCtrl] then
      begin
        case Key Of
        35:  ///end transaction kaydet
          begin
            if btnTRN_KAYDET.Enabled Then btnTRN_KAYDETClick(self);
          end; // 35 End;
        65://   A transaction iptal
          begin
            if btnTRN_IPTAL.Enabled Then btnTRN_IPTALClick(Self);
          end;
        46: // del delete
          begin
            if btnSil.Enabled Then btnSilClick(self);
          end;
        83: //s kaydet
          begin
            if btnKAYDET.Enabled Then btnKAYDETClick(Self);
          end; //83 end
        80: //p iptal
          begin
            if btnIptal.Enabled Then btnIptalClick(Self);
          end;
        45://ins kaydet
          begin
            if btnYeni.Enabled then btnYeniClick(Self);
          end;
        end; // case end;
      end;// Shift = [ssCtrl] then end

      if Shift = [] then
      begin
        case Key of
        45: //ins kaydet
          begin
            if btnEKLE.Enabled then btnEKLEClick(Self);
          end;
        end;//acase end
      end; ///if Shift = [] then ENd
end;

procedure TfrmANT_GIRIS.FormKeyPress(Sender: TObject; var Key: Char);
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

Function TfrmANT_GIRIS.ANT_DETAIL_BeforePostControl:Boolean;
begin

  if (Length(Trim(qryANT_DETAIL.FieldByName('ANT_BEYAN_NO').AsString)) <> 0) and
     (qryANT_DETAIL.FieldByName('ANT_BEYAN_TAR').IsNull) then
  begin
    Application.MessageBox('Antrepo Tarihini Girmediniz..','Dikkat',MB_ICONERROR);
    IB_Date3.SetFocus;
    Result := False;
    Exit;
  end;

  if Length(Trim(qryANT_DETAIL.FieldByName('CARI_AD').AsString)) = 0 then
  begin
    Application.MessageBox('Cari Adýný girmediniz!','Dikkat',MB_ICONERROR);
    cboCARI_AD.SetFocus;
    Result := False;
    Exit;
  end;

  if Length(Trim(qryANT_DETAIL.FieldByName('KONSIMENTO').AsString)) = 0 then
  begin
    Application.MessageBox('Konþimento Bilgisini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Edit4.SetFocus;
    Result := False;
    Exit;
  end;

  if Length(Trim(qryANT_DETAIL.FieldByName('ESYA').AsString)) = 0 then
  begin
    Application.MessageBox('Eþya Bilgisini Girmediniz!','Dikkat',MB_ICONERROR);
    cboESYA.SetFocus;
    Result := False;
    Exit;
  end;

  if qryANT_DETAIL.FieldByName('KAP_ADET').AsInteger = 0 then
  begin
    Application.MessageBox('Kap Adetini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Currency1.SetFocus;
    Result := False;
    Exit;
  end;

  if qryANT_DETAIL.FieldByName('KILO').AsCurrency = 0 then
  begin
    Application.MessageBox('Kilo bilgisini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Currency2.SetFocus;
    Result := False;
    Exit;
  end;
  Result := True;
end;

end.
