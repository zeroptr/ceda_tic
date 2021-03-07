unit ufrm_Kantar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, StdCtrls, Buttons, ExtCtrls, Mask, IB_Controls,
  frxClass, frxIBOSet, Grids, IB_Grid;


type
  Tfrm_Kantar = class(TForm)
    Panel1: TPanel;
    qry_Kantar: TIB_Query;
    DtsKantar: TIB_DataSource;
    IB_Edit14: TIB_Edit;
    IB_Edit15: TIB_Edit;
    IB_Edit16: TIB_Edit;
    Panel2: TPanel;
    btnYeni: TBitBtn;
    btnKaydet: TButton;
    btnIPTAL: TButton;
    btnSil: TButton;
    btnAra: TBitBtn;
    btnCikis: TBitBtn;
    BtnYazdir: TBitBtn;
    Memo1: TMemo;
    frxReport1: TfrxReport;
    frxIBOKantar_Fisi: TfrxIBODataset;
    Pnl_Giris: TPanel;
    txtPlaka_No: TIB_Edit;
    txtCari_Kod: TIB_Edit;
    IB_Edit3: TIB_Edit;
    txtUrun_Kod: TIB_Edit;
    IB_Edit5: TIB_Edit;
    IB_Edit10: TIB_Edit;
    IB_Edit11: TIB_Edit;
    IB_Date1: TIB_Date;
    IB_ComboBox1: TIB_ComboBox;
    IB_Edit2: TIB_Edit;
    Btn_Giris_Kilo: TBitBtn;
    Cb_Geldigi_Yer: TIB_ComboBox;
    Cb_Gittigi_Yer: TIB_ComboBox;
    Cb_Aciklama: TIB_ComboBox;
    Btn_Onceki: TButton;
    Btn_Sonraki: TButton;
    IB_Date4: TIB_Date;
    Btn_Cikis_Yap: TBitBtn;
    IB_Grid1: TIB_Grid;
    IB_Grid2: TIB_Grid;
    Dts_Cikanlar: TIB_DataSource;
    Qry_Cikanlar: TIB_Query;
    grpRapKod: TGroupBox;
    IB_Edit1: TIB_Edit;
    IB_Edit6: TIB_Edit;
    IB_Edit7: TIB_Edit;
    IB_Edit24: TIB_Edit;
    IB_Edit25: TIB_Edit;
    txtKasaKod: TIB_Edit;
    txtKasaAd: TIB_Edit;
    Splitter1: TSplitter;
    IB_Query1: TIB_Query;
    Btn_Giris_Yaz: TBitBtn;
    Btn_Degistir: TBitBtn;
    Pnl_Cikis: TPanel;
    IB_Edit12: TIB_Edit;
    IB_Edit13: TIB_Edit;
    IB_Date3: TIB_Date;
    IB_Edit4: TIB_Edit;
    Btn_Cikis_Kilo: TBitBtn;
    IB_Date2: TIB_Date;
    Dts_Girenler: TIB_DataSource;
    Qry_Girenler: TIB_Query;
    SpeedButton1: TSpeedButton;
    procedure Form_Open(Gc: Boolean; KANTAR_NO: Integer; ISLEM: Byte);
    procedure DataSet_Open(KANTAR_NO:Integer; ISLEM: Byte);
    procedure FormatDisplays;



    procedure txtUrun_KodButtonClick(Sender: TObject);
    procedure txtCari_KodButtonClick(Sender: TObject);
    procedure txtCari_KodExit(Sender: TObject);
    procedure txtUrun_KodExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCikisClick(Sender: TObject);
    procedure btnAraClick(Sender: TObject);
    procedure btnYeniClick(Sender: TObject);
    procedure btnKaydetClick(Sender: TObject);
    procedure btnIPTALClick(Sender: TObject);
    procedure btnSilClick(Sender: TObject);
    procedure txtCari_KodEnter(Sender: TObject);
    procedure txtUrun_KodEnter(Sender: TObject);
    procedure txtPlaka_NoKeyPress(Sender: TObject; var Key: Char);
    procedure txtCari_KodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtUrun_KodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtPlaka_NoEnter(Sender: TObject);
    procedure txtPlaka_NoExit(Sender: TObject);
    procedure qry_KantarAfterInsert(IB_Dataset: TIB_Dataset);
    procedure BtnYazdirClick(Sender: TObject);
    procedure DtsKantarStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
    procedure txtKasaKodButtonClick(Sender: TObject);
    procedure txtKasaKodExit(Sender: TObject);
    procedure txtKasaKodEnter(Sender: TObject);
    procedure txtKasaKodKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure txtPlaka_NoButtonClick(Sender: TObject);
    procedure IB_Edit14Exit(Sender: TObject);
    procedure IB_Edit14Enter(Sender: TObject);
    procedure IB_ComboBox1Enter(Sender: TObject);
    procedure IB_ComboBox1Exit(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure IB_Edit1ButtonClick(Sender: TObject);
    procedure IB_Edit6ButtonClick(Sender: TObject);
    procedure IB_Edit7ButtonClick(Sender: TObject);
    procedure IB_Edit24ButtonClick(Sender: TObject);
    procedure IB_Edit25ButtonClick(Sender: TObject);
    procedure IB_Edit1Exit(Sender: TObject);
    procedure IB_Edit6Exit(Sender: TObject);
    procedure IB_Edit7Exit(Sender: TObject);
    procedure IB_Edit24Exit(Sender: TObject);
    procedure IB_Edit25Exit(Sender: TObject);
    procedure IB_Edit1Enter(Sender: TObject);
    procedure IB_Edit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IB_Edit6Enter(Sender: TObject);
    procedure IB_Edit7Enter(Sender: TObject);
    procedure IB_Edit24Enter(Sender: TObject);
    procedure IB_Edit25Enter(Sender: TObject);
    procedure IB_Edit6KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IB_Edit7KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IB_Edit24KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IB_Edit25KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DtsKantarDataChange(Sender: TIB_StatementLink;
      Statement: TIB_Statement; Field: TIB_Column);
    procedure Btn_SonrakiClick(Sender: TObject);
    procedure Btn_OncekiClick(Sender: TObject);
    procedure Btn_Cikis_YapClick(Sender: TObject);
    procedure qry_KantarBeforePost(IB_Dataset: TIB_Dataset);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Btn_DegistirClick(Sender: TObject);
    procedure Qry_GirenlerAfterScroll(IB_Dataset: TIB_Dataset);
    procedure Qry_CikanlarAfterScroll(IB_Dataset: TIB_Dataset);
    procedure SpeedButton1Click(Sender: TObject);

  private
    Prv_Yazdirildi:Boolean;
    prv_CanUpdate,prv_CanDelete:Boolean;
    prv_KANTAR_NO:Integer;
    prv_BELGE_TUR:Integer;
    prv_Gc:Boolean;
    my_Active_Comp:TWinControl;
    Muh_Kod,Aciklama:String;
    prv_ISN:Integer;
    res_Cari : TStringList;
    
    function Form_Before_Delete: Boolean;
    function Form_Before_Post: Boolean;
    function Kantar_no_Al(KANTAR_SAYAC: INTEGER): String;
    procedure Kayitli_Deg_Al;
    procedure Geri_AL;
    procedure Kantar_Sql_Yenile;

    { Private declarations }
  public
    { Public declarations }
  end;


  const cns_kantar=31;

var
  frm_Kantar: Tfrm_Kantar;

implementation

uses unDataMod, ufrmUrunSDLG, ufrmCariSDLG, main, ufrm_Kantar_Sdlg,unFunc,
  unLogger, ufrmRaporCiktisi, ufrm_Kantar_Cikis, ufrm_Kantar_Degistir;

{$R *.dfm}




procedure Tfrm_Kantar.Kayitli_Deg_Al;
var
  qryDeg:TIB_Query;
begin
        DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT GELDIGI_YER FROM KANTAR';
        qryDeg.Open;
        Cb_Geldigi_Yer.Items.Clear;
        While not qryDeg.Eof do
        begin
            Cb_Geldigi_Yer.Items.Add(qryDeg.FieldByName('GELDIGI_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT GITTIGI_YER FROM KANTAR';
        qryDeg.Open;
        Cb_Gittigi_Yer.Items.Clear;
        While not qryDeg.Eof do
        begin
            Cb_Gittigi_Yer.Items.Add(qryDeg.FieldByName('GITTIGI_YER').asString);
            qryDeg.Next;
        end;

        qryDeg.Active:=False;
        qryDeg.SQL.Clear;
        qryDeg.SQL.Text:='SELECT DISTINCT ACIKLAMA FROM KANTAR';
        qryDeg.Open;
        Cb_Aciklama.Items.Clear;
        While not qryDeg.Eof do
        begin
            Cb_Aciklama.Items.Add(qryDeg.FieldByName('ACIKLAMA').asString);
            qryDeg.Next;
        end;


end;

procedure Tfrm_Kantar.Form_Open(Gc:Boolean;KANTAR_NO:Integer;ISLEM:Byte);
var
  local_can_update,local_can_delete:Boolean;
begin

  if not DataMod.Modul_Hak(cns_kantar,local_can_update,local_can_delete) then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if ((ISLEM = 0) and (local_can_update = False)) then
    begin
      Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;

//****************************************************************************//
  if not MainForm.FindChildFrm( Application, 'frm_Kantar') then
  begin
    Application.CreateForm (Tfrm_Kantar,frm_Kantar);
    frm_Kantar.prv_CanUpdate := local_can_update;
    frm_Kantar.prv_CanDelete := local_can_delete;
    frm_Kantar.prv_Gc:=Gc;
    if  frm_Kantar.prv_Gc then
    begin
    frm_Kantar.Caption:='Kantar Giriþ';
    frm_Kantar.Pnl_Cikis.Visible:=False;

    end
    else
    begin

    frm_Kantar.Caption:='Kantar Çýkýþ';

    frm_Kantar.Pnl_Cikis.Visible:=True;
    end;
  end
  else
  begin
    Application.MessageBox('Kantar formu açýk.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
//****************************************************************************//
  frm_Kantar.DataSet_Open(KANTAR_NO,Islem);
end;


Procedure Tfrm_Kantar.FormatDisplays;
begin
  with frm_Kantar.qry_Kantar do
  begin
    FieldByName('ARAC_KILO').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('GIRIS_KILO').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('UCRETI').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('CIKIS_KILO').DisplayFormat := glb_VPB_FIELD_PF;
    FieldByName('FARK_KILO').DisplayFormat := glb_VPB_FIELD_PF;
  end;
end;

procedure Tfrm_Kantar.DataSet_Open(KANTAR_NO:Integer;ISLEM:Byte);
begin
  if ((ISLEM = 0) and (prv_CanUpdate = False)) then
  begin
    Application.MessageBox('Bu modülde yeni kayýt yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  with frm_Kantar do
  begin

    DataMod.Rapor_Kod_Visible_Fields_IB('FAT',ib_edit1,ib_edit6,ib_edit7,ib_edit24,ib_edit25);
    prv_ISN := DataMod.Get_Isn_Num;


    with Qry_Girenler do
    begin
      Active := False;
      Active := True;
    end;

   { with qry_Kantar do
    begin
      Active := False;
      //ParambyName('PRM_KANTAR_SID').AsInteger := Glb_SID;
      //WHERE KANTAR_SID=:PRM_KANTAR_SID AND KANTAR_NO=:PRM_KANTAR_NO
 //     ParambyName('PRM_KANTAR_NO').AsInteger := KANTAR_NO;
      Active := True;
    end;
   }
    with Qry_Cikanlar do
    begin
      Active := False;
      Active := True;
    end;

//****************************************************************************//
    prv_KANTAR_NO := KANTAR_NO;
//****************************************************************************//
   { case Islem of
    0:
      begin
        qry_Kantar.Insert;
      end;
    1:
      begin
        qry_Kantar.Edit;
        if frm_Kantar.prv_Gc=False then
        if qry_Kantar.FieldByName('TIPI').AsString='G' then
        qry_Kantar.FieldByName('TIPI').AsString:='C';


      end;
    end;
}
  end;//with
  FormatDisplays;
  Kayitli_Deg_Al;
end;



procedure Tfrm_Kantar.txtUrun_KodButtonClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad:String;
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmUrunSDLG.Form_Open(False,Urun_Kod,Urun_AD,True) then
  begin
    qry_Kantar.FieldByName('URUN_KOD').AsString := Urun_Kod;
    qry_Kantar.FieldByName('URUN_AD').AsString := Urun_Ad;
  end;
end;

procedure Tfrm_Kantar.txtCari_KodButtonClick(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      qry_Kantar.FieldByName('CARI_KOD').AsString := Cari_KOD;
      qry_Kantar.FieldByName('CARI_AD').AsString := Cari_AD;
  end;
end;

procedure Tfrm_Kantar.txtCari_KodExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txtCari_Kod.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txtCari_Kod.Text,CARI_AD) then
    begin
      qry_Kantar.FieldByName('CARI_AD').AsString := CARI_AD;
      (Sender as TIB_Edit).Color := clWindow;
    end
    else
    begin
      txtCari_Kod.SetFocus;
    end;
  end
  else
  begin
    (Sender as TIB_Edit).Color := clWindow;
    qry_Kantar.FieldByName('CARI_AD').AsString := '';
  end;
end;

procedure Tfrm_Kantar.txtUrun_KodExit(Sender: TObject);
var
  Kissas,Urun_Ad:String;
begin
  if Length(Trim(txtUrun_Kod.Text))=0 then
  begin
    txtUrun_Kod.Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('URUN','URUN_KOD','URUN_AD',txtUrun_Kod.Text,Urun_Ad) then
  begin
    Application.MessageBox('Ürün Kodu Bulunamadý.Lütfen listeden seçiniz','Dikkat',MB_ICONWARNING);
    qry_Kantar.FieldByName('URUN_AD').AsString := '';
    txtUrun_Kod.Clear;
    txtUrun_Kod.SetFocus;
  end
  else
  begin
    qry_Kantar.FieldByName('URUN_AD').AsString := Urun_Ad;
    txtUrun_Kod.Color := clWindow;
    exit;
  end;
end;

procedure Tfrm_Kantar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure Tfrm_Kantar.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if qry_Kantar.State in [dssEDIT,dssINSERT] Then
  begin
    Application.MessageBox('Kantar bilgileri bölümünde yaptýðýnýz deðiþiklikleri kaydediniz veya iptal ediniz.','DÝKKAT',MB_ICONWARNING);
    CanClose := False;
  end;
end;

procedure Tfrm_Kantar.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frm_Kantar);
  res_Cari:=TStringList.Create;  
end;

procedure Tfrm_Kantar.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure Tfrm_Kantar.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure Tfrm_Kantar.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_Kantar.btnAraClick(Sender: TObject);
var
  KANTAR_NO:Integer;
begin
  if frm_Kantar_Sdlg.Form_Open(prv_Gc,KANTAR_NO,False) then
  begin
    DataSet_Open(KANTAR_NO,1);
  end;
end;

procedure Tfrm_Kantar.btnYeniClick(Sender: TObject);
begin
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde yeni Giriþ tanýmlama yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  //DataSet_Open(0,1);

  if Btn_Degistir.Visible then
  Kantar_Sql_Yenile;

  qry_Kantar.Append;

end;


function Tfrm_Kantar.Form_Before_Post: Boolean;
begin
  Result := False;
  if not prv_CanUpdate then
  begin
    Application.MessageBox('Bu modülde deðiþiklik yapma yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  Result := True;
end;


procedure Tfrm_Kantar.btnKaydetClick(Sender: TObject);
begin
  try
    if not Form_Before_Post then
    begin
      dmLOGGER.dbaMain_CancelMonitoring;
      exit;
    end;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Kantar.Post;

      dmLOGGER.dbaMain_StopMonitoringWrite2log('KANTAR',0,0,0,0,1,'KANTAR');
    end;
      Kayitli_Deg_Al;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;

  if Btn_Degistir.Visible then
  Kantar_Sql_Yenile;

end;

procedure Tfrm_Kantar.btnIPTALClick(Sender: TObject);
begin

  qry_Kantar.Cancel;
  dmLOGGER.dbaMain_CancelMonitoring;
  if Btn_Degistir.Visible then
  Kantar_Sql_Yenile;  
end;


function Tfrm_Kantar.Form_Before_Delete: Boolean;
begin
  Result := False;
  if not prv_CanDelete then
  begin
    Application.MessageBox('Bu modülde silme yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;

  if Application.MessageBox('Kaydý silmek istiyor musunuz ?','Dikkat',MB_OKCANCEL + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDCANCEL then Exit;

  Result := True;
end;


procedure Tfrm_Kantar.btnSilClick(Sender: TObject);
begin
  try
    if not Form_Before_Delete then exit;
    if dmLOGGER.dbaMain_StartMonitoring then
    begin
      qry_Kantar.Delete;
      dmLOGGER.dbaMain_StopMonitoringWrite2log('KANTAR',0,0,0,0,2,'KANTAR');
    end;
  except
    dmLOGGER.dbaMain_CancelMonitoring;
  end;
end;

procedure Tfrm_Kantar.txtCari_KodEnter(Sender: TObject);
begin
  txtCari_Kod.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.txtUrun_KodEnter(Sender: TObject);
begin
  txtUrun_Kod.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.txtPlaka_NoKeyPress(Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) then Key := toUpper(Key);
end;

procedure Tfrm_Kantar.txtCari_KodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txtCari_KodButtonClick(Self);
end;

procedure Tfrm_Kantar.txtUrun_KodKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 Then txtUrun_KodButtonClick(Self);
end;

procedure Tfrm_Kantar.txtPlaka_NoEnter(Sender: TObject);
begin
  txtPlaka_No.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.txtPlaka_NoExit(Sender: TObject);
var
  CARI_KOD:String;
begin
  if Length(Trim(txtPlaka_No.Text))=0 then
  begin
    txtPlaka_No.Color := clWindow;
    exit;
  end;

  if Trim(txtPlaka_No.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('PLAKA','PLAKA_NO','CARI_KOD',txtPlaka_No.Text,CARI_KOD) then
    begin
      qry_Kantar.FieldByName('CARI_KOD').AsString := CARI_KOD;
      txtPlaka_No.Color := clWindow;
      txtCari_Kod.SetFocus;
    end
    else
    begin
      txtPlaka_No.SetFocus;
    end;
  end
  else
  begin
    txtUrun_Kod.Color := clWindow;
    qry_Kantar.FieldByName('CARI_KOD').AsString := '';
    qry_Kantar.FieldByName('PLAKA_NO').AsString := '';
  end;
//  my_Active_Comp.Brush.Color := clWindow;
end;

procedure Tfrm_Kantar.qry_KantarAfterInsert(IB_Dataset: TIB_Dataset);
begin
  with qry_Kantar do
  begin
    FieldByName('KANTAR_SID').AsInteger := Glb_SID;
    {if prv_Gc then
    FieldByName('TIPI').AsString := 'G'
    else
    FieldByName('TIPI').AsString := 'C';
    }

    FieldByName('TIPI').AsString := 'G';
    FieldByName('GIRIS_TARIHI').AsDateTime := Date;
    FieldByName('GIRIS_SAATI').AsDateTime := Time;
    FieldByName('ARAC_KILO').AsFloat := 0;
    FieldByName('GIRIS_KILO').AsFloat := 0;
    FieldByName('CIKIS_KILO').AsFloat := 0;
    FieldByName('FARK_KILO').AsFloat := 0;

    FieldByName('KANTAR_NO').AsInteger := qry_Kantar.Gen_ID('GEN_KANTAR_NO',1);

    FieldByName('MAKBUZ_NO').AsString := Kantar_no_Al(FieldByName('KANTAR_NO').AsInteger);
  end;
  txtPlaka_No.SetFocus;
  
  if Btn_Degistir.Visible then
  Pnl_Cikis.Visible:=False;

end;

function Tfrm_Kantar.Kantar_no_Al(KANTAR_SAYAC:INTEGER):String;
begin
  Result := DataMod.Kod_Format(KANTAR_SAYAC,TRIM(DataMod.GetParam(cns_Kantar,'PRE_KOD',0)),'',glb_SID,StrToInt(DataMod.GetParam(cns_Kantar,'KOD_LENGTH',0)));
end;


procedure Tfrm_Kantar.BtnYazdirClick(Sender: TObject);
var
  row,col : integer;
begin

    if Sender=BtnYazdir then
    with IB_Query1 do
    begin
      Active := False;
      ParamByName('PRM_KANTAR_NO').AsInteger:=Qry_Cikanlar.FieldByName('KANTAR_NO').AsInteger;
      Active := True;
    end;

    if Sender=Btn_Giris_Yaz then
    with IB_Query1 do
    begin
      Active := False;
      ParamByName('PRM_KANTAR_NO').AsInteger:=qry_Kantar.FieldByName('KANTAR_NO').AsInteger;
      Active := True;
    end;


  if not IB_Query1.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;

  if IB_Query1.RecordCount = 0 then
  begin
    Application.MessageBox('Yapmýþ olduðunuz aramada hiçbir kayýda ulaþýlamadý.Lütfen kriterleri kontrol ediniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  row := 0;
  col := 0;



  Prv_Yazdirildi:=False;
//  if qry_Kantar.FieldByName('TIPI').AsString='G' then
  if Sender=Btn_Giris_Yaz then
  frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kantar_Giris_Fis.fr3');

//  if qry_Kantar.FieldByName('TIPI').AsString='C' then
  if Sender=BtnYazdir then
  frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kantar_Cikis_Fis.fr3');

  frxReport1.showReport;
  Exit;
////////////////////////////////////////////////////////////////////////////////
  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    SetCellText(row,col,qry_Kantar.FieldByName('MAKBUZ_NO').AsString+ ' nolu Kantar Fiþi  ');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    inc(row);
    col:=0;
    SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
{    if chkCARI.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Cari Kod : '+ lbl_CARIKOD.Caption+' - Cari Ad : '+lbl_CARI.Caption);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;

    if ((dtpIslemTar.Checked) and (dtpIslemTar2.Checked)) then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + (DateToStr(dtpIslemTar.Date)+' > - < '+DateToStr(dtpIslemTar2.Date)));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end
    else
    if dtpIslemTar2.Checked then
    begin
      inc(row);
      col := 0;
      SetCellText(row,col,'Ýþlem Tarihi : ' + DateToStr(dtpIslemTar2.Date));
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
    end;
}
    inc(row);
    col := 0;
    SetCellText(row,col,'Plaka No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('PLAKA_NO').AsString);

    inc(col);
    SetCellText(row,col,'Makbuz No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('MAKBUZ_NO').AsString);

    inc(row);
    col := 0;

    SetCellText(row,col,'Ücreti');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('UCRETI').AsString);
    inc(row);
    col := 0;


    SetCellText(row,col,'Giriþ Tarihi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('GIRIS_TARIHI').AsString);

    inc(col);
    SetCellText(row,col,'Giriþ Saati');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('GIRIS_SAATI').AsString);

    inc(row);
    col := 0;

    SetCellText(row,col,'Çýkýþ Tarihi');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('CIKIS_TARIHI').AsString);

    inc(col);
    SetCellText(row,col,'Çýkýþ Saati');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('CIKIS_SAATI').AsString);

    inc(row);
    col := 0;


    SetCellText(row,col,'Cari Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('CARI_AD').AsString);

    inc(col);
    SetCellText(row,col,'Ürün Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('URUN_AD').AsString);

    inc(row);
    col := 0;



    SetCellText(row,col,'Açýklama');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('ACIKLAMA').AsString);
    inc(row);
    col := 0;

    SetCellText(row,col,'Geldiði Yer');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('GELDIGI_YER').AsString);

    inc(col);
    SetCellText(row,col,'Gittiði Yer');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('GITTIGI_YER').AsString);
    inc(row);

    col := 0;
    SetCellText(row,col,'Giriþ Kilosu');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('GIRIS_KILO').AsString);

    inc(col);
    SetCellText(row,col,'Çýkýþ Kilosu');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,qry_Kantar.FieldByName('CIKIS_KILO').AsString);



////////////////////////////////////////////////////////////////////////////////
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  qry_Kantar.EnableControls;



end;

procedure Tfrm_Kantar.DtsKantarStateChanged(Sender: TIB_DataSource; ADataset: TIB_Dataset);
begin
  {
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
    if ADataset.FieldByName('KANTAR_NO').AsInteger<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;
  }

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
    if ADataset.FieldByName('KANTAR_NO').AsInteger<=0 then
      btnSil.Enabled := False
    else
      btnSil.Enabled := True;

    btnAra.Enabled := True;
    btnCikis.Enabled := True;
    btnKaydet.Enabled := False;
    btnIPTAL.Enabled := False;
  end;


  if qry_Kantar.FieldByName('TIPI').AsString='G' then
  begin
     Btn_Cikis_Yap.Enabled:=True;
     Btn_Giris_Yaz.Enabled:=True;
     BtnYazdir.Enabled:=False;
  end
  else
  begin
     Btn_Cikis_Yap.Enabled:=False;
     Btn_Giris_Yaz.Enabled:=False;
     BtnYazdir.Enabled:=True;
  end;

  {  with Qry_Girenler do
    begin
      Active := False;
      Active := True;
    end;
  }


end;

procedure Tfrm_Kantar.txtKasaKodButtonClick(Sender: TObject);
var
  Kasa_Kod,Kasa_Ad,DOVKOD:String;
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;

  if DataMod.LS_KASA(Kasa_Kod,Kasa_Ad,DOVKOD) Then
  begin
    with qry_Kantar do
    begin
      FieldByName('KASA_KOD').AsString:=Kasa_Kod;
      FieldByName('KASA_AD').AsString:=Kasa_Ad;
    end;
  end;
end;

procedure Tfrm_Kantar.txtKasaKodExit(Sender: TObject);
var
  Kasa_Ad:String;
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    txtKasaKod.Color := clWindow;
    exit;
  end;

  txtKasaKod.Color := clWindow;

  if Trim(txtKasaKod.Text)<>'' then
  begin
    if DataMod.FN_KOD2AD('KASA','KASA_KOD','ACIKLAMA',qry_Kantar.FieldByName('KASA_KOD').AsString,Kasa_Ad) Then
    begin
      qry_Kantar.FieldByName('KASA_AD').AsString := KASA_Ad;
    end
    else
    begin
      qry_Kantar.FieldByName('KASA_AD').AsString := '';
      txtKasaKod.SetFocus;
    end;
  end
  else
  begin
    qry_Kantar.FieldByName('KASA_AD').AsString := '';
  end;
end;

procedure Tfrm_Kantar.txtKasaKodEnter(Sender: TObject);
begin
  IB_ComboBox1.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.txtKasaKodKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 Then txtKasaKodButtonClick(Self);
end;

procedure Tfrm_Kantar.txtPlaka_NoButtonClick(Sender: TObject);
var
  PLAKA_NO,ACIKLAMA,CARI_KOD,CARI_AD:String;
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;


  if datamod.LS_Plaka(PLAKA_NO,ACIKLAMA,CARI_KOD,CARI_AD) then
  begin
      qry_Kantar.FieldByName('PLAKA_NO').AsString := PLAKA_NO;

      qry_Kantar.FieldByName('CARI_KOD').AsString := Cari_KOD;
      qry_Kantar.FieldByName('CARI_AD').AsString := Cari_AD;

  end;

end;

procedure Tfrm_Kantar.IB_Edit14Exit(Sender: TObject);
begin
  my_Active_Comp.Brush.color :=clWindow;
end;

procedure Tfrm_Kantar.IB_Edit14Enter(Sender: TObject);
begin
  ActiveControl.Brush.Color := glb_Art_Alan_Renk;
  my_Active_Comp:=ActiveControl;
end;

procedure Tfrm_Kantar.IB_ComboBox1Enter(Sender: TObject);
begin
  IB_ComboBox1.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.IB_ComboBox1Exit(Sender: TObject);
begin
IB_ComboBox1.Color := clWindow;
end;

procedure Tfrm_Kantar.frxReport1BeforePrint(Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin

        { res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;

       {end;
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;}

     {  c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
       }
//       c:=(frxReport1.FindComponent('Memo1') as TfrxMemoView);
//       c.memo.Text:=txtMasrafKod.Text;

       {c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);}

{
       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);

}
       Prv_Yazdirildi:=True;
    end;


end;

procedure Tfrm_Kantar.IB_Edit1ButtonClick(Sender: TObject);
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    qry_Kantar.FieldByName('MASRAF_MERK').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Kantar.IB_Edit6ButtonClick(Sender: TObject);
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    qry_Kantar.FieldByName('KOD1').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Kantar.IB_Edit7ButtonClick(Sender: TObject);
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    qry_Kantar.FieldByName('KOD2').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Kantar.IB_Edit24ButtonClick(Sender: TObject);
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    qry_Kantar.FieldByName('KOD3').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Kantar.IB_Edit25ButtonClick(Sender: TObject);
begin
  if not (qry_Kantar.State in [dssInsert,dssEdit]) then
  begin
    exit;
  end;
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    qry_Kantar.FieldByName('KOD4').AsString := Muh_Kod;
  end;
end;

procedure Tfrm_Kantar.IB_Edit1Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit1.Text)) = 0 then
  begin
    IB_Edit1.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit1,nil,0) then
  begin
    IB_Edit1.Color := clWindow;
  end
  else
  begin
    IB_Edit1.SetFocus;
  end;
    IB_Edit1.Color := clWindow;
end;

procedure Tfrm_Kantar.IB_Edit6Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit6.Text)) = 0 then
  begin
    IB_Edit6.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit6,nil,1) then
  begin
    IB_Edit6.Color := clWindow;
  end
  else
  begin
    IB_Edit6.SetFocus;
  end;
    IB_Edit6.Color := clWindow;
end;

procedure Tfrm_Kantar.IB_Edit7Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit7.Text)) = 0 then
  begin
    IB_Edit7.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit7,nil,2) then
  begin
    IB_Edit7.Color := clWindow;
  end
  else
  begin
    IB_Edit7.SetFocus;
  end;
    IB_Edit7.Color := clWindow;
end;

procedure Tfrm_Kantar.IB_Edit24Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit24.Text)) = 0 then
  begin
    IB_Edit24.Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(IB_Edit24,nil,3) then
  begin
    IB_Edit24.Color := clWindow;
  end
  else
  begin
    IB_Edit24.SetFocus;
  end;
    IB_Edit24.Color := clWindow;  
end;

procedure Tfrm_Kantar.IB_Edit25Exit(Sender: TObject);
begin
  if Length(trim(IB_Edit25.Text)) = 0 then
  begin
    IB_Edit25.Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(IB_Edit25,nil,4) then
  begin
    IB_Edit25.Color := clWindow;
  end
  else
  begin
    IB_Edit25.SetFocus;
  end;
    IB_Edit25.Color := clWindow;
end;

procedure Tfrm_Kantar.IB_Edit1Enter(Sender: TObject);
begin
  IB_Edit1.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.IB_Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit1ButtonClick(Self);
end;

procedure Tfrm_Kantar.IB_Edit6Enter(Sender: TObject);
begin
  IB_Edit6.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.IB_Edit7Enter(Sender: TObject);
begin
  IB_Edit7.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.IB_Edit24Enter(Sender: TObject);
begin
  IB_Edit24.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.IB_Edit25Enter(Sender: TObject);
begin
  IB_Edit25.Color := glb_Art_Alan_Renk;
end;

procedure Tfrm_Kantar.IB_Edit6KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit6ButtonClick(Self);
end;

procedure Tfrm_Kantar.IB_Edit7KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit7ButtonClick(Self);
end;

procedure Tfrm_Kantar.IB_Edit24KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit24ButtonClick(Self);
end;

procedure Tfrm_Kantar.IB_Edit25KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F4 then IB_Edit25ButtonClick(Self);
end;

procedure Tfrm_Kantar.DtsKantarDataChange(Sender: TIB_StatementLink;
  Statement: TIB_Statement; Field: TIB_Column);
begin
  {  if qry_Kantar.FieldByName('TIPI').AsString='G' then
    frm_Kantar.Pnl_Cikis.Visible:=False
    else
    if qry_Kantar.FieldByName('TIPI').AsString='C' then
    frm_Kantar.Pnl_Cikis.Visible:=True;
   }

  if Assigned( Field ) then
  begin
       if ((Field.FieldName='GIRIS_KILO') or (Field.FieldName='CIKIS_KILO')) then

       qry_Kantar.FieldByName('FARK_KILO').AsFloat:=
       qry_Kantar.FieldByName('GIRIS_KILO').AsFloat-
       qry_Kantar.FieldByName('CIKIS_KILO').AsFloat;

       if (Field.FieldName='TIPI') then
       if qry_Kantar.FieldByName('TIPI').AsString='G' then
       Btn_Cikis_Yap.Enabled:=True
       else
       Btn_Cikis_Yap.Enabled:=False;
  end;



end;

procedure Tfrm_Kantar.Btn_SonrakiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 KANTAR_NO FROM KANTAR WHERE KANTAR_NO>:KANTAR_NO ORDER BY KANTAR_NO';
     qryDeg1.ParamByName('KANTAR_NO').AsInteger:=qry_Kantar.FieldByName('KANTAR_NO').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('KANTAR_NO').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('KANTAR_NO').AsInteger;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;

procedure Tfrm_Kantar.Btn_OncekiClick(Sender: TObject);
var
   qryDeg1:TIb_Query;
   Id:Integer;
begin
     DataMod.CreateQuery(qryDeg1,nil,False,DataMod.dbaMain);
     qryDeg1.Active:=False;
     qryDeg1.SQL.Clear;
     qryDeg1.SQL.Text:='SELECT  FIRST 1 KANTAR_NO FROM KANTAR WHERE KANTAR_NO<:KANTAR_NO ORDER BY KANTAR_NO DESC';
     qryDeg1.ParamByName('KANTAR_NO').AsInteger:=qry_Kantar.FieldByName('KANTAR_NO').AsInteger;
     qryDeg1.Open;
     if qryDeg1.FieldByName('KANTAR_NO').AsInteger>0 then
     begin
          Id:=qryDeg1.FieldByName('KANTAR_NO').AsInteger;
          Geri_AL;
          DataSet_Open(Id,1);
     end;
     DataMod.ReleaseQuery(qryDeg1);

end;


procedure Tfrm_Kantar.Geri_AL;
begin
     if qry_Kantar.State in [DssEdit,DssInsert] then qry_Kantar.Cancel;
     qry_Kantar.Close;
end;


procedure Tfrm_Kantar.Btn_Cikis_YapClick(Sender: TObject);
begin
  Application.CreateForm(Tfrm_Kantar_Cikis, frm_Kantar_Cikis);
  qry_Kantar.FieldByName('Tipi').asString:='C';
  frm_Kantar_Cikis.ShowModal;

    with Qry_Cikanlar do
    begin
      Active := False;
      Active := True;
    end;
    with qry_Kantar do
    begin
      Active := False;
      Active := True;
    end;

end;

procedure Tfrm_Kantar.qry_KantarBeforePost(IB_Dataset: TIB_Dataset);
begin

  if Trim(qry_Kantar.FieldByName('MAKBUZ_NO').AsString) = ''  then
  begin
    IB_Edit2.SetFocus;
    Application.MessageBox('Makbuz No Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Abort;
  end;

  if Trim(qry_Kantar.FieldByName('PLAKA_NO').AsString) = ''  then
  begin
    txtPlaka_No.SetFocus;
    Application.MessageBox('Plaka No Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Abort;
  end;

  if Trim(qry_Kantar.FieldByName('CARI_KOD').AsString) = ''  then
  begin
    txtCari_Kod.SetFocus;
    Application.MessageBox('Cari Kod Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Abort;
  end;

  if Trim(qry_Kantar.FieldByName('URUN_KOD').AsString) = ''  then
  begin
    txtUrun_Kod.SetFocus;
    Application.MessageBox('Ürün Kodu Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Abort;
  end;

  if (Trim(qry_Kantar.FieldByName('TIPI').AsString) = 'G') or (Trim(qry_Kantar.FieldByName('TIPI').AsString) = 'C' ) then
  begin

       if Trim(qry_Kantar.FieldByName('GELDIGI_YER').AsString) = ''  then
       begin
         Cb_Geldigi_Yer.SetFocus;
         Application.MessageBox('Geldiði Yer Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;

       if qry_Kantar.FieldByName('GIRIS_TARIHI').AsVariant = Null  then
       begin
         IB_Date1.SetFocus;
         Application.MessageBox('Giriþ Tarihi Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;

       if qry_Kantar.FieldByName('GIRIS_SAATI').AsVariant = Null  then
       begin
         IB_Date4.SetFocus;
         Application.MessageBox('Giriþ Saati Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;


       if qry_Kantar.FieldByName('GIRIS_KILO').AsFloat <=0  then
       begin
         IB_Edit11.SetFocus;
         Application.MessageBox('Giriþ Kilosu Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;

       if Trim(qry_Kantar.FieldByName('GITTIGI_YER').AsString) = ''  then
       begin
         Cb_Gittigi_Yer.SetFocus;
         Application.MessageBox('Gittiði Yer Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;

  end;


  if Trim(qry_Kantar.FieldByName('TIPI').AsString) = 'C'  then
  begin

       if qry_Kantar.FieldByName('CIKIS_TARIHI').AsVariant = Null  then
       begin
         //IB_Date2.SetFocus;
         Application.MessageBox('Çýkýþ Tarihi Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;

       if qry_Kantar.FieldByName('CIKIS_SAATI').AsVariant = Null  then
       begin
         //IB_Date3.SetFocus;
         Application.MessageBox('Çýkýþ Saati Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;

       if qry_Kantar.FieldByName('CIKIS_KILO').AsFloat <=0  then
       begin
         //IB_Edit12.SetFocus;
         Application.MessageBox('Çýkýþ Kilosu Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;

       if qry_Kantar.FieldByName('UCRETI').AsFloat <=0  then
       begin
         //IB_Edit12.SetFocus;
         Application.MessageBox('Ücreti Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
         Abort;
       end;

  end;



{  if glb_PROJE_UYG then
  if Trim(qry_Kantar.FieldByName('PROJE_KOD').AsString) = ''  then
  begin
    txtProje_Kod.SetFocus;
    Application.MessageBox('Proje Kodu Alanýna Veri Girmediniz!!!','DÝKKAT',MB_ICONWARNING);
    Abort;
  end;

}

end;

procedure Tfrm_Kantar.FormActivate(Sender: TObject);
begin
  WindowState:=wsMaximized;
end;

procedure Tfrm_Kantar.FormResize(Sender: TObject);
begin
  WindowState:=wsMaximized;
end;

procedure Tfrm_Kantar.Btn_DegistirClick(Sender: TObject);
begin
Pnl_Giris.Height:=450;
Pnl_Cikis.Visible:=True;
Pnl_Cikis.Align:=alBottom;
    with qry_Kantar do
    begin
      Active := False;
      ParambyName('PRM_KANTAR_NO').AsInteger := Qry_Cikanlar.FieldbyName('KANTAR_NO').AsInteger;
      Active := True;
    end;
    qry_Kantar.Edit;

{//IB_Grid2.Height:=50;
qry_Kantar.Active:=False;
qry_Kantar.Sql.Clear;
qry_Kantar.Sql.Add(
'SELECT KANTAR_SID '+
'     , KANTAR_NO '+
'     , GIRIS_TARIHI '+
'     , GIRIS_SAATI '+
'     , MAKBUZ_NO '+
'     , URUN_KOD '+
'     ,(Select URUN_AD from URUN where URUN.URUN_KOD=KANTAR.URUN_KOD) as URUN_AD '+
'     , CARI_KOD '+
'     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=KANTAR.CARI_KOD) As CARI_AD '+
'     , ACIKLAMA '+
'     , GELDIGI_YER '+
'     , GELDIGI_YER_KOD '+
'     , GITTIGI_YER '+
'     , GITTIGI_YER_KOD '+
'     , CIKIS_TARIHI '+
'     , CIKIS_SAATI '+
'     , ARAC_KILO '+
'     , GIRIS_KILO '+
'     , CIKIS_KILO '+
'     , FARK_KILO '+
'     , UCRETI '+
'     , TIPI '+
'     , PLAKA_NO '+
'     , KASA_KOD '+
'     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=KANTAR.KASA_KOD) as KASA_AD '+
'     , MASRAF_MERK '+
'     , KOD1 '+
'     , KOD2 '+
'     , KOD3 '+
'     , KOD4 '+
'     , PERSONEL_KOD '+
'     , PROJE_KOD '+
'FROM KANTAR '+
'WHERE KANTAR_NO=:PRM_KANTAR_NO ');

qry_Kantar.ParamByName('PRM_KANTAR_NO').AsInteger:=Qry_Cikanlar.FieldByName('KANTAR_NO').AsInteger;
qry_Kantar.Active:=True;
}
end;




procedure Tfrm_Kantar.Kantar_Sql_Yenile;
begin
{qry_Kantar.Active:=False;
qry_Kantar.Sql.Clear;
qry_Kantar.Sql.Add(
'SELECT KANTAR_SID '+
'     , KANTAR_NO '+
'     , GIRIS_TARIHI '+
'     , GIRIS_SAATI '+
'     , MAKBUZ_NO '+
'     , URUN_KOD '+
'     ,(Select URUN_AD from URUN where URUN.URUN_KOD=KANTAR.URUN_KOD) as URUN_AD '+
'     , CARI_KOD '+
'     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=KANTAR.CARI_KOD) As CARI_AD '+
'     , ACIKLAMA '+
'     , GELDIGI_YER '+
'     , GELDIGI_YER_KOD '+
'     , GITTIGI_YER '+
'     , GITTIGI_YER_KOD '+
'     , CIKIS_TARIHI '+
'     , CIKIS_SAATI '+
'     , ARAC_KILO '+
'     , GIRIS_KILO '+
'     , CIKIS_KILO '+
'     , FARK_KILO '+
'     , UCRETI '+
'     , TIPI '+
'     , PLAKA_NO '+
'     , KASA_KOD '+
'     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=KANTAR.KASA_KOD) as KASA_AD '+
'     , MASRAF_MERK '+
'     , KOD1 '+
'     , KOD2 '+
'     , KOD3 '+
'     , KOD4 '+
'     , PERSONEL_KOD '+
'     , PROJE_KOD '+
'FROM KANTAR '+
'WHERE TIPI=''G'' '+
'ORDER BY GIRIS_TARIHI, GIRIS_SAATI');
qry_Kantar.Active:=True;
}
end;




procedure Tfrm_Kantar.Qry_GirenlerAfterScroll(IB_Dataset: TIB_Dataset);
begin
    with qry_Kantar do
    begin
      Active := False;
      ParambyName('PRM_KANTAR_NO').AsInteger := Qry_Girenler.FieldbyName('KANTAR_NO').AsInteger;
      Active := True;
    end;

//  if (ADataset.State in [dssEdit]) then
  if Btn_Degistir.Visible then
  Pnl_Cikis.Visible:=False;
end;

procedure Tfrm_Kantar.Qry_CikanlarAfterScroll(IB_Dataset: TIB_Dataset);
begin
  if Btn_Degistir.Visible then
  Pnl_Cikis.Visible:=False;

    with qry_Kantar do
    begin
      Active := False;
      ParambyName('PRM_KANTAR_NO').AsInteger := Qry_Cikanlar.FieldbyName('KANTAR_NO').AsInteger;
      Active := True;
    end;


end;

procedure Tfrm_Kantar.SpeedButton1Click(Sender: TObject);
begin
  Application.CreateForm(Tfrm_Kantar_Degistir, frm_Kantar_Degistir);
  frm_Kantar_Degistir.ShowModal;

end;

end.






{
CREATE TABLE KANTAR (
    KANTAR_SID       D_SID NOT NULL,
    KANTAR_NO        D_INTEGER NOT NULL,
    GIRIS_TARIHI     D_TARTIP,
    GIRIS_SAATI      D_SAATTIP,
    MAKBUZ_NO        D_KOD,
    URUN_KOD         D_KOD,
    CARI_KOD         D_KOD,
    ACIKLAMA         D_ACK50,
    GELDIGI_YER      D_ACK50,
    GELDIGI_YER_KOD  D_KOD,
    GITTIGI_YER      D_ACK50,
    GITTIGI_YER_KOD  D_KOD,
    CIKIS_TARIHI     D_TARTIP,
    CIKIS_SAATI      D_SAATTIP,
    ARAC_KILO        D_FLOAT,
    GIRIS_KILO       D_FLOAT,
    CIKIS_KILO       D_FLOAT,
    FARK_KILO        D_FLOAT,
    UCRETI           D_FLOAT,
    TIPI             D_CHR1,
    PLAKA_NO         D_KOD
);





/******************************************************************************/
/****                             Primary Keys                             ****/
/******************************************************************************/

ALTER TABLE KANTAR ADD CONSTRAINT PK_KANTAR PRIMARY KEY (KANTAR_SID, KANTAR_NO);



     , (Select PERSONEL.PERSONEL_ADI From CARI Where CARI.CARI_KOD=KANTAR.PERSONEL_KOD) As PERSONEL_AD

     KULLNICI AADI DA BASILABÝLÝR
}
