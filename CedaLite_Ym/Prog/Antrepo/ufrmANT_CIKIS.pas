unit ufrmANT_CIKIS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Mask, IB_Controls, Buttons, ExtCtrls, Grids,
  IB_Grid, Menus, ComCtrls, ToolWin;

type
  TfrmANT_CIKIS = class(TForm)
    qryANT_MAIN: TIB_Query;
    dtsANT_MAIN: TIB_DataSource;
    trnANTREPO: TIB_Transaction;
    Panel1: TPanel;
    IB_Edit1: TIB_Edit;
    IB_Edit2: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_ComboBox1: TIB_ComboBox;
    IB_Date2: TIB_Date;
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
    Label2: TLabel;
    IB_Currency7: TIB_Currency;
    IB_Currency8: TIB_Currency;
    IB_Edit7: TIB_Edit;
    IB_Date4: TIB_Date;
    IB_CheckBox2: TIB_CheckBox;
    Label3: TLabel;
    IB_Edit3: TIB_Edit;
    IB_Edit8: TIB_Edit;
    IB_Edit9: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_CheckBox3: TIB_CheckBox;
    txtDEFSIRANO: TIB_Edit;
    PopupMenu2: TPopupMenu;
    lemler1: TMenuItem;
    FaturasnA1: TMenuItem;
    btnISLEMELER: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function Form_Open(Menu: Boolean; ANT_MAIN_ID, ANT_MAIN_SID,ANT_DETAIL_ID: Integer): Boolean;
    function DataSet_Open(ANT_MAIN_ID, ANT_MAIN_SID,ANT_DETAIL_ID: Integer): Boolean;
    procedure qryANT_MAINAfterInsert(IB_Dataset: TIB_Dataset);
    procedure dtsANT_MAINStateChanged(Sender: TIB_DataSource;
      ADataset: TIB_Dataset);
    Function ANT_MAIN_BeforePostControl:Boolean;
    procedure btnTRN_KAYDETClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure btnTRN_IPTALClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure qryANT_DETAILAfterInsert(IB_Dataset: TIB_Dataset);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit6Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Function ANT_DETAIL_BeforePostControl:Boolean;
    procedure qryANT_DETAILBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryANT_MAINBeforePost(IB_Dataset: TIB_Dataset);
    procedure qryANT_DETAILBeforeInsert(IB_Dataset: TIB_Dataset);
    procedure IB_Edit6ButtonClick(Sender: TObject);
    procedure IB_Edit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GetFiyat;
    procedure IB_Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure btnAraClick(Sender: TObject);
    procedure btnFisSilClick(Sender: TObject);
    procedure IB_Edit9ButtonClick(Sender: TObject);
    procedure IB_Edit9Exit(Sender: TObject);
    procedure IB_Edit9KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qryANT_MAINBeforeCancel(IB_Dataset: TIB_Dataset);
    procedure IB_CheckBox3Click(Sender: TObject);
    procedure txtDEFSIRANOKeyPress(Sender: TObject; var Key: Char);
    Procedure Fatura_AC;
    procedure btnISLEMELERClick(Sender: TObject);
    procedure lemler1Click(Sender: TObject);
    procedure FaturasnA1Click(Sender: TObject);
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
  frmANT_CIKIS: TfrmANT_CIKIS;

implementation
uses Main,unDATAMOD, ufrmCariSDLG,unFUNC, ufrmANT_SDLG, ufrmFAT_IRS,
  ufrmANT_REPORT;

{$R *.dfm}

function TfrmANT_CIKIS.Form_Open(Menu: Boolean; ANT_MAIN_ID, ANT_MAIN_SID,ANT_DETAIL_ID: Integer): Boolean;
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
    if not MainForm.FindChildFrm(Application,'frmANT_CIKIS') then
    begin
      Application.CreateForm(TfrmANT_CIKIS,frmANT_CIKIS);
      with frmANT_CIKIS do
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
  frmANT_CIKIS.DataSet_Open(ANT_MAIN_ID,ANT_MAIN_SID,ANT_DETAIL_ID);
  Result := True;
end;

procedure TfrmANT_CIKIS.IB_CheckBox3Click(Sender: TObject);
begin
  txtDEFSIRANO.ReadOnly := not IB_CheckBox3.Checked;
end;

procedure TfrmANT_CIKIS.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmANT_CIKIS.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmANT_CIKIS.IB_Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmANT_CIKIS.GetFiyat;
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

procedure TfrmANT_CIKIS.IB_Edit6ButtonClick(Sender: TObject);
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

procedure TfrmANT_CIKIS.IB_Edit6Exit(Sender: TObject);
var CARI_AD:String;
begin
   my_Active_Comp.Brush.Color := clWindow;
   if Length(Trim(IB_Edit6.Text)) <> 0 then
   begin
     if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',Trim(IB_Edit6.Text),CARI_AD) then
     begin
       qryANT_DETAIL.FieldByName('CARI_AD').AsString := CARI_AD;
       GetFiyat;
     end
     else
     begin
        IB_Edit6.SetFocus;
     end;
   end;
end;

procedure TfrmANT_CIKIS.IB_Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit6ButtonClick(Self);
end;

procedure TfrmANT_CIKIS.IB_Edit9ButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qryANT_MAIN.State in [dssInsert,dssEdit]) then exit;
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
    qryANT_MAIN.FieldByName('GUM_KOM_KOD').AsString := Cari_KOD;
    qryANT_MAIN.FieldByName('GUM_KOM_AD').AsString := Cari_AD;
  end;
end;

procedure TfrmANT_CIKIS.IB_Edit9Exit(Sender: TObject);
var CARI_AD:String;
begin
   my_Active_Comp.Brush.Color := clWindow;
   if Length(Trim(IB_Edit9.Text)) <> 0 then
   begin
     if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',Trim(IB_Edit9.Text),CARI_AD) then
     begin
       qryANT_MAIN.FieldByName('GUM_KOM_AD').AsString := CARI_AD;
     end
     else
     begin
        IB_Edit9.SetFocus;
     end;
   end;
end;

procedure TfrmANT_CIKIS.IB_Edit9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit9ButtonClick(Self);
end;

procedure TfrmANT_CIKIS.lemler1Click(Sender: TObject);
begin
   frmANT_REPORT.ANT_CIKIS_FISI(qryANT_MAIN.FieldByName('ANT_MAIN_ID').AsInteger,glb_SID,qryANT_DETAIL.FieldByName('ANT_DETAIL_ID').AsInteger,0);
end;

function TfrmANT_CIKIS.DataSet_Open(ANT_MAIN_ID, ANT_MAIN_SID,ANT_DETAIL_ID: Integer): Boolean;
begin
  with frmANT_CIKIS.qryANT_DETAIL do
  begin
    Close;
    ParamByName('PRM_ANT_DETAIL_ID').AsInteger := ANT_DETAIL_ID;
    Open;
    Edit;
  end;
  with frmANT_CIKIS.qryANT_MAIN do
  begin
    Close;
    ParamByName('PRM_ANT_MAIN_ID').AsInteger := ANT_MAIN_ID;
    Open;
    if ANT_MAIN_ID = 0 then Append
    else
    begin
      prv_DEF_SIRA_NO := FieldByName('DEF_SIRA_NO').AsInteger;
      Edit;
    end;
  end;
end;

procedure TfrmANT_CIKIS.qryANT_DETAILAfterInsert(IB_Dataset: TIB_Dataset);
begin
{  with qryANT_DETAIL do
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
    FieldByName('KAPANDI').AsInteger := 0;
  end;}
end;

procedure TfrmANT_CIKIS.qryANT_DETAILBeforeInsert(IB_Dataset: TIB_Dataset);
begin
  if not ANT_MAIN_BeforePostControl then Abort;
end;

procedure TfrmANT_CIKIS.qryANT_DETAILBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not ANT_DETAIL_BeforePostControl then Abort;
end;

procedure TfrmANT_CIKIS.qryANT_MAINAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qryANT_MAIN do
  begin
    FieldByName('ANT_MAIN_ID').AsInteger := qryANT_MAIN.Gen_ID('GEN_ANT_MAIN',1);
    FieldByName('ANT_MAIN_SID').AsInteger  := glb_SID;
    FieldByName('DEF_SIRA_NO').AsInteger := DataMod.GET_SAYAC_NUM('ANT_GIR_CIK_SN',True,True,glb_SID);
    prv_DEF_SIRA_NO := FieldByName('DEF_SIRA_NO').AsInteger;    
    FieldByName('TARIH').AsDate := Date;
    FieldByName('GIRCIK').AsString := CIKIS;
    FieldByName('TASIYAN').AsInteger := 1;
    FieldByName('OZET_BEYAN_TAR').AsDate := Date;
    FieldByName('GIRIS_ANT_DETAIL_ID').AsInteger := qryANT_DETAIL.FieldByName('ANT_DETAIL_ID').AsInteger;
    FieldByName('CIK_KAP').AsInteger := qryANT_DETAIL.FieldByName('KALAN_KAP').AsInteger;
    FieldByName('CIK_KILO').AsCurrency := qryANT_DETAIL.FieldByName('KALAN_KILO').AsCurrency;
    FieldByName('FATURA_ID').AsInteger := 0;
    FieldByName('GUM_VEZ_TAR').AsDate := Date;
    FieldByName('KAP_BOL').AsInteger := 0;
    FieldByName('DEVIR').AsInteger := 0;
  end;
end;

procedure TfrmANT_CIKIS.qryANT_MAINBeforeCancel(IB_Dataset: TIB_Dataset);
begin
  if dtsANT_MAIN.State = dssINSERT then
  begin
    DataMod.Add_Sayaclar_Nu('ANT_GIR_CIK_SN',qryANT_MAIN.FieldByName('DEF_SIRA_NO').AsInteger,glb_SID);
  end;
end;

procedure TfrmANT_CIKIS.qryANT_MAINBeforePost(IB_Dataset: TIB_Dataset);
begin
  if not ANT_MAIN_BeforePostControl then Abort;
end;

procedure TfrmANT_CIKIS.txtDEFSIRANOKeyPress(Sender: TObject; var Key: Char);
begin
   if not isDigit(Key) then Key := #0;
end;

Function TfrmANT_CIKIS.ANT_MAIN_BeforePostControl:Boolean;
begin
  if Length(Trim(qryANT_MAIN.FieldByName('OZET_BEYAN_NO').AsString)) = 0 then
  begin
    Application.MessageBox('Çýkýþ Beyan Numarasý Bilgisini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Edit2.SetFocus;
    Result := False;
    Exit;
  end;

  if Length(Trim(qryANT_MAIN.FieldByName('GUM_VEZ_NO').AsString)) = 0 then
  begin
    Application.MessageBox('Gümrük Vezne Alýndý Bilgisini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Edit7.SetFocus;
    Result := False;
    Exit;
  end;

  if qryANT_MAIN.FieldByName('CIK_KAP').AsInteger = 0 then
  begin
    Application.MessageBox('Çýkan Kap Adetini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Currency7.SetFocus;
    Result := False;
    Exit;
  end;

  if qryANT_MAIN.FieldByName('CIK_KAP').AsInteger > qryANT_DETAIL.FieldByName('KALAN_KAP').AsInteger then
  begin
    Application.MessageBox('Çýkan Kap Adeti, Kalan Kap adetinden fazla olamaz!','Dikkat',MB_ICONERROR);
    IB_Currency7.SetFocus;
    Result := False;
    Exit;
  end;

  if qryANT_MAIN.FieldByName('CIK_KILO').AsCurrency = 0 then
  begin
    Application.MessageBox('Çýkan Kilo bilgisini Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Currency8.SetFocus;
    Result := False;
    Exit;
  end;

  if qryANT_MAIN.FieldByName('CIK_KILO').AsCurrency > qryANT_DETAIL.FieldByName('KALAN_KILO').AsCurrency then
  begin
    Application.MessageBox('Çýkan Kilo, Kalan Kilodan fazla olamaz!','Dikkat',MB_ICONERROR);
    IB_Currency8.SetFocus;
    Result := False;
    Exit;
  end;

  if (qryANT_MAIN.FieldByName('KAP_BOL').AsInteger = 0) and
     (qryANT_MAIN.FieldByName('CIK_KAP').AsInteger = qryANT_DETAIL.FieldByName('KALAN_KAP').AsInteger) and
     (qryANT_MAIN.FieldByName('CIK_KILO').AsCurrency < qryANT_DETAIL.FieldByName('KALAN_KILO').AsCurrency) then
  begin
    Application.MessageBox('Kap bölme yapmadan daha düþük kilo çýkamazsýnýz!','Dikkat',MB_ICONERROR);
    IB_Currency8.SetFocus;
    Result := False;
    Exit;
  end;


  if Length(Trim(qryANT_MAIN.FieldByName('GUM_KOM_KOD').AsString)) = 0 then
  begin
    Application.MessageBox('Gümrük Komisyoncusu Kodunu Girmediniz!','Dikkat',MB_ICONERROR);
    IB_Edit9.SetFocus;
    Result := False;
    Exit;
  end;
  Result := True;
end;

procedure TfrmANT_CIKIS.btnAraClick(Sender: TObject);
var ANT_MAIN_ID,ANT_DETAIL_ID:Integer;
begin
  if frmANT_SDLG.Form_Open(False,ANT_MAIN_ID,ANT_DETAIL_ID,2) then
  begin
    DataSet_Open(ANT_MAIN_ID,glb_SID,ANT_DETAIL_ID);
  end;
end;

procedure TfrmANT_CIKIS.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmANT_CIKIS.btnFisSilClick(Sender: TObject);
var qryKONTROL:TIB_Query;
begin
  if Application.MessageBox('Kaydý silmek istiyor musunuz?','Kayýt siliniyor',MB_ICONQUESTION+MB_YESNO)= ID_NO then Exit;
  try
    DataMod.CreateQuery(qryKONTROL,trnANTREPO,False,DataMod.dbaMain);
    qryKONTROL.SQL.Add('DELETE FROM ANT_MAIN WHERE ANT_MAIN_ID = '+ qryANT_MAIN.FieldByName('ANT_MAIN_ID').AsString);
    qryANT_MAIN.Close;
    qryANT_DETAIL.Close;
    trnANTREPO.StartTransaction;
    qryKONTROL.Execute;
    trnANTREPO.Commit;
    DataMod.Add_Sayaclar_Nu('ANT_GIR_CIK_SN',prv_DEF_SIRA_NO,glb_SID);    
  except on E:  Exception do
    Application.MessageBox(PChar('Hatanýn oluþtuðu yer:TfrmANT_CIKIS.btnFisSilClick Hata Mesajý:' + E.Message),'Dikkat',MB_ICONERROR);
  end;
end;

procedure TfrmANT_CIKIS.btnTRN_IPTALClick(Sender: TObject);
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

procedure TfrmANT_CIKIS.btnTRN_KAYDETClick(Sender: TObject);
begin
 if not ANT_DETAIL_BeforePostControl then Exit;
 if not ANT_MAIN_BeforePostControl then Exit;

 if trnANTREPO.InTransaction then trnANTREPO.Rollback;
 try
   if (qryANT_MAIN.State = dssInsert) and (qryANT_MAIN.FieldByName('DEVIR').AsInteger = 1) then
   begin
     DataMod.Add_Sayaclar_Nu('ANT_GIR_CIK_SN',prv_DEF_SIRA_NO,glb_SID);
   end;
   trnANTREPO.StartTransaction;
   qryANT_DETAIL.Post;
   qryANT_MAIN.Post;
   qryANT_DETAIL.ApplyUpdates;
   qryANT_MAIN.ApplyUpdates;
   trnANTREPO.CommitRetaining;
   frmANT_REPORT.ANT_CIKIS_FISI(qryANT_MAIN.FieldByName('ANT_MAIN_ID').AsInteger,glb_SID,qryANT_DETAIL.FieldByName('ANT_DETAIL_ID').AsInteger,0);
   if qryANT_MAIN.FieldByName('DEVIR').AsInteger = 0 then Fatura_AC;
  except
    trnANTREPO.RollbackRetaining;
    raise;
  end;
end;
procedure TfrmANT_CIKIS.btnISLEMELERClick(Sender: TObject);
begin
   PopupMenu2.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TfrmANT_CIKIS.FaturasnA1Click(Sender: TObject);
begin
   frmFAT_IRS.Form_Open(True,1,qryANT_MAIN.FieldByName('FATURA_ID').AsInteger,glb_SID,1,1);
end;

Procedure TfrmANT_CIKIS.Fatura_AC;
var Hammaliye,Ardiye,TonaDonus:Currency;
    GUN: Extended;
    Updater:TIB_Query;
    FAT_IRS_ID:Integer;
begin
   if qryANT_MAIN.FieldByName('FATURA_ID').AsInteger <> 0 then
   begin
      if MainForm.FindChildFrm(Application,'frmFAT_IRS') then
      begin
        Application.MessageBox ('Fatura formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
        Exit;
      end else
      begin
        frmFAT_IRS.Form_Open(False,1,qryANT_MAIN.FieldByName('FATURA_ID').AsInteger,glb_SID,1,1);
      end;
   end else
   begin
     with frmFAT_IRS do
     begin
       try
         if Datamod.Get_Doviz_Kur('USD',Date,2,0) = 0 then Exit;
         Form_Open(True,1,0,0,0,1);
         qryFAT_IRS.FieldByName('CARI_KOD').AsString := qryANT_DETAIL.FieldByName('CARI_KOD').AsString;
         txtCariKodExit(Self);
         pgFAT_IRS.ActivePage := tabKalem;
         frmFAT_IRS.btnEKLEClick(frmFAT_IRS);
         qryURUNHAR.FieldByName('URUN_KOD').AsString := DataMod.GETPARAM(51,'ARD_URUN_KOD',0);
         txtUrunKoduExit(frmFAT_IRS);
         qryURUNHAR.FieldByName('MIKTAR').AsInteger := 1;
         DataMod.OLCUBIRIM_DONUSTUR('KÝLO',qryANT_MAIN.FieldByName('CIK_KILO').AsCurrency, qryURUNHAR.FieldByName('OLCUBIRIM').AsString,TonaDonus);
         GUN := ((Date - qryANT_DETAIL.FieldByName('GIRIS_TAR').AsDate) + 1 );
         Hammaliye := qryANT_DETAIL.FieldByName('HAMMALIYE').AsCurrency * TonaDonus;
         Ardiye := GUN * TonaDonus * qryANT_DETAIL.FieldByName('ARDIYE_FIY').AsCurrency;
         qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency := Hammaliye + Ardiye;
         KalemHesapla;
         frmFAT_IRS.btnKaydetClick(Self);
         frmFAT_IRS.EkAciklamaOpen;
         qryFAT_IRS_ACK.FieldByName('ACK_30K_1').AsString := qryANT_DETAIL.FieldByName('GIRIS_TAR').AsString;
         qryFAT_IRS_ACK.FieldByName('ACK_30K_2').AsString := DateToStr(Date);
         qryFAT_IRS_ACK.FieldByName('ACK_50K_1').AsString := FloatToStr(GUN);
         qryFAT_IRS_ACK.FieldByName('ACK_50K_2').AsString := qryANT_MAIN.FieldByName('CIK_KAP').AsString;
         qryFAT_IRS_ACK.FieldByName('ACK_50K_3').AsString := qryANT_MAIN.FieldByName('CIK_KILO').AsString;
         qryFAT_IRS_ACK.FieldByName('ACK_50K_4').AsString := qryANT_MAIN.FieldByName('DEF_SIRA_NO').AsString;
         qryFAT_IRS_ACK.FieldByName('ACK_50K_5').AsString := FloatToStr(Hammaliye + Ardiye) + ' ' + qryURUNHAR.FieldByName('DOVKOD').AsString;
         qryFAT_IRS_ACK.FieldByName('ACK_100K_1').AsString := qryURUNHAR.FieldByName('DOVKUR').AsString;
         qryFAT_IRS_ACK.FieldByName('ACK_100K_2').AsString := qryANT_DETAIL.FieldByName('ESYA').AsString;
         pgFAT_IRS.ActivePage := tabFAT_IRS;
         qryANT_MAIN.FieldByName('FATURA_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
         rgYAZICI.ItemIndex := 1;
         FAT_IRS_ID := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
         frmFAT_IRS.btnTRN_KAYDETClick(frmFAT_IRS);
         frmFAT_IRS.btnCikisClick(frmFAT_IRS);
         DataMod.CreateQuery(Updater,Nil,False,DataMod.dbaMain);
         Updater.sql.Add('UPDATE ANT_MAIN SET FATURA_ID = ' + IntToStr(FAT_IRS_ID)+ ' WHERE ANT_MAIN.ANT_MAIN_ID = ' + qryANT_MAIN.FieldByName('ANT_MAIN_ID').AsString);
         Updater.Execute;
         Datamod.ReleaseQuery(Updater);
       except on E:Exception do
         Application.MessageBox(Pchar('Hata Oluþan Fonsiyon TfrmANT_CIKIS.Fatura_AC. Hata : '+ E.Message),'Hata',MB_ICONERROR);
       end;
     end;
   end;
end;
procedure TfrmANT_CIKIS.dtsANT_MAINStateChanged(Sender: TIB_DataSource;
  ADataset: TIB_Dataset);
begin
  if (ADataset.State in [dssEdit,dssInsert]) then
  begin
    if ADataset.State = dssEDIT then
    begin
      btnFisSil.Enabled := True;
      btnISLEMELER.Enabled := True;
    end
    else
    begin
      btnFisSil.Enabled := False;
      btnISLEMELER.Enabled := False;
    end;
    btnAra.Enabled := False;
    btnCikis.Enabled := False;
    btnTRN_KAYDET.Enabled := True;
    btnTRN_IPTAL.Enabled := True;
//    Btn_Onceki.Enabled := False;
//    Btn_Sonraki.Enabled := False;
  end
  else
  begin
    if ADataset.FieldByName('ANT_MAIN_ID').AsInteger<=0 then
    begin
      btnFisSil.Enabled := False;
      btnISLEMELER.Enabled := False;
//      Btn_Onceki.Enabled := False;
//      Btn_Sonraki.Enabled := False;
    end
    else
    begin
      btnFisSil.Enabled := True;
      btnISLEMELER.Enabled := True;
//      Btn_Onceki.Enabled := True;
//      Btn_Sonraki.Enabled := True;
    end;
    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnTRN_KAYDET.Enabled := False;
    btnTRN_IPTAL.Enabled := False;
  end;
end;

procedure TfrmANT_CIKIS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmANT_CIKIS.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmANT_CIKIS);
  with frmANT_CIKIS.qryANT_DETAIL do
  begin
    FieldByName('KALAN_KILO').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('ARDIYE_FIY').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('HAMMALIYE').DisplayFormat := glb_VPB_FIELD_PF;
  end;
  frmANT_CIKIS.qryANT_MAIN.FieldByName('CIK_KILO').DisplayFormat := glb_VPB_FIELD_PF;
end;

procedure TfrmANT_CIKIS.FormKeyDown(Sender: TObject; var Key: Word;
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

          end;
        83: //s kaydet
          begin

          end; //83 end
        80: //p iptal
          begin

          end;
        45://ins kaydet
          begin

          end;
        end; // case end;
      end;// Shift = [ssCtrl] then end

      if Shift = [] then
      begin
        case Key of
        45: //ins kaydet
          begin

          end;
        end;//acase end
      end; ///if Shift = [] then ENd
end;

procedure TfrmANT_CIKIS.FormKeyPress(Sender: TObject; var Key: Char);
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

Function TfrmANT_CIKIS.ANT_DETAIL_BeforePostControl:Boolean;
begin
  if Length(Trim(qryANT_DETAIL.FieldByName('CARI_KOD').AsString)) = 0 then
  begin
    Application.MessageBox('Cari kodunu girmediniz!','Dikkat',MB_ICONERROR);
    IB_Edit6.SetFocus;
    Result := False;
    Exit;
  end;
  Result := True;
end;

end.
