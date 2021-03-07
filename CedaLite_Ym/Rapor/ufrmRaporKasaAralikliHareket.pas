{$INCLUDE directive.inc}

unit ufrmRaporKasaAralikliHareket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, IB_Components, ExtCtrls, StdCtrls, frxClass, frxIBOSet
  , cxSSTypes, cxSSHeaders;

type
  TfrmRaporKasaAralikliHareket = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    chk_Sirket: TCheckBox;
    qry_Kasa: TIB_Query;
    qry_Rapor: TIB_Cursor;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    rdCins: TRadioGroup;
    qryDEVREDEN: TIB_Query;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    dtp_Tarih_1: TDateTimePicker;
    dtp_Tarih_2: TDateTimePicker;
    txt_KasaKod: TEdit;
    btnKasa: TButton;
    grpSube: TGroupBox;
    cmbSube: TComboBox;
    TabSheet2: TTabSheet;
    Label12: TLabel;
    lblKOD1: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    txtISLEMMERKEZI: TEdit;
    Button4: TButton;
    txtKOD1: TEdit;
    btnKOD1: TButton;
    txtKOD2: TEdit;
    Button6: TButton;
    txtKOD3: TEdit;
    Button7: TButton;
    txtKOD4: TEdit;
    Button8: TButton;
    frxIBODts_Kasa_Gunluk: TfrxIBODataset;
    frxReport1: TfrxReport;
    IB_Query1: TIB_Query;
    btn_Fast: TButton;
////////////////////////////////////////////////////////////////////////////////
    procedure Form_Open();
    procedure rapor_kasa_gunluk_hareket_yaz(tip:Byte);
    procedure Alan_isimlerini_ekle();
    procedure devir_hesapla;
    procedure rapor_sirket_ekle;
    procedure Rapor_Bitti;
    function rapor_toplam_gc_hesapla:Byte;
    function rapor_sql_aktar:Boolean;
////////////////////////////////////////////////////////////////////////////////
    procedure btnKasaClick(Sender: TObject);
    procedure txt_KasaKodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txt_KasaKodExit(Sender: TObject);
    procedure txt_KasaKodKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure txt_KasaKodEnter(Sender: TObject);
    procedure dtp_Tarih_1Enter(Sender: TObject);
    procedure dtp_Tarih_2Enter(Sender: TObject);
    procedure dtp_Tarih_2Exit(Sender: TObject);
    procedure dtp_Tarih_1Exit(Sender: TObject);
    procedure chk_SirketEnter(Sender: TObject);
    procedure chk_SirketExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtISLEMMERKEZIEnter(Sender: TObject);
    procedure txtISLEMMERKEZIExit(Sender: TObject);
    procedure txtKOD1Exit(Sender: TObject);
    procedure txtKOD2Exit(Sender: TObject);
    procedure txtKOD3Exit(Sender: TObject);
    procedure txtKOD4Exit(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnKOD1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD1KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD2KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD3KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure txtKOD4KeyUp(Sender: TObject; var Key: Word;      Shift: TShiftState);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
////////////////////////////////////////////////////////////////////////////////
  private
    prv_Cikis,prv_Giris:Currency;
    prv_kasa_dov_kod:String;
    prv_row,prv_col:integer;
    Prv_Yazdirildi:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;
  const cns_kasa_aralikli_har = 14;
var
  frmRaporKasaAralikliHareket: TfrmRaporKasaAralikliHareket;

implementation

uses unDataMod,unFunc,ufrmRaporCiktisi,main;

{$R *.dfm}

procedure TfrmRaporKasaAralikliHareket.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_kasa_aralikli_har,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok.','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporKasaAralikliHareket') then
    begin
      Application.CreateForm(TfrmRaporKasaAralikliHareket,frmRaporKasaAralikliHareket);
      with frmRaporKasaAralikliHareket do
      begin
        DataMod.Rapor_Kod_Visible_Fields('KASA'
                                         ,txtISLEMMERKEZI
                                         ,txtKOD1
                                         ,txtKOD2
                                         ,txtKOD3
                                         ,txtKOD4
                                         ,Button4
                                         ,btnKOD1
                                         ,Button6
                                         ,Button7
                                         ,Button8
                                         ,Label12
                                         ,lblKOD1
                                         ,Label14
                                         ,Label15
                                         ,Label16);

  {$IfDef TRANSPORT}
        TabSheet2.Visible := false;
  {$EndIf}
                                           
      end;
      if glb_SUBELI then
      begin
        if glb_SUBE_MUDAHALE then
        begin
          DataMod.FillSubeStr(frmRaporKasaAralikliHareket.cmbSube.Items);
          with frmRaporKasaAralikliHareket do
          begin
            cmbSube.ItemIndex := 0;
            grpSube.Visible := True;
          end;
        end
        else
        begin
          with frmRaporKasaAralikliHareket.cmbSube do
          begin
            Clear;
            Items.Add(DataMod.SubeID2Ad(False,glb_SID));
            ItemIndex := 0;
            Enabled := False;
          end;
        end;
      end
      else
      begin
        frmRaporKasaAralikliHareket.grpSube.Visible := False;
      end;//end if glb_SUBELI then
    end;
  end;
end;


procedure TfrmRaporKasaAralikliHareket.btnKasaClick(Sender: TObject);
var
  Kasa_Kod,Aciklama,DovKod : String;
begin
  if DataMod.LS_KASA(Kasa_Kod,Aciklama,DovKod) then txt_KasaKod.Text := Kasa_Kod;
end;

procedure TfrmRaporKasaAralikliHareket.txt_KasaKodKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
var
  Kasa_Kod,Kasa_Ad,DovKod : String;
begin
  if Key= VK_F4 Then
  begin
    if DataMod.LS_Kasa(Kasa_Kod,Kasa_Ad,DovKod) then  txt_KasaKod.Text := Kasa_Kod;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.txt_KasaKodExit(Sender: TObject);
var
  Kasa_Ad : String;
begin
  if Length(Trim(txt_KasaKod.Text))=0 then
  begin
    txt_KasaKod.Color := clWindow;
    exit;
  end;

  if not DataMod.GET_KULLANICI_KASA_KOD(txt_Kasakod.Text,Kasa_Ad) then
  begin
    txt_KasaKod.SetFocus;
  end
  else
  begin
    txt_KasaKod.Color := clWindow;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.txt_KasaKodKeyPress(Sender: TObject;  var Key: Char);
begin
{
  if Key = #8 then exit;
  if not ((Key in ['A'..'Z']) or (Key in ['a'..'z']) or (Key in ['0'..'9'])) then
    begin
      Key := #0;
    end;
}
  If not isDigit(Key) Then Key := toUpper(Key);
end;


procedure TfrmRaporKasaAralikliHareket.FormShow(Sender: TObject);
begin
  dtp_Tarih_1.Date := glb_DONEM_BAS;
  dtp_Tarih_2.Date := DataMod.GET_SERVER_DATE;
end;

procedure TfrmRaporKasaAralikliHareket.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporKasaAralikliHareket.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TfrmRaporKasaAralikliHareket.btnRaporClick(Sender: TObject);
var
   sql_strx,sql_str,sql_str1,sql_str2:String;
begin



 if Sender=Btn_Fast then
 begin




 Sql_str2:=
'select '+
' CAST(''01.01.2007'' AS DATE) tarih, '+
' CAST('''' AS VARCHAR(15)) kasa_kod, '+
' CAST(0 AS INTEGER) kasahar_id, '+
' CAST(0 AS INTEGER) belge_id, '+
' CAST(''Önceki Tarihten Hesaplanan '' AS VARCHAR(50)) aciklama, '+
' CAST('''' AS VARCHAR(5)) dovkod, '+
' CAST('''' AS CHAR(1)) tip, '+
' CAST(0 AS NUMERIC(15,4)) Tutar, '+
' (select sum(kasadeger) from kasahar where SIRA_NO > 0 and tip=''G'' and kasa.kasa_kod=kasahar.kasa_kod and Tarih<='+SQL_Tarih(dtp_Tarih_1.Date-1)+') borc, '+
' (select sum(kasadeger) from kasahar where SIRA_NO > 0 and tip=''C'' and kasa.kasa_kod=kasahar.kasa_kod and Tarih<='+SQL_Tarih(dtp_Tarih_1.Date-1)+') Alacak '+
'from kasa '+
'where kasa_kod='+SQL_Katar(txt_KasaKod.Text)+
' union ';


if rdCins.ItemIndex=0 then
begin
 Sql_str:=
'select '+
'tarih, '+
'kasa_kod, '+
'kasahar_id, '+
'belge_id, '+
'aciklama, '+
'dovkod, '+
'tip, '+
'kasadeger Tutar, '+
'case '+
'when Tip=''G'' then '+
'kasadeger '+
'end borc '+
',case '+
'when Tip=''C'' then '+
'kasadeger '+
'end alacak '+
'from kasahar '+
'where SIRA_NO > 0 and kasa_kod='+SQL_Katar(txt_KasaKod.Text)+ ' and Tarih between '+SQL_Tarih(dtp_Tarih_1.Date)+' and '+SQL_Tarih(dtp_Tarih_2.Date);

 Sql_str1:=
'SELECT '+
' CAST(''01.01.2007'' AS DATE) tarih, '+
' CAST('''' AS VARCHAR(15)) kasa_kod , '+
' CAST(0 AS INTEGER) kasahar_id, '+
' CAST(0 AS INTEGER) belge_id, '+
' CAST(''Devir'' AS VARCHAR(50)) aciklama, '+
' CAST('''' AS VARCHAR(5)) dovkod, '+
' CAST(''B'' AS CHAR(1)) tip, '+
' CAST(0 AS NUMERIC(15,4)) Tutar, '+
'DEVREDEN_BORC AS BORC,DEVREDEN_ALACAK AS ALACAK FROM KASA where kasa_kod='+SQL_Katar(txt_KasaKod.Text)+
'union ';


end;

if rdCins.ItemIndex=1 then
begin
 Sql_str:=
'select '+
'tarih, '+
'kasa_kod, '+
'kasahar_id, '+
'belge_id, '+
'aciklama, '+
'dovkod, '+
'tip, '+
'tutar_vpb Tutar '+
',case '+
'when Tip=''G'' then '+
'tutar_vpb '+
'end borc '+
',case '+
'when Tip=''C'' then '+
'tutar_vpb '+
'end alacak '+

'from kasahar '+
'where SIRA_NO > 0 and kasa_kod='+SQL_Katar(txt_KasaKod.Text)+ ' and Tarih between '+SQL_Tarih(dtp_Tarih_1.Date)+' and '+SQL_Tarih(dtp_Tarih_2.Date);

 Sql_str1:=
'SELECT '+
' CAST(''01.01.2007'' AS DATE) tarih, '+
' CAST('''' AS VARCHAR(15)) kasa_kod, '+
' CAST(0 AS INTEGER) kasahar_id, '+
' CAST(0 AS INTEGER) belge_id, '+
' CAST('''' AS VARCHAR(50)) aciklama, '+
' CAST('''' AS VARCHAR(5)) dovkod, '+
' CAST(''B'' AS CHAR(1)) tip, '+
' CAST(0 AS NUMERIC(15,4)) Tutar, '+
'DEVREDEN_BORC_VPB AS BORC,DEVREDEN_ALACAK_VPB AS ALACAK FROM KASA where kasa_kod='+SQL_Katar(txt_KasaKod.Text)+
'union ';

end;

//Sql_strx:=Sql_str;

//if chk_Devir.Checked then
Sql_strx:=Sql_str1+Sql_str2+Sql_str;

       with IB_Query1 do
       begin
         Active := false;
         SQL.Clear;
         SQL.Add(Sql_strx);
         Active := True;
       end;

       if ((IB_Query1.Eof) and (IB_Query1.bof))then
       begin
         Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý. Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
         IB_Query1.Close;
         Exit;
       end;

       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Kasa_Gunluk.fr3');

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



  case frmRaporCiktisi.Tarih_Karsilastir(dtp_Tarih_1.DateTime,dtp_Tarih_2.DateTime) of
  0:
    begin
      Application.MessageBox('Seçilen tarihler birbirleriyle ayný olamazlar.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  1:
    begin
      case rapor_toplam_gc_hesapla of
      0://kasa kodu boþ ise
        begin
          Application.MessageBox('Kasa seçmeden rapor alamazsýnýz.','Dikkat',MB_ICONWARNING);
          exit;
        end;
      2://tarihler eþit deðil ise
        begin
          if rapor_sql_aktar then
          begin
            frmRaporCiktisi.form_open();
            frmRaporCiktisi.grdA.BeginUpdate;
            rapor_sirket_ekle;
            rapor_kasa_gunluk_hareket_yaz(2);
            frmRaporCiktisi.grdA.EndUpdate;
            frmRaporCiktisi.WindowState := wsMaximized;
            qry_Kasa.Active := false;
            qry_Rapor.Active := false;
          end;
        end;
      3:
        begin
          Application.MessageBox('Seçilen tarihler arasýnda herhangi bir kayýt bulunamadý.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
          exit;
        end;
      end;//end case
    end;
  2:
    begin
      Application.MessageBox('Seçtiðiniz ilk tarih ikinci tarihten büyük olamaz.Lütfen kontrol ediniz.','Dikkat',MB_ICONWARNING);
      exit;
    end;
  end;
end;//end procedure


function TfrmRaporKasaAralikliHareket.rapor_toplam_gc_hesapla:Byte;
var
  SubeID : String;
begin
  Result := 0;
  prv_Cikis := 0;
  prv_Giris := 0;
  if Length(trim(txt_KasaKod.Text)) <> 0 then
  begin
    with qry_Kasa do
    begin
      Active := false;
      SQL.Clear;
      case rdCins.ItemIndex of
      //ESKÝSÝ
      0:SQL.Add('SELECT SIRA_NO,TIP,KASADEGER FROM KASAHAR WHERE SIRA_NO > 0 AND KASA_KOD='+SQL_Katar(txt_KasaKod.Text)+' AND TARIH BETWEEN '+SQL_Tarih(glb_DONEM_BAS)+' AND '+SQL_Tarih(frmRaporCiktisi.Date_PriorDay(dtp_Tarih_1.DateTime)));
      1:SQL.Add('SELECT SIRA_NO,TIP,TUTAR_VPB AS KASADEGER FROM KASAHAR WHERE SIRA_NO > 0 AND KASA_KOD='+SQL_Katar(txt_KasaKod.Text)+' AND TARIH BETWEEN '+ SQL_Tarih(glb_DONEM_BAS) +' AND '+ SQL_Tarih(frmRaporCiktisi.Date_PriorDay(dtp_Tarih_1.DateTime)));
      end;
      if glb_SUBELI then
      begin
        SubeID := DataMod.SubeAd2ID(cmbSube.Text);
        if SubeID <> '0' then
        begin
          SQL.Add(' AND KASAHAR.KASAHAR_SID = ' + SubeID);
        end;
      end
      else
      begin
        SQL.Add(' AND KASAHAR.KASAHAR_SID = '+inttostr(glb_SID));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.MASRAF_MERK = '+SQL_Katar(txtISLEMMERKEZI.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.KOD1 = '+SQL_Katar(txtKOD1.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.KOD2 = '+SQL_Katar(txtKOD2.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.KOD3 = ' + SQL_Katar(txtKOD3.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.KOD4 = ' + SQL_Katar(txtKOD4.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      Active := True;
    end;
    if not ((qry_Kasa.Bof) and (qry_Kasa.Eof)) then
    begin
      qry_Kasa.First;
      while not qry_Kasa.Eof do
      begin
        if qry_Kasa.FieldByName('TIP').AsString = 'C' then
        begin
          prv_Cikis := prv_Cikis + qry_Kasa.FieldByName('KASADEGER').AsCurrency;
        end
        else
        begin
          prv_Giris := prv_Giris + qry_Kasa.FieldByName('KASADEGER').AsCurrency;
        end;
        qry_Kasa.Next;
      end;
      qry_Kasa.Active := false;
      Result := 2;
    end
    else
    begin
      Result := 2;
    end;
  end;//end bosluk kontrol
end;

function TfrmRaporKasaAralikliHareket.rapor_sql_aktar:Boolean;
var
  SubeID : String;
begin
  result := false;
  with qry_Rapor do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM KASAHAR WHERE KASA_KOD='+SQL_Katar(txt_KasaKod.Text)+' AND SIRA_NO > 0 AND TARIH BETWEEN '+SQL_Tarih(dtp_Tarih_1.Date)+' AND '+SQL_Tarih(dtp_Tarih_2.Date));
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add(' AND KASAHAR.KASAHAR_SID = ' + SubeID);
      end;
    end
    else
    begin
      SQL.Add(' AND KASAHAR.KASAHAR_SID = '+inttostr(glb_SID));
    end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtISLEMMERKEZI.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.MASRAF_MERK = '+SQL_Katar(txtISLEMMERKEZI.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD1.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.KOD1 = '+SQL_Katar(txtKOD1.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD2.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.KOD2 = '+SQL_Katar(txtKOD2.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD3.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.KOD3 = ' + SQL_Katar(txtKOD3.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
      if Length(Trim(txtKOD4.Text)) <> 0 then
      begin
        SQL.Add(' AND KASAHAR.KOD4 = ' + SQL_Katar(txtKOD4.Text));
      end;
////////////////////////////////////////////////////////////////////////////////
    SQL.Add(' ORDER BY TARIH,KASAHAR_ID');
    Active := True;
  end;//end with
  if ((qry_Rapor.Eof) and (qry_Rapor.Bof)) then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qry_Rapor.Close;
  end
  else
  begin
    Result := True;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.Alan_isimlerini_ekle;
begin
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'FÝÞ NO');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(prv_col,prv_row,prv_col,prv_row,haRight,vaCenter);
  prv_col := 1;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'TARÝH');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(prv_col,prv_row,prv_col,prv_row,haRight,vaCenter);
  prv_col := 2;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'AÇIKLAMA');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  prv_col := 3;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'DÖVÝZ KODU');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  prv_col := 4;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'BORÇ');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(prv_col,prv_row,prv_col,prv_row,haRight,vaCenter);
  prv_col := 5;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'ALACAK');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(prv_col,prv_row,prv_col,prv_row,haRight,vaCenter);
  prv_col := 6;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'BORÇ BAKÝYESÝ');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(prv_col,prv_row,prv_col,prv_row,haRight,vaCenter);
  prv_col := 7;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'ALACAK BAKÝYESÝ');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',4);
  frmRaporCiktisi.SetCellAlignment(prv_col,prv_row,prv_col,prv_row,haRight,vaCenter);
end;

procedure TfrmRaporKasaAralikliHareket.rapor_kasa_gunluk_hareket_yaz(tip:Byte);
var
  SubeID : String;
begin
  prv_col := 0;
  with qry_Kasa do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add('SELECT KASA_KOD,ACIKLAMA,DOVKOD FROM KASA WHERE KASA_KOD = '+SQL_Katar(txt_KasaKod.Text));
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add(' AND KASA.KASA_SID = ' + SubeID);
      end;
    end
    else
    begin
      SQL.Add(' AND KASA.KASA_SID = '+inttostr(glb_SID));
    end;
    Active := True;
  end;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'Kasa Kodu : ');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);
  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Kasa.FieldByName('KASA_KOD').AsString);
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',2);
  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'Kasa Açýklamasý :');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);
  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Kasa.FieldByName('ACIKLAMA').AsString);
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',2);
  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'Kasa Döviz Kodu :');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);
  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Kasa.FieldByName('DOVKOD').AsString);
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',2);
  if trim(txtISLEMMERKEZI.Text) <> '' then
  begin
    inc(prv_col);
    frmRaporCiktisi.SetCellText(prv_row,prv_col,'Ýþlem Merkezi :');
    frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);
    inc(prv_col);
    frmRaporCiktisi.SetCellText(prv_row,prv_col,txtISLEMMERKEZI.Text);
    frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',2);
  end;
///////////////////////////////////////////////////////////////
  prv_kasa_dov_kod := qry_Kasa.FieldByName('DOVKOD').AsString;
  qry_Kasa.Close;
///////////////////////////////////////////////////////////////
  inc(prv_row);
  prv_col := 0;
  alan_isimlerini_ekle;
  inc(prv_row,2);
  prv_col := 1;
///////////////////////////////////////////////////////////////
  devir_hesapla;
///////////////////////////////////////////////////////////////
  qry_Rapor.First;
  while not qry_Rapor.Eof do
  begin
    inc(prv_row);
    prv_col := 0;

    DataMod.Rapor_Satir_Renklendir(prv_col,prv_row,7);

    if qry_Rapor.FieldByName('ISLEM_TIP').AsInteger = 6 then
    begin
      case qry_Rapor.FieldByName('SIRA_NO').AsInteger of
      1:frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('KASAHAR_ID').AsString);
      2:frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('BELGE_ID').AsString);
      end;
    end
    else
    begin
      frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('KASAHAR_ID').AsString);
    end;
    prv_col := 1;
    frmRaporCiktisi.SetCellDate(prv_col,prv_row,qry_Rapor.FieldByName('TARIH').AsDate);
    prv_col := 2;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('ACIKLAMA').AsString);
    prv_col := 3;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('DOVKOD').AsString);
    prv_col := 4;
///////////////////////////////////////////////////////////////
    if qry_Rapor.FieldByName('TIP').AsString = 'G' then
    begin
      case rdCins.ItemIndex of
      0:
        begin
          frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('KASADEGER').AsString);
          prv_Giris := prv_Giris + qry_Rapor.FieldByName('KASADEGER').AsCurrency;
        end;
      1:
        begin
          frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('TUTAR_VPB').AsString);
          prv_Giris := prv_Giris + qry_Rapor.FieldByName('TUTAR_VPB').AsCurrency;
        end;
      end;

      if (prv_kasa_dov_kod = glb_DEFCUR) then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
      prv_col := 5;
      frmRaporCiktisi.SetCellText(prv_row,prv_col,'0');
      if (prv_kasa_dov_kod = glb_DEFCUR) then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
    end;
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
    if qry_Rapor.FieldByName('TIP').AsString = 'C' then
    begin
      frmRaporCiktisi.SetCellText(prv_row,prv_col,'0');
      if (prv_kasa_dov_kod = glb_DEFCUR) then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
      prv_col := 5;
      case rdCins.ItemIndex of
      0:
        begin
          frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('KASADEGER').AsString);
          prv_Cikis := prv_Cikis + qry_Rapor.FieldByName('KASADEGER').AsCurrency;
        end;
      1:
        begin
          frmRaporCiktisi.SetCellText(prv_row,prv_col,qry_Rapor.FieldByName('TUTAR_VPB').AsString);
          prv_Cikis := prv_Cikis + qry_Rapor.FieldByName('TUTAR_VPB').AsCurrency;
        end;
      end;//end case

      if (prv_kasa_dov_kod = glb_DEFCUR) then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
    end;
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
    if (prv_Cikis > prv_Giris) then
    begin
      prv_Cikis := prv_Cikis - prv_Giris;
      prv_Giris := 0;
      prv_col := 6;
      frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Giris));
      if prv_kasa_dov_kod = glb_DEFCUR then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
      prv_col := 7;
      frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Cikis));
      if prv_kasa_dov_kod = glb_DEFCUR then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
    end;
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
    if (prv_Cikis < prv_Giris) then
    begin
      prv_Giris := prv_Giris - prv_Cikis;
      prv_Cikis := 0;
      prv_col := 6;
      frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Giris));
      if prv_kasa_dov_kod = glb_DEFCUR then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
      prv_col := 7;
      frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Cikis));
      if prv_kasa_dov_kod = glb_DEFCUR then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
    end;
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
    if (prv_Cikis = prv_Giris) then
    begin
      prv_Giris := 0;
      prv_Cikis := 0;
      prv_col := 6;
      frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Giris));
      if prv_kasa_dov_kod = glb_DEFCUR then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
      prv_col := 7;
      frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Cikis));
      if prv_kasa_dov_kod = glb_DEFCUR then
      begin
        frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
      end
      else
      begin
        frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
      end;
    end;
    qry_Rapor.Next;
  end;
  Rapor_Bitti;
///////////////////////////////////////////////////////////////
end;

procedure TfrmRaporKasaAralikliHareket.Rapor_Bitti;
begin
  inc(prv_row);
  prv_col := 3;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'TOPLAM');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',2);

  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'=SUM(E5:E'+IntToStr(prv_row)+')');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[],8,'MS Sans Serif',2);
  if prv_kasa_dov_kod = glb_DEFCUR then frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row)
  else frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);

  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'=SUM(F5:F'+IntToStr(prv_row)+')');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[],8,'MS Sans Serif',2);
  if prv_kasa_dov_kod = glb_DEFCUR then frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row)
  else frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);

  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Giris));
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[],8,'MS Sans Serif',2);
  if prv_kasa_dov_kod = glb_DEFCUR then frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row)
  else frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);

  inc(prv_col);
  frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Cikis));
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[],8,'MS Sans Serif',2);
  if prv_kasa_dov_kod = glb_DEFCUR then frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row)
  else frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);

  prv_Giris := 0;
  prv_Cikis := 0;
end;

procedure TfrmRaporKasaAralikliHareket.devir_hesapla;
var
  dvr_borc,dvr_alacak:Currency;
  SubeID : String;
begin
  with qryDEVREDEN do
  begin
    if Active then Active := false;
    SQL.Clear;
    case rdCins.ItemIndex of
      0:SQL.Add('SELECT DEVREDEN_BORC AS BORC,DEVREDEN_ALACAK AS ALACAK FROM KASA WHERE KASA_KOD = '+SQL_Katar(txt_KasaKod.Text));
      1:SQL.Add('SELECT DEVREDEN_BORC_VPB AS BORC,DEVREDEN_ALACAK_VPB AS ALACAK FROM KASA WHERE KASA_KOD = '+SQL_Katar(txt_KasaKod.Text));
    end;
    if glb_SUBELI then
    begin
      SubeID := DataMod.SubeAd2ID(cmbSube.Text);
      if SubeID <> '0' then
      begin
        SQL.Add(' AND KASA.KASA_SID = ' + SubeID);
      end;
    end
    else
    begin
      SQL.Add(' AND KASA.KASA_SID = '+inttostr(glb_SID));
    end;
    Active :=True;
    dvr_borc := FieldByName('BORC').AsCurrency;
    dvr_alacak := FieldByName('ALACAK').AsCurrency;
    Active := False;
  end;

  prv_col := 3;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,'DEVÝR');
  frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_col,[fsBold],8,'MS Sans Serif',0);
  prv_col := 4;
///////////////////////////////////////////////////////////////
///giriþ=borç
  prv_Giris := prv_Giris + dvr_borc;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Giris));
  if prv_kasa_dov_kod = glb_DEFCUR then
  begin
    frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
  end
  else
  begin
    frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
  end;
  prv_col := 5;
///////////////////////////////////////////////////////////////
///çýkýþ=alacak
  prv_Cikis := prv_Cikis + dvr_alacak;
  frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Cikis));
  if prv_kasa_dov_kod = glb_DEFCUR then
  begin
    frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
  end
  else
  begin
    frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
  end;
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
  if (prv_Cikis > prv_Giris) then
  begin
    prv_Cikis := prv_Cikis - prv_Giris;
    prv_Giris := 0;
    prv_col := 6;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Giris));
    if prv_kasa_dov_kod = glb_DEFCUR then
    begin
      frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
    end
    else
    begin
      frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
    end;
    prv_col := 7;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Cikis));
    if prv_kasa_dov_kod = glb_DEFCUR then
    begin
      frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
    end
    else
    begin
      frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
    end;
  end;
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////
  if (prv_Cikis < prv_Giris) then
  begin
    prv_Giris := prv_Giris - prv_Cikis;
    prv_Cikis := 0;
    prv_col := 6;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Giris));
    if prv_kasa_dov_kod = glb_DEFCUR then
    begin
      frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
    end
    else
    begin
      frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
    end;
    prv_col := 7;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Cikis));
    if prv_kasa_dov_kod = glb_DEFCUR then
    begin
      frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
    end
    else
    begin
      frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
    end;
  end;
///////////////////////////////////////////////////////////////
  if (prv_Cikis = prv_Giris) then
  begin
    prv_Cikis := 0;
    prv_Giris := 0;
    prv_col := 6;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Giris));
    if prv_kasa_dov_kod = glb_DEFCUR then
    begin
      frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
    end
    else
    begin
      frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
    end;
    prv_col := 7;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,CurrToStr(prv_Cikis));
    if prv_kasa_dov_kod = glb_DEFCUR then
    begin
      frmRaporCiktisi.format_ayarla(prv_col,prv_row,prv_col,prv_row);
    end
    else
    begin
      frmRaporCiktisi.format_ayarla_dov(prv_col,prv_row,prv_col,prv_row);
    end;
  end;
///////////////////////////////////////////////////////////////
end;

procedure TfrmRaporKasaAralikliHareket.rapor_sirket_ekle;
var
  res_Cari : TStringList;
begin
  prv_row := 0;
  prv_col := 0;
  if chk_Sirket.checked then
  begin
    res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      prv_col := 1;
      frmRaporCiktisi.SetCellText(prv_row,prv_col,res_Cari[1]);
      frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',2);
      inc(prv_col);
      frmRaporCiktisi.SetCellText(prv_row,prv_col,'Rapor Tarihi : '+FormatDateTime('dd.mm.yyyy',date));
      frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);
    end;
    res_Cari.Free;
    prv_row := 1;
  end
  else
  begin
    prv_col := 1;
    frmRaporCiktisi.SetCellText(prv_row,prv_col,'Rapor Tarihi : '+FormatDateTime('dd.mm.yyyy',date));
    frmRaporCiktisi.SetCellFont(prv_col,prv_row,prv_col,prv_row,[fsBold],8,'MS Sans Serif',0);
    prv_row := 1;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.FormKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmRaporKasaAralikliHareket.txt_KasaKodEnter(Sender: TObject);
begin
  txt_KasaKod.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporKasaAralikliHareket.dtp_Tarih_1Enter(Sender: TObject);
begin
  dtp_Tarih_1.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporKasaAralikliHareket.dtp_Tarih_2Enter(Sender: TObject);
begin
  dtp_Tarih_2.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporKasaAralikliHareket.dtp_Tarih_2Exit(Sender: TObject);
begin
  dtp_Tarih_2.Color := clWindow;
end;

procedure TfrmRaporKasaAralikliHareket.dtp_Tarih_1Exit(Sender: TObject);
begin
  dtp_Tarih_1.Color := clWindow;
end;

procedure TfrmRaporKasaAralikliHareket.chk_SirketEnter(Sender: TObject);
begin
  chk_Sirket.Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporKasaAralikliHareket.chk_SirketExit(Sender: TObject);
begin
  chk_Sirket.Color := clBtnFace;
end;

procedure TfrmRaporKasaAralikliHareket.FormCreate(Sender: TObject);
begin
  DataMod.Form_Comp_Color(frmRaporKasaAralikliHareket);
end;

procedure TfrmRaporKasaAralikliHareket.txtISLEMMERKEZIEnter(
  Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporKasaAralikliHareket.txtISLEMMERKEZIExit(
  Sender: TObject);
begin
  if Length(trim(Self.txtISLEMMERKEZI.Text)) = 0 then
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

procedure TfrmRaporKasaAralikliHareket.txtKOD1Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD1.Text)) = 0 then
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

procedure TfrmRaporKasaAralikliHareket.txtKOD2Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD2.Text)) = 0 then
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

procedure TfrmRaporKasaAralikliHareket.txtKOD3Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD3.Text)) = 0 then
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

procedure TfrmRaporKasaAralikliHareket.txtKOD4Exit(Sender: TObject);
begin
  if Length(trim(Self.txtKOD4.Text)) = 0 then
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

procedure TfrmRaporKasaAralikliHareket.Button4Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(0,Muh_Kod,Aciklama) then
  begin
    txtISLEMMERKEZI.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.btnKOD1Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(1,Muh_Kod,Aciklama) then
  begin
    txtKOD1.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.Button6Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(2,Muh_Kod,Aciklama) then
  begin
    txtKOD2.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.Button7Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(3,Muh_Kod,Aciklama) then
  begin
    txtKOD3.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.Button8Click(Sender: TObject);
var
  Muh_Kod,Aciklama:String;
begin
  if DataMod.LS_MUH_KOD(4,Muh_Kod,Aciklama) then
  begin
    txtKOD4.Text := Muh_Kod;
  end;
end;

procedure TfrmRaporKasaAralikliHareket.txtISLEMMERKEZIKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button4Click(Self);
end;

procedure TfrmRaporKasaAralikliHareket.txtKOD1KeyUp(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then btnKOD1Click(Self);
end;

procedure TfrmRaporKasaAralikliHareket.txtKOD2KeyUp(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button6Click(Self);
end;

procedure TfrmRaporKasaAralikliHareket.txtKOD3KeyUp(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button7Click(Self);
end;

procedure TfrmRaporKasaAralikliHareket.txtKOD4KeyUp(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F4 then Button8Click(Self);
end;

procedure TfrmRaporKasaAralikliHareket.frxReport1BeforePrint(
  Sender: TfrxReportComponent);
var
  a,b,c,d,e:TfrxMemoView;//TfrxComponent;
  //a,b,c:TfrxComponent;
  res_Cari : TStringList;
  KASA_AD:String;
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

       d:=(frxReport1.FindComponent('Memo_Kasa') as TfrxMemoView);
       d.memo.Text:=txt_KasaKod.Text;

       d:=(frxReport1.FindComponent('Memo_Kasa_ad') as TfrxMemoView);
       if DataMod.FN_KOD2AD('KASA','KASA_KOD','ACIKLAMA',txt_KasaKod.Text,KASA_AD) then
       d.memo.Text:=KASA_AD;

       c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
       c.memo.Text:=DateToStr(Date);


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtp_Tarih_1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtp_Tarih_2.Date);

        
       Prv_Yazdirildi:=True;
    end;



end;

end.
