unit ufrmRaporProjeHareketleri;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls,
  IB_Components, frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;

type
  TfrmRaporProjeHareketleri = class(TForm)
    qryProje: TIB_Query;
    qryRapor: TIB_Cursor;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    cmb_sirala: TComboBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    rdSec: TRadioGroup;
    rdTablo: TRadioGroup;
    GroupBox1: TGroupBox;
    txtProjeKod1: TEdit;
    Button1: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    frxIBODts_Proje_Har: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
///user defined procedures and functions
//start
    procedure alan_isimlerini_ekle;
    procedure yaz;
    procedure Form_Open();
    procedure frmRaporCiktisi_Open(Sender: TObject;strSQL:String);
//stop
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure txtProjeKod1Exit(Sender: TObject);
    procedure txtProjeKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtProjeKod1KeyPress(Sender: TObject; var Key: Char);
    procedure btnRaporClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txtProjeKod1Enter(Sender: TObject);
    procedure rdSecEnter(Sender: TObject);
    procedure rdSecExit(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure cmbSubeEnter(Sender: TObject);
    procedure cmbSubeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    row,col:integer;
    dvr_borc,dvr_alacak : Currency;
    prv_borc,prv_alacak : Currency;
    prv_dovkod : String;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_proje_hareketleri = 9;

var
  frmRaporProjeHareketleri: TfrmRaporProjeHareketleri;

implementation
uses unDataMod, unFunc, ufrmRaporCiktisi,main;
{$R *.dfm}

procedure TfrmRaporProjeHareketleri.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if DataMod.Modul_Hak(cns_proje_hareketleri,local_CanUpdate,local_CanDelete) = false then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporProjeHareketleri') then
    begin
      Application.CreateForm(TfrmRaporProjeHareketleri,frmRaporProjeHareketleri);
      frmRaporProjeHareketleri.dtpIslemTar1.Date := glb_DONEM_BAS;
      frmRaporProjeHareketleri.dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;

      if glb_SUBELI then
      begin
        DataMod.FillSubeStr(frmRaporProjeHareketleri.cmbSube.Items);
        frmRaporProjeHareketleri.cmbSube.ItemIndex := 0;
        frmRaporProjeHareketleri.grpSube.Visible := True;
      end
      else
      begin
        frmRaporProjeHareketleri.grpSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;



procedure TfrmRaporProjeHareketleri.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  qryProje.Close;
  qryRapor.Close;
  action := caFree;
end;

procedure TfrmRaporProjeHareketleri.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporProjeHareketleri.Button1Click(Sender: TObject);
var
  Proje_KOD,Proje_AD : String;
begin
  if DataMod.LS_Proje(Proje_KOD,Proje_AD,0) Then txtProjeKod1.Text := Proje_Kod;
end;

procedure TfrmRaporProjeHareketleri.txtProjeKod1Exit(Sender: TObject);
var
  Proje_Ad : String;
begin
  if Trim(txtProjeKod1.Text) = '' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if not DataMod.FN_KOD2AD('PROJE','PROJE_KOD','PROJE_AD',(Sender as TEdit).Text,Proje_Ad) then
  begin
    Application.MessageBox('Proje kodu bulunamadý.Lütfen listeden seçiniz.','DÝKKAT',MB_ICONWARNING);
    (Sender as TEdit).Clear;
    (Sender as TEdit).SetFocus;
  end
  else
  begin
    (Sender as TEdit).Color := clWindow;
  end;
end;


procedure TfrmRaporProjeHareketleri.txtProjeKod1KeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;


procedure TfrmRaporProjeHareketleri.txtProjeKod1KeyPress(Sender: TObject;  var Key: Char);
begin
  If not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporProjeHareketleri.btnRaporClick(Sender: TObject);
var
  strSQL,strSQLs,SubeID:String;
begin
  if (Length(Trim(txtProjeKod1.Text)) = 0) then
  begin
    Application.MessageBox('Lütfen bir proje seçiniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  strSQL:='';

  strSQLs:= '';
  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      strSQLs:= ' AND PROJE.PROJE_SID = ' + SubeID+' ';
    end;
  end
  else
  begin
    strSQLs:=  ' AND PROJE.PROJE_SID = ' + inttostr(glb_SID)+' ';
  end;


  case rdTablo.ItemIndex of
  0:
    begin
      if Sender=Btn_Fast then
      begin
           if rdSec.itemindex=2 then
           begin

              strSQL := 'SELECT  PROJE.PROJE_KOD'
                + ',PROJE.PROJE_AD'
                + ',PROJE.DOVKOD AS PROJE_DOVKOD'
                + ',CAST(''01.01.2007'' AS DATE) TARIH'
                + ',CAST(0 AS INTEGER) BELGE_ID'
                + ',CAST(0 AS INTEGER) BELGE_TUR'
                + ',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
                + ',CAST('''' AS CHAR(1)) TIP'
                + ',CAST('''' AS VARCHAR(5)) DOVKOD'
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR'
                + ',CAST(''Önceki Tarihten Hesaplanan'' AS VARCHAR(100)) ACIKLAMA'
                + ',CAST(0 AS NUMERIC(18,4)) DOVKUR'
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR_PROJE_DOVKOD'
                + ', (SELECT SUM(TUTAR_VPB) FROM PROJEHAR WHERE (PROJEHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and PROJEHAR.PROJE_KOD =PROJE.PROJE_KOD and PROJEHAR.TIP=''B'') CBorc '
                + ', (SELECT SUM(TUTAR_VPB) FROM PROJEHAR WHERE (PROJEHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and PROJEHAR.PROJE_KOD =PROJE.PROJE_KOD and PROJEHAR.TIP=''A'') CAlacak '
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB '
                + ' FROM PROJE'
                //+ ' INNER JOIN PROJEHAR ON (PROJEHAR.PROJE_KOD = PROJE.PROJE_KOD)'
                + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs
                + '  group by PROJE.PROJE_KOD,PROJE.PROJE_AD,PROJE.DOVKOD '
                + ' Union ';

              strSQL := strSQL +'SELECT  PROJE.PROJE_KOD'
                + ',PROJE.PROJE_AD'
                + ',PROJE.DOVKOD AS PROJE_DOVKOD'
                + ',CAST(''01.01.2007'' AS DATE) TARIH'
                + ',CAST(0 AS INTEGER) BELGE_ID'
                + ',CAST(0 AS INTEGER) BELGE_TUR'
                + ',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
                + ',CAST('''' AS CHAR(1)) TIP'
                + ',CAST('''' AS VARCHAR(5)) DOVKOD'
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR'
                + ',CAST(''DEVÝR'' AS VARCHAR(100)) ACIKLAMA'
                + ',CAST(0 AS NUMERIC(18,4)) DOVKUR'
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR_PROJE_DOVKOD'
                + ', PROJE.DEVREDEN_BORC_VPB CBorc '
                + ', PROJE.DEVREDEN_ALACAK_VPB CAlacak '
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB FROM PROJE'
                + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text)+  strSQLs;

           end
           else
           begin
              strSQL := 'SELECT  PROJE.PROJE_KOD'
                + ',PROJE.PROJE_AD'
                + ',PROJE.DOVKOD AS PROJE_DOVKOD'
                + ',CAST(''01.01.2007'' AS DATE) TARIH'
                + ',CAST(0 AS INTEGER) BELGE_ID'
                + ',CAST(0 AS INTEGER) BELGE_TUR'
                + ',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
                + ',CAST('''' AS CHAR(1)) TIP'
                + ',CAST('''' AS VARCHAR(5)) DOVKOD'
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR'
                + ',CAST(''Önceki Tarihten Hesaplanan'' AS VARCHAR(100)) ACIKLAMA'
                + ',CAST(0 AS NUMERIC(18,4)) DOVKUR'
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR_PROJE_DOVKOD'
                + ', (SELECT SUM(TUTAR) FROM PROJEHAR WHERE (PROJEHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and PROJEHAR.PROJE_KOD =PROJE.PROJE_KOD and PROJEHAR.TIP=''B'') CBorc '
                + ', (SELECT SUM(TUTAR) FROM PROJEHAR WHERE (PROJEHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and PROJEHAR.PROJE_KOD =PROJE.PROJE_KOD and PROJEHAR.TIP=''A'') CAlacak '
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB '
                + ' FROM PROJE'
                //+ ' INNER JOIN PROJEHAR ON (PROJEHAR.PROJE_KOD = PROJE.PROJE_KOD)'
                + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs
                + '  group by PROJE.PROJE_KOD,PROJE.PROJE_AD,PROJE.DOVKOD '
                + ' Union ';

              strSQL := strSQL+'SELECT  PROJE.PROJE_KOD'
                + ',PROJE.PROJE_AD'
                + ',PROJE.DOVKOD AS PROJE_DOVKOD'
                + ',CAST(''01.01.2007'' AS DATE) TARIH'
                + ',CAST(0 AS INTEGER) BELGE_ID'
                + ',CAST(0 AS INTEGER) BELGE_TUR'
                + ',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
                + ',CAST('''' AS CHAR(1)) TIP'
                + ',CAST('''' AS VARCHAR(5)) DOVKOD'
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR'
                + ',CAST(''DEVÝR'' AS VARCHAR(100)) ACIKLAMA'
                + ',CAST(0 AS NUMERIC(18,4)) DOVKUR'
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR_PROJE_DOVKOD'
                + ', PROJE.DEVREDEN_BORC CBorc '
                + ', PROJE.DEVREDEN_ALACAK CAlacak '
                + ',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB FROM PROJE'
                + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs;

           end;
           strSQL :=strSQL+ ' union ';
      end;
      if rdSec.itemindex=2 then
      begin
           strSQL := strSQL+'SELECT  PROJE.PROJE_KOD'
           + ',PROJE.PROJE_AD'
           + ',PROJE.DOVKOD AS PROJE_DOVKOD'
           + ',PROJEHAR.TARIH'
           + ',PROJEHAR.BELGE_ID'
           + ',PROJEHAR.BELGE_TUR'
           + ',PROJEHAR.DOV_BAZ_TAR'
           + ',PROJEHAR.TIP'
           + ',PROJEHAR.DOVKOD'
           + ',PROJEHAR.TUTAR'
           + ',PROJEHAR.ACIKLAMA'
           + ',PROJEHAR.DOVKUR'
           + ',PROJEHAR.TUTAR_PROJE_DOVKOD'
           + ',(case when  PROJEHAR.TIP=''B'' then '
           + 'PROJEHAR.TUTAR_VPB else 0 end) CBorc '
           + ',(case when  PROJEHAR.TIP=''A'' then '
           + 'PROJEHAR.TUTAR_VPB else 0 end ) CAlacak '
           + ',PROJEHAR.TUTAR_VPB FROM PROJE'
           + ' INNER JOIN PROJEHAR ON (PROJEHAR.PROJE_KOD = PROJE.PROJE_KOD)'
           + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text)  + strSQLs
           + ' and (PROJEHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';
      end;

      if rdSec.itemindex=0 then
      begin
           strSQL := strSQL+'SELECT  PROJE.PROJE_KOD'
           + ',PROJE.PROJE_AD'
           + ',PROJE.DOVKOD AS PROJE_DOVKOD'
           + ',PROJEHAR.TARIH'
           + ',PROJEHAR.BELGE_ID'
           + ',PROJEHAR.BELGE_TUR'
           + ',PROJEHAR.DOV_BAZ_TAR'
           + ',PROJEHAR.TIP'
           + ',PROJEHAR.DOVKOD'
           + ',PROJEHAR.TUTAR'
           + ',PROJEHAR.ACIKLAMA'
           + ',PROJEHAR.DOVKUR'
           + ',PROJEHAR.TUTAR_PROJE_DOVKOD'
           + ',(case when  PROJEHAR.TIP=''B'' then '
           + 'PROJEHAR.TUTAR else 0 end) CBorc '
           + ',(case when  PROJEHAR.TIP=''A'' then '
           + 'PROJEHAR.TUTAR else 0 end ) CAlacak '
           + ',PROJEHAR.TUTAR FROM PROJE'
           + ' INNER JOIN PROJEHAR ON (PROJEHAR.PROJE_KOD = PROJE.PROJE_KOD)'
           + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs
           + ' and (PROJEHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';
      end;
      if rdSec.itemindex=1 then
      begin
           strSQL := strSQL+'SELECT  PROJE.PROJE_KOD'
           + ',PROJE.PROJE_AD'
           + ',PROJE.DOVKOD AS PROJE_DOVKOD'
           + ',PROJEHAR.TARIH'
           + ',PROJEHAR.BELGE_ID'
           + ',PROJEHAR.BELGE_TUR'
           + ',PROJEHAR.DOV_BAZ_TAR'
           + ',PROJEHAR.TIP'
           + ',PROJEHAR.DOVKOD'
           + ',PROJEHAR.TUTAR'
           + ',PROJEHAR.ACIKLAMA'
           + ',PROJEHAR.DOVKUR'
           + ',PROJEHAR.TUTAR_PROJE_DOVKOD'
           + ',(case when  PROJEHAR.TIP=''B'' then '
           + 'PROJEHAR.TUTAR_PROJE_DOVKOD else 0 end) CBorc '
           + ',(case when  PROJEHAR.TIP=''A'' then '
           + 'PROJEHAR.TUTAR_PROJE_DOVKOD else 0 end ) CAlacak '
           + ',PROJEHAR.TUTAR FROM PROJE'
           + ' INNER JOIN PROJEHAR ON (PROJEHAR.PROJE_KOD = PROJE.PROJE_KOD)'
           + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs
           + ' and (PROJEHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';
      end;

        {      if glb_SUBELI then
              begin
                SubeID := DataMod.SubeAd2ID(cmbSube.Text);
                if SubeID <> '0' then
                begin
                  strSQL := strSQL + ' AND PROJEHAR.PROJEHAR_SID = ' + SubeID;
                end;
              end
              else
              begin
                strSQL := strSQL + ' AND PROJEHAR.PROJEHAR_SID = ' + inttostr(glb_SID);
              end;
}
      if Sender<>Btn_Fast then
      strSQL := strSQL + ' ORDER BY PROJEHAR.TARIH,PROJEHAR.PROJEHAR_ID';
    end;
  1:
    begin

           if rdSec.itemindex=2 then
           begin

              strSQL := 'SELECT  PROJE.PROJE_KOD'
              + ',PROJE.PROJE_AD'
              + ',PROJE.DOVKOD AS PROJE_DOVKOD'
              + ',CAST(''01.01.2007'' AS DATE) TARIH'
              + ',CAST(0 AS INTEGER) BELGE_ID'
              + ',CAST(0 AS INTEGER) BELGE_TUR'
              + ',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
              + ',CAST('''' AS CHAR(1)) TIP'
              + ',CAST('''' AS VARCHAR(5)) DOVKOD'
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR'
              + ',CAST(''Önceki Tarihten Hesaplanan'' AS VARCHAR(100)) ACIKLAMA'
              + ',CAST(0 AS NUMERIC(18,4)) DOVKUR'
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR_PROJE_DOVKOD'
              + ', (SELECT SUM(TUTAR_VPB) FROM CARIHAR WHERE (CARIHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and CARIHAR.PROJE_KOD =PROJE.PROJE_KOD and CARIHAR.TIP=''B'') CBorc '
              + ', (SELECT SUM(TUTAR_VPB) FROM CARIHAR WHERE (CARIHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and CARIHAR.PROJE_KOD =PROJE.PROJE_KOD and CARIHAR.TIP=''A'') CAlacak '
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB '
              + ' FROM PROJE'
              //+ ' INNER JOIN PROJEHAR ON (PROJEHAR.PROJE_KOD = PROJE.PROJE_KOD)'
              + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs
              + '  group by PROJE.PROJE_KOD,PROJE.PROJE_AD,PROJE.DOVKOD '
              + ' Union ';

              strSQL := strSQL +'SELECT  PROJE.PROJE_KOD'
              + ',PROJE.PROJE_AD'
              + ',PROJE.DOVKOD AS PROJE_DOVKOD'
              + ',CAST(''01.01.2007'' AS DATE) TARIH'
              + ',CAST(0 AS INTEGER) BELGE_ID'
              + ',CAST(0 AS INTEGER) BELGE_TUR'
              + ',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
              + ',CAST('''' AS CHAR(1)) TIP'
              + ',CAST('''' AS VARCHAR(5)) DOVKOD'
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR'
              + ',CAST(''DEVÝR'' AS VARCHAR(100)) ACIKLAMA'
              + ',CAST(0 AS NUMERIC(18,4)) DOVKUR'
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR_PROJE_DOVKOD'
              + ', PROJE.DEVREDEN_BORC_VPB CBorc '
              + ', PROJE.DEVREDEN_ALACAK_VPB CAlacak '
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB FROM PROJE'
              + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text)+  strSQLs;

           end
           else
           begin
              strSQL := 'SELECT  PROJE.PROJE_KOD'
              + ',PROJE.PROJE_AD'
              + ',PROJE.DOVKOD AS PROJE_DOVKOD'
              + ',CAST(''01.01.2007'' AS DATE) TARIH'
              + ',CAST(0 AS INTEGER) BELGE_ID'
              + ',CAST(0 AS INTEGER) BELGE_TUR'
              + ',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
              + ',CAST('''' AS CHAR(1)) TIP'
              + ',CAST('''' AS VARCHAR(5)) DOVKOD'
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR'
              + ',CAST(''Önceki Tarihten Hesaplanan'' AS VARCHAR(100)) ACIKLAMA'
              + ',CAST(0 AS NUMERIC(18,4)) DOVKUR'
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR_PROJE_DOVKOD'
              + ', (SELECT SUM(TUTAR) FROM CARIHAR WHERE (CARIHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and CARIHAR.PROJE_KOD =PROJE.PROJE_KOD and CARIHAR.TIP=''B'') CBorc '
              + ', (SELECT SUM(TUTAR) FROM CARIHAR WHERE (CARIHAR.TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS) +' AND '+SQL_Tarih(dtpIslemTar1.Date-1)+') and CARIHAR.PROJE_KOD =PROJE.PROJE_KOD and CARIHAR.TIP=''A'') CAlacak '
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB '
              + ' FROM PROJE'
              //+ ' INNER JOIN PROJEHAR ON (PROJEHAR.PROJE_KOD = PROJE.PROJE_KOD)'
              + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs
              + '  group by PROJE.PROJE_KOD,PROJE.PROJE_AD,PROJE.DOVKOD '
              + ' Union ';

              strSQL := strSQL+'SELECT  PROJE.PROJE_KOD'
              + ',PROJE.PROJE_AD'
              + ',PROJE.DOVKOD AS PROJE_DOVKOD'
              + ',CAST(''01.01.2007'' AS DATE) TARIH'
              + ',CAST(0 AS INTEGER) BELGE_ID'
              + ',CAST(0 AS INTEGER) BELGE_TUR'
              + ',CAST(''01.01.2007'' AS DATE) DOV_BAZ_TAR'
              + ',CAST('''' AS CHAR(1)) TIP'
              + ',CAST('''' AS VARCHAR(5)) DOVKOD'
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR'
              + ',CAST(''DEVÝR'' AS VARCHAR(100)) ACIKLAMA'
              + ',CAST(0 AS NUMERIC(18,4)) DOVKUR'
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR_PROJE_DOVKOD'
              + ', PROJE.DEVREDEN_BORC CBorc '
              + ', PROJE.DEVREDEN_ALACAK CAlacak '
              + ',CAST(0 AS NUMERIC(18,4)) TUTAR_VPB FROM PROJE'
              + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs;

           end;
           strSQL :=strSQL+ ' union ';




    if rdSec.ItemIndex=2 then
      strSQL :=strSQL+  'SELECT  PROJE.PROJE_KOD'
              + ',PROJE.PROJE_AD'
              + ',PROJE.DOVKOD AS PROJE_DOVKOD'
              + ',CARIHAR.TARIH'
              + ',CARIHAR.BELGE_ID'
              + ',CARIHAR.BELGE_TUR'
              + ',CARIHAR.DOV_BAZ_TAR'
              + ',CARIHAR.TIP'
              + ',CARIHAR.DOVKOD'
              + ',CARIHAR.TUTAR'
              + ',CARIHAR.ACIKLAMA'
              + ',CARIHAR.DOVKUR'
              + ',CARIHAR.TUTAR TUTAR_PROJE_DOVKOD'
              + ',(case when  CARIHAR.TIP=''B'' then '
              + 'CARIHAR.TUTAR_VPB else 0 end) CBorc '
              + ',(case when  CARIHAR.TIP=''A'' then '
              + 'CARIHAR.TUTAR_VPB else 0 end ) CAlacak '
              + ',CARIHAR.TUTAR_VPB'
              + ' FROM PROJE'
              + ' INNER JOIN CARIHAR ON (CARIHAR.PROJE_KOD = PROJE.PROJE_KOD)'
              + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs
              + ' and (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';

    if (rdSec.ItemIndex=0) or (rdSec.ItemIndex=1) then
      strSQL := strSQL+ 'SELECT  PROJE.PROJE_KOD'
              + ',PROJE.PROJE_AD'
              + ',PROJE.DOVKOD AS PROJE_DOVKOD'
              + ',CARIHAR.TARIH'
              + ',CARIHAR.BELGE_ID'
              + ',CARIHAR.BELGE_TUR'
              + ',CARIHAR.DOV_BAZ_TAR'
              + ',CARIHAR.TIP'
              + ',CARIHAR.DOVKOD'
              + ',CARIHAR.TUTAR'
              + ',CARIHAR.ACIKLAMA'
              + ',CARIHAR.DOVKUR'
              + ',CARIHAR.TUTAR TUTAR_PROJE_DOVKOD'
              + ',(case when  CARIHAR.TIP=''B'' then '
              + 'CARIHAR.TUTAR else 0 end) CBorc '
              + ',(case when  CARIHAR.TIP=''A'' then '
              + 'CARIHAR.TUTAR else 0 end ) CAlacak '
              + ',CARIHAR.TUTAR_VPB'
              + ' FROM PROJE'
              //              + ' INNER JOIN CARIHAR ON (CARIHAR.PROJE_KOD = PROJE.PROJE_KOD) AND (CARIHAR.CARIHAR_SID=PROJE.PROJE_SID)'
              + ' INNER JOIN CARIHAR ON (CARIHAR.PROJE_KOD = PROJE.PROJE_KOD)'
              + ' WHERE PROJE.PROJE_KOD =' + SQL_Katar(txtProjeKod1.Text) + strSQLs
              + ' and (CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date) +' AND '+SQL_Tarih(dtpIslemTar2.Date)+')';


              {if glb_SUBELI then
              begin
                SubeID := DataMod.SubeAd2ID(cmbSube.Text);
                if SubeID <> '0' then
                begin
                  strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = ' + SubeID;
                end;
              end
              else
              begin
                strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = ' + inttostr(glb_SID);
              end;}
      if Sender<>Btn_Fast then
      strSQL := strSQL + ' ORDER BY CARIHAR.TARIH,CARIHAR.CARIHAR_ID';

    end;
  end;
  frmRaporCiktisi_Open(Sender,strSQL);
end;

procedure TfrmRaporProjeHareketleri.frmRaporCiktisi_Open(Sender: TObject;strSQL : String);
begin
  with frmRaporProjeHareketleri.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if (frmRaporProjeHareketleri.qryRapor.Eof and frmRaporProjeHareketleri.qryRapor.Bof) then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    exit;
  end
  else
  begin


  if Sender=btn_Fast Then
  begin

  with frmRaporProjeHareketleri.IB_Query1 do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

       Prv_Yazdirildi:=False;
       if rdSec.ItemIndex<>0 then
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Proje_Hareket.fr3');
       if rdSec.ItemIndex=0 then
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Proje_Hareket_Dov.fr3');

      { if cmbGrup.itemindex=0 then
       begin
         a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
         a.Visible:=True;
         a.Height:=20;
       end
       else
         a.Height:=0;
      }
       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;

      end;
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;
    if chk_Sirket.Checked then
    begin
      frmRaporCiktisi.SetCellFont(0,2,1,2,[fsBold],8,'MS Sans Serif',2);
      frmRaporCiktisi.SetCellAlignment(0,3,0,3,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(1,3,1,3,haLEFT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(2,3,2,3,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(5,3,5,3,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(7,3,8,3,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellFont(0,3,8,3,[fsBold],8,'MS Sans Serif',4);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,1,1,[fsBold],8,'MS Sans Serif',2);
      frmRaporCiktisi.SetCellAlignment(0,2,0,2,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(1,2,1,2,haLEFT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(2,2,2,2,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(5,2,5,2,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellAlignment(7,2,8,2,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellFont(0,2,8,2,[fsBold],8,'MS Sans Serif',4);
    end;
    case rdTablo.ItemIndex of
    0:
      begin
        case rdSec.ItemIndex of
        1:
          begin
            prv_borc := prv_borc + dvr_borc;
            prv_alacak := prv_alacak + dvr_alacak;
            inc(row);
            frmRaporCiktisi.SetCellText(row,4,'Borç');
            frmRaporCiktisi.SetCellText(row,5,'Alacak');
            frmRaporCiktisi.SetCellText(row,6,'Bakiye');
            inc(row);
            if prv_dovkod = glb_DEFCUR then
            begin
              frmRaporCiktisi.SetCellFormat(4,row,4,row,3);
              frmRaporCiktisi.SetCellFormat(5,row,5,row,3);
            end
            else
            begin
              frmRaporCiktisi.SetCellFormat(4,row,4,row,4);
              frmRaporCiktisi.SetCellFormat(5,row,5,row,4);
            end;
            frmRaporCiktisi.SetCellText(row,4,CurrToStr(prv_borc));
            frmRaporCiktisi.SetCellText(row,5,CurrToStr(prv_alacak));
            if prv_dovkod = glb_DEFCUR then
            begin
              frmRaporCiktisi.SetCellFormat(6,row,6,row,3);
            end
            else
            begin
              frmRaporCiktisi.SetCellFormat(6,row,6,row,4);
            end;
            if prv_borc > prv_alacak then
            begin
              frmRaporCiktisi.SetCellText(row,6,CurrToStr(prv_borc - prv_alacak));
            end
            else
            if prv_borc < prv_alacak then
            begin
              frmRaporCiktisi.SetCellText(row,6,CurrToStr(prv_alacak - prv_borc));
            end
            else
            begin
              frmRaporCiktisi.SetCellText(row,6,'0');
            end;
          end;
        2:
          begin
            prv_borc := prv_borc + dvr_borc;
            prv_alacak := prv_alacak + dvr_alacak;
            inc(row);
            frmRaporCiktisi.SetCellText(row,4,'Borç');
            frmRaporCiktisi.SetCellText(row,5,'Alacak');
            frmRaporCiktisi.SetCellText(row,6,'Bakiye');
            inc(row);
            frmRaporCiktisi.SetCellText(row,4,CurrToStr(prv_borc));
            frmRaporCiktisi.SetCellFormat(4,row,4,row,3);
            frmRaporCiktisi.SetCellText(row,5,CurrToStr(prv_alacak));
            frmRaporCiktisi.SetCellFormat(5,row,5,row,3);
            frmRaporCiktisi.SetCellFormat(6,row,6,row,3);
            if prv_borc > prv_alacak then
            begin
              frmRaporCiktisi.SetCellText(row,6,CurrToStr(prv_borc - prv_alacak));
            end
            else
            if prv_borc < prv_alacak then
            begin
              frmRaporCiktisi.SetCellText(row,6,CurrToStr(prv_alacak - prv_borc));
            end
            else
            begin
              frmRaporCiktisi.SetCellText(row,6,'0');
            end;
          end;
        end;//end case
      end;
    1:
      begin
        prv_borc := prv_borc + dvr_borc;
        prv_alacak := prv_alacak + dvr_alacak;
        inc(row);
        frmRaporCiktisi.SetCellText(row,4,'Borç');
        frmRaporCiktisi.SetCellText(row,5,'Alacak');
        frmRaporCiktisi.SetCellText(row,6,'Bakiye');
        inc(row);
        frmRaporCiktisi.SetCellText(row,4,CurrToStr(prv_borc));
        frmRaporCiktisi.SetCellFormat(4,row,4,row,3);
        frmRaporCiktisi.SetCellText(row,5,CurrToStr(prv_alacak));
        frmRaporCiktisi.SetCellFormat(5,row,5,row,3);
        frmRaporCiktisi.SetCellFormat(6,row,6,row,3);
        if prv_borc > prv_alacak then
        begin
          frmRaporCiktisi.SetCellText(row,6,CurrToStr(prv_borc - prv_alacak));
        end
        else
        if prv_borc < prv_alacak then
        begin
          frmRaporCiktisi.SetCellText(row,6,CurrToStr(prv_alacak - prv_borc));
        end
        else
        begin
          frmRaporCiktisi.SetCellText(row,6,'0');
        end;
      end;
    end;
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;


procedure TfrmRaporProjeHareketleri.yaz;
var
  res_Cari : TStringList;
  SubeID : String;
begin
  row := 0;
  col := 0;
  prv_borc := 0;
  prv_alacak := 0;
  dvr_borc := 0;
  dvr_alacak := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    frmRaporProjeHareketleri.row := 1;
  end;

  frmRaporCiktisi.SetCellText(1,5,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(5,1,5,1,[fsBold],8,'MS Sans Serif',0);

  frmRaporCiktisi.SetCellText(row,col+2,'PROJE HAREKETLERÝ LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',2);

  inc(row);
  frmRaporProjeHareketleri.col := 0;

  case rdSec.ItemIndex of
  0:
    begin
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_KOD').AsString);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_AD').AsString);
    end;
  1:
    begin
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_KOD').AsString);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_AD').AsString);
      inc(col);
      case rdTablo.ItemIndex of
      0:
        begin
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_DOVKOD').AsString);
          prv_dovkod := qryRapor.FieldByName('PROJE_DOVKOD').AsString;
        end;
      1:
        begin
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);
          prv_dovkod := qryRapor.FieldByName('DOVKOD').AsString;
        end;
      end;
    end;
  2:
    begin
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_KOD').AsString);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_AD').AsString);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,glb_DEFCUR);
    end;
  end;

  col := 0;
  alan_isimlerini_ekle;
  with qryProje do
  begin
    if Active then Active := false;
    SQL.Clear;
    SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM PROJE WHERE PROJE_KOD=' + SQL_Katar(txtProjeKod1.Text));
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add(' AND PROJE.PROJE_SID = ' + SubeID);
      end;
    end
    else
    begin
      SQL.Add(' AND PROJE.PROJE_SID = ' + inttostr(glb_SID));
    end;

    Active := True;
    dvr_borc := FieldByName('DEVREDEN_BORC').AsCurrency;
    dvr_alacak := FieldByName('DEVREDEN_ALACAK').AsCurrency;
    Active := False;
  end;

  if dvr_borc > dvr_alacak then
  begin
    dvr_borc := dvr_borc - dvr_alacak;
    dvr_alacak := 0;
    col := 3;
    frmRaporCiktisi.SetCellText(row,col,'Borç');
    col := 4;
    frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
    col := 8;
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(dvr_borc));
    inc(row);
  end
  else
  if dvr_borc < dvr_alacak then
  begin
    dvr_alacak := dvr_alacak - dvr_borc;
    dvr_borc := 0;

    col := 3;
    frmRaporCiktisi.SetCellText(row,col,'Alacak');
    col := 4;
    frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
    col := 8;
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(dvr_alacak));
    inc(row);
  end
  else
  if dvr_borc = dvr_alacak then
  begin
    dvr_borc := 0;
    dvr_alacak := 0;
    inc(row);
  end;

  qryRapor.First;
  while not qryRapor.Eof do
  begin
    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,4);

    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TARIH').AsDateTime);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRapor.FieldByName('BELGE_TUR').AsInteger));
    case qryRapor.FieldByName('BELGE_TUR').AsInteger of
    14:
      begin
{
        with qryProje do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT ISLEM_TIP,BELGE_ID FROM KASAHAR WHERE KASAHAR_ID = '+qryRapor.FieldByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND KASAHAR_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND KASAHAR_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;
        if qryProje.FieldByName('ISLEM_TIP').AsInteger = 5 then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryProje.FieldByName('BELGE_ID').AsString);
          qryProje.Active := False;
        end
        else
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
        end;
}
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
      end;
    17:
      begin
        with qryProje do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT DEKONT_ID FROM DEKONT_D WHERE DEKONT_D_ID ='+qryRapor.FieldByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND DEKONT_D_SID = ' + SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND DEKONT_D_SID = ' + inttostr(glb_SID));
          end;
          Active := True;
        end;
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryProje.FieldByName('DEKONT_ID').AsString);
        qryProje.Active := False;
      end;
    else
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
      end;
    end;//end case

    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    inc(col);
    case rdTablo.ItemIndex of
    0:
      begin
        case rdSec.ItemIndex of
        0:
          begin
            frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('DOV_BAZ_TAR').AsDateTime);
            inc(col);
            frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKOD').AsString);
            inc(col);

            frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('DOVKUR').AsString);
            frmRaporCiktisi.format_ayarla(col,row,col,row);
            inc(col);
            if qryRapor.FieldByName('TIP').AsString = 'B' then
            begin
              frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR').AsString);
              if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row) else frmRaporCiktisi.format_ayarla(col,row,col,row);
              inc(col);
              frmRaporCiktisi.SetCellText(row,col,'0');
              if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row) else frmRaporCiktisi.format_ayarla(col,row,col,row);
            end
            else
            begin
              frmRaporCiktisi.SetCellText(row,col,'0');
              if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row) else frmRaporCiktisi.format_ayarla(col,row,col,row);
              inc(col);
              frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR').AsString);
              if qryRapor.FieldByName('DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row) else frmRaporCiktisi.format_ayarla(col,row,col,row);
            end;
          end;
        1:
          begin
            if qryRapor.FieldByName('TIP').AsString = 'B' then
            begin
              frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_PROJE_DOVKOD').AsString);
              if qryRapor.FieldByName('PROJE_DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row) else frmRaporCiktisi.format_ayarla(col,row,col,row);
              inc(col);
              frmRaporCiktisi.SetCellText(row,col,'0');
              if qryRapor.FieldByName('PROJE_DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row) else frmRaporCiktisi.format_ayarla(col,row,col,row);
              prv_borc := prv_borc + qryRapor.FieldByName('TUTAR_PROJE_DOVKOD').AsCurrency;
            end
            else
            begin
              frmRaporCiktisi.SetCellText(row,col,'0');
              if qryRapor.FieldByName('PROJE_DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row) else frmRaporCiktisi.format_ayarla(col,row,col,row);
              inc(col);
              frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_PROJE_DOVKOD').AsString);
              if qryRapor.FieldByName('PROJE_DOVKOD').AsString = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row) else frmRaporCiktisi.format_ayarla(col,row,col,row);
              prv_alacak := prv_alacak + qryRapor.FieldByName('TUTAR_PROJE_DOVKOD').AsCurrency;
            end;
          end;
        2:
          begin
            if qryRapor.FieldByName('TIP').AsString = 'B' then
            begin
              frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
              frmRaporCiktisi.format_ayarla(col,row,col,row);
              inc(col);
              frmRaporCiktisi.SetCellText(row,col,'0');
              frmRaporCiktisi.format_ayarla(col,row,col,row);
              prv_borc := prv_borc + qryRapor.FieldByName('TUTAR_VPB').AsCurrency;
            end
            else
            begin
              frmRaporCiktisi.SetCellText(row,col,'0');
              frmRaporCiktisi.format_ayarla(col,row,col,row);
              inc(col);
              frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
              frmRaporCiktisi.format_ayarla(col,row,col,row);
              prv_alacak := prv_alacak + qryRapor.FieldByName('TUTAR_VPB').AsCurrency;
            end;
          end;
        end;
      end;
    1:
      begin
        if qryRapor.FieldByName('TIP').AsString = 'B' then
        begin
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,'0');
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          prv_borc := prv_borc + qryRapor.FieldByName('TUTAR_VPB').AsCurrency;
        end
        else
        begin
          frmRaporCiktisi.SetCellText(row,col,'0');
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TUTAR_VPB').AsString);
          frmRaporCiktisi.format_ayarla(col,row,col,row);
          prv_alacak := prv_alacak + qryRapor.FieldByName('TUTAR_VPB').AsCurrency;
        end;
      end;
    end;
    inc(row);
    qryRapor.Next;
  end;
end;

procedure TfrmRaporProjeHareketleri.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Tarih');
  frmRaporCiktisi.SetCellText(row,col+1,'Belge Türü');
  frmRaporCiktisi.SetCellText(row,col+2,'Fiþ Numarasý');
  frmRaporCiktisi.SetCellText(row,col+3,'Açýklama');
  case rdTablo.ItemIndex of
  0:
    begin
      case rdSec.ItemIndex of
      0:
        begin
          frmRaporCiktisi.SetCellText(row,col+4,'Döviz Baz Tarihi');
          frmRaporCiktisi.SetCellText(row,col+5,'Para Birimi');
          frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
          frmRaporCiktisi.SetCellText(row,col+6,'Döviz Kuru');
          frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
          frmRaporCiktisi.SetCellText(row,col+7,'Borç');
          frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
          frmRaporCiktisi.SetCellText(row,col+8,'Alacak');
          frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
        end;
      1:
        begin
          frmRaporCiktisi.SetCellText(row,col+4,'Borç');
          frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
          frmRaporCiktisi.SetCellText(row,col+5,'Alacak');
          frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
        end;
      2:
        begin
          frmRaporCiktisi.SetCellText(row,col+4,'Borç');
          frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
          frmRaporCiktisi.SetCellText(row,col+5,'Alacak');
          frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
        end;
      end;
    end;
  1:
    begin
      frmRaporCiktisi.SetCellText(row,col+4,'Borç');
      frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
      frmRaporCiktisi.SetCellText(row,col+5,'Alacak');
      frmRaporCiktisi.SetCellAlignment(col,row,col,row,haRIGHT,vaCENTER);
    end;
  end;
  inc(row);
end;

procedure TfrmRaporProjeHareketleri.FormKeyPress(Sender: TObject;  var Key: Char);
begin
  if key = #27 then
  begin
    Close;
  end;
  if key = #13 then
  begin
    Key := #0;
    SelectNext(ActiveControl as tWinControl, True, True);
  end;
end;

procedure TfrmRaporProjeHareketleri.txtProjeKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporProjeHareketleri.rdSecEnter(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporProjeHareketleri.rdSecExit(Sender: TObject);
begin
  (Sender as TRadioGroup).Color := clBtnFace;
end;

procedure TfrmRaporProjeHareketleri.chk_SirketEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporProjeHareketleri.chk_SirketExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporProjeHareketleri.cmbSubeEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporProjeHareketleri.cmbSubeExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporProjeHareketleri.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporProjeHareketleri);
end;

procedure TfrmRaporProjeHareketleri.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
var
  SubeID:String;
begin
     if ARow.ByName('BELGE_TUR').AsInteger>0 then
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('BELGE_TUR').AsInteger);


    case ARow.ByName('BELGE_TUR').AsInteger of
    14:
      begin

        with qryProje do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT DEKONT_ID FROM DEKONT_D WHERE DEKONT_D_ID ='+qryRapor.FieldByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND DEKONT_D_SID = ' + SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND DEKONT_D_SID = ' + inttostr(glb_SID));
          end;
          Active := True;
        end;

        ARow.ByName('CALC_BELGE_ID').AsInteger :=qryProje.FieldByName('BELGE_ID').AsInteger;
        qryProje.Active := False;
      end;
    else
      begin
          ARow.ByName('CALC_BELGE_ID').AsInteger :=ARow.ByName('BELGE_ID').AsInteger;
      end;
   end;

end;

procedure TfrmRaporProjeHareketleri.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin

         res_Cari := TStringList.Create;
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
       end;
        }


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);


       c:=(frxReport1.FindComponent('Memo1') as TfrxMemoView);
       c.memo.Text:=txtProjeKod1.Text;

       {c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);
       }


      { d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
      }

       Prv_Yazdirildi:=True;
    end;


end;

end.
