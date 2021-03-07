{$INCLUDE directive.inc}

unit ufrmKasalarArasiTransfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, IB_Controls, Mask, StdCtrls, IB_Components, Buttons,
  ExtCtrls, Grids, IB_Grid;

type
  TfrmKasalarArasiTransfer = class(TForm)
    qryKASAHAR: TIB_Query;
    IB_Edit1: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_Date4: TIB_Date;
    edt_Dovkur: TIB_Currency;
    edt_tutar_alacak: TIB_Currency;
    edt_tutar_borc: TIB_Currency;
    Label1: TLabel;
    Label2: TLabel;
    IB_Edit3: TIB_Edit;
    dtsKASAHAR: TIB_DataSource;
    trnTRANSFER: TIB_Transaction;
    lbl_Borc_Kasa_Dov_Kod: TLabel;
    Label5: TLabel;
    txt_Borclu_Kasa: TEdit;
    btnALACAKLI: TButton;
    btnBORCLU: TButton;
    IB_Text1: TIB_Text;
    txt_Alacakli_Kasa: TIB_Edit;
    IB_Text2: TIB_Text;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    btnYeni: TBitBtn;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    edt_Dovkur1: TIB_Currency;
    edt_tutar_vpb: TIB_Currency;
    IB_Edit6: TIB_Edit;
    rgYAZICI: TRadioGroup;
    edt_tutar_vpb1: TIB_Currency;
    btnCikti: TButton;
    grpRapKod: TGroupBox;
    IB_Edit8: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCikisClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure dtsKASAHARStateChanged(Sender: TIB_DataSource;      ADataset: TIB_Dataset);
    procedure txt_Alacakli_KasaButtonClick(Sender: TObject);
    procedure txt_Borclu_KasaButtonClick(Sender: TObject);
    procedure btnALACAKLIClick(Sender: TObject);
    procedure btnBORCLUClick(Sender: TObject);
    procedure txt_Alacakli_KasaKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txt_Borclu_KasaKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txt_Alacakli_KasaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txt_Borclu_KasaExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure txt_Alacakli_KasaEnter(Sender: TObject);
    procedure txt_Borclu_KasaEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure txt_Alacakli_KasaKeyPress(Sender: TObject; var Key: Char);
    procedure dtsKASAHARDataChange(Sender: TIB_StatementLink;      Statement: TIB_Statement; Field: TIB_Column);
    procedure btnAraClick(Sender: TObject);
    procedure edt_Dovkur1Change(Sender: TObject);
    procedure edt_Dovkur1Exit(Sender: TObject);
    procedure edt_Dovkur1Enter(Sender: TObject);
    procedure edt_tutar_borcEnter(Sender: TObject);
    procedure edt_tutar_borcExit(Sender: TObject);
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
    procedure IB_Edit8KeyUp(Sender: TObject; var Key: Word;        Shift: TShiftState);
    procedure IB_Edit10KeyUp(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure IB_Edit11KeyUp(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure IB_Edit12KeyUp(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure IB_Edit13KeyUp(Sender: TObject; var Key: Word;       Shift: TShiftState);
    procedure IB_Edit3Exit(Sender: TObject);
    procedure edt_DovkurExit(Sender: TObject);
    procedure btnCiktiClick(Sender: TObject);
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Post;
    procedure Form_Delete;
    function Form_Before_Post:Boolean;
    function Form_Before_Delete:Boolean;
    procedure Form_Open(Menu:Boolean;KASAHAR_ID,KASAHAR_SID:Integer;Islem:Byte);
    procedure DataSet_Open(KASAHAR_ID,KASAHAR_SID:Integer;Islem:Byte);
////////////////////////////////////////////////////////////////////////////////
  private
    { Private declarations }
    PRV_ISN:Integer;
    my_Active_Comp:TWinControl;
    qryTEMP : TIB_Query;
    KASA_KOD,KASA_DOVKOD,KASA_AD:String;
    prv_CanUpdate,prv_CanDelete:Boolean;
  public
    { Public declarations }
    prnBELGEID,prnBELGESID:Integer;
  end;

  const cns_kasa_transfer = 14;

var
  frmKasalarArasiTransfer: TfrmKasalarArasiTransfer;

implementation

uses unDataMod, unFunc,ufrmISN_ERRORS,ufrmKasaSDGL,  unYazici,
  unLogger, main, UDm_Fast_Report;

{$R *.dfm}

procedure TfrmKasalarArasiTransfer.Form_Open(Menu:Boolean;KASAHAR_ID,KASAHAR_SID:Integer;Islem:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_kasa_transfer,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((KASAHAR_ID = 0) and (KASAHAR_SID = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
    if MainForm.FindChildFrm( Application, 'frmKasalarArasiTransfer') = False  Then
    begin
      Application.CreateForm(TfrmKasalarArasiTransfer,frmKasalarArasiTransfer);
      with frmKasalarArasiTransfer do
      begin
        prv_CanUpdate := local_can_update;
        prv_CanDelete := local_can_delete;


  {$IfDef TRANSPORT}
        grpRapKod.Visible := false;
        rgYAZICI.itemindex:=2;        
  {$EndIf}

        DataSet_Open(KASAHAR_ID,KASAHAR_SID,Islem);
      end;
    end;
  end;
end;

procedure TfrmKasalarArasiTransfer.DataSet_Open(KASAHAR_ID,KASAHAR_SID: Integer; Islem: Byte);
var
  Kasahar_Id_Ilk:Integer;
  borclu_kasa_kod : String;
  borclu_kasa_tutar: Currency;
begin
{ ISLEM
  0 : Yeni Kayýt
  1 : Edit
}
  if ((KASAHAR_ID=0) and (KASAHAR_SID=0) and (prv_CanUpdate=False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  DataMod.Rapor_Kod_Visible_Fields_IB('KASA',frmKasalarArasiTransfer.ib_edit8,frmKasalarArasiTransfer.ib_edit10,frmKasalarArasiTransfer.ib_edit11,frmKasalarArasiTransfer.ib_edit12,frmKasalarArasiTransfer.ib_edit13);
  with frmKasalarArasiTransfer do
  begin
    PRV_ISN := DataMod.Get_Isn_Num;
    try
      case Islem of
      0:
        begin
          with qryKASAHAR do
          begin
            ParamByName('PRM_BELGE_TUR').AsInteger := BT_KASA;
            ParamByName('PRM_BELGE_ID').AsInteger := 0;
            ParamByName('PRM_BELGE_SID').AsInteger := 0;
            DisableControls;
            Append;
////////////////////////////////////////////////////////////////////////////////
            FieldByName('BELGE_TUR').AsInteger := BT_KASA;
            FieldByName('BELGE_ID').AsInteger := FieldByName('KASAHAR_ID').AsInteger;
            Kasahar_Id_Ilk := FieldByName('KASAHAR_ID').AsInteger;
            FieldByName('BELGE_SID').AsInteger := glb_SID;
            FieldByName('KASAHAR_SID').AsInteger := glb_SID;
            FieldByName('ISLEM_TIP').AsInteger := 6;
            FieldByName('TIP').AsString := 'C';
            FieldByName('SIRA_NO').AsInteger := 1;
            FieldByName('MIKTAR').AsInteger := 0;
            FieldByName('MC').AsString := 'K';
            FieldByName('KASADEGER').AsCurrency := 0;
            FieldByName('KASA_KOD').AsString := 'KK';
            FieldByName('KARSIKOD').AsString := 'KK';
            FieldByName('DOVKUR').AsCurrency := 1;
            FieldByName('TUTAR').AsCurrency := 0;
            FieldByName('TUTAR_VPB').AsCurrency := 0;
            FieldByName('TARIH').AsDate := DataMod.GET_SERVER_DATE;
            FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('TARIH').AsDate;
            //dovkod burada kasanýn döviz kodu olacak.
            FieldByName('DOVKOD').AsString := glb_DEFCUR;
            //dovkur kasanýn döviz kodu olacak
            Update;
            Append;
            //yarýn burada must olmasý gereken alanlarý kontrol et
            //gereksiz datalarý buraya atma ve koddan kaldýr
            //çünkü 2.kasanýn deðerleri deðiþiyor.
            FieldByName('BELGE_TUR').AsInteger := BT_KASA;
            FieldByName('BELGE_ID').AsInteger := Kasahar_Id_Ilk;
            FieldByName('BELGE_SID').AsInteger := glb_SID;
            FieldByName('KASAHAR_SID').AsInteger := glb_SID;
            FieldByName('ISLEM_TIP').AsInteger := 6;
            FieldByName('TIP').AsString := 'G';
            FieldByName('SIRA_NO').AsInteger := 2;
////////////////////////////////////////////////////////////////////////////////
            FieldByName('KASA_KOD').AsString := KASA_KOD;
            FieldByName('KARSIKOD').AsString := 'KK';
            FieldByName('DOVKUR').AsCurrency := 1;
            FieldByName('TUTAR').AsCurrency := 0;
            FieldByName('TUTAR_VPB').AsCurrency := 0;
            FieldByName('TARIH').AsDate := DataMod.GET_SERVER_DATE;
            FieldByName('DOV_BAZ_TAR').AsDate := FieldByName('TARIH').AsDate;
            FieldByName('DOVKOD').AsString := glb_DEFCUR;
            FieldByName('KASADEGER').AsCurrency := 0;
            FieldByName('MIKTAR').AsInteger := 0;
            FieldByName('MC').AsString := 'K';
            //BURADA ASLINDA ÝKÝNCÝ KASANIN DEFAULT KASA OLMAMASI GEREKÝYOR
            //ÇÜNKÜ KASALAR ARASI TRANSFERDE KASALARIN BÝRBÝRÝNDEN FARKLI OLMASI
            //GEREKÝYOR.
            Update;
            Prior;
            EnableControls;
            if DataMod.GET_DEFAULT_KASA(KASA_KOD,KASA_AD,KASA_DOVKOD) then
            begin
              FieldByName('KASA_KOD').AsString := KASA_KOD;
              FieldByName('KASA_AD').AsString := KASA_AD;
              FieldByName('DOVKOD').AsString   := KASA_DOVKOD;
            end;
            btnSil.Enabled := False;
            IB_Date1.SetFocus;
////////////////////////////////////////////////////////////////////////////////
          end;
        end;
      1:
        begin
          DataMod.CreateQuery(qryTEMP,nil,False,DataMod.dbaMain);
          //qryTEMP := TIB_Query.Create(Self);
          with qryTEMP do
          begin
            //IB_Connection := DataMod.dbaMain;
            SQL.Add('SELECT BELGE_ID,BELGE_SID FROM KASAHAR WHERE KASAHAR_ID=:PRM_KASAHAR_ID AND KASAHAR_SID=:PRM_KASAHAR_SID');
            ParamByName('PRM_KASAHAR_ID').AsInteger := KASAHAR_ID;
            ParamByName('PRM_KASAHAR_SID').AsInteger := KASAHAR_SID;
            Active := True;
          end;

          with qryKASAHAR do
          begin
            SQL.Clear;
            SQL.Add('SELECT KASAHAR_ID');
            SQL.Add('       ,KASAHAR_SID');
            SQL.Add('       ,KASA_KOD');
            SQL.Add('       ,(SELECT KASA.ACIKLAMA FROM KASA WHERE KASA.KASA_KOD = KASAHAR.KASA_KOD)AS KASA_AD');
            SQL.Add('       ,TARIH');
            SQL.Add('       ,DOV_BAZ_TAR');
            SQL.Add('       ,BELGE_TUR');
            SQL.Add('       ,BELGE_ID');
            SQL.Add('       ,BELGE_SID');
            SQL.Add('       ,TIP');
            SQL.Add('       ,ACIKLAMA');
            SQL.Add('       ,KASADEGER');
            SQL.Add('       ,ISLEM_TIP');
            SQL.Add('       ,MC');
            SQL.Add('       ,KARSIKOD');
            SQL.Add('       ,SIRA_NO');
            SQL.Add('       ,DOVKOD');
            SQL.Add('       ,DOVKUR');
            SQL.Add('       ,TUTAR');
            SQL.Add('       ,TUTAR_VPB');
            SQL.Add('       ,OLCUBIRIM');
            SQL.Add('       ,MIKTAR');
            SQL.Add('       ,MASRAF_MERK');
            SQL.Add('       ,KOD1');
            SQL.Add('       ,KOD2');
            SQL.Add('       ,KOD3');
            SQL.Add('       ,KOD4');
            SQL.Add('       ,YEVMIYE_ACK');
            SQL.Add(' FROM KASAHAR');
            SQL.Add(' WHERE BELGE_TUR=:PRM_BELGE_TUR AND BELGE_ID=:PRM_BELGE_ID AND BELGE_SID=:PRM_BELGE_SID AND ISLEM_TIP=6');
            SQL.Add(' ORDER BY KASAHAR.SIRA_NO ');
          end;
          qryKASAHAR.Active := False;
          qryKASAHAR.ParamByName('PRM_BELGE_TUR').AsInteger := BT_KASA;
          qryKASAHAR.ParamByName('PRM_BELGE_ID').AsInteger := qryTEMP.FieldByName('BELGE_ID').AsInteger;
          qryKASAHAR.ParamByName('PRM_BELGE_SID').AsInteger := qryTEMP.FieldByName('BELGE_SID').AsInteger;

          DataMod.ReleaseQuery(qryTEMP);
          //qryTEMP.Active := False;
          //qryTEMP.Free;
          qryKASAHAR.Active := True;
          if qryKASAHAR.RecordCount = 0 then
          begin
            Application.MessageBox('Kayýta ulaþýlamadý.','Dikkat',MB_ICONWARNING);
          end;
          qryKASAHAR.DisableControls;
          qryKASAHAR.Next;
          borclu_kasa_kod := qryKASAHAR.FieldByName('KASA_KOD').AsString;
          borclu_kasa_tutar := qryKASAHAR.FieldByName('TUTAR').AsCurrency;
          edt_Dovkur1.Value := qryKASAHAR.FieldByName('DOVKUR').AsCurrency;
          qryKASAHAR.Prior;
          qryKASAHAR.EnableControls;
          prnBELGEID := qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger;
          prnBELGESID := qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger;
          edt_tutar_borc.Value := borclu_kasa_tutar;
          txt_Borclu_Kasa.Text := borclu_kasa_kod;
          txt_Borclu_KasaExit(Self);
          btnSil.Enabled := True;
//****************************************************************************//
//****************************************************************************//
        end;//end case 1
      end;//end case
    except
      Application.MessageBox('Veri Tabaný iþlemleri sýrasýnda hata oluþtu.','Dikkat',MB_ICONWARNING);
      Close;
    end;//end try
  end;//end with form
end;

procedure TfrmKasalarArasiTransfer.edt_Dovkur1Change(Sender: TObject);
begin
  edt_tutar_vpb.Value :=  edt_Dovkur1.Value * edt_tutar_borc.Value;
end;

procedure TfrmKasalarArasiTransfer.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmKasalarArasiTransfer.btnCikisClick(Sender: TObject);
begin
  close;
end;

procedure TfrmKasalarArasiTransfer.btnIPTALClick(Sender: TObject);
begin
  qryKASAHAR.CancelUpdates;
  qryKASAHAR.CommitUpdates;
  qryKASAHAR.Close;
  btnSil.Enabled := False;
//****************************************************************************//
  if trnTRANSFER.InTransaction then
     trnTRANSFER.Rollback;
  dmLOGGER.dbaMain_CancelMonitoring;
//****************************************************************************//
  prnBELGEID := 0;
  prnBELGESID := 0;
end;

procedure TfrmKasalarArasiTransfer.dtsKASAHARStateChanged(
  Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  Case ADataSet.State of
  dssEdit,dssInsert:
      begin
         btnYeni.Enabled := False;
         btnCikis.Enabled := False;
         btnAra.Enabled := False;
         btnKaydet.Enabled := True;
         btnIPTAL.Enabled := True;
         btnALACAKLI.Enabled := true;
         btnBORCLU.Enabled := true;

         IB_Date1.Enabled := true;
         IB_Date4.Enabled := true;
         IB_Edit3.Enabled := true;
         ib_edit6.Enabled :=True;

         txt_Borclu_Kasa.Enabled := true;
         txt_Alacakli_Kasa.Enabled := true;

         edt_Dovkur.Enabled := True;
         edt_Dovkur1.Enabled := True;
         edt_tutar_alacak.Enabled := true;
         edt_tutar_borc.Enabled := true;

         if IB_Edit8.Visible then IB_Edit8.Enabled := True;
         if IB_Edit10.Visible then IB_Edit10.Enabled := True;
         if IB_Edit11.Visible then IB_Edit11.Enabled := True;
         if IB_Edit12.Visible then IB_Edit12.Enabled := True;
         if IB_Edit13.Visible then IB_Edit13.Enabled := True;
         //edt_tutar_vpb.Enabled := true;
      end
  else
      begin
        btnYeni.Enabled := True;
        btnCikis.Enabled := true;
        btnAra.Enabled := True;
        btnKaydet.Enabled := False;
        btnIPTAL.Enabled := False;
        btnALACAKLI.Enabled := false;
        btnBORCLU.Enabled := false;
        //////////////////////////
        IB_Date1.Enabled := false;
        IB_Date4.Enabled := false;
        IB_Edit3.Enabled := false;
        ib_edit6.Enabled := false;
        //////////////////////////
        txt_Borclu_Kasa.Enabled := false;
        txt_Borclu_Kasa.Clear;
        txt_Alacakli_Kasa.Enabled := false;
        //////////////////////////////////
        edt_Dovkur.Enabled := false;
        edt_tutar_alacak.Enabled := false;
        edt_tutar_borc.Enabled := false;
        //edt_tutar_vpb.Enabled := false;
        edt_tutar_borc.Clear;
        edt_Dovkur1.Clear;
        edt_Dovkur1.Enabled := false;
        ///////////////////////////////////
        if IB_Edit8.Visible then IB_Edit8.Enabled := false;
        if IB_Edit10.Visible then IB_Edit10.Enabled := false;
        if IB_Edit11.Visible then IB_Edit11.Enabled := false;
        if IB_Edit12.Visible then IB_Edit12.Enabled := false;
        if IB_Edit13.Visible then IB_Edit13.Enabled := false;
        ////////////////////////////////////
        lbl_Borc_Kasa_Dov_Kod.Caption := '';
        Label6.Caption := '';
      end;
  end;
end;

procedure TfrmKasalarArasiTransfer.txt_Alacakli_KasaButtonClick(Sender: TObject);
var
 Kasa_Kod,Kasa_Ad,DOVKOD:String;
begin
  if DataMod.LS_KASA(Kasa_Kod,Kasa_Ad,DOVKOD) Then
    begin
      qryKASAHAR.FieldByName('KASA_KOD').AsString := Kasa_Kod;
      qryKASAHAR.FieldByName('DOVKOD').AsString := DOVKOD;
    end;
end;

procedure TfrmKasalarArasiTransfer.txt_Borclu_KasaButtonClick(Sender: TObject);
var
 Kasa_Kod,Kasa_Ad,DOVKOD:String;
begin
  if DataMod.LS_KASA(Kasa_Kod,Kasa_Ad,DOVKOD) Then
    begin
      txt_Borclu_Kasa.Text := Kasa_Kod;
      lbl_Borc_Kasa_Dov_Kod.Caption := DOVKOD;
    end;
end;

procedure TfrmKasalarArasiTransfer.btnALACAKLIClick(Sender: TObject);
var
  Kur : Currency;
begin
  if DataMod.LS_KASA(Kasa_Kod,Kasa_Ad,kasa_DOVKOD) Then
  begin
    qryKASAHAR.FieldByName('KASA_KOD').AsString := Kasa_Kod;
    qryKASAHAR.FieldByName('DOVKOD').AsString := Kasa_DOVKOD;
    qryKASAHAR.FieldByName('KASA_AD').AsString := Kasa_Ad;

    Kur := DataMod.Get_Doviz_Kur(kasa_DOVKOD,qryKASAHAR.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
    if Kur <> 0 then edt_Dovkur.Value := Kur else edt_Dovkur.Value := 1;
    edt_Dovkur.SetFocus;

    if Length(Trim(txt_Borclu_Kasa.Text)) = 0 then
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := '';
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := '';
    end
    else
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString +' dan '+txt_Borclu_Kasa.Text+' a transfer.';
      DataMod.CreateQuery(qryTEMP,nil,False,DataMod.dbaMain);
      //qryTemp := TIB_Query.Create(Self);
          {Lite
      with qryTemp do
      begin
        //IB_Connection := datamod.dbaMain;
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT K.MUHASKOD AS ALACAKLI_KASA_MUHASKOD, K1.MUHASKOD AS BORCLU_KASA_MUHASKOD');
        SQL.Add(' FROM KASA K,KASA K1');
        SQL.Add(' WHERE');
        SQL.Add(' (');
        SQL.Add('   (K.KASA_KOD =:PRM_ALACAKLI_KASA)');
        SQL.Add(' AND');
        SQL.Add('   (K1.KASA_KOD =:PRM_BORCLU_KASA)');
        SQL.Add(' )');
        ParamByName('PRM_ALACAKLI_KASA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString;
        ParamByName('PRM_BORCLU_KASA').AsString := txt_Borclu_Kasa.Text;
        Active := True;
      end;
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qryTemp.FieldByName('ALACAKLI_KASA_MUHASKOD').AsString +' dan '+qryTemp.FieldByName('BORCLU_KASA_MUHASKOD').AsString+' a transfer.';
      DataMod.ReleaseQuery(qryTemp);
      //qryTemp.Close;
      //qryTemp.Free;
      }
    end;

  end;
end;

procedure TfrmKasalarArasiTransfer.btnBORCLUClick(Sender: TObject);
var
 KUR : Currency;
begin
  if DataMod.LS_KASA(Kasa_Kod,Kasa_Ad,kasa_DOVKOD) Then
  begin
    txt_Borclu_Kasa.Text := Kasa_Kod;
    LABEL6.Caption := Kasa_Ad;
    lbl_Borc_Kasa_Dov_Kod.Caption := kasa_DOVKOD;
    KUR := DataMod.Get_Doviz_Kur(kasa_DOVKOD,qryKASAHAR.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
    if Kur <> 0 then edt_Dovkur1.Value := Kur else edt_Dovkur1.Value := 1;
    edt_Dovkur1.SetFocus;
    if Trim(qryKASAHAR.FieldByName('KASA_KOD').AsString) = '' then
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := '';
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := '';
    end
    else
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString +' dan '+txt_Borclu_Kasa.Text+' a transfer.';
      DataMod.CreateQuery(qryTemp,nil,False,DataMod.dbaMain);
          {Lite
      //qryTemp := TIB_Query.Create(Self);
      with qryTemp do
      begin
        //IB_Connection := datamod.dbaMain;
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT K.MUHASKOD AS ALACAKLI_KASA_MUHASKOD, K1.MUHASKOD AS BORCLU_KASA_MUHASKOD');
        SQL.Add(' FROM KASA K,KASA K1');
        SQL.Add(' WHERE');
        SQL.Add(' (');
        SQL.Add('   (K.KASA_KOD =:PRM_ALACAKLI_KASA)');
        SQL.Add(' AND');
        SQL.Add('   (K1.KASA_KOD =:PRM_BORCLU_KASA)');
        SQL.Add(' )');
        ParamByName('PRM_ALACAKLI_KASA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString;
        ParamByName('PRM_BORCLU_KASA').AsString := txt_Borclu_Kasa.Text;
        Active := True;
      end;
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qryTemp.FieldByName('ALACAKLI_KASA_MUHASKOD').AsString +' dan '+qryTemp.FieldByName('BORCLU_KASA_MUHASKOD').AsString+' a transfer.';
      DataMod.ReleaseQuery(qryTemp);
      if lbl_Borc_Kasa_Dov_Kod.Caption = glb_DEFCUR then
      begin
        edt_tutar_borc.Value := edt_tutar_vpb1.Value;
      end;
      //qryTemp.Close;
      //qryTemp.Free;
      }
    end;
  end;
end;

procedure TfrmKasalarArasiTransfer.txt_Alacakli_KasaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnALACAKLIClick(Self);
end;

procedure TfrmKasalarArasiTransfer.txt_Borclu_KasaKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnBORCLUClick(Self);
end;

procedure TfrmKasalarArasiTransfer.txt_Alacakli_KasaExit(Sender: TObject);
begin
  if Length(Trim(txt_Alacakli_Kasa.Text)) <> 0 then
  begin
    if glb_KASA_KISIT_UYG then
    begin
      if not DataMod.GET_KULLANICI_KASA_KOD(txt_Alacakli_Kasa.Text,KASA_AD) then
      begin
        txt_Alacakli_Kasa.SetFocus;
      end
      else
      begin
        qryKASAHAR.FieldByName('KASA_AD').AsString := KASA_AD;
        txt_Alacakli_Kasa.Color := clWindow;
      end;
    end
    else
    begin
      if not DataMod.GET_KASA_FROM_KASA_KOD(txt_Alacakli_Kasa.Text,KASA_AD,KASA_DOVKOD) then
      begin
        txt_Alacakli_Kasa.SetFocus;
      end
      else
      begin
        qryKASAHAR.FieldByName('KASA_AD').AsString := KASA_AD;
        txt_Alacakli_Kasa.Color := clWindow;
      end;
    end;
  end
  else
  begin
    if Length(Trim(txt_Borclu_Kasa.Text)) = 0 then
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := '';
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := '';
    end
    else
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString +' dan '+txt_Borclu_Kasa.Text+' a transfer.';
      DataMod.CreateQuery(qryTemp,nil,False,DataMod.dbaMain);
      //qryTemp := TIB_Query.Create(Self);
{Lite      with qryTemp do
      begin
        //IB_Connection := datamod.dbaMain;
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT K.MUHASKOD AS ALACAKLI_KASA_MUHASKOD, K1.MUHASKOD AS BORCLU_KASA_MUHASKOD');
        SQL.Add(' FROM KASA K,KASA K1');
        SQL.Add(' WHERE');
        SQL.Add(' (');
        SQL.Add('   (K.KASA_KOD =:PRM_ALACAKLI_KASA)');
        SQL.Add(' AND');
        SQL.Add('   (K1.KASA_KOD =:PRM_BORCLU_KASA)');
        SQL.Add(' )');
        ParamByName('PRM_ALACAKLI_KASA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString;
        ParamByName('PRM_BORCLU_KASA').AsString := txt_Borclu_Kasa.Text;
        Active := True;
      end;
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qryTemp.FieldByName('ALACAKLI_KASA_MUHASKOD').AsString +' dan '+qryTemp.FieldByName('BORCLU_KASA_MUHASKOD').AsString+' a transfer.';
      DataMod.ReleaseQuery(qryTemp);
      //qryTemp.Close;
      //qryTemp.Free;
}
    end;
    txt_Alacakli_Kasa.Color := clWindow;
  end;
end;

procedure TfrmKasalarArasiTransfer.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmKasalarArasiTransfer);
  with frmKasalarArasiTransfer.qryKASAHAR do
  begin
    FieldByName('TUTAR').DisplayFormat := glb_DOV_FIELD_PF;
    FieldByName('DOVKUR').DisplayFormat := glb_DOV_KUR_PF;
    FieldByName('TUTAR_VPB').DisplayFormat := glb_DOV_FIELD_PF;
  end;
  with frmKasalarArasiTransfer do
  begin
    edt_tutar_vpb.DisplayFormat := glb_DOV_FIELD_PF;
    edt_tutar_borc.DisplayFormat := glb_DOV_FIELD_PF;
    edt_Dovkur1.DisplayFormat := glb_DOV_KUR_PF;
  end;
end;

procedure TfrmKasalarArasiTransfer.txt_Borclu_KasaExit(Sender: TObject);
var
  KUR : Currency;
  strSQL : String;
begin
  if Length(Trim(txt_Borclu_Kasa.Text)) <> 0 then
  begin
    if glb_KASA_KISIT_UYG then
    begin
      strSQL := 'SELECT KASAHAK.KASA_KOD,KASA.ACIKLAMA,KASA.DOVKOD FROM KASA'
            + ' INNER JOIN KASAHAK ON (KASAHAK.KASA_KOD = KASA.KASA_KOD AND KASAHAK.KASA_SID = KASA.KASA_SID)'
            + ' WHERE KASAHAK.KULLANICI_ID = ' + inttostr(glb_USER_ID)
            + ' AND KASAHAK.KULLANICI_SID = ' + inttostr(glb_USER_SID)
            + ' AND KASAHAK.KASA_KOD = ' + SQL_Katar(txt_Borclu_Kasa.Text);
    end
    else
    begin
     strSQL := 'SELECT KASAHAK.KASA_KOD,KASA.ACIKLAMA,KASA.DOVKOD FROM KASA'
             + ' WHERE KASAHAK.KASA_KOD = ' + SQL_Katar(txt_Borclu_Kasa.Text);
    end;
    DataMod.CreateQuery(qryTemp,nil,False,DataMod.dbaMain);
    with qryTemp do
    begin
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;

    if qryTemp.RecordCount <> 0 then
    begin
      label6.Caption := qryTemp.FieldByName('ACIKLAMA').AsString;
      lbl_Borc_Kasa_Dov_Kod.Caption := qryTemp.FieldByName('DOVKOD').AsString;

      KUR := DataMod.Get_Doviz_Kur(qryTemp.FieldByName('DOVKOD').AsString,qryKASAHAR.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
      if Kur = 0 then
      begin
        edt_Dovkur1.Value := 1;
      end
      else
      begin
        if edt_Dovkur1.Value = 0 then
        begin
          edt_Dovkur1.Value := Kur;
        end;
      end;
      qryTemp.Active := False;
      txt_Borclu_Kasa.Color := clWindow;
      if Trim(qryKASAHAR.FieldByName('KASA_KOD').AsString) = '' then
      begin
        qryKASAHAR.FieldByName('ACIKLAMA').AsString := '';
        qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := '';
      end
      else
      begin
        qryKASAHAR.FieldByName('ACIKLAMA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString +' dan '+txt_Borclu_Kasa.Text+' a transfer.';
        {Lite
        with qryTemp do
        begin
          SQL.Clear;
          SQL.Add('SELECT K.MUHASKOD AS ALACAKLI_KASA_MUHASKOD, K1.MUHASKOD AS BORCLU_KASA_MUHASKOD');
          SQL.Add(' FROM KASA K,KASA K1');
          SQL.Add(' WHERE');
          SQL.Add(' (');
          SQL.Add('   (K.KASA_KOD =:PRM_ALACAKLI_KASA)');
          SQL.Add(' AND');
          SQL.Add('   (K1.KASA_KOD =:PRM_BORCLU_KASA)');
          SQL.Add(' )');
          ParamByName('PRM_ALACAKLI_KASA').AsString := qryKASAHAR.FieldByName('KASA_KOD').AsString;
          ParamByName('PRM_BORCLU_KASA').AsString := txt_Borclu_Kasa.Text;
          Active := True;
        end;
        qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qryTemp.FieldByName('ALACAKLI_KASA_MUHASKOD').AsString +' dan '+qryTemp.FieldByName('BORCLU_KASA_MUHASKOD').AsString+' a transfer.';
        DataMod.ReleaseQuery(qryTemp);
        if lbl_Borc_Kasa_Dov_Kod.Caption = glb_DEFCUR then
        begin
          edt_tutar_borc.Value := edt_tutar_vpb1.Value;
        end;
        //qryTemp.Close;
        //qryTemp.Free;
        }
      end;

    end

    else
    begin
      label6.Caption := '';
      lbl_Borc_Kasa_Dov_Kod.Caption := '';
      txt_Borclu_Kasa.SetFocus;
    end;
  end
  else
  begin
    if Trim(qryKASAHAR.FieldByName('KASA_KOD').AsString) = '' then
    begin
      qryKASAHAR.FieldByName('ACIKLAMA').AsString := '';
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := '';
    end;
    txt_Borclu_Kasa.Color := clWindow;
    edt_tutar_borc.Value := 0;
    label6.Caption := '';
    lbl_Borc_Kasa_Dov_Kod.Caption := '';
  end;
end;

procedure TfrmKasalarArasiTransfer.FormKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
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

procedure TfrmKasalarArasiTransfer.FormKeyPress(Sender: TObject;  var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
    if (ActiveControl as TWinControl).Name = 'btnALACAKLI' then
    begin
      SelectNext(ActiveControl as tWinControl, True, True );
    end
    else
    if (ActiveControl as TWinControl).Name = 'btnBORCLU' then
    begin
      SelectNext(ActiveControl as tWinControl, True, True );
    end;
  end;
  if key = #27 then
  begin
    if btnCikis.Enabled then btnCikisClick(Self);
  end;
end;

procedure TfrmKasalarArasiTransfer.IB_Edit1Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp := ActiveControl;
end;

procedure TfrmKasalarArasiTransfer.IB_Edit1Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKasalarArasiTransfer.btnKaydetClick(Sender: TObject);
begin
  Form_Post;
end;

procedure TfrmKasalarArasiTransfer.btnSilClick(Sender: TObject);
begin
  Form_Delete;
end;

procedure TfrmKasalarArasiTransfer.btnYeniClick(Sender: TObject);
begin
  DataSet_Open(0,0,0);
end;

procedure TfrmKasalarArasiTransfer.txt_Alacakli_KasaEnter(Sender: TObject);
begin
  txt_Alacakli_Kasa.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKasalarArasiTransfer.txt_Borclu_KasaEnter(Sender: TObject);
begin
  txt_Borclu_Kasa.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKasalarArasiTransfer.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if qryKASAHAR.State in [dssInsert,dssEdit] Then
  begin
    Application.MessageBox('Yaptýðýnýz iþlemi kaydetmeden ya da iptal etmeden formu kapatamazsýnýz.','DÝKKAT',MB_ICONINFORMATION);
    CanClose:= False;
  end;
end;

procedure TfrmKasalarArasiTransfer.txt_Alacakli_KasaKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure TfrmKasalarArasiTransfer.dtsKASAHARDataChange(Sender: TIB_StatementLink; Statement: TIB_Statement; Field: TIB_Column);
var
  Kur:Currency;
begin
  if  Assigned( Field ) Then
  begin
    if qryKASAHAR.FieldByName('TIP').AsString = 'C' then
    begin
      if Field.FieldName = 'DOVKOD' then
      begin
        KUR := DataMod.Get_Doviz_Kur(qryKASAHAR.FieldByName('DOVKOD').AsString,qryKASAHAR.FieldByName('DOV_BAZ_TAR').AsDate,glb_SATISKUR,PRV_ISN);
        if Kur = 0 then
        begin
          qryKASAHAR.FieldByName('DOVKUR').AsCurrency := 1;
        end
        else
        begin
          if qryKASAHAR.FieldByName('DOVKUR').AsCurrency = 0 then
          begin
            qryKASAHAR.FieldByName('DOVKUR').AsCurrency := Kur;
          end;
        end;
      end;
      if (Field.FieldName = 'TUTAR') or (Field.FieldName = 'DOVKUR') then
      begin
        qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency := qryKASAHAR.FieldByName('TUTAR').AsCurrency * qryKASAHAR.FieldByName('DOVKUR').AsCurrency ;
        qryKASAHAR.FieldByName('KASADEGER').AsCurrency := qryKASAHAR.FieldByName('TUTAR').AsCurrency;
      end;
    end;
  end;
end;

procedure TfrmKasalarArasiTransfer.btnAraClick(Sender: TObject);
var
  ISLEM_TIP,KASAHAR_ID,KASAHAR_SID:Integer;
  KASA_KOD,KASA_AD,KASA_DOVKOD:string;
begin
  if frmKasaSDGL.Form_Open(False,6, '',ISLEM_TIP,KASAHAR_ID,KASAHAR_SID,KASA_KOD,KASA_AD,KASA_DOVKOD) then
  begin
    Dataset_Open(KASAHAR_ID,KASAHAR_SID,1);
  end;
end;


procedure TfrmKasalarArasiTransfer.edt_Dovkur1Exit(Sender: TObject);
begin
  if (edt_Dovkur1.Value <= 0) then
  begin
    Showmessage('Borçlu kasanýn döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
    edt_Dovkur1.Value := 1;
    edt_Dovkur1.Color := clWindow;
    exit;
  end;
  edt_Dovkur1.Color := clWindow;
end;

procedure TfrmKasalarArasiTransfer.edt_Dovkur1Enter(Sender: TObject);
begin
  edt_Dovkur1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKasalarArasiTransfer.edt_tutar_borcEnter(Sender: TObject);
begin
  edt_tutar_borc.Color := glb_Art_Alan_Renk;
end;

procedure TfrmKasalarArasiTransfer.edt_tutar_borcExit(Sender: TObject);
begin
  edt_tutar_borc.Color := clWindow;
end;

procedure TfrmKasalarArasiTransfer.IB_Edit8ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama : String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure TfrmKasalarArasiTransfer.IB_Edit10ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama : String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure TfrmKasalarArasiTransfer.IB_Edit11ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama : String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure TfrmKasalarArasiTransfer.IB_Edit12ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama : String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure TfrmKasalarArasiTransfer.IB_Edit13ButtonClick(Sender: TObject);
var
  Muh_Kod,Aciklama : String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qryKASAHAR.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure TfrmKasalarArasiTransfer.IB_Edit8Exit(Sender: TObject);
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

procedure TfrmKasalarArasiTransfer.IB_Edit10Exit(Sender: TObject);
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

procedure TfrmKasalarArasiTransfer.IB_Edit11Exit(Sender: TObject);
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

procedure TfrmKasalarArasiTransfer.IB_Edit12Exit(Sender: TObject);
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

procedure TfrmKasalarArasiTransfer.IB_Edit13Exit(Sender: TObject);
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


procedure TfrmKasalarArasiTransfer.IB_Edit8KeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit8ButtonClick(Self);
end;

procedure TfrmKasalarArasiTransfer.IB_Edit10KeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit10ButtonClick(Self);
end;

procedure TfrmKasalarArasiTransfer.IB_Edit11KeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit11ButtonClick(Self);
end;

procedure TfrmKasalarArasiTransfer.IB_Edit12KeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit12ButtonClick(Self);
end;

procedure TfrmKasalarArasiTransfer.IB_Edit13KeyUp(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit13ButtonClick(Self);
end;

procedure TfrmKasalarArasiTransfer.IB_Edit3Exit(Sender: TObject);
begin
  if qryKASAHAR.State in [dssInsert] then
  begin
    if Trim(qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString) = '' then
    begin
      qryKASAHAR.FieldByName('YEVMIYE_ACK').AsString := qryKASAHAR.FieldByName('ACIKLAMA').AsString;
    end;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

function TfrmKasalarArasiTransfer.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryKASAHAR.FieldByName('TARIH').AsDate,True) then Exit;
  Result := True;
end;

procedure TfrmKasalarArasiTransfer.Form_Delete;
var
  KASAHAR_ID,KASAHAR_SID:Integer;
begin
  if not Form_Before_Delete then exit;
  if Application.MessageBox('Üzerinde bulunduðunuz kaydý gerçekten silmek istiyor musunuz.','Dikkat',MB_YESNO) = IDNO then Exit;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if trnTRANSFER.InTransaction then
     trnTRANSFER.Rollback;
  trnTRANSFER.StartTransaction;
//****************************************************************************//
  try
//****************************************************************************//
    KASAHAR_ID := qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger;
    KASAHAR_SID := qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger;
//****************************************************************************//
    qryKASAHAR.Delete;
    qryKASAHAR.Delete;
    qryKASAHAR.ApplyUpdates;
    qryKASAHAR.CommitUpdates;
////////////////////////////////////////////////////////////////////////////////
    dmLOGGER.dbaMain_StopMonitoringWrite2log('KASAHAR,',
                                             BT_KASA,
                                             KASAHAR_ID,
                                             KASAHAR_SID,
                                             1,2,'');
////////////////////////////////////////////////////////////////////////////////
    trnTRANSFER.Commit;
    btnSil.Enabled := false;
  except;
    trnTRANSFER.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise;
  end;
end;


function TfrmKasalarArasiTransfer.Form_Before_Post: Boolean;
begin
  Result := False;
  //burada daha önceden query içerisine data atýldýðý için
  //before post kontrol hata vermeyecektir fakat asýl datalar form üzerindedir,
  //bu yüzden form üzerindeki componentlerin içeriklerini kontrol etmek gerekmektedir.
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Length(Trim(txt_Alacakli_Kasa.Text)) = 0 then
  begin
    txt_Alacakli_Kasa.SetFocus;
    Application.MessageBox('Lütfen Alacaklý Kasa seçimi yapýnýz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;
  if Length(Trim(txt_Borclu_Kasa.Text)) = 0 then
  begin
    txt_Borclu_Kasa.SetFocus;
    Application.MessageBox('Lütfen Borçlu Kasa seçimi yapýnýz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;
  if (Trim(txt_Borclu_Kasa.Text)=Trim(txt_Alacakli_Kasa.Text)) then
  begin
    txt_Borclu_Kasa.SetFocus;
    Application.MessageBox('Seçilen kasalar birbiriyle ayný olamaz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;
  if edt_Dovkur.Value <= 0 then
  begin
    edt_Dovkur.SetFocus;
    Application.MessageBox('Alacaklý Kasanýn Döviz Kurunu sýfýra eþit yada küçük olamaz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;
  if edt_Dovkur1.Value <= 0 then
  begin
    edt_Dovkur1.SetFocus;
    Application.MessageBox('Borçlu Kasanýn Döviz Kuru sýfýra eþit yada küçük olamaz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;
  if edt_tutar_alacak.Value <= 0 then
  begin
    edt_tutar_alacak.SetFocus;
    Application.MessageBox('Alacaklý Kasa Tutarý sýfýra eþit yada küçük olamaz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;
  if edt_tutar_borc.Value <= 0 then
  begin
    edt_tutar_borc.SetFocus;
    Application.MessageBox('Borçlu Kasa Tutarý sýfýra eþit yada küçük olamaz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;

  if edt_tutar_vpb.Value <= 0 then
  begin
    edt_tutar_borc.SetFocus;
    Application.MessageBox('Borçlu Kasa Tutarý sýfýra eþit yada küçük olamaz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;

  if edt_tutar_vpb1.Value <= 0 then
  begin
    edt_tutar_alacak.SetFocus;
    Application.MessageBox('Alacaklý Kasa Tutarý sýfýra eþit yada küçük olamaz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;

  if (qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency > edt_tutar_vpb.Value) then
  begin
    if (qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency - edt_tutar_vpb.Value) >= 0.01 then
    begin
      Application.MessageBox('TUTAR_VPB deðerleri birbirini tutmuyor.Lütfen kontrol ediniz..!!','Dikkat',MB_ICONEXCLAMATION);
      exit;
    end;
  end
  else
  if (qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency < edt_tutar_vpb.Value) then
  begin
    if (edt_tutar_vpb.Value - qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency) >= 0.01 then
    begin
      Application.MessageBox('TUTAR_VPB deðerleri birbirini tutmuyor.Lütfen kontrol ediniz..!!','Dikkat',MB_ICONEXCLAMATION);
      exit;
    end;
  end;

{
  if (qryKASAHAR.FieldByName('TUTAR_VPB').AsCurrency <> edt_tutar_vpb.Value) then
  begin
    Application.MessageBox('TUTAR_VPB deðerleri birbirini tutmuyor.Lütfen kontrol ediniz..!!','Dikkat',MB_ICONEXCLAMATION);
    exit;
  end;
}

  if not DataMod.EN_GER_KAY_TAR_KONTROL(qryKASAHAR.FieldByName('TARIH').AsDate,True) then Exit;
  if not DataMod.IsDateInTerm(qryKASAHAR.FieldByName('TARIH').AsDate, 'Ýþlem Tarihi') then Exit;
  if not DataMod.IsDateInTerm(qryKASAHAR.FieldByName('DOV_BAZ_TAR').AsDate, 'Döviz Baz Tarihi') then Exit;
  Result := True;
end;

procedure TfrmKasalarArasiTransfer.Form_Post;
var
  DOVKUR,TUTAR : Currency;
  alacakli_kasa_tarih,alacakli_kasa_dov_baz_tar:TDate;
  alacakli_kasa_dov_kod,
  alacakli_kasa_aciklama,
  alacakli_kasa_yev_aciklama,
  alacakli_kasa_kod,
  borclu_kasa_kod,
  borclu_kasa_dovkod,
  borclu_kasa_ad : String;
begin
  if not Form_Before_Post then
  begin
    dmLOGGER.dbaMain_CancelMonitoring;
    exit;
  end;
//****************************************************************************//
  if not dmLOGGER.dbaMain_StartMonitoring then Exit;
//****************************************************************************//
  if trnTRANSFER.InTransaction then
     trnTRANSFER.Rollback;
  trnTRANSFER.StartTransaction;
//****************************************************************************//
  prnBELGEID := qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger;
  prnBELGESID := qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger;
//****************************************************************************//
  try
    with qryKASAHAR do
    begin
      DisableControls;
      //Alacaklý Kasa Update Fields --start
      FieldByName('KARSIKOD').AsString := txt_Borclu_Kasa.Text;
      alacakli_kasa_kod := FieldByName('KASA_KOD').AsString;
      alacakli_kasa_dov_kod := FieldByName('DOVKOD').AsString;
      alacakli_kasa_aciklama := FieldByName('ACIKLAMA').AsString;
      alacakli_kasa_yev_aciklama := FieldByName('YEVMIYE_ACK').AsString;
      alacakli_kasa_tarih := FieldByName('TARIH').AsDate;
      alacakli_kasa_dov_baz_tar := FieldByName('DOV_BAZ_TAR').AsDate;
      borclu_kasa_dovkod := lbl_Borc_Kasa_Dov_Kod.Caption;
      borclu_kasa_ad := Label6.Caption;
      ////////////////////////////////////////////////////////////////////////
      DOVKUR := edt_Dovkur1.Value;
      TUTAR := edt_tutar_borc.Value;
      //Alacaklý Kasa Update Fields --stop
      ////////////////////////////////////////////////////////////////////////
      //qryKASAHAR.ApplyUpdates;
      //Update;
      Next;
      //Borçlu Kasa Update Fields --start
      FieldByName('KASA_KOD').AsString := txt_Borclu_Kasa.Text;
      borclu_kasa_kod := FieldByName('KASA_KOD').AsString;
      FieldByName('KARSIKOD').AsString := alacakli_kasa_kod;
      FieldByName('TARIH').AsDate := alacakli_kasa_tarih;
      FieldByName('DOV_BAZ_TAR').AsDate := alacakli_kasa_dov_baz_tar;
      FieldByName('ACIKLAMA').AsString := alacakli_kasa_aciklama;
      FieldByName('YEVMIYE_ACK').AsString := alacakli_kasa_yev_aciklama;
      FieldByName('DOVKUR').AsCurrency := edt_Dovkur1.Value;
      FieldByName('DOVKOD').AsString := borclu_kasa_dovkod;
      FieldByName('TUTAR').AsCurrency := edt_tutar_borc.Value;
      FieldByName('TUTAR_VPB').AsCurrency := edt_tutar_vpb.Value;
      ////////////////////////////////////////////////////////////////////////
      FieldByName('KASADEGER').AsCurrency := edt_tutar_borc.Value;
      //qryKASAHAR.ApplyUpdates;
      Prior;
      EnableControls;
    end;


    qryKASAHAR.ApplyUpdates;
    qryKASAHAR.CommitUpdates;
//****************************************************************************//
    dmLOGGER.dbaMain_StopMonitoringWrite2log('KASAHAR,',
                                             BT_KASA,
                                             qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger,
                                             qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger,
                                             1,1,'');
//****************************************************************************//
    trnTRANSFER.Commit;
//****************************************************************************//
    if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(144)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,144,14,4,rgYAZICI.ItemIndex,prnBELGEID,prnBELGESID,0,'');
  end
  else

    Yazici.KASATRANSFER(prnBELGEID,prnBELGESID,rgYAZICI.ItemIndex);
    prnBELGEID := 0;
    prnBELGESID := 0;
//****************************************************************************//
  except
    trnTRANSFER.RollbackRetaining;
    dmLOGGER.dbaMain_CancelMonitoring;
    raise; {raise the exception to prevent a call to CommitUpdates!}
  end;
  qryKASAHAR.Close;
  btnSil.Enabled := False;
end;

procedure TfrmKasalarArasiTransfer.edt_DovkurExit(Sender: TObject);
begin
  if (edt_Dovkur.Value <= 0) then
  begin
    Showmessage('Alacaklý kasanýn döviz kuru sýfýra eþit yada sýfýrdan küçük olamaz.Lütfen kontrol ediniz.');
    edt_Dovkur.Value := 1;
    exit;
  end;
  my_Active_Comp.Brush.Color := clWindow;
end;

procedure TfrmKasalarArasiTransfer.btnCiktiClick(Sender: TObject);
begin
  if Application.MessageBox('Kaydýn çýktýsýný almak istiyor musunuz?','Dikkat',MB_ICONQUESTION+MB_YESNO)=7 then exit;
  if rgYAZICI.ItemIndex < 2 then
  if Dm_Fast_Report.Yeni_Rapor_Varmi(144)>0 then
  begin
       Dm_Fast_Report.Rapor_Ac(0,144,14,4,rgYAZICI.ItemIndex,prnBELGEID,prnBELGESID,0,'');
  end
  else

  Yazici.KASATRANSFER(prnBELGEID,prnBELGESID,rgYAZICI.ItemIndex);
end;

end.
