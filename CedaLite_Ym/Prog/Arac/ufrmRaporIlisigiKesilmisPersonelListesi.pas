unit ufrmRaporIlisigiKesilmisPersonelListesi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components,frxClass, frxIBOSet,cxSSTypes,cxSSHeaders;
  
type
  TfrmRaporIlisigiKesilmisPersonelListesi = class(TForm)
    frxIBODts_IKes_Pers: TfrxIBODataset;
    frxReport1: TfrxReport;
    qryRapor: TIB_Query;
    procedure FormCreate(Sender: TObject);
    procedure frxReport1BeforePrint(Sender: TfrxReportComponent);
  private
    Prv_Yazdirildi:Boolean;
    procedure alan_isimlerini_ekle;
    procedure yaz;
    { Private declarations }
  public
  row,col:Integer;
    { Public declarations }
  end;

var
  frmRaporIlisigiKesilmisPersonelListesi: TfrmRaporIlisigiKesilmisPersonelListesi;

implementation


uses unDataMod, ufrmRaporCiktisi, UnFunc;
{$R *.dfm}

procedure TfrmRaporIlisigiKesilmisPersonelListesi.FormCreate( Sender: TObject);
var
  strSQL,SubeID:String;
  where_ek : Boolean;
  CHeader : TcxSSHeader;
begin
  where_ek := false;

  strSQL :=
  'SELECT PERSONEL_KOD '+
  '     , ADI_SOYADI '+
  '     , SICIL_NO '+
  '     , SSK_NO '+
  '     , GIRIS_TARIH '+
  '     , CIKIC_TARIH '+
  '     , DOGUM_TARIH '+
  '     , DOGUM_YER '+
  '     , CINSIYET '+
  '     , TAHSIL '+
  '     , EVLI '+
  '     , GOREVI '+
  '     , VERGI_NO '+
  '     , VERGI_DAIRE '+
  '     , VERGI_KARNE_TARIH '+
  '     , TEL_NO '+
  '     , LISTEDEN_CIKAR '+
  '     , BORC '+
  '     , ALACAK '+
  ' FROM PERSONEL '+
  ' WHERE CIKIC_TARIH<= '+Sql_Tarih( DataMod.GET_SERVER_DATE);

  with frmRaporIlisigiKesilmisPersonelListesi.qryRapor do
  begin
    Active := false;
    SQL.Clear;
    SQL.Add(strSQL);
    Active := True;
  end;

  if ((frmRaporIlisigiKesilmisPersonelListesi.qryRapor.Eof) and (frmRaporIlisigiKesilmisPersonelListesi.qryRapor.Bof))then
  begin
    Application.MessageBox('Verdiðiniz kýsýtlara uygun bir rapor alýnamadý.Lütfen kontrol edip tekrar deneyiniz.','Dikkat',MB_ICONWARNING);
    qryRapor.Close;
    Exit;
  end
  else
  begin


    if Application.MessageBox('Excel Rapor ? ','Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDNO then
    begin
       Prv_Yazdirildi:=False;
       frxReport1.LoadFromFile(glb_REPORTS_DIR+'\IKes_Pers.fr3');
       frxReport1.showReport;
       Exit;
    end;


    frmRaporCiktisi.form_open();
    frmRaporCiktisi.grdA.BeginUpdate;
    yaz;
    {if chk_Sirket.Checked then
    begin
      frmRaporCiktisi.SetCellFont(0,2,14,2,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(5,2,6,2,haRight,vaCenter);
    end
    else
    begin
      frmRaporCiktisi.SetCellFont(0,1,14,1,[fsBold],8,'MS Sans Serif',4);
      frmRaporCiktisi.SetCellAlignment(5,1,6,1,haRight,vaCenter);
    end;
    }
    CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
    CHeader.Size[1] := 150;

    frmRaporCiktisi.grdA.EndUpdate;
    frmRaporCiktisi.WindowState := wsMaximized;
    qryRapor.Close;
  end;
end;




procedure TfrmRaporIlisigiKesilmisPersonelListesi.yaz;
var
  res_Cari : TStringList;
  Deger:String;
begin
  row := 0;
  col := 0;
  {if chk_Sirket.checked then
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
  }
  frmRaporCiktisi.SetCellText(row,col,'ÝLÝÞÝÐÝ KESÝLMÝÞ PERSONEL LÝSTESÝ');
  frmRaporCiktisi.SetCellFont(col,row,col,row,[fsBold],8,'MS Sans Serif',2);
  frmRaporCiktisi.SetCellText(row,col+3,'Rapor Tarihi : ' + DateToStr(DataMod.GET_SERVER_DATE));
  frmRaporCiktisi.SetCellFont(col+3,row,col+3,row,[fsBold],8,'MS Sans Serif',0);

  frmRaporCiktisi.SetCellFont(0,1,4,1,[fsBold],8,'MS Sans Serif',4);
  alan_isimlerini_ekle;
  qryRapor.First;
  while not qryRapor.Eof do
  begin

    col := 0;

    DataMod.Rapor_Satir_Renklendir(col,row,4);

    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SICIL_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('ADI_SOYADI').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('SSK_NO').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('GIRIS_TARIH').AsString);
    inc(col);
    frmRaporCiktisi.SetCellText(row,col,qryRapor.FieldByName('CIKIC_TARIH').AsString);

    inc(row);
    qryRapor.Next;
  end;
end;


procedure TfrmRaporIlisigiKesilmisPersonelListesi.alan_isimlerini_ekle;
begin
  inc(row);
  frmRaporCiktisi.SetCellText(row,col,'Sicil No');
  frmRaporCiktisi.SetCellText(row,col+1,'Adý Soyadý');
  frmRaporCiktisi.SetCellText(row,col+2,'SSK No');
  frmRaporCiktisi.SetCellText(row,col+3,'Giriþ Tarihi');
  frmRaporCiktisi.SetCellText(row,col+4,'Çýkýþ Tarihi');
  inc(row);
end;


procedure TfrmRaporIlisigiKesilmisPersonelListesi.frxReport1BeforePrint(
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

         c:=(frxReport1.FindComponent('Memo_Bit_Tar') as TfrxMemoView);
         c.memo.Text:=DateToStr(Date);

        {d:=(frxReport1.FindComponent('Memo_BaTar') as TfrxMemoView);
         d.memo.Text:=DateToStr(dtpIslemTar1.Date);

         e:=(frxReport1.FindComponent('Memo_BiTar') as TfrxMemoView);
         e.memo.Text:=DateToStr(dtpIslemTar2.Date);}

         Prv_Yazdirildi:=True;
    end;
end;

end.
