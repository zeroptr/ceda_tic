unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,IniFiles, ShellAPI, ShlObj,ExtCtrls, StdCtrls, NetOpenX_Tlb,
  IB_Components,Ib_Session, Grids, IB_Grid, UnFunc;

type
  TFrmMain = class(TForm)
    Query_Dosya: TIB_Query;
    IB_Conn: TIB_Connection;
    Dts_Query_Dosya: TIB_DataSource;
    IB_Conn_Data: TIB_Connection;
    qryFAT_IRS: TIB_Query;
    Qry_Asl_Urun_Har: TIB_Query;
    dtsFAT_IRS: TIB_DataSource;
    qryFAT_IRS_MUH_CARI: TIB_Query;
    dtsFAT_IRS_MUH_CARI: TIB_DataSource;
    qryFAT_IRS_ACK: TIB_Query;
    dtsFAT_IRS_ACK: TIB_DataSource;
    qry_Aktarilanlar: TIB_Query;
    IB_Grid2: TIB_Grid;
    IB_Grid3: TIB_Grid;
    Dts_Asl_Urun_Har: TIB_DataSource;
    qry_Temp: TIB_Query;
    Panel1: TPanel;
    btn_Fatura_Aktar_Tek: TButton;
    btn_Fatura_Aktar: TButton;
    lbl_Fatura_Id: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    IB_Grid1: TIB_Grid;
    Button2: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_Fatura_AktarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure qryFAT_IRSAfterScroll(IB_Dataset: TIB_Dataset);
    procedure btn_Fatura_Aktar_TekClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);

  private
    Kernel:IKernel;
    Sirket:ISirket;

   Fatura:IFatura;
   FatUst:IFatUst;
   FatKalem:IFatKalem;

   Cari:ICari;
   CariTemel:ICariTemelBilgi;

   Stok:IStok;
   StokTemel:IStokTemelBilgi;


    function GetAppPath: string;
    function Fatura_Tumu: Boolean;
    function Fatura_Aktar: Boolean;
    function Urun_Kodu_Getir(Kodu: String): String;

    { Private declarations }

  public
    AktarmaIni: TIniFile;
    HostIni: TIniFile;

    Main_Dosya:String;
    Main_Dosya_Adi:String;

    D_user_name:String;
    D_password:String;
    D_servername:String;
    D_local_con:Integer;

    user_name:String;
    password:String;
    servername:String;
    sirket_adi:String;
    no_user_name:String;
    no_password:String;
    no_servername:String;
    no_sirket_adi:String;

    { Public declarations }

  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

function TFrmMain.GetAppPath: string;
begin
  Result := ExtractFilePath(Application.ExeName);
  if Result[Length(Result)] <> '\' then
   Result := Result + '\';
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  AktarmaIni := TIniFile.Create(GetAppPath + 'NAktarma.ini');
  HostIni := TIniFile.Create(GetAppPath + 'Host.ini');

  Main_Dosya:=HostIni.ReadString('MainDB', 'DB_PATH', '');
  Main_Dosya_Adi:=ExtractFileName(Main_Dosya);

  D_user_name:=HostIni.ReadString('MainDB', 'USER', '');
  D_password:=HostIni.ReadString('MainDB', 'PASS_WORD', '');
  D_servername:=HostIni.ReadString('MainDB', 'SERVER', '');
  D_local_con:=HostIni.ReadInteger('MainDB', 'CONN_LOCAL', 0);

  IB_Conn.Connected:=False;
  IB_Conn.Server:=D_servername;
  IB_Conn.Password:=D_password;
  IB_Conn.Username:=D_user_name;
  if D_local_con=0 then
  begin
    IB_Conn.Protocol:=cpTCP_IP;
    IB_Conn.DatabaseName:=D_servername+':'+Main_Dosya;
  end
  else
  begin
    IB_Conn.Protocol:=cpLocal;
    IB_Conn.DatabaseName:=Main_Dosya;
  end;
  IB_Conn.Connected:=True;




  user_name:=AktarmaIni.ReadString('SQL', 'USER', '');
  password:=AktarmaIni.ReadString('SQL', 'PASS_WORD', '');
  servername:=AktarmaIni.ReadString('SQL', 'SERVER', '');
  sirket_adi:=AktarmaIni.ReadString('SQL', 'SIRKET_ADI', '');

  no_user_name:=AktarmaIni.ReadString('NOX', 'USER', '');
  no_password:=AktarmaIni.ReadString('NOX', 'PASS_WORD', '');
  no_servername:=AktarmaIni.ReadString('NOX', 'SERVER', '');
  no_sirket_adi:=AktarmaIni.ReadString('NOX', 'SIRKET_ADI', '');
    

  {AktarmaIni.WriteString('SQL', 'USER', '');
  AktarmaIni.WriteString('SQL', 'PASS_WORD', '');
  AktarmaIni.WriteString('SQL', 'SERVER', '');
  AktarmaIni.WriteString('SQL', 'SIRKET_ADI', '');
  AktarmaIni.WriteString('NOX', 'USER', '');
  AktarmaIni.WriteString('NOX', 'PASS_WORD', '');
  AktarmaIni.WriteString('NOX', 'SERVER', '');
  AktarmaIni.WriteString('NOX', 'SIRKET_ADI', '');
  }

  Query_Dosya.Active:=False;
  Query_Dosya.SQL.Clear;
  Query_Dosya.SQL.Add('Select CONN_LOCAL,SERVER_NAME,DB_PATH,USER_NAME,PASS_WORD,DONEM_BAS,DONEM_SON,DONEM_NO from TERMS');
  Query_Dosya.Active:=True;

end;

procedure TFrmMain.btn_Fatura_AktarClick(Sender: TObject);
begin

  Kernel:=CoKernel.Create;
  Sirket:=Kernel.yeniSirket(vtMSSQL,no_sirket_adi,'TEMELSET','',no_user_name,no_password,0);

  Fatura_Tumu;

  Sirket:=Nil;
  Kernel.FreeNetsisLibrary;

    with qryFAT_IRS do
    begin
      Active := False;
      Active := True;
    end;

  ShowMessage('Aktarma Tamamlandý');

end;

function TFrmMain.Urun_Kodu_Getir(Kodu:String):String;
begin
  Result:='';
  qry_Temp.Active:=False;
  qry_Temp.sql.Clear;
  qry_Temp.sql.Add('Select NETSIS_URUN_KOD from NETSIS_AKTARMA where YENI_URUN_KOD=:YENI_URUN_KOD');
  qry_Temp.ParamByName('YENI_URUN_KOD').AsString:=Kodu;
  qry_Temp.Active:=True;
  if qry_Temp.RecordCount>0 then
  Result:= qry_Temp.FieldByName('NETSIS_URUN_KOD').AsString;
  //else Result:= 'URN0100001';
end;


function TFrmMain.Fatura_Aktar:Boolean;
var
   Belge_Not,Belge_No,Belge_No_Temp:String;
   Urun_Kod:String;
begin

    Belge_No:='000000000000000';
    Result:=False;

        {
         with Qry_Asl_Urun_Har do
         begin
           Active := False;
           ParamByName('PRM_FATURA_ID').AsInteger := qryFAT_IRS.FieldbyName('PRM_FAT_IRS_ID').AsInteger;
           ParambyName('PRM_FATURA_SID').AsInteger := qryFAT_IRS.FieldbyName('PRM_FAT_IRS_SID').AsInteger;
           Active := True;
         end;
         }
         //lbl_Fatura_Id.Caption:=Inttostr(qryFAT_IRS.FieldbyName('FAT_IRS_ID').AsInteger);


         Fatura:=Kernel.yeniFatura(Sirket,ftsFAt);

         //Cari:=Kernel.yeniCari(Sirket);

         if not Cari.kayitOku(otAc,'CASABIT.CARI_KOD='+#39+Trim(qryFAT_IRS.FieldbyName('CARI_KOD').AsString)+#39) then
         //   if not Cari.kayitOku(otAc,'CASABIT.CARI_KOD='+'001') then
         begin
              Application.MessageBox(Pchar(qryFAT_IRS.FieldbyName('CARI_KOD').AsString+' Cari Kodu Netsis de Bulunamadý'),'Bilgi',MB_OK);
              Abort;
         end;


         {Belge_Not:=
         Copy(Belge_No+qryFAT_IRS.FieldbyName('BELGE_NO').AsString,
         Length(Belge_No+qryFAT_IRS.FieldbyName('BELGE_NO').AsString)-14,15);
         }

         Belge_Not:=
         Copy(Belge_No+qryFAT_IRS.FieldbyName('FAT_IRS_SERI').AsString+qryFAT_IRS.FieldbyName('BELGE_NO').AsString,
         Length(Belge_No+qryFAT_IRS.FieldbyName('FAT_IRS_SERI').AsString+qryFAT_IRS.FieldbyName('BELGE_NO').AsString)-14,15);

         if not Fatura.KayitOku(otAc,'FATUIRS.FATIRS_NO='+Belge_Not)
         then
         begin
              Application.MessageBox(Pchar(qryFAT_IRS.FieldbyName('CARI_KOD').AsString+' Cari Kodu '+qryFAT_IRS.FieldbyName('FAT_IRS_SERI').AsString+qryFAT_IRS.FieldbyName('BELGE_NO').AsString+' belge nolu faturasý vardýr iþlemden vazgeçilecek'),'Bilgi',MB_OK);
              Abort;
         end;

         try
         Fatura.NetsisTransaction(ttBaslat);

         FatUst:=Fatura.Ust;

        // FatUst.FATIRS_NO:='9999999999999999';//Belge_Not;
         FatUst.FATIRS_NO:=Belge_Not;
         FatUst.TIPI:=ft_YurtIci;
         FatUst.CariKod:=qryFAT_IRS.FieldbyName('CARI_KOD').AsString;
         //FatUst.CariKod:='001';//qryFAT_IRS.FieldbyName('CARI_KOD').AsString;
         FatUst.Tarih:=qryFAT_IRS.FieldbyName('TARIH').AsDateTime;
         FatUst.KDV_DAHILMI:=False;
         Fatust.ENTEGRE_TRH := qryFAT_IRS.FieldbyName('TARIH').AsDateTime;
         Fatust.FIYATTARIHI := qryFAT_IRS.FieldbyName('TARIH').AsDateTime;
         FATUST.ODEMEGUNU := 30;
         //Fatust.FIYATTARIHI := qryFAT_IRS.FieldbyName('TARIH').AsDateTime;
         //FatUst.SIPARIS_TEST:=Date;

         Qry_Asl_Urun_Har.First;

         While not Qry_Asl_Urun_Har.Eof do
         begin
              Urun_Kod:=Urun_Kodu_Getir(Qry_Asl_Urun_Har.FieldbyName('URUN_KOD').AsString);

              if Qry_Asl_Urun_Har.FieldbyName('URUN_KOD').AsString='URN0100001' then
              begin
                   Urun_Kod:='ÖZMAL';
              end;

              // Qry_Asl_Urun_Har.FieldbyName('URUN_KOD').AsString<>'URN0100001' then
              //gin
                  if not Stok.kayitOku(otAc,'stsabit.STOK_KODU='+#39+Urun_Kod+#39) then
                  //if not Stok.kayitOku(otAc,'stsabit.STOK_KODU='+'001') then
                  begin
                       Application.MessageBox(Pchar(Qry_Asl_Urun_Har.FieldbyName('URUN_KOD').AsString+' '+Urun_Kod+' Stok Kodu Netsis de Bulunamadý'),'Bilgi',MB_OK);
                       Abort;
                  end;
              //end
              //else


              {if Qry_Asl_Urun_Har.FieldbyName('SEFER').AsInteger=1999999 then
              begin

                   //Sefere konumlan satýcý kodunu olup oladýgýna göre
                   //özmal veya kiralýk ayrýmý yap toplamlarýný bul ona göre öz kiralýk seklinde faturanýn
                   //satýrlarýný olstur

              end;
              }

              FatKalem:=Fatura.kalemYeni(Urun_Kod);
              //FatKalem:=Fatura.kalemYeni('001');
              FatKalem.STra_GCMIK:=Qry_Asl_Urun_Har.FieldbyName('MIKTAR').AsFloat;
              FatKalem.STra_BF:=Qry_Asl_Urun_Har.FieldbyName('BIRIM_FIY_VPB').AsFloat;
              FatKalem.STra_KDV :=Qry_Asl_Urun_Har.FieldbyName('Kdv').AsFloat;
              FatKalem.Stra_FiiliTar := qryFAT_IRS.FieldbyName('TARIH').AsDateTime;
             Qry_Asl_Urun_Har.Next;
         end;

         Fatura.NetsisTransaction(ttBitir);
         Fatura.kayitYeni;
         try
         qry_Aktarilanlar.Append;
         qry_Aktarilanlar.FieldbyName('FAT_IRS_SEP').AsInteger:=qryFAT_IRS.FieldbyName('FAT_IRS_SEP').AsInteger;
         qry_Aktarilanlar.FieldbyName('FAT_IRS_ID').AsInteger:=qryFAT_IRS.FieldbyName('FAT_IRS_ID').AsInteger;
         qry_Aktarilanlar.FieldbyName('FAT_IRS_SID').AsInteger:=qryFAT_IRS.FieldbyName('FAT_IRS_SID').AsInteger;
         qry_Aktarilanlar.FieldbyName('TIP').AsInteger:=qryFAT_IRS.FieldbyName('TIP').AsInteger;
         qry_Aktarilanlar.FieldbyName('TARIH').AsDateTime:=Date;
         qry_Aktarilanlar.Post;
         except
         qry_Aktarilanlar.Cancel;
         end;


         except
           Fatura.NetsisTransaction(ttGeriAl);
           Raise;
         end;
        //Fatura:=
        result:=True;

end;

function TFrmMain.Fatura_Tumu:Boolean;
var
   Qry_Fat:TIb_Query;

begin

    with qryFAT_IRS do
    begin
      Active := False;
      {ParamByName('PRM_FAT_IRS_SEP').AsInteger := 1;
      ParambyName('PRM_FAT_IRS_ID').AsInteger := 1;
      ParambyName('PRM_FAT_IRS_SID').AsInteger := 1;}
      Active := True;
    end;


     qryFAT_IRS.First;
     While not qryFAT_IRS.Eof Do
     begin
         Fatura_Aktar;

         qryFAT_IRS.Next;
   end;
end;

procedure TFrmMain.Button2Click(Sender: TObject);
begin
    //Query_Dosya.SQL.Add('Select Select CONN_LOCAL,SERVER_NAME,DB_PATH,USER_NAME,PASS_WORD,DONEM_BAS,DONEM_SON,DONEM_NO from TERMS');
   try
     IB_Conn_Data.Connected:=False;
     IB_Conn_Data.Server:=Query_Dosya.FieldbyName('SERVER_NAME').AsString;
     IB_Conn_Data.Password:=Query_Dosya.FieldbyName('PASS_WORD').AsString;
     IB_Conn_Data.Username:=Query_Dosya.FieldbyName('USER_NAME').AsString;
     if Query_Dosya.FieldbyName('CONN_LOCAL').AsInteger=0 then
     begin
       IB_Conn_Data.Protocol:=cpTCP_IP;
       IB_Conn_Data.DatabaseName:=Query_Dosya.FieldbyName('SERVER_NAME').AsString+':'+Query_Dosya.FieldbyName('DB_PATH').AsString;
     end
     else
     begin
       IB_Conn_Data.Protocol:=cpLocal;
       IB_Conn_Data.DatabaseName:=Query_Dosya.FieldbyName('DB_PATH').AsString;
     end;
     IB_Conn_Data.Connected:=True;

    // btn_Fatura_Aktar.Enabled:=True;
    // btn_Fatura_Aktar.Visible:=True;


     btn_Fatura_Aktar_Tek.Enabled:=True;
     btn_Fatura_Aktar_Tek.Visible:=True;

   except
   end;

    with qryFAT_IRS do
    begin
      Active := False;
      Sql.Clear;
      Sql.Add(

'SELECT f.FAT_IRS_SEP '+
'     , f.FAT_IRS_ID '+
'     , f.FAT_IRS_SID '+
'     , f.CARI_KOD '+
'     , f.FAT_IRS_SERI '+
'     , f.BELGE_NO '+
'     , f.TARIH '+
'     , f.REF_BELGE_TUR '+
'     , f.REF_BELGE_ID '+
'     , f.REF_BELGE_SID '+
'     , f.ACIKLAMA '+
'     , f.BRUT_TOP '+
'     , f.NET_TOP '+
'     , f.GENEL_TOP '+
'     , f.KDV_TOP '+
'     , f.TIP '+
'     , f.YAZILDI '+
'     , f.IPTAL '+
'     , f.PLASIYER_KOD '+
'     , f.DEPO_KOD '+
'     , f.SAAT '+
'     , f.KALEM_ISKONTO_TOPLAM_VPB '+
'     , f.ISKONTO_TIP '+
'     , f.ISKONTO_ORAN '+
'     , f.ISKONTO_TUTAR_VPB '+
'     , f.ISKONTO_TOPLAM_VPB '+
'     , f.KDV1 '+
'     , f.KDV2 '+
'     , f.KDV3 '+
'     , f.KDV4 '+
'     , f.KDV5 '+
'     , f.OTV '+
'     , f.VADE_GUN '+
'     , f.VADE_TARIH '+
'     , f.FAT_IRS_TIP '+
'     , f.KDV1_ORAN '+
'     , f.KDV2_ORAN '+
'     , f.KDV3_ORAN '+
'     , f.KDV4_ORAN '+
'     , f.KDV5_ORAN '+
'     , f.DOV_BAZ_TAR '+
'     , f.MUHTELIF '+
'     , f.KASA_KOD '+
'     , f.MASRAF_MERK '+
'     , f.KOD1 '+
'     , f.KOD2 '+
'     , f.KOD3 '+
'     , f.KOD4 '+
'     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=FAT_IRS.KASA_KOD) as KASA_AD '+
'     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=FAT_IRS.CARI_KOD) As CARI_AD '+
'     , (Select DEPO.ADI From DEPO Where DEPO.DEPO_KOD=FAT_IRS.DEPO_KOD ) As DEPO_AD '+
'     , (Select PLASIYER.ADISOY from PLASIYER Where PLASIYER.PLASIYER_KOD=FAT_IRS.PLASIYER_KOD) AS PLASIYER_AD '+
'     , f.PROJE_KOD '+
'     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=FAT_IRS.PROJE_KOD) As PROJE_AD '+
'     , f.YEV_ACIKLAMA '+
'     , f.KAPANDI '+
'     , f.SEVK_ADRES_KOD '+
'FROM FAT_IRS f '+
'WHERE '+
'f.TIP=1 '+
'and not (f.FAT_IRS_ID in (SELECT a.FAT_IRS_ID FROM fat_irs_aktar a '+
'WHERE f.FAT_IRS_SEP=a.FAT_IRS_SEP AND f.FAT_IRS_ID=a.FAT_IRS_ID AND f.FAT_IRS_SID=a.FAT_IRS_SID)) '+
'Order By f.FAT_IRS_ID ');




      Active := True;
      Last;
    end;
end;

procedure TFrmMain.qryFAT_IRSAfterScroll(IB_Dataset: TIB_Dataset);
begin
         with Qry_Asl_Urun_Har do
         begin
           Active := False;
           ParamByName('PRM_FATURA_ID').AsInteger := qryFAT_IRS.FieldbyName('FAT_IRS_ID').AsInteger;
           ParambyName('PRM_FATURA_SID').AsInteger := qryFAT_IRS.FieldbyName('FAT_IRS_SID').AsInteger;
           Active := True;
         end;
end;

procedure TFrmMain.btn_Fatura_Aktar_TekClick(Sender: TObject);
begin

  Kernel:=CoKernel.Create;

  Sirket:=Kernel.yeniSirket(vtMSSQL,no_sirket_adi,'TEMELSET','',no_user_name,no_password,0);

  Cari:=Kernel.yeniCari(Sirket);
  Stok:=Kernel.yeniStok(Sirket);
  Fatura_Aktar;
  Cari:=Nil;
  Stok:=Nil;
  Sirket:=Nil;
  Kernel.FreeNetsisLibrary;

  qryFAT_IRS.Active:=False;
  qryFAT_IRS.Active:=True;
  
  ShowMessage('Aktarma Tamamlandý');


end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AktarmaIni.Free;
  HostIni.Free;

end;

procedure TFrmMain.Button1Click(Sender: TObject);
begin


    with qryFAT_IRS do
    begin
      Active := False;
      Sql.Clear;
      Sql.Add(

'SELECT f.FAT_IRS_SEP '+
'     , f.FAT_IRS_ID '+
'     , f.FAT_IRS_SID '+
'     , f.CARI_KOD '+
'     , f.FAT_IRS_SERI '+
'     , f.BELGE_NO '+
'     , f.TARIH '+
'     , f.REF_BELGE_TUR '+
'     , f.REF_BELGE_ID '+
'     , f.REF_BELGE_SID '+
'     , f.ACIKLAMA '+
'     , f.BRUT_TOP '+
'     , f.NET_TOP '+
'     , f.GENEL_TOP '+
'     , f.KDV_TOP '+
'     , f.TIP '+
'     , f.YAZILDI '+
'     , f.IPTAL '+
'     , f.PLASIYER_KOD '+
'     , f.DEPO_KOD '+
'     , f.SAAT '+
'     , f.KALEM_ISKONTO_TOPLAM_VPB '+
'     , f.ISKONTO_TIP '+
'     , f.ISKONTO_ORAN '+
'     , f.ISKONTO_TUTAR_VPB '+
'     , f.ISKONTO_TOPLAM_VPB '+
'     , f.KDV1 '+
'     , f.KDV2 '+
'     , f.KDV3 '+
'     , f.KDV4 '+
'     , f.KDV5 '+
'     , f.OTV '+
'     , f.VADE_GUN '+
'     , f.VADE_TARIH '+
'     , f.FAT_IRS_TIP '+
'     , f.KDV1_ORAN '+
'     , f.KDV2_ORAN '+
'     , f.KDV3_ORAN '+
'     , f.KDV4_ORAN '+
'     , f.KDV5_ORAN '+
'     , f.DOV_BAZ_TAR '+
'     , f.MUHTELIF '+
'     , f.KASA_KOD '+
'     , f.MASRAF_MERK '+
'     , f.KOD1 '+
'     , f.KOD2 '+
'     , f.KOD3 '+
'     , f.KOD4 '+
'     , (Select KASA.ACIKLAMA From KASA where KASA.KASA_KOD=FAT_IRS.KASA_KOD) as KASA_AD '+
'     , (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=FAT_IRS.CARI_KOD) As CARI_AD '+
'     , (Select DEPO.ADI From DEPO Where DEPO.DEPO_KOD=FAT_IRS.DEPO_KOD ) As DEPO_AD '+
'     , (Select PLASIYER.ADISOY from PLASIYER Where PLASIYER.PLASIYER_KOD=FAT_IRS.PLASIYER_KOD) AS PLASIYER_AD '+
'     , f.PROJE_KOD '+
'     , (Select PROJE.PROJE_AD From PROJE Where PROJE.PROJE_KOD=FAT_IRS.PROJE_KOD) As PROJE_AD '+
'     , f.YEV_ACIKLAMA '+
'     , f.KAPANDI '+
'     , f.SEVK_ADRES_KOD '+
'FROM FAT_IRS f '+
'WHERE '+
'f.TIP=1 '+
'and (f.FAT_IRS_ID in (SELECT a.FAT_IRS_ID FROM fat_irs_aktar a '+
'WHERE f.FAT_IRS_SEP=a.FAT_IRS_SEP AND f.FAT_IRS_ID=a.FAT_IRS_ID AND f.FAT_IRS_SID=a.FAT_IRS_SID)) '+
'Order By f.FAT_IRS_ID ');


      Active := True;
      Last;
    end;
end;

end.











{



CREATE TABLE FAT_IRS_AKTAR (
    FAT_IRS_SEP  D_SID NOT NULL /* D_SID = SMALLINT NOT NULL */,
    FAT_IRS_ID   D_IDFIELD NOT NULL /* D_IDFIELD = INTEGER DEFAULT 0 NOT NULL */,
    FAT_IRS_SID  D_SID NOT NULL /* D_SID = SMALLINT NOT NULL */,
    TIP          D_SMALLINT /* D_SMALLINT = SMALLINT */,
    TARIH        TIMESTAMP
);
ALTER TABLE FAT_IRS_AKTAR ADD CONSTRAINT PK_FAT_IRS_AKTAR PRIMARY KEY (FAT_IRS_SEP, FAT_IRS_ID, FAT_IRS_SID);


SELECT COUNT (SEFER_ID) FROM URUNHAR
GROUP BY SEFER_ID
HAVING  COUNT (SEFER_ID)=1



UPDATE URUNHAR SET URUN_KOD='URN0100006'
WHERE SEFER_ID>0 AND SEFER_ID<>1999999 AND
SEFER_ID = (SELECT SEFER_ID FROM SEFER WHERE SEFER.SATICI_KOD<>'' AND SEFER_ID=URUNHAR.SEFER_ID)



UPDATE FATURA_D SET URUN_KOD='URN0100006'
WHERE SEFER_ID>0 AND SEFER_ID<>1999999 AND
SEFER_ID = (SELECT SEFER_ID FROM SEFER WHERE SEFER.SATICI_KOD<>'' AND SEFER_ID=FATURA_D.SEFER_ID)
}
