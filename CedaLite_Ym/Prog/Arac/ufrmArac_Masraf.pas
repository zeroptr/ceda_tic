{$INCLUDE directive.inc}

unit ufrmArac_Masraf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Buttons, ExtCtrls, IB_Controls, Mask,
  Menus;

type
  TfrmArac_Masraf = class(TForm)
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    qryArac_Masraf: TIB_Query;
    dtsArac_Masraf: TIB_DataSource;
    trnArac_Masraf: TIB_Transaction;
    IB_Edit1: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_Date2: TIB_Date;
    IB_Edit2: TIB_Edit;
    IB_Text1: TIB_Text;
    IB_Edit4: TIB_Edit;
    edt_tutar: TIB_Currency;
    edt_Dovkur: TIB_Currency;
    IB_Currency3: TIB_Currency;
    IB_Text3: TIB_Text;
    Label1: TLabel;
    rgYAZICI: TRadioGroup;
    btnCikti: TButton;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    procedure qryArac_MasrafAfterInsert(IB_Dataset: TIB_Dataset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure dtsArac_MasrafStateChanged(Sender: TIB_DataSource;       ADataset: TIB_Dataset);
    procedure btnCikisClick(Sender: TObject);
    procedure dtsArac_MasrafDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure IB_Edit2ButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IB_Edit2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit2Exit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit2Enter(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure btnSilClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure IB_Edit8ButtonClick(Sender: TObject);
    procedure IB_Edit10ButtonClick(Sender: TObject);
    procedure IB_Edit11ButtonClick(Sender: TObject);
    procedure IB_Edit12ButtonClick(Sender: TObject);
    procedure IB_Edit13ButtonClick(Sender: TObject);
    procedure IB_Edit8Exit(Sender: TObject);
    procedure IB_Edit10Exit(Sender: TObject);
    procedure IB_Edit11Exit(Sender: TObject);
    procedure IB_Edit12Exit(Sender: TObject);
    procedure IB_Edit13Exit(Sender: TObject);
    procedure IB_Edit8KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit10KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit11KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit12KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit13KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure IB_Edit4Exit(Sender: TObject);
    procedure edt_DovkurExit(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    function Form_Open(Menuden:Boolean;ARACHAR_ID, ARACHAR_SID: Integer; Islem : Byte): Boolean;
    procedure DataSet_Open(ARACHAR_ID, ARACHAR_SID: Integer; Islem : Byte);
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    function OM_HAR_KAYDET(SIL:Boolean):Boolean;
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_SonrakiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    PRV_ISN,prnAracHARID,prnAracHARSID:Integer;
    my_Active_Comp:TWinControl;
    prv_CanUpdate,prv_CanDelete:Boolean;
    procedure Geri_AL;
  public
    { Public declarations }
  end;
  const cns_Arac_Masraf = 34;
var
  frmArac_Masraf: TfrmArac_Masraf;

implementation

uses unDATAMOD, main, ufrmISN_ERRORS, ufrmCariSDLG,unFUNC,  ufrmKasaSDGL, unYazici,
  unLogger, UDm_Fast_Report, ufrmAracMasrafSDGL;

{$R *.dfm}

function  TfrmArac_Masraf.Form_Open(Menuden:Boolean;ARACHAR_ID, ARACHAR_SID: Integer; Islem : Byte): Boolean;
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Arac_Masraf,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ARACHAR_ID=0) and (ARACHAR_SID=0) and (local_can_update=False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt hakkýnýz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;

    if not MainForm.FindChildFrm(Application, 'frmArac_Masraf') then
    begin
      Application.CreateForm(TfrmArac_Masraf,frmArac_Masraf);
      with frmArac_Masraf do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;

  {$IfDef TRANSPORT}
        grpRapKod.Visible := false;
        rgYAZICI.itemindex:=2;        
  {$EndIf}

        DataSet_Open(ARACHAR_ID,ARACHAR_SID,Islem);
      end;
      Result := True;
    end;
  end;
end;

procedure TfrmArac_Masraf.DataSet_Open(ARACHAR_ID, ARACHAR_SID: Integer; Islem : Byte);
{
  ISLEM
  0 : Yeni Kayýt
  1 : Edit
}
begin
  if ((ARACHAR_ID=0) and (ARACHAR_SID=0) and (prv_CanUpdate=False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt hakkýnýz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frmArac_Masraf do
  begin
    PRV_ISN := DataMod.Get_Isn_Num;
    try
      case Islem of
      0:
        begin
          with qryArac_Masraf do
          begin
            ParamByName('PRM_ARACHAR_ID').AsInteger := 0;
            ParamByName('PRM_ARACHAR_SID').AsInteger := 0;
            Insert;
          end;
        end;
      1:
        begin
          with qryArac_Masraf do
          begin
            Active := False;
            ParamByName('PRM_ARACHAR_ID').AsInteger := ARACHAR_ID;
            ParamByName('PRM_ARACHAR_SID').AsInteger := ARACHAR_SID;
            Active := True;
            Edit;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
          end;
          if qryArac_Masraf.RecordCount = 0 then
          begin
            Application.MessageBox('Kayýta ulaþýlamadý.','Dikkat',MB_ICONWARNING);
          end;
          prnAracHARID := QryArac_Masraf.FieldByName('ARACHAR_ID').AsInteger;
          prnAracHARSID := QryArac_Masraf.FieldByName('ARACHAR_SID').AsInteger;
        end;
      end;//end case Islem of
    except
      Application.MessageBox('Veri Tabaný iþlemleri sýrasýnda Hata Oluþtu','Dikkat',MB_ICONWARNING);
      Close;
    end;
    DataMod.Rapor_Kod_Visible_Fields_IB('ARACHAR',frmArac_Masraf.ib_edit8,frmArac_Masraf.ib_edit10,frmArac_Masraf.ib_edit11,frmArac_Masraf.ib_edit12,frmArac_Masraf.ib_edit13);
  end;
end;


procedure TfrmArac_Masraf.qryArac_MasrafAfterInsert(IB_Dataset: TIB_Dataset);
var
  KASA_KOD,KASA_AD,KASA_DOVKOD:String;
begin
  with qryArac_Masraf do
  begin
    FieldByName('ARACHAR_ID').AsInteger := qryArac_Masraf.Gen_ID('GEN_ARACHAR',1);
    FieldByName('ARACHAR_SID').AsInteger := glb_SID;
    FieldByName('TARIH').AsDate := DataMod.GET_SERVER_DATE ;
    FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('TARIH').AsDate;
//    FieldByName('MIKTAR').AsInteger := 0;
    FieldByName('BELGE_TUR').AsInteger := BT_ARAC_MASRAF;
    FieldByName('BELGE_ID').AsInteger := 0;
    FieldByName('BELGE_SID').AsInteger := 0;
    //FieldByName('MC').AsString := 'C';
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
    FieldByName('DOVKUR').AsCurrency := 1;
    FieldByName('SIRA_NO').AsInteger := 1;
    FieldByName('BA').AsString:=BORC;
   { if DataMod.GET_DEFAULT_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) then
    begin
      FieldByName('KASA_KOD').AsString := KASA_KOD;
      FieldByName('KASA_AD').AsString  := KASA_AD;
      FieldByName('DOVKOD').AsString   := KASA_DOVKOD;
    end;
    }
  end;
  IB_Date1.SetFocus;
end;


procedure TfrmArac_Masraf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
end;

procedure TfrmArac_Masraf.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmArac_Masraf.Form_Post;
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if TrnArac_Masraf.InTransaction then
     TrnArac_Masraf.Rollback;
  TrnArac_Masraf.StartTransaction;
//****************************************************************************//
  try
//****************************************************************************//
    prnAracHARID := qryArac_Masraf.FieldByName('ARACHAR_ID').AsInteger;
    prnAracHARSID := qryArac_Masraf.FieldByName('ARACHAR_SID').AsSmallint;
//****************************************************************************//
   { if OM_HAR_KAYDET(False) = False then
    begin
      TrnArac_Masraf.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
  }

      if not DataMod.ARAC_BA_UPDATE(trnArac_Masraf,
                                 qryArac_Masraf.FieldByName('ARAC_KOD').AsString,
                                 qryArac_Masraf.FieldByName('TUTAR_VPB').AsCurrency,
                                 qryArac_Masraf.FieldByName('BA').AsString[1])
    then
    begin
      TrnArac_Masraf.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;


//****************************************************************************//
    QryArac_Masraf.Post;
    QryArac_Masraf.ApplyUpdates;
    QryArac_Masraf.CommitUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('ARACHAR,ARAC,',
                                             BT_KASA,
                                             QryArac_Masraf.FieldByName('ARACHAR_ID').AsInteger,
                                             QryArac_Masraf.FieldByName('ARACHAR_SID').AsInteger,
                                             1,1,'ARACHAR');
//****************************************************************************//
    TrnArac_Masraf.Commit;
//****************************************************************************//
{  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(151)>0 then
  begin
       //Dm_Fast_Report.Rapor_Ac(0,141,14,1,rgYAZICI.ItemIndex,prnAracHARID,prnAracHARSID,0,'');
  end;
  //else
   // if rgYAZICI.ItemIndex < 2 then Yazici.KASACARI(prnAracHARID,prnAracHARSID,rgYAZICI.ItemIndex);
}
    prnAracHARID := 0;
    prnAracHARSID := 0;
//****************************************************************************//
  except
    TrnArac_Masraf.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  QryArac_Masraf.Close;
end;

procedure TfrmArac_Masraf.Form_Delete;
var
  ARACHAR_ID,ARACHAR_SID : Integer;
begin
  if not Form_Before_Delete then exit;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if TrnArac_Masraf.InTransaction then
     TrnArac_Masraf.Rollback;
  TrnArac_Masraf.StartTransaction;
//****************************************************************************//
  try
    //storedprocs
//****************************************************************************//
{    if OM_HAR_KAYDET(True) = False then
    begin
      TrnArac_Masraf.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      Exit;
    end;
}

     if not DataMod.ARAC_BA_UPDATE(trnArac_Masraf,
                       qryArac_Masraf.FieldByName('ARAC_KOD').AsString,
                       -qryArac_Masraf.FieldByName('TUTAR_VPB').AsCurrency,
                       qryArac_Masraf.FieldByName('BA').AsString[1])
    then
    begin
      TrnArac_Masraf.RollbackRetaining;
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;


//****************************************************************************//
    ARACHAR_ID := QryArac_Masraf.FieldByName('ARACHAR_ID').AsInteger;
    ARACHAR_SID := QryArac_Masraf.FieldByName('ARACHAR_SID').AsInteger;
//****************************************************************************//
    QryArac_Masraf.Delete;
    QryArac_Masraf.ApplyUpdates;
    QryArac_Masraf.CommitUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('ARACHAR,ARAC,',
                                             BT_ARAC_MASRAF,
                                             ARACHAR_ID,
                                             ARACHAR_SID,
                                             1,2,'ARACHAR');
//****************************************************************************//
    TrnArac_Masraf.Commit;
  except
    TrnArac_Masraf.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  QryArac_Masraf.Close;
end;

procedure TfrmArac_Masraf.btnIPTALClick(Sender: TObject);
begin
  case Application.MessageBox('Ýptal etmek istediðinizden emin misiniz.','Dikkat',MB_YESNO) of
  ID_YES:
    begin
      QryArac_Masraf.CancelUpdates;
      QryArac_Masraf.CommitUpdates;
//****************************************************************************//
      if TrnArac_Masraf.InTransaction then
         TrnArac_Masraf.Rollback;
      dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
      prnAracHARID := 0;
      prnAracHARSID := 0;
    end;
  end;//end case
end;

procedure TfrmArac_Masraf.dtsArac_MasrafStateChanged(Sender: TIB_DataSource;  ADataset: TIB_Dataset);
begin
  case ADataSet.State of
  dssEdit,dssInsert:
    begin
      btnYeni.Enabled := False;
      btnCikis.Enabled := False;
      btnAra.Enabled := False;
      if ADataSet.State <> dssEdit then
      begin
         btnSil.Enabled := False;
         Btn_Onceki.Enabled := False;
         Btn_Sonraki.Enabled := False;
      end
      else
      begin
        btnSil.Enabled := True;
        Btn_Onceki.Enabled := True;
        Btn_Sonraki.Enabled := True;
      end;
      btnKaydet.Enabled := True;
      btnIPTAL.Enabled := True;
    end;
    else
    begin
      Btn_Onceki.Enabled := False;
      Btn_Sonraki.Enabled := False;
      btnYeni.Enabled := True;
      btnCikis.Enabled := true;
      btnAra.Enabled := True;
      btnSil.Enabled := False;
      btnKaydet.Enabled := False;
      btnIPTAL.Enabled := False;
    end;
  end;
end;

procedure TfrmArac_Masraf.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmArac_Masraf.dtsArac_MasrafDataChange(Sender: TIB_StatementLink;  Statement: TIB_Statement; Field: TIB_Column);
var
  Kur:Currency;
begin
  if  Assigned( Field ) Then
  begin
    if Field.FieldName = 'DOVKOD' then
    begin
      KUR := DataMod.Get_Doviz_Kur(QryArac_Masraf.FieldByName('DOVKOD').AsString,QryArac_Masraf.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur <> 0 then QryArac_Masraf.FieldByName('DOVKUR').AsCurrency := Kur else QryArac_Masraf.FieldByName('DOVKUR').AsCurrency := 1;
    end;

    if (Field.FieldName = 'TUTAR') or (Field.FieldName = 'DOVKUR') then
    begin
      QryArac_Masraf.FieldByName('TUTAR_VPB').AsCurrency := QryArac_Masraf.FieldByName('TUTAR').AsCurrency * QryArac_Masraf.FieldByName('DOVKUR').AsCurrency ;
      //QryArac_Masraf.FieldByName('KASADEGER').AsCurrency := QryArac_Masraf.FieldByName('TUTAR').AsCurrency;
    end;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit2ButtonClick(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if not (qryArac_Masraf.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      qryArac_Masraf.FieldByName('ARAC_PLAKA').AsString := PLAKA;
      qryArac_Masraf.FieldByName('ARAC_KOD').AsString := ARAC_KOD;
  end;
end;

procedure TfrmArac_Masraf.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmArac_Masraf);
  with frmArac_Masraf.QryArac_Masraf do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_VPB_FIELD_PF;
    //FieldByName('KASADEGER').DisplayFormat := glb_DOV_FIELD_PF;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit2KeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
begin
  if Key = VK_F4 then  IB_Edit2ButtonClick(Self);
end;

procedure TfrmArac_Masraf.IB_Edit2Exit(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 SATICI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:String;
begin
  if Trim(IB_Edit2.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('ARAC','ARAC_KOD','PLAKA',IB_Edit2.Text,PLAKA) then
    begin
      qryArac_Masraf.FieldByName('ARAC_PLAKA').AsString := PLAKA;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      IB_Edit2.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qryArac_Masraf.FieldByName('ARAC_PLAKA').AsString := '';
  end;
end;

procedure TfrmArac_Masraf.FormKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmArac_Masraf.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmArac_Masraf.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmArac_Masraf.IB_Edit2Enter(Sender: TObject);
begin
  IB_Edit2.Color := glb_Art_Alan_Renk;
end;

procedure TfrmArac_Masraf.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmArac_Masraf.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
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
    end;//acase end
  end; ///if Shift = [] then ENd
end;

procedure TfrmArac_Masraf.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

function TfrmArac_Masraf.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(QryArac_Masraf.FieldByName('TARIH').AsDate,True) then Exit;
  Result := True;
end;


function TfrmArac_Masraf.Form_Before_Post:Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if not DataMod.KAY_TAR_KONTROL(QryArac_Masraf.FieldByName('TARIH').AsDate,True) then Exit; 

  if Trim(IB_Edit2.Text) = '' then
  begin
    IB_Edit2.SetFocus;
    Application.MessageBox('Mutlaka bir Araç belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if Trim(IB_Edit4.Text) = '' then
  begin
    IB_Edit4.SetFocus;
    Application.MessageBox('Mutlaka bir AÇIKLAMA belirtmelisiniz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if QryArac_Masraf.FieldByName('TUTAR').AsCurrency <= 0 then
  begin
    edt_tutar.SetFocus;
    Application.MessageBox('Tutar deðeri sýfýra eþit yada küçük olamaz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;

  if (QryArac_Masraf.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    edt_Dovkur.SetFocus;
    Application.MessageBox('Döviz kuru sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if (QryArac_Masraf.FieldByName('TUTAR_VPB').AsCurrency <= 0) then
  begin
    edt_tutar.SetFocus;
    Application.MessageBox('Tutar vpb deðeri sýfýra eþit yada küçük olamaz!!','Dikkat',MB_ICONSTOP);
    exit;
  end;

  if not DataMod.EN_GER_KAY_TAR_KONTROL(QryArac_Masraf.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(QryArac_Masraf.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(QryArac_Masraf.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;

  Result := True;
end;

function TfrmArac_Masraf.OM_HAR_KAYDET(SIL:Boolean):Boolean;
var CARI_YON,PROJE_YON:Char;
    BELGE_ID,BELGE_SID:INTEGER;
    PROJE_SIL,CARI_SIL:Byte;
begin
{  if QryArac_Masraf.FieldByName('TIP').AsString = GIRIS then
  begin
    CARI_YON := ALACAK;
    PROJE_YON := ALACAK;
  end
  else
  begin
    CARI_YON := BORC;
    PROJE_YON := BORC;
  end;
  try
      // CARI HAREKET
    if SIL then
    begin
      CARI_SIL := 1
    end
    else
    begin
      CARI_SIL := 0;
    end;
    if not DataMod.CARIHAR_AUD(TrnArac_Masraf,
                              BT_KASA,
                              QryArac_Masraf.FieldbyName('KASAHAR_ID').AsInteger,
                              QryArac_Masraf.FieldbyName('KASAHAR_SID').AsInteger,
                              1,
                              QryArac_Masraf.FieldbyName('KARSIKOD').AsString,
                              CARI_YON,
                              QryArac_Masraf.FieldbyName('TARIH').AsDate,
                              QryArac_Masraf.FieldbyName('TARIH').AsDate,
                              QryArac_Masraf.FieldbyName('DOV_BAZ_TAR').AsDate,
                              QryArac_Masraf.FieldbyName('TUTAR').AsCurrency,
                              QryArac_Masraf.FieldbyName('DOVKOD').AsString,
                              QryArac_Masraf.FieldbyName('DOVKUR').AsCurrency,
                              QryArac_Masraf.FieldbyName('TUTAR_VPB').AsCurrency,
                              QryArac_Masraf.FieldbyName('TARIH').AsDate,
//                              QryArac_Masraf.FieldbyName('YEVMIYE_ACK').AsString,
                              QryArac_Masraf.FieldbyName('ACIKLAMA').AsString,
                              CARI_SIL,
                              PRV_ISN,
                              QryArac_Masraf.FieldByName('MASRAF_MERK').AsString,
                              QryArac_Masraf.FieldByName('KOD1').AsString,
                              QryArac_Masraf.FieldByName('KOD2').AsString,
                              QryArac_Masraf.FieldByName('KOD3').AsString,
                              QryArac_Masraf.FieldByName('KOD4').AsString,
                              QryArac_Masraf.FieldByName('PLASIYER_KOD').AsString,
                              QryArac_Masraf.FieldByName('PROJE_KOD').AsString,
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(TrnArac_Masraf,PRV_ISN,0);
      Result := False;
      Exit;
    end;
   {
    //PROJE HAREKETÝ
    if Trim(QryArac_Masraf.FieldByName('PROJE_KOD').AsString) = '' then
    begin
      PROJE_SIL:=1
    end
    else
    begin
      PROJE_SIL:=0;
    end;

    if SIL then
    begin
      PROJE_SIL := 1;
    end;
    if not DataMod.PROJEHAR_AUD(TrnArac_Masraf,
                               BT_KASA,
                               QryArac_Masraf.FieldbyName('KASAHAR_ID').AsInteger,
                               QryArac_Masraf.FieldbyName('KASAHAR_SID').AsInteger,
                               1,
                               QryArac_Masraf.FieldbyName('PROJE_KOD').AsString,
                               QryArac_Masraf.FieldbyName('TARIH').AsDate,
                               QryArac_Masraf.FieldbyName('TARIH').AsDate,
                               QryArac_Masraf.FieldbyName('DOV_BAZ_TAR').AsDate,
                               QryArac_Masraf.FieldbyName('TARIH').AsDate,
                               PROJE_YON,
                               QryArac_Masraf.FieldbyName('DOVKOD').AsString,
                               QryArac_Masraf.FieldbyName('DOVKUR').AsCurrency,
                               QryArac_Masraf.FieldbyName('TUTAR').AsCurrency,
                               QryArac_Masraf.FieldbyName('TUTAR_VPB').AsCurrency,
                               PROJE_SIL,
//                               QryArac_Masraf.FieldbyName('YEVMIYE_ACK').AsString,
                               QryArac_Masraf.FieldbyName('ACIKLAMA').AsString,
                               PRV_ISN ,
                               QryArac_Masraf.FieldByName('MASRAF_MERK').AsString,
                               QryArac_Masraf.FieldByName('KOD1').AsString,
                               QryArac_Masraf.FieldByName('KOD2').AsString,
                               QryArac_Masraf.FieldByName('KOD3').AsString,
                               QryArac_Masraf.FieldByName('KOD4').AsString,
                               BELGE_ID,
                               BELGE_SID) then
    begin
      Result := False;
      Exit;
    end;
    }
{    Result := True;
  except
    Result := False;
  end; //try end;
}  
end; //FUNCTION END;

procedure TfrmArac_Masraf.btnAraClick(Sender: TObject);
var
ARACHAR_ID, ARACHAR_SID: Integer;
begin
  if frmAracMAsrafSDGL.Form_Open(True,ARACHAR_ID,ARACHAR_SID) then
  begin
    Dataset_Open(ARACHAR_ID,ARACHAR_SID,1);
  end;
end;

procedure TfrmArac_Masraf.IB_Edit8ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (QryArac_Masraf.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    QryArac_Masraf.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit10ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (QryArac_Masraf.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    QryArac_Masraf.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit11ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (QryArac_Masraf.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    QryArac_Masraf.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit12ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (QryArac_Masraf.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    QryArac_Masraf.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit13ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if not (QryArac_Masraf.State in [dssInsert,dssEdit]) then exit;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    QryArac_Masraf.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit8Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit8.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit8,nil,0) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit8.SetFocus;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit10Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit10.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit10,nil,1) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit10.SetFocus;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit11Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit11.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit11,nil,2) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit11.SetFocus;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit12Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit12.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit12,nil,3) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit12.SetFocus;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit13Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit13.Text)) = 0 then
  begin
    //buraya renk deðiþiminin kodu gelecek.
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit13,nil,4) then
  begin
    //buraya renk deðiþiminin kodu gelecek.
  end
  else
  begin
    IB_Edit13.SetFocus;
  end;
end;

procedure TfrmArac_Masraf.IB_Edit8KeyUp(Sender: TObject; var Key: Word;   Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure TfrmArac_Masraf.IB_Edit10KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure TfrmArac_Masraf.IB_Edit11KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure TfrmArac_Masraf.IB_Edit12KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure TfrmArac_Masraf.IB_Edit13KeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;

procedure TfrmArac_Masraf.IB_Edit4Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmArac_Masraf.edt_DovkurExit(Sender: TObject);
begin
  if not (QryArac_Masraf.State in [dssInsert,dssEdit]) then
  begin
    my_Active_Comp.Brush.Color := clWindow;
    exit;
  end;

  if (QryArac_Masraf.FieldByName('DOVKUR').AsCurrency <= 0) then
  begin
    Showmessage('Döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
    QryArac_Masraf.FieldByName('DOVKUR').AsCurrency := 1;
    edt_Dovkur.SetFocus;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmArac_Masraf.btnCiktiClick(Sender: TObject);
begin
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
 { if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(151)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,151,14,1,rgYAZICI.ItemIndex,prnAracHARID,prnAracHARSID,0,'');
  end
  else
  if rgYAZICI.ItemIndex < 2 then Yazici.KASACARI(prnAracHARID,prnAracHARSID,rgYAZICI.ItemIndex);
  }
end;

procedure TfrmArac_Masraf.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT FIRST 1 ARACHAR_ID,ARACHAR_SID FROM ARACHAR  WHERE BA = ''B'' and BELGE_TUR='+ Inttostr(BT_ARAC_MASRAF) +' AND ARACHAR_ID<:ARACHAR_ID AND ARACHAR_SID=:ARACHAR_SID ORDER BY ARACHAR_ID DESC';
     qryDeg1.ParamByName('ARACHAR_ID').AsInteger:=QryArac_Masraf.FieldByName('ARACHAR_ID').AsInteger;
     qryDeg1.ParamByName('ARACHAR_SID').AsInteger:=QryArac_Masraf.FieldByName('ARACHAR_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ARACHAR_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('ARACHAR_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('ARACHAR_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;

procedure TfrmArac_Masraf.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id,Sid:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT FIRST 1 ARACHAR_ID,ARACHAR_SID FROM ARACHAR  WHERE BA = ''B'' and BELGE_TUR='+ Inttostr(BT_ARAC_MASRAF) +' AND ARACHAR_ID>:ARACHAR_ID AND ARACHAR_SID=:ARACHAR_SID ORDER BY ARACHAR_ID';
     qryDeg1.ParamByName('ARACHAR_ID').AsInteger:=QryArac_Masraf.FieldByName('ARACHAR_ID').AsInteger;
     qryDeg1.ParamByName('ARACHAR_SID').AsInteger:=QryArac_Masraf.FieldByName('ARACHAR_SID').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('ARACHAR_ID').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('ARACHAR_ID').AsInteger;
          Sid:=qryDeg1.FieldByName('ARACHAR_SID').AsInteger;
          Geri_AL;
          DataSet_Open(Id,Sid,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);
end;


procedure TfrmArac_Masraf.Geri_AL;
begin
     QryArac_Masraf.CancelUpdates;
     QryArac_Masraf.Close;
     TrnArac_Masraf.Rollback;
end;

end.
