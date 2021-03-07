{$INCLUDE directive.inc}

unit ufrmRaporCariBakiyeliHareketTarihli;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, Buttons, StdCtrls,IB_Components, IB_Controls,  frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;


type
  TfrmRaporCariBakiyeliHareketTarihli = class(TForm)
    qryRapor: TIB_Cursor;
    qryToplam: TIB_Cursor;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    GroupBox3: TGroupBox;
    cmbParaBirimi: TComboBox;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    chkDEVIR: TCheckBox;
    chk_Sirket: TCheckBox;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    CheckBox1: TCheckBox;
    cb_Kod_Araligi: TCheckBox;
    Label1: TLabel;
    txt_ilk_Cari: TEdit;
    Button6: TButton;
    Label2: TLabel;
    txt_son_Cari: TEdit;
    Button1: TButton;
    IB_Query1: TIB_Query;
    frxReport1: TfrxReport;
    frxIBOHarTar: TfrxIBODataset;
    Btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure Alan_isimlerini_ekle;
    procedure frmRaporCiktisi_Open(strSQL:String;Rapor_Tipi:Byte);
    procedure yaz(Rapor_Tipi:Byte);
    procedure rapor_bitti;
////////////////////////////////////////////////////////////////////////////////
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRaporClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dtpIslemTar1Enter(Sender: TObject);
    procedure dtpIslemTar2Enter(Sender: TObject);
    procedure dtpIslemTar1Exit(Sender: TObject);
    procedure dtpIslemTar2Exit(Sender: TObject);
    procedure cmbParaBirimiEnter(Sender: TObject);
    procedure cmbParaBirimiExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkDEVIREnter(Sender: TObject);
    procedure chkDEVIRExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure txt_son_CariEnter(Sender: TObject);
    procedure txt_son_CariExit(Sender: TObject);
    procedure txt_ilk_CariExit(Sender: TObject);
    procedure txt_ilk_CariEnter(Sender: TObject);
    procedure IB_Query1CalculateField(Sender: TIB_Statement; ARow: TIB_Row;
      AField: TIB_Column);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
////////////////////////////////////////////////////////////////////////////////
  private
    row,col:integer;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

  const cns_cari_bakiyeli_hareket_tarihli = 2;
var
  frmRaporCariBakiyeliHareketTarihli: TfrmRaporCariBakiyeliHareketTarihli;

implementation

uses unDataMod, ufrmRaporCiktisi, ufrmCariSDLG,unFunc,DateUtils,main;

{$R *.dfm}

procedure TfrmRaporCariBakiyeliHareketTarihli.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_cari_bakiyeli_hareket_tarihli ,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporCariBakiyeliHareketTarihli') then
    begin
      Application.CreateForm(TfrmRaporCariBakiyeliHareketTarihli,frmRaporCariBakiyeliHareketTarihli);
      with frmRaporCariBakiyeliHareketTarihli.cmbParaBirimi do
      begin
        Items.Add(glb_DEFCUR);
        Items.AddStrings(glb_TAK_DOV_LIST);
        ItemIndex := 0;
      end;
      if glb_SUBELI then
      begin
        DataMod.FillSubeStr(frmRaporCariBakiyeliHareketTarihli.cmbSube.Items);
        frmRaporCariBakiyeliHareketTarihli.cmbSube.ItemIndex := 0;
        frmRaporCariBakiyeliHareketTarihli.grpSube.Visible := True;
      end
      else
      begin
        frmRaporCariBakiyeliHareketTarihli.grpSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.btnRaporClick(Sender: TObject);
var
  SubeID,strSQL : String;
begin

  case frmRaporCiktisi.Tarih_Karsilastir(dtpIslemTar1.Date,dtpIslemTar2.Date) of
  2:
    begin
      Application.MessageBox('Ýkinci iþlem tarihi birinci tarihten küçük olamaz.Lütfen iþlem tarihlerini kontrol ediniz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
  end;


  if cb_Kod_Araligi.Checked then
  begin
      if (Trim(txt_ilk_Cari.Text)='') or (Trim(txt_son_Cari.Text)='') then
      begin
        Application.MessageBox('Kod Aralýðýný Giriniz','Dikkat',MB_ICONWARNING);
        Exit;
      end;
  end;


     if sender=Btn_Fast then
     begin
        strSQL :=
'select '+
'    cari_liste.prm_cari_kod, '+
'    cari_liste.prm_cari_ad, '+
'    cari_liste.prm_cari_borc, '+
'    cari_liste.prm_cari_alacak, '+
'    cari_liste.prm_cari_dev_borc, '+
'    cari_liste.prm_cari_dev_alacak, '+
'    cari_liste.prm_cari_borc_bakiye, '+
'    cari_liste.prm_cari_alacak_bakiye, '+
'    cari_liste_har.prm_cari_kod, '+
'    cari_liste_har.prm_tarih, '+
'    cari_liste_har.prm_belge_tur, '+
'    cari_liste_har.prm_fis_no, '+
'    cari_liste_har.prm_aciklama, '+
'    cari_liste_har.prm_tip, '+
'    cari_liste_har.prm_borc, '+
'    cari_liste_har.prm_alacak, '+
'    cari_liste_har.prm_cari_borc_bakiye, '+
'    cari_liste_har.prm_cari_alacak_bakiye, '+
'    cari_liste_har.prm_cari_dev_borc_bakiye, '+
'    cari_liste_har.prm_cari_dev_alacak_bakiye '+
' from cari_liste(:devir,:ilk,:son,null,:kullan_tip,:dovkod,null) '+
' inner join cari_liste_har(:devir,null,:dov_kod,:tar1,:tar2,:sefer_mozot,:devir,null) on '+
' (cari_liste.prm_cari_kod=cari_liste_har.prm_cari_kod) ';

{    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if (SubeID <> '0') and (Trim(SubeID)<>'')  then
      begin
         strSQL:=strSQL+ ' Where cari_liste.prm_cari_sid='+Trim(SubeID);
      end;
    end
    else
    begin
         strSQL:=strSQL+ ' Where cari_liste.prm_cari_sid='+Inttostr(glb_SID);
    end;
}
strSQL:=strSQL+
' order by cari_liste_har.prm_fis_no, cari_liste_har.prm_cari_kod, cari_liste_har.prm_tarih ';

          IB_Query1.Close;
          IB_Query1.Sql.Clear;
          IB_Query1.Sql.Add(strSql);

          IB_Query1.ParamByName('tar1').AsString:=DateTostr(dtpIslemTar1.Date);
          IB_Query1.ParamByName('tar2').AsString:=DateTostr(dtpIslemTar2.Date);


          if CheckBox1.Checked then
          IB_Query1.ParamByName('sefer_mozot').AsInteger:=0
          else
          IB_Query1.ParamByName('sefer_mozot').AsInteger:=1;

          if chkDEVIR.Checked then
          IB_Query1.ParamByName('Devir').AsInteger:=1
          else
          IB_Query1.ParamByName('Devir').AsInteger:=0;

          IB_Query1.ParamByName('ilk').AsVariant:=null;
          IB_Query1.ParamByName('son').AsVariant:=null;
          //IB_Query1.ParamByName('grup').AsVariant:=null;

          IB_Query1.ParamByName('kullan_tip').AsInteger:=1;

          if not cb_Kod_Araligi.Checked then
          IB_Query1.ParamByName('kullan_tip').AsInteger:=1;

          if cb_Kod_Araligi.Checked then
          if (Trim(txt_ilk_Cari.Text)<>'') and (Trim(txt_son_Cari.Text)<>'') then
          begin
          IB_Query1.ParamByName('kullan_tip').AsInteger:=2;
          IB_Query1.ParamByName('ilk').AsVariant:=txt_ilk_Cari.Text;
          IB_Query1.ParamByName('son').AsVariant:=txt_son_Cari.Text;
          end;

         IB_Query1.ParamByName('dovkod').AsVariant:=null;

         if (cmbParaBirimi.Text <> glb_DEFCUR) then
         begin
         IB_Query1.ParamByName('dovkod').AsString:=cmbParaBirimi.Text;
         end;

          IB_Query1.Open;

          Prv_Yazdirildi:=False;
          frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Cari_Hareket_Tarih.fr3');
          //frxReport1.PrepareReport();
          { a:=(frxReport1.FindComponent('Memo_Rapor_Adi') as TfrxMemoView);
           a.memo.Text:='Cari Hareket Toplamý';
           if chk_devir.Checked then
           a.memo.Text:='Devirli Cari Hareket Toplamý';
           }
          frxReport1.showReport;


          Exit;


     end;


  if (cmbParaBirimi.Text = glb_DEFCUR) then
  begin
    strSQL := 'SELECT CARIHAR.CARI_KOD'
            + ',(SELECT CARI.CARI_AD FROM CARI WHERE CARI.CARI_KOD=CARIHAR.CARI_KOD) as CARI_AD'
            + ',CARIHAR.BELGE_ID'
            + ',CARIHAR.TIP'
            + ',CARIHAR.TUTAR_VPB AS TOPLAM'
            + ',CARIHAR.TARIH'
            + ',CARIHAR.ACIKLAMA'
            + ',CARIHAR.MASRAF_MERK'
            + ',CARIHAR.PLASIYER_KOD'
            + ',CARIHAR.BELGE_TUR'
            + ',CARIHAR.PROJE_KOD FROM CARIHAR'
            + ' WHERE CARIHAR.TARIH BETWEEN '+ SQL_Tarih(dtpIslemTar1.Date) + ' AND ' + SQL_Tarih(dtpIslemTar2.Date);

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

    if CheckBox1.State<>cbGrayed then
    begin
         {
         if CheckBox1.Checked then
         strSQL := strSQL + ' AND BELGE_TUR='+SQL_Para(BT_SEFER)
         else
         strSQL := strSQL + ' AND BELGE_TUR<>'+SQL_Para(BT_SEFER)
         }
         if CheckBox1.Checked then
         //strSQL := strSQL + ' AND (BELGE_TUR=41 OR BELGE_TUR=42) ';
         else
         strSQL := strSQL + ' AND (BELGE_TUR<>41 OR BELGE_TUR<>42) ';

    end;

    if cb_Kod_Araligi.Checked then
    begin
        strSQL := strSQL + ' And CARIHAR.CARI_KOD BETWEEN '+ SQL_Katar(txt_ilk_Cari.Text)+ ' AND '+ SQL_Katar(txt_son_Cari.Text);

    end;


    strSQL := strSQL + ' ORDER BY CARIHAR.TARIH';

    frmRaporCiktisi_Open(strSQL,1);
  end
  else
  begin
    strSQL := 'SELECT CARIHAR.CARI_KOD,'
            + '(SELECT CARI.CARI_AD FROM CARI WHERE CARI.CARI_KOD=CARIHAR.CARI_KOD) as CARI_AD,'
            + 'CARIHAR.MASRAF_MERK,'
            + 'CARIHAR.PLASIYER_KOD,'
            + 'CARIHAR.BELGE_ID,'
            + 'CARIHAR.TIP,'
            + 'CARIHAR_DOV.TUTAR TOPLAM,'
            + 'CARIHAR.TARIH,'
            + 'CARIHAR.ACIKLAMA,'
            + 'CARIHAR.BELGE_TUR,'
            + 'CARIHAR.PROJE_KOD FROM CARIHAR'
            + ' LEFT OUTER JOIN CARIHAR_DOV ON (CARIHAR.CARIHAR_ID = CARIHAR_DOV.CARIHAR_ID) AND (CARIHAR.CARIHAR_SID = CARIHAR_DOV.CARIHAR_SID)'
            + ' WHERE ((CARIHAR.TARIH BETWEEN '+ SQL_Tarih(dtpIslemTar1.Date)
            + ' AND ' + SQL_Tarih(dtpIslemTar2.Date)
            + ') AND'+' (CARIHAR_DOV.DOVKOD =' + SQL_Katar(cmbParaBirimi.Text)+')';
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        strSQL := strSQL + ' AND (CARIHAR.CARIHAR_SID = ' + SubeID+')';
      end;
    end
    else
    begin
      strSQL := strSQL + ' AND (CARIHAR.CARIHAR_SID = '+ inttostr(glb_SID)+')';
    end;

    if CheckBox1.State<>cbGrayed then
    begin
         {if CheckBox1.Checked then
         strSQL := strSQL + ' AND BELGE_TUR='+SQL_Para(BT_SEFER)
         else
         strSQL := strSQL + ' AND BELGE_TUR<>'+SQL_Para(BT_SEFER)
         }
         if CheckBox1.Checked then
         //strSQL := strSQL + ' AND (BELGE_TUR=41 OR BELGE_TUR=42) ';
         else
         strSQL := strSQL + ' AND (BELGE_TUR<>41 OR BELGE_TUR<>42) ';

    end;


    if cb_Kod_Araligi.Checked then
    begin
        strSQL := strSQL + ' And CARIHAR.CARI_KOD BETWEEN '+ SQL_Katar(txt_ilk_Cari.Text)+ ' AND '+ SQL_Katar(txt_son_Cari.Text);
    end;


    strSQL := strSQL + ') ORDER BY CARIHAR.TARIH';



    frmRaporCiktisi_Open(strSQL,2);
  end;
end;



procedure TfrmRaporCariBakiyeliHareketTarihli.frmRaporCiktisi_Open(strSQL:String;Rapor_Tipi:Byte);
//rapor tipi 1 ise glb_defcur seçilidir.
//rapor tipi 2 ise takipli kurlardan birisi seçilidir.
var
  CHeader : TcxSSHeader;
begin
  with qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((qryRapor.Eof) and (qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Active := False;
    exit;
  end
  else
  begin
    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz(Rapor_Tipi);
    frmRaporCiktisi.SetCellFormat(1,3,1,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    frmRaporCiktisi.SetCellAlignment(0,2,0,2,haright,vaCenter);
    frmRaporCiktisi.SetCellAlignment(2,2,2,2,haright,vaCenter);
    frmRaporCiktisi.SetCellAlignment(5,2,8,2,haright,vaCenter);
    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[1] := 100;
    CHeader.Size[2] := 300;
    CHeader.Size[3] := 100;
    CHeader.Size[4] := 250;
    CHeader.Size[5] := 125;
    CHeader.Size[6] := 125;
    frmRaporCiktisi.Rapor_Ayarlari(2);
    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
    qryToplam.Close;
  end;
end;


procedure TfrmRaporCariBakiyeliHareketTarihli.yaz(Rapor_Tipi:Byte);
var
  baslik_yazildi : Boolean;
  res_Cari : TStringList;
  SubeID : String;
begin
  row := 0;
  col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      frmRaporCiktisi.SetCellText(row,col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
    row := 1;
  end;
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(1,0,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(0,1,0,1,[fsBold],8,'MS Sans Serif',0);
  Inc(row);
  Alan_isimlerini_ekle;

  if chkDEVIR.Checked then
  begin
    with qryToplam do
    begin
      Active := False;
      SQL.Clear;
      if cmbParaBirimi.Text = glb_DEFCUR then
      begin
        SQL.Add('SELECT * FROM CARI WHERE (DEVREDEN_BORC-DEVREDEN_ALACAK) <> 0');
      end
      else
      begin
        if cmbParaBirimi.Text <> 'TRL' then
        begin
          SQL.Add('SELECT CARI_DOV.CARI_KOD,CARI_DOV.DEVREDEN_BORC,CARI_DOV.DEVREDEN_ALACAK,');
          SQL.Add('(SELECT CARI.CARI_AD FROM CARI WHERE CARI.CARI_KOD=CARI_DOV.CARI_KOD) as CARI_AD FROM CARI_DOV');
          SQL.Add('WHERE (CARI_DOV.DEVREDEN_BORC-CARI_DOV.DEVREDEN_ALACAK) <> 0');
        end
        else
        begin
          SQL.Add('SELECT CARI_KOD,CARI_AD,(DEVREDEN_BORC*1000000) as DEVREDEN_BORC,(DEVREDEN_ALACAK*1000000) as DEVREDEN_ALACAK');
          SQL.Add('FROM CARI WHERE (DEVREDEN_BORC-DEVREDEN_ALACAK) <> 0');
        end;
      end;
      Active := True;
    end;
    qryToplam.First;
    while not (qryToplam.Eof) do
    begin
      col :=  0;
  {$IfDef TRANSPORT}
    DataMod.Rapor_Satir_Renklendir(col,row,8);
  {$EndIf}

  {$IfnDef TRANSPORT}
    DataMod.Rapor_Satir_Renklendir(col,row,11);
  {$EndIf}

      Inc(row);
      frmRaporCiktisi.SetCellDate(col,row,glb_DONEM_BAS);
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('CARI_KOD').AsString);
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryToplam.FieldByName('CARI_AD').AsString);
      Inc(col,2);
      frmRaporCiktisi.SetCellText(row,col,'DEVÝR');
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,'0');
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,'DEVÝR KAYDI');

      if qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency > qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency then
      begin
        frmRaporCiktisi.SetCellText(row,col-3,'B');
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency - qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency));
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        frmRaporCiktisi.format_ayarla(col,row,col,row);
      end
      else
      if qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency < qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency then
      begin
        frmRaporCiktisi.SetCellText(row,col-3,'A');
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,CurrToStr(qryToplam.FieldByName('DEVREDEN_ALACAK').AsCurrency - qryToplam.FieldByName('DEVREDEN_BORC').AsCurrency));
        frmRaporCiktisi.format_ayarla(col,row,col,row);
      end
      else
      begin
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        frmRaporCiktisi.format_ayarla(col,row,col,row);
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,'0');
        frmRaporCiktisi.format_ayarla(col,row,col,row);
      end;
      qryToplam.Next;
    end;
    Inc(row);
  end;

  if not chkDEVIR.Checked then Inc(row);
  qryRapor.First;

  while not (qryRapor.Eof) do
  begin
    col :=  0;

    {if glb_RAPOR_RENKLENDIRME then
    begin
      Inc(glb_Renk_Say);

      if glb_RAPOR_RENK_TIPI=1 then
      if (glb_Renk_Say mod 2)=1  then
      frmRaporCiktisi.SetCellPattern(col,row,col+6,row,glb_ARKAPLAN_RENK1,glb_ARKAPLAN_RENK0,glb_RAPOR_DOLGU)
      else
      frmRaporCiktisi.SetCellPattern(col,row,col+6,row,glb_ARKAPLAN_RENK2,glb_ARKAPLAN_RENK0,glb_RAPOR_DOLGU);

      if glb_RAPOR_RENK_TIPI=2 then
      if (glb_Renk_Say mod 2)=1  then
      frmRaporCiktisi.SetCellFont(col,row,col+6,row,[fsBold],8,'MS Sans Serif',glb_ARKAPLAN_RENK1)
      else
      frmRaporCiktisi.SetCellFont(col,row,col+6,row,[fsBold],8,'MS Sans Serif',glb_ARKAPLAN_RENK2);

    end;
    }
  {$IfDef TRANSPORT}
    DataMod.Rapor_Satir_Renklendir(col,row,8);
  {$EndIf}

  {$IfnDef TRANSPORT}
    DataMod.Rapor_Satir_Renklendir(col,row,11);
  {$EndIf}


    frmRaporCiktisi.SetCellDate(col,row,qryRapor.FieldByName('TARIH').AsDate);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_KOD').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CARI_AD').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TIP').AsString);
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,DataMod.GetBelgeKod(qryRapor.FieldByName('BELGE_TUR').AsInteger));
    case qryRapor.FieldByName('BELGE_TUR').AsInteger of
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
        Inc(col);
        frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('BELGE_ID').AsString);
      end;
    end;//end case
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ACIKLAMA').AsString);
    Inc(col);
    if qryRapor.FieldByName('TIP').AsString = 'B' then
    begin
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TOPLAM').AsString);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,'0');
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;
    if qryRapor.FieldByName('TIP').AsString = 'A' then
    begin
      frmRaporCiktisi.SetCellText(row,col,'0');
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('TOPLAM').AsString);
      if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
      else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
    end;
  {$IfnDef TRANSPORT}
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('MASRAF_MERK').AsString);
    if glb_PROJE_UYG then
    begin
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PROJE_KOD').AsString);
    end;
    if glb_PLASIYER_UYG then
    begin
      Inc(col);
      frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('PLASIYER_KOD').AsString);
    end;
  {$EndIf}

    Inc(col);
    Inc(row);
    frmRaporCariBakiyeliHareketTarihli.qryRapor.Next;
  end;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.rapor_bitti;
begin
  Inc(row);
  col := 6;
  frmRaporCiktisi.SetCellText(row,col,'TOPLAM');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'=SUM(H4:H'+IntToStr(row)+')');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
  else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'=SUM(I4:I'+IntToStr(row)+')');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
  if cmbParaBirimi.Text = glb_DEFCUR then frmRaporCiktisi.format_ayarla(col,row,col,row)
  else frmRaporCiktisi.format_ayarla_dov(col,row,col,row);
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.Alan_isimlerini_ekle;
begin
  Inc(row);
  frmRaporCiktisi.SetCellText(row,col,'TARÝH');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'CARÝ KOD');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'CARÝ AD');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'TÝP');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'BELGE TÜRÜ');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'FÝÞ NUMARASI');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'AÇIKLAMA');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'BORÇ');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'ALACAK');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);


  {$IfnDef TRANSPORT}
  Inc(col);
  frmRaporCiktisi.SetCellText(row,col,'ÝÞLEM MERKEZÝ');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  if glb_PROJE_UYG then
  begin
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,'PROJE KODU');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  end;
  if glb_PLASIYER_UYG then
  begin
    Inc(col);
    frmRaporCiktisi.SetCellText(row,col,'PLASÝYER KODU');
    frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
  end;
  {$EndIf}

  col := 0;
end;



procedure TfrmRaporCariBakiyeliHareketTarihli.FormKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmRaporCariBakiyeliHareketTarihli.FormKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F6:PageControl1.SelectNextPage(True);
  end;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.dtpIslemTar1Enter(Sender: TObject);
begin
  dtpIslemTar1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.dtpIslemTar2Enter(Sender: TObject);
begin
  dtpIslemTar2.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.dtpIslemTar1Exit(Sender: TObject);
begin
  dtpIslemTar1.Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.dtpIslemTar2Exit(Sender: TObject);
begin
  dtpIslemTar2.Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.cmbParaBirimiEnter(Sender: TObject);
begin
  (Sender as TComboBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.cmbParaBirimiExit(Sender: TObject);
begin
  (Sender as TComboBox).Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporCariBakiyeliHareketTarihli);
  {$IfnDef TRANSPORT}
  CheckBox1.Visible:=False;
  {$EndIf}
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.chkDEVIREnter(Sender: TObject);
begin
  (Sender as TCheckBox).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.chkDEVIRExit(Sender: TObject);
begin
 (Sender as TCheckBox).Color := clBtnFace;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.Button1Click( Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      txt_ilk_Cari.Text := Cari_KOD;
  end;

end;

procedure TfrmRaporCariBakiyeliHareketTarihli.Button6Click( Sender: TObject);
var
  Cari_KOD,Cari_AD:String;
begin
  if frmCariSDLG.Form_Open(False,Cari_KOD,Cari_AD,1) Then
  begin
      txt_son_Cari.Text := Cari_KOD;
  end;

end;

procedure TfrmRaporCariBakiyeliHareketTarihli.txt_son_CariEnter( Sender: TObject);
begin
    (Sender as TEdit).Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.txt_son_CariExit(
  Sender: TObject);
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

procedure TfrmRaporCariBakiyeliHareketTarihli.txt_ilk_CariExit( Sender: TObject);
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

procedure TfrmRaporCariBakiyeliHareketTarihli.txt_ilk_CariEnter( Sender: TObject);
begin
    (Sender as TEdit).Color := clWindow;
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.IB_Query1CalculateField(
  Sender: TIB_Statement; ARow: TIB_Row; AField: TIB_Column);
begin
     if ARow.ByName('prm_belge_tur').AsInteger>0 then
    ARow.ByName('CALC_BELGE_TUR').AsString :=
    DataMod.GetBelgeKod(ARow.ByName('prm_belge_tur').AsInteger)
    else
    ARow.ByName('CALC_BELGE_TUR').AsString :='DEVÝR';
end;

procedure TfrmRaporCariBakiyeliHareketTarihli.frxReport1BeforePrint(
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

end.







{select
    cari_liste.prm_cari_kod,
    cari_liste.prm_cari_ad,
    cari_liste.prm_cari_borc,
    cari_liste.prm_cari_alacak,
    cari_liste.prm_cari_dev_borc,
    cari_liste.prm_cari_dev_alacak,
    cari_liste.prm_cari_borc_bakiye,
    cari_liste.prm_cari_alacak_bakiye,
    cari_liste_har.prm_cari_kod,
    cari_liste_har.prm_tarih,
    cari_liste_har.prm_belge_tur,
    cari_liste_har.prm_fis_no,
    cari_liste_har.prm_aciklama,
    cari_liste_har.prm_tip,
    cari_liste_har.prm_borc,
    cari_liste_har.prm_alacak,
    cari_liste_har.prm_cari_borc_bakiye,
    cari_liste_har.prm_cari_alacak_bakiye,
    cari_liste_har.prm_cari_dev_borc_bakiye,
    cari_liste_har.prm_cari_dev_alacak_bakiye

 from cari_liste(0,'','','',1,null,null)
 inner join cari_liste_har(1,null,null,'01.01.2001','01.01.2008',1,1,0) on
 (cari_liste.prm_cari_kod=cari_liste_har.prm_cari_kod)
 order by  prm_fis_no ,cari_liste_har.prm_cari_kod,prm_tarih

}
