unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IB_Components, Grids, IB_Grid, StdCtrls,math, DBGrids, DB,
  DBTables, ExcelXP, OleServer;

type
  TForm1 = class(TForm)
    dbaMain: TIB_Connection;
    trn_Uretim: TIB_Transaction;
    Button1: TButton;
    IB_Query1: TIB_Query;
    IB_Query2: TIB_Query;
    IB_Grid1: TIB_Grid;
    IB_DataSource1: TIB_DataSource;
    Button2: TButton;
    Button3: TButton;
    qrydeg1: TIB_Query;
    DataSource1: TDataSource;
    Query1: TQuery;
    DBGrid1: TDBGrid;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Query2: TQuery;
    Button7: TButton;
    Ea1: TExcelApplication;
    Qry_Grup: TIB_Query;
    Qry_Grup_Uye: TIB_Query;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
  public
     procedure CreateQuery(Var Query:TIB_Query;Transaction:TIB_Transaction;RequestLive:Boolean;Connection:TIB_Connection);
     procedure ReleaseQuery(var Query:TIB_Query);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses comobj;

{$R *.dfm}

procedure TForm1.CreateQuery(Var Query:TIB_Query;Transaction:TIB_Transaction;RequestLive:Boolean;Connection:TIB_Connection);
begin
  Query := TIB_Query.Create(Self);
  Query.IB_Connection := Connection;
  if Transaction <> Nil then Query.IB_Transaction := Transaction;
  Query.RequestLive := RequestLive;
  Query.ReadOnly := Not RequestLive;
//  Query.CachedUpdates:=true;
end;

Procedure TForm1.ReleaseQuery(var Query:TIB_Query);
begin
  try
    if Assigned(Query) then
    begin
      if Query.Active then Query.Close;
      Query.Free;
    end;
  except
  end;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
dbaMain.Connect;
trn_Uretim.StartTransaction;
IB_Query1.Insert;
IB_Query1.FieldByName('SAYAC_ADI').AsString:='sssss';
IB_Query1.FieldByName('SUBE_ID').AsInteger:=0;
IB_Query1.FieldByName('DEGER').AsInteger:=999;
IB_Query1.Post;
IB_Query1.ApplyUpdates;
{IB_Query1.Insert;
IB_Query1.FieldByName('SAYAC_ADI').AsString:='sssss';
IB_Query1.FieldByName('SUBE_ID').AsInteger:=0;
IB_Query1.FieldByName('DEGER').AsInteger:=999;
IB_Query1.Post;
IB_Query1.ApplyUpdates;}
//trn_Uretim.CommitRetaining;
IB_Query2.Close;
IB_Query2.open;
ShowMessage('ww');
trn_Uretim.Rollback;
dbaMain.Disconnect;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ShowMessage(Inttostr(ceil(1.7)));
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  qryDeg:TIb_Query;
begin
dbaMain.Connect;
  CreateQuery(qryDeg,trn_Uretim,True,dbaMain);
     qryDeg.Active:=False;
     qryDeg.sql.Clear;
     qryDeg.sql.Text:='Select * from Sayaclar';
//     qryDeg.ParamByName('SATIS_URUN_HAR_ID').AsInteger:=Gelen_Id;
     qryDeg.Active:=True;

qryDeg.Insert;
qryDeg.FieldByName('SAYAC_ADI').AsString:='sssss';
qryDeg.FieldByName('SUBE_ID').AsInteger:=0;
qryDeg.FieldByName('DEGER').AsInteger:=999;
qryDeg.Post;


//ReleaseQuery(qryDeg);




     CreateQuery(qryDeg,trn_Uretim,True,dbaMain);
     qryDeg.Active:=False;
     qryDeg.sql.Clear;
     qryDeg.sql.Text:='Select * from Sayaclar';
     qryDeg.Active:=True;

{    if trn_Uretim.InTransaction then
       trn_Uretim.Rollback;}
trn_Uretim.RollbackRetaining;
//    trn_Uretim.StartTransaction;
    //ilk basta açýlmasa bile baglý iþlemi iþleyip geri sarabiliyor



qryDeg.Insert;
qryDeg.FieldByName('SAYAC_ADI').AsString:='sssss1';
qryDeg.FieldByName('SUBE_ID').AsInteger:=0;
qryDeg.FieldByName('DEGER').AsInteger:=999;
qryDeg.Post;
//ReleaseQuery(qryDeg);

{
qryDeg.Insert;
qryDeg.FieldByName('SAYAC_ADI').AsString:='sssss';
qryDeg.FieldByName('SUBE_ID').AsInteger:=0;
qryDeg.FieldByName('DEGER').AsInteger:=999;
qryDeg.Post;
}
if trn_Uretim.InTransaction then
ShowMessage('ww');
//start tran denilmezsede tarn baglý oluyor ama in tran göstermiyor

//cacheupdate acýk qryde son iþlenen de iþlem yapýlyuor onceki devreye alýnmýyor
//cacheupdate acýk qryde relase yapýlmada hata veriyor

//trn_Uretim.Rollback;
//qryDeg.ApplyUpdates;
//trn_Uretim.Rollback;
//trn_Uretim.RollbackRetaining;
trn_Uretim.Commit;

dbaMain.Disconnect;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
   a:Integer;
begin

dbaMain.Connect;
IB_Query1.Active:=False;
IB_Query1.SQL.Text:=' delete from cari';
IB_Query1.Execute;

IB_Query1.Active:=False;
IB_Query1.SQL.Text:=
'INSERT INTO CARI (CARI_KOD, CARI_SID, CARI_AD, YETKISI, VERDAIRE, VERNO, ADRES_1, ADRES_2, ILCE, SEHIR, POSTA_KOD, TIP, TEL_NO_1, TEL_NO_2, FAX, E_MAIL, WEB_ADDR, '+
' KREDILMT, RISK, BORC, ALACAK, ULKE, YURTDISI, ISLEMTIP, MUHTELIF, DEVREDEN_BORC, DEVREDEN_ALACAK, DOVIZLI, DOVKOD) '+
'VALUES (:CARI_KOD, :CARI_SID, :CARI_AD, :YETKISI, :VERDAIRE, :VERNO, :ADRES_1, :ADRES_2, :ILCE, :SEHIR, :POSTA_KOD, :TIP, '+
' :TEL_NO_1, :TEL_NO_2, :FAX, :E_MAIL, :WEB_ADDR, :KREDILMT, :RISK, :BORC, :ALACAK, :ULKE, :YURTDISI, :ISLEMTIP, :MUHTELIF, :DEVREDEN_BORC, :DEVREDEN_ALACAK, :DOVIZLI, :DOVKOD);';
   Query1.Close;
   Query1.SQL.Clear;
   Query1.SQL.Text:=' Select * from CariKart';
   Query1.Open;
   While not Query1.eof Do
   begin
        for a:=0 to IB_Query1.ParamCount-1 do
        begin
        IB_Query1.Params[a].AsVariant:=Null;
        end;
        IB_Query1.ParamByName('CARI_KOD').AsString:=Query1.FieldByName('CariKodu').AsString;
        IB_Query1.ParamByName('CARI_SID').AsInteger:=1;
        IB_Query1.ParamByName('CARI_AD').AsString:=Query1.FieldByName('CariAdi').AsString;
        IB_Query1.ParamByName('YETKISI').AsString:=Query1.FieldByName('YetKisi').AsString;
        IB_Query1.ParamByName('VERDAIRE').AsString:=Query1.FieldByName('VergiDaire').AsString;
        IB_Query1.ParamByName('VERNO').AsString:=Query1.FieldByName('VergiNo').AsString;
        IB_Query1.ParamByName('ADRES_1').AsString:=Query1.FieldByName('Adres').AsString;
        IB_Query1.ParamByName('ILCE').AsString:=Query1.FieldByName('Ilce').AsString;
        IB_Query1.ParamByName('SEHIR').AsString:=Query1.FieldByName('Sehir').AsString;
        IB_Query1.ParamByName('ADRES_2').AsString:=Query1.FieldByName('Aciklama').AsString;

        if Query1.FieldByName('Alici').AsBoolean then
        IB_Query1.ParamByName('TIP').AsInteger:=0;

        IB_Query1.ParamByName('TIP').AsInteger:=2;
        if Query1.FieldByName('mAZOTCU').AsBoolean then
        IB_Query1.ParamByName('TIP').AsInteger:=5;

        IB_Query1.ParamByName('TEL_NO_1').AsString:=Query1.FieldByName('TelNo').AsString;
        IB_Query1.ParamByName('FAX').AsString:=Query1.FieldByName('FaxNo').AsString;

        {IB_Query1.ParamByName('POSTA_KOD').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('ADRES_2').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('TEL_NO_2').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('E_MAIL').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('WEB_ADDR').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('KREDILMT').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('RISK').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('BORC').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('ALACAK').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('ULKE').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('YURTDISI').AsString:=Query1.FieldByName('').AsString;
        }
        IB_Query1.ParamByName('ISLEMTIP').AsInteger:=0;
        IB_Query1.ParamByName('MUHTELIF').AsInteger:=0;

        IB_Query1.ParamByName('DEVREDEN_BORC').AsFloat:=Query1.FieldByName('Borc').AsFloat;
        IB_Query1.ParamByName('DEVREDEN_ALACAK').AsFloat:=Query1.FieldByName('Alacak').AsFloat;
        {
        IB_Query1.ParamByName('DEVREDEN_BORC').AsFloat:=0;
        IB_Query1.ParamByName('DEVREDEN_ALACAK').AsFloat:=0;
        }
        IB_Query1.ParamByName('DOVIZLI').AsInteger:=0;
        IB_Query1.ParamByName('DOVKOD').AsString:='YTL';

        try
        IB_Query1.Execute;
        except
        end;

        Query1.Next;
   end;
   Query1.Close;
   //IB_Query1.ApplyUpdates;
   //IB_Query1.CommitUpdates;
   trn_Uretim.CommitRetaining;
dbaMain.Disconnect;
  ShowMessage('Bitti');
end;

procedure TForm1.Button5Click(Sender: TObject);
var
   a:Integer;
begin

dbaMain.Connect;
IB_Query1.Active:=False;
IB_Query1.SQL.Text:=' delete from ARAC';
IB_Query1.Execute;

IB_Query1.Active:=False;
IB_Query1.SQL.Text:=
'INSERT INTO ARAC (ARAC_KOD, ARAC_SID, PLAKA, ARAC_TIP, OZ_MAL, CARI_KOD, ACIKLAMA, BORC, ALACAK, AKTIF_DEGIL, YAKIT_LITRE, TRF_SIG_GEC_TAR, KASKO_SIG_GEC_TAR, PERSONEL_KOD, DORSE_KOD, AS_ADISOYADI, '+
'AS_DOGUM_YERI, AS_NUFUS_IL, AS_NUFUS_ILCE, AS_DOGUM_TARIHI, AS_IKA_ADRES, AS_SERI_NO, AS_MUYANE_GECERLILIK_SUR,DEVREDEN_BORC,DEVREDEN_ALACAK) '+
'VALUES (:ARAC_KOD, :ARAC_SID, :PLAKA, :ARAC_TIP, :OZ_MAL, :CARI_KOD, :ACIKLAMA, :BORC, :ALACAK, :AKTIF_DEGIL, :YAKIT_LITRE, :TRF_SIG_GEC_TAR, :KASKO_SIG_GEC_TAR, :PERSONEL_KOD, :DORSE_KOD, :AS_ADISOYADI, '+
':AS_DOGUM_YERI, :AS_NUFUS_IL, :AS_NUFUS_ILCE, :AS_DOGUM_TARIHI, :AS_IKA_ADRES, :AS_SERI_NO, :AS_MUYANE_GECERLILIK_SUR,:DEVREDEN_BORC,:DEVREDEN_ALACAK);';
   Query1.Close;
   Query1.SQL.Clear;
   Query1.SQL.Text:=' Select * from AracKart';
   Query1.Open;
   While not Query1.eof Do
   begin
        for a:=0 to IB_Query1.ParamCount-1 do
        begin
        IB_Query1.Params[a].AsVariant:=Null;
        end;
        IB_Query1.ParamByName('ARAC_KOD').AsString:=Query1.FieldByName('AracId').AsString;
        IB_Query1.ParamByName('ARAC_SID').AsInteger:=1;
        IB_Query1.ParamByName('PLAKA').AsString:=Query1.FieldByName('Plaka').AsString;

        if Query1.FieldByName('OzMal').AsBoolean then
        IB_Query1.ParamByName('OZ_MAL').AsInteger:=1
        else
        IB_Query1.ParamByName('OZ_MAL').AsInteger:=0;



        if Query1.FieldByName('CariID').AsInteger>0 then
        begin
          Query2.Active:=False;
          Query2.Sql.Text:='Select CariKodu from CariKart where CariID=:CariID';
          Query2.ParamByName('CariID').AsInteger:=Query1.FieldByName('CariID').AsInteger;
          Query2.Active:=True;


          if Trim(Query2.FieldByName('CariKodu').AsString)<>'' then
          begin

             IB_Query2.Active:=False;
             IB_Query2.Sql.Text:='Select CARI_KOD from CARI where CARI_KOD=:CARI_KOD';
             IB_Query2.ParamByName('CARI_KOD').AsString:=Query2.FieldByName('CariKodu').AsString;
             IB_Query2.Active:=True;

             if Trim(IB_Query2.FieldByName('CARI_KOD').AsString)<>'' then
             IB_Query1.ParamByName('CARI_KOD').AsString:=IB_Query2.FieldByName('CARI_KOD').AsString;

          end;
        end;
        











        if Query1.FieldByName('PersonelID').AsInteger>0 then
        begin
          Query2.Active:=False;
          Query2.Sql.Text:='Select SicilNo from PersKart where PersonelID=:PersonelID';
          Query2.ParamByName('PersonelID').AsInteger:=Query1.FieldByName('PersonelID').AsInteger;
          Query2.Active:=True;


          if Trim(Query2.FieldByName('SicilNo').AsString)<>'' then
          begin

             IB_Query2.Active:=False;
             IB_Query2.Sql.Text:='Select PERSONEL_KOD from PERSONEL where PERSONEL_KOD=:PERSONEL_KOD';
             IB_Query2.ParamByName('PERSONEL_KOD').AsString:=Query2.FieldByName('SicilNo').AsString;
             IB_Query2.Active:=True;

             if Trim(IB_Query2.FieldByName('PERSONEL_KOD').AsString)<>'' then
             IB_Query1.ParamByName('PERSONEL_KOD').AsString:=IB_Query2.FieldByName('PERSONEL_KOD').AsString;

          end;
        end;





        IB_Query1.ParamByName('ARAC_TIP').AsInteger:=Query1.FieldByName('AracTip').AsInteger;

        if Query1.FieldByName('AracTip').AsInteger=2 then
        IB_Query1.ParamByName('ARAC_TIP').AsInteger:=4;


        IB_Query1.ParamByName('ACIKLAMA').AsString:=Query1.FieldByName('Aciklama').AsString;


        IB_Query1.ParamByName('YAKIT_LITRE').Asfloat:=Query1.FieldByName('LitKm').Asfloat;

        if Query1.FieldByName('ListeCikar').AsBoolean=true then
        IB_Query1.ParamByName('AKTIF_DEGIL').AsInteger:=1
        else
        IB_Query1.ParamByName('AKTIF_DEGIL').AsInteger:=0;

        IB_Query1.ParamByName('DEVREDEN_BORC').AsFloat:=Query1.FieldByName('Borc').AsFloat;
        IB_Query1.ParamByName('DEVREDEN_ALACAK').AsFloat:=Query1.FieldByName('Alacak').AsFloat;

        IB_Query1.ParamByName('AS_ADISOYADI').AsString:=Query1.FieldByName('RuhBil01').AsString;


        try
        IB_Query1.Execute;
        except
        end;

        Query1.Next;
   end;
   Query1.Close;
   //IB_Query1.ApplyUpdates;
   //IB_Query1.CommitUpdates;
   trn_Uretim.CommitRetaining;
dbaMain.Disconnect;

  ShowMessage('Bitti');




end;

procedure TForm1.Button6Click(Sender: TObject);
var
   a:Integer;
begin

dbaMain.Connect;
IB_Query1.Active:=False;
IB_Query1.SQL.Text:=' delete from PERSONEL';
IB_Query1.Execute;

IB_Query1.Active:=False;
IB_Query1.SQL.Text:=
'INSERT INTO PERSONEL (PERSONEL_KOD, PERSONEL_SID, ADI_SOYADI, SICIL_NO, SSK_NO, GIRIS_TARIH, CIKIC_TARIH, DOGUM_TARIH, DOGUM_YER, CINSIYET, TAHSIL, EVLI, '+
'GOREVI, VERGI_NO, VERGI_DAIRE, VERGI_KARNE_TARIH, TEL_NO, LISTEDEN_CIKAR, BORC, ALACAK,DEVREDEN_BORC,DEVREDEN_ALACAK) '+
'VALUES (:PERSONEL_KOD, :PERSONEL_SID, :ADI_SOYADI, :SICIL_NO, :SSK_NO, :GIRIS_TARIH, :CIKIC_TARIH, :DOGUM_TARIH, :DOGUM_YER, :CINSIYET, :TAHSIL, :EVLI, '+
':GOREVI, :VERGI_NO, :VERGI_DAIRE, :VERGI_KARNE_TARIH, :TEL_NO, :LISTEDEN_CIKAR, :BORC, :ALACAK,:DEVREDEN_BORC,:DEVREDEN_ALACAK); ';
   Query1.Close;
   Query1.SQL.Clear;
   Query1.SQL.Text:=' Select * from PersKart';
   Query1.Open;
   While not Query1.eof Do
   begin
        for a:=0 to IB_Query1.ParamCount-1 do
        begin
        IB_Query1.Params[a].AsVariant:=Null;
        end;
        IB_Query1.ParamByName('PERSONEL_KOD').AsString:=Query1.FieldByName('SicilNo').AsString;
        IB_Query1.ParamByName('PERSONEL_SID').AsInteger:=1;
        IB_Query1.ParamByName('ADI_SOYADI').AsString:=Query1.FieldByName('AdiSoyadi').AsString;
        IB_Query1.ParamByName('SSK_NO').AsString:=Query1.FieldByName('SSKNo').AsString;
        IB_Query1.ParamByName('GIRIS_TARIH').AsString:=Query1.FieldByName('GirisTar').AsString;
        IB_Query1.ParamByName('CIKIC_TARIH').AsString:=Query1.FieldByName('CikisTar').AsString;
        IB_Query1.ParamByName('DOGUM_TARIH').AsString:=Query1.FieldByName('DogTar').AsString;
        IB_Query1.ParamByName('DOGUM_YER').AsString:=Query1.FieldByName('DogYer').AsString;

        if Query1.FieldByName('Cinsiyet').AsBoolean then
        IB_Query1.ParamByName('CINSIYET').AsString:='E'
        else
        IB_Query1.ParamByName('CINSIYET').AsString:='K';

        IB_Query1.ParamByName('TAHSIL').AsInteger:=Query1.FieldByName('Tahsil').AsInteger+1;
        
        if Query1.FieldByName('Evli').AsInteger=1 then
        IB_Query1.ParamByName('EVLI').AsString:='E';
        if Query1.FieldByName('Evli').AsInteger=0 then
        IB_Query1.ParamByName('EVLI').AsString:='B';
        if Query1.FieldByName('Evli').AsInteger=2 then
        IB_Query1.ParamByName('EVLI').AsString:='D';



        IB_Query1.ParamByName('GOREVI').AsString:=Query1.FieldByName('Gorev').AsString;

        IB_Query1.ParamByName('GOREVI').AsString:=Query1.FieldByName('Gorev').AsString;
        IB_Query1.ParamByName('VERGI_DAIRE').AsString:=Query1.FieldByName('VerDairesi').AsString;
        IB_Query1.ParamByName('VERGI_KARNE_TARIH').AsString:=Query1.FieldByName('VerKarTar').AsString;


        if Query1.FieldByName('ListeCikar').AsBoolean then
        IB_Query1.ParamByName('LISTEDEN_CIKAR').AsInteger:=1
        else
        IB_Query1.ParamByName('LISTEDEN_CIKAR').AsInteger:=0;



        IB_Query1.ParamByName('TEL_NO').AsString:=Query1.FieldByName('TelefonNo').AsString;


        IB_Query1.ParamByName('DEVREDEN_BORC').AsFloat:=Query1.FieldByName('Borc').AsFloat;
        IB_Query1.ParamByName('DEVREDEN_ALACAK').AsFloat:=Query1.FieldByName('Alacak').AsFloat;


        try
        IB_Query1.Execute;
        except
        end;

        Query1.Next;
   end;
   Query1.Close;
   //IB_Query1.ApplyUpdates;
   //IB_Query1.CommitUpdates;
   trn_Uretim.CommitRetaining;
dbaMain.Disconnect;

  ShowMessage('Bitti');

end;

procedure TForm1.Button7Click(Sender: TObject);
var
  ea: OleVariant;
  a,a1:Integer;
begin

dbaMain.Connect;
  //   Ea.Workbooks.Open('Musteriler.xls');
  ea := CreateOleObject('Excel.Application');
  ea.DisplayAlerts := False;
  Ea.Workbooks.Open('C:\CedaLite\Aktar\Mus.xls');


//Ea.Cells[1,1].value;
//    ShowMessage(Ea.Cells[2,1].value);
//    Ea.Worksheets.Application.Cells[1,1]


IB_Query1.Active:=False;
IB_Query1.SQL.Text:='delete from CARI_GRUP_UYE;';
IB_Query1.Execute;

IB_Query1.Active:=False;
IB_Query1.SQL.Text:='delete from CARI_GRUP;';
IB_Query1.Execute;


Qry_Grup_Uye.Active:=False;
Qry_Grup_Uye.Active:=True;


Qry_Grup.Active:=False;
Qry_Grup.Active:=True;



for a:=2 to 908 do
begin
     if Trim(Ea.Cells[a,1].value)<>'' then
     if not Qry_Grup.Locate('CARI_GRUP_KOD',Trim(Ea.Cells[a,1].value),[]) then
     begin
         Qry_Grup.Append;
         Qry_Grup.FieldByName('CARI_GRUP_KOD').AsString:=UpperCase(LowerCase(Ea.Cells[a,1].value));
         Qry_Grup.FieldByName('CARI_GRUP_SID').AsInteger:=1;
         Qry_Grup.FieldByName('CGADI').AsString:=Ea.Cells[a,1].value;
         Qry_Grup.FieldByName('TIP').AsInteger:=0;
         Qry_Grup.Post;
     end;
end;

   trn_Uretim.CommitRetaining;






IB_Query1.Active:=False;
IB_Query1.SQL.Text:=' delete from cari';
IB_Query1.Execute;

IB_Query1.Active:=False;
IB_Query1.SQL.Text:=
'INSERT INTO CARI (CARI_KOD, CARI_SID, CARI_AD, YETKISI, VERDAIRE, VERNO, ADRES_1, ADRES_2, ILCE, SEHIR, POSTA_KOD, TIP, TEL_NO_1, TEL_NO_2, FAX, E_MAIL, WEB_ADDR, '+
' KREDILMT, RISK, BORC, ALACAK, ULKE, YURTDISI, ISLEMTIP, MUHTELIF, DEVREDEN_BORC, DEVREDEN_ALACAK, DOVIZLI, DOVKOD) '+
'VALUES (:CARI_KOD, :CARI_SID, :CARI_AD, :YETKISI, :VERDAIRE, :VERNO, :ADRES_1, :ADRES_2, :ILCE, :SEHIR, :POSTA_KOD, :TIP, '+
' :TEL_NO_1, :TEL_NO_2, :FAX, :E_MAIL, :WEB_ADDR, :KREDILMT, :RISK, :BORC, :ALACAK, :ULKE, :YURTDISI, :ISLEMTIP, :MUHTELIF, :DEVREDEN_BORC, :DEVREDEN_ALACAK, :DOVIZLI, :DOVKOD);';

//IB_Query1.FieldByName('VERNO').EditMask:='### ### ####';
//IB_Query1.FieldByName('TEL_NO_1').EditMask:='0(###)#######';
//IB_Query1.FieldByName('TEL_NO_2').EditMask:='0(###)#######';

for a1:=2 to 908 do
begin
        for a:=0 to IB_Query1.ParamCount-1 do
        begin
        IB_Query1.Params[a].AsVariant:=Null;
        end;



        IB_Query1.ParamByName('CARI_KOD').AsString:=Trim(Ea.Cells[a1,2].value);
        IB_Query1.ParamByName('CARI_SID').AsInteger:=1;
        IB_Query1.ParamByName('CARI_AD').AsString:=Trim(Ea.Cells[a1,3].value)+' ' +Trim(Ea.Cells[a1,4].value);
        IB_Query1.ParamByName('VERDAIRE').AsString:=Trim(Ea.Cells[a1,5].value);

//        IB_Query1.ParamByName('VERNO').AsString:=Trim(Ea.Cells[a1,6].value);

        IB_Query1.ParamByName('VERNO').AsString:=

        Copy(Trim(Ea.Cells[a1,6].value),1,3)+' '+
        Copy(Trim(Ea.Cells[a1,6].value),4,3)+' '+
        Copy(Trim(Ea.Cells[a1,6].value),7,4);



        IB_Query1.ParamByName('E_MAIL').AsString:=Trim(Ea.Cells[a1,7].value);

        IB_Query1.ParamByName('YETKISI').AsString:=Trim(Ea.Cells[a1,15].value)+ ' '+Trim(Ea.Cells[a1,16].value)+' ' +Trim(Ea.Cells[a1,17].value)+' '+ Trim(Ea.Cells[a1,18].value);

        IB_Query1.ParamByName('ADRES_1').AsString:=Trim(Ea.Cells[a1,35].value);
        IB_Query1.ParamByName('ADRES_2').AsString:=Trim(Ea.Cells[a1,36].value)+ ' '+Trim(Ea.Cells[a1,37].value);

        IB_Query1.ParamByName('ILCE').AsString:=Trim(Ea.Cells[a1,38].value);
        IB_Query1.ParamByName('SEHIR').AsString:=Trim(Ea.Cells[a1,40].value);
        IB_Query1.ParamByName('POSTA_KOD').AsString:=Trim(Ea.Cells[a1,39].value);
        IB_Query1.ParamByName('WEB_ADDR').AsString:=Trim(Ea.Cells[a1,11].value);

        IB_Query1.ParamByName('TIP').AsInteger:=0;

        {if Query1.FieldByName('Alici').AsBoolean then
        IB_Query1.ParamByName('TIP').AsInteger:=0;

        IB_Query1.ParamByName('TIP').AsInteger:=2;
        if Query1.FieldByName('mAZOTCU').AsBoolean then
        IB_Query1.ParamByName('TIP').AsInteger:=5;
       }

if Length(Trim(Ea.Cells[a1,41].value))=10 then
IB_Query1.ParamByName('TEL_NO_1').AsString:='0('+Copy(Trim(Ea.Cells[a1,41].value),1,3)+')'+Copy(Trim(Ea.Cells[a1,41].value),4,7);

if Length(Trim(Ea.Cells[a1,41].value))=7 then
IB_Query1.ParamByName('TEL_NO_1').AsString:='0(232)'+Trim(Ea.Cells[a1,41].value);

//        IB_Query1.ParamByName('TEL_NO_1').AsString:=Trim(Ea.Cells[a1,41].value);
        //IB_Query1.ParamByName('FAX').AsString:=Query1.FieldByName('FaxNo').AsString;

        {IB_Query1.ParamByName('POSTA_KOD').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('ADRES_2').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('TEL_NO_2').AsString:=Query1.FieldByName('').AsString;


        IB_Query1.ParamByName('KREDILMT').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('RISK').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('BORC').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('ALACAK').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('ULKE').AsString:=Query1.FieldByName('').AsString;
        IB_Query1.ParamByName('YURTDISI').AsString:=Query1.FieldByName('').AsString;
        }
        IB_Query1.ParamByName('ISLEMTIP').AsInteger:=0;
        IB_Query1.ParamByName('MUHTELIF').AsInteger:=0;

        IB_Query1.ParamByName('DEVREDEN_BORC').AsFloat:=0;
        IB_Query1.ParamByName('DEVREDEN_ALACAK').AsFloat:=0;
        {
        IB_Query1.ParamByName('DEVREDEN_BORC').AsFloat:=0;
        IB_Query1.ParamByName('DEVREDEN_ALACAK').AsFloat:=0;
        }
        IB_Query1.ParamByName('DOVIZLI').AsInteger:=0;
        IB_Query1.ParamByName('DOVKOD').AsString:='YTL';

        try
        IB_Query1.Execute;
        except
        end;


end;

   //IB_Query1.ApplyUpdates;
   //IB_Query1.CommitUpdates;
   trn_Uretim.CommitRetaining;




for a1:=2 to 908 do
begin

if (Trim(Ea.Cells[a1,1].value)<>'') and (Trim(Ea.Cells[a1,2].value)<>'') then
begin
     if not Qry_Grup_Uye.Locate('CARI_GRUP_KOD;CARI_KOD',vararrayof([UpperCase(LowerCase(Trim(Ea.Cells[a1,1].value))),Trim(Ea.Cells[a1,2].value)]),[]) then
     begin
     Qry_Grup_Uye.Append;
     Qry_Grup_Uye.FieldByName('CARI_GRUP_KOD').AsString:=UpperCase(LowerCase(Trim(Ea.Cells[a1,1].value)));
     Qry_Grup_Uye.FieldByName('CARI_KOD').AsString:=Trim(Ea.Cells[a1,2].value);
     Qry_Grup_Uye.FieldByName('VARSAY').AsInteger:=1;
     Qry_Grup_Uye.Post;
     end;
end;

end;

   trn_Uretim.CommitRetaining;

dbaMain.Disconnect;
  ShowMessage('Bitti');




end;

end.











