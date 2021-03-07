unit unHARFUNCS;

interface

uses
  SysUtils, Classes,Controls,Dialogs,Forms,Windows,
  unDataMod,unFUNC,IB_Components;

type
  TdmHARFUNCS = class(TDataModule)
  Procedure CleanURUN_BA;
  Procedure CleanURUNHAR;
  Procedure CleanFAT_IRS;
 // Procedure CopyFatura2FAT_IRS;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmHARFUNCS: TdmHARFUNCS;

implementation

{$R *.dfm}

Procedure TdmHARFUNCS.CleanURUN_BA;
var qryEXECUTER:TIB_Query;
begin
   DataMod.CreateQuery(qryEXECUTER,Nil,False,DataMod.dbaMain);
   with qryEXECUTER do
   begin
     sql.Add('UPDATE URUN SET BORC = 0, ALACAK = 0, BORC_VPB = 0, ALACAK_VPB = 0, MIKTAR_BORC = 0, MIKTAR_ALACAK =0');
     qryEXECUTER.Execute;
   end;
end;

Procedure TdmHARFUNCS.CleanURUNHAR;
var qryEXECUTER:TIB_Query;
begin
   DataMod.CreateQuery(qryEXECUTER,Nil,False,DataMod.dbaMain);
   with qryEXECUTER do
   begin
     sql.Add('DELETE FROM URUNHAR');
     qryEXECUTER.Execute;
   end;
end;

Procedure TdmHARFUNCS.CleanFAT_IRS;
var qryEXECUTER:TIB_Query;
begin
   DataMod.CreateQuery(qryEXECUTER,Nil,False,DataMod.dbaMain);
   with qryEXECUTER do
   begin
     sql.Add('DELETE FROM FAT_IRS');
     qryEXECUTER.Execute;
   end;
end;
{
Procedure TdmHARFUNCS.CopyFatura2FAT_IRS;
var qryFATURA,qryFAT_IRS,qryFATURA_D,qryURUNHAR:TIB_Query;
    trnFAT_IRS:TIB_Transaction;
    BIRIMFIY_URN_DOVKOD,
    TUTAR_URN_DOVKOD,
    MIKTAR_URN_OLCUBIRIM,
    BIRIMFIY_VPB:Currency;
    URUN_DOVKOD,URUN_OLCUBIRIM:String;

begin
  DataMod.CreateQuery(qryFATURA,Nil,False,DataMod.dbaMain);
  DataMod.CreateQuery(qryFATURA_D,Nil,False,DataMod.dbaMain);
  DataMod.CreateTransaction(trnFAT_IRS,tiCommitted,DataMod.dbaMain);
  DataMod.CreateQuery(qryFAT_IRS,trnFAT_IRS,True,DataMod.dbaMain);
  DataMod.CreateQuery(qryURUNHAR,trnFAT_IRS,True,DataMod.dbaMain);
  CleanFAT_IRS;
  CleanURUNHAR;
  CleanURUN_BA;
  qryFATURA_D.SQL.Add('SELECT * FROM FATURA_D WHERE FATURA_ID=:PRM_FATURA_ID AND FATURA_SID=:PRM_FATURA_SID');
  qryFATURA_D.Prepare;
  qryFATURA.SQL.Add('SELECT * FROM FATURA');
  qryFATURA.Open;
  qryFAT_IRS.SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_SEP = 5');
  qryURUNHAR.SQL.Add('SELECT * FROM URUNHAR WHERE URUNHAR_ID = 0 ');
  repeat
    trnFAT_IRS.StartTransaction;
    qryFAT_IRS.Open;
    qryFAT_IRS.Insert;
    qryFAT_IRS.FieldByName('FAT_IRS_SEP').asInteger                       := 1;
    qryFAT_IRS.FieldByName('FAT_IRS_ID').asInteger                        := qryFATURA.FieldByName('FATURA_ID').asInteger;
    qryFAT_IRS.FieldByName('FAT_IRS_SID').asInteger                       := qryFATURA.FieldByName('FATURA_SID').asInteger;
    qryFAT_IRS.FieldByName('CARI_KOD').AsString                           := qryFATURA.FieldByName('CARI_KOD').AsString;
    qryFAT_IRS.FieldByName('FAT_IRS_SERI').AsString                       := qryFATURA.FieldByName('FATSERI').AsString;
    qryFAT_IRS.FieldByName('BELGE_NO').AsString                           := qryFATURA.FieldByName('FATURA_NO').AsString;
    qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDate                          := qryFATURA.FieldByName('DOV_BAZ_TAR').AsDate;
    qryFAT_IRS.FieldByName('TARIH').AsDate                                := qryFATURA.FieldByName('TARIH').AsDate;
    qryFAT_IRS.FieldByName('REF_BELGE_TUR').asInteger                     := qryFATURA.FieldByName('REF_BELGE_TUR').asInteger;
    qryFAT_IRS.FieldByName('REF_BELGE_ID').asInteger                      := qryFATURA.FieldByName('REF_BELGE_ID').asInteger;
    qryFAT_IRS.FieldByName('REF_BELGE_SID').asInteger                     := qryFATURA.FieldByName('REF_BELGE_SID').asInteger;
    qryFAT_IRS.FieldByName('ACIKLAMA').AsString                           := qryFATURA.FieldByName('ACIKLAMA').AsString;
    qryFAT_IRS.FieldByName('BRUT_TOP').AsCurrency                         := qryFATURA.FieldByName('BRUTTOP').AsCurrency;
    qryFAT_IRS.FieldByName('NET_TOP').AsCurrency                          := qryFATURA.FieldByName('NETTOP').AsCurrency;
    qryFAT_IRS.FieldByName('GENEL_TOP').AsCurrency                        := qryFATURA.FieldByName('GENELTOP').AsCurrency;
    qryFAT_IRS.FieldByName('KDV_TOP').AsCurrency                          := qryFATURA.FieldByName('KDVTOP').AsCurrency;
    qryFAT_IRS.FieldByName('TIP').asInteger                               := qryFATURA.FieldByName('TIP').asInteger;
    qryFAT_IRS.FieldByName('FAT_IRS_TIP').asInteger                       := qryFATURA.FieldByName('FATURA_TIP').asInteger;
    qryFAT_IRS.FieldByName('YAZILDI').asInteger                           := qryFATURA.FieldByName('YAZILDI').asInteger;
    qryFAT_IRS.FieldByName('IPTAL').asInteger                             := qryFATURA.FieldByName('IPTAL').asInteger;
    qryFAT_IRS.FieldByName('DEPO_KOD').AsString                           := qryFATURA.FieldByName('DEPO_KOD').AsString;
    qryFAT_IRS.FieldByName('SAAT').AsDateTime                             := qryFATURA.FieldByName('SAAT').AsDateTime;
    qryFAT_IRS.FieldByName('KALEM_ISKONTO_TOPLAM_VPB').AsCurrency         := qryFATURA.FieldByName('KALEM_ISKONTO_TOPLAMVBP').AsCurrency;
    qryFAT_IRS.FieldByName('ISKONTO_TIP').asInteger                       := qryFATURA.FieldByName('FATURA_ISKONTO_TIP').asInteger;
    qryFAT_IRS.FieldByName('ISKONTO_ORAN').asInteger                      := qryFATURA.FieldByName('FATURA_ISKONTO_ORAN').asInteger;
    qryFAT_IRS.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency                := qryFATURA.FieldByName('FATURA_ISKONTO_TUTARVPB').AsCurrency;
    qryFAT_IRS.FieldByName('ISKONTO_TOPLAM_VPB').AsCurrency               := qryFATURA.FieldByName('ISKONTO_TOPLAMIVPB').AsCurrency;
    qryFAT_IRS.FieldByName('KDV1').AsCurrency                             := qryFATURA.FieldByName('KDV1').AsCurrency;
    qryFAT_IRS.FieldByName('KDV2').AsCurrency                             := qryFATURA.FieldByName('KDV2').AsCurrency;
    qryFAT_IRS.FieldByName('KDV3').AsCurrency                             := qryFATURA.FieldByName('KDV3').AsCurrency;
    qryFAT_IRS.FieldByName('KDV4').AsCurrency                             := qryFATURA.FieldByName('KDV4').AsCurrency;
    qryFAT_IRS.FieldByName('KDV5').AsCurrency                             := qryFATURA.FieldByName('KDV5').AsCurrency;
    qryFAT_IRS.FieldByName('OTV').AsCurrency                              := qryFATURA.FieldByName('OTV').AsCurrency;
    qryFAT_IRS.FieldByName('VADE_GUN').asInteger                          := qryFATURA.FieldByName('VADE_GUN').asInteger;
    qryFAT_IRS.FieldByName('VADE_TARIH').AsDate                           := qryFATURA.FieldByName('VADE_TARIH').AsDate;
    qryFAT_IRS.FieldByName('KDV1_ORAN').asInteger                         := qryFATURA.FieldByName('KDV1_ORAN').asInteger;
    qryFAT_IRS.FieldByName('KDV2_ORAN').asInteger                         := qryFATURA.FieldByName('KDV2_ORAN').asInteger;
    qryFAT_IRS.FieldByName('KDV3_ORAN').asInteger                         := qryFATURA.FieldByName('KDV3_ORAN').asInteger;
    qryFAT_IRS.FieldByName('KDV4_ORAN').asInteger                         := qryFATURA.FieldByName('KDV4_ORAN').asInteger;
    qryFAT_IRS.FieldByName('KDV5_ORAN').asInteger                         := qryFATURA.FieldByName('KDV5_ORAN').asInteger;
    qryFAT_IRS.FieldByName('ODEMETAR').AsDate                             := qryFATURA.FieldByName('ODEMETAR').AsDate;
    qryFAT_IRS.FieldByName('MUHTELIF').asInteger                          := qryFATURA.FieldByName('MUHTELIF').asInteger;
    qryFAT_IRS.FieldByName('KASA_KOD').AsString                           := qryFATURA.FieldByName('KASA_KOD').AsString;
    qryFAT_IRS.FieldByName('PLASIYER_KOD').AsString                       := qryFATURA.FieldByName('PLASIYER_KOD').AsString;
    qryFAT_IRS.FieldByName('PROJE_KOD').AsString                          := qryFATURA.FieldByName('PROJE_KOD').AsString;
    qryFAT_IRS.FieldByName('MASRAF_MERK').AsString                        := qryFATURA.FieldByName('MASRAF_MERK').AsString;
    qryFAT_IRS.FieldByName('KOD1').AsString                               := qryFATURA.FieldByName('KOD1').AsString;
    qryFAT_IRS.FieldByName('KOD2').AsString                               := qryFATURA.FieldByName('KOD2').AsString;
    qryFAT_IRS.FieldByName('KOD3').AsString                               := qryFATURA.FieldByName('KOD3').AsString;
    qryFAT_IRS.FieldByName('KOD4').AsString                               := qryFATURA.FieldByName('KOD4').AsString;
    qryFAT_IRS.FieldByName('YEV_ACIKLAMA').AsString                       := qryFATURA.FieldByName('YEV_ACIKLAMA').AsString;
    qryFAT_IRS.Post;
    qryFATURA_D.Close;
    qryFATURA_D.ParamByName('PRM_FATURA_ID').AsInteger := qryFATURA.FieldByName('FATURA_ID').AsInteger;
    qryFATURA_D.ParamByName('PRM_FATURA_SID').AsInteger := qryFATURA.FieldByName('FATURA_SID').AsInteger;
    qryFATURA_D.Open;
    if qryFATURA_D.RecordCount <> 0 then
    begin
      qryURUNHAR.Open;
      repeat
        qryURUNHAR.Insert;
        qryURUNHAR.FieldByName('URUNHAR_ID').AsInteger := qryURUNHAR.Gen_ID('GEN_URUNHAR',1);
        qryURUNHAR.FieldByName('URUNHAR_SID').AsInteger := glb_SID;
        qryURUNHAR.FieldByName('URUN_KOD').AsString := qryFATURA_D.FieldByName('URUN_KOD').asString;
        if qryFATURA.FieldByName('TIP').AsSmallint = 1 then
        begin
           qryURUNHAR.FieldByName('TIP').AsString := ALACAK;
           qryURUNHAR.FieldByName('BELGE_TUR').AsInteger := BT_SATIS_FAT;
        end else
        begin
           qryURUNHAR.FieldByName('TIP').AsString := BORC;
           qryURUNHAR.FieldByName('BELGE_TUR').AsInteger := BT_ALIS_FAT;
        end;
        qryURUNHAR.FieldByName('BELGE_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger ;
        qryURUNHAR.FieldByName('BELGE_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger ;
        qryURUNHAR.FieldByName('BELGE_SIRA_NO').AsInteger := 1;
        qryURUNHAR.FieldByName('TARIH').AsDate := qryFAT_IRS.FieldByName('TARIH').AsDate;
        qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDate  := qryFAT_IRS.FieldByName('DOV_BAZ_TAR').AsDate;
        qryURUNHAR.FieldByName('OLCUBIRIM').AsString := qryFATURA_D.FieldByName('OLCUBIRIM').AsString;
        qryURUNHAR.FieldByName('MIKTAR').AsCurrency := qryFATURA_D.FieldByName('MIKTAR').AsCurrency;
        qryURUNHAR.FieldByName('DOVKOD').AsString := qryFATURA_D.FieldByName('DOVKOD').AsString;
        qryURUNHAR.FieldByName('DOVKUR').AsCurrency := qryFATURA_D.FieldByName('DOVKUR').AsCurrency;
        qryURUNHAR.FieldByName('TUTAR').AsCurrency := qryFATURA_D.FieldByName('TUTARDOV').AsCurrency;
        qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency := qryFATURA_D.FieldByName('TUTARVPB').AsCurrency;
        qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency := qryFATURA_D.FieldByName('BIRIMFIY').AsCurrency;
        qryURUNHAR.FieldByName('ISKONTO_TUTAR').AsCurrency := qryFATURA_D.FieldByName('ISKONTO_TUTAR').AsCurrency;
        qryURUNHAR.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qryFATURA_D.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency;
        qryURUNHAR.FieldByName('DEPO_KOD').AsString := qryFATURA_D.FieldByName('DEPO_KOD').AsString;
        qryURUNHAR.FieldByName('MASRAF_MERK').AsString := qryFATURA.FieldByName('MASRAF_MERK').AsString;
        qryURUNHAR.FieldByName('KOD1').AsString := qryFATURA.FieldByName('KOD1').AsString;
        qryURUNHAR.FieldByName('KOD2').AsString := qryFATURA.FieldByName('KOD2').AsString;
        qryURUNHAR.FieldByName('KOD3').AsString := qryFATURA.FieldByName('KOD3').AsString;
        qryURUNHAR.FieldByName('KOD4').AsString := qryFATURA.FieldByName('KOD4').AsString;
        qryURUNHAR.FieldByName('ACIKLAMA').AsString := qryFATURA_D.FieldByName('ACIKLAMA').AsString;
        qryURUNHAR.FieldByName('ISKONTO_TIP').AsInteger := qryFATURA_D.FieldByName('ISKONTO_TIP').AsInteger;
        qryURUNHAR.FieldByName('ISKONTO_ORAN').AsInteger := qryFATURA_D.FieldByName('ISKONTO_ORAN').AsInteger;
        qryURUNHAR.FieldByName('FATURA_ID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger;
        qryURUNHAR.FieldByName('FATURA_SID').AsInteger := qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger;
        qryURUNHAR.FieldByName('IRSALIYE_ID').AsInteger := 0;
        qryURUNHAR.FieldByName('IRSALIYE_SID').AsInteger := 0;
        qryURUNHAR.FieldByName('KDV').AsInteger := qryFATURA_D.FieldByName('KDV').AsInteger;
        qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency := qryFATURA_D.FieldByName('KDV_TUTAR').AsCurrency;

         if DataMod.GET_URUNHAR_URUN_BILGI(qryURUNHAR.FieldByName('URUN_KOD').AsString,
                                           qryURUNHAR.FieldByName('TIP').AsString[1],
                                           qryURUNHAR.FieldByName('DOVKOD').AsString,
                                           qryURUNHAR.FieldByName('OLCUBIRIM').AsString,
                                           qryURUNHAR.FieldByName('DOV_BAZ_TAR').AsDate,
                                           qryURUNHAR.FieldByName('BIRIM_FIY').AsCurrency,
                                           qryURUNHAR.FieldByName('TUTAR').AsCurrency,
                                           qryURUNHAR.FieldByName('DOVKUR').AsCurrency,
                                           qryURUNHAR.FieldByName('MIKTAR').AsCurrency,
                                           BIRIMFIY_URN_DOVKOD,
                                           BIRIMFIY_VPB,
                                           TUTAR_URN_DOVKOD,
                                           MIKTAR_URN_OLCUBIRIM,
                                           URUN_DOVKOD,
                                           URUN_OLCUBIRIM) then
         begin
           qryURUNHAR.FieldByName('BIRIM_FIY_URN_DOVKOD').AsCurrency := BIRIMFIY_URN_DOVKOD;
           qryURUNHAR.FieldByName('BIRIM_FIY_VPB').AsCurrency := BIRIMFIY_VPB;
           qryURUNHAR.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency := TUTAR_URN_DOVKOD;
           qryURUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency := MIKTAR_URN_OLCUBIRIM;
           qryURUNHAR.FieldByName('URUN_DOVKOD').AsString := URUN_DOVKOD;
           qryURUNHAR.FieldByName('OLCUBIRIM_URN_OB').AsString := URUN_OLCUBIRIM;
         end else
         begin
           Application.MessageBox('DataMod.GET_URUNHAR_URUN_BILGI','Hata',MB_ICONERROR);
           Exit;
         end;
         if (qryURUNHAR.FieldByName('URUN_KOD').AsString <> '') Or (qryURUNHAR.FieldByName('IRSALIYE_ID').AsInteger = 0)Then
         begin
            if not DataMod.URUN_HAR_AUD(trnFAT_IRS,
                                        qryURUNHAR.FieldByName('URUN_KOD').AsString,
                                        qryURUNHAR.FieldByName('DEPO_KOD').AsString,
                                        qryURUNHAR.FieldByName('TIP').AsString[1],
                                        qryURUNHAR.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency,
                                        qryURUNHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                        qryURUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency) then
            begin
              Application.MessageBox('DataMod.URUN_HAR_AUD','Hata',MB_ICONERROR);
              Exit;
            end;
          end;

        qryURUNHAR.Post;
        qryFATURA_D.Next;
      until qryFATURA_D.EOF;
    end;
    trnFAT_IRS.Commit;
    qryFATURA.Next;
  until qryFATURA.Eof;
  ShowMessage('Bitti');
end;
}
end.
