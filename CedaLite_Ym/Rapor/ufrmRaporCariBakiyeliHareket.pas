{$INCLUDE directive.inc}

unit ufrmRaporCariBakiyeliHareket;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Buttons, StdCtrls,
   frxClass, frxIBOSet,IB_Components, IB_Controls,cxSSTypes,cxSSHeaders;

type
  TfrmRaporCariBakiyeliHareket = class(TForm)
    qryRapor: TIB_Cursor;
    qryToplam: TIB_Cursor;
    Panel1: TPanel;
    btnRapor: TButton;
    btnCikis: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    btnCariListesi: TButton;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    GroupBox4: TGroupBox;
    cmbParaBirimi: TComboBox;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    chk_Sirket: TCheckBox;
    chk_devir: TCheckBox;
    TabSheet2: TTabSheet;
    lblISLEMMERKEZI: TLabel;
    lblKOD1: TLabel;
    lblKOD2: TLabel;
    lblKOD3: TLabel;
    lblKOD4: TLabel;
    txtISLEMMERKEZI: TEdit;
    btnISLEMMERKEZI: TButton;
    txtKOD1: TEdit;
    btnKOD1: TButton;
    txtKOD2: TEdit;
    btnKOD2: TButton;
    txtKOD3: TEdit;
    btnKOD3: TButton;
    txtKOD4: TEdit;
    btnKOD4: TButton;
    chk_Harmanla: TCheckBox;
    lstCariKod: TListBox;
    chk_Sayfalar: TCheckBox;
    txt_ilk_Cari: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    cb_Kod_Araligi: TCheckBox;
    txt_son_Cari: TEdit;
    Button6: TButton;
    Button1: TButton;
    qryTemp: TIB_Cursor;
    chk_Sefer: TCheckBox;
    frxReport1: TfrxReport;
    frxIBOmaster: TfrxIBODataset;
    frxIBOdetail: TfrxIBODataset;
    IB_DataSource1: TIB_DataSource;
    IB_Query1: TIB_Query;
    IB_Query2: TIB_Query;
    Btn_Fast: TButton;
    Memo1: TMemo;
    IB_Query3: TIB_Query;
    IB_Query4: TIB_Query;
    IB_DataSource2: TIB_DataSource;
    cb_Bakiye: TComboBox;
    Label3: TLabel;
    Cb_Cari_Yas: TCheckBox;
    Label4: TLabel;
    chk_Mazot: TCheckBox;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open(Menu:Boolean);
    procedure Alan_Isimlerini_Ekle(Tip:Byte);
    procedure ToplamBul(CariKod:String);
    procedure DevirIcinToplamBul(CariKod:String;Tip:Byte);
    procedure Rapor_Bitti;
    procedure SQL_Hazirla(UseCariKod:Boolean;CariKod:String);
    procedure Yaz;
    procedure SirketBilgisiEkle;
    procedure CariBilgisiEkle;
    procedure DevirBilgisiEkle(Tip:Byte;CariKod:String);
    procedure AltAltaAyriYaz;
    procedure CarileriHarmanla;
    procedure SayfalarHalindeYaz;
    procedure RaporTarihiEkle;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRaporClick(Sender: TObject);
    procedure btnCariListesiClick(Sender: TObject);
    procedure btnCikisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure dtpIslemTar1Enter(Sender: TObject);
    procedure dtpIslemTar2Enter(Sender: TObject);
    procedure dtpIslemTar1Exit(Sender: TObject);
    procedure dtpIslemTar2Exit(Sender: TObject);
    procedure cmbParaBirimiEnter(Sender: TObject);
    procedure cmbParaBirimiExit(Sender: TObject);
    procedure chk_devirEnter(Sender: TObject);
    procedure chk_devirExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure lstCariKodKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure btnISLEMMERKEZIClick(Sender: TObject);
    procedure txtKOD1Exit(Sender:TObject);
    procedure txtKOD2Exit(Sender:TObject);
    procedure txtKOD3Exit(Sender:TObject);
    procedure txtKOD4Exit(Sender:TObject);
    procedure btnKOD1Click(Sender:TObject);
    procedure btnKOD2Click(Sender:TObject);
    procedure btnKOD3Click(Sender:TObject);
    procedure btnKOD4Click(Sender:TObject);
    procedure txtKOD1KeyUp(Sender:TObject; var Key: Word;Shift: TShiftState);
    procedure txtKOD2KeyUp(Sender:TObject; var Key: Word;Shift: TShiftState);
    procedure txtKOD3KeyUp(Sender:TObject; var Key: Word;Shift: TShiftState);
    procedure txtKOD4KeyUp(Sender:TObject; var Key: Word;Shift: TShiftState);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure txt_ilk_CariExit(Sender: TObject);
    procedure txt_son_CariExit(Sender: TObject);
    procedure txt_ilk_CariEnter(Sender: TObject);
    procedure txt_ilk_CariKeyPress(Sender: TObject; var Key: Char);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure IB_Query2CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
    procedure IB_Query1AfterScroll(IB_Dataset: TIB_Dataset);
    procedure IB_Query4CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
////////////////////////////////////////////////////////////////////////////////
  private
    row,col,Prv_Id:integer;
    genel_alacak,genel_borc:Currency;
    Prv_Yazdirildi,Prv_Hesap:Boolean;
    prv_cl_Borc,prv_cl_Alacak:Double;
    { Private declarations }
  public
    { Public declarations }
  end;

const cns_rapor_cari_bakiyeli_hareket = 2;

var
  frmRaporCariBakiyeliHareket: TfrmRaporCariBakiyeliHareket;

implementation

uses unDataMod, ufrmRaporCiktisi, ufrmCariSDLG, unFunc, DateUtils, main;

{$R *.dfm}

procedure TfrmRaporCariBakiyeliHareket.Form_Open(Menu:Boolean);
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_rapor_cari_bakiyeli_hareket,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporCariBakiyeliHareket') then
    begin
      Application.CreateForm(TfrmRaporCariBakiyeliHareket,frmRaporCariBakiyeliHareket);
      with frmRaporCariBakiyeliHareket.cmbParaBirimi do
      begin
        Items.Add(glb_DEFCUR);
        Items.AddStrings(glb_TAK_DOV_LIST);
        ItemIndex := 0;
      end;
//****************************************************************************//
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporCariBakiyeliHareket.cmbSube.Items);
          with frmRaporCariBakiyeliHareket do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporCariBakiyeliHareket.cmbSube do
          begin
            Clear;
            Items.Add(DataMod.SubeID2Ad(False,glb_SID));
            ItemIndex := 0;
            Enabled := False;
          end;
          frmRaporCariBakiyeliHareket.grpSube.Visible := True;
        end;
      end
      else
      begin
        frmRaporCariBakiyeliHareket.grpSube.Visible := False;
      end;//end if glb_SUBELI then

      with frmRaporCariBakiyeliHareket do
      begin
  {$IfDef TRANSPORT}
        TabSheet2.Visible := false;
  {$EndIf}
      end;
//****************************************************************************//
    end;//end if not MainForm.FindChildFrm(Application,'frmRaporCariBakiyeliHareket') then
  end;//end if not DataMod.Modul_Hak(prv_RAPOR_CARI_BAKIYELI_MODUL_ID,local_CanUpdate,local_CanDelete) then
end;

procedure TfrmRaporCariBakiyeliHareket.btnCariListesiClick(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) then
  begin
    if lstCariKod.Items.IndexOf(CARI_KOD) = -1 then
       lstCariKod.Items.Add(CARI_KOD);
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporCariBakiyeliHareket.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporCariBakiyeliHareket.btnCikisClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRaporCariBakiyeliHareket.btnRaporClick(Sender: TObject);
var
  a:TfrxGroupHeader;//TfrxComponent;
  strSQL,strSQL1,CariLst:String;
  i:Integer;
  SubeID:String;
begin
  genel_alacak := 0;
  genel_borc := 0;

  if cb_Kod_Araligi.Checked=False then
  if lstCariKod.Count = 0 then
  begin
    Application.MessageBox('Cari se?imi yapmadan rapor alamazs?n?z.','Dikkat',MB_ICONWARNING);
    btnCariListesiClick(Self);
    exit;
  end;
  if cb_Kod_Araligi.Checked then
  begin
    if (Trim(txt_ilk_Cari.Text)='') or (Trim(txt_Son_Cari.Text)='') then
    begin
    Application.MessageBox('?lk Son Kodlar? Se?iniz.','Dikkat',MB_ICONWARNING);
    exit;
    end;
  end;
//****************************************************************************//
  if CompareDate(dtpIslemTar1.Date,dtpIslemTar2.Date) = 1 then
  begin
    Application.MessageBox('?lk i?lem tarihi ikinci tarihten b?y?k olamaz.L?tfen i?lem tarihlerini kontrol ediniz.','Dikkat',MB_ICONWARNING);
    exit;
  end;




     if sender=Btn_Fast then
     begin
{
          IB_Query1.Close;
          IB_Query1.Sql.Clear;
          IB_Query1.Sql.Add(
'SELECT CARI_KOD '+
'     , CARI_SID '+
'     , CARI_AD '+
'     , YETKISI '+
'     , VERDAIRE '+
'     , VERNO '+
'     , ADRES_1 '+
'     , ADRES_2 '+
'     , ILCE '+
'     , SEHIR '+
'     , POSTA_KOD '+
'     , TIP '+
'     , TEL_NO_1 '+
'     , TEL_NO_2 '+
'     , FAX '+
'     , E_MAIL '+
'     , WEB_ADDR '+
'     , NOTES '+
'     , KREDILMT '+
'     , RISK '+
'     , BORC '+
'     , ALACAK '+
'     , ULKE '+
'     , YURTDISI '+
'     , ISLEMTIP '+
'     , MUHTELIF '+
'     , DEVREDEN_BORC '+
'     , DEVREDEN_ALACAK '+
'     , DOVIZLI '+
'     , DOVKOD '+
'FROM CARI '+
'Where CARI_KOD<>'''' ');

    strSQL:='';
    if not cb_Kod_Araligi.Checked then
    begin
         CariLst := '';
         for i := 0 to lstCariKod.Count - 1 do
         begin
           CariLst := CariLst + SQL_Katar(lstCariKod.Items[i]) + ','
         end;
         CariLst := copy(CariLst,1,Length(CariLst)-1);

         if (cmbParaBirimi.Text = glb_DEFCUR) then
         begin
           strSQL := strSQL + ' AND CARI.CARI_KOD IN ('+CariLst+')';
         end
         else
         begin
           //strSQL := strSQL + ' AND CARI.CARI_KOD IN ('+CariLst+') AND CARIHAR_DOV.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text);
           strSQL := strSQL + ' AND CARI.CARI_KOD IN ('+CariLst+')' ;
         end;

          IB_Query1.Sql.Add(strSQL);
    end;

    if cb_Kod_Araligi.Checked then
    begin
     strSQL := strSQL + ' AND CARI_KOD BETWEEN '+Sql_Katar(txt_ilk_Cari.Text)+' AND '+Sql_Katar(txt_son_Cari.Text)+' ORDER BY CARI_KOD';
     //IB_Query1.ParamByName('ILK').AsString:=txt_ilk_Cari.Text;
     //IB_Query1.ParamByName('SON').AsString:=txt_son_Cari.Text;
     IB_Query1.Sql.Add(strSQL);
    end;



          IB_Query1.Open;


          IB_Query2.Close;
          IB_Query2.Sql.Clear;
          IB_Query2.Sql.Add(
'SELECT CARIHAR_ID '+
'     , CARIHAR_SID '+
'     , CARI_KOD '+
'     , TIP '+
'     , BELGE_TUR '+
'     , BELGE_ID '+
'     , BELGE_SID '+
'     , TARIH '+
'     , SIRA_NO '+
'     , FIILI_TAR '+
'     , DOV_BAZ_TAR '+
'     , VADETAR '+
'     , DOVKOD '+
'     , DOVKUR '+
'     , TUTAR '+
'     , TUTAR_VPB '+
'     , ACIKLAMA '+
'     , MASRAF_MERK '+
'     , KOD1 '+
'     , KOD2 '+
'     , KOD3 '+
'     , KOD4 '+
'     , PLASIYER_KOD '+
'     , PROJE_KOD '+
'    , '+
'    (CASE '+
'    WHEN TIP=''B'' THEN  TUTAR_VPB '+
'    ELSE 0   '+
'    END) BORC '+
'    ,(CASE '+
'    WHEN TIP=''A'' THEN  TUTAR_VPB '+
'    ELSE 0 '+
'    END) ALACAK '+
'FROM CARIHAR WHERE CARIHAR_ID>0 ');
if chk_Sefer.Checked=False then
IB_Query2.Sql.Add(' AND ((BELGE_TUR<>41) and (BELGE_TUR<>42))');

IB_Query2.Sql.Add(' AND TARIH BETWEEN :ILK AND :SON');
IB_Query2.ParamByName('ILK').AsDate:=dtpIslemTar1.Date;
IB_Query2.ParamByName('SON').AsDate:=dtpIslemTar2.Date;

if Trim(txtISLEMMERKEZI.Text)<>'' then
IB_Query2.Sql.Add(' AND MASRAF_MERK='+Sql_Katar(Trim(txtISLEMMERKEZI.Text)));
if Trim(txtKOD1.Text)<>'' then
IB_Query2.Sql.Add(' AND KOD1='+Sql_Katar(Trim(txtKOD1.Text)));
if Trim(txtKOD2.Text)<>'' then
IB_Query2.Sql.Add(' AND KOD2='+Sql_Katar(Trim(txtKOD2.Text)));
if Trim(txtKOD3.Text)<>'' then
IB_Query2.Sql.Add(' AND KOD3='+Sql_Katar(Trim(txtKOD3.Text)));
if Trim(txtKOD4.Text)<>'' then
IB_Query2.Sql.Add(' AND KOD4='+Sql_Katar(Trim(txtKOD4.Text)));

          IB_Query2.Open;
}

          IB_Query3.Close;
          IB_Query3.Sql.Clear;
          IB_Query4.Close;
          IB_Query4.Sql.Clear;
strSQL:=
'    select '+
'    prm_cari_kod, '+
'    prm_cari_ad, '+
'    prm_cari_borc, '+
'    prm_cari_alacak, '+
'    prm_cari_dev_borc, '+
'    prm_cari_dev_alacak, '+
'    prm_cari_borc_bakiye, '+
'    prm_cari_alacak_bakiye '+
'    from cari_liste(:devir,:ilk,:son,:inkod,:kullan_tip,:dovkod,null) ';

          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if (SubeID <> '0') and (Trim(SubeID)<>'') then
            begin
               strSQL :=strSQL+ 'Where cari_liste.prm_cari_sid ='+SubeID;
            end;
          end
          else
          begin
               strSQL :=strSQL+ 'Where cari_liste.prm_cari_sid ='+Inttostr(Glb_Sid);
          end;



  if cb_Bakiye.ItemIndex=1 then
  if chk_devir.Checked then
   strSQL :=strSQL+ ' and (cari_liste.prm_cari_borc_bakiye+cari_liste.prm_cari_dev_borc>cari_liste.prm_cari_alacak_bakiye+cari_liste.prm_cari_dev_alacak) ';


  if cb_Bakiye.ItemIndex=2 then
  if chk_devir.Checked then
   strSQL :=strSQL+ ' and (cari_liste.prm_cari_alacak_bakiye+cari_liste.prm_cari_dev_alacak>cari_liste.prm_cari_borc_bakiye+cari_liste.prm_cari_dev_borc) ';


  if cb_Bakiye.ItemIndex=1 then
  if not chk_devir.Checked then
   strSQL :=strSQL+ ' and (cari_liste.prm_cari_borc_bakiye>cari_liste.prm_cari_alacak_bakiye) ';


  if cb_Bakiye.ItemIndex=2 then
  if not chk_devir.Checked then
   strSQL :=strSQL+ ' and (cari_liste.prm_cari_alacak_bakiye>cari_liste.prm_cari_borc_bakiye) ';




{
kod araligi in para birimi
kullan_tip=1 tumu
2 aral?k
3 inkod
4 grup
}
strSQL1:=
'select '+
'    prm_cari_kod, '+
'    prm_tarih, '+
'    prm_belge_tur, '+
'    prm_fis_no, '+
'    prm_aciklama, '+
'    prm_tip, '+
'    prm_borc, '+
'    prm_alacak, '+
'    prm_cari_borc_bakiye, '+
'    prm_cari_alacak_bakiye, '+
'    prm_cari_dev_borc_bakiye, '+
'    prm_cari_dev_alacak_bakiye '+
//' from cari_liste_har(:devir,null,:dovkod,:tar1,:tar2,:sefer_mazot,:devir,null) ';
' from cari_liste_har(:devir,:prm_cari_kod1,:dovkod,:tar1,:tar2,:sefer_mazot,:devir,null) ';



if Cb_Cari_Yas.Checked then
strSQL1:=
' select '+
'    prm_cari_kod, '+
'    prm_tarih, '+
'    prm_belge_tur, '+
'    prm_fis_no, '+
'    prm_aciklama, '+
'    prm_tip, '+
'    prm_borc, '+
'    prm_alacak, '+
'    prm_cari_borc_bakiye, '+
'    prm_cari_alacak_bakiye, '+
'    prm_cari_dev_borc_bakiye, '+
'    prm_cari_dev_alacak_bakiye '+
' from CARI_YAS_HAR(:devir,:prm_cari_kod1,:dovkod,:tar1,:tar2,:tarx1,:tarx2,:sefer_mazot,null) ';



          IB_Query3.Sql.Text:=strSQL;
          IB_Query4.Sql.Text:=strSQL1;


//          IB_Query4.ParamByName('prm_cari_kod1').AsVariant:=null;

          IB_Query3.ParamByName('devir').AsVariant:=null;
          IB_Query3.ParamByName('ilk').AsVariant:=null;
          IB_Query3.ParamByName('son').AsVariant:=null;
          IB_Query3.ParamByName('inkod').AsVariant:=null;
          IB_Query3.ParamByName('kullan_tip').AsVariant:=null;
          IB_Query3.ParamByName('dovkod').AsVariant:=null;


          IB_Query4.ParamByName('devir').AsVariant:=null;
          IB_Query4.ParamByName('tar1').AsVariant:=null;
          IB_Query4.ParamByName('tar2').AsVariant:=null;
          IB_Query4.ParamByName('sefer_mazot').AsVariant:=null;
          IB_Query4.ParamByName('devir').AsVariant:=null;
          IB_Query4.ParamByName('dovkod').AsVariant:=null;


               IB_Query3.ParamByName('kullan_tip').AsInteger:=1;

          if chk_devir.Checked then
          begin
          IB_Query3.ParamByName('devir').AsInteger:=1;
          IB_Query4.ParamByName('devir').AsInteger:=1;
          end
          else
          begin
          IB_Query3.ParamByName('devir').AsInteger:=0;
          IB_Query4.ParamByName('devir').AsInteger:=0;
          end;

          if cb_Kod_Araligi.Checked then
          begin
               IB_Query3.ParamByName('ilk').AsString:=Trim(txt_ilk_Cari.Text);
               IB_Query3.ParamByName('son').AsVariant:=Trim(txt_son_Cari.Text);
               IB_Query3.ParamByName('kullan_tip').AsInteger:=2;
          end
          else
          begin
               CariLst:='';
               for i := 0 to lstCariKod.Count - 1 do
               begin
                 CariLst := CariLst + SQL_Katar(lstCariKod.Items[i]) + ','
               end;
               CariLst := copy(CariLst,1,Length(CariLst)-1);

               IB_Query3.ParamByName('inkod').AsString:=CariLst;
               IB_Query3.ParamByName('kullan_tip').AsInteger:=3;
          end;

         if (cmbParaBirimi.Text <> glb_DEFCUR) then
         begin
         IB_Query3.ParamByName('dovkod').AsString:=cmbParaBirimi.Text;
         IB_Query4.ParamByName('dovkod').AsString:=cmbParaBirimi.Text;
         end;

         IB_Query4.ParamByName('tar1').AsDate:=dtpIslemTar1.Date;
         IB_Query4.ParamByName('tar2').AsDate:=dtpIslemTar2.Date;


         if Cb_Cari_Yas.Checked then
         begin
              IB_Query4.ParamByName('tarx1').AsDate:=glb_DONEM_BAS;
              IB_Query4.ParamByName('tarx2').AsDate:=dtpIslemTar1.Date-1;
         end;


         {if chk_Sefer.Checked then
         IB_Query4.ParamByName('sefer_mazot').AsInteger:=0
         else
         IB_Query4.ParamByName('sefer_mazot').AsInteger:=1;
         }


         if (not chk_Sefer.Checked) and (not chk_Mazot.Checked) then
         IB_Query4.ParamByName('sefer_mazot').AsInteger:=1;

         if chk_Sefer.Checked and chk_Mazot.Checked then
         IB_Query4.ParamByName('sefer_mazot').AsInteger:=0;

         if chk_Sefer.Checked and (not chk_Mazot.Checked) then
         IB_Query4.ParamByName('sefer_mazot').AsInteger:=3;

         if chk_Mazot.Checked and (not chk_Sefer.Checked) then
         IB_Query4.ParamByName('sefer_mazot').AsInteger:=2;

         IB_Query3.Open;
         IB_Query4.Open;


          Prv_Yazdirildi:=False;
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Hareket_proc.fr3');
          if chk_Sayfalar.Checked then
          begin
          a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
          a.StartNewPage:=True;
          end;
          //frxReport1.PrepareReport();
          frxReport1.showReport;
          Exit;
     end;


//***************************************************************************//
  if (chk_Harmanla.Checked = False) and (chk_Sayfalar.Checked = False) then
  begin
    //Se?ili carilerin hareketleri alt alta ayr? ayr? yaz?lacak.
    AltAltaAyriYaz;
  end
  else
  if (chk_Harmanla.Checked) and (chk_Sayfalar.Checked = False) then
  begin
    //Se?ili carilerin hareketleri harmanlanarak tek bir rapor elde edilecek.
    CarileriHarmanla;
  end
  else
  if (chk_Harmanla.Checked) and (chk_Sayfalar.Checked) then
  begin
    //Se?ili carilerin hareketleri harmanlanarak tek bir rapor elde edilecek.
    CarileriHarmanla;
  end
  else
  if (chk_Harmanla.Checked = False) and (chk_Sayfalar.Checked) then
  begin
    //Se?ili carilerin hareketleri raporda ayr? sayfalar halinde verilecek.
    SayfalarHalindeYaz;
  end;
//  SQL_Hazirla;
end;

procedure TfrmRaporCariBakiyeliHareket.SQL_Hazirla(UseCariKod:Boolean;CariKod:String);
var
  SubeID: String;
  i : Byte;
  strSQL,CariLst : String;
begin
//****************************************************************************//
  if (cmbParaBirimi.Text = glb_DEFCUR) then
  begin
    strSQL := 'SELECT CARI.CARI_AD'
            + '      ,CARIHAR.CARI_KOD'
            + '      ,CARIHAR.BELGE_ID'
            + '      ,CARIHAR.TIP'
            + '      ,CARIHAR.KOD1'
            + '      ,CARIHAR.TUTAR_VPB AS TOPLAM'
            + '      ,CARIHAR.TARIH'
            + '      ,CARIHAR.ACIKLAMA'
            + '      ,CARIHAR.BELGE_TUR'
            + '      ,CARIHAR.PROJE_KOD'
            + '      ,CARIHAR.SIRA_NO'

            + ' FROM CARIHAR'
            + ' LEFT OUTER JOIN CARI ON (CARIHAR.CARI_KOD = CARI.CARI_KOD)'
            + ' WHERE CARIHAR.TARIH BETWEEN '+ SQL_Tarih(dtpIslemTar1.Date) + ' AND ' + SQL_Tarih(dtpIslemTar2.Date);
  end
  else
  begin
    strSQL := 'SELECT CARI.CARI_AD,'
            + '       CARIHAR.CARI_KOD,'
            + '       CARIHAR.BELGE_ID,'
            + '       CARIHAR.KOD1,'
            + '       CARIHAR.TIP,'
            + '       CARIHAR_DOV.TUTAR AS TOPLAM,'
            + '       CARIHAR.TARIH,'
            + '       CARIHAR.ACIKLAMA,'
            + '       CARIHAR.BELGE_TUR,'
            + '       CARIHAR.PROJE_KOD,'
            + '       CARIHAR.SIRA_NO'
            + ' FROM CARIHAR'
            + ' LEFT OUTER JOIN CARI ON (CARIHAR.CARI_KOD = CARI.CARI_KOD)'
            + ' LEFT OUTER JOIN CARIHAR_DOV ON (CARIHAR.CARIHAR_ID = CARIHAR_DOV.CARIHAR_ID) AND (CARIHAR.CARIHAR_SID = CARIHAR_DOV.CARIHAR_SID)'
            + ' WHERE CARIHAR.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date)+' AND '+ SQL_Tarih(dtpIslemTar2.Date)
  end;
//****************************************************************************//
  //if not cb_Kod_Araligi.Checked then

  if not chk_Sefer.Checked then
  begin
      //strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER);
      strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER);
  end;


  if not chk_Mazot.Checked then
  begin
      //strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER);
      strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_MAZOT);
  end;
  {
  if (not chk_Sefer.Checked) and (not chk_Mazot.Checked) then
  begin
      //strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER);
      strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER)+ ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_MAZOT);
  end;
  }


  if UseCariKod then
  begin
    if (cmbParaBirimi.Text = glb_DEFCUR) then
    begin
      strSQL := strSQL + ' AND CARIHAR.CARI_KOD = ' + SQL_Katar(CariKod);
    end
    else
    begin
      strSQL := strSQL + ' AND CARIHAR.CARI_KOD = ' + SQL_Katar(CariKod) + ' AND CARIHAR_DOV.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text);
    end;
  end
  else
  if chk_Harmanla.Checked then
  begin
    if not cb_Kod_Araligi.Checked then
    begin
    CariLst := '';
    for i := 0 to lstCariKod.Count - 1 do
    begin
      CariLst := CariLst + SQL_Katar(lstCariKod.Items[i]) + ','
    end;
    CariLst := copy(CariLst,1,Length(CariLst)-1);
    if (cmbParaBirimi.Text = glb_DEFCUR) then
    begin
      strSQL := strSQL + ' AND CARIHAR.CARI_KOD IN ('+CariLst+')';
    end
    else
    begin
      strSQL := strSQL + ' AND CARIHAR.CARI_KOD IN ('+CariLst+') AND CARIHAR_DOV.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text);
    end;
    end;

    if cb_Kod_Araligi.Checked then
    begin

     qryTemp.Active:=False;
     qryTemp.Sql.Text:='SELECT CARI_KOD FROM CARI WHERE CARI_KOD BETWEEN :ILK AND :SON ORDER BY CARI_KOD';
     qryTemp.ParamByName('ILK').AsString:=txt_ilk_Cari.Text;
     qryTemp.ParamByName('SON').AsString:=txt_son_Cari.Text;
     qryTemp.Active:=True;

     qryTemp.First;
     While not qryTemp.Eof Do
     begin
        CariLst := CariLst + SQL_Katar( qryTemp.FieldByName('CARI_KOD').AsString) + ',';
          qryTemp.Next;
     end;


     CariLst := copy(CariLst,1,Length(CariLst)-1);

     if (cmbParaBirimi.Text = glb_DEFCUR) then
     begin
       strSQL := strSQL + ' AND CARIHAR.CARI_KOD IN ('+CariLst+')';
     end
     else
     begin
       strSQL := strSQL + ' AND CARIHAR.CARI_KOD IN ('+CariLst+') AND CARIHAR_DOV.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text);
     end;

    end;

  end;

//****************************************************************************//
  if Trim(txtISLEMMERKEZI.Text) <> '' then
  begin
    strSQL := strSQL + ' AND CARIHAR.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
  end;
//****************************************************************************//
  if Trim(txtKOD1.Text) <> '' then
  begin
    strSQL := strSQL + ' AND CARIHAR.KOD1 = '+ SQL_Katar(txtKOD1.Text);
  end;
//****************************************************************************//
  if Trim(txtKOD2.Text) <> '' then
  begin
    strSQL := strSQL + ' AND CARIHAR.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
  end;
//****************************************************************************//
  if Trim(txtKOD3.Text) <> '' then
  begin
    strSQL := strSQL + ' AND CARIHAR.KOD3 = ' + SQL_Katar(txtKOD3.Text);
  end;
//****************************************************************************//
  if Trim(txtKOD4.Text) <> '' then
  begin
    strSQL := strSQL + ' AND CARIHAR.KOD4 = ' + SQL_Katar(txtKOD4.Text);
  end;
//****************************************************************************//
  if glb_SUBELI then
  begin
    SubeID := DataMod.SubeAd2ID(cmbSube.Text);
    if SubeID <> '0' then
    begin
      strSQL := strSQL + ' AND (CARIHAR.CARIHAR_SID = '+ SubeID+')';
    end;
  end
  else
  begin
    strSQL := strSQL + ' AND (CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID)+')';
  end;
//****************************************************************************//
  strSQL := strSQL + ' ORDER BY CARIHAR.TARIH,CARIHAR.CARIHAR_ID ASC';
//****************************************************************************//
  with qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;
  //frmRaporCiktisi_Open(strSQL);
end;



procedure TfrmRaporCariBakiyeliHareket.ToplamBul(CariKod:String);
var
  SubeID,strSQL : String;
begin
  genel_alacak := 0;
  genel_borc := 0;
  if CompareDate(dtpIslemTar1.Date,glb_DONEM_BAS) = 1 then
  begin
    with frmRaporCariBakiyeliHareket.qryToplam do
    begin
      Active := false;
      SQL.Clear;
      if (cmbParaBirimi.Text = glb_DEFCUR) then
      begin
        strSQL := ' SELECT CARIHAR.TIP,SUM(CARIHAR.TUTAR_VPB) AS TOPLAM FROM CARIHAR'
                   + ' WHERE (CARIHAR.TARIH >='+ SQL_Tarih(glb_DONEM_BAS)
                   + ' AND CARIHAR.TARIH < ' + SQL_Tarih(dtpIslemTar1.Date)
                   + ' ) AND CARIHAR.CARI_KOD = ' + SQL_Katar(CariKod);
//****************************************************************************//
  if not chk_Sefer.Checked then
  strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER);
  if not chk_Mazot.Checked then
  strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_MAZOT);
  {if (not chk_Sefer.Checked) and (not chk_Mazot.Checked) then
  strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER)+ ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_MAZOT);
  }
        if Trim(txtISLEMMERKEZI.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
        end;
//****************************************************************************//
        if Trim(txtKOD1.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.KOD1 = '+ SQL_Katar(txtKOD1.Text);
        end;
//****************************************************************************//
        if Trim(txtKOD2.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
        end;
//****************************************************************************//
        if Trim(txtKOD3.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.KOD3 = ' + SQL_Katar(txtKOD3.Text);
        end;
//****************************************************************************//
        if Trim(txtKOD4.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.KOD4 = ' + SQL_Katar(txtKOD4.Text);
        end;
//****************************************************************************//
        if glb_SUBELI then
        begin
          SubeID := DataMod.SubeAd2ID(cmbSube.Text);
          if SubeID <> '0' then
          begin
            strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ SubeID;
          end;
        end
        else
        begin
          strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
        end;
        strSQL := strSQL + ' GROUP BY CARIHAR.TIP ';
      end
      else
      begin
        if cmbParaBirimi.Text <> 'TRL' then
        begin
          strSQL := 'SELECT CARIHAR.TIP,SUM(CARIHAR_DOV.TUTAR) AS TOPLAM FROM CARIHAR_DOV'
                  + ' LEFT OUTER JOIN CARIHAR ON (CARIHAR.CARIHAR_ID = CARIHAR_DOV.CARIHAR_ID AND CARIHAR.CARIHAR_SID = CARIHAR_DOV.CARIHAR_DOV_SID)'
                  + ' LEFT OUTER JOIN CARI ON (CARI.CARI_KOD = CARIHAR.CARI_KOD)'
                  + ' WHERE (CARIHAR.TARIH >= '+ SQL_Tarih(glb_DONEM_BAS) +' AND CARIHAR.TARIH < ' + SQL_Tarih(dtpIslemTar1.Date) + ')'
                  + ' AND CARIHAR_DOV.DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text)
                  + ' AND CARIHAR.CARI_KOD = ' + SQL_Katar(CariKod);
        end
        else
        begin
          if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0 then
          begin
            strSQL := ' SELECT CARIHAR.TIP,(SUM(CARIHAR.TUTAR_VPB) * 1000000) AS TOPLAM FROM CARIHAR'
                    + ' WHERE (CARIHAR.TARIH >= '+ SQL_Tarih(glb_DONEM_BAS)
                    + ' AND CARIHAR.TARIH < ' + SQL_Tarih(dtpIslemTar1.Date) + ')'
                    + ' AND CARIHAR.CARI_KOD = ' + SQL_Katar(CariKod);
          end
          else
          begin
            strSQL := ' SELECT CARIHAR.TIP,SUM(CARIHAR.TUTAR_VPB) AS TOPLAM FROM CARIHAR'
                    + ' WHERE (CARIHAR.TARIH >= '+ SQL_Tarih(glb_DONEM_BAS)
                    + ' AND CARIHAR.TARIH < ' + SQL_Tarih(dtpIslemTar1.Date) + ')'
                    + ' AND CARIHAR.CARI_KOD = ' + SQL_Katar(CariKod);
          end;
        end;

        if not chk_Sefer.Checked then
        strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER);
        if not chk_Mazot.Checked then
        strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_MAZOT);
        {if (not chk_Sefer.Checked) and (not chk_Mazot.Checked) then
        strSQL := strSQL + ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_SEFER)+ ' AND CARIHAR.BELGE_TUR <> ' + Inttostr(BT_MAZOT);
        }
//****************************************************************************//
        if Trim(txtISLEMMERKEZI.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.MASRAF_MERK = '+ SQL_Katar(txtISLEMMERKEZI.Text);
        end;
//****************************************************************************//
        if Trim(txtKOD1.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.KOD1 = '+ SQL_Katar(txtKOD1.Text);
        end;
//****************************************************************************//
        if Trim(txtKOD2.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.KOD2 = ' +  SQL_Katar(txtKOD2.Text);
        end;
//****************************************************************************//
        if Trim(txtKOD3.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.KOD3 = ' + SQL_Katar(txtKOD3.Text);
        end;
//****************************************************************************//
        if Trim(txtKOD4.Text) <> '' then
        begin
          strSQL := strSQL + ' AND CARIHAR.KOD4 = ' + SQL_Katar(txtKOD4.Text);
        end;
//****************************************************************************//
        if glb_SUBELI then
        begin
          SubeID := DataMod.SubeAd2ID(cmbSube.Text);
          if SubeID <> '0' then
          begin
            strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ SubeID;
          end;
        end
        else
        begin
          strSQL := strSQL + ' AND CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID);
        end;
        strSQL := strSQL + ' GROUP BY CARIHAR.TIP ';
      end;
      SQL.Add(strSQL);
      Active := True;
    end;
//****************************************************************************//
    qryToplam.First;
    while not qryToplam.Eof do
    begin
      if qryToplam.FieldByName('TIP').AsString = 'A' then
      begin
        genel_alacak := qryToplam.FieldByName('TOPLAM').AsCurrency;
      end;
      if qryToplam.FieldByName('TIP').AsString = 'B' then
      begin
        genel_borc := qryToplam.FieldByName('TOPLAM').AsCurrency;
      end;
      qryToplam.Next;
    end;
//****************************************************************************//
    with qryToplam do
    begin
      if Active then Active := false;
      SQL.Clear;
      if cmbParaBirimi.Text = glb_DEFCUR then
      begin
        SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI WHERE CARI_KOD = '+SQL_Katar(CariKod));
      end
      else
      begin
        if cmbParaBirimi.Text = 'TRL' then
        begin
          SQL.Add('SELECT (DEVREDEN_BORC*1000000) as DEVREDEN_BORC,(DEVREDEN_ALACAK*1000000) as DEVREDEN_ALACAK FROM CARI WHERE CARI_KOD = '+SQL_Katar(CariKod));
        end
        else
        begin
          SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI_DOV WHERE CARI_KOD = '+SQL_Katar(CariKod)+' AND DOVKOD = '+ SQL_Katar(cmbParaBirimi.Text));
        end;
      end;
      Active := True;
      genel_alacak := genel_alacak + FieldByName('DEVREDEN_ALACAK').AsCurrency;
      genel_borc :=  genel_borc + FieldByName('DEVREDEN_BORC').AsCurrency;
      Active := False;
    end;
//****************************************************************************//
  end
  else
  begin
    with qryToplam do
    begin
      Active := false;
      SQL.Clear;
      if cmbParaBirimi.Text = glb_DEFCUR then
      begin
        SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI WHERE CARI_KOD = '+SQL_Katar(CariKod));
      end
      else
      begin
        if cmbParaBirimi.Text = 'TRL' then
        begin
          SQL.Add('SELECT (DEVREDEN_BORC*1000000) as DEVREDEN_BORC,(DEVREDEN_ALACAK*1000000) as DEVREDEN_ALACAK FROM CARI WHERE CARI_KOD = '+SQL_Katar(CariKod));
        end
        else
        begin
          SQL.Add('SELECT DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI_DOV WHERE CARI_KOD = '+SQL_Katar(CariKod)+' AND DOVKOD = '+SQL_Katar(cmbParaBirimi.Text));
        end;
      end;
      Active := True;
      genel_alacak := FieldByName('DEVREDEN_ALACAK').AsCurrency;
      genel_borc := FieldByName('DEVREDEN_BORC').AsCurrency;
      Active := False;
    end;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.DevirIcinToplamBul(CariKod:String;Tip:Byte);
begin
  with qryToplam do
  begin
    Active := false;
    SQL.Clear;
    if cmbParaBirimi.Text = glb_DEFCUR then
    begin
      SQL.Add('SELECT CARI_AD,CARI_KOD,DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI WHERE CARI_KOD = '+SQL_Katar(CariKod));
    end
    else
    begin
      if cmbParaBirimi.Text = 'TRL' then
      begin
        SQL.Add('SELECT CARI_AD,CARI_KOD,(DEVREDEN_BORC*1000000) as DEVREDEN_BORC,(DEVREDEN_ALACAK*1000000) as DEVREDEN_ALACAK FROM CARI WHERE CARI_KOD = '+SQL_Katar(CariKod));
      end
      else
      begin
        SQL.Add('SELECT (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = CARI_DOV.CARI_KOD) AS CARI_AD,CARI_KOD,DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI_DOV WHERE CARI_KOD = '+SQL_Katar(CariKod)+' AND DOVKOD = '+SQL_Katar(cmbParaBirimi.Text));
      end;
    end;

    {if cb_Kod_Araligi.Checked then
    begin
      Active := false;
      SQL.Clear;

      SQL.Add('SELECT CARI_AD,CARI_KOD,DEVREDEN_BORC,DEVREDEN_ALACAK FROM CARI WHERE ');


      if (cmbParaBirimi.Text = glb_DEFCUR) then
      begin
        SQL.Add( ' CARI_KOD BETWEEN '+SQL_Katar(txt_ilk_Cari.Text) +' AND '+ SQL_Katar(txt_son_Cari.Text));
      end
      else
      begin
        SQL.Add( '  CARI_KOD BETWEEN '+SQL_Katar(txt_ilk_Cari.Text) +' AND '+ SQL_Katar(txt_son_Cari.Text) +' AND DOVKOD = ' + SQL_Katar(cmbParaBirimi.Text));
      end;

    end;
    }

    Active := True;
  end;

  case tip of
  1:
    begin
      col := 0;
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('CARI_AD').AsString);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      inc(row);
      col := 0;
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('CARI_KOD').AsString);
      frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      inc(row);
      col := 0;
      frmRaporCiktisi.SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      if trim(txtISLEMMERKEZI.Text) <> '' then
      begin
        inc(row);
        frmRaporCiktisi.SetCellText(row,col,'??lem Merkezi : ' + txtISLEMMERKEZI.Text);
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      end;
      inc(row);
      Alan_isimlerini_ekle(1);
      inc(row,2);
//****************************************************************************//
      inc(col,3);
      frmRaporCiktisi.SetCellText(row,col,'DEV?R');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
//****************************************************************************//
  {$IfnDef TRANSPORT}
    inc(col,2);
  {$EndIf}
  {$IfDef TRANSPORT}
    inc(col,1);
  {$EndIf}

      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEVREDEN_BORC').AsString);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
//****************************************************************************//
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEVREDEN_ALACAK').AsString);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
//****************************************************************************//
      if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency > qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency - qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
//****************************************************************************//
      if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency < qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency - qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
//****************************************************************************//
      if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency = qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
//****************************************************************************//
      inc(row,2);
    end;
  2:
    begin
      col := 0;
      frmRaporCiktisi.SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      if trim(txtISLEMMERKEZI.Text) <> '' then
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'??lem Merkezi : ' + txtISLEMMERKEZI.Text);
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      end;
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('CARI_AD').AsString);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('CARI_KOD').AsString);
      frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'DEV?R');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEVREDEN_BORC').AsString);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
//****************************************************************************//
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEVREDEN_ALACAK').AsString);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
//****************************************************************************//
      if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency > qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency - qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
//****************************************************************************//
      if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency < qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency - qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
//****************************************************************************//
      if (qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency = qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency) then
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
//****************************************************************************//
      inc(row);
    end;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.yaz;
var
  SubeID:String;
  prow : integer;
begin
  qryRapor.First;

  if not chk_devir.Checked then
  begin
    prow := row + 2;
  end
  else
  if chk_Harmanla.Checked then
  begin
    prow := row + 2;
  end
  else
  if (chk_devir.Checked) and (not chk_Harmanla.Checked) then
  begin
    prow := row + 1;
  end;

  while not (qryRapor.Eof) do
  begin
  //cari ad? bakiyeli hareket d?k?m? a??klamas?n? ve current date'i ekleyen k?s?m
  //start
    inc(row);
    col :=  0;

    DataMod.Rapor_Satir_Renklendir(col,row,8);

    if chk_Harmanla.Checked then
    begin
    //////////////////////////////////////////////////////////////////////////////
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_KOD').AsString);
      frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
      frmRaporCiktisi.SetCellAlignment(col,row,col,row,haLEFT,vaCENTER);
      inc(col);
    //////////////////////////////////////////////////////////////////////////////
    end;
    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TARIH').AsDate);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRapor.FieldByName('BELGE_TUR').AsInteger));
    case qryRapor.FieldByName('BELGE_TUR').AsInteger of
    41:
    begin
         if (qryRapor.FieldByName('SIRA_NO').AsInteger=3) or
             (qryRapor.FieldByName('SIRA_NO').AsInteger=4)  then
             begin


        with qryToplam do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT SEFER_ID FROM SEFER WHERE SEFER_ID = '+qryRapor.FieldByName('BELGE_ID').AsString
          +' AND (BEKLEME_FAT_VAR=1 or SBEKLEME_FAT_VAR=1) AND (SBEKLEME_FAT_TUTAR='
          +SQL_Para(qryRapor.FieldByName('TOPLAM').AsCurrency)
          + ' or BEKLEME_FAT_TUTAR='+SQL_Para(qryRapor.FieldByName('TOPLAM').AsCurrency) +' )' );
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND SEFER_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND SEFER_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;

        if qryToplam.FieldByName('SEFER_ID').AsInteger>0 then
        begin
          frmRaporCiktisi.SetCellText(row,col,'SEFER BEKLEME ');
        end;

          qryToplam.Active := False;

             end;
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);

    end;
    14:
      begin
        with qryToplam do
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
        if qryToplam.FieldByName('ISLEM_TIP').AsInteger = 5 then
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('BELGE_ID').AsString);
          qryToplam.Active := False;
        end
        else
        begin
          inc(col);
          frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
          qryToplam.Active := False;
        end;
      end;
    17:
      begin
        with qryToplam do
        begin
          Active := false;
          SQL.Clear;
          SQL.Add('SELECT DEKONT_ID FROM DEKONT_D WHERE DEKONT_D.DEKONT_D_ID ='+qryRapor.FieldByName('BELGE_ID').AsString);
          if glb_SUBELI then
          begin
            SubeID := DataMod.SubeAd2ID(cmbSube.Text);
            if SubeID <> '0' then
            begin
              SQL.Add(' AND DEKONT_D.DEKONT_SID = '+ SubeID);
            end;
          end
          else
          begin
            SQL.Add(' AND DEKONT_D.DEKONT_SID = '+ inttostr(glb_SID));
          end;
          Active := True;
        end;
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('DEKONT_ID').AsString);
        qryToplam.Active := False;
      end;
    else
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
      end;
    end;//end case


    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);

  {$IfnDef TRANSPORT}
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_KOD').AsString);
  {$EndIf}

    inc(col);
    if qryRapor.FieldByName('TIP').AsString = 'B' then
    begin
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TOPLAM').AsString);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'0');
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      genel_borc := genel_borc + qryRapor.FieldByName('TOPLAM').AsCurrency;
    end;
    if qryRapor.FieldByName('TIP').AsString = 'A' then
    begin
      frmRaporCiktisi.SetCellText(row,col,'0');
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TOPLAM').AsString);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      genel_alacak := genel_alacak + qryRapor.FieldByName('TOPLAM').AsCurrency;
    end;
    if (genel_alacak > genel_borc) then
    begin
      genel_alacak := genel_alacak - genel_borc;
      genel_borc := 0;
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;
    if (genel_alacak < genel_borc) then
    begin
      genel_borc := genel_borc - genel_alacak;
      genel_alacak := 0;
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;
    if (genel_alacak = genel_borc) then
    begin
      genel_alacak := 0;
      genel_borc := 0;
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;
    frmRaporCariBakiyeliHareket.qryRapor.Next;
  end;
//****************************************************************************//
  inc(row);
  if chk_Harmanla.Checked then
  begin
    if row < prow then exit;
    col := 4;
    frmRaporCiktisi.SetCellText(row,col,'TOPLAM');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  {$IfnDef TRANSPORT}
    inc(col,2);
  {$EndIf}
  {$IfDef TRANSPORT}
    inc(col,1);
  {$EndIf}

//****************************************************************************//
    frmRaporCiktisi.SetCellText(row,col,'=SUM(G'+inttostr(prow)+':G'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(H'+inttostr(prow)+':H'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
//****************************************************************************//
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
//****************************************************************************//
  end
  else
  begin
//****************************************************************************//
    col := 3;
    frmRaporCiktisi.SetCellText(row,col,'TOPLAM');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  {$IfnDef TRANSPORT}
    inc(col,2);
  {$EndIf}
  {$IfDef TRANSPORT}
    inc(col,1);
  {$EndIf}
  {$IfDef TRANSPORT}
//****************************************************************************//
    frmRaporCiktisi.SetCellText(row,col,'=SUM(E'+inttostr(prow)+':E'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F'+inttostr(prow)+':F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
  {$EndIf}

  {$IfnDef TRANSPORT}
//****************************************************************************//
    frmRaporCiktisi.SetCellText(row,col,'=SUM(F'+inttostr(prow)+':F'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,'=SUM(G'+inttostr(prow)+':G'+IntToStr(row)+')');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
  {$EndIf}

//****************************************************************************//
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
    frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
    if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
    else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
//****************************************************************************//
  end;
//****************************************************************************//
  inc(row,2);
end;

procedure TfrmRaporCariBakiyeliHareket.rapor_bitti;
begin
  inc(row);
  col := 3;
  frmRaporCiktisi.SetCellText(row,col,'TOPLAM');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  {$IfnDef TRANSPORT}
    inc(col,2);
  {$EndIf}
  {$IfDef TRANSPORT}
    inc(col,1);
  {$EndIf}


  if (chk_devir.Checked and chk_Sirket.Checked) then
  begin
    if trim(txtISLEMMERKEZI.Text) <> '' then
    begin
      frmRaporCiktisi.SetCellText(row,col,'=SUM(F9:F'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'=SUM(G9:G'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end
    else
    begin
      frmRaporCiktisi.SetCellText(row,col,'=SUM(F8:F'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'=SUM(G8:G'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;
  end
  else
  if (chk_devir.Checked or chk_Sirket.Checked) then
  begin
    if trim(txtISLEMMERKEZI.Text) <> '' then
    begin
      frmRaporCiktisi.SetCellText(row,col,'=SUM(F8:F'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'=SUM(G8:G'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end
    else
    begin
      frmRaporCiktisi.SetCellText(row,col,'=SUM(F7:F'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'=SUM(G7:G'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;
  end
  else
  if not ((chk_devir.Checked and chk_Sirket.Checked)) then
  begin
    if trim(txtISLEMMERKEZI.Text) <> '' then
    begin
      frmRaporCiktisi.SetCellText(row,col,'=SUM(F7:F'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'=SUM(G7:G'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end
    else
    begin
      frmRaporCiktisi.SetCellText(row,col,'=SUM(F6:F'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'=SUM(G6:G'+IntToStr(row)+')');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;
  end;
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
  else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
  inc(col);
  frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
  else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
  genel_borc := 0;
  genel_alacak := 0;
end;


procedure TfrmRaporCariBakiyeliHareket.Alan_isimlerini_ekle(Tip:Byte);
begin
  col := 0;
  case tip of
  1:
    begin
      inc(row);
      frmRaporCiktisi.SetCellText(row,col,'TAR?H');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'BELGE T?R?');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'F?? NUMARASI');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'A?IKLAMA');
  {$IfnDef TRANSPORT}
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'PROJE KODU');
  {$EndIf}
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'BOR?');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'ALACAK');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'BOR? BAK?YES?');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'ALACAK BAK?YES?');
      frmRaporCiktisi.SetCellFont(0,row,col,row,[fsBold],8,'MS Sans Serif',4);
    end;
  2:
    begin
      inc(col,3);
      frmRaporCiktisi.SetCellText(row,col,'BOR?');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'ALACAK');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'BOR? BAK?YES?');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'ALACAK BAK?YES?');
      frmRaporCiktisi.SetCellFont(3,row,col,row,[fsBold],8,'MS Sans Serif',4);
      inc(row);
    end;
  3:
    begin
      inc(row);
      frmRaporCiktisi.SetCellText(row,col,'CAR? KOD');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'TAR?H');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'BELGE T?R?');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'F?? NUMARASI');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'A?IKLAMA');
  {$IfnDef TRANSPORT}
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'PROJE KODU');
  {$EndIf}
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'BOR?');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'ALACAK');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'BOR? BAK?YES?');
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'ALACAK BAK?YES?');
      frmRaporCiktisi.SetCellFont(0,row,col,row,[fsBold],9,'MS Sans Serif',4);
    end;
  end;
  col := 0;
end;

procedure TfrmRaporCariBakiyeliHareket.FormKeyPress(Sender: TObject;  var Key: Char);
begin
  if key = #27 then
  begin
    close;
  end;
  if key = #13 then
  begin
    key := #0;
    SelectNext(ActiveControl as tWinControl, True, True );
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.FormKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  case Key Of
    VK_F6:PageControl1.SelectNextPage(True);
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.dtpIslemTar1Enter(Sender: TObject);
begin
  dtpIslemTar1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareket.dtpIslemTar2Enter(Sender: TObject);
begin
  dtpIslemTar2.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareket.dtpIslemTar1Exit(Sender: TObject);
begin
  dtpIslemTar1.Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareket.dtpIslemTar2Exit(Sender: TObject);
begin
  dtpIslemTar2.Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareket.cmbParaBirimiEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareket.cmbParaBirimiExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareket.chk_devirEnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareket.chk_devirExit(Sender: TObject);
begin
  (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporCariBakiyeliHareket.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporCariBakiyeliHareket);
  {$IfnDef TRANSPORT}
  chk_Sefer.Visible:=False;
  chk_Mazot.Visible:=False;
  Label4.Visible:=False;  
  {$EndIf}

end;

procedure TfrmRaporCariBakiyeliHareket.txtISLEMMERKEZIEnter(
  Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareket.txtISLEMMERKEZIExit(
  Sender: TObject);
begin
  if Trim(Self.txtISLEMMERKEZI.Text) = '' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtISLEMMERKEZI,0) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtISLEMMERKEZI.SetFocus;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txtISLEMMERKEZIKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnISLEMMERKEZIClick(Self);
end;

procedure TfrmRaporCariBakiyeliHareket.btnISLEMMERKEZIClick(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txtKOD1Exit(Sender: TObject);
begin
  if Trim(Self.txtKOD1.Text) = '' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD1,1) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD1.SetFocus;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txtKOD2Exit(Sender: TObject);
begin
  if Trim(Self.txtKOD2.Text) = '' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD2,2) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD2.SetFocus;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txtKOD3Exit(Sender: TObject);
begin
  if Trim(Self.txtKOD3.Text) = '' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;

  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD3,3) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD3.SetFocus;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txtKOD4Exit(Sender: TObject);
begin
  if Trim(Self.txtKOD4.Text) = '' then
  begin
    (Sender as TEdit).Color := clWindow;
    exit;
  end;
  if DataMod.Muh_Kod_Kontrol(nil,Self.txtKOD4,4) then
  begin
    (Sender as TEdit).Color := clWindow;
  end
  else
  begin
    Self.txtKOD4.SetFocus;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.btnKOD1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.btnKOD2Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.btnKOD3Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.btnKOD4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txtKOD1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD1Click(Self);
end;

procedure TfrmRaporCariBakiyeliHareket.txtKOD2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD2Click(Self);
end;

procedure TfrmRaporCariBakiyeliHareket.txtKOD3KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD3Click(Self);
end;

procedure TfrmRaporCariBakiyeliHareket.txtKOD4KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD4Click(Self);
end;

procedure TfrmRaporCariBakiyeliHareket.lstCariKodKeyDown(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
  case Key of
  VK_DELETE:
    begin
      if lstCariKod.Count <> 0 then
      begin
        if lstCariKod.ItemIndex = -1 then
        begin
          lstCariKod.Items.Delete(0);
        end
        else
        begin
          lstCariKod.Items.Delete(lstCariKod.ItemIndex);
        end;
      end;
    end;
  VK_F4:
    begin
      btnCariListesiClick(Self);
    end;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.SirketBilgisiEkle;
var
  res_Cari : TStringList;
begin
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket(res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    inc(row);
    col := 0;
    res_Cari.Free;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.CariBilgisiEkle;
var
str:string;
begin
  col := 0;
  frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_AD').AsString);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  inc(row);
  col := 0;
  frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_KOD').AsString);
  frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  inc(row);
  col := 0;
  frmRaporCiktisi.SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
  str:=TimeToStr(DataMod.GET_SERVER_DATETIME);

  frmRaporCiktisi.SetCellText(row,col+2,str);
  frmRaporCiktisi.SetCellFont(col+2,row,col+2,row,[fsBold],8,'MS Sans Serif',0);


  if trim(txtISLEMMERKEZI.Text) <> '' then
  begin
    inc(row);
    frmRaporCiktisi.SetCellText(row,col,'??lem Merkezi : ' + txtISLEMMERKEZI.Text);
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
  end;
  inc(row);
end;

procedure TfrmRaporCariBakiyeliHareket.DevirBilgisiEkle(Tip:Byte;CariKod:String);
var
  CariAd:String;
begin
  case Tip of
  1:
    begin
      inc(row,2);
      //qryToplam'dan elde edilen ve genel_borc ve genel_alacak de?i?kenlerine at?lan
      //de?erler burada kar??la?t?r?l?yor ve gerekli de?erler atan?yor.
      inc(col,3);
      frmRaporCiktisi.SetCellText(row,col,'DEV?R');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
  {$IfnDef TRANSPORT}
    inc(col,2);
  {$EndIf}
  {$IfDef TRANSPORT}
    inc(col,1);
  {$EndIf}

     //burada qytoplam'dan al?nan genel_borc gride ekleniyor.
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      //stop
      inc(col);
      //burada qrytoplam'dan al?nan genel_alacak gride ekleniyor.
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      //burada genel_alacak ve genel_borc de?i?kenleri kar??la?t?r?larak bor? bakiyesi ve alacak bakiyesi
      //gride ekleniyor.
      if (genel_alacak > genel_borc) then
      begin
        //*******
        genel_alacak := genel_alacak - genel_borc;
        //*********
        genel_borc := 0;
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
      //burada genel_alacak ve genel_borc de?i?kenleri kar??la?t?r?larak bor? bakiyesi ve alacak bakiyesi
      //gride ekleniyor.
      if (genel_alacak < genel_borc) then
      begin
        //start
        genel_borc := genel_borc - genel_alacak;
        genel_alacak := 0;
        //stop
        inc(col);
        //start
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        //stop
        inc(col);
        //start
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        //stop
      end;
      //burada genel_alacak ve genel_borc de?i?kenleri kar??la?t?r?larak bor? bakiyesi ve alacak bakiyesi
      //gride ekleniyor.
      if (genel_alacak = genel_borc) then
      begin
        genel_alacak := 0;
        genel_borc := 0;
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
    end;
  2:
    begin
//****************************************************************************//
      col := 0;
//****************************************************************************//
{
      if trim(txtISLEMMERKEZI.Text) <> '' then
      begin
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,'??lem Merkezi : ' + txtISLEMMERKEZI.Text);
        frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      end;
}
//    inc(col);


      DataMod.Rapor_Satir_Renklendir(col,row,6);

      DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',CariKod,CariAd);
      frmRaporCiktisi.SetCellText(row,col,CariAd);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
//****************************************************************************//
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,CariKod);
      frmRaporCiktisi.SetCellFormat(col,row,col,row,1);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
      frmRaporCiktisi.SetCellAlignment(col,row,col,row,haLEFT,vaCENTER);
//****************************************************************************//
      inc(col);
      frmRaporCiktisi.SetCellText(row,col,'DEV?R');
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
      inc(col);
//****************************************************************************//
     //burada qytoplam'dan al?nan genel_borc gride ekleniyor.
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      //stop
      inc(col);
      //burada qrytoplam'dan al?nan genel_alacak gride ekleniyor.
      frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      //burada genel_alacak ve genel_borc de?i?kenleri kar??la?t?r?larak bor? bakiyesi ve alacak bakiyesi
      //gride ekleniyor.
//****************************************************************************//
      if (genel_alacak > genel_borc) then
      begin
        //*******
        genel_alacak := genel_alacak - genel_borc;
        //*********
        genel_borc := 0;
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
      //burada genel_alacak ve genel_borc de?i?kenleri kar??la?t?r?larak bor? bakiyesi ve alacak bakiyesi
      //gride ekleniyor.
//****************************************************************************//
      if (genel_alacak < genel_borc) then
      begin
        //start
        genel_borc := genel_borc - genel_alacak;
        genel_alacak := 0;
        //stop
        inc(col);
        //start
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        //stop
        inc(col);
        //start
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        //stop
      end;
      //burada genel_alacak ve genel_borc de?i?kenleri kar??la?t?r?larak bor? bakiyesi ve alacak bakiyesi
      //gride ekleniyor.
//****************************************************************************//
      if (genel_alacak = genel_borc) then
      begin
        genel_alacak := 0;
        genel_borc := 0;
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_borc));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
        inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(genel_alacak));
        if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
        else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      end;
//****************************************************************************//
      inc(row);
    end;
  end;


end;

procedure TfrmRaporCariBakiyeliHareket.AltAltaAyriYaz;
var
  CHeader : TcxSSHeader;
  i : Byte;
begin
  row := 0;
  col := 0;
  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;
  SirketBilgisiEkle;
  if not cb_Kod_Araligi.Checked then
  for i := 0 to lstCariKod.Count - 1 do
  begin
    SQL_Hazirla(True,lstCariKod.Items[i]);
    if ((qryRapor.Eof) and (qryRapor.Bof)) then
    begin
      if chk_devir.Checked then
      begin
        DevirIcinToplamBul(lstCariKod.Items[i],1);
      end
      else
      begin
        qryRapor.Active := False;
      end;
      //Exit;
    end
    else
    begin
      if chk_devir.Checked then
      begin
        ToplamBul(lstCariKod.Items[i]);
      end;
      CariBilgisiEkle;
      Alan_isimlerini_ekle(1);
      if chk_devir.Checked then
      begin
        DevirBilgisiEkle(1,'');
      end;
      yaz;
    end;
  end;










  if cb_Kod_Araligi.Checked then
  begin
   qryTemp.Active:=False;
   qryTemp.Sql.Text:='SELECT CARI_KOD FROM CARI WHERE CARI_KOD BETWEEN :ILK AND :SON  ORDER BY CARI_KOD';
   qryTemp.ParamByName('ILK').AsString:=txt_ilk_Cari.Text;
   qryTemp.ParamByName('SON').AsString:=txt_son_Cari.Text;
   qryTemp.Active:=True;

   qryTemp.First;
   While not qryTemp.Eof Do
   begin
    SQL_Hazirla(True,qryTemp.FieldByName('CARI_KOD').AsString);
    if ((qryRapor.Eof) and (qryRapor.Bof)) then
    begin
      if chk_devir.Checked then
      begin
        DevirIcinToplamBul(qryTemp.FieldByName('CARI_KOD').AsString,1);
      end
      else
      begin
        qryTemp.Active := False;
      end;
      //Exit;
    end
    else
    begin
      if chk_devir.Checked then
      begin
        ToplamBul(qryTemp.FieldByName('CARI_KOD').AsString);
      end;
      CariBilgisiEkle;
      Alan_isimlerini_ekle(1);
      if chk_devir.Checked then
      begin
        DevirBilgisiEkle(1,qryTemp.FieldByName('CARI_KOD').AsString);
      end;
      yaz;

    end;
    qryTemp.Next;
   end;
  end;



  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[1] := 100;
  CHeader.Size[2] := 100;
  CHeader.Size[3] := 250;
  CHeader.Size[4] := 125;
  CHeader.Size[5] := 125;
  CHeader.Size[6] := 125;
  frmRaporCiktisi.Rapor_Ayarlari(2);

  frmRaporCiktisi.grdA.EndUpdate;

  frmRaporCiktisi.WindowState := wsMaximized;
  qryRapor.Close;
  qryToplam.Close;
//  rapor_bitti;
end;

procedure TfrmRaporCariBakiyeliHareket.CarileriHarmanla;
var
  CHeader : TcxSSHeader;
  i : Byte;
begin
  row := 0;
  col := 0;
  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;
  SirketBilgisiEkle;
  RaporTarihiEkle;
  Alan_Isimlerini_Ekle(2);



  if cb_Kod_Araligi.Checked then
  begin
   qryTemp.Active:=False;
   qryTemp.Sql.Text:='SELECT CARI_KOD FROM CARI WHERE CARI_KOD BETWEEN :ILK AND :SON ORDER BY CARI_KOD';
   qryTemp.ParamByName('ILK').AsString:=txt_ilk_Cari.Text;
   qryTemp.ParamByName('SON').AsString:=txt_son_Cari.Text;
   qryTemp.Active:=True;

   qryTemp.First;
   While not qryTemp.Eof Do
   begin
    //SQL_Hazirla(True,qryTemp.FieldByName('CARI_KOD').AsString);

    ToplamBul(qryTemp.FieldByName('CARI_KOD').AsString);
    DevirBilgisiEkle(2,qryTemp.FieldByName('CARI_KOD').AsString);
    qryTemp.Next;
   end;

  end;

  if not cb_Kod_Araligi.Checked then
  for i := 0 to lstCariKod.Count - 1 do
  begin
    ToplamBul(lstCariKod.Items[i]);
    DevirBilgisiEkle(2,lstCariKod.Items[i]);
  end;


  Alan_Isimlerini_Ekle(3);
  SQL_Hazirla(False,'');
  yaz;
  CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
  CHeader.Size[1] := 100;
  CHeader.Size[2] := 100;
  CHeader.Size[3] := 100;
  CHeader.Size[4] := 250;
  CHeader.Size[5] := 125;
  CHeader.Size[6] := 125;
  CHeader.Size[7] := 125;
  frmRaporCiktisi.Rapor_Ayarlari(2);
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
  qryRapor.Close;
  qryToplam.Close;
end;

procedure TfrmRaporCariBakiyeliHareket.SayfalarHalindeYaz;
var
  CHeader : TcxSSHeader;
  i:integer;
begin
  row := 0;
  col := 0;
  frmRaporCiktisi.form_open();
  frmRaporCiktisi.grdA.BeginUpdate;
  if not cb_Kod_Araligi.Checked then
  begin

  for i := 0 to lstCariKod.Count - 1 do
  begin
    if i = 0 then
    begin
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      SirketBilgisiEkle;
      frmRaporCiktisi.grdA.Pages[0].Caption := lstCariKod.Items[0];
    end
    else
    begin
      row := 0;
      col := 0;
      frmRaporCiktisi.grdA.AddSheetPage(lstCariKod.Items[i]);
      frmRaporCiktisi.grdA.ActivePage := i;
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      SirketBilgisiEkle;
    end;

    SQL_Hazirla(True,lstCariKod.Items[i]);

    if ((qryRapor.Eof) and (qryRapor.Bof)) then
    begin
      if chk_devir.Checked then
      begin
        DevirIcinToplamBul(lstCariKod.Items[i],1);
        CHeader.Size[1] := 100;
        CHeader.Size[2] := 100;
        CHeader.Size[3] := 250;
        CHeader.Size[4] := 125;
        CHeader.Size[5] := 125;
        CHeader.Size[6] := 125;
      end
      else
      begin
        qryRapor.Active := False;
      end;
    end
    else
    begin
      if chk_devir.Checked then
      begin
        ToplamBul(lstCariKod.Items[i]);
      end;
      CariBilgisiEkle;
      Alan_isimlerini_ekle(1);
      if chk_devir.Checked then
      begin
        DevirBilgisiEkle(1,'');
      end;
      yaz;
      CHeader.Size[1] := 100;
      CHeader.Size[2] := 100;
      CHeader.Size[3] := 250;
      CHeader.Size[4] := 125;
      CHeader.Size[5] := 125;
      CHeader.Size[6] := 125;
    end;
  end;

  frmRaporCiktisi.Rapor_Ayarlari(2);
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
  qryRapor.Close;
  qryToplam.Close;
  end
  else
  begin


   qryTemp.Active:=False;
   qryTemp.Sql.Text:='SELECT CARI_KOD FROM CARI WHERE CARI_KOD BETWEEN :ILK AND :SON ORDER BY CARI_KOD';
   qryTemp.ParamByName('ILK').AsString:=txt_ilk_Cari.Text;
   qryTemp.ParamByName('SON').AsString:=txt_son_Cari.Text;
   qryTemp.Active:=True;

   i:=0;
   qryTemp.First;
   While not qryTemp.Eof Do
   begin

    if i = 0 then
    begin
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      SirketBilgisiEkle;
      frmRaporCiktisi.grdA.Pages[0].Caption := qryTemp.FieldByName('CARI_KOD').AsString
    end
    else
    begin
      row := 0;
      col := 0;
      frmRaporCiktisi.grdA.AddSheetPage(qryTemp.FieldByName('CARI_KOD').AsString);
      frmRaporCiktisi.grdA.ActivePage := i;
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      SirketBilgisiEkle;
    end;

    SQL_Hazirla(True,qryTemp.FieldByName('CARI_KOD').AsString);

    if ((qryRapor.Eof) and (qryRapor.Bof)) then
    begin
      if chk_devir.Checked then
      begin
        DevirIcinToplamBul(qryTemp.FieldByName('CARI_KOD').AsString,1);
        CHeader.Size[1] := 100;
        CHeader.Size[2] := 100;
        CHeader.Size[3] := 250;
        CHeader.Size[4] := 125;
        CHeader.Size[5] := 125;
        CHeader.Size[6] := 125;
      end
      else
      begin
        qryRapor.Active := False;
      end;
    end
    else
    begin
      if chk_devir.Checked then
      begin
        ToplamBul(qryTemp.FieldByName('CARI_KOD').AsString);
      end;
      CariBilgisiEkle;
      Alan_isimlerini_ekle(1);
      if chk_devir.Checked then
      begin
        DevirBilgisiEkle(1,'');
      end;
      yaz;
      CHeader.Size[1] := 100;
      CHeader.Size[2] := 100;
      CHeader.Size[3] := 250;
      CHeader.Size[4] := 125;
      CHeader.Size[5] := 125;
      CHeader.Size[6] := 125;
    end;
    inc(i);
    QryTemp.Next;
  end;
  frmRaporCiktisi.Rapor_Ayarlari(2);
  frmRaporCiktisi.grdA.EndUpdate;
  frmRaporCiktisi.WindowState := wsMaximized;
  qryRapor.Close;
  qryToplam.Close;


  end;


end;

procedure TfrmRaporCariBakiyeliHareket.RaporTarihiEkle;
begin
  frmRaporCiktisi.SetCellText(row,col,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',0);
end;

procedure TfrmRaporCariBakiyeliHareket.Button6Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      txt_ilk_Cari.Text := Cari_KOD;
  end;

end;

procedure TfrmRaporCariBakiyeliHareket.Button1Click(Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      txt_son_Cari.Text := Cari_KOD;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txt_ilk_CariExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txt_ilk_Cari.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txt_ilk_Cari.Text,CARI_AD) then
    begin
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txt_ilk_Cari.SetFocus;
    end;
  end
  else
  begin
    if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txt_son_CariExit(Sender: TObject);
var
  CARI_AD:String;
begin
  if Trim(txt_son_Cari.Text) <> '' then
  begin
    if DataMod.FN_KOD2AD('CARI','CARI_KOD','CARI_AD',txt_son_Cari.Text,CARI_AD) then
    begin
      if (Sender is TEdit) then
      (Sender as TEdit).Color := clWindow;
    end
    else
    begin
      txt_son_Cari.SetFocus;
    end;
  end
  else
  begin
    if (Sender is TEdit) then
    (Sender as TEdit).Color := clWindow;
  end;
end;

procedure TfrmRaporCariBakiyeliHareket.txt_ilk_CariEnter(Sender: TObject);
begin
    (Sender as TEdit).Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareket.txt_ilk_CariKeyPress( Sender: TObject; var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporCariBakiyeliHareket.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
begin
    if not Prv_Yazdirildi then
    begin
       if chk_Sirket.Checked then
       begin
         res_Cari := TStringList.Create;
         if DataMod.FN_Sirket (res_Cari) then
         begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:=res_Cari[1];
         end;
         res_Cari.Free;
       end
       else
       begin
           a:=(frxReport1.FindComponent('Memo_Sirket_adi') as TfrxMemoView);
           a.memo.Text:='';
       end;


       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(dtpIslemTar2.Date);


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);


       Prv_Yazdirildi:=True;
    end;

end;

procedure TfrmRaporCariBakiyeliHareket.IB_Query2CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
var
  a,b:Double;
begin
{    //if ARow.ByName('TIP').AsString='
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('BELGE_TUR').AsInteger);

    if Prv_Id<>ARow.ByName('CARIHAR_ID').AsInteger then Prv_Hesap:=True
    else Prv_Hesap:=False;

    if Prv_Hesap then
    begin
    prv_cl_Borc:=prv_cl_Borc+ARow.ByName('BORC').AsFloat;
    prv_cl_Alacak:=prv_cl_Alacak+ARow.ByName('ALACAK').AsFloat;


    if prv_cl_Borc>prv_cl_Alacak then b:=prv_cl_Borc-prv_cl_Alacak
    else b:=0;

    if prv_cl_Alacak>prv_cl_Borc then a:=prv_cl_Alacak-prv_cl_Borc
    else a:=0;

    ARow.ByName('CALC_BORC').AsFloat :=b;
    //IB_Query2.FieldByName('BORC').AsFloat;

    ARow.ByName('CALC_ALACAK').AsFloat :=a;
    //IB_Query2.FieldByName('ALACAK').AsFloat;

    Prv_Id:=ARow.ByName('CARIHAR_ID').AsInteger;
    end;
}
end;

procedure TfrmRaporCariBakiyeliHareket.IB_Query1AfterScroll(
  IB_Dataset: TIB_Dataset);
begin
{     prv_cl_Borc:=0;
     prv_cl_Alacak:=0;
     Prv_Hesap:=False;
     Prv_Id:=0;
}
end;

procedure TfrmRaporCariBakiyeliHareket.IB_Query4CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('prm_belge_tur').AsInteger);

end;

end.
