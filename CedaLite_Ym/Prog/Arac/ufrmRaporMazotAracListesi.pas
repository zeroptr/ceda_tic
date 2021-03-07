unit ufrmRaporMazotAracListesi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IB_Components, frxClass, frxIBOSet;

type
  TfrmRaporMazotAracListesi = class(TForm)
    GroupBox2: TGroupBox;
    dtpIslemTar1: TDateTimePicker;
    dtpIslemTar2: TDateTimePicker;
    Panel1: TPanel;
    btnRapor: TButton;
    Button3: TButton;
    chk_Sirket: TCheckBox;
    GroupBox1: TGroupBox;
    txtAracKod1: TEdit;
    Button1: TButton;
    txtAracKod2: TEdit;
    Button2: TButton;
    qryMazot: TIB_Query;
    frxIBODts_Mazot_Arac: TfrxIBODataset;
    frxReport1: TfrxReport;
    Btn_Fast: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure txtAracKod1Exit(Sender: TObject);
    procedure txtAracKod2Exit(Sender: TObject);
    procedure btnRaporClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtAracKod1Enter(Sender: TObject);
    procedure dtpIslemTar1Enter(Sender: TObject);
    procedure dtpIslemTar1Exit(Sender: TObject);
    procedure txtAracKod1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAracKod2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAracKod1KeyPress(Sender: TObject; var Key: Char);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
    procedure FormShow(Sender: TObject);
  private
    Prv_Yazdirildi:boolean;

    procedure kod_cikis(kod: TEdit);
    { Private declarations }
  public
    procedure Form_Open();
    { Public declarations }
  end;

  const cns_Mazot = 37;

var
  frmRaporMazotAracListesi: TfrmRaporMazotAracListesi;

implementation

uses unDataMod, main, ufrmRaporCiktisi, UnFunc;

{$R *.dfm}

procedure TfrmRaporMazotAracListesi.Form_Open();
var
  local_CanUpdate,local_CanDelete:Boolean;
begin
  if not DataMod.Modul_Hak(cns_Mazot,local_CanUpdate,local_CanDelete) then
  begin
    Application.MessageBox('Yetkiniz Yok','Dikkat',MB_ICONWARNING);
    exit;
  end
  else
  begin
    if not MainForm.FindChildFrm(Application,'frmRaporMazotAracListesi') then
    begin
      Application.CreateForm(TfrmRaporMazotAracListesi, frmRaporMazotAracListesi);
    end;
  end;
end;



procedure TfrmRaporMazotAracListesi.Button1Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      txtAracKod1.Text := ARAC_KOD;
  end;
end;

procedure TfrmRaporMazotAracListesi.Button2Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 PERSONEL_KOD:String;
 OZ_MAL:Integer;
 DORSE_KOD:String;
begin
  if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') Then
  begin
      txtAracKod2.Text := ARAC_KOD;
  end;
end;

procedure TfrmRaporMazotAracListesi.txtAracKod1Exit(Sender: TObject);
begin
  kod_cikis(txtAracKod1);
end;

procedure TfrmRaporMazotAracListesi.kod_cikis(kod : TEdit);
var
 ARAC_KOD:String;
begin
  if Length(Trim(kod.Text))=0 then
  begin
    kod.Color := clWindow;
    exit;
  end;

  if not DataMod.FN_KOD2AD('ARAC','ARAC_KOD','ARAC_KOD',kod.Text,ARAC_KOD) then
  begin
    Application.MessageBox('araç Kodu Bulunamadý.Lütfen listeden seçiniz.','Dikkat',MB_ICONWARNING);
    kod.Clear;
    kod.SetFocus;
  end
  else
  begin
    kod.Color := clWindow;
  end;
end;

procedure TfrmRaporMazotAracListesi.txtAracKod2Exit(Sender: TObject);
begin
  kod_cikis(txtAracKod2);
end;

procedure TfrmRaporMazotAracListesi.btnRaporClick(Sender: TObject);
var
  row,col : integer;
  res_Cari : TStringList;
  WhereEk:Boolean;
  strSQL,SubeID:String;
begin
  {if lblKASA_KOD.Caption = '' then
  begin
    Application.MessageBox('Önce Kasa Seçmeniz Gerekiyor','Dikkat',MB_ICONSTOP);
    exit;
  end;  }
  //////////////////////////////////////////////////////////////////////////////
  WhereEk := False;
  strSQL :=
  ' SELECT MAZOT_FIS_ID '+#13+
  '     , MAZOT_FIS_SID '+#13+
  '     , ARAC_KOD '+#13+
  '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=MAZOT_FISI.ARAC_KOD) AS ARAC_PLAKA '+#13+
  '     , FIS_NO '+#13+
  '     , TARIH '+#13+
  '     , SAAT '+#13+
  '     , VEREN_PERSONEL_KOD '+#13+
  '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=MAZOT_FISI.VEREN_PERSONEL_KOD) AS VEREN_PERSONEL_ADI '+#13+
  '     , ALAN_PERSONEL_KOD '+#13+
  '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=MAZOT_FISI.ALAN_PERSONEL_KOD) AS ALAN_PERSONEL_ADI '+#13+
  '     , ALAN_CARI_KOD '+#13+
  '     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.ALAN_CARI_KOD=CARI.CARI_KOD) AS ALAN_CARI_ADI '+#13+
  '     , MAZOTCU_CARI_KOD '+#13+
  '     ,(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.MAZOTCU_CARI_KOD=CARI.CARI_KOD) AS MAZOTCU_CARI_ADI '+#13+
  '     , KM '+#13+
  '     , LITRE '+#13+
  '     , LITRE_FIYAT '+#13+
  '     , DOVKOD '+#13+
  '     , DOV_BAZ_TAR '+#13+
  '     , DOVKUR '+#13+
  '     , TUTAR '+#13+
  '     , TUTAR_VPB '+#13+
  '     , ACIKLAMA '+#13+
  '     , MASRAF_MERK '+#13+
  '     , KOD1 '+#13+
  '     , KOD2 '+#13+
  '     , KOD3 '+#13+
  '     , KOD4 '+#13+
  '     , SEFER_ID '+#13+
  '     , ALIS_URUN_HAR_ID '+#13+
  '     , SECIM '+#13+
  '     , ALIS_FATURASI_ALINDI'+#13+
  ' FROM MAZOT_FISI K ';


  strSQL := strSQL +  ' WHERE (MAZOT_FISI.TARIH BETWEEN '+SQL_Tarih(dtpIslemTar1.Date)+' AND '+ SQL_Tarih(dtpIslemTar2.Date)+') ';

  if ((Length(Trim(txtAracKod1.Text)) <> 0) and (Length(Trim(txtAracKod2.Text))<>0)) then
  begin
    strSQL := strSQL + ' and K.ARAC_KOD BETWEEN ' + SQL_Katar(txtAracKod1.Text) + ' AND ' + SQL_Katar(txtAracKod2.Text);
  end
  else
  if Trim(txtAracKod1.Text) <> '' then
  begin
    strSQL := strSQL + ' and K.ARAC_KOD = '+ SQL_Katar(Trim(txtAracKod1.Text));
  end;



  strSQL := strSQL + ' ORDER BY K.ARAC_KOD, K.TARIH, MAZOT_FIS_ID ';

  ////////////////////////////////////////////////////////////////////////////
  try
    with qryMazot do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add(strSQL);
      Active := True;
    end;
  except
    Application.MessageBox('SQL cümleciðinde hata oluþtu.','Dikkat',MB_ICONSTOP);
    ShowMessage(strSQL);
  end;


  if not qryMazot.Active then
  begin
    Application.MessageBox('Arama iþlemi yapmadan rapor alamazsýnýz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;
  if qryMazot.RecordCount = 0 then
  begin
    Application.MessageBox('Yapmýþ olduðunuz aramada hiçbir kayýda ulaþýlamadý.Lütfen kriterleri kontrol ediniz.','Dikkat',MB_ICONINFORMATION);
    exit;
  end;


  if sender=Btn_Fast then
  begin
       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\Arac_Mazot.fr3');

       {   if Cb_Yeni_Sayfa.Checked then
          begin
          a:=(frxReport1.FindComponent('GroupHeader1') as TfrxGroupHeader);
          a.StartNewPage:=True;
          end;
       }

       //frxReport1.PrepareReport();
       frxReport1.showReport;
       Exit;
  end;

  row := 0;
  col := 0;
////////////////////////////////////////////////////////////////////////////////
  with frmRaporCiktisi do
  begin
    form_open();
    grdA.BeginUpdate;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
   if chk_Sirket.Checked then
   begin
   res_Cari := TStringList.Create;
    if DataMod.FN_Sirket (res_Cari) then
    begin
      SetCellText(row,col,res_Cari[1]);
      SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
    end;
    res_Cari.Free;
   end;

    inc(row);
    SetCellText(row,col+1,'ARAÇ MAZOT ALIMI LÝSTESÝ ');
    SetCellFont(col+1,row,col+1,row,[fsBold],8,'MS Sans Serif',2);
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


    SetCellText(row,col,'Araç Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Araç Plaka');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Tarih');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Alan Personel Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Adý Soyadý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Fiþ No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Kilometre');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Litre Fiyatý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Litre');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Tutar');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Mazotçu Cari Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Mazotçu Cari Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    {SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Fark TL');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    }

{
    inc(col);
    SetCellText(row,col,'Sýra No');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Saat');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Veren Personel Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Adý Soyadý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);

    inc(col);
    SetCellText(row,col,'Alan Cari Kod');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Cari Adý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Açýklama');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
    inc(col);
    SetCellText(row,col,'Alýþ Faturasý Alýndý');
    SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',4);
}
    inc(row);
    qryMazot.DisableControls;
    qryMazot.First;
    while not qryMazot.Eof do
    begin
      col := 0;
      {
      SetCellText(row,col,qryMazot.FieldByName('MAZOT_FIS_ID').AsString);
      inc(col);
      }
      DataMod.Rapor_Satir_Renklendir(col,row,11);
      
      SetCellText(row,col,qryMazot.FieldByName('ARAC_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ARAC_PLAKA').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('TARIH').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALAN_PERSONEL_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALAN_PERSONEL_ADI').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('FIS_NO').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('KM').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('LITRE_FIYAT').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('LITRE').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('TUTAR_VPB').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('MAZOTCU_CARI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('MAZOTCU_CARI_ADI').AsString);

     {
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('SAAT').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('VEREN_PERSONEL_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('VEREN_PERSONEL_ADI').AsString);

      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALAN_CARI_KOD').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALAN_CARI_ADI').AsString);

      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ACIKLAMA').AsString);
      inc(col);
      SetCellText(row,col,qryMazot.FieldByName('ALIS_FATURASI_ALINDI').AsString);
      }

      inc(row);
      qryMazot.Next;
    end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    inc(row);
    col := 7;
//    SetCellText(row,col,'=SUM(H4:H'+IntToStr(row-1)+')');
//    SetCellFont(col,row,col,row,[],8,'MS Sans Serif',2);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    SetCellFormat(4,3,4,frmRaporCiktisi.grdA.ActiveSheet.RowCount,1);
    format_ayarla(7,3,7,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
    format_ayarla(9,3,9,frmRaporCiktisi.grdA.ActiveSheet.RowCount);
    frmRaporCiktisi.Rapor_Ayarlari(2);
        
    grdA.EndUpdate;
    WindowState := wsMaximized;
  end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
  qryMazot.First;
  qryMazot.EnableControls;
end;

procedure TfrmRaporMazotAracListesi.Button3Click(Sender: TObject);
begin
     Close;
end;

procedure TfrmRaporMazotAracListesi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRaporMazotAracListesi.txtAracKod1Enter(Sender: TObject);
begin
  (Sender as TEdit).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMazotAracListesi.dtpIslemTar1Enter(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := glb_Art_Alan_Renk;
end;

procedure TfrmRaporMazotAracListesi.dtpIslemTar1Exit(Sender: TObject);
begin
  (Sender as TDateTimePicker).Color := clWindow;
end;

procedure TfrmRaporMazotAracListesi.txtAracKod1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button1Click(Self);
end;

procedure TfrmRaporMazotAracListesi.txtAracKod2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_F4 Then Button2Click(Self);
end;

procedure TfrmRaporMazotAracListesi.txtAracKod1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if not isDigit(Key) Then Key := toUpper(Key);
end;

procedure TfrmRaporMazotAracListesi.frxReport1BeforePrint(
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
       c.memo.Text:=DateToStr(Date);


       d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
       d.memo.Text:=DateToStr(dtpIslemTar1.Date);

       e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
       e.memo.Text:=DateToStr(dtpIslemTar2.Date);
       Prv_Yazdirildi:=True;
    end;
end;

procedure TfrmRaporMazotAracListesi.FormShow(Sender: TObject);
begin
  dtpIslemTar1.Date := glb_DONEM_BAS;
  dtpIslemTar2.Date := DataMod.GET_SERVER_DATE;
end;

end.
