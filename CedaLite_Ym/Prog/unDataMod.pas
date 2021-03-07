{$INCLUDE directive.inc}

unit unDataMod;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IB_Components, IB_StoredProc, IB_Monitor, IB_Dialogs, IB_Controls, Variants,
  IB_Grid, StdCtrls,ComCtrls, IB_SessionProps,DateUtils,IB_Session,
  IB_Process, IB_Script, cxSSTypes,Menus;

type
  TSube = Record
    Sube_Id : integer;
    Sube_Ad : String[100];
  end;

type
  TDataMod = class(TDataModule)
    dbaMain: TIB_Connection;
    qryGENEL: TIB_Query;
    FBMon: TIB_MonitorDialog;
    SP_GET_URUN_FAT_BILGI: TIB_StoredProc;
    SP_GET_SERVER_DATE_TIME: TIB_StoredProc;
    IB_SessionProps1: TIB_SessionProps;
    dbaANA: TIB_Connection;
    qryGENEL1: TIB_Query;
    trnUpd: TIB_Transaction;
////////////////////////////////////////////////////////////////////////////////
    function LS_Depo(var DEPO_KOD:String;var DEPO_AD:String):Boolean;
    function LS_Plasiyer(var Plasiyer_KOD:String;Var Plasiyer_AD:String;DURUM:Byte):Boolean;
    function LS_Arac(var ARAC_KOD, PLAKA: String; DURUM: Byte): Boolean; Overload;
    function LS_Personel(var Personel_KOD, Personel_AD: String): Boolean;

    function LS_Esya(var Esya_Id:Integer; var Esya_AD: String): Boolean;

    function LS_Proje(var Proje_KOD:String;var Proje_AD:String;Durum:Byte):Boolean;
    function LS_CariGroup(var CariGroup_KOD:String;var CariGroup_AD:String):Boolean;
    function LS_MasrafGroup(var MasrafGroup_KOD:String;var MasrafGroup_AD:String):Boolean;
    function LS_UrunGroup(var UrunGroup_KOD:String;Var UrunGroup_AD:String):Boolean;
    function LS_KASA(var KASA_KOD:String;var ACIKLAMA:String;var DOVKOD:String):Boolean;
    function LS_OlcuBrm(OlcuTip:String; Var OlcuBir:String):Boolean;
    function LS_OlcuTip(var OlcuTIP:String):Boolean;
    function LS_Modul():Integer;
    function LS_MASRAFTAN(var MasrafKod: String): Boolean;
    function LS_DEKONT_AUT(var ID,SID: Integer): Boolean;
    function LS_Siparis(var FAT_IRS_SEP:Integer; var FAT_IRS_SID, FAT_IRS_ID: Integer; var SERI_BELGE: String): Boolean;
    function LS_MUH_KOD(TIP: SmallInt; var MUH_KOD, ACIKLAMA: String): Boolean;
    function LS_Sevk_Adres(var ADRES_KOD: String; CARI_KOD: String;  CARI_SID: Integer): Boolean;OverLoad;
    function LS_Paket(var PAKET_KOD, PAKET_AD: String): Boolean;

    function LS_Komisyon(var Id: Integer): Boolean;
    function LS_Sofor(var Sofor_KOD, Sofor_AD: String): Boolean;

    function LS_Bayi(var BAYI_KOD, BAYI_AD: String): Boolean;
    function LS_Ariza(var ARIZA_KOD, ARIZA_AD: String): Boolean;
    function LS_Sigorta(var SIGORTA_KOD, SIGORTA_AD: String): Boolean;
    function LS_Arac_Srv(var ARAC_KOD, PLAKA, CARI_KOD: String;var SASI_NO:String;var MARKA_TIP:String; Kissas: String): Boolean;
    function LS_Gelis_Nedeni(var NEDEN_KOD, ACIKLAMA: String): Boolean;
    function LS_MARKA(var MARKA: String): Boolean;
    function LS_MARKA_TIP(MARKA:String; var MARKA_TIP: String): Boolean;



    function LS_Plaka(var PLAKA_NO, ACIKLAMA, CARI_KOD, CARI_AD: String): Boolean;    

////////////////////////////////////////////////////////////////////////////////
    function GETPARAM(Modul_ID:Integer;ParamName:String;Sube_ID:SmallInt):String;
    function GET_SAYAC_NUM(SayacName :String;Arttir:Boolean;Sirali:Boolean;Sube_ID:SmallInt):integer;
    function GET_DOVIZ_KUR(PRM_DOVKOD:String;PRM_TARIH:TDateTime;PRM_TIP:Byte;PRM_ISN:Integer):Extended;
    function GET_KASA_FROM_KASA_KOD(KASA_KOD:String;var KASA_AD:String;var KASA_DOVKOD:String):Boolean;
    function GET_DEFAULT_KASA(var KASA_KOD,KASA_AD,KASA_DOVKOD:String):Boolean;
    function GET_DEFAULT_KASA_ESKI(var KASA_KOD,KASA_AD,KASA_DOVKOD:String):Boolean;

    function GET_KULLANICI_KASA_KOD(KASA_KOD: String; var KASA_AD: String): Boolean;

    //01.03.2005 tarihinde eser þahin tarafýndan yeni get_default_kasa fonksiyonu yazýldý.
    function GET_SERVER_DATE:TDate;
    function GET_SERVER_DATETIME:TDateTime;
    function GET_ISN_NUM:Integer;
////////////////////////////////////////////////////////////////////////////////
    function Kod_Format(Value:int64;PreWord:String;EndWord:String;BranchID:integer;KodLength:Integer):String;
    function KurluDonustur(Tarih:TdateTime;FromKur:String;FROM_DOVKUR:Currency;ToKur:String;Tutar:Currency;KurTipi:Byte;DOV_KURLA_ISLE:Boolean;var SONUC:Currency):Boolean;
    function Modul_Hak(Modul_ID:Integer;Var my_CanUpdate:Boolean;Var my_CanDelete:Boolean):Boolean;
    function Before_Post_Kontrol(my_Table:TIB_Query;my_Table_Name:String; my_NotNullCol:String;my_UniqueCol:String):String;
////////////////////////////////////////////////////////////////////////////////

    function FN_CariKOD2Bilgi(Cari_KOD:String; Var res_Cari:TStringList):Boolean;
    function FN_Sirket(Var res_Sirket:TStringList):Boolean;
    function FN_KOD2AD(my_Table_Name:String;KOD_FIELDNAME:String;NAME_FIELDNAME:String;KOD_VALUE:String;Var AD:String):Boolean;OverLoad; /// kod gönderip sadece ad alýncak functionlarda kullanýlcak

////////////////////////////////////////////////////////////////////////////////
    function Delete_Control(Table_Name:String;Value:String;var Msg:String):Boolean;
    function Post_Update(Table_Name:String;OldValue:String;NewValue:String;Transaction:TIB_Transaction):Boolean;
    function Muh_Kod_Kontrol(Kontrol_IB:TIB_Edit;Kontrol:TEdit;Alan:Byte):Boolean;
    function IsDateInTerm(Value:TDateTime;FieldName:String):Boolean;
    function SubeAd2ID(ad:String):String;
    function SubeID2Ad(Yazici:Boolean;ID:Integer):String;
////////////////////////////////////////////////////////////////////////////////
    function  DEPO_URUN_BA_UPDATE(Transaction:TIB_Transaction;
                                  PRM_DEPO_KOD,PRM_URUN_KOD:String;
                                  PRM_BA:Char;
                                  PRM_TUTAR,PRM_TUTAR_VPB,PRM_MIKTAR:Currency):Boolean;

    function URUN_BA_UPDATE(Transaction:TIB_Transaction;
                            PRM_URUN_KOD:String;
                            PRM_BA:Char;
                            PRM_TUTAR,PRM_TUTAR_VPB,PRM_MIKTAR:Currency):Boolean;

    function GET_URUNHAR_URUN_BILGI(PRM_URUN_KOD:String;
                                    PRM_BA:Char;
                                    PRM_DOVKOD,PRM_OLCUBIRIM:String;
                                    PRM_TARIH:TDate;
                                    PRM_BIRIMFIY,
                                    PRM_TUTAR,
                                    PRM_DOVKUR,
                                    PRM_MIKTAR:Currency;
                                    var BIRIMFIY_URN_DOVKOD:Currency;
                                    var BIRIMFIY_VPB:Currency;
                                    var TUTAR_URN_DOVKOD:Currency;
                                    var MIKTAR_URN_OLCUBIRIM:Currency;
                                    var URUN_DOVKOD:String;
                                    var URUN_OLCUBIRIM:String):Boolean;

    function URUN_HAR_AUD(Transaction:TIB_Transaction;
                          PRM_URUN_KOD,PRM_DEPO_KOD:String;
                          PRM_BA:Char;
                          PRM_TUTAR,
                          PRM_TUTAR_VPB,
                          PRM_MIKTAR:Currency):Boolean;
////////////////////////////////////////////////////////////////////////////////
    function GET_URUN_FAT_BILGI(trn:TIB_Transaction;
                                PRM_URUN_KOD:String;
                                PRM_CARI_KOD:String;
                                PRM_TIP:Byte;
                                PRM_ISN:Integer;
                                var PRM_FIYAT:Currency;
                                var PRM_DOVKOD: String;
                                var PRM_URUN_AD: String;
                                var PRM_OLCUBIRIM:String;
                                var PRM_DEPO_KOD: string;
                                var PRM_DEPO_AD: String;
                                var PRM_KDV: Byte;
                                var PRM_KDV_TUTAR:Currency;
                                var PRM_KDV_DAHIL:Byte):Boolean;
////////////////////////////////////////////////////////////////////////////////
    function PROJEHAR_AUD (Transaction: TIB_Transaction;
                           PRM_BELGE_TUR:Integer;
                           PRM_BELGE_ID:Integer;
                           PRM_BELGE_SID:Integer;
                           PRM_SIRA_NO:Byte;
                           PRM_PROJE_KOD:String;
                           PRM_TARIH:TDate;
                           PRM_FIILI_TAR:TDate;
                           PRM_DOV_BAZ_TAR:TDate;
                           PRM_VADETAR:TDate;
                           PRM_TIP:Char;
                           PRM_DOVKOD:String;
                           PRM_DOVKUR:Currency;
                           PRM_TUTAR:Currency;
                           PRM_TUTAR_VPB:Currency;
                           PRM_SIL:Byte;
                           PRM_ACIKLAMA:String;
                           ISN:Integer;
                           PRM_MASRAF_MERK,
                           PRM_KOD1,
                           PRM_KOD2,
                           PRM_KOD3,
                           PRM_KOD4:String;
                           var PRM_PROJEHAR_ID:Integer;
                           var PRM_PROJEHAR_SID:Integer):Boolean;
////////////////////////////////////////////////////////////////////////////////
    function KASAHAR_AUD(Transaction:TIB_Transaction;
                         PRM_KASA_KOD:String;
                         PRM_TARIH,
                         PRM_DOV_BAZ_TAR:TDate;
                         PRM_BELGE_TUR,
                         PRM_BELGE_ID,
                         PRM_BELGE_SID:Integer;
                         PRM_TIP:Char;
                         PRM_ACIKLAMA:String;
                         PRM_KASA_DOVKOD:String;
                         PRM_ISLEM_TIP:Byte;
                         PRM_PROJE_KOD,
                         PRM_PLASIYER_KOD:String;
                         PRM_MC:Char;
                         PRM_KARSIKOD:String;
                         PRM_SIRA_NO:Integer;
                         PRM_DOVKOD:String;
                         PRM_DOVKUR,
                         PRM_TUTAR,
                         PRM_TUTAR_VPB:Currency;
                         PRM_OLCUBIRIM:String;
                         PRM_MIKTAR:Currency;
                         PRM_MASRAF_MERK,
                         PRM_KOD1,
                         PRM_KOD2,
                         PRM_KOD3,
                         PRM_KOD4,
                         PRM_YEVMIYE_ACK:String;
                         PRM_SIL:Byte;
                         PRM_ISN:Integer;
                         var PRM_KASAHAR_ID:Integer;
                         var PRM_KASAHAR_SID:Integer):Boolean;

    function KASA_BA_AY_UPDATE(Transaction:TIB_Transaction;
                               PRM_KASA_KOD:String;
                               PRM_TARIH:TDate;
                               PRM_TUTAR_KASA_DOVKOD,
                               PRM_TUTAR_VPB:Currency;
                               PRM_GC:Char):Boolean;
////////////////////////////////////////////////////////////////////////////////
    function CARIHAR_AUD(Transaction:TIB_Transaction;
                         PRM_BELGETUR:Integer;
                         PRM_BELGE_ID:Integer;
                         PRM_BELGE_SID:Integer;
                         PRM_SIRA_NO:Byte;
                         PRM_CARI_KOD:String;
                         PRM_TIP:String;
                         PRM_TARIH:TDateTime;
                         PRM_FIILI_TAR:TDateTime;
                         PRM_DOV_BAZ_TAR:TDateTime;
                         PRM_TUTAR:Currency;
                         PRM_DOVKOD:String;
                         PRM_DOVKUR:Currency;
                         PRM_TUTAR_VPB:Currency;
                         PRM_VADETAR :TDateTime;
                         PRM_ACIKLAMA:String;
                         PRM_SIL:Byte;
                         ISN:Integer;
                         PRM_MASRAF_MERK,
                         PRM_KOD1,
                         PRM_KOD2,
                         PRM_KOD3,
                         PRM_KOD4,
                         PRM_PLASIYER_KOD,
                         PRM_PROJE_KOD:String;
                         var PRM_CARIHAR_ID:Integer;
                         var PRM_CARIHAR_SID:Integer):Boolean;

    function CARIHAR_DOV_ADDUPDATE(Transaction:TIB_Transaction;
                                   PRM_CARIHARID,PRM_CARIHAR_SID:INTEGER;
                                   PRM_DOVKOD:String;
                                   PRM_TUTAR,
                                   PRM_DOVKUR:Currency;
                                   PRM_DOV_BAZ_TAR:TDate;
                                   SenderProc:String):Boolean;

    function CARI_BA_UPDATE(Transaction:TIB_Transaction;
                            PRM_CARI_KOD:String;
                            PRM_DOV_BAZ_TAR:TDate;
                            PRM_DOVKOD:String;
                            PRM_DOVKUR,
                            PRM_TUTAR,
                            PRM_TUTAR_VPB:Currency;
                            PRM_BA:Char;
                            SenderProc:String;
                            var PRM_LIMIT_ASIMI:Boolean):Boolean;

    function CARI_DOV_ADDUPDATE(Transaction:TIB_Transaction;
                                PRM_CARI_KOD:String;
                                PRM_DOV_BAZ_TAR:TDate;
                                PRM_BA:Char;
                                PRM_DOVKOD:String;
                                PRM_DOVKUR,
                                PRM_TUTAR:Currency;
                                SenderProc:String):Boolean;

    function CARI_AY_ADDUPDATE(Transaction:TIB_Transaction;
                               PRM_CARI_KOD:String;
                               PRM_TARIH,PRM_DOV_BAZ_TAR:TDate;
                               PRM_BA:Char;
                               PRM_DOVKOD:String;
                               PRM_DOVKUR,
                               PRM_TUTAR_VPB,PRM_TUTAR:Currency;
                               SenderProc:String):Boolean;

    function MASRAF_BA_UPDATE(Transaction:TIB_Transaction;
                              PRM_MASRAF_KOD:String;
                              PRM_TUTAR_VPB:Currency;
                              PRM_BA:Char):Boolean;

    function MASRAFHAR_AUD(Transaction:TIB_Transaction;
                           PRM_BELGETUR:Integer;
                           PRM_BELGE_ID:Integer;
                           PRM_BELGE_SID:Integer;
                           PRM_SIRA_NO:Byte;
                           PRM_MASRAF_KOD:String;
                           PRM_BA:CHAR;
                           PRM_TARIH:TDateTime;
                           PRM_DOV_BAZ_TAR:TDateTime;
                           PRM_TUTAR:Currency;
                           PRM_DOVKOD:String;
                           PRM_DOVKUR:Currency;
                           PRM_TUTAR_VPB:Currency;
                           PRM_ACIKLAMA:String;
                           PRM_SIL:Byte;
                           PRM_MASRAF_MERK,
                           PRM_KOD1,
                           PRM_KOD2,
                           PRM_KOD3,
                           PRM_KOD4:String;
                           var PRM_MASRAFHAR_ID:Integer;
                           var PRM_MASRAFHAR_SID:Integer):Boolean;
////////////////////////////////////////////////////////////////////////////////

    function ARAC_BA_UPDATE(
      Transaction: TIB_Transaction;
      PRM_ARAC_KOD: String;
      PRM_TUTAR_VPB: Currency;
      PRM_BA: Char): Boolean;

    function ARACHAR_AUD(
      Transaction: TIB_Transaction;
      PRM_BELGETUR,
      PRM_BELGE_ID,
      PRM_BELGE_SID: Integer;
      PRM_SIRA_NO: Byte;
      PRM_ARAC_KOD: String;
      PRM_BA: CHAR;
      PRM_TARIH,
      PRM_DOV_BAZ_TAR: TDateTime;
      PRM_TUTAR: Currency;
      PRM_DOVKOD: String;
      PRM_DOVKUR,
      PRM_TUTAR_VPB: Currency;
      PRM_ACIKLAMA: String;
      PRM_SIL: Byte;
      PRM_MASRAF_MERK,
      PRM_KOD1,
      PRM_KOD2,
      PRM_KOD3,
      PRM_KOD4: String;
       var PRM_ARACHAR_ID,
      PRM_ARACHAR_SID: Integer): Boolean;

    function PERSONEL_BA_UPDATE(
      Transaction: TIB_Transaction;
      PRM_PERSONEL_KOD: String;
      PRM_TUTAR_VPB: Currency;
      PRM_BA: Char): Boolean;

    function PERSONELHAR_AUD(
    Transaction: TIB_Transaction;
    PRM_BELGETUR,
      PRM_BELGE_ID,
      PRM_BELGE_SID: Integer;
      PRM_SIRA_NO: Byte;
      PRM_PERSONEL_KOD: String;
      PRM_BA: CHAR;
      PRM_TARIH,
      PRM_DOV_BAZ_TAR: TDateTime;
      PRM_TUTAR: Currency;
      PRM_DOVKOD: String;
      PRM_DOVKUR,
      PRM_TUTAR_VPB: Currency;
      PRM_ACIKLAMA: String;
      PRM_SIL: Byte;
      PRM_MASRAF_MERK,
      PRM_KOD1,
      PRM_KOD2,
      PRM_KOD3,
      PRM_KOD4: String;
      var PRM_PERSONELHAR_ID,
      PRM_PERSONELHAR_SID: Integer): Boolean;

    procedure Form_Comp_Color(my_Form:TForm);
    procedure dbaMainAfterConnect(Sender: TIB_Connection);
    function SetParam(Modul_ID:Integer;ParamName:String;Value:String;Sube_ID:SmallInt):Boolean;
    procedure SET_SAYAC_NUM(SayacName:String;NewValue:Integer;Sube_ID:SmallInt);
    procedure Add_Sayaclar_Nu(SayacName:String;NewValue:Integer;Sube_ID:SmallInt);
    procedure DataModuleCreate(Sender: TObject);
    procedure Rapor_Kod_Visible_Fields(BELGE:String;MASRAF_MERK,KOD1,KOD2,KOD3,KOD4:TEDIT;MASRAF_MERK_BTN,KOD1_BTN,KOD2_BTN,KOD3_BTN,KOD4_BTN:TBUTTON;MASRAF_MERK_LBL,KOD1_LBL,KOD2_LBL,KOD3_LBL,KOD4_LBL:TLABEL);
    procedure Rapor_Kod_Visible_Fields_IB(BELGE:String;MASRAF_MERK,KOD1,KOD2,KOD3,KOD4:TIB_EDIT);
    procedure CreateQuery(Var Query:TIB_Query;Transaction:TIB_Transaction;RequestLive:Boolean;Connection:TIB_Connection);
    procedure ReleaseQuery(var Query:TIB_Query);
    procedure CreateTransaction(Var Transaction:TIB_Transaction;IsolationLevel:TIB_Isolation;Connection:TIB_Connection);
    procedure ReleaseTransaction(Var Transaction:TIB_Transaction);
    procedure CreateCursor(Var Cursor:TIB_Cursor;Transaction:TIB_Transaction;RequestLive:Boolean;Connection:TIB_Connection);
    procedure ReleaseCursor(Var Cursor:TIB_Cursor);
    procedure LoadDovizLists;
    procedure SubeADIDYukle;
    procedure FillSubeStr(strLst : TStrings);
    procedure AssignConnProps(Connection:TIB_Connection;ConnLocal:Boolean;ServerName,DB_Path,User_Name,Pass_Word:String);
////////////////////////////////////////////////////////////////////////////////
    function OLCUBIRIM_DONUSTUR(PRM_FROM_BIRIM:String;PRM_FROM_BIRIM_DEGER:Currency; PRM_TO_BIRIM:String;var PRM_BIRIM_DEGER:Currency):Boolean;
    function TestConnection(ConnLocal:Boolean;ServerName,DB_Path,User_Name,Pass_Word:String;ShowMSG:Boolean):Boolean;
    function EN_GER_KAY_TAR_KONTROL(Deger:TDateTime;MsgVer:Boolean):Boolean;
    function GetBelgeKod(BelgeTur:Integer):String;
    function GetRefTableFromBelgeTur(BelgeTur:Integer):String;
    function GetBelgeTurFromRefTable(REFERANS_TABLO:String):String;
    function GetVPB(var VPB:String):Boolean;
    function Get_Ib_RecordText(const qry: TIB_Query): String;
    function Subeli_mi:Boolean;
    function GetRapKodUyg(var Kod:String;var RapKodGor:Boolean):Boolean;
    function GetKayTarUyg(var Tarih:TDateTime):Boolean;
    function GetSubeMudahale:Integer;

    function Planlama_Urun_Sipariste_Varmi(Urun_Id: String; var qryDeg:TIB_Query): Integer;
    function Planlama_Urun_Max_Tedarik(Urun_Id: String): Integer;
    function Planlama_Urun_Min_Tedarik(Urun_Id: String): Integer;
    function Planlama_Urun_NeKadar_Var(Urun_Id: String): Double;
    function Planlama_Urun_Borc(Urun_Id: String): Double;


    function Siparis_Fat_Ayarla(Transaction:TIB_Transaction;Fatura_Id, FaturaD_ID, Siparis_Id: Integer;Toplam_Miktar: Double;Nereden:String): Integer;
    function Siparis_Fat_KaC_Adet(Fatura_Id, FaturaD_ID: Integer;Nereden:String): Integer;
    function Siparis_Bul(Fatura_Id, FaturaD_ID: Integer): Integer;
    function Siparis_Faturami(Fatura_Id:Integer): Integer;
    function Planlama_Urun_Olcu_Birim(Urun_Id: String): String;
    function Planlama_Urun_Olcu_Tip(Urun_Id: String): String;
    function Planlama_Olcu_Birim_Do_Deg(OLCU_TIP, OLCUBIRIM: String): Double;
    function Planlama_Olcu_Birim_Miktar_Hes(URUN_KOD:String;OLCUBIRIM:String;Miktar:Double): Double;


    function Onarim_Faturami(Fatura_Id: Integer): Integer;
    function Onarim_Fat_Kac_Adet(Fatura_Id, FaturaD_ID: Integer; Nereden: String): Integer;
    function Onarim_Fat_Ayarla(Transaction: TIB_Transaction; Fatura_Id, FaturaD_ID, Onarim_Id: Integer; Toplam_Miktar: Double;   Nereden: String): Integer;
    function Onarim_Kapandi_Ayarla(Transaction: TIB_Transaction; Onarim_Id,Onarim_SId: Integer): Boolean;
    function Onarim_Kapandi_AyarlaD(Transaction: TIB_Transaction; Onarim_Did: Integer): Boolean;
    function Onarim_Grup_Toplam(Transaction: TIB_Transaction; Onarim_Id,Onarim_SId: Integer; Grup: String):Double;
    function Son_Onarim_Tar_Ayarla(Transaction: TIB_Transaction;  Arac_Kod: String): Boolean;
    function Onarim_ON_MUH_ENT(SIL: Byte; Transaction: TIB_Transaction; qryFAT_IRS: TIb_Query;PRV_ISN:Integer): Boolean;
    function Onarim_Kapandi_Ba_Ayarla(Transaction: TIB_Transaction; Fat_Irs_Id: Integer): Boolean;
    function Seri_No_Kontrolu(DataSet: TIb_Query; Tablo: String; Fat_Irs,Fat_Irs_Id,Tip: Integer; Seri, Belge, Cari_Kod: String): Boolean;
    function Paket_At(Transaction: TIB_Transaction; DataSet: TIb_Query; PAKET_KOD: String; FAT_TIP, ISN: SmallInt; KDV_HESAPLA: Boolean;    Cari_Kod: String): Boolean;

    function Get_Ib_RecordTextQry(const qry: String): String;

    function Urun_Har_Ekle(Transaction: TIB_Transaction;
                           var Qry:TIb_Query;
                           PRM_URUN_KOD:String;
                           PRM_OLCUBIRIM:String;
                           PRM_DEPO_KOD:String;
                           PRM_BORC_ALACAK:String;
                           PRM_KDV_HESAPLA:Boolean;
                           PRM_BELGE_TUR:Integer;
                           PRM_BELGE_ID:Integer;
                           PRM_BELGE_SID:Integer;
                           PRM_SIRA_NO:Byte;
                           PRM_PROJE_KOD:String;
                           PRM_TARIH:TDate;
                           PRM_FIILI_TAR:TDate;
                           PRM_DOV_BAZ_TAR:TDate;
                           PRM_MIKTAR:Currency;
                           PRM_DOVKOD:String;
                           PRM_URUN_DOVKOD:String;
                           PRM_TUTAR_URUN_DOVKOD:String;
                           PRM_DOVKUR:Currency;
                           PRM_BIRIM_FIY:Currency;
                           PRM_BIRIM_FIY_VPB:Currency;
                           PRM_BIRIM_FIY_URN_DOVKOD:Currency;
                           PRM_TUTAR:Currency;
                           PRM_TUTAR_VPB:Currency;
                           PRM_KDV:Currency;
                           PRM_KDV_TUTAR:Currency;
                           PRM_SIL:Byte;
                           PRM_ACIKLAMA:String;
                           ISN:Integer;
                           PRM_MASRAF_MERK,
                           PRM_KOD1,
                           PRM_KOD2,
                           PRM_KOD3,
                           PRM_KOD4:String;
                           var PRM_URUNHAR_ID:Integer;
                           var PRM_URUNHAR_SID:Integer):Boolean;

    function Urun_Kod_Karsilastir(Kaynak_Kod, Hedef_Kod: String): Boolean;
    function Urun_Kod_Merkez_Karsilastir(Kaynak_Kod, Merkez_Kod: String): Boolean;

  private
    function Sipd_Fat_Aktarilan(SIPARISD_ID: Integer): Double;
    function Sipd_Miktari(SIPARISD_ID: Integer): Double;
    function Faturad_Miktari(Fatura_Id, FaturaD_ID: Integer): Double;
    function Kantar_ON_MUH_ENT(SIL: Byte; Transaction: TIB_Transaction;
      qry: TIb_Query; PRV_ISN: Integer): Boolean;




    { Private declarations }
  public
      function Get_Doviz_Kur_Kontrol(PRM_TARIH: TDateTime): Boolean;
    function KAY_TAR_KONTROL(Deger: TDateTime; MsgVer: Boolean): Boolean;
    procedure Kullanici_Rapor_Click(Sender: TObject);

    function Menu_Kullanni_Rapor_Ekle(Menu: TMainMenu): Boolean;

    procedure Rapor_Satir_Renklendir(Col, Row, Col_Say: Integer);

    function FN_KOD2AD(Kissas:String;my_Table_Name:String;KOD_FIELDNAME:String;NAME_FIELDNAME:String;KOD_VALUE:String;Var AD:String):Boolean;OverLoad;
    Function LS_Arac(var ARAC_KOD:String;Var PLAKA:String;var CARI_KOD:String;var PERSONEL_KOD:String;var OZ_MAL:Integer;var DORSE_KOD:String; DURUM:Byte;Kissas:String):Boolean;OverLoad;
    function LS_Sevk_Adres(var ADRES_KOD:String; var ADRES1:String; var ADRES2:String; CARI_KOD:String;CARI_SID:Integer):Boolean;Overload;

    function ALICI_BEKLEME_CARI_HAR(SIL: Byte; CARI_YON: String;
      PRV_ISN: Integer; BELGE_TUR:Integer;DataSet: TIb_Query;
      Tran: TIb_Transaction): Boolean;

    function SALICI_BEKLEME_CARI_HAR(SIL: Byte; CARI_YON: String; PRV_ISN,
      BELGE_TUR: Integer; DataSet: TIb_Query; Tran: TIb_Transaction): Boolean;

    function ALICI_CARI_HAR(SIL: Byte; CARI_YON: String; PRV_ISN: Integer;
      BELGE_TUR:Integer;DataSet: TIb_Query; Tran: TIb_Transaction): Boolean;
    function SATICI_CARI_HAR(SIL: Byte; CARI_YON: String; PRV_ISN: Integer;
      BELGE_TUR:Integer;DataSet: TIb_Query; Tran: TIb_Transaction): Boolean;
    function MAZOTCU_CARI_HAR(SIL: Byte; CARI_YON: String;
      PRV_ISN: Integer; BELGE_TUR:Integer;DataSet: TIb_Query;
      Tran: TIb_Transaction): Boolean;
    function Resim_Bul(Dosya_Adi, Tip: String): Boolean;

    function Onarim_Fatura_Ayarla(Transaction: TIB_Transaction; Onarim_Id,
      Onarim_SId: Integer; Tarihi: TDateTime; FNo: String;
      Id: Integer): Boolean;

    { Public declarations }
  end;

  function GetVersionInfo:TStringList;

var
  DataMod: TDataMod;
  glb_SID:Integer;
  KODFILLCHAR:string[1];//Kodlama iþleminde kullanýlan doldurma karakteri '0'
  glb_USER_NAME:String[15]; // SÝSTEME GÝREN KULLANICININ ADI
  glb_USER_ID:Integer; // SÝSTEME GÝREN KULLANICININ TANIMLAMA NUMARASI
  glb_USER_SID:Integer; // SÝSTEME GÝREN KULLANICININ YARATILDIÐI ÞUBE KODU
  glb_YONETICI:Boolean;
  glb_Yazi_Renk:TColor;
  glb_Art_Alan_Renk:TColor;
  glb_DEFCUR:String; //default currency code 'TRL' for Turkey
  glb_SATISKUR:SmallInt;
  glb_CALISMA_YIL  : Integer; // Çalýþma Yýlý
  glb_DOVTAKIP     : Boolean; // Firma Dövizli Takip yapýyor mu?
  glb_MUH_ENT      : Boolean; // Firma Entegre Muhasebe Kullanýyor mu ?
  glb_WINDOWS_DIR  : String; // Makinanýn  Windows Dizini
  glb_SYSTEM_DIR   : String; // Makinanýn Sistem Dizini
  glb_PLATFORM     : String; // Programýn çalýþtýðý platform
  glb_DOV_KUR_PF   : String; // Döviz kurunun formatý
  glb_DOV_FIELD_PF : String; // Döviz Para Biriminin Formatý
  glb_VPB_FIELD_PF : String; // Varsayýlan Para Biriminin Formatý

////////////////////////////////////////////////////////////////////////////////
  glb_VPB_RAP_PF : String; // Döviz Para Biriminin Formatý
  glb_DOV_RAP_PF : String; // Varsayýlan Para Biriminin Formatý
////////////////////////////////////////////////////////////////////////////////
  glb_FILES_DIR    : String; // Files Dizininin Path'i
  glb_IMAGE_DIR    : String; // Image Dizininin Path'i
  glb_SCRIPTS_DIR  : String; // Scripts Dizininin Path'i
  glb_REPORTS_DIR  : String; // Reports Dizininin Path'i
  glb_DEPO_UYG     : Boolean; // Program Depo Uygulamasý kullanýyor mu?
  glb_PROJE_UYG    : Boolean; // Program Proje Uygulamasý kullanýyor mu?
  glb_PLASIYER_UYG : Boolean; // Program Proje Uygulamasý kullanýyor mu?
  glb_DONEM_BAS    : TDate;   // Dönem baþlangýç Tarihi
  glb_DONEM_SON    : TDate;   // Dönem Bitiþ Tarihi
  glb_EN_GER_KAY_TAR : TDate; // Kayýt Girilebilecek En Eski Tarih
  glb_DOV_LIST     : TStrings;// Para Birimi Listesi ni Tutan List;
  glb_TAK_DOV_LIST : TStrings;// Takipli Para Birimi Listesi ni Tutan List;
  glb_MUAVIN_KULLAN: Boolean;
  glb_SUBELI       : Boolean; // Program þubeli çalýþýyorsa True Deðilse 0
  glb_SUBE_MUDAHALE : Boolean; //Programda comboboxlarda subelere mudahale edebilir,edemez.
  glb_Sube_ID_AD   : Array Of TSube;
  glb_SIRKET_ID    : Integer; // Çalýþýlan Þirketin Tanýmlama Numarasý
  glb_SERVER_NAME   :String;

  glb_SIRKET_ADI   : String;
  glb_IS_SIST_KULLANICI: String;
  glb_MAKINA_ADI:String;
  glb_DONEM_NO:Integer;

  glb_NAK_HIZ_URN_KOD:String;
  glb_BEK_HIZ_URN_KOD:String;
  glb_MAZ_HIZ_URN_KOD:String;
  glb_FATURA_MIK_SEF:Integer;

  glb_S_DIAG_GRUP_KOD:String;
  glb_S_ISCI_GRUP_KOD:String;
  glb_S_MAL_GRUP_KOD:String;

  glb_Db:String;
  glb_Pass:String;
  glb_User:String;
  glb_Server:String;
  glb_Con_Tip:Boolean;

  glb_KASA_KISIT_UYG : Boolean;
  glb_K_PRJ_INS : Boolean;
  glb_K_PRJ_DEL : Boolean;
  glb_K_PRJ_DEL_MSG : Boolean;

  glb_RAPOR_RENKLENDIRME:Boolean;

  glb_ARKAPLAN_RENK0:Integer;
  glb_ARKAPLAN_RENK1:Integer;
  glb_ARKAPLAN_RENK2:Integer;
  glb_RAPOR_DOLGU:TcxSSFillStyle;
  glb_Renk_Say:Integer;
  glb_RAPOR_RENK_TIPI:Integer;
  glb_Muhtelif_Kod:String;
  glb_Yazici_Is_Bildir:Boolean;


const
  BORC             = 'B';
  ALACAK           = 'A';
  GIRIS            = 'G';
  CIKIS            = 'C';
  VER_PRG_ID       =   1;
  VER_MAJOR        =   2;
  VER_MINOR        =   0;
  VER_RELEASE      = 110;
  //BELGE_TURLERI begýn
  BT_ALIS_FAT         = 1; //ALIÞ FATURASI                            ALIS FATURASI    FAT_IRS
  BT_SATIS_FAT        = 20;//SATIÞ FATURASI                           SATIS FATURASI   FAT_IRS
  BT_BORC_CEK         = 4;
  BT_BORC_SEN         = 18;//BORÇ SENET                               SENET            SENET
  BT_DEVIR_KAYDI      = 5;
  BT_MCEK_ALINDI      = 6; //M.C ALINDI KAYDI                         MUSTERI CEK      CEK
  BT_MSEN_ALINDI      = 7; //M.S. ALINDI KAYDI                        MUSTERI SENET
  BT_MCEK_CIRO        = 8; //MUSTERI CEK CIROLAMASI                   MCEK CIRO        CEKSENHAR
  BT_MSEN_CIRO        = 13;//MUSTERI SENET CIROLAMASI                 MSEN CIRO
  BT_CEK_BORDRO       = 9; //CEK BORDROSU                             CEK BORDROSU
  BT_SEN_BORDRO       = 10;//SENET BORDROSU                           SENET BORDROSU
  BT_MCEK_IADE        = 11;//MÜÞTERÝ ÇEKÝ IADE DEKONTU                MCEK IADE
  BT_MSEN_IADE        = 12;//MÜÞTERÝ SENETÝ IADE DEKONTU              MSEN IADE
  BT_PORT_CEK_KARS    = 15;//PORTFOYDE KI ÇEK KARÞILIKSIZ  DEKONTU    P CEK KARSZ      CEKSENHAR
  BT_PORT_SEN_KARS    = 16;//PORTFOYDE KI SENET KARÞILIKSIZ  DEKONTU  P SEN KARSZ      CEKSENHAR
  BT_MCEK_TAHSIL_VER  = 21;//MUSTERI CEKI TAHSILE VERME               CEK TAHSIL VER   CEKSENHAR
  BT_MSEN_TAHSIL_VER  = 22;//MUSTERI SENEDI TAHSILE VERME             SEN TAHSIL VER   CEKSENHAR
  BT_BANK_KARS_CEK    = 25;//BANKADAN GELEN KARÞILIKSIZ ÇEK           B KSIZ CEK       CEKSENHAR
  BT_BANK_PROT_SEN    = 27;//BANKADAN GELEN PROTESTOLU SENET          B PROT SENET     CEKSENHAR
  BT_SATICI_KARS_CEK  = 24;//SATICIDAN GELEN KARÞILIKSIZ ÇEK          S KSIZ CEK       CEKSENHAR
  BT_SATICI_PROT_SEN  = 26;//SATICIDAN GELEN PROTESTOLU SENET         S PROT SENET     CEKSENHAR
  BT_BANK_MCEK_TAH    = 28;//BANKADAN GELEN ÇEK TAHSÝL DEKONTU        B CEK TAH DE     CEKSENHAR
  BT_BANK_MSEN_TAH    = 32;//BANKADAN GELEN SENET TAHSÝL DEKONTU      B SEN TAH DE     CEKSENHAR
  BT_KASA_CEKSEN_TAH  = 33;//KASAYA ÇEK SENET TAHSILI                 KASA CE/SE TAH   CEKSENHAR
  BT_KASA_CEKSEN_TED  = 34;//KASADAN ÇEK SENET TEDÝYESÝ               KASA CE/SE TED   CEKSENHAR
  BT_KASA             = 14;//KASA                                     KASA
  BT_S_DEKONT         = 17;//SERBEST DEKONT                           SERBEST DEKONT   DEKONT
  BT_CARI             = 19;//CARI                                     CARI             CARI
  BT_MUH_FIS          = 23;//MUHASEBE FÝÞÝ                            MUH FIS          MUHFIS
  BT_BORC_CEK_ODE     = 29;//BORÇ ÇEKÝ ÖDEME DEKONTU                  BCEK ODEME       CEKSENHAR
  BT_BORC_CEK_IADE    = 30;//BORC CEKI IADE DEKONTU                   BCEK IADE        CEKSENHAR
  BT_BORC_SEN_IADE    = 31;//BORC SENETÝ IADE DEKONTU                 BSEN IADE        CEKSENHAR
  BT_ALIS_IRS         = 35;//ALIÞ ÝRSALÝYESÝ                          ALIS ÝRSALÝYESÝ    FAT_IRS
  BT_SATIS_IRS        = 36;//SATIÞ ÝRSLÝYESÝ                          SATIS ÝRSALÝYESÝ   FAT_IRS

  BT_MUSTERI_SIPARISI = 37;//MUSTERI_SIPARISI
  BT_SATICI_SIPARISI  = 38;//SATICI SIPARISI

  BT_URETIM           = 39;
  BT_SERBEST_URETIM   = 40;

  BT_SEFER            = 41;
  BT_MAZOT            = 42;
  BT_MAZOT_CARI       = 50;
  BT_ARAC_MASRAF       = 51;

  BT_KOMISYON_FISI       = 43; //komýsyon yukleme fiþi

  BT_ONARIM_FISI       = 60; //ONARIM FÝÞÝ

  BT_KANTAR_FISI      = 55;

  //BELGE_TURLERI END
implementation

uses ufrmSDLG,ufrmISN_ERRORS,ufrmCariSDLG, ufrmUrunSDLG, unFUNC,unLOGGER,Math,Un_Kul_con_Fb,
  ufrmRaporCiktisi, UDm_Fast_Report;

{$R *.DFM}

Procedure TDataMod.Rapor_Kod_Visible_Fields(BELGE:String;MASRAF_MERK,KOD1,KOD2,KOD3,KOD4:TEDIT;MASRAF_MERK_BTN,KOD1_BTN,KOD2_BTN,KOD3_BTN,KOD4_BTN:TBUTTON;MASRAF_MERK_LBL,KOD1_LBL,KOD2_LBL,KOD3_LBL,KOD4_LBL:TLABEL);
// Raporkodlarý kullanan formlarda ilgili sahalarýn Visiblelarýný ayarlamak için kullanýlýr.
// Proceduru Kullanýrken BELGE sahasýna.
var
  qryMUH_KOD_PARAMS:TIB_Query;
  MSG:Pchar;
begin
  try
    DataMod.CreateQuery(qryMUH_KOD_PARAMS,nil,False,DataMod.dbaMain);
    with qryMUH_KOD_PARAMS Do
    begin
      sql.Add('SELECT * FROM RAP_KOD_PARAMS WHERE BELGE = '+ SQL_Katar(BELGE));
      Open;
      if RecordCount <> 0 then
      begin
        MASRAF_MERK.Visible := (FieldByName('MASRAF_MERK').AsInteger = 1);
        KOD1.Visible := (FieldByName('KOD1').AsInteger = 1);
        KOD2.Visible := (FieldByName('KOD2').AsInteger = 1);
        KOD3.Visible := (FieldByName('KOD3').AsInteger = 1);
        KOD4.Visible := (FieldByName('KOD4').AsInteger = 1);
        /////////////////////////////////////////////////////////
        MASRAF_MERK_BTN.Visible := (FieldByName('MASRAF_MERK').AsInteger = 1);
        KOD1_BTN.Visible := (FieldByName('KOD1').AsInteger = 1);
        KOD2_BTN.Visible := (FieldByName('KOD2').AsInteger = 1);
        KOD3_BTN.Visible := (FieldByName('KOD3').AsInteger = 1);
        KOD4_BTN.Visible := (FieldByName('KOD4').AsInteger = 1);
        /////////////////////////////////////////////////////////
        MASRAF_MERK_LBL.Visible := (FieldByName('MASRAF_MERK').AsInteger = 1);
        KOD1_LBL.Visible := (FieldByName('KOD1').AsInteger = 1);
        KOD2_LBL.Visible := (FieldByName('KOD2').AsInteger = 1);
        KOD3_LBL.Visible := (FieldByName('KOD3').AsInteger = 1);
        KOD4_LBL.Visible := (FieldByName('KOD4').AsInteger = 1);
      end
      else
      begin
        MASRAF_MERK.Visible := False;
        KOD1.Visible := False;
        KOD2.Visible := False;
        KOD3.Visible := False;
        KOD4.Visible := False;
        //////////////////////////////////////////////////////////////////////
        MASRAF_MERK_BTN.Visible := False;
        KOD1_BTN.Visible := False;
        KOD2_BTN.Visible := False;
        KOD3_BTN.Visible := False;
        KOD4_BTN.Visible := False;
        //////////////////////////////////////////////////////////////////////
        MASRAF_MERK_LBL.Visible := False;
        KOD1_LBL.Visible := False;
        KOD2_LBL.Visible := False;
        KOD3_LBL.Visible := False;
        KOD4_LBL.Visible := False;
        //////////////////////////////////////////////////////////////////////
        MSG := PCHAR(BELGE + ' kodunda RAP_KOD_PARAMS tablosunda bir kayýt yok. Lütfen yazýlým destek biriminizle irtibata geçiniz.');
        Application.MessageBox(MSG,'Dikkat: Yazýlým hatasý',MB_ICONHAND);
      end;
    end;
  finally
    DataMod.ReleaseQuery(qryMUH_KOD_PARAMS);
  end;
end;


Procedure TDataMod.Rapor_Kod_Visible_Fields_IB(BELGE:String;MASRAF_MERK,KOD1,KOD2,KOD3,KOD4:TIB_EDIT);
// Raporkodlarý kullanan formlarda ilgili sahalarýn Visiblelarýný ayarlamak için kullanýlýr.
// Proceduru Kullanýrken BELGE sahasýna.
var
  qryMUH_KOD_PARAMS:TIB_Query;
  MSG:Pchar;
begin
  try
    DataMod.CreateQuery(qryMUH_KOD_PARAMS,nil,False,DataMod.dbaMain);
    with qryMUH_KOD_PARAMS Do
    begin
      sql.Add('SELECT * FROM RAP_KOD_PARAMS WHERE BELGE = '+ SQL_Katar(BELGE));
      Open;
      if RecordCount <> 0 then
      begin
        MASRAF_MERK.Visible := (FieldByName('MASRAF_MERK').AsInteger = 1);
        KOD1.Visible := (FieldByName('KOD1').AsInteger = 1);
        KOD2.Visible := (FieldByName('KOD2').AsInteger = 1);
        KOD3.Visible := (FieldByName('KOD3').AsInteger = 1);
        KOD4.Visible := (FieldByName('KOD4').AsInteger = 1);
      end
      else
      begin
        MASRAF_MERK.Visible := False;
        KOD1.Visible := False;
        KOD2.Visible := False;
        KOD3.Visible := False;
        KOD4.Visible := False;
        MSG := PCHAR(BELGE + ' kodunda RAP_KOD_PARAMS tablosunda bir kayýt yok. Lütfen yazýlým destek biriminizle irtibata geçiniz.');
        Application.MessageBox(MSG,'Dikkat: Yazýlým hatasý',MB_ICONHAND);
      end;
    end;
  finally
    DataMod.ReleaseQuery(qryMUH_KOD_PARAMS);
  end;
end;


function TDataMod.Muh_Kod_Kontrol(Kontrol_IB:TIB_Edit;Kontrol:TEdit;Alan:Byte):Boolean;
var
  qry_denetle : TIB_Query;
  ALAN_DEGER:String;
begin
  Result := False;
  try
    if Kontrol_IB <> nil then
    begin
      if Length(Trim(Kontrol_IB.Text))=0 then exit;
      ALAN_DEGER := Kontrol_IB.Text;
    end
    else
    begin
      if Length(Trim(Kontrol.Text))=0 then exit;
      ALAN_DEGER := Kontrol.Text;
    end;
    DataMod.CreateQuery(qry_denetle,nil,False,DataMod.dbaMain);
    with qry_denetle do
    begin
      Active := false;
      qry_denetle.SQL.Add('SELECT COUNT(*) AS KAYITSAY FROM RAP_KOD WHERE RAP_KOD_TIP = '+ IntToStr(ALAN) + 'AND KOD='+ SQL_Katar(ALAN_DEGER));
      Active := True;
    end;
    Result := (qry_denetle.FieldByName('KAYITSAY').AsInteger = 1);
  finally
    ReleaseQuery(qry_denetle);
  end;
end;


Function TDataMod.CARIHAR_AUD(Transaction:TIB_Transaction;
                                  PRM_BELGETUR:Integer;
                                  PRM_BELGE_ID:Integer;
                                  PRM_BELGE_SID:Integer;
                                  PRM_SIRA_NO:Byte;
                                  PRM_CARI_KOD:String;
                                  PRM_TIP:String;
                                  PRM_TARIH:TDateTime;
                                  PRM_FIILI_TAR:TDateTime;
                                  PRM_DOV_BAZ_TAR:TDateTime;
                                  PRM_TUTAR:Currency;
                                  PRM_DOVKOD:String;
                                  PRM_DOVKUR:Currency;
                                  PRM_TUTAR_VPB:Currency;
                                  PRM_VADETAR :TDateTime;
                                  PRM_ACIKLAMA:String;
                                  PRM_SIL:Byte;
                                  ISN:Integer;
                                  PRM_MASRAF_MERK,
                                  PRM_KOD1,
                                  PRM_KOD2,
                                  PRM_KOD3,
                                  PRM_KOD4,
                                  PRM_PLASIYER_KOD,
                                  PRM_PROJE_KOD:String;
                                  var PRM_CARIHAR_ID:Integer;
                                  var PRM_CARIHAR_SID:Integer):Boolean;
var
  qryCARIHAR,qryCARIHAR_DOV:TIB_Query;
  LIMIT_ASIMI:Boolean;
begin
  try
    try
      DataMod.CreateQuery(qryCARIHAR,Transaction,True,DataMod.dbaMain);
      qryCARIHAR.SQL.Add('SELECT * FROM CARIHAR WHERE BELGE_TUR = '+ IntToStr(PRM_BELGETUR) + ' AND BELGE_ID = '+ IntToStr(PRM_BELGE_ID) + ' AND BELGE_SID = ' + IntToStr(PRM_BELGE_SID) + ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO));
      qryCARIHAR.Open;

      if qryCARIHAR.RecordCount > 0 then
      begin
        Result := CARI_BA_UPDATE(Transaction,
                                qryCARIHAR.FieldByName('CARI_KOD').AsString,
                                qryCARIHAR.FieldByName('DOV_BAZ_TAR').AsDate,
                                qryCARIHAR.FieldByName('DOVKOD').AsString,
                                qryCARIHAR.FieldByName('DOVKUR').AsCurrency,
                                -qryCARIHAR.FieldByName('TUTAR').AsCurrency,
                                -qryCARIHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                qryCARIHAR.FieldByName('TIP').AsString[1],
                                'TDataMod.SPP_CARIHAR_AUD:',
                                LIMIT_ASIMI);
        if not Result then Exit;
        Result :=  CARI_AY_ADDUPDATE(Transaction,
                                    qryCARIHAR.FieldByName('CARI_KOD').AsString,
                                    qryCARIHAR.FieldByName('TARIH').AsDate,
                                    qryCARIHAR.FieldByName('DOV_BAZ_TAR').AsDate,
                                    qryCARIHAR.FieldByName('TIP').AsString[1],
                                    qryCARIHAR.FieldByName('DOVKOD').AsString,
                                    qryCARIHAR.FieldByName('DOVKUR').AsCurrency,
                                    -qryCARIHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                    -qryCARIHAR.FieldByName('TUTAR').AsCurrency,
                                    'TDataMod.SPP_CARIHAR_AUD:');
        if not Result then Exit;

        DataMod.CreateQuery(qryCARIHAR_DOV,Transaction,False,DataMod.dbaMain);
        qryCARIHAR_DOV.SQL.Add('DELETE FROM CARIHAR_DOV WHERE CARIHAR_ID = ' + qryCARIHAR.FieldbyName('CARIHAR_ID').AsString + ' AND CARIHAR_SID = ' + qryCARIHAR.FieldbyName('CARIHAR_SID').AsString);
        qryCARIHAR_DOV.Execute;


        if PRM_SIL <> 1 then // SILME ÝÞLEMÝ
        begin
          qryCARIHAR.Edit
        end
        else
        begin
          PRM_CARIHAR_ID := qryCARIHAR.FieldByName('CARIHAR_ID').AsInteger;
          PRM_CARIHAR_SID := qryCARIHAR.FieldByName('CARIHAR_SID').AsInteger;
          qryCARIHAR.Delete; // SILME ÝÞLEMÝnin fiilen olduu yer.
          Result := True;
          Exit;
        end;
      end
      else
      begin
        if PRM_SIL = 1 then
        begin
          Result := True;
          PRM_CARIHAR_ID := 0;
          PRM_CARIHAR_SID := 0;
          Exit;
        end;
        qryCARIHAR.Insert;
        qryCARIHAR.FieldByName('CARIHAR_ID').AsInteger := qryCARIHAR.Gen_ID('GEN_CARIHAR',1);
        qryCARIHAR.FieldByName('CARIHAR_SID').AsInteger := glb_SID;
      end;

      if Trim(PRM_CARI_KOD)='' then
      begin
            qryCARIHAR.Cancel;
            Result := True;
            Exit;
      end;

      PRM_CARIHAR_ID := qryCARIHAR.FieldByName('CARIHAR_ID').AsInteger;
      PRM_CARIHAR_SID := qryCARIHAR.FieldByName('CARIHAR_SID').AsInteger;
      qryCARIHAR.FieldByName('CARI_KOD').AsString := Trim(PRM_CARI_KOD);
      qryCARIHAR.FieldByName('TIP').AsString := PRM_TIP[1];
      qryCARIHAR.FieldByName('BELGE_TUR').AsInteger := PRM_BELGETUR;
      qryCARIHAR.FieldByName('BELGE_ID').AsInteger := PRM_BELGE_ID;
      qryCARIHAR.FieldByName('BELGE_SID').AsInteger := PRM_BELGE_SID;
      qryCARIHAR.FieldByName('SIRA_NO').AsInteger := PRM_SIRA_NO;
      qryCARIHAR.FieldByName('TARIH').AsDate := PRM_TARIH;
      qryCARIHAR.FieldByName('FIILI_TAR').AsDate := PRM_FIILI_TAR;
      qryCARIHAR.FieldByName('DOV_BAZ_TAR').AsDate := PRM_DOV_BAZ_TAR;
      qryCARIHAR.FieldByName('VADETAR').AsDate := PRM_VADETAR;
      qryCARIHAR.FieldByName('DOVKOD').AsString := Trim(PRM_DOVKOD);
      qryCARIHAR.FieldByName('DOVKUR').AsCurrency := PRM_DOVKUR;
      qryCARIHAR.FieldByName('TUTAR').AsCurrency := PRM_TUTAR;
      qryCARIHAR.FieldByName('TUTAR_VPB').AsCurrency := PRM_TUTAR_VPB;
      qryCARIHAR.FieldByName('ACIKLAMA').AsString := Trim(PRM_ACIKLAMA);
      qryCARIHAR.FieldByName('MASRAF_MERK').AsString := Trim(PRM_MASRAF_MERK);
      qryCARIHAR.FieldByName('KOD1').AsString := Trim(PRM_KOD1);
      qryCARIHAR.FieldByName('KOD2').AsString := Trim(PRM_KOD2);
      qryCARIHAR.FieldByName('KOD3').AsString := Trim(PRM_KOD3);
      qryCARIHAR.FieldByName('KOD4').AsString := Trim(PRM_KOD4);
      qryCARIHAR.FieldByName('PLASIYER_KOD').AsString := Trim(PRM_PLASIYER_KOD);
      qryCARIHAR.FieldByName('PROJE_KOD').AsString := Trim(PRM_PROJE_KOD);
      qryCARIHAR.Post;
  ////////////////////////////////////////////////////////////////////////////////
     Result := CARI_BA_UPDATE(Transaction,Trim(PRM_CARI_KOD),PRM_DOV_BAZ_TAR,Trim(PRM_DOVKOD),PRM_DOVKUR,PRM_TUTAR,PRM_TUTAR_VPB,PRM_TIP[1],'TDataMod.SPP_CARIHAR_AUD:',LIMIT_ASIMI);
     if not Result then Exit;
     if (TRIM(DataMod.GetParam(2,'LIMIT_ASIM_UYAR',0))= '1') and LIMIT_ASIMI then
     begin
       if Application.MessageBox('Dikkat Carinin Risk limiti aþýldý yine de devam etmek istiyor musunuz?','Dikkat',MB_YESNO+MB_ICONSTOP)= IDNO then
       begin
         PRM_CARIHAR_ID := 0;
         PRM_CARIHAR_SID := 0;
         Result := False;
         Exit;
       end;
     end;
     Result := CARIHAR_DOV_ADDUPDATE(Transaction,PRM_CARIHAR_ID,PRM_CARIHAR_SID,Trim(PRM_DOVKOD),PRM_TUTAR,PRM_DOVKUR,PRM_DOV_BAZ_TAR,'TDataMod.SPP_CARIHAR_AUD:');
     if not Result then Exit;
     Result :=  CARI_AY_ADDUPDATE(Transaction,
                                  PRM_CARI_KOD,
                                  PRM_TARIH,
                                  PRM_DOV_BAZ_TAR,
                                  PRM_TIP[1],
                                  PRM_DOVKOD,
                                  PRM_DOVKUR,
                                  PRM_TUTAR_VPB,
                                  PRM_TUTAR,
                                  'TDataMod.SPP_CARIHAR_AUD:');
     if not Result then Exit;
     Result := True;

    except
      PRM_CARIHAR_ID := 0;
      PRM_CARIHAR_SID := 0;
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARIHAR);
    DataMod.ReleaseQuery(qryCARIHAR_DOV);
  end;
end;

Function TDataMod.KASAHAR_AUD(Transaction:TIB_Transaction;
                                  PRM_KASA_KOD:String;
                                  PRM_TARIH,
                                  PRM_DOV_BAZ_TAR:TDate;
                                  PRM_BELGE_TUR,
                                  PRM_BELGE_ID,
                                  PRM_BELGE_SID:Integer;
                                  PRM_TIP:Char;
                                  PRM_ACIKLAMA:String;
                                  PRM_KASA_DOVKOD:String;
                                  PRM_ISLEM_TIP:Byte;
                                  PRM_PROJE_KOD,
                                  PRM_PLASIYER_KOD:String;
                                  PRM_MC:Char;
                                  PRM_KARSIKOD:String;
                                  PRM_SIRA_NO:Integer;
                                  PRM_DOVKOD:String;
                                  PRM_DOVKUR,
                                  PRM_TUTAR,
                                  PRM_TUTAR_VPB:Currency;
                                  PRM_OLCUBIRIM:String;
                                  PRM_MIKTAR:Currency;
                                  PRM_MASRAF_MERK,
                                  PRM_KOD1,
                                  PRM_KOD2,
                                  PRM_KOD3,
                                  PRM_KOD4,
                                  PRM_YEVMIYE_ACK:String;
                                  PRM_SIL:Byte;
                                  PRM_ISN:Integer;
                                  var PRM_KASAHAR_ID:Integer;
                                  var PRM_KASAHAR_SID:Integer):Boolean;
var
  qryKASAHAR:TIB_Query;
  var_KASADEGER:Currency;
begin
  try
    try
      if not DataMod.KurluDonustur(PRM_DOV_BAZ_TAR,Trim(PRM_DOVKOD),PRM_DOVKUR,Trim(PRM_KASA_DOVKOD),PRM_TUTAR,glb_SATISKUR,True,var_KASADEGER) then
      begin
        Application.MessageBox('TDataMod.SPP_KASAHAR_AUD: Kasadeðer Kur dönüþümü yapýlamadýðý için KasaHareket kaydý yapýlamýyor.','Dikkat',MB_ICONERROR);
        Result := False;
        Exit;
      end;

      DataMod.CreateQuery(qryKASAHAR,Transaction,True,DataMod.dbaMain);
      with qryKASAHAR do
      begin
        sql.Add('SELECT * FROM KASAHAR WHERE BELGE_TUR = '+ IntToStr(PRM_BELGE_TUR)+ ' AND BELGE_ID = '+ IntToStr(PRM_BELGE_ID) + ' AND BELGE_SID = ' + IntToStr(PRM_BELGE_SID)+ ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO));
        Active := True;
        if RecordCount > 0 then
        begin
          { if PRM_SIRA_NO <> 0 then
           begin
             Result := KASA_BA_AY_UPDATE(Transaction,
                                         FieldByName('KASA_KOD').AsString,
                                         FieldByName('TARIH').AsDate,
                                         -FieldByName('KASADEGER').AsCurrency,
                                         -FieldByName('TUTAR_VPB').AsCurrency,
                                         FieldByName('TIP').AsString[1]);
             if not Result then Exit;
           end;}
           if PRM_SIL <> 1 then // SILME ÝÞLEMÝ
           begin
             qryKASAHAR.Edit;
           end
           else
           begin
             PRM_KASAHAR_ID := FieldByName('KASAHAR_ID').AsInteger;
             PRM_KASAHAR_SID := FieldByName('KASAHAR_SID').AsInteger;
             qryKASAHAR.Delete; // SILME ÝÞLEMÝnin fiilen olduu yer.
             Result := True;
             Exit;
           end;
        end
        else //if RecordCount > 0 then
        begin // KAYIT YOK
          if PRM_SIL = 1 then
          begin
            Result := True;
            PRM_KASAHAR_ID := 0;
            PRM_KASAHAR_SID := 0;
            Exit;
          end;
          Insert;
          FieldByName('KASAHAR_ID').AsInteger := qryKASAHAR.Gen_ID('GEN_KASAHAR',1);
          FieldByName('KASAHAR_SID').AsInteger := glb_SID;
        end;
          FieldByName('KASA_KOD').AsString := Trim(PRM_KASA_KOD);
          FieldByName('TARIH').AsDate := PRM_TARIH;
          FieldByName('DOV_BAZ_TAR').AsDate := PRM_DOV_BAZ_TAR;
          FieldByName('BELGE_TUR').AsInteger := PRM_BELGE_TUR;
          FieldByName('BELGE_ID').AsInteger := PRM_BELGE_ID;
          FieldByName('BELGE_SID').AsInteger := PRM_BELGE_SID;
          FieldByName('TIP').AsString := PRM_TIP;
          FieldByName('ACIKLAMA').AsString := PRM_ACIKLAMA;
          FieldByName('KASADEGER').AsCurrency := var_KASADEGER;
          FieldByName('ISLEM_TIP').AsInteger := PRM_ISLEM_TIP;
          FieldByName('PROJE_KOD').AsString :=  Trim(PRM_PROJE_KOD);
          FieldByName('PLASIYER_KOD').AsString :=  Trim(PRM_PLASIYER_KOD);
          FieldByName('MC').AsString := PRM_MC;
          FieldByName('KARSIKOD').AsString :=  Trim(PRM_KARSIKOD);
          FieldByName('SIRA_NO').AsInteger := PRM_SIRA_NO;
          FieldByName('DOVKOD').AsString := Trim(PRM_DOVKOD);
          FieldByName('DOVKUR').AsCurrency := PRM_DOVKUR;
          FieldByName('TUTAR').AsCurrency := PRM_TUTAR;
          FieldByName('TUTAR_VPB').AsCurrency := PRM_TUTAR;
          FieldByName('OLCUBIRIM').AsString := TRIM(PRM_OLCUBIRIM);
          FieldByName('MIKTAR').AsCurrency := PRM_MIKTAR;
          FieldByName('MASRAF_MERK').AsString := Trim(PRM_MASRAF_MERK);
          FieldByName('KOD1').AsString := Trim(PRM_KOD1);
          FieldByName('KOD2').AsString := Trim(PRM_KOD2);
          FieldByName('KOD3').AsString := Trim(PRM_KOD3);
          FieldByName('KOD4').AsString := Trim(PRM_KOD4);
          FieldByName('YEVMIYE_ACK').AsString := Trim(PRM_YEVMIYE_ACK);
          Post;
          PRM_KASAHAR_ID := FieldByName('KASAHAR_ID').AsInteger;
          PRM_KASAHAR_SID := FieldByName('KASAHAR_SID').AsInteger;
          { if PRM_SIRA_NO <> 0 then
           begin
             Result := KASA_BA_AY_UPDATE(Transaction,
                                         PRM_KASA_KOD,
                                         PRM_TARIH,
                                         var_KASADEGER,
                                         PRM_TUTAR_VPB,
                                         PRM_TIP);
            if not Result then Exit;
          end;}
      end; // with qryKASAHAR
      Result := True;
    except
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryKASAHAR);
  end;
end;



function TDataMod.LS_Depo(var DEPO_KOD:String;Var DEPO_AD:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('DEPO_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('ADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Depo Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT DEPO_KOD,ADI  FROM DEPO','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     DEPO_KOD := Kolonlar.Strings[0];
     DEPO_AD := Kolonlar.Strings[1];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;





Function TDataMod.LS_MARKA(var MARKA:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('MARKA_KOD');
  Kolonlar.Add('Araç Markasý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Marka  Listesi';
  frmSrcDlg.List( 1 , Kolonlar ,'SELECT MARKA_KOD FROM SRV_ARAC_MARKA','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    MARKA := Kolonlar.Strings[0];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

Function TDataMod.LS_MARKA_TIP(MARKA:String; var MARKA_TIP:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
{  Kolonlar.Add('MARKA_KOD');
  Kolonlar.Add('Araç Marka');
  Kolonlar.Add('100');}
  Kolonlar.Add('MARKA_TIP_KOD');
  Kolonlar.Add('Araç Marka Tipleri');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Marka Tipleri Listesi';
  frmSrcDlg.List( 1 , Kolonlar ,'SELECT MARKA_TIP_SID, MARKA_KOD , MARKA_TIP_KOD FROM SRV_ARAC_MARKA_TIP WHERE MARKA_KOD='+Sql_Katar(MARKA),'',1,2);
  //frmSrcDlg.List( 2 , Kolonlar ,'SELECT MARKA_KOD,MARKA_TIP_KOD FROM SRV_ARAC_MARKA_TIP WHERE MARKA_KOD='+Sql_Katar(MARKA),'',2,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    //MARKA_TIP := Kolonlar.Strings[1];
    MARKA_TIP := Kolonlar.Strings[2];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


function TDataMod.LS_Bayi(var BAYI_KOD:String;Var BAYI_AD:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('BAYI_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('BAYI_ADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Bayi Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT BAYI_KOD,BAYI_ADI  FROM SRV_ARAC_BAYI','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     BAYI_KOD := Kolonlar.Strings[0];
     BAYI_AD := Kolonlar.Strings[1];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

function TDataMod.LS_Gelis_Nedeni(var NEDEN_KOD:String;Var ACIKLAMA:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('NEDEN_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('ACIKLAMA');
  Kolonlar.Add('Açýklama');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Geliþ Nedeni Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT NEDEN_KOD,ACIKLAMA FROM SRV_GELIS_NEDENI','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     NEDEN_KOD := Kolonlar.Strings[0];
     ACIKLAMA := Kolonlar.Strings[1];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


function TDataMod.LS_Ariza(var ARIZA_KOD:String;Var ARIZA_AD:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('ARIZA_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('ACIKLAMA');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Bayi Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT ARIZA_KOD,ACIKLAMA  FROM SRV_ARIZA_TIP','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     ARIZA_KOD := Kolonlar.Strings[0];
     ARIZA_AD := Kolonlar.Strings[1];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


function TDataMod.LS_Sigorta(var SIGORTA_KOD:String;Var SIGORTA_AD:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('SIGORTA_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('ADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Sigorta Þirketleri Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT SIGORTA_KOD,ADI  FROM SRV_ARAC_SIGORTA','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     SIGORTA_KOD := Kolonlar.Strings[0];
     SIGORTA_AD := Kolonlar.Strings[1];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


function TDataMod.LS_Komisyon(var Id:Integer):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('DEPO_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('ADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Depo Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT DEPO_KOD,ADI  FROM DEPO','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
{     DEPO_KOD := Kolonlar.Strings[0];
     DEPO_AD := Kolonlar.Strings[1];
     }
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


function TDataMod.LS_Paket(var PAKET_KOD:String; Var PAKET_AD:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('PAKET_SID');
  Kolonlar.Add('PAKET_SID');
  Kolonlar.Add('0');
  Kolonlar.Add('PAKET_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('PAKET_AD');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Paket Listesi';
  frmSrcDlg.List( 3 , Kolonlar ,'SELECT PAKET_SID,PAKET_KOD,PAKET_ADI FROM PAKET','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     PAKET_KOD := Kolonlar.Strings[1];
     PAKET_AD := Kolonlar.Strings[2];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


function TDataMod.LS_Sevk_Adres(var ADRES_KOD:String; CARI_KOD:String;CARI_SID:Integer):Boolean;
var
  Kolonlar : TStringList;
  sqlwe:String;
begin
  sqlwe:=
  ' WHERE CARI_KOD='+SQL_Katar(CARI_KOD)+ ' and CARI_SID='+Inttostr(CARI_SID);
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('CARI_SEVK_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('ADRES_1');
  Kolonlar.Add('Adres1');
  Kolonlar.Add('150');
  Kolonlar.Add('ADRES_2');
  Kolonlar.Add('Adres2');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Sevk Adresi Listesi';
  frmSrcDlg.List( 3 , Kolonlar ,'SELECT CARI_SEVK_KOD, ADRES_1, ADRES_2 FROM CARI_SEVKAD '
  ,sqlwe,1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     ADRES_KOD := Kolonlar.Strings[0];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

function TDataMod.LS_Sevk_Adres(var ADRES_KOD:String; var ADRES1:String; var ADRES2:String; CARI_KOD:String;CARI_SID:Integer):Boolean;
var
  Kolonlar : TStringList;
  sqlwe:String;
begin
  sqlwe:=
  ' WHERE CARI_KOD='+SQL_Katar(CARI_KOD)+ ' and CARI_SID='+Inttostr(CARI_SID);
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('CARI_SEVK_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('ADRES_1');
  Kolonlar.Add('Adres1');
  Kolonlar.Add('150');
  Kolonlar.Add('ADRES_2');
  Kolonlar.Add('Adres2');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Sevk Adresi Listesi';
  frmSrcDlg.List( 3 , Kolonlar ,'SELECT CARI_SEVK_KOD, ADRES_1, ADRES_2 FROM CARI_SEVKAD '
  ,sqlwe,1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     ADRES_KOD := Kolonlar.Strings[0];
     ADRES1:=Kolonlar.Strings[1];
     ADRES2:=Kolonlar.Strings[2];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


function TDataMod.LS_MUH_KOD(TIP: SmallInt; var MUH_KOD,  ACIKLAMA: String): Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('KOD');
  Kolonlar.Add('Kod');
  Kolonlar.Add('150');
  Kolonlar.Add('ACIKLAMA');
  Kolonlar.Add('Acýklama');
  Kolonlar.Add('250');
  frmSrcDlg.Caption := 'Muhasebe Kodu Listesi';
  frmSrcDlg.List( 1 , Kolonlar ,'SELECT RAP_KOD_TIP,KOD,ACIKLAMA FROM RAP_KOD WHERE RAP_KOD_TIP=' + IntTostr(TIP) ,'',1,1);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    MUH_KOD := Kolonlar.Strings[1];
    ACIKLAMA := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

function TDataMod.LS_Siparis(var FAT_IRS_SEP:Integer;var FAT_IRS_SID:Integer;Var FAT_IRS_ID:Integer; var SERI_BELGE:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('FAT_IRS_ID');
  Kolonlar.Add('Ýrsaliye Id');
  Kolonlar.Add('30');
  Kolonlar.Add('FAT_IRS_SID');
  Kolonlar.Add('Ýrsaliye sId');
  Kolonlar.Add('30');
  Kolonlar.Add('FAT_IRS_SERI');
  Kolonlar.Add('Seri');
  Kolonlar.Add('100');
  Kolonlar.Add('BELGE_NO');
  Kolonlar.Add('Belge no');
  Kolonlar.Add('100');
  frmSrcDlg.Caption := 'Sipariþ Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT FAT_IRS_SEP,FAT_IRS_SID,FAT_IRS_ID,FAT_IRS_SERI,BELGE_NO FROM SIPARIS','',1,1);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     FAT_IRS_SEP := StrToInt(Kolonlar.Strings[0]);
     FAT_IRS_SID := StrToInt(Kolonlar.Strings[1]);
     FAT_IRS_ID := StrToInt(Kolonlar.Strings[2]);
     SERI_BELGE:= Kolonlar.Strings[3]+' '+ Kolonlar.Strings[4];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


function TDataMod.LS_DEKONT_AUT(var ID,SID: Integer): Boolean;
var
  Kolonlar : TStringList;
begin
// Eser SAHIN 13/06/2005
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('DEKONT_AUT_NAME');
  Kolonlar.Add('Adý');
  Kolonlar.Add('250');
  Kolonlar.Add('ACIKLAMA');
  Kolonlar.Add('Açýklama');
  Kolonlar.Add('100');
  Kolonlar.Add('DEKONT_ID');
  Kolonlar.Add('Sýra No');
  Kolonlar.Add('75');
  Kolonlar.Add('DEKONT_SID');
  Kolonlar.Add('Þube No');
  Kolonlar.Add('75');
  frmSrcDlg.Caption := 'Masraf Tanýmlama Listesi';
  frmSrcDlg.List(2, Kolonlar ,'SELECT DEKONT_ID,DEKONT_SID,DEKONT_AUT_NAME,ACIKLAMA FROM DEKONT_AUT','',0,2);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    ID := StrToInt(Kolonlar.Strings[0]);
    SID := StrToInt(Kolonlar.Strings[1]);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
  Kolonlar.Free;
end;

Function TDataMod.LS_Plasiyer(var Plasiyer_KOD:String;Var Plasiyer_AD:String;DURUM:Byte):Boolean;
var
  Kolonlar : TStringList;
  strDURUM : String;
begin
  // DURUM 0 : Tüm Plasiyerler
  // DURUM 1 : Aktif Plasiyerler
  // DURUM 2 : Pasif Plasiyerler
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('ADISOY');
  Kolonlar.Add('Adý');
  Kolonlar.Add('250');
  case DURUM of
  0:
    begin
      frmSrcDlg.Caption := 'Plasiyer Listesi [Tüm Plasiyerler] ';
      strDURUM := ''
    end;
  1:
    begin
      frmSrcDlg.Caption := 'Plasiyer Listesi [Aktif Plasiyerler] ';
      strDURUM := ' WHERE PASIF = 0'
    end;
  2:
    begin
      frmSrcDlg.Caption := 'Plasiyer Listesi [Pasif Plasiyerler] ';
      strDURUM := ' WHERE PASIF = 1'
    end;
  end;
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT PLASIYER_KOD, ADISOY FROM PLASIYER',strDURUM,1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    Plasiyer_KOD := Kolonlar.Strings[0];
    Plasiyer_AD := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;



Function TDataMod.LS_Arac(var ARAC_KOD:String;Var PLAKA:String;DURUM:Byte):Boolean;
var
  Kolonlar : TStringList;
  strDURUM : String;
begin
  // DURUM 0 : Aktif
  // DURUM 1 : Aktif deði
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('ARAC_KOD');
  Kolonlar.Add('Araç Kodu');
  Kolonlar.Add('200');
  Kolonlar.Add('PLAKA');
  Kolonlar.Add('Plaka');
  Kolonlar.Add('200');
  strDURUM := '';
  {case DURUM of
  0:
    begin
      frmSrcDlg.Caption := 'Araç Listesi [Tüm Araçlar] ';
      strDURUM := ''
    end;
  1:
    begin
      frmSrcDlg.Caption := 'Araç Listesi [Aktif Olmayanlar] ';
      strDURUM := ' WHERE AKTIF_DEGIL = 1'
    end;

  end;
  }
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT ARAC_KOD, PLAKA FROM ARAC',strDURUM,1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    ARAC_KOD := Kolonlar.Strings[0];
    PLAKA := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


Function TDataMod.LS_Arac(var ARAC_KOD:String;Var PLAKA:String;var CARI_KOD:String;var PERSONEL_KOD:String;var OZ_MAL:Integer;var DORSE_KOD:String;DURUM:Byte;Kissas:String):Boolean;
var
  Kolonlar : TStringList;
  strDURUM,Sql : String;
begin
  // DURUM 0 : Aktif
  // DURUM 1 : Aktif deði
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('ARAC.PLAKA');
  Kolonlar.Add('Plaka');
  Kolonlar.Add('100');
  Kolonlar.Add('ARAC.CARI_KOD');
  Kolonlar.Add('Cari Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('CARI.CARI_AD');
  Kolonlar.Add('Cari Adý');
  Kolonlar.Add('200');
  strDURUM :=  ' WHERE ';
  case DURUM of
  0:
    begin
      frmSrcDlg.Caption := 'Araç Listesi [Tüm Araçlar] ';
      strDURUM := strDURUM+ ' ARAC_KOD<>'''' ';
    end;
  1:
    begin
      frmSrcDlg.Caption := 'Araç Listesi [Aktif Olmayanlar] ';
      strDURUM := strDURUM+' AKTIF_DEGIL = 1 ';
    end;
  end;
  strDURUM := strDURUM+Kissas;

{Sql:='SELECT ARAC_KOD '+
     ' , PLAKA'+
     ' , OZ_MAL'+
     ' , CARI_KOD'+
     ' ,(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KOD) AS CARI_ADI'+
     ' , PERSONEL_KOD'+
     ' ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=ARAC.PERSONEL_KOD) AS PERSONEL_ADI'+
     ' ,DORSE_KOD '+
     ' FROM ARAC';
}
   Sql:='SELECT '+
     '   ARAC.ARAC_KOD '+
     ' , ARAC.PERSONEL_KOD'+
     ' , PERSONEL.ADI_SOYADI AS PERSONEL_ADI'+
     ' , ARAC.DORSE_KOD '+
     ' , ARAC.OZ_MAL'+
     ' , ARAC.PLAKA'+
     ' , ARAC.CARI_KOD'+
     ' , CARI.CARI_AD  AS CARI_ADI'+
     ' FROM ARAC'+
     ' LEFT OUTER JOIN CARI ON (ARAC.CARI_KOD=CARI.CARI_KOD) '+
     ' LEFT OUTER JOIN PERSONEL ON (PERSONEL.PERSONEL_KOD=ARAC.PERSONEL_KOD) ';

  frmSrcDlg.List(3, Kolonlar ,Sql,strDURUM,0,5);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    PERSONEL_KOD := Kolonlar.Strings[1];
    DORSE_KOD:= Kolonlar.Strings[3];
    OZ_MAL := StrToInt(Kolonlar.Strings[4]);
    PLAKA := Kolonlar.Strings[5];
    CARI_KOD := Kolonlar.Strings[6];
    ARAC_KOD := Kolonlar.Strings[0];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;



Function TDataMod.LS_Arac_Srv(var ARAC_KOD:String;Var PLAKA:String;var CARI_KOD:String;var SASI_NO:String;var MARKA_TIP:String;Kissas:String):Boolean;
var
  Kolonlar : TStringList;
  strDURUM,Sql : String;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('SRV_ARAC.ARAC_KOD');
  Kolonlar.Add('Araç Kodu');
  Kolonlar.Add('100');

  Kolonlar.Add('SRV_ARAC.PLAKA');
  Kolonlar.Add('Plaka');
  Kolonlar.Add('100');
  Kolonlar.Add('SRV_ARAC.CARI_KOD');
  Kolonlar.Add('Cari Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('CARI.CARI_AD');
  Kolonlar.Add('Cari Adý');
  Kolonlar.Add('200');
  strDURUM :=  ' WHERE SRV_ARAC.ARAC_KOD<>'''' ';
  strDURUM := strDURUM+Kissas;
  Sql:='SELECT '+
     '   SRV_ARAC.ARAC_KOD '+
     ' , SRV_ARAC.PLAKA'+
     ' , SRV_ARAC.CARI_KOD'+
     ' , CARI.CARI_AD AS CARI_ADI'+
     ' FROM SRV_ARAC'+
     ' LEFT OUTER JOIN CARI ON (SRV_ARAC.CARI_KOD=CARI.CARI_KOD) ';
  frmSrcDlg.List(3, Kolonlar ,Sql,strDURUM,0,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    PLAKA := Kolonlar.Strings[1];
    CARI_KOD := Kolonlar.Strings[2];
    ARAC_KOD := Kolonlar.Strings[0];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

Function TDataMod.LS_Personel(var Personel_KOD:String;Var Personel_AD:String):Boolean;
var
  Kolonlar : TStringList;
  strDURUM : String;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('PERSONEL_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('150');
  Kolonlar.Add('ADI_SOYADI');
  Kolonlar.Add('Adý Soyadý');
  Kolonlar.Add('250');
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT PERSONEL_KOD, ADI_SOYADI FROM PERSONEL','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    Personel_KOD := Kolonlar.Strings[0];
    Personel_AD := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


Function TDataMod.LS_Esya(var Esya_Id:Integer;Var Esya_AD:String):Boolean;
var
  Kolonlar : TStringList;
  strDURUM : String;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('ESYA_ID');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('150');
  Kolonlar.Add('ESYA_AD');
  Kolonlar.Add('Eþya Adý ');
  Kolonlar.Add('250');
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT ESYA_ID, ESYA_AD FROM ESYA','',0,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    Esya_Id := StrToInt(Kolonlar.Strings[0]);
    Esya_AD := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


Function TDataMod.LS_Sofor(var Sofor_KOD:String; Var Sofor_AD:String):Boolean;
var
  Kolonlar : TStringList;
  strDURUM : String;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('SOFOR_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('150');
  Kolonlar.Add('ADI_SOYADI');
  Kolonlar.Add('Adý Soyadý');
  Kolonlar.Add('250');
  Kolonlar.Add('VERGI_DAIRE');
  Kolonlar.Add('Vegi Dairesi');
  Kolonlar.Add('150');
  Kolonlar.Add('VERGI_NO');
  Kolonlar.Add('Vergi Daire No');
  Kolonlar.Add('150');
  Kolonlar.Add('EHLIYET_NO');
  Kolonlar.Add('Ehliyet No');
  Kolonlar.Add('150');
  Kolonlar.Add('ACIKLAMA');
  Kolonlar.Add('Açýklama');
  Kolonlar.Add('250');
  Kolonlar.Add('KARA_LISTE');
  Kolonlar.Add('Kara Liste');
  Kolonlar.Add('50');
  frmSrcDlg.List( 7, Kolonlar ,'SELECT SOFOR_KOD, ADI_SOYADI,VERGI_DAIRE,VERGI_NO,EHLIYET_NO,ACIKLAMA,KARA_LISTE FROM SOFOR','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    Sofor_KOD := Kolonlar.Strings[0];
    Sofor_AD := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

Function TDataMod.FN_KOD2AD(my_Table_Name:String;KOD_FIELDNAME:String;NAME_FIELDNAME:String;KOD_VALUE:String;Var AD:String):Boolean;
var
  qryTEMP:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryTEMP,nil,False,DataMod.dbaMain);
      qryTEMP.SQL.Add('SELECT '+ NAME_FIELDNAME + ' FROM ' + my_Table_Name + ' WHERE ' + KOD_FIELDNAME + '=' + SQL_Katar(KOD_VALUE));
      qryTEMP.Active := True;
      if not (qryTEMP.RecordCount = 0) Then
      begin
        AD:= qryTEMP.FieldByName(NAME_FIELDNAME).AsString;
        Result := True;
      end
      else
      begin
        AD:='';
        Result := False;
      end;
    except
      AD:='';
      Result := False;
      raise;
    end;
  finally
    DataMod.ReleaseQuery(qryTEMP);
  end;
end;

Function TDataMod.FN_KOD2AD(Kissas:String;my_Table_Name:String;KOD_FIELDNAME:String;NAME_FIELDNAME:String;KOD_VALUE:String;Var AD:String):Boolean;
var
  qryTEMP:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryTEMP,nil,False,DataMod.dbaMain);
      qryTEMP.SQL.Add('SELECT '+ NAME_FIELDNAME + ' FROM ' + my_Table_Name + ' WHERE ' + KOD_FIELDNAME + '=' + SQL_Katar(KOD_VALUE)+ Kissas);
      qryTEMP.Active := True;
      if not (qryTEMP.RecordCount = 0) Then
      begin
        AD:= qryTEMP.FieldByName(NAME_FIELDNAME).AsString;
        Result := True;
      end
      else
      begin
        AD:='';
        Result := False;
      end;
    except
      AD:='';
      Result := False;
      raise;
    end;
  finally
    DataMod.ReleaseQuery(qryTEMP);
  end;
end;



procedure TDataMod.Form_Comp_Color(my_Form:TForm);
//formlarýn art alan ve yazý renklerini belirler
var
  i:Integer;
  my_Comp:TWinControl;
begin
  for i:=0 to my_Form.ComponentCount-1 do
  begin
    if (my_Form.Components[i].ClassName = 'TIB_Edit') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TIB_EDIT).Font.Color := glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TIB_Memo') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TIB_MEMO).Font.Color := glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TIB_CheckBox') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TIB_CheckBox).Font.Color := glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TIB_LookupCombo') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TIB_LookupCombo).Font.Color :=glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TIB_Currency') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TIB_Currency).Font.Color :=glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TEdit') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TEdit).Font.Color :=glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TDateTimePicker') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TDateTimePicker).Font.Color :=glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TCheckBox') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TCheckBox).Font.Color :=glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TIB_ComboBox') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TIB_ComboBox).Font.Color :=glb_Yazi_Renk;
    end
    else
    if (my_Form.Components[i].ClassName = 'TIB_Date') then
    begin
      my_Comp := TWinControl(my_Form.Components[i]);
      (my_Comp as TIB_DATE).Font.Color :=glb_Yazi_Renk;
    end;
  end;
end;


function TDataMod.GetParam(Modul_ID:Integer;ParamName:String;Sube_ID:SmallInt):String;
var
  strSQL:String;
  qryPARAM : TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryPARAM,nil,False,DataMod.dbaMain);
      with qryPARAM do
      begin
        strSQL := 'SELECT PARAMETERS.DEGER' +
                  ' FROM PARAMETERS ' +
                  ' WHERE  PARAMETERS.MODUL_ID =' +  IntToStr(Modul_ID) +
                  ' AND PARAMETERS.PARAM_NAME= '+ SQL_Katar(ParamName)+
                  ' AND PARAMETERS.SUBE_ID = ' + IntToStr(Sube_ID);
        SQL.Add(strSQL);
        Active := True;
        if recordcount <> 0 then
           Result := Trim(Fields[0].AsString)
        else
           Result :='';
        Active := False;
      end;
    except
      Result := '';
    end;
  finally
    DataMod.ReleaseQuery(qryPARAM);
  end;
end;

function TDataMod.SETPARAM(Modul_ID:Integer;ParamName:String;Value:String;Sube_ID:SmallInt):Boolean;
var
  strSQL:String;
  qryPARAM : TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryPARAM,nil,False,DataMod.dbaMain);
      with qryPARAM do
      begin
        strSQL := 'UPDATE PARAMETERS' +
                 ' SET DEGER =' + SQL_Katar(Value) +
                 ' WHERE  PARAMETERS.MODUL_ID =' +  IntToStr(Modul_ID) +
                 ' AND PARAMETERS.PARAM_NAME= '+ SQL_Katar(ParamName)+
                 ' AND PARAMETERS.SUBE_ID= '+ IntToStr(Sube_ID);
        SQL.Add(strSQL);
        Execute;
        Result := True;
      end;
    except
      Result := False;
    end;
  finally
    DataMod.ReleaseQuery(qryPARAM);
  end;
end;

function TDataMod.Kod_Format(Value:int64;PreWord:String;EndWord:String;BranchID:integer;KodLength:Integer):String;
var
  ValueStr,ResultStr,BranchIDStr:String;
  S:Integer;
  SUBEKODKARSAY,SUBEKODDAHIL:INTEGER;
begin
  SUBEKODKARSAY := StrToInt(GetParam(0,'KOD_SUBE_LENGTH',0));
  SUBEKODDAHIL := StrToInt(GetParam(0,'KOD_SUBE',0));
  ValueStr := IntToStr(Value);
  BranchIDStr := '';
  if Length(ValueStr) >= KODLENGTH then
  begin
    Result := Copy(ValueStr,1,KODLENGTH);
    exit;
  end;
  ResultStr := Valuestr;
  for s:=1 to (KODLENGTH - (length(PreWord)+ length(ValueStr)+SUBEKODKARSAY)) do Resultstr := KODFILLCHAR + ResultStr;
  if SUBEKODDAHIL > 0 then
  begin
    BranchIDStr := IntToStr(glb_SID);
    for s:=1 to (SUBEKODKARSAY- length(BranchIDStr)) do BranchIDStr := KODFILLCHAR + BranchIDStr;
  end;
  Result := PreWord + BranchIDStr +ResultStr + EndWord;
end;


Function TDataMod.Modul_Hak(Modul_ID:Integer;Var my_CanUpdate:Boolean ;var my_CanDelete:Boolean):Boolean;
var
   qryMODULHAK:TIB_Query;
begin
    my_CanUpdate := True;
    my_CanDelete := True;
    Result := True;
    if glb_YONETICI=False then
    begin
      DataMod.CreateQuery(qryMODULHAK,Nil,False,DataMod.dbaANA);
      with qryMODULHAK do
      begin
        Active := False;
        SQL.Clear;
        SQL.Add('SELECT * FROM MODULHAK WHERE KULLANICI_ID='
                + IntToStr(glb_USER_ID) + ' AND KULLANICI_SID='
                + IntToStr(glb_USER_SID)
                + ' AND MODUL_ID='+IntToStr(Modul_ID)
               );
        Active := True;
        if not ((Eof) and (Bof)) then
        begin
          if FieldByName('IZLEME').AsSmallint = 0 then
          begin
            Result:=False;
          end
          else
          begin
            if FieldByName('DEGISTIRME').AsSmallint = 0 then my_CanUpdate:=False;
            if FieldByName('SILME').AsSmallint = 0 then my_CanDelete:=False;
          end;
        end
        else
        begin
          ShowMessage('Modulün Veri Tabanýnda Tanýmlý olduðunu kontrol ediniz') ;
        end;
        Active := False;
      end;
    end
    else
    begin
      my_CanUpdate:=True;
      my_CanDelete:=True;
      Result := True;
    end;
end;



Function TDataMod.LS_Proje(var Proje_KOD:String;var Proje_AD:String;Durum:Byte):Boolean;
var
  Kolonlar : TStringList;
  strDURUM : String;
begin
  // DURUM 0 : Tüm Projeler
  // DURUM 1 : Açýk Projeler
  // DURUM 2 : Kapalý Projeler
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('PROJE_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('PROJE_AD');
  Kolonlar.Add('Adý');
  Kolonlar.Add('250');
  case DURUM of
  0:
    begin
      frmSrcDlg.Caption := 'Proje Listesi [Tüm Projeler]';
      strDURUM := ''
    end;
  1:
    begin
      frmSrcDlg.Caption := 'Proje Listesi [Açýk Projeler]';
      strDURUM := ' WHERE KAPANDI = 0'
    end;
  2:
    begin
      frmSrcDlg.Caption := 'Proje Listesi [Kapalý Projeler]';
      strDURUM := ' WHERE KAPANDI = 1'
    end;
  end;

  frmSrcDlg.List( 2 , Kolonlar ,'SELECT PROJE_KOD, PROJE_AD FROM PROJE',strDURUM,1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    Proje_KOD := Kolonlar.Strings[0];
    Proje_AD := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

function TDataMod.LS_CariGroup(var CariGroup_KOD:String;var CariGroup_AD:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('CARI_GRUP_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('CGADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Cari Grup Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT CARI_GRUP_KOD,CGADI  FROM CARI_GRUP','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    CariGroup_KOD := Kolonlar.Strings[0];
    CariGroup_AD := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;


Function TDataMod.LS_UrunGroup(var UrunGroup_KOD:String;var UrunGroup_AD:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('URUN_GRUP_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('UGADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Ürün Grup Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT URUN_GRUP_KOD,UGADI  FROM URUN_GRUP','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     UrunGroup_KOD := Kolonlar.Strings[0];
     UrunGroup_AD := Kolonlar.Strings[1];
     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

Function TDataMod.LS_KASA(var KASA_KOD:String;var ACIKLAMA:String;var DOVKOD:String):Boolean;
var
  Kolonlar : TStringList;
  strSQL : String;
begin
// Burak ÖZLER 18/12/2002
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('KASAHAK.KASA_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('75');
  Kolonlar.Add('ACIKLAMA');
  Kolonlar.Add('Adý');
  Kolonlar.Add('250');
  Kolonlar.Add('DOVKOD');
  Kolonlar.Add('Para Birimi');
  Kolonlar.Add('60');
  frmSrcDlg.Caption := 'Kasa Listesi';
//****************************************************************************//
  if glb_KASA_KISIT_UYG then
  begin
    strSQL := 'SELECT KASAHAK.KASA_KOD,KASA.ACIKLAMA,KASA.DOVKOD FROM KASA'
            + ' INNER JOIN KASAHAK ON (KASAHAK.KASA_KOD = KASA.KASA_KOD AND KASAHAK.KASA_SID = KASA.KASA_SID)'
//            + ' WHERE KASAHAK.KULLANICI_ID = ' + inttostr(glb_USER_ID) + ' AND KASAHAK.KULLANICI_SID = ' + inttostr(glb_USER_SID);
//            + ' WHERE KASAHAK.KULLANICI_ID = ' + inttostr(glb_USER_ID) + ' AND KASAHAK.KULLANICI_SID = ' + inttostr(glb_USER_SID);
  end
  else
  begin
    strSQL := 'SELECT KASA_KOD,ACIKLAMA,DOVKOD FROM KASA';
  end;
//****************************************************************************//
  frmSrcDlg.List( 3 , Kolonlar ,strSQL,'',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    KASA_KOD := (Kolonlar.Strings[0]);
    ACIKLAMA := (Kolonlar.Strings[1]);
    DOVKOD := Kolonlar.Strings[2];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

Function TDataMod.GET_URUN_FAT_BILGI(trn:TIB_Transaction;
                                     PRM_URUN_KOD:String;
                                     PRM_CARI_KOD:String;
                                     PRM_TIP:Byte;
                                     PRM_ISN:Integer;
                                     Var PRM_FIYAT:Currency;
                                     Var PRM_DOVKOD: String;
                                     Var PRM_URUN_AD: String;
                                     Var PRM_OLCUBIRIM:String;
                                     Var PRM_DEPO_KOD: string;
                                     Var PRM_DEPO_AD: String;
                                     Var PRM_KDV: Byte;
                                     Var PRM_KDV_TUTAR:Currency;
                                     Var PRM_KDV_DAHIL:Byte):Boolean;
var
  LOCAL_FIYAT:Currency;
  OLDU :Byte;
begin
  with SP_GET_URUN_FAT_BILGI  do
  begin
    if trn <> Nil then IB_Transaction:= trn;
    Prepare;
    ParamByName('PRM_URUN_KOD').AsString :=  PRM_URUN_KOD;
    ParamByName('PRM_CARI_KOD').AsString := PRM_CARI_KOD;
    ParamByName('PRM_TIP').AsSmallInt := PRM_TIP;
    ParamByName('ISN').AsInteger := PRM_ISN;
    try
      ExecProc;
      PRM_KDV_DAHIL := ParamByName('PRM_KDV_DAHIL').AsSmallint;
      LOCAL_FIYAT:=ParamByName('PRM_FIYAT').AsCurrency;
      PRM_DOVKOD := ParamByName('PRM_DOVKOD').AsString;
      PRM_URUN_AD := ParamByName('PRM_URUN_AD').AsString;
      PRM_OLCUBIRIM:= ParamByName('PRM_OLCUBIRIM').AsString;
      PRM_DEPO_KOD:= ParamByName('PRM_DEPO_KOD').AsString;
      PRM_DEPO_AD:= ParamByName('PRM_DEPO_AD').AsString;
      PRM_KDV:= ParamByName('PRM_KDV').AsSmallint;
      if PRM_KDV_DAHIL =1 then
      begin
        PRM_FIYAT :=LOCAL_FIYAT /(1 + (PRM_KDV /100));
        PRM_KDV_TUTAR := (LOCAL_FIYAT-PRM_FIYAT);
      end
      else
      begin
        PRM_FIYAT :=LOCAL_FIYAT;
        PRM_KDV_TUTAR := LOCAL_FIYAT * (PRM_KDV / 100);
      end;
      OLDU:= ParamByName('PRM_OLDU').AssmallInt;
      if OLDU = 1 then Result := True
      else
      begin
        frmISN_ERRORS.AnyErr(trn,prm_ISN,0);
        Result := False;
      end;
      Unprepare;
    except
      Result := False;
      Unprepare;
    end;
  end;
end;


Function TDataMod.LS_OlcuBrm(OlcuTip:String; Var OlcuBir:String):Boolean;
// irfan yardým
//26.10.2002

var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('OLCUBIRIM');
  Kolonlar.Add('Ölçü Birimi');
  Kolonlar.Add('150');
  Kolonlar.Add('DEGERTODOM');
  Kolonlar.Add('Deðer');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Ölçü Birim Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT OLCUBIRIM As A,OLCUBIRIM,DEGERTODOM  FROM OLCUBIR Where OLCU_TIP='+SQL_Katar(OlcuTip),'',1,1);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    OlcuBir := Kolonlar.Strings[0];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

Function TDataMod.LS_OlcuTIP(var OlcuTIP:String):Boolean;
// irfan yardým
//26.10.2002
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('OLCU_TIP');
  Kolonlar.Add('Ölçü Tipi');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Ölçü Tipi Listesi';
  frmSrcDlg.List( 1 , Kolonlar ,'SELECT OLCU_TIP As OLCUTIPA,OLCU_TIP FROM OLCUTIP','',1,1);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    OlcuTIP := Kolonlar.Strings[0];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

procedure TDataMod.dbaMainAfterConnect(Sender: TIB_Connection);
var
  S:String;
  RKodGor : Boolean;
  qryTemp:TIB_Query;
  qryKULLANICI:TIB_Query;
  qryKULLANICIARR:TIB_Query;
  i : integer;
begin
  try
    if DataMod.GetParam(0,'YAZICI_IS_BIL',0)='1' then
    glb_Yazici_Is_Bildir:=True
    else
    glb_Yazici_Is_Bildir:=False;

    {$IfDef TRANSPORT}
      glb_NAK_HIZ_URN_KOD:=Trim(DataMod.GetParam(0,'NAK_HIZ_URN_KOD',0));
      glb_BEK_HIZ_URN_KOD:=Trim(DataMod.GetParam(0,'BEK_HIZ_URN_KOD',0));
      glb_MAZ_HIZ_URN_KOD:=Trim(DataMod.GetParam(0,'MAZ_HIZ_URN_KOD',0));
      glb_FATURA_MIK_SEF:=StrtoInt(Trim(DataMod.GetParam(0,'FATURA_MIK_SEF',0)));
    {$EndIf}


    glb_S_DIAG_GRUP_KOD:=Trim(DataMod.GetParam(0,'S_DIAG_GRUP_KOD',0));
    glb_S_ISCI_GRUP_KOD:=Trim(DataMod.GetParam(0,'S_ISCI_GRUP_KOD',0));
    glb_S_MAL_GRUP_KOD:=Trim(DataMod.GetParam(0,'S_MAL_GRUP_KOD',0));


    DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
    qryTemp.Active:=False;
    qryTemp.Sql.Text:='Select CARI_KOD from CARI where MUHTELIF=1';
    qryTemp.Open;
    glb_Muhtelif_Kod:='';
    if qryTemp.RecordCount<1 then
    begin
     Application.MessageBox('Muhtelif Cari Kodu Tanýmlý Deðil','Dikkat',MB_ICONHAND);
    end
    else
    begin
      glb_Muhtelif_Kod:=QryTemp.Fieldbyname('CARI_KOD').AsString;
    end;


    { glb_ARKAPLAN_RENK1:=StringToColor(DataMod.GetParam(0,'RAP_ARKAPRENK1',0));
    glb_ARKAPLAN_RENK2:=StringToColor(DataMod.GetParam(0,'RAP_ARKAPRENK2',0));}

    // try


    if Trim(DataMod.GetParam(0,'RAPOR_RENK_KUL',0))='1' then
    begin
      glb_RAPOR_RENKLENDIRME:=True;
      glb_RAPOR_RENK_TIPI:=StrToInt(Trim(DataMod.GetParam(0,'RAP_RENK_TIPI',0)));
      glb_ARKAPLAN_RENK1:=StrToInt(Trim(DataMod.GetParam(0,'RAP_ARKAPRENK1',0)));
      glb_ARKAPLAN_RENK2:=StrToInt(Trim(DataMod.GetParam(0,'RAP_ARKAPRENK2',0)));
    end
    else
    glb_RAPOR_RENKLENDIRME:=False;

    //except
    // end;

    // locate saçmaladýðý için bu yönteme donuldu
    if not GetVPB(glb_DEFCUR) then Application.MessageBox('Varsayýlan Para Birimi Parametresi olmadan program çalýþamaz.Lütfen yazýlým destek biriminizle irtibata geçiniz.','Dikkat',MB_ICONHAND);
    KODFILLCHAR := Trim(DataMod.GetParam(0,'KODFILLCHAR',0));
    glb_SATISKUR := StrToInt(DataMod.GetParam(1,'SATISKUR',0));
    glb_CALISMA_YIL := StrToInt(DataMod.GetParam(0,'CALISMA_YIL',0));
    glb_DOVTAKIP := (Trim(DataMod.GetParam(1,'USEDOVIZ',0)) = '1');
    glb_KASA_KISIT_UYG := (Trim(DataMod.GetParam(14,'KASA_KISIT_UYG',0)) = '1');
    {$ifdef TAM}
      glb_MUH_ENT := (Trim(DataMod.GetParam(19,'MUH_ENTEGRE',0)) = '1');
      s := Trim(DataMod.GetParam(0,'EN_GER_KAY_TAR',0));
      glb_EN_GER_KAY_TAR := StrToDate(Copy(s,7,2) + DateSeparator + Copy(s,5,2)+ DateSeparator + Copy(s,1,4));
    {$else}
      glb_MUH_ENT := False;
    {$endif}
    glb_MUAVIN_KULLAN := (Trim(DataMod.GetParam(20,'MUAVIN_KULLAN',0)) = '1');
    glb_DOV_KUR_PF := Trim(DataMod.GetParam(0,'DOV_KUR_PF',0));
    glb_DOV_FIELD_PF := Trim(DataMod.GetParam(0,'DOV_FIELD_PF',0));
    glb_VPB_FIELD_PF := Trim(DataMod.GetParam(0,'VPB_FIELD_PF',0));
    {$IfDef DEPO}
       glb_DEPO_UYG := (Trim(DataMod.GetParam(8,'DEPO_UYG',0)) = '1');
    {$Else}
       glb_DEPO_UYG := False;
    {$EndIf}
    {$IfDef PROJE}
       glb_PROJE_UYG := (Trim(DataMod.GetParam(9,'PROJE_UYG',0)) = '1');
    {$Else}
       glb_PROJE_UYG := False;
    {$EndIf}
    {$IfDef PLASIYER}
       glb_PLASIYER_UYG := (Trim(DataMod.GetParam(10,'PLASIYER_UYG',0)) = '1');
    {$Else}
       glb_PLASIYER_UYG := False;
    {$EndIf}
    if glb_PROJE_UYG then
    begin
      glb_K_PRJ_INS := (Trim(DataMod.GetParam(9,'K_PRJ_INS',0)) = '1');
      glb_K_PRJ_DEL := (Trim(DataMod.GetParam(9,'K_PRJ_DEL',0)) = '1');
      glb_K_PRJ_DEL_MSG := (Trim(DataMod.GetParam(9,'K_PRJ_DEL_MSG',0)) = '1');
    end
    else
    begin
      glb_K_PRJ_INS := False;
      glb_K_PRJ_DEL := False;
      glb_K_PRJ_DEL_MSG := False;
    end;
    DataMod.LoadDovizLists;
    //****************************************************************************//
    glb_SUBELI := DataMod.Subeli_mi;
    //****************************************************************************//
    if glb_SUBELI then
    begin
      if (Trim(DataMod.GETParam(0,'ASGN_USR_SID',0))= '1') then
      begin
        DataMod.CreateQuery(qryKULLANICI,Nil,False,DataMod.dbaANA);
        qryKULLANICI.SQL.Add('SELECT SUBE_ID FROM KULLANICI WHERE KULLANICI.KULLANICI_ID = '+ inttostr(glb_USER_ID) + ' AND KULLANICI.KULLANICI_SID = '+ IntToStr(glb_USER_SID));
        qryKULLANICI.Open;
        if qryKULLANICI.RecordCount <> 0 then
           glb_SID := qryKULLANICI.FieldByName('SUBE_ID').AsInteger;
        qryKULLANICI.Close;
        DataMod.ReleaseQuery(qryKULLANICI);
      end;
    end
    else
    begin
      glb_SID := StrToInt(DataMod.GetParam(0,'SUBE_KOD',0));
    end;
    //****************************************************************************//
    if glb_SUBELI then
    begin
      DataMod.SubeADIDYukle;
      glb_SUBE_MUDAHALE := (DataMod.GetSubeMudahale = 1);
    end;
    //****************************************************************************//
    glb_Art_Alan_Renk := StringToColor(DataMod.GetParam(0,'ART_AL_RENK',0));
    glb_Yazi_Renk := StringToColor(DataMod.GetParam(0,'YAZI_RENK',0));
    dmLOGGER.Connect2LOG_DB;
 except
    on E: Exception do ShowMessage('Parametreleri Düzeltip Programdan Çýkýp Yeniden Giriniz  '+ E.Message);

 end;

end;


Procedure TDataMod.Rapor_Satir_Renklendir(Col:Integer;Row:Integer;Col_Say:Integer);
begin
    if glb_RAPOR_RENKLENDIRME then
    begin
      Inc(glb_Renk_Say);
      if glb_RAPOR_RENK_TIPI=1 then
      if (glb_Renk_Say mod 2)=1  then
      frmRaporCiktisi.SetCellPattern(col,row,col+Col_Say,row,glb_ARKAPLAN_RENK1,glb_ARKAPLAN_RENK0,glb_RAPOR_DOLGU)
      else
      frmRaporCiktisi.SetCellPattern(col,row,col+Col_Say,row,glb_ARKAPLAN_RENK2,glb_ARKAPLAN_RENK0,glb_RAPOR_DOLGU);
      if glb_RAPOR_RENK_TIPI=2 then
      if (glb_Renk_Say mod 2)=1  then
      frmRaporCiktisi.SetCellFont(col,row,col+Col_Say,row,[fsBold],8,'MS Sans Serif',glb_ARKAPLAN_RENK1)
      else
      frmRaporCiktisi.SetCellFont(col,row,col+Col_Say,row,[fsBold],8,'MS Sans Serif',glb_ARKAPLAN_RENK2);
    end;
end;

Function TDataMod.KurluDonustur(Tarih:TDateTime;FromKur:String;FROM_DOVKUR:Currency;ToKur:String;Tutar:Currency;KurTipi:Byte;DOV_KURLA_ISLE:Boolean;var SONUC:Currency):Boolean;
{ Burak
  Satýs kuru için Satýs = 1
  FROM_DOVKUR: Dönüþtürme iþlemi yapýlacak From Kur'un Döviz Kur'u
  DOV_KURLA_ISLE: True gönderilirse FROM_DOVKUR degerini kullanýr
                  False gönderilirse KurDonustur gibi davranýr.
FromKur'u kendisi bulur.
  }
var
  FromDovKurDeger,ToDovKur,ISLENEN,ISLEMDEKI:Extended;
  a:Currency;
begin
  try
    if Tutar = 0 then
    begin
      Application.MessageBox('TDataMod.KurluDonustur: Tutar 0 olduðundan iþlem yapýlamýyor', 'Dikkat', MB_ICONERROR);
      Sonuc := 0;
      Result := False;
      Exit;
    end;
    if Trim(FromKur) = Trim(ToKur) then
    begin
      Sonuc := Tutar;
      Result := True;
      Exit;
    end;
    if DOV_KURLA_ISLE then
    begin
      if FROM_DOVKUR <> 0 then
      begin
        FromDovKurDeger := FROM_DOVKUR
      end
      else
      begin
        FromDovKurDeger := Get_Doviz_Kur(FromKur,Tarih,KurTipi,0);
      end;
    end
    else
    begin
      FromDovKurDeger := Get_Doviz_Kur(FromKur,Tarih,KurTipi,0);
    end;
    if FromDovKurDeger = 0 then
    begin
      Application.MessageBox('TDataMod.KurluDonustur: Kur çevrimi yapýlacak kaynak kur 0 deðeri aldýðýndan iþlem yapýlamýyor', 'Dikkat',MB_ICONERROR);
      Sonuc := 0;
      Result := False;
      Exit;
    end;

    if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005'))=0 then
    begin
      ISLEMDEKI := StrToCurr(FormatCurr('#.00',Tutar * FromDovKurDeger));
    end
    else
    begin
      ISLEMDEKI := Tutar * FromDovKurDeger;
    end;

    ToDovKur := Get_Doviz_Kur(ToKur,Tarih,KurTipi,0);
    if ToDovKur = 0 then
    begin
      Application.MessageBox('TDataMod.KurluDonustur: Kur çevrimi yapýlacak Hedef kur 0 deðeri aldýðýndan iþlem yapýlamýyor', 'Dikkat', MB_ICONERROR);
      Sonuc := 0;
      Result := False;
      Exit;
    end;

    if ToKur = 'TRL' then
    begin
      ISLEMDEKI := ISLEMDEKI * ToDovKur;
    end
    else
    begin
      if ToDovKur >= 1 then
         ISLEMDEKI := ISLEMDEKI / ToDovKur  // PARITE ISLEMLERI ICIN
      else
         ISLEMDEKI := ISLEMDEKI * ToDovKur;


      ISLENEN := Frac(ISLEMDEKI);
      // YTL UYARLAMASI 0.00 geri donusum için
      if Length(FloatToStr(ISLENEN)) > 4 then
      begin
        ISLEMDEKI := ISLEMDEKI - (Frac(ISLENEN * 100) / 100);
        a := Frac(ISLENEN * 100);
        if a >= 0.5 then
           ISLEMDEKI := ISLEMDEKI + 0.01
        else
        if a <= -0.5 then
          ISLEMDEKI := ISLEMDEKI - 0.01
      end;

    end;
    Sonuc := ISLEMDEKI;
    Result := True;
  except
    Result := False;
    raise;
  end;
end;

Function TDataMod.Get_Isn_Num:Integer;
begin
  Result := GET_SAYAC_NUM('ISN',True,False,0);
end;

Function TDataMod.Before_Post_Kontrol(my_Table:TIB_Query;my_Table_Name:String; my_NotNullCol:String;my_UniqueCol:String ):string;
/// irfan yardým
///31.10.2002
/// querileri befor postunda caðrýlýcak ve querinin not null ve unique alanlarýný kontrol edecek
var
  i:Integer;
  local_my_NotNullCol :TStringList;
  local_my_Unique:TStringList;
  strSQL:String;
  qryTEMP:TIB_Query;
begin
  try
    DataMod.CreateQuery(qryTEMP,Nil,False,DataMod.dbaMain);
    local_my_NotNullCol := TstringList.Create;
    local_my_NotNullCol.CommaText := my_NotNullCol;
    local_my_Unique:=TStringList.Create;
    local_my_Unique.CommaText := my_UniqueCol;

    Result := '';
    for i:=0 to local_my_NotNullCol.Count-1 do
    begin
      if my_Table.FieldByName(local_my_NotNullCol[i]).AsString='' then
      begin
        Result:=my_Table.FieldByName(local_my_NotNullCol[i]).DisplayName + ' Alanýna Veri Girmediniz';
        Exit;
      end;
    end;
    if my_Table.State in [dssInsert] then
    begin
      for i:=0 to local_my_Unique.Count-1 do
      begin
        if my_Table.FieldByName(local_my_Unique[i]).IsText then
        begin
          strSQL:='Select Count(*) as MY_VALUE From ' + my_Table_Name + ' Where ' + local_my_Unique[i] + '=' + SQL_Katar(my_Table.FieldByName(local_my_Unique[i]).AsString);
        end
        else
        if my_Table.FieldByName(local_my_Unique[i]).IsNumeric Then
        begin
          strSQL:='Select Count(*) as MY_VALUE From ' + my_Table_Name + ' Where ' + local_my_Unique[i] + '=' + my_Table.FieldByName(local_my_Unique[i]).AsString;
        end;
        qryTEMP.Active:=False;
        qryTEMP.SQL.Clear;
        qryTEMP.SQL.Add(strSQL);
        qryTEMP.Open;
        if qryTEMP.FieldByName('MY_VALUE').AsInteger<>0 then
        begin
          Result := my_Table.FieldByName(local_my_Unique[i]).DisplayName + ' Alanýný Kontrol Edip Tekrar Deneyiniz';
          Exit;
        end;
      end;
    end
    else
    if my_Table.State in [dssEdit] then
    begin
      ////edit durumu yane
      for i:=0 to local_my_Unique.Count-1 Do
      begin
        if  (my_Table.FieldByName(local_my_Unique[i]).OldAsString <> my_Table.FieldByName(local_my_Unique[i]).AsString) then
        begin
          if my_Table.FieldByName(local_my_Unique[i]).IsText then
          begin
            strSQL:='SELECT COUNT(*) as MY_VALUE FROM ' + my_Table_Name + ' WHERE ' + local_my_Unique[i] + '='
            + SQL_Katar(my_Table.FieldByName(local_my_Unique[i]).AsString);
          end
          else
          if my_Table.FieldByName(local_my_Unique[i]).IsNumeric Then
          begin
            strSQL:='SELECT COUNT(*) as MY_VALUE FROM ' + my_Table_Name + ' WHERE ' + local_my_Unique[i] + '='
            + my_Table.FieldByName(local_my_Unique[i]).AsString;
          end;
          qryTEMP.Active:=False;
          qryTEMP.SQL.Clear;
          qryTEMP.SQL.Add(strSQL);
          qryTEMP.Open;
          if qryTEMP.FieldByName('MY_VALUE').AsInteger<>0 then
          begin
            Result := my_Table.FieldByName(local_my_Unique[i]).DisplayName + ' Alanýný Kontrol Edip Tekrar Deneyiniz';
            Exit;
          end;
        end;
      end;
    end;
  finally
    DataMod.ReleaseQuery(qryTEMP);
  end;
end;


function TDataMod.Get_Doviz_Kur_Kontrol(PRM_TARIH:TDateTime):Boolean;
var
  qryDOVKUR,qryDOVKART:TIB_Query;
  adet:integer;
    Msg : PChar;
  begin

    try


      DataMod.CreateQuery(qryDOVKART,Nil,False,DataMod.dbaMain);
      with qryDOVKART do
      begin
        SQL.Add('SELECT * FROM DOVKART');
        Open;
        adet:=RecordCount;
      end;
      DataMod.CreateQuery(qryDOVKUR,Nil,False,DataMod.dbaMain);
      with qryDOVKUR do
      begin
        SQL.Add('SELECT * FROM DOVKUR WHERE TARIH = '+ SQL_Tarih(PRM_TARIH));
        Open;
        if (RecordCount <> adet) then
        begin
          MSG := PChar(DateToStr(PRM_TARIH) + ' tarihine ait döviz kurlari bilgileri girilmemiþ..!');
          Application.MessageBox(Msg,'Dikkat',MB_ICONERROR);
          Result := false;
          Exit;
        end;
        if (RecordCount = adet) then
        begin
                     Result := true;
          Exit;
        end;
      end;
  finally
    DataMod.ReleaseQuery(qryDOVKART);
    DataMod.ReleaseQuery(qryDOVKUR);
  end;

end;



function TDataMod.Get_Doviz_Kur(PRM_DOVKOD:String;PRM_TARIH:TDateTime;PRM_TIP:Byte;PRM_ISN:Integer):Extended;
var
  qryDOVKUR,qryDOVKART:TIB_Query;
  Msg : PChar;
begin
  try
    try
      if Trim(PRM_DOVKOD) = glb_DEFCUR then
      begin
        Result := 1;
        Exit;
      end;
      if not PRM_TIP in [1..4] then
      begin
        Application.MessageBox('Ýþlem yapmak istediðiniz Döviz Kuru Tipi sistemde tanýmlý deðil 1..4 arasýnda olmalý','Dikkat',MB_ICONHAND);
        Result := 0;
        Exit;
      end;
      DataMod.CreateQuery(qryDOVKART,Nil,False,DataMod.dbaMain);
      with qryDOVKART do
      begin
        SQL.Add('SELECT * FROM DOVKART WHERE DOVKOD = ' + SQL_Katar(PRM_DOVKOD));
        Open;
        if FieldByName('PARITE').AsInteger = 1 then
        begin
          Result := FieldByName('PARITE_DEGER').AsFloat;
          Exit;
        end;
      end;

      DataMod.CreateQuery(qryDOVKUR,Nil,False,DataMod.dbaMain);
      with qryDOVKUR do
      begin
        SQL.Add('SELECT * FROM DOVKUR WHERE DOVKOD = ' + SQL_Katar(PRM_DOVKOD) + ' AND TARIH = '+ SQL_Tarih(PRM_TARIH));
        Open;
        if RecordCount = 0 then
        begin
          MSG := PChar(DateToStr(PRM_TARIH) + ' tarihine ait döviz kuru bilgileri girilmemiþ..!');
          Application.MessageBox(Msg,'Dikkat',MB_ICONERROR);
          Result := 0;
          Exit;
        end;
        case PRM_TIP of
        1: Result := FieldByName('ALISKUR').AsCurrency;
        2: Result := FieldByName('SATISKUR').AsCurrency;
        3: Result := FieldByName('EF_ALISKUR').AsCurrency;
        4: Result := FieldByName('EF_SATISKUR').AsCurrency;
        end; // case end
      end; // with end
    except
      MSG := Pchar('TDataMod.Get_Doviz_Kur Prosedüründe Hata Oluþtu' + chr(13) + qryDOVKUR.SQL[0]);
      Application.MessageBox(MSG,'Dikkat',MB_ICONERROR);
      Result := 0;
      raise;
    end;
  finally
    DataMod.ReleaseQuery(qryDOVKART);
    DataMod.ReleaseQuery(qryDOVKUR);
  end;
end;


Function TDataMod.FN_Sirket(Var res_Sirket:TStringList):Boolean;
var
  qrySirket : TIB_Query;
//  08/11/2002 irfan yardým
//  Amaç: Þirket bilgilerini saðlar
//  Kullanýmý: TDataMod.FN_Sirket(res_Sirket)
//  Dönen Deðerler
//  TRUE : Ýlgili carinin bilgilerine ulaþýlmýþtýr.
//  ResultSet
//     0 : Sirket_KOD
//     1 : ADI
//     2 : YETKILI
//     3 : ADRES_1
//     4 : ADRES_2
//     5 : ILCE
//     6 : SEHIR
//     7 : PK
//     8 : TEL1
//     9 : TEL2
//    10 : FAX
//    11 : VERDAIRE
//    12 : VERNO
//    13 : TOPLAM_SUBE_ADET
//  FALSE: 1. Durum verilen cariye ait bilgiye rastlanýlmamýþtýr.
//         2. Durum SQL cümleciðinde hata oluþtu
//         iki durumda da hata sebebi Resultset[0] da geri döndürülür.
//23/10/2004 ESER ÞAHÝN
// BOLUNMUÞ VERÝ TABANI ÝÇÝN DÜZENLEME 
begin
  try
    DataMod.CreateQuery(qrySirket,nil,False,dbaANA);
    res_Sirket.Clear;
    Result := True;
    with qrySirket do
    begin
      Active := False;
      sql.Clear;
      sql.Add('SELECT * FROM SIRKET WHERE SIRKET_ID = ' + IntToStr(glb_SIRKET_ID));
      try
        Active := True;
        if RecordCount <> 0 then
        begin
          First;
          res_Sirket.Add(FieldByName('SIRKET_ID').AsString);
          res_Sirket.Add(FieldByName('SIRKET_AD').AsString);
          res_Sirket.Add(FieldByName('YETKILI').AsString);
          res_Sirket.Add(FieldByName('ADRES_1').AsString);
          res_Sirket.Add(FieldByName('ADRES_2').AsString);
          res_Sirket.Add(FieldByName('ILCE').AsString);
          res_Sirket.Add(FieldByName('SEHIR').AsString);
          res_Sirket.Add(FieldByName('PK').AsString);
          res_Sirket.Add(FieldByName('TEL1').AsString);
          res_Sirket.Add(FieldByName('TEL2').AsString);
          res_Sirket.Add(FieldByName('FAX').AsString);
          res_Sirket.Add(FieldByName('VERDAIRE').AsString);
          res_Sirket.Add(FieldByName('VERNO').AsString);
          res_Sirket.Add(FieldByName('TOPLAM_SUBE_ADET').AsString);
        end
        else
        begin
          Result := False;
          Active := False;
          exit;
        end;
      except
        Result := False;
        res_Sirket.Add('FN_Sirket yordamýnýn '+ sql[0] +' cümleciðinde hata oluþtu');
      end;
      Active := False;
    end;
  finally
    DataMod.ReleaseQuery(qrySirket);
  end;
end;

function TDataMod.GET_SAYAC_NUM(SayacName:String;Arttir:Boolean;Sirali:Boolean;Sube_ID:SmallInt):Integer;
var
  qrySAYAC:TIB_Query;
  trnSAYAC:TIB_Transaction;
  DEGER:Integer;
  strSQL : String;
begin
  try
    if Length(Trim(SayacName))> 15 then
    begin
      Application.MessageBox('Sayac Uzunluðu 15 Karakterden Fazla Olamaz, yazýlým üreticisi ile temasa geçin.','Dikkat',MB_ICONERROR);
      Result := 0;
      Exit;
    end;
    DataMod.CreateTransaction(trnSAYAC,tiConcurrency,DataMod.dbaMain);
    DataMod.CreateQuery(qrySAYAC,trnSAYAC,True,DataMod.dbaMain);
    if Sirali then
    begin
      strSQL := 'SELECT * FROM SAYACLAR_NU WHERE SUBE_ID = ' + IntToStr(Sube_ID) + ' AND SAYAC_ADI = ' + SQL_Katar(SayacName)+ ' ORDER BY DEGER';
      qrySAYAC.SQL.Add(strSQL);
      qrySAYAC.Open;
      if qrySAYAC.RecordCount <> 0 then
      begin
        qrySAYAC.First;
        DEGER := qrySAYAC.FieldByName('DEGER').AsInteger;
        Result := DEGER;
        qrySAYAC.Close;
        qrySAYAC.SQL.Clear;
        trnSAYAC.StartTransaction;
        strSQL := 'DELETE FROM SAYACLAR_NU WHERE SUBE_ID = ' + IntToStr(Sube_ID) + ' AND SAYAC_ADI = ' + SQL_Katar(SayacName)+ ' AND DEGER = ' + IntToStr(DEGER);
        qrySAYAC.SQL.Add(strSQL);
        qrySAYAC.Execute;
        trnSAYAC.Commit;
        Exit;
      end;
    end;

    qrySAYAC.Close;
    qrySAYAC.SQL.Clear;
    qrySAYAC.sql.Add('SELECT * FROM SAYACLAR WHERE SUBE_ID = ' + IntToStr(Sube_ID) + ' AND SAYAC_ADI = ' + SQL_Katar(SayacName));
    qrySAYAC.Open;

    if qrySAYAC.RecordCount = 0 then
    begin
      qrySAYAC.Close;
      qrySAYAC.SQL.Clear;
      qrySAYAC.SQL.Add('INSERT INTO SAYACLAR(SUBE_ID,SAYAC_ADI,DEGER) VALUES (' + IntToStr(Sube_ID) + ',' + SQL_Katar(SayacName) + ',1)');
      trnSAYAC.StartTransaction;
      qrySAYAC.Execute;
      trnSAYAC.Commit;
      Result := 1;
    end
    else
    begin
      if Arttir then
      begin
        Result := qrySAYAC.FieldByName('DEGER').AsInteger + 1;
        trnSAYAC.StartTransaction;
        qrySAYAC.Edit;
        qrySAYAC.FieldByName('DEGER').AsInteger  := qrySAYAC.FieldByName('DEGER').AsInteger + 1;
        qrySAYAC.Post;
        trnSAYAC.Commit;
      end
      else
      begin
        Result := qrySAYAC.FieldByName('DEGER').AsInteger;
      end;
    end;

  finally
    DataMod.ReleaseQuery(qrySAYAC);
    DataMod.ReleaseTransaction(trnSAYAC);
  end;
end;

procedure TDataMod.SET_SAYAC_NUM(SayacName:String;NewValue:Integer;Sube_ID:SmallInt);
var
  qrySAYAC:TIB_Query;
  trnSAYAC:TIB_Transaction;
begin
  try
    DataMod.CreateTransaction(trnSAYAC,tiConcurrency,DataMod.dbaMain);
    DataMod.CreateQuery(qrySAYAC,trnSAYAC,True,DataMod.dbaMain);
    qrySAYAC.sql.Add('SELECT * FROM SAYACLAR WHERE SUBE_ID = ' + IntToStr(Sube_ID) + ' AND SAYAC_ADI = ' + SQL_Katar(SayacName));
    qrySAYAC.Open;
    if qrySAYAC.RecordCount = 0 then
    begin
      qrySAYAC.Close;
      qrySAYAC.SQL.Clear;
      qrySAYAC.SQL.Add('INSERT INTO SAYACLAR (SUBE_ID,SAYAC_ADI,DEGER) VALUES ('+IntToStr(Sube_ID)+','+SQL_Katar(SayacName)+','+IntToStr(NewValue)+')');
      trnSAYAC.StartTransaction;
      qrySAYAC.Execute;
      trnSAYAC.Commit;
    end
    else
    begin
      trnSAYAC.StartTransaction;
      qrySAYAC.Edit;
      qrySAYAC.FieldByName('DEGER').AsInteger := NewValue;
      qrySAYAC.Post;
      trnSAYAC.Commit;
    end;
  finally
    DataMod.ReleaseQuery(qrySAYAC);
    DataMod.ReleaseTransaction(trnSAYAC);
  end;
end;

procedure TDataMod.Add_Sayaclar_Nu(SayacName:String;NewValue:Integer;Sube_ID:SmallInt);
var
  qrySAYAC:TIB_Query;
  trnSAYAC:TIB_Transaction;
begin
  try
    DataMod.CreateTransaction(trnSAYAC,tiConcurrency,DataMod.dbaMain);
    DataMod.CreateQuery(qrySAYAC,trnSAYAC,False,DataMod.dbaMain);
    qrySAYAC.SQL.Add('INSERT INTO SAYACLAR_NU (SUBE_ID,SAYAC_ADI,DEGER) VALUES ('+IntToStr(Sube_ID)+','+ SQL_Katar(SayacName)+ ','+ IntToStr(NewValue)+')');
    trnSAYAC.StartTransaction;
    qrySAYAC.Execute;
    trnSAYAC.Commit;
  finally
    DataMod.ReleaseQuery(qrySAYAC);
    DataMod.ReleaseTransaction(trnSAYAC);
  end;
End;



Function TDataMod.PROJEHAR_AUD (Transaction: TIB_Transaction;
                                PRM_BELGE_TUR:Integer;
                                PRM_BELGE_ID:Integer;
                                PRM_BELGE_SID:Integer;
                                PRM_SIRA_NO:Byte;
                                PRM_PROJE_KOD:String;
                                PRM_TARIH:TDate;
                                PRM_FIILI_TAR:TDate;
                                PRM_DOV_BAZ_TAR:TDate;
                                PRM_VADETAR:TDate;
                                PRM_TIP:Char;
                                PRM_DOVKOD:String;
                                PRM_DOVKUR:Currency;
                                PRM_TUTAR:Currency;
                                PRM_TUTAR_VPB:Currency;
                                PRM_SIL:Byte;
                                PRM_ACIKLAMA:String;
                                ISN:Integer;
                                PRM_MASRAF_MERK,
                                PRM_KOD1,
                                PRM_KOD2,
                                PRM_KOD3,
                                PRM_KOD4:String;
                                var PRM_PROJEHAR_ID:Integer;
                                var PRM_PROJEHAR_SID:Integer):Boolean;
var
  qryPROJE,qryPROJEHAR:TIB_Query;
  MSG:PChar;
  PROJE_TUTAR:Currency;
  PROJE_TANIMLI:Boolean;
  PROJE_DOVKOD:String;
  KAPANDI : String;
begin
  try
    try
//****************************************************************************//
      if not glb_PROJE_UYG then
      begin
        Result := True;
        PRM_PROJEHAR_ID := 0;
        PRM_PROJEHAR_SID:= 0;
        Exit;
      end;
//****************************************************************************//
      if Trim(PRM_PROJE_KOD) <> '' then
      begin
        PROJE_TANIMLI := DataMod.FN_KOD2AD('PROJE','PROJE_KOD','DOVKOD',PRM_PROJE_KOD,PROJE_DOVKOD);
        if not PROJE_TANIMLI then
        begin
          MSG := PChar('TDataMod.SPP_PROJEHAR_AUD : '+ PRM_PROJE_KOD + ' Projesi tanýmlý olmadýðý için iþlem hareket kayýtlarý üretilemedi.');
          Application.MessageBox(MSG,'Dikkat',MB_ICONHAND);
          Result := False;
          Exit;
        end;
//****************************************************************************//
        DataMod.FN_KOD2AD('PROJE','PROJE_KOD','KAPANDI',PRM_PROJE_KOD,KAPANDI);
//****************************************************************************//
        if (PRM_SIL = 0) and (KAPANDI = '1') and (not glb_K_PRJ_INS) then
        begin
          MSG := PChar('TDataMod.SPP_PROJEHAR_AUD : '+ PRM_PROJE_KOD + ' Projesi kapalý olduðu ve genel parametrelerde kapalý proje üzerinden kayýt ekleme izini olmadýðý için iþlem hareket kayýtlarý üretilemedi.');
          Application.MessageBox(MSG,'Dikkat',MB_ICONHAND);
          Result := False;
          Exit;
        end
        else
        if (PRM_SIL = 1) and (KAPANDI = '1') and (not glb_K_PRJ_DEL) then
        begin
          if glb_K_PRJ_DEL_MSG then
          begin
            MSG := PChar('TDataMod.SPP_PROJEHAR_AUD : '+ PRM_PROJE_KOD + ' Projesi kapalý olduðu ve genel parametrelerde kapalý proje üzerinden kayýt silme izini olmadýðý için iþlem hareket kayýtlarý üretilemedi.');
            Application.MessageBox(MSG,'Dikkat',MB_ICONHAND);
          end;
          Result := False;
          Exit;
        end;
      end;
//****************************************************************************//
      DataMod.CreateQuery(qryPROJE,Transaction,False,DataMod.dbaMain);
      if PROJE_TANIMLI and (PRM_SIL <> 1) then
      begin
        if PROJE_DOVKOD = glb_DEFCUR then PROJE_TUTAR := PRM_TUTAR_VPB
        else
        begin
           if PROJE_DOVKOD = Trim(PRM_DOVKOD) then PROJE_TUTAR := PRM_TUTAR
           else
           begin
             if not DataMod.KurluDonustur(PRM_DOV_BAZ_TAR,PRM_DOVKOD,PRM_DOVKUR,PROJE_DOVKOD,PRM_TUTAR,glb_SATISKUR,True,PROJE_TUTAR) then
             begin
               Result := False;
               Exit;
             end;
           end;
        end;
      end;
//****************************************************************************//
      DataMod.CreateQuery(qryPROJEHAR,Transaction,True,DataMod.dbaMain);
      qryPROJEHAR.SQL.Add('SELECT * FROM PROJEHAR WHERE BELGE_TUR = '+ IntToStr(PRM_BELGE_TUR) + ' AND BELGE_ID = '+ IntToStr(PRM_BELGE_ID) + ' AND BELGE_SID = ' + IntToStr(PRM_BELGE_SID) + ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO));
      qryPROJEHAR.Open;
//****************************************************************************//
      if qryPROJEHAR.RecordCount > 0 then
      begin
        if Trim(qryPROJEHAR.FieldByName('TIP').AsString) = BORC then
        begin
          qryPROJE.SQL.Clear;
          qryPROJE.SQL.Add('UPDATE PROJE SET BORC = BORC - '+SQL_Para(qryPROJEHAR.FieldByName('TUTAR_PROJE_DOVKOD').AsCurrency)
                        +  ' , BORC_VPB = BORC_VPB - '+ SQL_Para(qryPROJEHAR.FieldByName('TUTAR_VPB').AsCurrency)
                        +  ' WHERE PROJE_KOD = ' + SQL_Katar(qryPROJEHAR.FieldByName('PROJE_KOD').AsString));
          qryPROJE.Execute;
        end
        else
        begin
          qryPROJE.SQL.Clear;
          qryPROJE.SQL.Add('UPDATE PROJE SET ALACAK = ALACAK - '+SQL_Para(qryPROJEHAR.FieldByName('TUTAR_PROJE_DOVKOD').AsCurrency)
                        +  ' , ALACAK_VPB = ALACAK_VPB - '+ SQL_Para(qryPROJEHAR.FieldByName('TUTAR_VPB').AsCurrency)
                        +  ' WHERE PROJE_KOD = ' + SQL_Katar(qryPROJEHAR.FieldByName('PROJE_KOD').AsString));
          qryPROJE.Execute;
        end;
//****************************************************************************//
        if PRM_SIL = 1 then // SILME ÝÞLEMÝ
        begin
          qryPROJEHAR.Delete; // SILME ÝÞLEMÝnin fiilen olduu yer.
          Result := True;
          Exit;
        end;
      end
      else
      begin
        if PRM_SIL = 1 then
        begin
           Result := True;
           Exit;
        end;
        qryPROJEHAR.Insert;
        qryPROJEHAR.FieldByName('PROJEHAR_ID').AsInteger := qryPROJEHAR.Gen_ID('GEN_PROJEHAR',1);
        qryPROJEHAR.FieldByName('PROJEHAR_SID').AsInteger := glb_SID;
      end;
//****************************************************************************//
      PRM_PROJEHAR_ID := qryPROJEHAR.FieldByName('PROJEHAR_ID').AsInteger;
      PRM_PROJEHAR_SID := qryPROJEHAR.FieldByName('PROJEHAR_SID').AsInteger;
      qryPROJEHAR.FieldByName('PROJE_KOD').AsString := Trim(PRM_PROJE_KOD);
      qryPROJEHAR.FieldByName('BELGE_TUR').AsInteger := PRM_BELGE_TUR;
      qryPROJEHAR.FieldByName('BELGE_ID').AsInteger := PRM_BELGE_ID;
      qryPROJEHAR.FieldByName('BELGE_SID').AsInteger := PRM_BELGE_SID;
      qryPROJEHAR.FieldByName('SIRA_NO').AsInteger := PRM_SIRA_NO;
      qryPROJEHAR.FieldByName('TARIH').AsDate := PRM_TARIH;
      qryPROJEHAR.FieldByName('FIILI_TAR').AsDate := PRM_FIILI_TAR;
      qryPROJEHAR.FieldByName('DOV_BAZ_TAR').AsDate := PRM_DOV_BAZ_TAR;
      qryPROJEHAR.FieldByName('VADETAR').AsDate := PRM_VADETAR;
      qryPROJEHAR.FieldByName('TIP').AsString := PRM_TIP;
      qryPROJEHAR.FieldByName('DOVKOD').AsString := Trim(PRM_DOVKOD);
      qryPROJEHAR.FieldByName('TUTAR').AsCurrency := PRM_TUTAR;
      qryPROJEHAR.FieldByName('ACIKLAMA').AsString := Trim(PRM_ACIKLAMA);
      qryPROJEHAR.FieldByName('DOVKUR').AsCurrency := PRM_DOVKUR;
      qryPROJEHAR.FieldByName('TUTAR_PROJE_DOVKOD').AsCurrency := PROJE_TUTAR;
      qryPROJEHAR.FieldByName('TUTAR_VPB').AsCurrency := PRM_TUTAR_VPB;
      qryPROJEHAR.FieldByName('MASRAF_MERK').AsString := Trim(PRM_MASRAF_MERK);
      qryPROJEHAR.FieldByName('KOD1').AsString := Trim(PRM_KOD1);
      qryPROJEHAR.FieldByName('KOD2').AsString := Trim(PRM_KOD2);
      qryPROJEHAR.FieldByName('KOD3').AsString := Trim(PRM_KOD3);
      qryPROJEHAR.FieldByName('KOD4').AsString := Trim(PRM_KOD4);
      qryPROJEHAR.Post;
      qryPROJE.SQL.Clear;
      if Trim(qryPROJEHAR.FieldByName('TIP').AsString) = BORC then
      begin
        qryPROJE.SQL.Clear;
        qryPROJE.SQL.Add('UPDATE PROJE SET BORC = BORC + '+SQL_Para(PROJE_TUTAR)
                       + ' , BORC_VPB = BORC_VPB + '+ SQL_Para(PRM_TUTAR_VPB)
                       + ' WHERE PROJE_KOD = ' + SQL_Katar(PRM_PROJE_KOD));
        qryPROJE.Execute;
      end
      else
      begin
        qryPROJE.SQL.Clear;
        qryPROJE.SQL.Add('UPDATE PROJE SET ALACAK = ALACAK + '+SQL_Para(PROJE_TUTAR)
                      +  ' , ALACAK_VPB = ALACAK_VPB + '+ SQL_Para(PRM_TUTAR_VPB)
                      +  ' WHERE PROJE_KOD = ' + SQL_Katar(PRM_PROJE_KOD));
        qryPROJE.Execute;
      end;
      Result := True;
    except
      Result := False;
      raise;
    end;
  finally
    DataMod.ReleaseQuery(qryPROJE);
    DataMod.ReleaseQuery(qryPROJEHAR);
  end;
end;


Function TDataMod.FN_CariKOD2Bilgi(Cari_KOD:String; Var res_Cari:TStringList):Boolean;
//  09/07/2001 Burak ÖZLER
//  Amaç: CariID verildiðinde Cari Adý ve Kodu geri elde etmek için kullanýlan fonksiyondur
//  Kullanýmý: CariID2CariKod_Ad(53)
//  Dönen Deðerler
//  TRUE : Ýlgili carinin bilgilerine ulaþýlmýþtýr.
//  ResultSet
//     0 : CKOD
//     1 : CARIAD
//     2 : YETKISI
//     3 : VERDAIRE
//     4 : VERNO
//     5 : ADRES_1
//     6 : ADRES_2
//     7 : ILCE
//     8 : SEHIR
//     9 : POSTA_KOD
//    10 : TEL_NO_1
//    11 : TEL_NO_2
//    12 : FAX
//    13 : E_MAIL
//    14 : WEB_ADDR
//    15 : MUHTELIF
//  FALSE: 1. Durum verilen cariye ait bilgiye rastlanýlmamýþtýr.
//         2. Durum SQL cümleciðinde hata oluþtu
//         iki durumda da hata sebebi Resultset[0] da geri döndürülür.
var qryCARI:TIB_Query;
begin
  try
    DataMod.CreateQuery(qryCARI,Nil,False,DataMod.dbaMain);
    res_Cari.Clear;
    Result := True;
    with qryCARI do
    begin
      sql.Add('SELECT * FROM CARI WHERE CARI_KOD = ' + SQL_Katar(Cari_KOD));
      try
        Active := True;
        if recordcount <> 0 then
        begin
          res_Cari.Add(FieldByName('CARI_KOD').AsString);
          res_Cari.Add(FieldByName('CARI_AD').AsString);
          res_Cari.Add(FieldByName('YETKISI').AsString);
          res_Cari.Add(FieldByName('VERDAIRE').AsString);
          res_Cari.Add(FieldByName('VERNO').AsString);
          res_Cari.Add(FieldByName('ADRES_1').AsString);
          res_Cari.Add(FieldByName('ADRES_2').AsString);
          res_Cari.Add(FieldByName('ILCE').AsString);
          res_Cari.Add(FieldByName('SEHIR').AsString);
          res_Cari.Add(FieldByName('POSTA_KOD').AsString);
          res_Cari.Add(FieldByName('TEL_NO_1').AsString);
          res_Cari.Add(FieldByName('TEL_NO_2').AsString);
          res_Cari.Add(FieldByName('FAX').AsString);
          res_Cari.Add(FieldByName('E_MAIL').AsString);
          res_Cari.Add(FieldByName('WEB_ADDR').AsString);
          res_Cari.Add(FieldByName('MUHTELIF').AsString)
        end
        else
        begin
          Result := False;
          res_Cari.Add(Cari_KOD+ ' numarasýna tanýmlý Cari Bulunamadý...');
          Active := False;
          exit;
        end;
      except
        Result := False;
        res_Cari.Add('CariID2CariKod_Ad yordamýnýn '+ sql[0] +' cümleciðinde hata oluþtu');
      end;
      Active := False;
    end;
  finally
    DataMod.ReleaseQuery(qryCARI);
  end;
end;



function TDataMod.LS_Modul():Integer;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('MODUL_ID');
  Kolonlar.Add('Modül Ýd');
  Kolonlar.Add('100');
  Kolonlar.Add('MODUL_ADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Modül Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT MODUL_ID,MODUL_ID,MODUL_ADI From MODUL','',1,2);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    Result := strToInt(Kolonlar.Strings[0]);
  end
  else Result := 0;
  Kolonlar.Free;
end;

function TDataMod.GET_KASA_FROM_KASA_KOD(KASA_KOD:String;var KASA_AD:String;var KASA_DOVKOD:String):Boolean;
var qryKASA:TIB_Query;
begin
  try
    DataMod.CreateQuery(qryKASA,Nil,False,DataMod.dbaMain);
    with qryKASA do
    begin
      sql.Add('SELECT ACIKLAMA,DOVKOD FROM KASA WHERE KASA_KOD = '+ SQL_Katar(KASA_KOD));
      try
        Active := True;
        if RecordCount <> 0 then
        begin
          KASA_AD := FieldByName('ACIKLAMA').AsString;
          KASA_DOVKOD := FieldByName('DOVKOD').AsString;
          Result :=True;
        end
        else
        begin
          Result := False;
          Exit;
        end;
      except
        Result := False;
        exit;
      end;
    end;
  finally
    DataMod.ReleaseQuery(qryKASA);
  end;
end;

function TDataMod.GET_DEFAULT_KASA(var KASA_KOD,KASA_AD,KASA_DOVKOD:String):Boolean;
var
  qryKASA:TIB_Query;
  strSQL : String;
begin
  try
    Result := False;
    DataMod.CreateQuery(qryKASA,Nil,False,DataMod.dbaMain);
    if glb_KASA_KISIT_UYG then
    begin
      strSQL := 'SELECT KASAHAK.KASA_KOD,KASA.ACIKLAMA,KASA.DOVKOD FROM KASA'
            + ' INNER JOIN KASAHAK ON (KASAHAK.KASA_KOD = KASA.KASA_KOD AND KASAHAK.KASA_SID = KASA.KASA_SID)'
            + ' WHERE KASAHAK.VARSAYILAN = 1'
            + ' AND KASAHAK.KULLANICI_ID = ' + inttostr(glb_USER_ID)
            + ' AND KASAHAK.KULLANICI_SID = ' + inttostr(glb_USER_SID);
    end
    else
    begin
      strSQL := 'SELECT KASA_KOD,ACIKLAMA,DOVKOD FROM KASA WHERE KASA.VARSAYILAN = 1';
    end;

    with qryKASA do
    begin
      sql.Add(strSQL);
      try
        Active := True;
        if RecordCount = 0 then
        begin
          Application.MessageBox('Default kasanýz tanýmlý deðil.Lütfen sistem yöneticinizle baðlantýya geçiniz.','Dikkat',MB_ICONWARNING);
          Active := False;
          Result := False;
          Exit;
        end
        else
        if RecordCount = 1 then
        begin
          KASA_KOD     := FieldByName('KASA_KOD').AsString;
          KASA_AD      := FieldByName('ACIKLAMA').AsString;
          KASA_DOVKOD  := FieldByName('DOVKOD').AsString;
          Active := False;
          Result := True;
          Exit;
        end;
      except
        Active := False;
        Result := False;
      end;
    end;
  finally
    DataMod.ReleaseQuery(qryKASA);
  end;
end;

function TDataMod.GET_KULLANICI_KASA_KOD(KASA_KOD: String; var KASA_AD: String): Boolean;
var
  qryKASA:TIB_Query;
  strSQL : String;
begin
  try
    Result := False;
    DataMod.CreateQuery(qryKASA,Nil,False,DataMod.dbaMain);
    strSQL := 'SELECT KASAHAK.KASA_KOD,KASA.ACIKLAMA,KASA.DOVKOD FROM KASA'
          + ' INNER JOIN KASAHAK ON (KASAHAK.KASA_KOD = KASA.KASA_KOD AND KASAHAK.KASA_SID = KASA.KASA_SID)'
          + ' WHERE KASAHAK.KULLANICI_ID = ' + inttostr(glb_USER_ID)
          + ' AND KASAHAK.KULLANICI_SID = ' + inttostr(glb_USER_SID)
          + ' AND KASAHAK.KASA_KOD = ' + SQL_Katar(KASA_KOD);
    with qryKASA do
    begin
      SQL.Clear;
      SQL.Add(strSQL);
      try
        Active := True;
        if RecordCount = 0 then
        begin
          Active := False;
          Result := False;
          Exit;
        end
        else
        if RecordCount = 1 then
        begin
          KASA_AD      := FieldByName('ACIKLAMA').AsString;
          Active := False;
          Result := True;
          Exit;
        end;
      except
        Active := False;
        Result := False;
      end;
    end;
  finally
    DataMod.ReleaseQuery(qryKASA);
  end;
end;


function TDataMod.GET_DEFAULT_KASA_ESKI(var KASA_KOD,KASA_AD,KASA_DOVKOD:String):Boolean;
var
  qryKASA:TIB_Query;
begin
  try
    Result := False;
    DataMod.CreateQuery(qryKASA,Nil,False,DataMod.dbaMain);
    with qryKASA do
    begin
      sql.Add('SELECT * FROM KASA');
      try
        Active := True;
        if RecordCount = 0 then
        begin
          Active := False;
          Result := False;
          Exit;
        end;
        if RecordCount = 1 then
        begin
          KASA_KOD     := FieldByName('KASA_KOD').AsString;
          KASA_AD      := FieldByName('ACIKLAMA').AsString;
          KASA_DOVKOD  := FieldByName('DOVKOD').AsString;
          Active := False;
          Result := True;
          Exit;
        end;
        repeat
          if FieldByName('VARSAYILAN').AsInteger = 1 then
          begin
            KASA_KOD     := FieldByName('KASA_KOD').AsString;
            KASA_AD      := FieldByName('ACIKLAMA').AsString;
            KASA_DOVKOD  := FieldByName('DOVKOD').AsString;
            Active := False;
            Result := True;
            Exit;
          end;
          Next;
        until Eof;
      except
        Active := False;
        Result := False;
      end;
    end;
  finally
    DataMod.ReleaseQuery(qryKASA);
  end;
end;

procedure TDataMod.DataModuleCreate(Sender: TObject);
begin
  glb_WINDOWS_DIR := FindWindowsDir;
  glb_SYSTEM_DIR := FindSystemDir;
  glb_PLATFORM := GetPlatform;
  glb_DOV_LIST := TStringList.Create;
  glb_TAK_DOV_LIST := TStringList.Create;
  glb_IS_SIST_KULLANICI := GET_OP_SYS_UserName;
  glb_MAKINA_ADI := GET_ComputerName;

  glb_ARKAPLAN_RENK0:=0;
  glb_ARKAPLAN_RENK1:=7;
  glb_ARKAPLAN_RENK2:=8;
  glb_RAPOR_RENKLENDIRME:=True;
  glb_RAPOR_DOLGU:=fsSolid;
  glb_Yazici_Is_Bildir:=False;
end;

Function GetVersionInfo:TStringList;
const
  InfoNum = 10;
  InfoStr: array[1..InfoNum] of string = ('CompanyName', 'FileDescription', 'FileVersion', 'InternalName', 'LegalCopyright', 'LegalTradeMarks', 'OriginalFileName', 'ProductName', 'ProductVersion', 'Comments');
var
  S: string;
  n, Len, i: longWORD;
  Buf: PChar;
  Value: PChar;
  StringList1:TStringList;
begin
  StringList1:=TStringList.Create;
  S := Application.ExeName;
  n := GetFileVersionInfoSize(PChar(S), n);  //in windows unit
  if n > 0 then
  begin
    Buf := AllocMem(n);
    GetFileVersionInfo(PChar(S), 0, n, Buf);
    for i := 1 to InfoNum do
    begin
      if VerQueryValue(Buf, PChar('StringFileInfo\040904E4\'+ InfoStr[i]), Pointer(Value), Len) then
      begin
        stringlist1.Add(InfoStr[i] + ' = ' + Value);
        FreeMem(Buf, n);
      end;  
    end;
  end;
  Result:=stringlist1;
end;

function TDataMod.Delete_Control(Table_Name:String;Value:String;var Msg:String):Boolean;
// Tanýmlama tablolarýnýn before deleteleri anýnda yapýlan kontrol
// Eðer Herhangi bir tabloda karþýlaþýlýrsa False deðerini geri çevirir
// -- Veri tabanlarý ayrýldý artýk SP olmasý mumkun deðil -- Bu fonksiyon FB 1.5 versiyonundan itibaren Stored Procedure olacak
var
  qryTABLE_DEP,qryTABLES:TIB_Query;
begin
  try
    DataMod.CreateQuery(qryTABLE_DEP,nil,False,DataMod.dbaANA);
    DataMod.CreateQuery(qryTABLES,nil,False,DataMod.dbaMain);
    Result := True;
    with qryTABLE_DEP do
    begin
      sql.Add('SELECT * FROM TABLE_DEP WHERE TABLENAME = '+ SQL_Katar(Table_Name));
      Active := True;
      while not eof do
      begin
        qryTABLES.Close;
        qryTABLES.SQL.Clear;
        if FieldByName('ON_SART').AsInteger = 0 then
        begin
          qryTABLES.SQL.Add('SELECT COUNT(*) AS KAYITSAY FROM '+ FieldByName('F_TABLE').AsString + ' WHERE ' + FieldByName('F_FIELD').AsString + ' = '+ SQL_Katar(Value));
        end
        else
        begin
          qryTABLES.SQL.Add('SELECT COUNT(*) AS KAYITSAY FROM '+ FieldByName('F_TABLE').AsString + ' WHERE ' + FieldByName('SART_FIELD').AsString + ' = '+ SQL_Katar(FieldByName('SART_FIELD_VALUE').AsString) + ' AND '+FieldByName('F_FIELD').AsString + ' = '+ SQL_Katar(Value));
        end;
        try
          qryTABLES.Open;
          if qryTABLES.FieldByName('KAYITSAY').AsInteger > 0 then
          begin
            Result := False;
            Msg := FieldByName('F_TABLE').AsString + ' tablosunun ' + FieldByName('F_FIELD').AsString +
                   ' sahasýnda '+ Value + ' deðerinde ' + qryTABLES.FieldByName('KAYITSAY').AsString +
                   ' adet kayýt var. Kayýt Silinemez!';
            break;
          end;
        except
          Result := False;
          raise;
        end;
        next;
      end;
    end; // with end
  finally
    DataMod.ReleaseQuery(qryTABLE_DEP);
    DataMod.ReleaseQuery(qryTABLES);
  end;
end;

function TDataMod.Post_Update(Table_Name:String;OldValue:String;NewValue:String;Transaction:TIB_Transaction):Boolean;
// Tanýmlama tablolarýnýn After Post anýnda yapýlan kontrol
// Eðer Herhangi bir tabloda karþýlaþýlýrsa update iþlemi yapar
// Bu fonksiyon FB 1.5 versiyonundan itibaren Stored Procedure olacak
var
  qryTABLE_DEP,qryExecuter:TIB_Query;
  SqlStr:String;
  Dbb:String;
  Say:Integer;
begin
  if Trim(OldValue)='' then
  begin
    Result := True;
    Exit;
  end;

  if OldValue = NewValue then
  begin
    Result := True;
    Exit;
  end;

  if OldValue <> NewValue then
  begin
       Dbb:=glb_Db;
       if not glb_Con_Tip then Dbb:=glb_Server+':'+Dbb;
       say:=Un_Kul_con_Fb.kul_bul(glb_User,glb_Pass,Dbb);
       if  Say>2 then
       begin
         Application.MessageBox('Birden fazla kullanýcý baðlantýsý var. Tek Kullanýcý ile bu deðiþikliði uygulayýnýz.','Dikkat',MB_ICONWARNING);
         Result := True;

         Abort;
       end;
  end;

  try
    DataMod.CreateQuery(qryTABLE_DEP,nil,False,DataMod.dbaANA);
    if Transaction=Nil then
    begin
    if trnUpd.InTransaction then
    trnUpd.Rollback;
    trnUpd.StartTransaction;
    DataMod.CreateQuery(qryExecuter,trnUpd,False,DataMod.dbaMain)

    end
    else
    DataMod.CreateQuery(qryExecuter,Transaction,False,DataMod.dbaMain);

    Result := True;
    with qryTABLE_DEP do
    begin
      sql.Add('SELECT * FROM TABLE_DEP WHERE TABLENAME = '+ SQL_Katar(Table_Name));
      Active := True;
      qryTABLE_DEP.First;
      while not eof do
      begin
        if FieldByName('ON_SART').AsInteger = 0 then
        begin
          SqlStr := 'UPDATE '+ FieldByName('F_TABLE').AsString + ' SET '+ FieldByName('F_FIELD').AsString +' = '+ SQL_Katar(NewValue) + ' WHERE ' + FieldByName('F_FIELD').AsString + ' = '+ SQL_Katar(OldValue);
        end
        else
        begin
          SqlStr := 'UPDATE '+ FieldByName('F_TABLE').AsString + ' SET '+ FieldByName('F_FIELD').AsString +' = '+ SQL_Katar(NewValue) + ' WHERE ' + FieldByName('SART_FIELD').AsString + ' = '+ SQL_Katar(FieldByName('SART_FIELD_VALUE').AsString) + ' AND '+FieldByName('F_FIELD').AsString + ' = '+ SQL_Katar(OldValue);
        end;
        try
          with qryExecuter do
          begin
            SQL.Clear;
            SQL.Add(SqlStr);
            Execute;
          end;
        except
          if Transaction=Nil then
          trnUpd.Rollback;

          Application.MessageBox(Pchar(sqlstr),'SQL Cümlesi',MB_ICONHAND);
          Result := False;
          raise;
        end;
        Next;
      end;
    end; // with end
  finally
    if Transaction=Nil then
    if trnUpd.InTransaction then
    trnUpd.Commit;

    DataMod.ReleaseQuery(qryTABLE_DEP);
    DataMod.ReleaseQuery(qryExecuter);
  end;
end;

function TDataMod.GET_SERVER_DATE:TDate;
begin
  SP_GET_SERVER_DATE_TIME.Execute;
  Result := SP_GET_SERVER_DATE_TIME.FieldByName('SDATE').AsDate;
  SP_GET_SERVER_DATE_TIME.Close;
end;

function TDataMod.GET_SERVER_DATETIME:TDateTime;
begin
  SP_GET_SERVER_DATE_TIME.Execute;
  Result := SP_GET_SERVER_DATE_TIME.FieldByName('SDATETIME').AsDateTime;
  SP_GET_SERVER_DATE_TIME.Close;
end;

function TDataMod.IsDateInTerm(Value:TDateTime;FieldName:String):Boolean;
var
  Msg:PChar;
  {Yapýlan iþlemin Dönem baþlangýç ve Bitiþ tarihleri içinde olup olmadýðýný belirler}
begin
  case CompareDate(Value,glb_DONEM_BAS) of
  -1:
    begin
      Msg:= PChar(FieldName + ' sahasýna girdiðiniz ' +DateToStr(Value) + ' Tarihi dönem baþlangýç tarihiniz olan ' + DateToStr(glb_DONEM_BAS) + ' tarihinden küçük yinede devam etmek istiyor musunuz ?');
      if Application.MessageBox(msg,'Dikkat',MB_ICONQUESTION + MB_YESNO) = ID_YES then
      begin
        Result := True
      end
      else
      begin
        Result := False;
      end;
    end;
  0,1:
    begin
      if CompareDate(Value,glb_DONEM_SON) = 1 then
      begin
        Msg:= PChar(FieldName + ' sahasýna girdiðiniz ' + DateToStr(Value) + ' Tarihi dönem bitiþ tarihiniz olan ' + DateToStr(glb_DONEM_SON) + ' tarihinden büyük yinede devam etmek istiyor musunuz ?');
        if Application.MessageBox(msg,'Dikkat',MB_ICONQUESTION + MB_YESNO) = ID_YES then
        begin
          Result := True
        end
        else
        begin
          Result := False;
        end;
      end
      else
      begin
        Result := True;
      end;
    end;
  end;
end;

procedure TDataMod.CreateQuery(Var Query:TIB_Query;Transaction:TIB_Transaction;RequestLive:Boolean;Connection:TIB_Connection);
begin
  Query := TIB_Query.Create(Self);
  Query.IB_Connection := Connection;
  if Transaction <> Nil then Query.IB_Transaction := Transaction;
  Query.RequestLive := RequestLive;
  Query.ReadOnly := Not RequestLive;
end;

Procedure TDataMod.ReleaseQuery(var Query:TIB_Query);
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

procedure TDataMod.CreateTransaction(var Transaction:TIB_Transaction;IsolationLevel:TIB_Isolation;Connection:TIB_Connection);
begin
  Transaction := TIB_Transaction.Create(Self);
  Transaction.Isolation := IsolationLevel;
  Transaction.IB_Connection := Connection;
end;

procedure TDataMod.ReleaseTransaction(var Transaction:TIB_Transaction);
begin
  if Transaction <> nil then
  begin
    if Transaction.InTransaction then Transaction.Rollback;
    Transaction.Free;
  end;
end;

procedure TDataMod.CreateCursor(var Cursor:TIB_Cursor;Transaction:TIB_Transaction;RequestLive:Boolean;Connection:TIB_Connection);
begin
  Cursor := TIB_Cursor.Create(Self);
  Cursor.IB_Connection := Connection;
  if Transaction <> nil then Cursor.IB_Transaction := Transaction;
  Cursor.RequestLive := RequestLive;
  Cursor.ReadOnly := Not RequestLive;
end;

procedure TDataMod.ReleaseCursor(Var Cursor:TIB_Cursor);
begin
  if Cursor <> Nil then
  begin
    if Cursor.Active then Cursor.Close;
    Cursor.Free;
  end;
end;

procedure TDataMod.LoadDovizLists;
var
  qryDOVKART:TIB_Query;
begin
  glb_DOV_LIST.Clear;
  glb_TAK_DOV_LIST.Clear;
  DataMod.CreateQuery(qryDOVKART,Nil,False,DataMod.dbaMain);
  qryDOVKART.SQL.Add('SELECT DOVKOD,TAKIP FROM DOVKART');
  qryDOVKART.Active := True;
  while not qryDOVKART.Eof do
  begin
//****************************************************************************//
    if qryDOVKART.FieldByName('DOVKOD').AsString = 'YTL' then
    begin
      if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2004')) <> 0 then
      begin
        glb_DOV_LIST.Add(Trim(qryDOVKART.FieldByName('DOVKOD').AsString));
      end
    end
    else
    if qryDOVKART.FieldByName('DOVKOD').AsString = 'TRL' then
    begin
      if CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = -1 then
      begin
        glb_DOV_LIST.Add(Trim(qryDOVKART.FieldByName('DOVKOD').AsString));
      end
    end
    else
    begin
      glb_DOV_LIST.Add(Trim(qryDOVKART.FieldByName('DOVKOD').AsString));
    end;
//****************************************************************************//
    if qryDOVKART.FieldByName('TAKIP').AsInteger = 1 then
       glb_TAK_DOV_LIST.Add(Trim(qryDOVKART.FieldByName('DOVKOD').AsString));
//****************************************************************************//
    qryDOVKART.Next;
//****************************************************************************//
  end;
  DataMod.ReleaseQuery(qryDOVKART);
end;

Function TDataMod.CARIHAR_DOV_ADDUPDATE(Transaction:TIB_Transaction;
                                        PRM_CARIHARID,PRM_CARIHAR_SID:INTEGER;
                                        PRM_DOVKOD:String;
                                        PRM_TUTAR,
                                        PRM_DOVKUR:Currency;
                                        PRM_DOV_BAZ_TAR:TDate;
                                        SenderProc:String):Boolean;
var i:Integer;
    qryCARIHAR_DOV:TIB_Query;
    TUTAR_DOV:Currency;
begin
  try
    try
      if glb_DOVTAKIP then
      begin
        DataMod.CreateQuery(qryCARIHAR_DOV,Transaction,False,DataMod.dbaMain);
        for i := 0 to glb_TAK_DOV_LIST.Count -1 do
        begin
          Result:= DataMod.KurluDonustur(PRM_DOV_BAZ_TAR,PRM_DOVKOD,PRM_DOVKUR,glb_TAK_DOV_LIST[i],PRM_TUTAR,glb_SATISKUR,True,TUTAR_DOV);
          if not Result then Exit;
          qryCARIHAR_DOV.SQL.Clear;
          qryCARIHAR_DOV.SQL.Add('INSERT INTO CARIHAR_DOV (CARIHAR_DOV_ID,CARIHAR_DOV_SID, CARIHAR_ID, CARIHAR_SID, DOVKOD,TUTAR) ' +
          'VALUES ('+ IntToStr(qryCARIHAR_DOV.Gen_ID('GEN_CARIHAR_DOV',1)) + ','+ IntToStr(glb_SID) +','+ IntToStr(PRM_CARIHARID) +','+ IntToStr(PRM_CARIHAR_SID) +
          ' ,'+ SQL_Katar(glb_TAK_DOV_LIST[i]) +','+ SQL_Para(TUTAR_DOV)+')');
          qryCARIHAR_DOV.Execute;
        end;
      end;
      Result := True;
    except
      Result := False;
      Application.MessageBox('Exception Oluþan Yordam :TDataMod.CARIHAR_DOV_ADDUPDATE','Dikkat', MB_ICONHAND);
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARIHAR_DOV);
  end;
end;

Function TDataMod.CARI_BA_UPDATE(Transaction:TIB_Transaction;
                                 PRM_CARI_KOD:String;
                                 PRM_DOV_BAZ_TAR:TDate;
                                 PRM_DOVKOD:String;
                                 PRM_DOVKUR,
                                 PRM_TUTAR,
                                 PRM_TUTAR_VPB:Currency;
                                 PRM_BA:Char;
                                 SenderProc:String;
                                 Var PRM_LIMIT_ASIMI:Boolean):Boolean;
var
  qryCARI:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryCARI,Transaction,True,DataMod.dbaMain);
      Result :=CARI_DOV_ADDUPDATE(Transaction,PRM_CARI_KOD,PRM_DOV_BAZ_TAR,PRM_BA,PRM_DOVKOD,PRM_DOVKUR,PRM_TUTAR,SenderProc + 'CARI_BA_UPDATE:');
      if not Result then Exit;
      qryCARI.SQL.Add('SELECT CARI_KOD,BORC,ALACAK,RISK,KREDILMT FROM CARI WHERE CARI_KOD = ' + SQL_Katar(PRM_CARI_KOD));
      qryCARI.Open;
      if qryCARI.RecordCount <> 0 then
      begin
        qryCARI.Edit;
        if PRM_BA = BORC then
        begin
          if qryCARI.FieldByName('KREDILMT').AsCurrency > 0 then
          begin
            qryCARI.FieldByName('RISK').AsCurrency := qryCARI.FieldByName('RISK').AsCurrency + PRM_TUTAR_VPB;
            PRM_LIMIT_ASIMI := (qryCARI.FieldByName('RISK').AsCurrency > qryCARI.FieldByName('KREDILMT').AsCurrency)
          end
          else PRM_LIMIT_ASIMI := False;
          qryCARI.FieldByName('BORC').AsCurrency := qryCARI.FieldByName('BORC').AsCurrency + PRM_TUTAR_VPB;
        end
        else
        begin
          if qryCARI.FieldByName('KREDILMT').AsCurrency > 0 then
          begin
            qryCARI.FieldByName('RISK').AsCurrency := qryCARI.FieldByName('RISK').AsCurrency - PRM_TUTAR_VPB;
          end;
          PRM_LIMIT_ASIMI := False;
          qryCARI.FieldByName('ALACAK').AsCurrency := qryCARI.FieldByName('ALACAK').AsCurrency + PRM_TUTAR_VPB;
        end;
        qryCARI.Post;
      end;
      Result := True;
    except
      Result := False;
      Application.MessageBox('Exception Oluþan Yordam :TDataMod.CARI_BA_UPDATE','Dikkat', MB_ICONHAND);
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARI);
  end;
end;

Function TDataMod.CARI_DOV_ADDUPDATE(Transaction:TIB_Transaction;
                                     PRM_CARI_KOD:String;
                                     PRM_DOV_BAZ_TAR:TDate;
                                     PRM_BA:Char;
                                     PRM_DOVKOD:String;
                                     PRM_DOVKUR,
                                     PRM_TUTAR:Currency;
                                     SenderProc:String):Boolean;
var
  i:Integer;
  qryCARI:TIB_Query;
  TUTAR_DOV:Currency;
begin
  try
    try
      if glb_DOVTAKIP then
      begin
        DataMod.CreateQuery(qryCARI,Transaction,True,DataMod.dbaMain);
        for i := 0 to glb_TAK_DOV_LIST.Count -1 do
        begin
          Result:= DataMod.KurluDonustur(PRM_DOV_BAZ_TAR,PRM_DOVKOD,PRM_DOVKUR,glb_TAK_DOV_LIST[i],PRM_TUTAR,glb_SATISKUR,True,TUTAR_DOV);
          if not Result then Exit;
          qryCARI.Close;
          qryCARI.SQL.Clear;
          qryCARI.SQL.Add('SELECT * FROM CARI_DOV WHERE CARI_KOD = '+ SQL_Katar(PRM_CARI_KOD) + ' AND DOVKOD = ' + SQL_Katar(glb_TAK_DOV_LIST[i]));
          qryCARI.Open;
          if qryCARI.RecordCount = 0 then
          begin
            qryCARI.Insert;
            qryCARI.FieldByName('CARI_KOD').AsString := Trim(PRM_CARI_KOD);
            qryCARI.FieldByName('DOVKOD').AsString := glb_TAK_DOV_LIST[i];
            qryCARI.FieldByName('KREDILMT').AsCurrency := 0;
            qryCARI.FieldByName('RISK').AsCurrency := 0;
            qryCARI.FieldByName('BORC').AsCurrency := 0;
            qryCARI.FieldByName('ALACAK').AsCurrency := 0;
            qryCARI.FieldByName('DEVREDEN_BORC').AsCurrency := 0;
            qryCARI.FieldByName('DEVREDEN_ALACAK').AsCurrency := 0;
          end
          else
            qryCARI.Edit;

            if PRM_BA = BORC then
            begin
              qryCARI.FieldByName('BORC').AsCurrency := qryCARI.FieldByName('BORC').AsCurrency + TUTAR_DOV;
            end
            else
            begin
              qryCARI.FieldByName('ALACAK').AsCurrency := qryCARI.FieldByName('ALACAK').AsCurrency + TUTAR_DOV;
            end;
            qryCARI.Post;
        end;
      end;
      Result := True;
    except
      Result := False;
      Application.MessageBox('Exception Oluþan Yordam :TDataMod.CARI_DOV_ADDUPDATE','Dikkat', MB_ICONHAND);
      Raise;
    end;
  finally
     DataMod.ReleaseQuery(qryCARI);
  end;
end;

procedure TDataMod.SubeADIDYukle;
var
  qrySUBE:TIB_Query;
  i : integer;
begin
  DataMod.CreateQuery(qrySUBE,nil,False,DataMod.dbaANA);
  qrySUBE.SQL.Add('SELECT SUBE_ID,ADI FROM SUBE WHERE SIRKET_ID ='+IntToStr(glb_SIRKET_ID)+' ORDER BY VARSAYILAN DESC');
  qrySUBE.Active := True;
  SetLength(glb_Sube_ID_AD,qrySUBE.RecordCount+1);
  glb_Sube_ID_AD[0].Sube_Id := 0;
  glb_Sube_ID_AD[0].Sube_Ad := 'HEPSÝ';
  qrySUBE.First;
  i := 1;
  while not qrySUBE.Eof do
  begin
    with glb_Sube_ID_AD[i] do
    begin
      Sube_Id := qrySUBE.FieldByName('SUBE_ID').AsInteger;
      Sube_Ad := qrySUBE.FieldByName('ADI').AsString;
    end;
    inc(i);
    qrySUBE.Next;
  end;
  DataMod.ReleaseQuery(qrySUBE);
end;

procedure TDataMod.FillSubeStr(strLst : TStrings);
var
  i : integer;
begin
  strLst.Clear;
  for i := 0 to Length(glb_Sube_ID_AD)-1 do
  begin
    strLst.Add(glb_Sube_ID_AD[i].Sube_Ad);
  end;
end;


function TDataMod.SubeID2Ad(Yazici:Boolean;ID:Integer):String;
begin
//sube id = 0 hepsi
//sube id = 1 izmir
//geçici olarak yapýldý
//izmirdeki faturalar üzerinde sube adý IZMIR diye yazýldðý
//için ve fatura üzerine tekrar izmir diye yazdýrmamak için
//ID 0 ve 1 olarak gelirse fonksiyondan geriye boþluk dönüyor.
//su anda izmirde kullanýlan faturalar bittiðinde buradaki
//id = 1 kaldýrýlacak ve izmirdede izmir gelecek.
{
  if Yazici then
  begin
    if (ID = 0) or (ID = 1) then
    begin
      Result := '';
      Exit;
    end
    else
    begin
      Result := glb_Sube_ID_AD[ID].Sube_Ad + ' - ';
    end;
  end
  else
  begin
    Result := glb_Sube_ID_AD[ID].Sube_Ad;
  end;
}
  Result := glb_Sube_ID_AD[ID].Sube_Ad;
end;


function TDataMod.SubeAd2ID(ad:String):String;
var
  qrySubeKontrol : TIB_Query;
begin
  if ad = 'HEPSÝ' then
  begin
    Result := '0';
    Exit;
  end;
  DataMod.CreateQuery(qrySubeKontrol,nil,False,DataMod.dbaANA);
  with qrySubeKontrol do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT SUBE_ID FROM SUBE WHERE ADI = '+SQL_Katar(ad));
    Active := True;
  end;
  Result := qrySubeKontrol.FieldByName('SUBE_ID').AsString;
end;

Function TDataMod.CARI_AY_ADDUPDATE(Transaction:TIB_Transaction;
                                     PRM_CARI_KOD:String;
                                     PRM_TARIH,PRM_DOV_BAZ_TAR:TDate;
                                     PRM_BA:Char;
                                     PRM_DOVKOD:String;
                                     PRM_DOVKUR,
                                     PRM_TUTAR_VPB,PRM_TUTAR:Currency;
                                     SenderProc:String):Boolean;
var
  i:Integer;
  qryCARI_AY:TIB_Query;
  TUTAR_DOV:Currency;
  AY,YIL,GUN:Word;
begin
  try
    try
      DecodeDate(PRM_TARIH,YIL,AY,GUN);
      DataMod.CreateQuery(qryCARI_AY,Transaction,True,DataMod.dbaMain);
      qryCARI_AY.SQL.Add('SELECT * FROM CARI_AY WHERE CARI_KOD = ' + SQL_Katar(PRM_CARI_KOD) + ' AND DOVKOD = '+ SQL_Katar(glb_DEFCUR) + ' AND YIL = ' + IntToStr(YIL) + ' AND AY = ' + IntToStr(AY));
      qryCARI_AY.Open;
      if qryCARI_AY.RecordCount = 0 then
      begin
        qryCARI_AY.Insert;
        qryCARI_AY.FieldByName('CARI_KOD').AsString := Trim(PRM_CARI_KOD);
        qryCARI_AY.FieldByName('DOVKOD').AsString := Trim(glb_DEFCUR);
        qryCARI_AY.FieldByName('YIL').AsInteger := YIL;
        qryCARI_AY.FieldByName('AY').AsInteger := AY;
        qryCARI_AY.FieldByName('BORC').AsCurrency := 0;
        qryCARI_AY.FieldByName('ALACAK').AsCurrency := 0;
      end
      else
        qryCARI_AY.Edit;

      if PRM_BA = BORC then
      begin
        qryCARI_AY.FieldByName('BORC').AsCurrency := qryCARI_AY.FieldByName('BORC').AsCurrency + PRM_TUTAR_VPB;
      end
      else
      begin
        qryCARI_AY.FieldByName('ALACAK').AsCurrency := qryCARI_AY.FieldByName('ALACAK').AsCurrency + PRM_TUTAR_VPB;
      end;

      qryCARI_AY.Post;

      if glb_DOVTAKIP then
      begin
        for i := 0 to glb_TAK_DOV_LIST.Count -1 do
        begin
          Result := DataMod.KurluDonustur(PRM_DOV_BAZ_TAR,PRM_DOVKOD,PRM_DOVKUR,glb_TAK_DOV_LIST[i],PRM_TUTAR,glb_SATISKUR,True,TUTAR_DOV);
          if not Result then Exit;
          qryCARI_AY.Close;
          qryCARI_AY.SQL.Clear;
          qryCARI_AY.SQL.Add('SELECT * FROM CARI_AY WHERE CARI_KOD = ' + SQL_Katar(PRM_CARI_KOD) + ' AND DOVKOD = '+ SQL_Katar(glb_TAK_DOV_LIST[i]) + ' AND YIL = ' + IntToStr(YIL) + ' AND AY = ' + IntToStr(AY));
          qryCARI_AY.Open;
          if qryCARI_AY.RecordCount = 0 then
          begin
            qryCARI_AY.Insert;
            qryCARI_AY.FieldByName('CARI_KOD').AsString := Trim(PRM_CARI_KOD);
            qryCARI_AY.FieldByName('DOVKOD').AsString := Trim(glb_TAK_DOV_LIST[i]);
            qryCARI_AY.FieldByName('YIL').AsInteger := YIL;
            qryCARI_AY.FieldByName('AY').AsInteger := AY;
            qryCARI_AY.FieldByName('BORC').AsCurrency := 0;
            qryCARI_AY.FieldByName('ALACAK').AsCurrency := 0;
          end
          else
            qryCARI_AY.Edit;

          if PRM_BA = BORC then
          begin
            qryCARI_AY.FieldByName('BORC').AsCurrency := qryCARI_AY.FieldByName('BORC').AsCurrency + TUTAR_DOV;
          end
          else
          begin
            qryCARI_AY.FieldByName('ALACAK').AsCurrency := qryCARI_AY.FieldByName('ALACAK').AsCurrency + TUTAR_DOV;
          end;

          qryCARI_AY.Post;
        end; // for end;
      end;
      Result := True;
      qryCARI_AY.Close;
    except
      Result := False;
      Application.MessageBox('Exception Oluþan Yordam :TDataMod.CARI_AY_ADDUPDATE','Dikkat', MB_ICONHAND);
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryCARI_AY);
  end;
end;


Function TDataMod.PERSONEL_BA_UPDATE(Transaction:TIB_Transaction; PRM_PERSONEL_KOD:String; PRM_TUTAR_VPB:Currency;PRM_BA:Char):Boolean;
var
  qryPERSONEL:TIB_Query;
  Msg:Pchar;
begin
  try
    try
      DataMod.CreateQuery(qryPERSONEL,Transaction,True,DataMod.dbaMain);
      qryPERSONEL.SQL.Add('SELECT BORC,ALACAK FROM PERSONEL WHERE PERSONEL_KOD = ' + SQL_Katar(PRM_PERSONEL_KOD));
      qryPERSONEL.Open;
      if qryPERSONEL.RecordCount <> 0 then
      begin
        qryPERSONEL.Edit;
        if PRM_BA = BORC then
        begin
          qryPERSONEL.FieldByName('BORC').AsCurrency := qryPERSONEL.FieldByName('BORC').AsCurrency + PRM_TUTAR_VPB;
        end
        else
        begin
          qryPERSONEL.FieldByName('ALACAK').AsCurrency := qryPERSONEL.FieldByName('ALACAK').AsCurrency + PRM_TUTAR_VPB;
        end;
        qryPERSONEL.Post;
      end
      else
      begin
        Msg := Pchar(PRM_PERSONEL_KOD + ' Kodu Personel olarak tanýmlý deðil. Yanlýþ Kod girilmiþ');
        Application.MessageBox(Msg,'Dikkat', MB_ICONHAND);
        Result := False;
        Exit;
      end;
      Result := True;
    except
      Result := False;
      Application.MessageBox('Exception Oluþan Yordam :TDataMod.CARI_BA_UPDATE','Dikkat', MB_ICONHAND);
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryPERSONEL);
  end;
end;



Function TDataMod.PERSONELHAR_AUD(Transaction:TIB_Transaction;
                                PRM_BELGETUR:Integer;
                                PRM_BELGE_ID:Integer;
                                PRM_BELGE_SID:Integer;
                                PRM_SIRA_NO:Byte;
                                PRM_PERSONEL_KOD:String;
                                PRM_BA:CHAR;
                                PRM_TARIH:TDateTime;
                                PRM_DOV_BAZ_TAR:TDateTime;
                                PRM_TUTAR:Currency;
                                PRM_DOVKOD:String;
                                PRM_DOVKUR:Currency;
                                PRM_TUTAR_VPB:Currency;
                                PRM_ACIKLAMA:String;
                                PRM_SIL:Byte;
                                PRM_MASRAF_MERK,
                                PRM_KOD1,
                                PRM_KOD2,
                                PRM_KOD3,
                                PRM_KOD4:String;
                                var PRM_PERSONELHAR_ID:Integer;
                                var PRM_PERSONELHAR_SID:Integer):Boolean;
var
  qryPERSONELHAR:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryPERSONELHAR,Transaction,True,DataMod.dbaMain);
      qryPERSONELHAR.SQL.Add('SELECT * FROM PERSONEL_HAR WHERE BELGE_TUR = '+ IntToStr(PRM_BELGETUR) + ' AND BELGE_ID = '+ IntToStr(PRM_BELGE_ID) + ' AND BELGE_SID = ' + IntToStr(PRM_BELGE_SID) + ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO));
      qryPERSONELHAR.Open;
      if qryPERSONELHAR.RecordCount > 0 then
      begin
        Result := PERSONEL_BA_UPDATE(Transaction,
                       qryPERSONELHAR.FieldByName('PERSONEL_KOD').AsString,
                       -qryPERSONELHAR.FieldByName('TUTAR_VPB').AsCurrency,
                       qryPERSONELHAR.FieldByName('BA').AsString[1]);
        if not Result then Exit;
        if PRM_SIL <> 1 then // SILME ÝÞLEMÝ
        begin
          qryPERSONELHAR.Edit
        end
        else
        begin
          qryPERSONELHAR.Delete; // SILME ÝÞLEMÝnin fiilen olduu yer.
          Result := True;
          Exit;
        end;
      end
      else
      begin
        if PRM_SIL = 1 then
        begin
          Result := True;
          PRM_PERSONELHAR_ID := 0;
          PRM_PERSONELHAR_SID:= 0;
          Exit;
        end;
        qryPERSONELHAR.Insert;
        qryPERSONELHAR.FieldByName('PERSONELHAR_ID').AsInteger := qryPERSONELHAR.Gen_ID('GEN_PERSONELHAR',1);
        qryPERSONELHAR.FieldByName('PERSONELHAR_SID').AsInteger := glb_SID;
      end;

      if Trim(PRM_PERSONEL_KOD)='' then
      begin
            qryPERSONELHAR.Cancel;
            Result := True;
            Exit;
      end;

      PRM_PERSONELHAR_ID := qryPERSONELHAR.FieldByName('PERSONELHAR_ID').AsInteger;
      PRM_PERSONELHAR_SID := qryPERSONELHAR.FieldByName('PERSONELHAR_SID').AsInteger;
      qryPERSONELHAR.FieldByName('PERSONEL_KOD').AsString := Trim(PRM_PERSONEL_KOD);
      qryPERSONELHAR.FieldByName('BA').AsString := PRM_BA;
      qryPERSONELHAR.FieldByName('BELGE_TUR').AsInteger := PRM_BELGETUR;
      qryPERSONELHAR.FieldByName('BELGE_ID').AsInteger := PRM_BELGE_ID;
      qryPERSONELHAR.FieldByName('BELGE_SID').AsInteger := PRM_BELGE_SID;
      qryPERSONELHAR.FieldByName('SIRA_NO').AsInteger := PRM_SIRA_NO;
      qryPERSONELHAR.FieldByName('TARIH').AsDate := PRM_TARIH;
      qryPERSONELHAR.FieldByName('DOV_BAZ_TAR').AsDate := PRM_DOV_BAZ_TAR;
      qryPERSONELHAR.FieldByName('DOVKOD').AsString := Trim(PRM_DOVKOD);
      qryPERSONELHAR.FieldByName('DOVKUR').AsCurrency := PRM_DOVKUR;
      qryPERSONELHAR.FieldByName('TUTAR').AsCurrency := PRM_TUTAR;
      qryPERSONELHAR.FieldByName('TUTAR_VPB').AsCurrency := PRM_TUTAR_VPB;
      qryPERSONELHAR.FieldByName('ACIKLAMA').AsString := Trim(PRM_ACIKLAMA);
      qryPERSONELHAR.FieldByName('MASRAF_MERK').AsString := Trim(PRM_MASRAF_MERK);
      qryPERSONELHAR.FieldByName('KOD1').AsString := Trim(PRM_KOD1);
      qryPERSONELHAR.FieldByName('KOD2').AsString := Trim(PRM_KOD2);
      qryPERSONELHAR.FieldByName('KOD3').AsString := Trim(PRM_KOD3);
      qryPERSONELHAR.FieldByName('KOD4').AsString := Trim(PRM_KOD4);
      qryPERSONELHAR.Post;
      Result := PERSONEL_BA_UPDATE(Transaction,
                                 qryPERSONELHAR.FieldByName('PERSONEL_KOD').AsString,
                                 qryPERSONELHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                 qryPERSONELHAR.FieldByName('BA').AsString[1]);
      if not Result then Exit;

      Result := True;
    except
      PRM_PERSONELHAR_ID := 0;
      PRM_PERSONELHAR_SID := 0;
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryPERSONELHAR);
  end;
end;





Function TDataMod.ARAC_BA_UPDATE(Transaction:TIB_Transaction; PRM_ARAC_KOD:String; PRM_TUTAR_VPB:Currency;PRM_BA:Char):Boolean;
var
  qryARAC:TIB_Query;
  Msg:Pchar;
begin
  try
    try
      DataMod.CreateQuery(qryARAC,Transaction,True,DataMod.dbaMain);
      qryARAC.SQL.Add('SELECT BORC,ALACAK FROM ARAC WHERE ARAC_KOD = ' + SQL_Katar(PRM_ARAC_KOD));
      qryARAC.Open;
      if qryARAC.RecordCount <> 0 then
      begin
        qryARAC.Edit;
        if PRM_BA = BORC then
        begin
          qryARAC.FieldByName('BORC').AsCurrency := qryARAC.FieldByName('BORC').AsCurrency + PRM_TUTAR_VPB;
        end
        else
        begin
          qryARAC.FieldByName('ALACAK').AsCurrency := qryARAC.FieldByName('ALACAK').AsCurrency + PRM_TUTAR_VPB;
        end;
        qryARAC.Post;
      end
      else
      begin
        Msg := Pchar(PRM_ARAC_KOD + ' Kodu Araç olarak tanýmlý deðil. Yanlýþ Kod girilmiþ');
        Application.MessageBox(Msg,'Dikkat', MB_ICONHAND);
        Result := False;
        Exit;
      end;
      Result := True;
    except
      Result := False;
      Application.MessageBox('Exception Oluþan Yordam :TDataMod.CARI_BA_UPDATE','Dikkat', MB_ICONHAND);
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryARAC);
  end;
end;



Function TDataMod.ARACHAR_AUD(Transaction:TIB_Transaction;
                                PRM_BELGETUR:Integer;
                                PRM_BELGE_ID:Integer;
                                PRM_BELGE_SID:Integer;
                                PRM_SIRA_NO:Byte;
                                PRM_ARAC_KOD:String;
                                PRM_BA:CHAR;
                                PRM_TARIH:TDateTime;
                                PRM_DOV_BAZ_TAR:TDateTime;
                                PRM_TUTAR:Currency;
                                PRM_DOVKOD:String;
                                PRM_DOVKUR:Currency;
                                PRM_TUTAR_VPB:Currency;
                                PRM_ACIKLAMA:String;
                                PRM_SIL:Byte;
                                PRM_MASRAF_MERK,
                                PRM_KOD1,
                                PRM_KOD2,
                                PRM_KOD3,
                                PRM_KOD4:String;
                                var PRM_ARACHAR_ID:Integer;
                                var PRM_ARACHAR_SID:Integer):Boolean;
var
  qryARACHAR:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryARACHAR,Transaction,True,DataMod.dbaMain);
      qryARACHAR.SQL.Add('SELECT * FROM ARACHAR WHERE BELGE_TUR = '+ IntToStr(PRM_BELGETUR) + ' AND BELGE_ID = '+ IntToStr(PRM_BELGE_ID) + ' AND BELGE_SID = ' + IntToStr(PRM_BELGE_SID) + ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO));
      qryARACHAR.Open;
      if qryARACHAR.RecordCount > 0 then
      begin
        Result := ARAC_BA_UPDATE(Transaction,
                       qryARACHAR.FieldByName('ARAC_KOD').AsString,
                       -qryARACHAR.FieldByName('TUTAR_VPB').AsCurrency,
                       qryARACHAR.FieldByName('BA').AsString[1]);
        if not Result then Exit;
        if PRM_SIL <> 1 then // SILME ÝÞLEMÝ
        begin
          qryARACHAR.Edit
        end
        else
        begin
          qryARACHAR.Delete; // SILME ÝÞLEMÝnin fiilen olduu yer.
          Result := True;
          Exit;
        end;
      end
      else
      begin
        if PRM_SIL = 1 then
        begin
          Result := True;
          PRM_ARACHAR_ID := 0;
          PRM_ARACHAR_SID:= 0;
          Exit;
        end;
        qryARACHAR.Insert;
        qryARACHAR.FieldByName('ARACHAR_ID').AsInteger := qryARACHAR.Gen_ID('GEN_ARACHAR',1);
        qryARACHAR.FieldByName('ARACHAR_SID').AsInteger := glb_SID;
      end;

      if Trim(PRM_ARAC_KOD)='' then
      begin
            qryARACHAR.Cancel;
            Result := True;
            Exit;
      end;

      PRM_ARACHAR_ID := qryARACHAR.FieldByName('ARACHAR_ID').AsInteger;
      PRM_ARACHAR_SID := qryARACHAR.FieldByName('ARACHAR_SID').AsInteger;
      qryARACHAR.FieldByName('ARAC_KOD').AsString := Trim(PRM_ARAC_KOD);
      qryARACHAR.FieldByName('BA').AsString := PRM_BA;
      qryARACHAR.FieldByName('BELGE_TUR').AsInteger := PRM_BELGETUR;
      qryARACHAR.FieldByName('BELGE_ID').AsInteger := PRM_BELGE_ID;
      qryARACHAR.FieldByName('BELGE_SID').AsInteger := PRM_BELGE_SID;
      qryARACHAR.FieldByName('SIRA_NO').AsInteger := PRM_SIRA_NO;
      qryARACHAR.FieldByName('TARIH').AsDate := PRM_TARIH;
      qryARACHAR.FieldByName('DOV_BAZ_TAR').AsDate := PRM_DOV_BAZ_TAR;
      qryARACHAR.FieldByName('DOVKOD').AsString := Trim(PRM_DOVKOD);
      qryARACHAR.FieldByName('DOVKUR').AsCurrency := PRM_DOVKUR;
      qryARACHAR.FieldByName('TUTAR').AsCurrency := PRM_TUTAR;
      qryARACHAR.FieldByName('TUTAR_VPB').AsCurrency := PRM_TUTAR_VPB;
      qryARACHAR.FieldByName('ACIKLAMA').AsString := Trim(PRM_ACIKLAMA);
      qryARACHAR.FieldByName('MASRAF_MERK').AsString := Trim(PRM_MASRAF_MERK);
      qryARACHAR.FieldByName('KOD1').AsString := Trim(PRM_KOD1);
      qryARACHAR.FieldByName('KOD2').AsString := Trim(PRM_KOD2);
      qryARACHAR.FieldByName('KOD3').AsString := Trim(PRM_KOD3);
      qryARACHAR.FieldByName('KOD4').AsString := Trim(PRM_KOD4);
      qryARACHAR.Post;
      Result := ARAC_BA_UPDATE(Transaction,
                                 qryARACHAR.FieldByName('ARAC_KOD').AsString,
                                 qryARACHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                 qryARACHAR.FieldByName('BA').AsString[1]);
      if not Result then Exit;

      Result := True;
    except
      PRM_ARACHAR_ID := 0;
      PRM_ARACHAR_SID := 0;
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryARACHAR);
  end;
end;


Function TDataMod.MASRAF_BA_UPDATE(Transaction:TIB_Transaction; PRM_MASRAF_KOD:String; PRM_TUTAR_VPB:Currency;PRM_BA:Char):Boolean;
var
  qryMASRAF:TIB_Query;
  Msg:Pchar;
begin
  try
    try
      DataMod.CreateQuery(qryMASRAF,Transaction,True,DataMod.dbaMain);
      qryMASRAF.SQL.Add('SELECT BORC,ALACAK FROM MASRAF WHERE MASRAF_KOD = ' + SQL_Katar(PRM_MASRAF_KOD));
      qryMASRAF.Open;
      if qryMASRAF.RecordCount <> 0 then
      begin
        qryMASRAF.Edit;
        if PRM_BA = BORC then
        begin
          qryMASRAF.FieldByName('BORC').AsCurrency := qryMASRAF.FieldByName('BORC').AsCurrency + PRM_TUTAR_VPB;
        end
        else
        begin
          qryMASRAF.FieldByName('ALACAK').AsCurrency := qryMASRAF.FieldByName('ALACAK').AsCurrency + PRM_TUTAR_VPB;
        end;
        qryMASRAF.Post;
      end
      else
      begin
        Msg := Pchar(PRM_MASRAF_KOD + ' Kodu Masraf olarak tanýmlý deðil. Yanlýþ Kod girilmiþ');
        Application.MessageBox(Msg,'Dikkat', MB_ICONHAND);
        Result := False;
        Exit;
      end;
      Result := True;
    except
      Result := False;
      Application.MessageBox('Exception Oluþan Yordam :TDataMod.CARI_BA_UPDATE','Dikkat', MB_ICONHAND);
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryMASRAF);
  end;
end;

Function TDataMod.MASRAFHAR_AUD(Transaction:TIB_Transaction;
                                PRM_BELGETUR:Integer;
                                PRM_BELGE_ID:Integer;
                                PRM_BELGE_SID:Integer;
                                PRM_SIRA_NO:Byte;
                                PRM_MASRAF_KOD:String;
                                PRM_BA:CHAR;
                                PRM_TARIH:TDateTime;
                                PRM_DOV_BAZ_TAR:TDateTime;
                                PRM_TUTAR:Currency;
                                PRM_DOVKOD:String;
                                PRM_DOVKUR:Currency;
                                PRM_TUTAR_VPB:Currency;
                                PRM_ACIKLAMA:String;
                                PRM_SIL:Byte;
                                PRM_MASRAF_MERK,
                                PRM_KOD1,
                                PRM_KOD2,
                                PRM_KOD3,
                                PRM_KOD4:String;
                                var PRM_MASRAFHAR_ID:Integer;
                                var PRM_MASRAFHAR_SID:Integer):Boolean;
var
  qryMASRAFHAR:TIB_Query;
begin
  try
    try
      DataMod.CreateQuery(qryMASRAFHAR,Transaction,True,DataMod.dbaMain);
      qryMASRAFHAR.SQL.Add('SELECT * FROM MASRAFHAR WHERE BELGE_TUR = '+ IntToStr(PRM_BELGETUR) + ' AND BELGE_ID = '+ IntToStr(PRM_BELGE_ID) + ' AND BELGE_SID = ' + IntToStr(PRM_BELGE_SID) + ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO));
      qryMASRAFHAR.Open;
      if qryMASRAFHAR.RecordCount > 0 then
      begin
        Result := MASRAF_BA_UPDATE(Transaction,
                       qryMASRAFHAR.FieldByName('MASRAF_KOD').AsString,
                       -qryMASRAFHAR.FieldByName('TUTAR_VPB').AsCurrency,
                       qryMASRAFHAR.FieldByName('BA').AsString[1]);
        if not Result then Exit;
        if PRM_SIL <> 1 then // SILME ÝÞLEMÝ
        begin
          qryMASRAFHAR.Edit
        end
        else
        begin
          qryMASRAFHAR.Delete; // SILME ÝÞLEMÝnin fiilen olduu yer.
          Result := True;
          Exit;
        end;
      end
      else
      begin
        if PRM_SIL = 1 then
        begin
          Result := True;
          PRM_MASRAFHAR_ID := 0;
          PRM_MASRAFHAR_SID:= 0;
          Exit;
        end;
        qryMASRAFHAR.Insert;
        qryMASRAFHAR.FieldByName('MASRAFHAR_ID').AsInteger := qryMASRAFHAR.Gen_ID('GEN_MASRAFHAR',1);
        qryMASRAFHAR.FieldByName('MASRAFHAR_SID').AsInteger := glb_SID;
      end;
      PRM_MASRAFHAR_ID := qryMASRAFHAR.FieldByName('MASRAFHAR_ID').AsInteger;
      PRM_MASRAFHAR_SID := qryMASRAFHAR.FieldByName('MASRAFHAR_SID').AsInteger;
      qryMASRAFHAR.FieldByName('MASRAF_KOD').AsString := Trim(PRM_MASRAF_KOD);
      qryMASRAFHAR.FieldByName('BA').AsString := PRM_BA;
      qryMASRAFHAR.FieldByName('BELGE_TUR').AsInteger := PRM_BELGETUR;
      qryMASRAFHAR.FieldByName('BELGE_ID').AsInteger := PRM_BELGE_ID;
      qryMASRAFHAR.FieldByName('BELGE_SID').AsInteger := PRM_BELGE_SID;
      qryMASRAFHAR.FieldByName('SIRA_NO').AsInteger := PRM_SIRA_NO;
      qryMASRAFHAR.FieldByName('TARIH').AsDate := PRM_TARIH;
      qryMASRAFHAR.FieldByName('DOV_BAZ_TAR').AsDate := PRM_DOV_BAZ_TAR;
      qryMASRAFHAR.FieldByName('DOVKOD').AsString := Trim(PRM_DOVKOD);
      qryMASRAFHAR.FieldByName('DOVKUR').AsCurrency := PRM_DOVKUR;
      qryMASRAFHAR.FieldByName('TUTAR').AsCurrency := PRM_TUTAR;
      qryMASRAFHAR.FieldByName('TUTAR_VPB').AsCurrency := PRM_TUTAR_VPB;
      qryMASRAFHAR.FieldByName('ACIKLAMA').AsString := Trim(PRM_ACIKLAMA);
      qryMASRAFHAR.FieldByName('MASRAF_MERK').AsString := Trim(PRM_MASRAF_MERK);
      qryMASRAFHAR.FieldByName('KOD1').AsString := Trim(PRM_KOD1);
      qryMASRAFHAR.FieldByName('KOD2').AsString := Trim(PRM_KOD2);
      qryMASRAFHAR.FieldByName('KOD3').AsString := Trim(PRM_KOD3);
      qryMASRAFHAR.FieldByName('KOD4').AsString := Trim(PRM_KOD4);
      qryMASRAFHAR.Post;
      Result := MASRAF_BA_UPDATE(Transaction,
                                 qryMASRAFHAR.FieldByName('MASRAF_KOD').AsString,
                                 qryMASRAFHAR.FieldByName('TUTAR_VPB').AsCurrency,
                                 qryMASRAFHAR.FieldByName('BA').AsString[1]);
      if not Result then Exit;

      Result := True;
    except
      PRM_MASRAFHAR_ID := 0;
      PRM_MASRAFHAR_SID := 0;
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryMASRAFHAR);
  end;
end;

Function TDataMod.LS_MASRAFTAN(var MasrafKod: String): Boolean;
var
  Kolonlar : TStringList;
begin
// Burak ÖZLER 18/12/2002
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('MASRAF_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('75');
  Kolonlar.Add('ADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('250');
  frmSrcDlg.Caption := 'Masraf Tanýmlama Listesi';
  frmSrcDlg.List(2, Kolonlar ,'SELECT MASRAF_KOD,ADI FROM MASRAF','',0,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    MasrafKod := (Kolonlar.Strings[0]);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
  Kolonlar.Free;
end;



Function TDataMod.OLCUBIRIM_DONUSTUR(PRM_FROM_BIRIM:String;PRM_FROM_BIRIM_DEGER:Currency; PRM_TO_BIRIM:String;var PRM_BIRIM_DEGER:Currency):Boolean;
var
  {NOT TESTED}
  qryTEMP:TIB_Query;
  FROM_TIP,TO_TIP:String;
  ErrMsg:Pchar;
  FROM_DEGERTODOM,TO_DEGERTODOM,DominantDeger:Currency;
begin
  try
    try
      Result := False;
      if (Trim(PRM_FROM_BIRIM) = Trim(PRM_TO_BIRIM)) then
      begin
        PRM_BIRIM_DEGER := PRM_FROM_BIRIM_DEGER;
        Result := True;
        Exit;
      end;
      // Bu bölümde iki Ölçü birimide select edilip tipleri çekiliyor.
      DataMod.CreateQuery(qryTEMP,Nil,False,DataMod.dbaMain);
      qryTEMP.SQL.Add('SELECT * FROM OLCUBIR WHERE OLCUBIRIM IN (' + SQL_Katar(PRM_FROM_BIRIM) + ',' + SQL_Katar(PRM_TO_BIRIM) + ')');
      qryTEMP.Open;
      if Trim(qryTEMP.FieldByName('OLCUBIRIM').AsString) = Trim(PRM_FROM_BIRIM) then
      begin
         FROM_TIP := Trim(qryTEMP.FieldByName('OLCU_TIP').AsString);
         FROM_DEGERTODOM := qryTEMP.FieldByName('DEGERTODOM').AsCurrency;
      end else
      begin
         TO_TIP := Trim(qryTEMP.FieldByName('OLCU_TIP').AsString);
         TO_DEGERTODOM := qryTEMP.FieldByName('DEGERTODOM').AsCurrency;
      end;
      qryTEMP.Next;
      if Trim(qryTEMP.FieldByName('OLCUBIRIM').AsString) = Trim(PRM_TO_BIRIM) then
      begin
         TO_TIP := Trim(qryTEMP.FieldByName('OLCU_TIP').AsString);
         TO_DEGERTODOM := qryTEMP.FieldByName('DEGERTODOM').AsCurrency;
      end else
      begin
         FROM_TIP := Trim(qryTEMP.FieldByName('OLCU_TIP').AsString);
         FROM_DEGERTODOM := qryTEMP.FieldByName('DEGERTODOM').AsCurrency;
      end;
      //Farklý Tipler Birbirine dönüþtürülemez Adet - Hacim Gibi
      if FROM_TIP <> TO_TIP then
      begin
        ErrMsg := Pchar('Ölçü Birim Dönüþtürme Hatasý:' + FROM_TIP + ' ve ' + TO_TIP +' arasýnda birim dönüþümü yapýlamaz.');
        Application.MessageBox(ErrMsg,'Dikkat',MB_ICONWARNING);
        Exit;
      end;
      DominantDeger := PRM_FROM_BIRIM_DEGER * FROM_DEGERTODOM;
      PRM_BIRIM_DEGER := DominantDeger / TO_DEGERTODOM;
      qryTEMP.Close;
      Result := True;
    except
      Result := False;
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryTEMP);
  end;
end;

Function TDataMod.DEPO_URUN_BA_UPDATE(Transaction:TIB_Transaction;
                                      PRM_DEPO_KOD,PRM_URUN_KOD:String;
                                      PRM_BA:Char;
                                      PRM_TUTAR,PRM_TUTAR_VPB,PRM_MIKTAR:Currency):Boolean;
var qryDEPO_URUN:TIB_Query;
begin
{NOT TESTED}
// Burak ÖZLER 24/09/2004
// PRM_TUTAR Ürün Kartý üzerinde belirtilen Para birimi Cinsinden gönderilecek
// PRM_MIKTAR Ürün Kartý üzerinde belirtilen Ölçü Birimi Cinsinden gönderilecek
// PRM_BA BORC ALACAK Constantlarýndan biri olmalý
   try
     try
       Result := False;
       DataMod.CreateQuery(qryDEPO_URUN,Transaction,True,DataMod.dbaMain);
       qryDEPO_URUN.SQL.Add('SELECT * FROM DEPOURUN WHERE DEPO_KOD = ' + SQL_Katar(PRM_DEPO_KOD) + ' AND URUN_KOD = '+ SQL_Katar(PRM_URUN_KOD));
       qryDEPO_URUN.Active := True;
       if qryDEPO_URUN.RecordCount = 0 then
       begin
         qryDEPO_URUN.Insert;
         qryDEPO_URUN.FieldByName('DEPO_KOD').AsString := Trim(PRM_DEPO_KOD);
         qryDEPO_URUN.FieldByName('URUN_KOD').AsString := Trim(PRM_URUN_KOD);
         qryDEPO_URUN.FieldByName('BORC').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('ALACAK').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('BORC_VPB').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('ALACAK_VPB').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('MIKTAR_BORC').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('MIKTAR_ALACAK').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('DEV_BORC').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('DEV_BORC_VPB').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('DEV_MIKTAR_BORC').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('DEV_ALACAK').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('DEV_ALACAK_VPB').AsCurrency := 0;
         qryDEPO_URUN.FieldByName('DEV_MIKTAR_ALACAK').AsCurrency := 0;

         if PRM_BA = BORC then
         begin
            qryDEPO_URUN.FieldByName('BORC').AsCurrency := PRM_TUTAR;
            qryDEPO_URUN.FieldByName('BORC_VPB').AsCurrency := PRM_TUTAR_VPB;
            qryDEPO_URUN.FieldByName('MIKTAR_BORC').AsCurrency := PRM_MIKTAR;
         end else
         begin
            qryDEPO_URUN.FieldByName('ALACAK').AsCurrency := PRM_TUTAR;
            qryDEPO_URUN.FieldByName('ALACAK_VPB').AsCurrency := PRM_TUTAR_VPB;
            qryDEPO_URUN.FieldByName('MIKTAR_ALACAK').AsCurrency := PRM_MIKTAR;
         end;
         qryDEPO_URUN.Post;
       end else
       begin
         qryDEPO_URUN.Edit;
         if PRM_BA = BORC then
         begin
            qryDEPO_URUN.FieldByName('BORC').AsCurrency := qryDEPO_URUN.FieldByName('BORC').AsCurrency + PRM_TUTAR;
            qryDEPO_URUN.FieldByName('BORC_VPB').AsCurrency := qryDEPO_URUN.FieldByName('BORC_VPB').AsCurrency + PRM_TUTAR_VPB;
            qryDEPO_URUN.FieldByName('MIKTAR_BORC').AsCurrency := qryDEPO_URUN.FieldByName('MIKTAR_BORC').AsCurrency + PRM_MIKTAR;
         end else
         begin
            qryDEPO_URUN.FieldByName('ALACAK').AsCurrency := qryDEPO_URUN.FieldByName('ALACAK').AsCurrency + PRM_TUTAR;
            qryDEPO_URUN.FieldByName('ALACAK_VPB').AsCurrency := qryDEPO_URUN.FieldByName('ALACAK_VPB').AsCurrency + PRM_TUTAR_VPB;
            qryDEPO_URUN.FieldByName('MIKTAR_ALACAK').AsCurrency := qryDEPO_URUN.FieldByName('MIKTAR_ALACAK').AsCurrency + PRM_MIKTAR;
         end;
         qryDEPO_URUN.Post;
       end;
       qryDEPO_URUN.Close;
       Result := True;
     except
       Application.MessageBox('DataMod.DEPO_URUN_BA_UPDATE Yordamýnda hata oluþtu','Hata',MB_ICONERROR);
       raise;
     end;
   finally
     DataMod.ReleaseQuery(qryDEPO_URUN);
   end;
end;

Function TDataMod.URUN_BA_UPDATE(Transaction:TIB_Transaction;
                                 PRM_URUN_KOD:String;
                                 PRM_BA:Char;
                                 PRM_TUTAR,PRM_TUTAR_VPB,PRM_MIKTAR:Currency):Boolean;
var qryURUN:TIB_Query; ErrMsg:PChar;
begin
// Burak ÖZLER 27/09/2004
// PRM_TUTAR Ürün Kartý üzerinde belirtilen Para birimi Cinsinden gönderilecek
// PRM_MIKTAR Ürün Kartý üzerinde belirtilen Ölçü Birimi Cinsinden gönderilecek
// PRM_BA BORC ALACAK Constantlarýndan biri olmalý
   try
     try
       Result := False;
       DataMod.CreateQuery(qryURUN,Transaction,True,DataMod.dbaMain);
       qryURUN.SQL.Add('SELECT URUN_KOD,BORC,ALACAK,BORC_VPB,ALACAK_VPB,MIKTAR_BORC,MIKTAR_ALACAK FROM URUN WHERE URUN_KOD = '+ SQL_Katar(PRM_URUN_KOD));
       qryURUN.Active := True;
       if qryURUN.RecordCount <> 0 then
       begin
         qryURUN.Edit;
         if PRM_BA = BORC then
         begin
            qryURUN.FieldByName('BORC').AsCurrency := qryURUN.FieldByName('BORC').AsCurrency + PRM_TUTAR;
            qryURUN.FieldByName('BORC_VPB').AsCurrency := qryURUN.FieldByName('BORC_VPB').AsCurrency + PRM_TUTAR_VPB;
            qryURUN.FieldByName('MIKTAR_BORC').AsCurrency := qryURUN.FieldByName('MIKTAR_BORC').AsCurrency + PRM_MIKTAR;
         end
         else
         begin
            qryURUN.FieldByName('ALACAK').AsCurrency := qryURUN.FieldByName('ALACAK').AsCurrency + PRM_TUTAR;
            qryURUN.FieldByName('ALACAK_VPB').AsCurrency := qryURUN.FieldByName('ALACAK_VPB').AsCurrency + PRM_TUTAR_VPB;
            qryURUN.FieldByName('MIKTAR_ALACAK').AsCurrency := qryURUN.FieldByName('MIKTAR_ALACAK').AsCurrency + PRM_MIKTAR;
         end;
         qryURUN.Post;
       end else
       begin
         ErrMsg := Pchar('DataMod.URUN_BA_UPDATE Yordamýnda hata oluþtu ' + PRM_URUN_KOD + ' Kodunda bir Ürün kayýtlý deðil!');
         Application.MessageBox(ErrMsg,'Hata',MB_ICONERROR);
         Exit;
       end;
       Result := True;
     except
       Application.MessageBox('DataMod.URUN_BA_UPDATE Yordamýnda hata oluþtu','Hata',MB_ICONERROR);
       raise;
     end;
   finally
     DataMod.ReleaseQuery(qryURUN);
   end;
end;

Function TDataMod.GET_URUNHAR_URUN_BILGI(PRM_URUN_KOD:String;
                                         PRM_BA:Char;
                                         PRM_DOVKOD,PRM_OLCUBIRIM:String;
                                         PRM_TARIH:TDate;
                                         PRM_BIRIMFIY,
                                         PRM_TUTAR,
                                         PRM_DOVKUR,
                                         PRM_MIKTAR:Currency;
                                         var BIRIMFIY_URN_DOVKOD:Currency;
                                         var BIRIMFIY_VPB:Currency;
                                         var TUTAR_URN_DOVKOD:Currency;
                                         var MIKTAR_URN_OLCUBIRIM:Currency;
                                         var URUN_DOVKOD:String;
                                         var URUN_OLCUBIRIM:String):Boolean;
var qryURUN:TIB_Query; ErrMsg:PChar;
begin
// Burak ÖZLER 27/09/2004
// Bu fonksiyona gelen tüm parametreler URUNHAR üzerinde ki deðerlerdeir.
   try
     try
       Result := False;
       DataMod.CreateQuery(qryURUN,Nil,False,DataMod.dbaMain);
       qryURUN.SQL.Add('SELECT DOVKOD,OLCUBIRIM,MIKTAR_BORC,MIKTAR_ALACAK,HIZMET,DEV_MIK_BORC,DEV_MIK_ALACAK FROM URUN WHERE URUN_KOD = '+ SQL_Katar(PRM_URUN_KOD));
       qryURUN.Active := True;
       if qryURUN.RecordCount <> 0 then
       begin
         URUN_DOVKOD := qryURUN.FieldByName('DOVKOD').AsString;
         URUN_OLCUBIRIM := qryURUN.FieldByName('OLCUBIRIM').AsString;
         Result := DataMod.KurluDonustur(PRM_TARIH,PRM_DOVKOD,PRM_DOVKUR,glb_DEFCUR,PRM_BIRIMFIY,glb_SATISKUR,True,BIRIMFIY_VPB);
         if Not Result then Exit;
         Result := DataMod.KurluDonustur(PRM_TARIH,PRM_DOVKOD,PRM_DOVKUR,qryURUN.FieldByName('DOVKOD').AsString,PRM_BIRIMFIY,glb_SATISKUR,True,BIRIMFIY_URN_DOVKOD);
         if Not Result then Exit;
         Result := DataMod.KurluDonustur(PRM_TARIH,PRM_DOVKOD,PRM_DOVKUR,qryURUN.FieldByName('DOVKOD').AsString,PRM_TUTAR,glb_SATISKUR,True,TUTAR_URN_DOVKOD);
         if Not Result then Exit;
         Result := DataMod.OLCUBIRIM_DONUSTUR(PRM_OLCUBIRIM,PRM_MIKTAR,qryURUN.FieldByName('OLCUBIRIM').AsString,MIKTAR_URN_OLCUBIRIM);
         if Not Result then Exit;
         if (PRM_BA = ALACAK)
         AND (((qryURUN.FieldByName('DEV_MIK_BORC').AsCurrency + qryURUN.FieldByName('MIKTAR_BORC').AsCurrency) - (qryURUN.FieldByName('DEV_MIK_ALACAK').AsCurrency + qryURUN.FieldByName('MIKTAR_ALACAK').AsCurrency)) < MIKTAR_URN_OLCUBIRIM)
         AND (qryURUN.FieldByName('HIZMET').AsInteger <> 1) then
         begin
            if (Trim(DataMod.GETParam(7,'WARN_OVER_STOCK',0))='1') then
            begin
              Application.MessageBox(Pchar('Yapmak istediðiniz iþlem Ürünün Borç Bakiyesini aþýyor. Stoklarýnýzda yapmak istediðiniz satýþ miktarý kadar ürün '+PRM_URUN_KOD+' kodlu üründen yok'),'Dikkat',MB_ICONWARNING);
            end;
            if (Trim(DataMod.GETParam(7,'ALLOW_OVER_STCK',0))='0')  then
            begin
                 Application.MessageBox(Pchar('Yeterli  '+PRM_URUN_KOD+' kodlu Ürün Yok Ürün Çýkýþý Yapýlamaz'),'Dikkat',MB_ICONERROR);
                 Result := False;
                 Exit;
            end;
         end;
       end else
       begin
         ErrMsg := Pchar('DataMod.GET_URUNHAR_URUN_BILGI Yordamýnda hata oluþtu ' + PRM_URUN_KOD + ' Kodunda bir Ürün kayýtlý deðil!');
         Application.MessageBox(ErrMsg,'Hata',MB_ICONERROR);
         Exit;
       end;
       qryURUN.Close;
       Result := True;
     except
       Application.MessageBox('DataMod.GET_URUNHAR_URUN_BILGI Yordamýnda hata oluþtu','Hata',MB_ICONERROR);
       raise;
     end;
   finally
     DataMod.ReleaseQuery(qryURUN);
   end;
end;

Function TDataMod.URUN_HAR_AUD(Transaction:TIB_Transaction;
                               PRM_URUN_KOD,PRM_DEPO_KOD:String;
                               PRM_BA:Char;
                               PRM_TUTAR,
                               PRM_TUTAR_VPB,
                               PRM_MIKTAR:Currency):Boolean;
begin
// Burak ÖZLER 28/09/2004
// PRM_TUTAR Ürün Kartý üzerinde belirtilen Para birimi Cinsinden gönderilecek
// PRM_MIKTAR Ürün Kartý üzerinde belirtilen Ölçü Birimi Cinsinden gönderilecek
// PRM_BA BORC ALACAK Constantlarýndan biri olmalý
  Result := DataMod.URUN_BA_UPDATE(Transaction,PRM_URUN_KOD,PRM_BA,PRM_TUTAR,PRM_TUTAR_VPB,PRM_MIKTAR);
  if TRIM(PRM_DEPO_KOD) <> '' then
  begin
    Result := DataMod.DEPO_URUN_BA_UPDATE(Transaction,PRM_DEPO_KOD,PRM_URUN_KOD,PRM_BA,PRM_TUTAR,PRM_TUTAR_VPB,PRM_MIKTAR);
  end;
end;

Procedure TDataMod.AssignConnProps(Connection:TIB_Connection;ConnLocal:Boolean;ServerName,DB_Path,User_Name,Pass_Word:String);
{Connection Nesnesinin Propertylerini yükler}
begin
  with Connection do
  begin
     Close;
     if not ConnLocal then
     begin
       DatabaseName := ServerName + ':'+ DB_Path;
       Protocol := cpTCP_IP
     end else
     begin
       DatabaseName := DB_Path;
       Protocol := cpLOCAL;
     end;
     Username := User_Name;
     Password := Pass_Word;
     SQLDialect := 3;
     PageSize := 8192;
     CharSet := 'WIN1254';
  end;
end;

Function TDataMod.TestConnection(ConnLocal:Boolean;ServerName,DB_Path,User_Name,Pass_Word:String;ShowMSG:Boolean):Boolean;
var
  cnConnection:TIB_Connection;
begin
  cnConnection := TIB_Connection.Create(Self);
  DataMod.AssignConnProps(cnConnection,ConnLocal,ServerName,DB_Path,User_Name,Pass_Word);
  try
    cnConnection.Connect;
    if ShowMSG then Application.MessageBox('Veri Tabanýna Baðlantý Baþarý ile Kurulmuþtur','Baþarýlý',MB_ICONINFORMATION);
    Result := True;
  except
    if ShowMSG then Application.MessageBox('Veri Tabanýna Baðlantý Kurulamadý !','Baþarýsýz',MB_ICONHAND);
    Result := False;
  end;
end;

function TDataMod.EN_GER_KAY_TAR_KONTROL(Deger:TDateTime;MsgVer:Boolean):Boolean;
{Ýþlem tarihinin EN_GER_KAY_TAR dan küçük olup olmadýðýný belirler}
var
  qryTarih : TIB_Query;
  Tarih : TDateTime;
begin
  if GetKayTarUyg(Tarih) then
  begin
    if (CompareDate(Deger,Tarih)= -1) or (CompareDate(Deger,Tarih)= 0) then
    begin
      if MsgVer then  Application.MessageBox('Ýþlem Tarihiniz iþlem yapýlabilecek en eski tarih parametresinden küçük. Ýþlem yapýlamaz.','Dikkat',MB_ICONSTOP);
      Result := False;
    end
    else
    begin
      Result := True;
    end;
  end
  else
  begin
    if (CompareDate(Deger,glb_EN_GER_KAY_TAR)= -1) or (CompareDate(Deger,glb_EN_GER_KAY_TAR)= 0) then
    begin
      if MsgVer then  Application.MessageBox('Ýþlem Tarihiniz iþlem yapýlabilecek en eski tarih parametresinden küçük. Ýþlem yapýlamaz..','Dikkat',MB_ICONSTOP);
      Result := False;
    end
    else
    begin
      Result := True;
    end;
  end;
end;

function TDataMod.KAY_TAR_KONTROL(Deger:TDateTime;MsgVer:Boolean):Boolean;
{Ýþlem tarihinin EN_GER_KAY_TAR dan küçük olup olmadýðýný belirler}
var
  qryTarih : TIB_Query;
  Tarih : TDateTime;
begin
    if Deger>Date then
    begin
      if MsgVer then  Application.MessageBox('Ýþlem Tarihiniz Henüz Gelmemiþ','Dikkat',MB_ICONSTOP);
      if Application.MessageBox('Ýþleme devam etmek istiyor musunuz','Dikkat',MB_YESNO) = IDNO then
      Result := False;
      // Abort;
    end
    else
    begin
      Result := True;
    end;

end;


{Function TDataMod.GetBelgeKod(BelgeTur:Integer):String;
var qryBELGETUR:TIB_Query;
begin
  try
    DataMod.CreateQuery(qryBELGETUR,Nil,False,DataMod.dbaANA);
    qryBELGETUR.SQL.Add('SELECT BELGE_KOD FROM BELGETUR WHERE BELGE_TUR = ' + IntToStr(BelgeTur));
    qryBELGETUR.Active := True;
    if qryBELGETUR.RecordCount <> 0 then
       Result := qryBELGETUR.FieldByName('BELGE_KOD').AsString
    else
       Result := '';
  except
    Result := '';
    Raise;
  end;
end;}



function TDataMod.GetBelgeKod(BelgeTur:Integer):String;
begin
  case BelgeTur of
  1 :Result:='ALIS FATURASI';
  20:Result:='SATIS FATURASI';
  14:Result:='KASA';
  17:Result:='SERBEST DEKONT';
  4 :Result:='BORC CEKI';
  18:Result:='BORÇ SENETÝ';
  5 :Result:='DEVIR KAYDI';
  6 :Result:='M.CEK ALINDI';
  7 :Result:='M.SEN ALINDI';
  8 :Result:='M.CEK CIRO';
  13:Result:='M.SEN CIRO';
  9 :Result:='CEK BORDROSU';
  10:Result:='SENET BORDROSU';
  11:Result:='M.CEK IADE';
  12:Result:='M.SEN IADE';
  15:Result:='PORT_CEK_KARS';
  16:Result:='PORT_SEN_KARS';
  21:Result:='M.CEK TAHSIL VER';
  22:Result:='M.SEN TAHSIL VER';
  25:Result:='BANK KARS CEK';
  27:Result:='BANK_PROT_SEN';
  24:Result:='SATICI KARS CEK';
  26:Result:='SATICI_PROT_SEN';
  28:Result:='BANK M.CEK TAH';
  32:Result:='BANK M.SEN TAH';
  33:Result:='KASA CEKSEN TAH';
  34:Result:='KASA CEKSEN TED';
  19:Result:='CARI';
  23:Result:='MUHASEBE FÝÞÝ';
  29:Result:='BORÇ ÇEKÝ ÖDEME';
  30:Result:='BORC CEKI IADE';
  31:Result:='BORC SENETÝ IADE';

  35:Result:='ALIÞ ÝRSALÝYE';
  36:Result:='SATIÞ ÝRSALÝYE';
  37:Result:='MÜÞTERÝ SÝPARÝÞÝ';
  38:Result:='SATICI SÝPARÝÞÝ';
  39:Result:='ÜRETÝM';
  40:Result:='SERBEST ÜRETÝM';
  41:Result:='SEFER';
  42:Result:='MAZOT FÝÞÝ';
  43:Result:='KOMÝSYON FÝÞÝ';
  50:Result:='MAZOT FÝÞÝ CARÝ';
  60:Result:='ONARIM FÝÞÝ';
  else
    Result:='TANIMSIZ';
  end; // case end
end;

function TDataMod.GetRefTableFromBelgeTur(BelgeTur:Integer):String;
var qryBELGETUR:TIB_Query;
begin
  try
    DataMod.CreateQuery(qryBELGETUR,Nil,False,DataMod.dbaANA);
    qryBELGETUR.SQL.Add('SELECT REFERANS_TABLO FROM BELGETUR WHERE BELGE_TUR = ' + IntToStr(BelgeTur));
    qryBELGETUR.Active := True;
    if qryBELGETUR.RecordCount <> 0 then
       Result := qryBELGETUR.FieldByName('REFERANS_TABLO').AsString
    else
       Result := '';
     DataMod.ReleaseQuery(qryBELGETUR);
  except
    Result := '';
    Raise;
  end;
end;

Function TDataMod.GetBelgeTurFromRefTable(REFERANS_TABLO:String):String;
// REFERANS_TABLO ya ait belge_tur ler '1,2,3' þeklinde geri, gönderilir.
var qryBELGETUR:TIB_Query;
begin
  try
    Result := '';
    //DataMod.CreateQuery(qryBELGETUR,Nil,False,DataMod.dbaANA);
    DataMod.CreateQuery(qryBELGETUR,Nil,False,DataMod.dbaMain);
    qryBELGETUR.SQL.Add('SELECT BELGE_TUR FROM BELGETUR WHERE  REFERANS_TABLO = ' + SQL_Katar(REFERANS_TABLO));
    qryBELGETUR.Active := True;
    if qryBELGETUR.RecordCount <> 0 then
    begin
       Repeat
         Result := Result + qryBELGETUR.FieldByName('BELGE_TUR').AsString + ',';
         qryBELGETUR.Next;
       until qryBELGETUR.Eof;
       Result := Copy(Result,0,Length(Result) - 1);
    end;
    DataMOd.ReleaseQuery(qryBELGETUR);
  except
    Result := '';
    Raise;
  end;
end;

function TDataMod.GetVPB(var VPB:String):Boolean;
var
  qryDOVKART:TIB_Query;
begin
  try
    Result:=False;
    DataMod.CreateQuery(qryDOVKART,Nil,False,DataMod.dbaMain);
    qryDOVKART.SQL.Add('SELECT DOVKOD FROM DOVKART WHERE VPB = 1');
    qryDOVKART.Open;
    if qryDOVKART.RecordCount <> 0 then
    begin
      VPB := qryDOVKART.FieldByName('DOVKOD').AsString;
      Result := True;
    end;
  finally
    DataMod.ReleaseQuery(qryDOVKART);
  end;
end;

Function TDataMod.Get_Ib_RecordText(const qry: TIB_Query): String;
var
  qryTEMP:TIB_Query;
  i : integer;
  ReturnStr : String;
begin
  qryTEMP := qry;
  qryTEMP.First;
  while not qryTEMP.Eof do
  begin
    for i := 0 to qryTEMP.FieldCount - 1 do
    begin
      ReturnStr := ReturnStr + qryTEMP.Fields[i].FieldName +':'+qryTEMP.Fields[i].AsString+',';
    end;
    qryTEMP.Next;
  end;
  Result := Copy(ReturnStr,0,Length(ReturnStr)-1);
end;

Function TDataMod.Get_Ib_RecordTextQry(const qry:String): String;
var
  qryTEMP:TIB_Query;
  i : integer;
  ReturnStr : String;
begin
  DataMod.CreateQuery(qryTEMP,Nil,False,DataMod.dbaMain);
  qryTEMP.SQL.Text := qry;
  qryTEMP.Active:=True;
  qryTEMP.First;
  while not qryTEMP.Eof do
  begin
    for i := 0 to qryTEMP.FieldCount - 2 do
    begin
      ReturnStr := ReturnStr +qryTEMP.Fields[i].AsString+' ';
    end;
    qryTEMP.Next;
  end;
  Result := Copy(ReturnStr,0,Length(ReturnStr)-1);
  DataMod.ReleaseQuery(qryTEMP);
end;



function TDataMod.Subeli_mi:Boolean;
var
  qrySUBE:TIB_Query;
begin
  try
    Result := False;
    DataMod.CreateQuery(qrySUBE,Nil,False,DataMod.dbaANA);
    qrySUBE.SQL.Add('SELECT COUNT(*) AS KAY_SAY FROM SUBE WHERE SIRKET_ID = '+ IntToStr(glb_SIRKET_ID));
    qrySUBE.Active := True;
    Result := (qrySUBE.FieldByName('KAY_SAY').AsInteger > 0);
  finally
    DataMod.ReleaseQuery(qrySUBE);
  end;
end;


function TDataMod.GetRapKodUyg(var Kod:String; var RapKodGor:Boolean):Boolean;
var
  qryKullanici:TIB_Query;
begin
  try
    Result := False;
    DataMod.CreateQuery(qryKULLANICI,Nil,False,DataMod.dbaANA);
    qryKullanici.SQL.Add('SELECT RAPKOD_UYG,RAPKOD,RAPKOD_GOR FROM KULLANICI WHERE KULLANICI.KULLANICI_ID = '+ inttostr(glb_USER_ID) + ' AND KULLANICI.KULLANICI_SID = '+ IntToStr(glb_USER_SID));
    qryKullanici.Active := True;
    case qryKullanici.FieldByName('RAPKOD_UYG').asInteger of
    0:
      begin
        Result := False;
        Kod := '';
      end;
    1:
      begin
        Result := True;
        Kod := qryKullanici.FieldByName('RAPKOD').asString;
        RapKodGor := (qryKullanici.FieldByName('RAPKOD_GOR').asInteger = 1);
      end;
    end;
  finally
    DataMod.ReleaseQuery(qryKullanici);
  end;
end;

function TDataMod.GetKayTarUyg(var Tarih:TDateTime):Boolean;
var
  qryKullanici:TIB_Query;
begin
  try
    Result := False;
    DataMod.CreateQuery(qryKULLANICI,Nil,False,DataMod.dbaANA);
    qryKullanici.SQL.Add('SELECT EN_GER_KAY_TAR,KAY_TAR_UYG FROM KULLANICI WHERE KULLANICI.KULLANICI_ID = '+ inttostr(glb_USER_ID) + ' AND KULLANICI.KULLANICI_SID = '+ IntToStr(glb_USER_SID));
    qryKullanici.Active := True;
    Tarih := qryKullanici.FieldByName('EN_GER_KAY_TAR').AsDateTime;
    Result := (qryKullanici.FieldByName('KAY_TAR_UYG').asInteger = 1);
  finally
    DataMod.ReleaseQuery(qryKullanici);
  end;
end;



function TDataMod.GetSubeMudahale:Integer;
var
  qrySUBEMUDAHALE:TIB_Query;
begin
  try
    Result := 0;
    DataMod.CreateQuery(qrySUBEMUDAHALE,Nil,False,DataMod.dbaANA);
    qrySUBEMUDAHALE.SQL.Add('SELECT SUBE_MUDAHALE FROM KULLANICI WHERE KULLANICI.KULLANICI_ID = '+ inttostr(glb_USER_ID) + ' AND KULLANICI.KULLANICI_SID = '+ IntToStr(glb_USER_SID));
    qrySUBEMUDAHALE.Open;
    Result := qrySUBEMUDAHALE.FieldByName('SUBE_MUDAHALE').AsInteger;
    qrySUBEMUDAHALE.Close;
  finally
    DataMod.ReleaseQuery(qrySUBEMUDAHALE);
  end;
end;

Function TDataMod.KASA_BA_AY_UPDATE( Transaction:TIB_Transaction;
                                     PRM_KASA_KOD:String;
                                     PRM_TARIH:TDate;
                                     PRM_TUTAR_KASA_DOVKOD,
                                     PRM_TUTAR_VPB:Currency;
                                     PRM_GC:Char):Boolean;
var
  qryKASA,qryKASA_AY:TIB_Query;
  YIL,AY,GUN:Word;
begin
  try
    try
      DataMod.CreateQuery(qryKASA,Transaction,True,DataMod.dbaMain);
      DataMod.CreateQuery(qryKASA_AY,Transaction,True,DataMod.dbaMain);
      DecodeDate(PRM_TARIH,YIL,AY,GUN);
      qryKASA.SQL.Add('SELECT KASA_KOD,BORC,ALACAK,BORC_VPB,ALACAK_VPB FROM KASA WHERE KASA_KOD = ' + SQL_Katar(PRM_KASA_KOD));
      qryKASA.Open;
      if qryKASA.RecordCount <> 0 then
      begin
        qryKASA.Edit;
        if PRM_GC = GIRIS then
        begin
          qryKASA.FieldByName('BORC').AsCurrency := qryKASA.FieldByName('BORC').AsCurrency + PRM_TUTAR_KASA_DOVKOD;
          qryKASA.FieldByName('BORC_VPB').AsCurrency := qryKASA.FieldByName('BORC_VPB').AsCurrency + PRM_TUTAR_VPB;
        end
        else
        begin
          qryKASA.FieldByName('ALACAK').AsCurrency := qryKASA.FieldByName('ALACAK').AsCurrency + PRM_TUTAR_KASA_DOVKOD;
          qryKASA.FieldByName('ALACAK_VPB').AsCurrency := qryKASA.FieldByName('ALACAK_VPB').AsCurrency + PRM_TUTAR_VPB;
        end;
        qryKASA.Post;
      end
      else
      begin
        Result := False;
        Exit;
      end;
      // KASA_AY ÝÞLEMLERÝ
      qryKASA_AY.SQL.Add('SELECT * FROM KASA_AY WHERE KASA_KOD = ' + SQL_Katar(PRM_KASA_KOD) + ' AND YIL = ' + IntToStr(YIL) + ' AND AY = '+ IntToStr(AY));
      qryKASA_AY.Open;
      if qryKASA_AY.RecordCount = 0 then
      begin
        qryKASA_AY.Insert;
        qryKASA_AY.FieldByName('KASA_KOD').AsString := Trim(PRM_KASA_KOD);
        qryKASA_AY.FieldByName('YIL').AsInteger := YIL;
        qryKASA_AY.FieldByName('AY').AsInteger := AY;
        qryKASA_AY.FieldByName('BORC').AsCurrency := 0;
        qryKASA_AY.FieldByName('BORC_VPB').AsCurrency := 0;
        qryKASA_AY.FieldByName('ALACAK').AsCurrency := 0;
        qryKASA_AY.FieldByName('ALACAK_VPB').AsCurrency := 0;
      end
      else
      begin
        qryKASA_AY.Edit;
      end;
      if PRM_GC = GIRIS then
      begin
        qryKASA_AY.FieldByName('BORC').AsCurrency := qryKASA.FieldByName('BORC').AsCurrency + PRM_TUTAR_KASA_DOVKOD;
        qryKASA_AY.FieldByName('BORC_VPB').AsCurrency := qryKASA.FieldByName('BORC_VPB').AsCurrency + PRM_TUTAR_VPB;
      end
      else
      begin
        qryKASA_AY.FieldByName('ALACAK').AsCurrency := qryKASA.FieldByName('ALACAK').AsCurrency + PRM_TUTAR_KASA_DOVKOD;
        qryKASA_AY.FieldByName('ALACAK_VPB').AsCurrency := qryKASA.FieldByName('ALACAK_VPB').AsCurrency + PRM_TUTAR_VPB;
      end;
      qryKASA_AY.Post;

      Result := True;
    except
      Result := False;
      Application.MessageBox('Exception Oluþan Yordam :TDataMod.KASA_BA_AY_UPDATE','Dikkat', MB_ICONHAND);
      Raise;
    end;
  finally
    DataMod.ReleaseQuery(qryKASA);
    DataMod.ReleaseQuery(qryKASA_AY);
  end;
end;

function TDataMod.LS_MasrafGroup(var MasrafGroup_KOD,MasrafGroup_AD: String): Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('MASRAF_GRUP_KOD');
  Kolonlar.Add('Kodu');
  Kolonlar.Add('100');
  Kolonlar.Add('MASRAF_GRUP_ADI');
  Kolonlar.Add('Adý');
  Kolonlar.Add('150');
  frmSrcDlg.Caption := 'Masraf Gruplarý Listesi';
  frmSrcDlg.List( 2 , Kolonlar ,'SELECT MASRAF_GRUP_KOD,MASRAF_GRUP_ADI FROM MASRAF_GRUP','',1,0);
  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
    MasrafGroup_KOD := Kolonlar.Strings[0];
    MasrafGroup_AD := Kolonlar.Strings[1];
    Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

function TDataMod.Planlama_Urun_Sipariste_Varmi(Urun_Id:String; var qryDeg:TIB_Query):Integer;
//var
//  qryDeg:TIB_Query;
begin
  Result:=0;
  try
      DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
      qryDeg.SQL.Text:='SELECT Min(siparis.vade_Tarih),siparis.vade_Tarih,siparis.fat_irs_id,siparis_D.Miktar FROM SIPARIS_D'+
                       ' inner join siparis on (siparis.fat_irs_id=siparis_d.fatura_id)'+
                       ' WHERE SIPARIS_D.URUN_KOD = ' + SQL_Katar(Urun_Id)+
                       ' group by siparis.vade_Tarih,siparis.fat_irs_id,siparis_D.Miktar';
      qryDeg.Open;
      if qryDeg.RecordCount <> 0 then
      Result:=qryDeg.FieldByName('fat_irs_id').AsInteger;
  except
  Result:=-1;
  end;
end;


function TDataMod.Planlama_Urun_Max_Tedarik(Urun_Id:String):Integer;
var
  qryDeg:TIB_Query;
begin
  Result:=0;
  try
      DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
      qryDeg.SQL.Text:='SELECT MAX(URUN_TEDARIK.tedarik_suresi) MAX_TEDARIK FROM URUN'+
                       ' INNER join URUN_TEDARIK ON (URUN.urun_kod=URUN_TEDARIK.urun_kod)'+
                       ' WHERE URUN.urun_kod='+SQL_Katar(Urun_Id);
      qryDeg.Open;
      if qryDeg.RecordCount <> 0 then
      Result:=qryDeg.FieldByName('MAX_TEDARIK').AsInteger;
  except
  Result:=-1;
  end;
end;

function TDataMod.Planlama_Urun_Min_Tedarik(Urun_Id:String):Integer;
var
  qryDeg:TIB_Query;
begin
  Result:=0;
  try
      DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
      qryDeg.SQL.Text:='SELECT MIN(URUN_TEDARIK.tedarik_suresi) MAX_TEDARIK FROM URUN'+
                       ' INNER join URUN_TEDARIK ON (URUN.urun_kod=URUN_TEDARIK.urun_kod)'+
                       ' WHERE URUN.urun_kod='+SQL_Katar(Urun_Id);
      qryDeg.Open;
      if qryDeg.RecordCount <> 0 then
      Result:=qryDeg.FieldByName('MAX_TEDARIK').AsInteger;
  except
  Result:=-1;
  end;
end;


function TDataMod.Planlama_Urun_NeKadar_Var(Urun_Id:String):Double;
var
  qryDeg:TIB_Query;
begin
  Result:=0;
  try
      DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
      qryDeg.SQL.Text:='SELECT MIKTAR_BORC-MIKTAR_ALACAK AS MIKTAR FROM URUN'+
                       ' WHERE URUN.URUN_KOD='+SQL_Katar(Urun_Id);
      qryDeg.Open;
      if qryDeg.RecordCount <> 0 then
      Result:=qryDeg.FieldByName('MIKTAR').AsFloat;
  except
  Result:=-1;
  end;
end;

function TDataMod.Planlama_Urun_Borc(Urun_Id:String):Double;
var
  qryDeg:TIB_Query;
begin
  Result:=0;
  try
      DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
      qryDeg.SQL.Text:='SELECT MIKTAR_BORC AS MIKTAR FROM URUN'+
                       ' WHERE URUN.URUN_KOD='+SQL_Katar(Urun_Id);
      qryDeg.Open;
      if qryDeg.RecordCount <> 0 then
      Result:=qryDeg.FieldByName('MIKTAR').AsFloat;
  except
  Result:=-1;
  end;
end;



function TDataMod.Planlama_Urun_Olcu_Birim(Urun_Id:String):String;
var
  qryDeg:TIB_Query;
begin
  Result:='';
  try
      DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
      qryDeg.SQL.Text:='SELECT OLCUBIRIM FROM URUN'+
                       ' WHERE URUN.urun_kod='+SQL_Katar(Urun_Id);
      qryDeg.Open;
      if qryDeg.RecordCount <> 0 then
      Result:=qryDeg.FieldByName('OLCUBIRIM').AsString
      else
      begin
           Application.MessageBox(Pchar(Urun_Id +' Ürününün Ölçü Birimi Bulunamadý Ýþlem Durdurulacak'),'Dikkat',MB_ICONWARNING);
           abort;
      end;

  except
           Application.MessageBox(Pchar(Urun_Id +' Ürününün Ölçü Birimi Bulunmasýnda Hata Ýþlem Durdurulacak'),'Dikkat',MB_ICONWARNING);
           abort;

  end;
end;

function TDataMod.Planlama_Urun_Olcu_Tip(Urun_Id:String):String;
var
  qryDeg:TIB_Query;
begin
  Result:='';
  try
      DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
      qryDeg.SQL.Text:='SELECT OLCU_TIP FROM URUN'+
                       ' WHERE URUN.urun_kod='+SQL_Katar(Urun_Id);
      qryDeg.Open;
      if qryDeg.RecordCount <> 0 then
      Result:=qryDeg.FieldByName('OLCU_TIP').AsString
      else
      begin
           Application.MessageBox(Pchar(Urun_Id +' Ürününün Ölçü Tip Bulunamadý Ýþlem Durdurulacak'),'Dikkat',MB_ICONWARNING);
           abort;
      end;

  except
        Application.MessageBox(Pchar(Urun_Id +' Ürününün Ölçü Tip Bulunmasýnda Hata Ýþlem Durdurulacak'),'Dikkat',MB_ICONWARNING);
        abort;
  end;
end;


function TDataMod.Planlama_Olcu_Birim_Do_Deg(OLCU_TIP:String;OLCUBIRIM:String):Double;
var
  qryDeg:TIB_Query;
begin
  Result:=0;
  try
      DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
      qryDeg.SQL.Text:='SELECT DEGERTODOM FROM OLCUBIR'+
                       ' WHERE OLCUBIR.OLCU_TIP='+SQL_Katar(OLCU_TIP)+ ' AND  OLCUBIR.OLCUBIRIM='+SQL_Katar(OLCUBIRIM);
                             qryDeg.Open;
      if qryDeg.RecordCount <> 0 then
      Result:=qryDeg.FieldByName('DEGERTODOM').AsFloat
      else
      begin
           Application.MessageBox(Pchar(OLCU_TIP+' Ölçü Tipinin '+OLCUBIRIM +'Ölçü Birimi Dönüþüm Oraný Bulunamadý. Ýþlem Durdurulacak'),'Dikkat',MB_ICONWARNING);
           abort;
      end;

  except
     Application.MessageBox(Pchar(OLCU_TIP+' Ölçü Tipinin '+OLCUBIRIM +'Ölçü Birimi Hesaplamasýnda Hata Ýþlem Durdurulacak'),'Dikkat',MB_ICONWARNING);
     abort;
  end;
end;



{function TDataMod.Planlama_Olcu_Birim_Miktar_Hes(URUN_KOD:String;OLCUBIRIM:String;Miktar:Double):Double;
var
    Olcu_Tip,Asl_Olcu_Birim:String;
begin
     try
     Result:=0;

           //gelen ölçü birimin ölcu tipi ni bul bizim urunun ölçü tipiyle ayný deðilse hata ver

           Asl_Olcu_Birim:=DataMod.Planlama_Urun_Olcu_Birim(Urun_kod);
           Olcu_Tip:=DataMod.Planlama_Urun_Olcu_Tip(Urun_kod);

           if OLCUBIRIM <> Asl_Olcu_Birim then
           begin
                Result:=Miktar*DataMod.Planlama_Olcu_Birim_Do_Deg(Olcu_Tip ,OLCUBIRIM);
           end
           else Result:=Miktar;
     except
     Application.MessageBox(Pchar(URUN_KOD+' Kodlu Ürünün '+OLCUBIRIM+' Ölçü Tipinin Ölçü Birimi Bulunamasý Ýþlem Durdurulacak'),'Dikkat',MB_ICONWARNING);
     Abort;
     end;
end;}

function TDataMod.Planlama_Olcu_Birim_Miktar_Hes(URUN_KOD:String;OLCUBIRIM:String;Miktar:Double):Double;
var
    Olcu_Tip,Asl_Olcu_Birim:String;
    Asil_Olcu_Dom,Gelen_Olcu_Dom:Double;

begin
     try
     Result:=0;

           //gelen ölçü birimin ölcu tipi ni bul bizim urunun ölçü tipiyle ayný deðilse hata ver
           Asl_Olcu_Birim:=DataMod.Planlama_Urun_Olcu_Birim(Urun_kod);
           if Asl_Olcu_Birim=OLCUBIRIM then
           begin
                Result:=Miktar;
                Exit;
           end;

           Olcu_Tip:=DataMod.Planlama_Urun_Olcu_Tip(Urun_kod);

           Asil_Olcu_Dom :=DataMod.Planlama_Olcu_Birim_Do_Deg(Olcu_Tip ,Asl_Olcu_Birim);
           Gelen_Olcu_Dom  :=DataMod.Planlama_Olcu_Birim_Do_Deg(Olcu_Tip ,OLCUBIRIM);

           {if Asil_Olcu_Dom > Gelen_Olcu_Dom then
           begin
                Result:=Miktar / Asil_Olcu_Dom;
           end
           else
           begin
                Result:=Miktar * Gelen_Olcu_Dom;
           end; }

           Result:=(Miktar * Gelen_Olcu_Dom)/Asil_Olcu_Dom;

           {
           if OLCUBIRIM <> Asl_Olcu_Birim then
           begin
                //Result:=Miktar*DataMod.Planlama_Olcu_Birim_Do_Deg(Olcu_Tip ,OLCUBIRIM);
                Result:=Miktar*DataMod.Planlama_Olcu_Birim_Do_Deg(Olcu_Tip ,OLCUBIRIM);

           end
           else Result:=Miktar;
           }
     except
     Application.MessageBox(Pchar(URUN_KOD+' Kodlu Ürünün '+OLCUBIRIM+' Ölçü Tipinin Ölçü Birimi Bulunamadý Ýþlem Durdurulacak'),'Dikkat',MB_ICONWARNING);
     Abort;
     end;
end;



function TDataMod.Sipd_Fat_Aktarilan(SIPARISD_ID:Integer):Double;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT SUM(MIKTAR) MIKTAR  FROM SIPARIS_D_FAT'+
                   ' WHERE SIPARISD_ID=:SIPARISD_ID';
  qryDeg.ParamByName('SIPARISD_ID').AsInteger:=SiparisD_Id;
  qryDeg.Open;
  result:= qryDeg.FieldByName('MIKTAR').AsFloat;
end;

function TDataMod.Sipd_Miktari(SIPARISD_ID:Integer):Double;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT MIKTAR FROM SIPARIS_D'+
                   ' WHERE URUNHAR_ID=:URUNHAR_ID';
  qryDeg.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
  qryDeg.Open;
  result:= qryDeg.FieldByName('MIKTAR').AsFloat;
end;


function TDataMod.Faturad_Miktari(Fatura_Id:Integer;FaturaD_ID:Integer):Double;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT MIKTAR FROM URUNHAR'+
                   ' WHERE FATURA_ID=:FATURA_ID AND URUNHAR_ID=:URUNHAR_ID';
  qryDeg.ParamByName('URUNHAR_ID').AsInteger:=FaturaD_ID;
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.Open;
  result:= qryDeg.FieldByName('MIKTAR').AsFloat;
end;



function TDataMod.Siparis_Fat_Kac_Adet(Fatura_Id:Integer;FaturaD_ID:Integer;Nereden:String):Integer;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT Count(*) GELEN from SIPARIS_D_FAT'+
                    ' WHERE FATURA_ID=:FATURA_ID AND FATURAD_ID=:FATURAD_ID AND NEREDEN=:NEREDEN';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_ID;
  qryDeg.ParamByName('NEREDEN').AsString:=Nereden;
  qryDeg.Open;
  result:= qryDeg.FieldByName('GELEN').AsInteger;
end;

function TDataMod.Onarim_Fat_Kac_Adet(Fatura_Id:Integer;FaturaD_ID:Integer;Nereden:String):Integer;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT Count(*) GELEN from ONARIM_D_FAT'+
                    ' WHERE FATURA_ID=:FATURA_ID AND FATURAD_ID=:FATURAD_ID AND NEREDEN=:NEREDEN';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_ID;
  qryDeg.ParamByName('NEREDEN').AsString:=Nereden;
  qryDeg.Open;
  result:= qryDeg.FieldByName('GELEN').AsInteger;
end;


function TDataMod.Siparis_Faturami(Fatura_Id:Integer):Integer;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT Siparis_ID GELEN from SIPARIS_D_FAT'+
                    ' WHERE FATURA_ID=:FATURA_ID';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.Open;
  if qryDeg.FieldByName('GELEN').AsInteger>0 then
  result:= qryDeg.FieldByName('GELEN').AsInteger
end;

function TDataMod.Onarim_Faturami(Fatura_Id:Integer):Integer;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT ONARIM_ID GELEN from ONARIM_D_FAT'+
                    ' WHERE FATURA_ID=:FATURA_ID';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.Open;
  if qryDeg.FieldByName('GELEN').AsInteger>0 then
  result:= qryDeg.FieldByName('GELEN').AsInteger
end;



function TDataMod.Siparis_Bul(Fatura_Id:Integer; FaturaD_ID: Integer):Integer;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT Siparis_ID GELEN from SIPARIS_D_FAT'+
                    ' WHERE FATURA_ID=:FATURA_ID AND FATURAD_ID=:FATURAD_ID';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_ID;
  qryDeg.Open;
  result:= qryDeg.FieldByName('GELEN').AsInteger;
end;


function TDataMod.Siparis_Fat_Ayarla(Transaction:TIB_Transaction;Fatura_Id:Integer;FaturaD_ID:Integer;Siparis_Id:Integer;Toplam_Miktar:Double;Nereden:String  ):Integer;

function fSip_Miktari(SIPARISD_ID:Integer):Double;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT MIKTAR FROM SIPARIS_D'+
                   ' WHERE URUNHAR_ID=:URUNHAR_ID';
  qryDeg.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
  qryDeg.Open;
  result:= qryDeg.FieldByName('MIKTAR').AsFloat;
end;

function fFat_Aktarilan(Fatura_Id:Integer;FaturaD_ID:Integer;Siparis_Id:Integer;SiparisD_Id:Integer):Double;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT SUM(MIKTAR) MIKTAR  FROM SIPARIS_D_FAT'+
                   ' WHERE FATURA_ID<>:FATURA_ID AND FATURAD_ID<>:FATURAD_ID AND SIPARIS_ID=:SIPARIS_ID AND SIPARISD_ID=:SIPARISD_ID AND NEREDEN=:NEREDEN';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_ID;
  qryDeg.ParamByName('SIPARIS_ID').AsInteger:=Siparis_Id;
  qryDeg.ParamByName('SIPARISD_ID').AsInteger:=SiparisD_Id;
  qryDeg.ParamByName('NEREDEN').AsString:=Nereden;
  qryDeg.Open;
  result:= qryDeg.FieldByName('MIKTAR').AsFloat;
end;


var
  qryDeg,qryDeg1:TIB_Query;
  Topla,Sip_Mik ,Fat_Aktarilan,Fark,Aktarilan:Double;
begin
      DataMod.CreateQuery(qryDeg,Transaction,False,DataMod.dbaMain);
      DataMod.CreateQuery(qryDeg1,Transaction,False,DataMod.dbaMain);
      qryDeg.Active:=False;
      qryDeg.SQL.Clear;
      qryDeg.SQL.Text:='SELECT SIPARIS_D_FAT.MIKTAR,SIPARIS_D_FAT.SIPARIS_ID,SIPARIS_D_FAT.SIPARISD_ID,SIPARIS_D_FAT.SIPARIS_D_FAT_ID FROM SIPARIS_D_FAT'+
                       ' WHERE FATURA_ID=:FATURA_ID AND FATURAD_ID=:FATURAD_ID AND NEREDEN=:NEREDEN'+
                       ' order by SIPARIS_D_FAT.SIPARISD_ID';
      qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
      qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_ID;
      qryDeg.ParamByName('NEREDEN').AsString:=Nereden;
      qryDeg.Open;

      Topla:=0;
      Aktarilan:=0;

      while not qryDeg.eof do
      begin

         Sip_Mik:=fSip_Miktari(qryDeg.FieldByName('SIPARISD_ID').AsInteger);
         Fat_Aktarilan:=fFat_Aktarilan(Fatura_Id,FaturaD_ID,qryDeg.FieldByName('SIPARIS_ID').AsInteger,qryDeg.FieldByName('SIPARISD_ID').AsInteger);
         Fark:=0;

         if Toplam_Miktar-Aktarilan>(Sip_Mik-Fat_Aktarilan) then
         begin
           fark:=(Sip_Mik-Fat_Aktarilan);
           Aktarilan:=Aktarilan+Fark;
         end
         else
         begin
              Fark:=Toplam_Miktar-Aktarilan;
              Aktarilan:=Aktarilan+Fark;
         end;

         if fark>0 then
         begin

           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           qryDeg1.SQL.Text:='UPDATE SIPARIS_D_FAT SET MIKTAR=:MIKTAR WHERE SIPARIS_D_FAT_ID=:SIPARIS_D_FAT_ID';
           qryDeg1.ParamByName('SIPARIS_D_FAT_ID').AsInteger:=qryDeg.FieldByName('SIPARIS_D_FAT_ID').AsInteger;
           qryDeg1.ParamByName('MIKTAR').Asfloat:=Fark;
           qryDeg1.ExecSql;

           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           //qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=:MIKTAR WHERE URUNHAR_ID=:URUNHAR_ID';
           qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET SIPARIS_D.AKTARILAN_MIKTAR= (SELECT SUM(SIPARIS_D_FAT.MIKTAR) FROM SIPARIS_D_FAT WHERE SIPARIS_D_FAT.SIPARISD_ID=:URUNHAR_ID) WHERE SIPARIS_D.URUNHAR_ID=:URUNHAR_ID';
           qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=qryDeg.FieldByName('SIPARISD_ID').AsInteger;
           //qryDeg1.ParamByName('MIKTAR').Asfloat:=Fark+Fat_Aktarilan;
           qryDeg1.ExecSql;

           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET KAPANDI=1 WHERE URUNHAR_ID=:URUNHAR_ID and MIKTAR=AKTARILAN_MIKTAR';
           qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=qryDeg.FieldByName('SIPARISD_ID').AsInteger;
           qryDeg1.ExecSql;
         end
         else
         begin
           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           qryDeg1.SQL.Text:='DELETE FROM SIPARIS_D_FAT WHERE SIPARIS_D_FAT_ID=:SIPARIS_D_FAT_ID';
           qryDeg1.ParamByName('SIPARIS_D_FAT_ID').AsInteger:=qryDeg.FieldByName('SIPARIS_D_FAT_ID').AsInteger;
           qryDeg1.ExecSql;

           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           //qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=:MIKTAR WHERE URUNHAR_ID=:URUNHAR_ID';
           qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET SIPARIS_D.AKTARILAN_MIKTAR= (SELECT SUM(SIPARIS_D_FAT.MIKTAR) FROM SIPARIS_D_FAT WHERE SIPARIS_D_FAT.SIPARISD_ID=:URUNHAR_ID) WHERE SIPARIS_D.URUNHAR_ID=:URUNHAR_ID';
           qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=qryDeg.FieldByName('SIPARISD_ID').AsInteger;
           //qryDeg1.ParamByName('MIKTAR').Asfloat:=Fark+Fat_Aktarilan;
           qryDeg1.ExecSql;

         end;

         qryDeg1.Active:=False;
         qryDeg1.SQL.Clear;
         qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=0 WHERE URUNHAR_ID=:URUNHAR_ID and (AKTARILAN_MIKTAR IS NULL)';
         qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=qryDeg.FieldByName('SIPARISD_ID').AsInteger;
         qryDeg1.ExecSql;

         qryDeg.Next;
      end;
end;


function TDataMod.Onarim_Fat_Ayarla(Transaction:TIB_Transaction;Fatura_Id:Integer;FaturaD_ID:Integer;Onarim_Id:Integer;Toplam_Miktar:Double;Nereden:String  ):Integer;

function fSip_Miktari(SIPARISD_ID:Integer):Double;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT MIKTAR FROM SRV_ARAC_ONARIM_D'+
                   ' WHERE URUNHAR_ID=:URUNHAR_ID';
  qryDeg.ParamByName('URUNHAR_ID').AsInteger:=SIPARISD_ID;
  qryDeg.Open;
  result:= qryDeg.FieldByName('MIKTAR').AsFloat;
end;


function fFat_Aktarilan(Fatura_Id:Integer;FaturaD_ID:Integer;Siparis_Id:Integer;SiparisD_Id:Integer):Double;
var
  qryDeg:TIB_Query;
begin
  result:=0;
  DataMod.CreateQuery(qryDeg,nil,False,DataMod.dbaMain);
  qryDeg.SQL.Text:='SELECT SUM(MIKTAR) MIKTAR  FROM ONARIM_D_FAT'+
                   ' WHERE FATURA_ID<>:FATURA_ID AND FATURAD_ID<>:FATURAD_ID AND ONARIM_ID=:ONARIM_ID AND ORNARIMD_ID=:ORNARIMD_ID AND NEREDEN=:NEREDEN';
  qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
  qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_ID;
  qryDeg.ParamByName('ORNARIM_ID').AsInteger:=Siparis_Id;
  qryDeg.ParamByName('ORNARIMD_ID').AsInteger:=SiparisD_Id;
  qryDeg.ParamByName('NEREDEN').AsString:=Nereden;
  qryDeg.Open;
  result:= qryDeg.FieldByName('MIKTAR').AsFloat;
end;


var
  qryDeg,qryDeg1:TIB_Query;
  Topla,Sip_Mik ,Fat_Aktarilan,Fark,Aktarilan:Double;
begin
      DataMod.CreateQuery(qryDeg,Transaction,False,DataMod.dbaMain);
      DataMod.CreateQuery(qryDeg1,Transaction,False,DataMod.dbaMain);
      qryDeg.Active:=False;
      qryDeg.SQL.Clear;
      qryDeg.SQL.Text:='SELECT ONARIM_D_FAT.MIKTAR,ONARIM_D_FAT.ONARIM_ID,ONARIM_D_FAT.ONARIMD_ID,ONARIM_D_FAT.ONARIM_D_FAT_ID FROM ONARIM_D_FAT'+
                       ' WHERE FATURA_ID=:FATURA_ID AND FATURAD_ID=:FATURAD_ID AND NEREDEN=:NEREDEN'+
                       ' order by ONARIM_D_FAT.ONARIM_ID';
      qryDeg.ParamByName('FATURA_ID').AsInteger:=Fatura_Id;
      qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_ID;
      qryDeg.ParamByName('NEREDEN').AsString:=Nereden;
      qryDeg.Open;

      Topla:=0;
      Aktarilan:=0;

      while not qryDeg.eof do
      begin

         Sip_Mik:=fSip_Miktari(qryDeg.FieldByName('ONARIMD_ID').AsInteger);
         Fat_Aktarilan:=fFat_Aktarilan(Fatura_Id,FaturaD_ID,qryDeg.FieldByName('ONARIM_ID').AsInteger,qryDeg.FieldByName('ONARIMD_ID').AsInteger);
         Fark:=0;

         if Toplam_Miktar-Aktarilan>(Sip_Mik-Fat_Aktarilan) then
         begin
           fark:=(Sip_Mik-Fat_Aktarilan);
           Aktarilan:=Aktarilan+Fark;
         end
         else
         begin
              Fark:=Toplam_Miktar-Aktarilan;
              Aktarilan:=Aktarilan+Fark;
         end;

         if fark>0 then
         begin

           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           qryDeg1.SQL.Text:='UPDATE ONARIM_D_FAT SET MIKTAR=:MIKTAR WHERE ONARIM_D_FAT_ID=:ONARIM_D_FAT_ID';
           qryDeg1.ParamByName('ONARIM_D_FAT_ID').AsInteger:=qryDeg.FieldByName('ONARIM_D_FAT_ID').AsInteger;
           qryDeg1.ParamByName('MIKTAR').Asfloat:=Fark;
           qryDeg1.ExecSql;

           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           //qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=:MIKTAR WHERE URUNHAR_ID=:URUNHAR_ID';
           qryDeg1.SQL.Text:='UPDATE SRV_ARAC_ORNARIM_D SET SRV_ARAC_ORNARIM_D.AKTARILAN_MIKTAR= (SELECT SUM(ONARIM_D_FAT.MIKTAR) FROM ONARIM_D_FAT WHERE ONARIM_D_FAT.ONARIMD_ID=:URUNHAR_ID) WHERE ONARIM_D.URUNHAR_ID=:URUNHAR_ID';
           qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=qryDeg.FieldByName('ONARIMD_ID').AsInteger;
           //qryDeg1.ParamByName('MIKTAR').Asfloat:=Fark+Fat_Aktarilan;
           qryDeg1.ExecSql;

           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           qryDeg1.SQL.Text:='UPDATE SRV_ARAC_ORNARIM_D SET KAPANDI=1 WHERE URUNHAR_ID=:URUNHAR_ID and MIKTAR=AKTARILAN_MIKTAR';
           qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=qryDeg.FieldByName('SIPARISD_ID').AsInteger;
           qryDeg1.ExecSql;
         end
         else
         begin
           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           qryDeg1.SQL.Text:='DELETE FROM ONARIM_D_FAT WHERE SIPARIS_D_FAT_ID=:ONARIM_D_FAT_ID';
           qryDeg1.ParamByName('ONARIM_D_FAT_ID').AsInteger:=qryDeg.FieldByName('ONARIM_D_FAT_ID').AsInteger;
           qryDeg1.ExecSql;

           qryDeg1.Active:=False;
           qryDeg1.SQL.Clear;
           //qryDeg1.SQL.Text:='UPDATE SIPARIS_D SET AKTARILAN_MIKTAR=:MIKTAR WHERE URUNHAR_ID=:URUNHAR_ID';
           qryDeg1.SQL.Text:='UPDATE SRV_ARAC_ONARIM_D SET SRV_ARAC_ONARIM_D.AKTARILAN_MIKTAR= (SELECT SUM(ONARIM_D_FAT.MIKTAR) FROM ONARIM_D_FAT WHERE ONARIM_D_FAT.ONARIMD_ID=:URUNHAR_ID) WHERE SRV_ARAC_ONARIM_D.URUNHAR_ID=:URUNHAR_ID';
           qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=qryDeg.FieldByName('ONARIMD_ID').AsInteger;
           //qryDeg1.ParamByName('MIKTAR').Asfloat:=Fark+Fat_Aktarilan;
           qryDeg1.ExecSql;

         end;

         qryDeg1.Active:=False;
         qryDeg1.SQL.Clear;
         qryDeg1.SQL.Text:='UPDATE ONARIM_D SET AKTARILAN_MIKTAR=0 WHERE URUNHAR_ID=:URUNHAR_ID and (AKTARILAN_MIKTAR IS NULL)';
         qryDeg1.ParamByName('URUNHAR_ID').AsInteger:=qryDeg.FieldByName('ONARIMD_ID').AsInteger;
         qryDeg1.ExecSql;

         qryDeg.Next;
      end;
end;









function TDataMod.Seri_No_Kontrolu(DataSet:TIb_Query;Tablo:String;Fat_Irs:Integer;Fat_Irs_Id:Integer;Tip:Integer;Seri:String;Belge:String;Cari_Kod:String):Boolean;
var
  qryTEMP:TIB_Query;
  Msg:PChar;
begin
     Result:=False;
    try
//      if Dataset.State in [dsSINSERT] then
//      begin
        DataMod.CreateQuery(qryTemp,nil,False,DataMod.dbaMain);

        if Tip=2 then
        qryTEMP.SQL.Add('SELECT FAT_IRS_ID,CARI_KOD,COUNT(FAT_IRS_ID) AS KAY_SAY FROM '+Tablo +' WHERE FAT_IRS_SERI= ' + SQL_Katar(Seri) + ' AND BELGE_NO = ' + SQL_Katar(Belge)
        + ' and FAT_IRS_SEP=' + InttoStr(Fat_Irs) + ' and Tip='+ InttoStr(Tip));


        if Tip<>2 then
        qryTEMP.SQL.Add('SELECT FAT_IRS_ID,COUNT(FAT_IRS_ID) AS KAY_SAY FROM '+Tablo +' WHERE FAT_IRS_SERI= ' + SQL_Katar(Seri) + ' AND BELGE_NO = ' + SQL_Katar(Belge)
        + ' and FAT_IRS_SEP=' + InttoStr(Fat_Irs) + ' and Tip='+ InttoStr(Tip));

        if Tip=2 then qryTEMP.SQL.Add(' and CARI_KOD='+SQL_Katar(Cari_Kod));

        if Tip=2 then
        qryTEMP.SQL.Add(' GROUP BY FAT_IRS_ID,CARI_KOD ')
        else
        qryTEMP.SQL.Add(' GROUP BY FAT_IRS_ID ');

        qryTEMP.Open;
        if Dataset.State in [dsSINSERT] then
        if qryTEMP.FieldByName('KAY_SAY').AsInteger > 0 then
        begin
          Application.MessageBox('Mükerrer Seri Belge Numarasý Giriyorsunuz!','Dikkat',MB_ICONINFORMATION);
          Result:=True;
          Exit;
        end;

        if Dataset.State in [dsSEDIT] then
        if qryTEMP.FieldByName('KAY_SAY').AsInteger > 1 then
        begin
          Application.MessageBox('Mükerrer Seri Belge Numarasý Giriyorsunuz!','Dikkat',MB_ICONINFORMATION);
          Result:=True;
          Exit;
        end;

        if Tip<>2 then
        if Dataset.State in [dsSEDIT] then
        if qryTEMP.FieldByName('KAY_SAY').AsInteger >= 1 then
        if qryTEMP.FieldByName('FAT_IRS_ID').AsInteger<>Fat_Irs_id then
        begin
          Application.MessageBox('Mükerrer Seri Belge Numarasý Giriyorsunuz!','Dikkat',MB_ICONINFORMATION);
          Result:=True;
          Exit;
        end;

        if Tip=2 then
        begin
             While not qryTEMP.Eof do
             begin

                if Dataset.State in [dsSEDIT] then
                if qryTEMP.FieldByName('KAY_SAY').AsInteger >= 1 then
                if (qryTEMP.FieldByName('FAT_IRS_ID').AsInteger<>Fat_Irs_id)
                and
                (qryTEMP.FieldByName('CARI_KOD').AsString<>Cari_Kod) then
                begin
                  Application.MessageBox('Mükerrer Seri Belge Numarasý Giriyorsunuz!','Dikkat',MB_ICONINFORMATION);
                  Result:=True;
                  Exit;
                end;

                qryTEMP.Next;
             end;
        end;
//      end;
    except
      Msg := PChar(qryTEMP.SQL[0] + ' Sorgusunda hata oluþtu');
      Application.MessageBox(Msg,'Dikkat',MB_ICONHAND);
      Result:=True;
    end;//end try
end;

function TDataMod.Paket_At(Transaction:TIB_Transaction; DataSet: TIb_Query; PAKET_KOD:String;FAT_TIP:SmallInt;ISN:SmallInt;KDV_HESAPLA:Boolean;Cari_Kod:String):Boolean;
var
  Urun_Kod,Urun_Ad,DOVKOD,OlcuBirim, Depo_Kod, Depo_Ad:String;
  KDV_TUTAR,Fiyat:Currency;
  KDV,KDV_DAHIL:Byte;

  qry_Deg1:TIB_Query;
begin
      DataMod.CreateQuery(qry_Deg1,Transaction,True,DataMod.dbaMain);
      qry_Deg1.Active:=False;
      qry_Deg1.Sql.Text:='Select * from PAKET_D where PAKET_KOD=:PAKET_KOD';
      qry_Deg1.ParamByName('PAKET_KOD').AsString:=PAKET_KOD;
      qry_Deg1.Open;
      While not qry_Deg1.eof do
      begin
          DataSet.Insert;
          DataSet.FieldByName('URUN_KOD').AsString:=qry_Deg1.FieldbyName('URUN_KOD').AsString;
          DataSet.FieldByName('OLCUBIRIM').AsString:=qry_Deg1.FieldbyName('OLCU_BIRIM').AsString;
          DataSet.FieldByName('MIKTAR').AsFloat:=qry_Deg1.FieldbyName('MIKTAR').AsFloat;



          if DataMod.GET_URUN_FAT_BILGI(Transaction,
                                        DataSet.FieldByName('URUN_KOD').AsString,
                                        '',
                                        FAT_TIP,
                                        ISN,
                                        Fiyat,
                                        DOVKOD,
                                        Urun_Ad,
                                        OlcuBirim,
                                        Depo_Kod,
                                        Depo_Ad,
                                        KDV,
                                        KDV_TUTAR,
                                        KDV_DAHIL) then
          begin
            with DataSet do
            begin
              FieldByName('URUN_AD').AsString := Urun_Ad;
              FieldByName('ACIKLAMA').AsString := Urun_Ad;
              FieldByName('BIRIM_FIY').AsCurrency := Fiyat;
              FieldByName('DOVKOD').AsString := DOVKOD;
              FieldByName('OLCUBIRIM').AsString := OlcuBirim;
            end;
            //qryURUNHAR.FieldByName('KDV_TUTAR').AsCurrency  := KDV_TUTAR;
            if (Trim(DataSet.FieldByName('DEPO_KOD').AsString) = '') and glb_DEPO_UYG then
            begin
              DataSet.FieldByName('DEPO_KOD').AsString := Depo_Kod;
              DataSet.FieldByName('DEPO_AD').AsString := Depo_Ad;
            end;
            if KDV_HESAPLA then
            begin
              DataSet.FieldByName('KDV').AsSmallInt := KDV;
            end
            else
            begin
              DataSet.FieldByName('KDV').AsSmallInt := 0;
            end;
          end;

          DataSet.Post;
          qry_Deg1.Next;
      end;

end;


function TDataMod.SATICI_CARI_HAR(
SIL:Byte;
CARI_YON:String;
PRV_ISN:Integer;
BELGE_TUR:Integer;
DataSet:TIb_Query;
Tran:TIb_Transaction
):Boolean;
var
    BELGE_ID,BELGE_SID:INTEGER;
begin
//BT_SEFER
    Result:=False;
    if not DataMod.CARIHAR_AUD(Tran,
                              BELGE_TUR,
                              DataSet.FieldbyName('Sefer_ID').AsInteger,
                              DataSet.FieldbyName('Sefer_SID').AsInteger,
                              1,
                              DataSet.FieldbyName('SATICI_KOD').AsString,
                              CARI_YON,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('SATICI_A_DOV_BAZ_TAR').AsDate,
                              DataSet.FieldbyName('SATICI_ALACAK').AsCurrency,
                              DataSet.FieldbyName('SATICI_A_DOVKOD').AsString,
                              DataSet.FieldbyName('SATICI_A_DOVKUR').AsCurrency,
                              DataSet.FieldbyName('SATICI_ALACAK_VPB').AsCurrency,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('SEFER_NOTLARI').AsString,
                              SIL,
                              PRV_ISN,
                              DataSet.FieldByName('MASRAF_MERK').AsString,
                              DataSet.FieldByName('KOD1').AsString,
                              DataSet.FieldByName('KOD2').AsString,
                              DataSet.FieldByName('KOD3').AsString,
                              DataSet.FieldByName('KOD4').AsString,
                              //DataSet.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //DataSet.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(Tran,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    Result:=True;
end;

function TDataMod.ALICI_CARI_HAR(
SIL:Byte;
CARI_YON:String;
PRV_ISN:Integer;
BELGE_TUR:Integer;
DataSet:TIb_Query;
Tran:TIb_Transaction
):Boolean;
var
    BELGE_ID,BELGE_SID:INTEGER;
begin
//BT_SEFER
    Result:=False;
    if not DataMod.CARIHAR_AUD(Tran,
                              BELGE_TUR,
                              DataSet.FieldbyName('Sefer_ID').AsInteger,
                              DataSet.FieldbyName('Sefer_SID').AsInteger,
                              2,
                              DataSet.FieldbyName('ALICI_KOD').AsString,
                              CARI_YON,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('ALICI_B_DOV_BAZ_TAR').AsDate,
                              DataSet.FieldbyName('ALICI_BORC').AsCurrency,
                              DataSet.FieldbyName('ALICI_B_DOVKOD').AsString,
                              DataSet.FieldbyName('ALICI_B_DOVKUR').AsCurrency,
                              DataSet.FieldbyName('ALICI_BORC_VPB').AsCurrency,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('SEFER_NOTLARI').AsString,
                              SIL,
                              PRV_ISN,
                              DataSet.FieldByName('MASRAF_MERK').AsString,
                              DataSet.FieldByName('KOD1').AsString,
                              DataSet.FieldByName('KOD2').AsString,
                              DataSet.FieldByName('KOD3').AsString,
                              DataSet.FieldByName('KOD4').AsString,
                              //DataSet.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //DataSet.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(Tran,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    Result:=True;
end;


function TDataMod.SALICI_BEKLEME_CARI_HAR(
SIL:Byte;
CARI_YON:String;
PRV_ISN:Integer;
BELGE_TUR:Integer;
DataSet:TIb_Query;
Tran:TIb_Transaction
):Boolean;
var
    BELGE_ID,BELGE_SID:INTEGER;
begin
//BT_SEFER
    Result:=False;
    if not DataMod.CARIHAR_AUD(Tran,
                              BELGE_TUR,
                              DataSet.FieldbyName('Sefer_ID').AsInteger,
                              DataSet.FieldbyName('Sefer_SID').AsInteger,
                              4,
                              DataSet.FieldbyName('SATICI_KOD').AsString,
                              CARI_YON,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('SBEKLEME_FAT_DOV_BAZ_TAR').AsDate,
                              DataSet.FieldbyName('SBEKLEME_FAT_TUTAR').AsCurrency,
                              DataSet.FieldbyName('SBEKLEME_FAT_DOV_KOD').AsString,
                              DataSet.FieldbyName('SBEKLEME_FAT_DOVKUR').AsCurrency,
                              DataSet.FieldbyName('SBEKLEME_FAT_VPB').AsCurrency,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('SEFER_NOTLARI').AsString,
                              SIL,
                              PRV_ISN,
                              DataSet.FieldByName('MASRAF_MERK').AsString,
                              DataSet.FieldByName('KOD1').AsString,
                              DataSet.FieldByName('KOD2').AsString,
                              DataSet.FieldByName('KOD3').AsString,
                              DataSet.FieldByName('KOD4').AsString,
                              //DataSet.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //DataSet.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(Tran,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    Result:=True;
end;


function TDataMod.ALICI_BEKLEME_CARI_HAR(
SIL:Byte;
CARI_YON:String;
PRV_ISN:Integer;
BELGE_TUR:Integer;
DataSet:TIb_Query;
Tran:TIb_Transaction
):Boolean;
var
    BELGE_ID,BELGE_SID:INTEGER;
begin
//BT_SEFER
    Result:=False;
    if not DataMod.CARIHAR_AUD(Tran,
                              BELGE_TUR,
                              DataSet.FieldbyName('Sefer_ID').AsInteger,
                              DataSet.FieldbyName('Sefer_SID').AsInteger,
                              3,
                              DataSet.FieldbyName('ALICI_KOD').AsString,
                              CARI_YON,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('BEKLEME_FAT_DOV_BAZ_TAR').AsDate,
                              DataSet.FieldbyName('BEKLEME_FAT_TUTAR').AsCurrency,
                              DataSet.FieldbyName('BEKLEME_FAT_DOV_KOD').AsString,
                              DataSet.FieldbyName('BEKLEME_FAT_DOVKUR').AsCurrency,
                              DataSet.FieldbyName('BEKLEME_FAT_VPB').AsCurrency,
                              DataSet.FieldbyName('BAS_TAR').AsDate,
                              DataSet.FieldbyName('SEFER_NOTLARI').AsString,
                              SIL,
                              PRV_ISN,
                              DataSet.FieldByName('MASRAF_MERK').AsString,
                              DataSet.FieldByName('KOD1').AsString,
                              DataSet.FieldByName('KOD2').AsString,
                              DataSet.FieldByName('KOD3').AsString,
                              DataSet.FieldByName('KOD4').AsString,
                              //DataSet.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //DataSet.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(Tran,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    Result:=True;
end;



function TDataMod.MAZOTCU_CARI_HAR(
SIL:Byte;
CARI_YON:String;
PRV_ISN:Integer;
BELGE_TUR:Integer;
DataSet:TIb_Query;
Tran:TIb_Transaction
):Boolean;
var
    BELGE_ID,BELGE_SID:INTEGER;
begin
    Result:=False;

//BT_MAZOT
    if not DataMod.CARIHAR_AUD(Tran,
                              BELGE_TUR,
                              DataSet.FieldbyName('MAZOT_FIS_ID').AsInteger,
                              DataSet.FieldbyName('MAZOT_FIS_SID').AsInteger,
                              4,
                              DataSet.FieldbyName('MAZOTCU_CARI_KOD').AsString,
                              CARI_YON,
                              DataSet.FieldbyName('TARIH').AsDate,
                              DataSet.FieldbyName('TARIH').AsDate,
                              DataSet.FieldbyName('DOV_BAZ_TAR').AsDate,
                              DataSet.FieldbyName('TUTAR').AsCurrency,
                              DataSet.FieldbyName('DOVKOD').AsString,
                              DataSet.FieldbyName('DOVKUR').AsCurrency,
                              DataSet.FieldbyName('TUTAR_VPB').AsCurrency,
                              DataSet.FieldbyName('TARIH').AsDate,
                              DataSet.FieldbyName('ACIKLAMA').AsString,
                              SIL,
                              PRV_ISN,
                              DataSet.FieldByName('MASRAF_MERK').AsString,
                              DataSet.FieldByName('KOD1').AsString,
                              DataSet.FieldByName('KOD2').AsString,
                              DataSet.FieldByName('KOD3').AsString,
                              DataSet.FieldByName('KOD4').AsString,
                              //DataSet.FieldByName('PLASIYER_KOD').AsString,
                              '',
                              //DataSet.FieldByName('PROJE_KOD').AsString,
                              '',
                              BELGE_ID,
                              BELGE_SID) then
    begin
      frmISN_ERRORS.AnyErr(Tran,PRV_ISN,0);
      Result := False;
      Exit;
    end;
    Result:=True;

end;




{
function TDataMod.Sefer_Musteri_Adi(
var
  qryDeg:TIB_Query;
begin
      DataMod.CreateQuery(qryDeg,Transaction,False,DataMod.dbaMain);
      qryDeg.Active:=False;
      qryDeg.SQL.Clear;
      qryDeg.SQL.Text:=''
      qryDeg.ParamByName('FATURAD_ID').AsInteger:=FaturaD_ID;
      qryDeg.Open;

}


function TDataMod.Urun_Kod_Karsilastir(Kaynak_Kod:String;Hedef_Kod:String) :Boolean;
var
   qryTemp:TIb_Query;
begin
  Result:=False;
  if Trim(Kaynak_Kod)=Trim(Hedef_Kod) then
  begin
   Result:=True;
   Exit;
  end;

  DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
  with qryTemp do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM NETSIS_AKTARMA WHERE URUN_KOD = '+ Sql_Katar(Hedef_Kod));
    Active := True;
  end;
  While not qryTemp.eof do
  begin
       if Trim(qryTemp.FieldByName('YENI_URUN_KOD').AsString)=Trim(Kaynak_Kod) then
       begin
          Result:=True;
          Break;
       end;
       qryTemp.Next;
  end;
{  if Result=False then
  Application.MessageBox('Ürün kodu Masraf Karþýlaþtýrmasýnda bulunamadý','Dikkat',MB_ICONWARNING);
}
end;

function TDataMod.Urun_Kod_Merkez_Karsilastir(Kaynak_Kod:String;Merkez_Kod:String) :Boolean;
var
   qryTemp:TIb_Query;
begin
  Result:=False;
  DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
  with qryTemp do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM NETSIS_AKTARMA WHERE URUN_KOD = '+ Sql_Katar(Kaynak_Kod)+ ' AND MASRAF_MERKEZI='+Sql_Katar(Merkez_Kod));
    Active := True;
  end;
  if QryTemp.RecordCount>0 then
  begin
     Result:=True;
  end;
end;



function TDataMod.Urun_Har_Ekle(
                           Transaction: TIB_Transaction;
                           var Qry:TIb_Query;
                           PRM_URUN_KOD:String;
                           PRM_OLCUBIRIM:String;
                           PRM_DEPO_KOD:String;
                           PRM_BORC_ALACAK:String;
                           PRM_KDV_HESAPLA:Boolean;
                           PRM_BELGE_TUR:Integer;
                           PRM_BELGE_ID:Integer;
                           PRM_BELGE_SID:Integer;
                           PRM_SIRA_NO:Byte;
                           PRM_PROJE_KOD:String;
                           PRM_TARIH:TDate;
                           PRM_FIILI_TAR:TDate;
                           PRM_DOV_BAZ_TAR:TDate;
                           PRM_MIKTAR:Currency;
                           PRM_DOVKOD:String;
                           PRM_URUN_DOVKOD:String;
                           PRM_TUTAR_URUN_DOVKOD:String;
                           PRM_DOVKUR:Currency;
                           PRM_BIRIM_FIY:Currency;
                           PRM_BIRIM_FIY_VPB:Currency;
                           PRM_BIRIM_FIY_URN_DOVKOD:Currency;
                           PRM_TUTAR:Currency;
                           PRM_TUTAR_VPB:Currency;
                           PRM_KDV:Currency;
                           PRM_KDV_TUTAR:Currency;
                           PRM_SIL:Byte;
                           PRM_ACIKLAMA:String;
                           ISN:Integer;
                           PRM_MASRAF_MERK,
                           PRM_KOD1,
                           PRM_KOD2,
                           PRM_KOD3,
                           PRM_KOD4:String;
                           var PRM_URUNHAR_ID:Integer;
                           var PRM_URUNHAR_SID:Integer):Boolean;
///////////////////////////

var
  qry_UrunHar:TIB_Query;
  qryS_URUNHAR:TIB_Query;


  BIRIMFIY_URN_DOVKOD,
  TUTAR_URN_DOVKOD,
  MIKTAR_URN_OLCUBIRIM,
  BIRIMFIY_VPB:Currency;
  URUN_DOVKOD,URUN_OLCUBIRIM:String;
  KDV_TUTAR,Fiyat:Currency;
  KDV,KDV_DAHIL:Byte;
  DOV_KUR:Currency;
  Urun_Ad,DOVKOD,OlcuBirim, Depo_Kod, Depo_Ad:String;
  Birim:Currency;
  ErrMsg:PChar;
begin
  Result := False;
  try
  DataMod.CreateQuery(qryS_URUNHAR,Transaction,False,DataMod.dbaMain);
  with qryS_URUNHAR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM URUNHAR WHERE URUNHAR_ID = '+ Inttostr(PRM_URUNHAR_ID) + ' AND URUNHAR_SID = ' + Inttostr(PRM_URUNHAR_SID));
    Active := True;
  end;

  if Prm_Sil=1 then
  if qryS_URUNHAR.RecordCount = 0 then
  begin
    Result := True;
    Exit;
  end;

  if (Trim(qryS_URUNHAR.FieldByName('URUN_KOD').AsString) <> '') then
  begin
    if not DataMod.URUN_HAR_AUD(Transaction,
                                qryS_URUNHAR.FieldByName('URUN_KOD').AsString,
                                qryS_URUNHAR.FieldByName('DEPO_KOD').AsString,
                                qryS_URUNHAR.FieldByName('TIP').AsString[1],
                                (0 - qryS_URUNHAR.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency),
                                (0 - qryS_URUNHAR.FieldByName('TUTAR_VPB').AsCurrency),
                                (0 - qryS_URUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency)) then
    begin
      Result := False;
      Exit;
    end
    else
    Result := True;
  end;

  with qryS_URUNHAR do
  begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM URUNHAR WHERE URUNHAR_ID = '+ Inttostr(PRM_URUNHAR_ID) + ' AND URUNHAR_SID = ' + Inttostr(PRM_URUNHAR_SID));
    qryS_URUNHAR.Execsql;
  end;

  if Prm_Sil=1 then Exit;  //silme ise çýk

  if Trim(PRM_URUN_KOD)='' then //ürün kodu yok ise çýk
  begin
       Result := True;
       Exit;
  end;

  DataMod.CreateQuery(qry_UrunHar,Transaction,True,DataMod.dbaMain);
  qry_UrunHar.Active:=False;
  qry_UrunHar.SQL.Clear;
  qry_UrunHar.SQL.Text:=
  ' SELECT URUNHAR_ID '+
  '     , URUNHAR_SID '+
  '     , TARIH '+
  '     , FIILI_TAR '+
  '     , DOV_BAZ_TAR '+
  '     , URUN_KOD '+
  '     , (SELECT  URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=URUNHAR.URUN_KOD) AS URUN_AD '+
  '     , ACIKLAMA '+
  '     , TIP '+
  '     , BELGE_TUR '+
  '     , BELGE_ID '+
  '     , BELGE_SID '+
  '     , BELGE_SIRA_NO '+
  '     , OLCUBIRIM '+
  '     , OLCUBIRIM_URN_OB '+
  '     , MIKTAR '+
  '     , MIKTAR_URN_OB '+
  '     , DOVKOD '+
  '     , DOVKUR '+
  '     , TUTAR '+
  '     , TUTAR_VPB '+
  '     , URUN_DOVKOD '+
  '     , TUTAR_URUN_DOVKOD '+
  '     , BIRIM_FIY '+
  '     , BIRIM_FIY_VPB '+
  '     , BIRIM_FIY_URN_DOVKOD '+
  '     , ISKONTO_TIP '+
  '     , ISKONTO_ORAN '+
  '     , ISKONTO_TUTAR '+
  '     , ISKONTO_TUTAR_VPB '+
  '     , DEPO_KOD '+
  '     , (SELECT DEPO.ADI FROM DEPO WHERE DEPO.DEPO_KOD = URUNHAR.DEPO_KOD) AS DEPO_AD '+
  '     , FATURA_ID '+
  '     , FATURA_SID '+
  '     , IRSALIYE_ID '+
  '     , IRSALIYE_SID '+
  '     , MASRAF_MERK '+
  '     , KDV '+
  '     , KDV_TUTAR '+
  '     , KOD1 '+
  '     , KOD2 '+
  '     , KOD3 '+
  '     , KOD4 '+
  '     , SECIM '+
  '     , BIRIM_FIY_URN_OB '+
  '     , CIKIS_MIKTAR '+
  ' FROM URUNHAR '+
  ' WHERE URUNHAR_ID=:PRM_FATURA_ID And URUNHAR_SID=:PRM_FATURA_SID '+
  ' ORDER BY URUNHAR_ID; ';

  with qry_URUNHAR do
  begin
    Active := False;
    //ParamByName('PRM_FATURA_ID').AsInteger :=PRM_URUNHAR_ID;
    //ParamByName('PRM_FATURA_SID').AsInteger :=PRM_URUNHAR_SID;
    ParamByName('PRM_FATURA_ID').AsInteger :=0;
    ParamByName('PRM_FATURA_SID').AsInteger :=0;

    Active := True;
  end;
  qry_UrunHar.Insert;



  with qry_UrunHar do
  begin
    FieldByName('URUNHAR_ID').AsInteger := qry_URUNHAR.Gen_ID('GEN_URUNHAR',1);
    FieldByName('URUNHAR_SID').AsInteger := glb_SID;

    FieldByName('MIKTAR').AsInteger := 1;
    FieldByName('FATURA_ID').AsInteger := 0;
    FieldByName('FATURA_SID').AsInteger := 0;
    FieldByName('IRSALIYE_ID').AsInteger := 0;
    FieldByName('IRSALIYE_SID').AsInteger := 0;
    FieldByName('DEPO_KOD').AsString := PRM_DEPO_KOD;
    FieldByName('TARIH').AsDate := PRM_TARIH;
    FieldByName('DOV_BAZ_TAR').AsDate := PRM_DOV_BAZ_TAR;
    FieldByName('BELGE_TUR').AsInteger := PRM_BELGE_TUR;
    FieldByName('BELGE_ID').AsInteger := PRM_BELGE_ID;
    FieldByName('BELGE_SID').AsInteger := PRM_BELGE_SID;
    FieldByName('BELGE_SIRA_NO').AsInteger := 1;
    FieldByName('ISKONTO_TIP').AsInteger := 0;
    FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := 0 ;
    FieldByName('DOVKOD').AsString := glb_DEFCUR;
    FieldByName('CIKIS_MIKTAR').AsCurrency := 0;
    FieldByName('TIP').AsString :=  PRM_BORC_ALACAK;

    if PRM_KDV_HESAPLA then
    begin
       FieldByName('KDV').AsInteger := 18
    end
    else
    begin
       FieldByName('KDV').AsInteger := 0;
    end;


    FieldByName('URUN_KOD').AsString :=  PRM_URUN_KOD;
    FieldByName('OLCUBIRIM').AsString :=  PRM_OLCUBIRIM;
    FieldByName('MIKTAR').AsFloat:=  PRM_MIKTAR;
    FieldByName('DOVKOD').AsString :=  PRM_DOVKOD;
    FieldByName('DOVKUR').AsFloat :=  PRM_DOVKUR;
    FieldByName('TUTAR').AsFloat :=  PRM_TUTAR;
    FieldByName('TUTAR_VPB').AsFloat :=  PRM_TUTAR_VPB;
    FieldByName('URUN_DOVKOD').AsString :=  PRM_URUN_DOVKOD;
    FieldByName('TUTAR_URUN_DOVKOD').AsString :=  PRM_TUTAR_URUN_DOVKOD;
    FieldByName('BIRIM_FIY').AsFloat :=  PRM_BIRIM_FIY;
    FieldByName('BIRIM_FIY_VPB').AsFloat :=  PRM_BIRIM_FIY_VPB;
    FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat :=  PRM_BIRIM_FIY_URN_DOVKOD;
    FieldByName('DEPO_KOD').AsString :=  PRM_DEPO_KOD;
    FieldByName('KDV').AsFloat :=  PRM_KDV;
    FieldByName('KDV_TUTAR').AsFloat :=  PRM_KDV_TUTAR;
    FieldByName('ACIKLAMA').AsString :=  PRM_ACIKLAMA;
  end;


//deger atamlarýný yap

  if DataMod.GET_URUNHAR_URUN_BILGI(qry_UrunHar.FieldByName('URUN_KOD').AsString,
                                    qry_UrunHar.FieldByName('TIP').AsString[1],
                                    qry_UrunHar.FieldByName('DOVKOD').AsString,
                                    qry_UrunHar.FieldByName('OLCUBIRIM').AsString,
                                    qry_UrunHar.FieldByName('DOV_BAZ_TAR').AsDate,
                                    qry_UrunHar.FieldByName('BIRIM_FIY').AsCurrency,
                                    qry_UrunHar.FieldByName('TUTAR').AsCurrency,
                                    qry_UrunHar.FieldByName('DOVKUR').AsCurrency,
                                    qry_UrunHar.FieldByName('MIKTAR').AsCurrency,
                                    BIRIMFIY_URN_DOVKOD,
                                    BIRIMFIY_VPB,
                                    TUTAR_URN_DOVKOD,
                                    MIKTAR_URN_OLCUBIRIM,
                                    URUN_DOVKOD,
                                    URUN_OLCUBIRIM) then
  begin
    qry_UrunHar.FieldByName('BIRIM_FIY_URN_DOVKOD').AsCurrency := BIRIMFIY_URN_DOVKOD;
    qry_UrunHar.FieldByName('BIRIM_FIY_VPB').AsCurrency := BIRIMFIY_VPB;
    qry_UrunHar.FieldByName('TUTAR_URUN_DOVKOD').AsCurrency := TUTAR_URN_DOVKOD;
    qry_UrunHar.FieldByName('MIKTAR_URN_OB').AsCurrency := MIKTAR_URN_OLCUBIRIM;
    qry_UrunHar.FieldByName('URUN_DOVKOD').AsString := URUN_DOVKOD;
    qry_UrunHar.FieldByName('OLCUBIRIM_URN_OB').AsString := URUN_OLCUBIRIM;
  end
  else
  begin
    Abort;
  end;

  if qry_URUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency=qry_URUNHAR.FieldByName('MIKTAR').AsCurrency then
  qry_URUNHAR.FieldByName('BIRIM_FIY_URN_OB').AsCurrency := qry_URUNHAR.FieldByName('BIRIM_FIY').AsCurrency
  else
  qry_URUNHAR.FieldByName('BIRIM_FIY_URN_OB').AsCurrency :=
  qry_URUNHAR.FieldByName('TUTAR').AsCurrency/
  qry_URUNHAR.FieldByName('MIKTAR_URN_OB').AsCurrency;


   DOV_KUR := DataMod.Get_Doviz_Kur(qry_UrunHar .FieldByName('DOVKOD').AsString,
   PRM_DOV_BAZ_TAR,glb_SATISKUR,0);
   if DOV_KUR<>0 then
   begin
     qry_UrunHar.FieldByName('DOVKUR').AsCurrency := DOV_KUR ;
   end
   else
   begin
     qry_UrunHar.FieldByName('DOVKUR').AsCurrency := 1 ;
   end;



   qry_UrunHar.FieldByName('TUTAR').AsCurrency := qry_UrunHar.FieldByNAme('MIKTAR').AsCurrency * qry_UrunHar.FieldByName('BIRIM_FIY').AsCurrency;
   qry_UrunHar.FieldByName('TUTAR_VPB').AsCurrency := qry_UrunHar.FieldByNAme('MIKTAR').AsCurrency * qry_UrunHar.FieldByName('BIRIM_FIY').AsCurrency*qry_UrunHar.FieldByName('DOVKUR').AsCurrency;

   if PRM_KDV_HESAPLA then
   begin
     if qry_UrunHar.FieldByName('KDV').AsInteger <> 0 then  qry_UrunHar.FieldByName('KDV_TUTAR').AsCurrency := qry_UrunHar.FieldByName('TUTAR_VPB').AsCurrency * (qry_UrunHar.FieldByName('KDV').AsInteger / 100);
   end
   else
   begin
     qry_UrunHar.FieldByName('KDV_TUTAR').AsCurrency := 0;
   end;

   if qry_UrunHar.FieldByName('ISKONTO_TIP').AsSmallInt=0 then
   begin //oran yani
     qry_UrunHar.FieldByName('ISKONTO_TUTAR').AsCurrency := qry_UrunHar.FieldByName('ISKONTO_ORAN').AsInteger*(qry_UrunHar.FieldByName('TUTAR').AsCurrency/100);
     qry_UrunHar.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qry_UrunHar.FieldByName('ISKONTO_TUTAR').AsCurrency * qry_UrunHar.FieldByName('DOVKUR').AsCurrency;
   end
   else
   begin // tutar yani
     qry_UrunHar.FieldByName('ISKONTO_TUTAR_VPB').AsCurrency := qry_UrunHar.FieldByName('ISKONTO_TUTAR').AsCurrency * qry_UrunHar.FieldByName('DOVKUR').AsCurrency;
   end;

   qry_UrunHar.Post;
   PRM_URUNHAR_ID:=qry_UrunHar.FieldByName('URUNHAR_ID').AsInteger;
   PRM_URUNHAR_SID:=qry_UrunHar.FieldByName('URUNHAR_SID').AsInteger;


   Qry.FieldByName('TUTAR_VPB').AsFloat:=qry_UrunHar.FieldByName('TUTAR_VPB').AsFloat;
   Qry.FieldByName('TUTAR_URUN_DOVKOD').AsFloat:=qry_UrunHar.FieldByName('TUTAR_URUN_DOVKOD').AsFloat;
   Qry.FieldByName('BIRIM_FIY_VPB').AsFloat:=qry_UrunHar.FieldByName('BIRIM_FIY_VPB').AsFloat;
   Qry.FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat:=qry_UrunHar.FieldByName('BIRIM_FIY_URN_DOVKOD').AsFloat;
   Qry.FieldByName('OLCUBIRIM_URN_OB').AsString:=qry_UrunHar.FieldByName('OLCUBIRIM_URN_OB').AsString;
   Qry.FieldByName('MIKTAR_URN_OB').AsFloat:=qry_UrunHar.FieldByName('MIKTAR_URN_OB').AsFloat;
   Qry.FieldByName('KDV_TUTAR').AsFloat:=qry_UrunHar.FieldByName('KDV_TUTAR').AsFloat;



   Result:=True;
  Except
      PRM_URUNHAR_ID:=0;
      PRM_URUNHAR_SID:=0;
      Result := False;
  end;
end;


Procedure TDataMod.Kullanici_Rapor_Click(Sender:TObject);
begin
     if (Sender is TMenuItem) then
     Dm_Fast_Report.Rapor_Ac((Sender as TMenuItem).Tag,0,0,0,1,0,0,0,'');
end;


function TDataMod.Menu_Kullanni_Rapor_Ekle(Menu:TMainMenu):Boolean;
var
   mi:TMenuItem;
   qryTemp:TIB_Query;
   a,b:Integer;
begin
     {SELECT ID
          , ADI
          , UST_ID
          , ISLEM_VAR
          , RAPOR_YERI_ADI
          , MODUL_ID
          , ESKI_RAPOR_NO
     FROM KULLANICI_MENU
     }
     // Mi:=TMenuItem.Create(Menu);
     //qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU');
     //mi.Free;
     //if qryGENEL.FieldByName('ADI').AsString
     //qryGENEL.FieldByName('ADI').AsString);

     b:=Menu.Items[3].Count-1;
     if b>=0 then
     for a:=b downto 0 do
     begin
          Menu.Items[3].Delete(a);
     end;

     DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaANA);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where UST_ID=0 and GOSTER=1');
     qryTemp.Active:=True;
     qryTemp.First;
     While not qryTemp.Eof do
     begin
          Mi:=TMenuItem.Create(Menu);
          Mi.Caption:=qryTemp.FieldByName('ADI').AsString;
          if qryTemp.FieldByName('ISLEM_VAR').AsInteger=1 then
          //mi.OnClick:=Dm_Fast_Report.Kullanici_Rapor_Click
          mi.OnClick:=Kullanici_Rapor_Click
          else mi.OnClick:=Nil;
          Mi.Tag:=qryTemp.FieldByName('ID').AsInteger;
          Menu.Items[3].Add(Mi);
          qryTemp.Next;
     end;

     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('SELECT ID, ADI, UST_ID, ISLEM_VAR, RAPOR_YERI_ADI, MODUL_ID, ESKI_RAPOR_NO FROM KULLANICI_MENU Where UST_ID>0 and GOSTER=1');
     qryTemp.Active:=True;
     qryTemp.First;
     While not qryTemp.Eof do
     begin
          Mi:=TMenuItem.Create(Menu);
          Mi.Caption:=qryTemp.FieldByName('ADI').AsString;
          if qryTemp.FieldByName('ISLEM_VAR').AsInteger=1 then
          //mi.OnClick:=Dm_Fast_Report.Kullanici_Rapor_Click
          mi.OnClick:=Kullanici_Rapor_Click
          else mi.OnClick:=Nil;
          Mi.Tag:=qryTemp.FieldByName('ID').AsInteger;
          Menu.Items[3].Items[qryTemp.FieldByName('UST_ID').AsInteger-1].Add(Mi);
          qryTemp.Next;
     end;
end;


function TDataMod.Resim_Bul(Dosya_Adi:String;Tip:String):Boolean;
var
   qryTemp:TIB_Query;
begin
     Result:=False;
     DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);

     {if Tip<>'ARC' then
     begin

     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('SELECT RESIM FROM ARAC WHERE RESIM=:RESIM');
     qryTemp.ParamByName('RESIM').AsString:=Dosya_Adi;
     qryTemp.Active:=True;
     if qryTemp.RecordCount>0 then Result:=True;
     end; }

     if Tip<>'SFR' then
     begin
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('SELECT RESIM FROM SOFOR WHERE RESIM=:RESIM');
     qryTemp.ParamByName('RESIM').AsString:=Dosya_Adi;
     qryTemp.Active:=True;
     if qryTemp.RecordCount>0 then Result:=True;
     end;

     if Tip<>'KOM' then
     begin
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('SELECT RESIM FROM KOMISYON WHERE RESIM=:RESIM');
     qryTemp.ParamByName('RESIM').AsString:=Dosya_Adi;
     qryTemp.Active:=True;
     if qryTemp.RecordCount>0 then Result:=True;
     end;
end;






function TDataMod.Onarim_Fatura_Ayarla(Transaction: TIB_Transaction;Onarim_Id:Integer;Onarim_SId:Integer;
Tarihi:TDateTime;
FNo:String;
Id:Integer):Boolean;
var
   qryTemp:TIB_Query;
begin
     Result:=False;
     DataMod.CreateQuery(qryTemp,Transaction,False,DataMod.dbaMain);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('UPDATE SRV_ARAC_ONARIM SET KAPANDI=''1'', FATURA_TARIHI=:FATURA_TARIHI,FATURA_NO=:FATURA_NO,FATURA_ID=:FATURA_ID'+
     ' WHERE ONARIM_ID=:ONARIM_ID AND ONARIM_SID=:ONARIM_SID');

     qryTemp.ParamByName('FATURA_TARIHI').AsDate:=Tarihi;
     qryTemp.ParamByName('FATURA_NO').AsString:=FNo;
     qryTemp.ParamByName('FATURA_ID').AsInteger:=Id;
     qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
     qryTemp.ParamByName('ONARIM_sID').AsInteger:=Onarim_SId;
     qryTemp.Execute;
     Onarim_Kapandi_Ayarla(Transaction,Onarim_Id,Onarim_Sid);
end;



function TDataMod.Onarim_Grup_Toplam(Transaction: TIB_Transaction;Onarim_Id:Integer;Onarim_SId:Integer;Grup:String):Double;
var
   qryTemp:TIB_Query;
begin
     Result:=0;
     DataMod.CreateQuery(qryTemp,Transaction,False,DataMod.dbaMain);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add(
     'select Sum(TUTAR_VPB) Gelen from '+
     'SRV_ARAC_ONARIM_D O '+
     'left OUTER JOIN URUN_GRUP_UYE U ON (O.URUN_KOD=U.URUN_KOD) '+
     'where '+
     'ONARIM_ID=:ONARIM_ID AND ONARIM_SID=:ONARIM_SID AND ');
     if grup='MAL' then
     qryTemp.SQL.Add(' U.URUN_GRUP_KOD='+Sql_Katar(glb_S_MAL_GRUP_KOD));
     if grup='ISCI' then
     qryTemp.SQL.Add(' U.URUN_GRUP_KOD='+Sql_Katar(glb_S_ISCI_GRUP_KOD));
     if grup='DIAG' then
     qryTemp.SQL.Add(' U.URUN_GRUP_KOD='+Sql_Katar(glb_S_DIAG_GRUP_KOD));

     qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
     qryTemp.ParamByName('ONARIM_SID').AsInteger:=Onarim_SId;
     qryTemp.Active:=True;
     Result:=
     qryTemp.FieldByName('Gelen').AsFloat;

     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     if grup='MAL' then
     qryTemp.SQL.Add('update SRV_ARAC_ONARIM SET MALZEME_FIYATI=:MALZEME_FIYATI WHERE ONARIM_ID=:ONARIM_ID AND ONARIM_SID=:ONARIM_SID');
     if grup='ISCI' then
     qryTemp.SQL.Add('update SRV_ARAC_ONARIM SET ISCILIK_FIYATI=:MALZEME_FIYATI WHERE ONARIM_ID=:ONARIM_ID AND ONARIM_SID=:ONARIM_SID');
     if grup='DIAG' then
     qryTemp.SQL.Add('update SRV_ARAC_ONARIM SET DIAGNOSTIK_FIYATI=:MALZEME_FIYATI WHERE ONARIM_ID=:ONARIM_ID AND ONARIM_SID=:ONARIM_SID');

     qryTemp.ParamByName('MALZEME_FIYATI').Asfloat:=Result;

     qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
     qryTemp.ParamByName('ONARIM_sID').AsInteger:=Onarim_Sid;
     qryTemp.Execute;
end;

function TDataMod.Onarim_Kapandi_Ayarla(Transaction: TIB_Transaction;Onarim_Id:Integer;Onarim_SId:Integer):Boolean;
var
   qryTemp:TIB_Query;
begin
     Result:=False;
     DataMod.CreateQuery(qryTemp,Transaction,False,DataMod.dbaMain);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('select count(*) Gelen from SRV_ARAC_ONARIM_D WHERE ONARIM_ID=:ONARIM_ID AND ONARIM_SID=:ONARIM_SID and FATURA_URUN_HAR_ID>0');
     qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
     qryTemp.ParamByName('ONARIM_SID').AsInteger:=Onarim_SId;
     qryTemp.Active:=True;
     if qryTemp.FieldByName('Gelen').AsInteger>0 then
     begin

{              if not DataMod.Onarim_ON_MUH_ENT(1,Transaction,qryTemp,1) then
              begin
                Transaction.RollbackRetaining;
                Abort;
                //dmLOGGER.dbaMain_CancelMonitoring;
                //Exit;
              end;
}
          qryTemp.Active:=False;
          qryTemp.SQL.Clear;
          qryTemp.SQL.Add('update SRV_ARAC_ONARIM SET KAPANDI=''1'' WHERE ONARIM_ID=:ONARIM_ID AND ONARIM_SID=:ONARIM_SID');
          qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
          qryTemp.ParamByName('ONARIM_sID').AsInteger:=Onarim_Sid;
          qryTemp.Execute;
     end
     else
     begin
          qryTemp.Active:=False;
          qryTemp.SQL.Clear;
          qryTemp.SQL.Add('update SRV_ARAC_ONARIM SET KAPANDI=''0'' WHERE ONARIM_ID=:ONARIM_ID AND ONARIM_SID=:ONARIM_SID');
          qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
          qryTemp.ParamByName('ONARIM_sID').AsInteger:=Onarim_Sid;
          qryTemp.Execute;
     end;
end;


function TDataMod.Onarim_Kapandi_AyarlaD(Transaction: TIB_Transaction;Onarim_Did:Integer):Boolean;
var
   qryTemp:TIB_Query;
   Onarim_id:Integer;
begin
     Onarim_id:=0;
     Result:=False;
     DataMod.CreateQuery(qryTemp,Transaction,False,DataMod.dbaMain);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('select ONARIM_ID from SRV_ARAC_ONARIM_D WHERE URUNHAR_ID=:URUNHAR_ID');
     qryTemp.ParamByName('URUNHAR_ID').AsInteger:=Onarim_Did;
     qryTemp.Active:=True;
     Onarim_id:=qryTemp.FieldByName('ONARIM_ID').AsInteger;

     if Onarim_id>0 then
     begin
         qryTemp.Active:=False;
         qryTemp.SQL.Clear;
         qryTemp.SQL.Add('select count(*) Gelen from SRV_ARAC_ONARIM_D WHERE ONARIM_ID=:ONARIM_ID and FATURA_URUN_HAR_ID>0');
         qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
         qryTemp.Active:=True;

         if qryTemp.FieldByName('Gelen').AsInteger>0 then
         begin
              qryTemp.Active:=False;
              qryTemp.SQL.Clear;
              qryTemp.SQL.Add('update SRV_ARAC_ONARIM SET KAPANDI=''1'' WHERE ONARIM_ID=:ONARIM_ID');
              qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
              qryTemp.Execute;
         end
         else
         begin
              qryTemp.Active:=False;
              qryTemp.SQL.Clear;
              qryTemp.SQL.Add('update SRV_ARAC_ONARIM SET KAPANDI=''0'' WHERE ONARIM_ID=:ONARIM_ID');
              qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_Id;
              qryTemp.Execute;
         end;
     end;
end;




function TDataMod.Son_Onarim_Tar_Ayarla(Transaction: TIB_Transaction;Arac_Kod:String):Boolean;
var
   qryTemp:TIB_Query;
   Tar:TDateTime;
   Km:Integer;
begin
     Result:=False;
     DataMod.CreateQuery(qryTemp,Transaction,False,DataMod.dbaMain);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('select TESLIM_TAR from SRV_ARAC_ONARIM WHERE ARAC_KODU=:ARAC_KODU ORDER BY TESLIM_TAR DESC ');
     qryTemp.ParamByName('ARAC_KODU').AsString:=Arac_Kod;
     qryTemp.Active:=True;
     if qryTemp.RecordCount>0 then
     begin
          Tar:=qryTemp.FieldByName('TESLIM_TAR').AsDateTime;
          qryTemp.Active:=False;
          qryTemp.SQL.Clear;
          qryTemp.SQL.Add('update SRV_ARAC SET SON_ONARIM_TARIHI=:SON_ONARIM_TARIHI WHERE ARAC_KOD=:ARAC_KOD');
          qryTemp.ParamByName('SON_ONARIM_TARIHI').AsDateTime:=Tar;
          qryTemp.ParamByName('ARAC_KOD').AsString:=Arac_Kod;
          qryTemp.Execute;
     end;
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('select GIRIS_KM from SRV_ARAC_ONARIM WHERE ARAC_KODU=:ARAC_KODU ORDER BY GIRIS_KM DESC ');
     qryTemp.ParamByName('ARAC_KODU').AsString:=Arac_Kod;
     qryTemp.Active:=True;
     if qryTemp.RecordCount>0 then
     begin
          Km:=qryTemp.FieldByName('GIRIS_KM').AsInteger;
          qryTemp.Active:=False;
          qryTemp.SQL.Clear;
          qryTemp.SQL.Add('update SRV_ARAC SET SON_ONARIM_KM=:SON_ONARIM_KM WHERE ARAC_KOD=:ARAC_KOD');
          qryTemp.ParamByName('SON_ONARIM_KM').AsInteger:=Km;
          qryTemp.ParamByName('ARAC_KOD').AsString:=Arac_Kod;
          qryTemp.Execute;
     end;
end;



function TDataMod.Onarim_ON_MUH_ENT(SIL:Byte;Transaction: TIB_Transaction;qryFAT_IRS:TIb_Query;PRV_ISN:Integer):Boolean;
var
  BELGE_ID,BELGE_SID,a:Integer;
  Proje_BA,Cari_BA,URUN_HAR_TIP:Char;
  ISLEM_SIRA_NO:Byte;
  Proje_Sil,Cari_Sil:Byte;
begin
       Cari_BA := BORC;
//       Cari_BA := ALACAK;
       Proje_BA := ALACAK;
       ISLEM_SIRA_NO := 1;
       Cari_Sil:=Sil;

       if qryFAT_IRS.FieldbyName('IPTAL').AsInteger=1 then
       Cari_Sil:=1;


       if not DataMod.CARIHAR_AUD(Transaction,
                          BT_ONARIM_FISI,
                          qryFAT_IRS.FieldbyName('ONARIM_ID').AsInteger,
                          qryFAT_IRS.FieldbyName('ONARIM_SID').AsInteger,
                          ISLEM_SIRA_NO,
                          qryFAT_IRS.FieldbyName('CARI_KOD').AsString,
                          Cari_BA,
                          qryFAT_IRS.FieldbyName('GIRIS_TARIH').AsDate,
                          qryFAT_IRS.FieldbyName('GIRIS_TARIH').AsDate,
                          qryFAT_IRS.FieldbyName('GIRIS_TARIH').AsDate,
                          qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency,
                          glb_DEFCUR,
                          1,
                          qryFAT_IRS.FieldbyName('GENEL_TOP').AsCurrency,
                          qryFAT_IRS.FieldbyName('GIRIS_TARIH').AsDate,
                          qryFAT_IRS.FieldbyName('ACIKLAMA').AsString,
                          Cari_Sil,
                          PRV_ISN,
                          qryFAT_IRS.FieldByName('MASRAF_MERK').AsString,
                          qryFAT_IRS.FieldByName('KOD1').AsString,
                          qryFAT_IRS.FieldByName('KOD2').AsString,
                          qryFAT_IRS.FieldByName('KOD3').AsString,
                          qryFAT_IRS.FieldByName('KOD4').AsString,
                          '',
                          qryFAT_IRS.FieldByName('PROJE_KOD').AsString,
                          BELGE_ID,
                          BELGE_SID) then
        begin
          Result := False;
          Exit;
        end;
  Result := True;
end;



function TDataMod.Onarim_Kapandi_Ba_Ayarla(Transaction: TIB_Transaction;Fat_Irs_Id:Integer):Boolean;
var
   qryTemp,qryTemp1:TIB_Query;
   Onarim_id,a:Integer;
   str:String;
   on_id:TstringList;
begin
	   on_id:=TstringList.Create;
     Onarim_id:=0;
     Result:=False;
     DataMod.CreateQuery(qryTemp,Transaction,False,DataMod.dbaMain);
     DataMod.CreateQuery(qryTemp1,Transaction,False,DataMod.dbaMain);
     qryTemp.Active:=False;
     qryTemp.SQL.Clear;
     qryTemp.SQL.Add('select URUNHAR_ID,ONARIMD_ID from urunhar WHERE FATURA_ID=:FATURA_ID and ONARIMD_ID>0');
     qryTemp.ParamByName('FATURA_ID').AsInteger:=Fat_Irs_Id;
     qryTemp.Active:=True;
     //Onarim_id:=qryTemp.FieldByName('ONARIM_ID').AsInteger;
     str:='(';
     while not qryTemp.eof do
     begin
          if qryTemp.FieldByName('ONARIMD_ID').AsInteger>0 then
          if qryTemp.FieldByName('ONARIMD_ID').AsInteger=1999999 then
          begin

                qryTemp1.Active:=False;
                qryTemp1.SQL.Clear;
                qryTemp1.SQL.Add('select ONARIM_ID from SRV_ARAC_ONARIM_D WHERE FATURA_URUN_HAR_ID=:FATURA_URUN_HAR_ID');
                qryTemp1.ParamByName('FATURA_URUN_HAR_ID').AsInteger:=qryTemp.FieldByName('URUNHAR_ID').AsInteger;
                qryTemp1.Active:=True;
                while not qrytemp1.Eof do
                begin
                   if on_id.indexof(InttoStr(qryTemp1.FieldByName('ONARIM_ID').AsInteger))=-1 then
                     on_id.Add(InttoStr(qryTemp1.FieldByName('ONARIM_ID').AsInteger));
                					qrytemp1.Next;
                end;

          	//buna ait onarým id bul
          end;

          if qryTemp.FieldByName('ONARIMD_ID').AsInteger>0 then
          if qryTemp.FieldByName('ONARIMD_ID').AsInteger<>1999999 then
          begin
                qryTemp1.Active:=False;
                qryTemp1.SQL.Clear;
                qryTemp1.SQL.Add('select ONARIM_ID from SRV_ARAC_ONARIM_D WHERE URUNHAR_ID=:URUNHAR_ID');
                qryTemp1.ParamByName('URUNHAR_ID').AsInteger:=qryTemp.FieldByName('ONARIMD_ID').AsInteger;
                qryTemp1.Active:=True;
                while not qrytemp1.Eof do
                begin
                   if on_id.indexof(InttoStr(qryTemp1.FieldByName('ONARIM_ID').AsInteger))=-1 then
                     on_id.Add(InttoStr(qryTemp1.FieldByName('ONARIM_ID').AsInteger));
                					qrytemp1.Next;
                end;

          end;
          qryTemp.Next;
     end;

     for a:=0 to on_id.Count-1 do
     begin
         Onarim_id:=Strtoint(on_id.Strings[a]);
         if Onarim_id>0 then
         begin
                 qryTemp.Active:=False;
                 qryTemp.SQL.Clear;
                 qryTemp.SQL.Add('select * from SRV_ARAC_ONARIM WHERE ONARIM_ID=:ONARIM_ID');
                 qryTemp.ParamByName('ONARIM_ID').AsInteger:=Onarim_id;
                 qryTemp.Active:=True;

                 if qryTemp.FieldByName('KAPANDI').AsString='1' then
                 if not DataMod.Onarim_ON_MUH_ENT(1,Transaction,qryTemp,1) then
                  begin
                    Transaction.RollbackRetaining;
                    Abort;
                    //dmLOGGER.dbaMain_CancelMonitoring;
                    //Exit;
                 end;
                 if qryTemp.FieldByName('KAPANDI').AsString='0' then
                 if not DataMod.Onarim_ON_MUH_ENT(0,Transaction,qryTemp,1) then
                  begin
                    Transaction.RollbackRetaining;
                    Abort;
                    //dmLOGGER.dbaMain_CancelMonitoring;
                    //Exit;
                  end;
         end;
     end;
end;

function TDataMod.LS_Plaka(var PLAKA_NO:String; Var ACIKLAMA:String; Var CARI_KOD:String; Var CARI_AD:String):Boolean;
var
  Kolonlar : TStringList;
begin
  Screen.Cursor := crHourGlass;
  Application.CreateForm(TfrmSrcDlg, frmSrcDlg);
  Screen.Cursor := crDefault;
  Kolonlar := TStringList.Create;
  Kolonlar.Add('PLAKA_NO');
  Kolonlar.Add('Plaka No');
  Kolonlar.Add('100');
  Kolonlar.Add('ACIKLAMA');
  Kolonlar.Add('Açýklama');
  Kolonlar.Add('150');
  Kolonlar.Add('CARI_KOD');
  Kolonlar.Add('Cari Kod');
  Kolonlar.Add('100');
  Kolonlar.Add('CARI_AD');
  Kolonlar.Add('Cari Adý');
  Kolonlar.Add('150');

  frmSrcDlg.Caption := 'Plaka Listesi';
  frmSrcDlg.List( 4 , Kolonlar ,'SELECT PLAKA_NO, ACIKLAMA, CARI_KOD, (Select CARI.CARI_AD From CARI Where CARI.CARI_KOD=PLAKA.CARI_KOD) As CARI_AD    FROM PLAKA','',1,0);

  if Kolonlar.Strings[0] <> 'CNC-LLD' then
  begin
     PLAKA_NO := Kolonlar.Strings[0];
     ACIKLAMA := Kolonlar.Strings[1];
     CARI_KOD := Kolonlar.Strings[2];
     CARI_AD := Kolonlar.Strings[3];

     Result := True;
  end
  else Result := False;
  Kolonlar.Free;
end;

function TDataMod.Kantar_ON_MUH_ENT(SIL:Byte;Transaction: TIB_Transaction;qry:TIb_Query;PRV_ISN:Integer):Boolean;
var
  BELGE_ID,BELGE_SID,a:Integer;
  Proje_BA,Cari_BA,URUN_HAR_TIP:Char;
  ISLEM_SIRA_NO:Byte;
  Proje_Sil,Cari_Sil:Byte;
begin
       Cari_BA := BORC;
//     Cari_BA := ALACAK;
       Proje_BA := ALACAK;
       ISLEM_SIRA_NO := 1;
       Cari_Sil:=Sil;

      { if qry.FieldbyName('IPTAL').AsInteger=1 then
       Cari_Sil:=1;
       }

       if not DataMod.CARIHAR_AUD(Transaction,
                          BT_KANTAR_FISI,
                          qry.FieldbyName('KANTAR_NO').AsInteger,
                          qry.FieldbyName('KANTAR_SID').AsInteger,
                          ISLEM_SIRA_NO,
                          qry.FieldbyName('CARI_KOD').AsString,
                          Cari_BA,
                          qry.FieldbyName('CIKIS_TARIHI').AsDate,
                          qry.FieldbyName('CIKIS_TARIHI').AsDate,
                          qry.FieldbyName('CIKIS_TARIHI').AsDate,
                          qry.FieldbyName('UCRETI').AsCurrency,
                          glb_DEFCUR,
                          1,
                          qry.FieldbyName('UCRETI').AsCurrency,
                          qry.FieldbyName('CIKIS_TARIHI').AsDate,
                          qry.FieldbyName('ACIKLAMA').AsString,
                          Cari_Sil,
                          PRV_ISN,
                          qry.FieldByName('MASRAF_MERK').AsString,
                          qry.FieldByName('KOD1').AsString,
                          qry.FieldByName('KOD2').AsString,
                          qry.FieldByName('KOD3').AsString,
                          qry.FieldByName('KOD4').AsString,
                          '',
                          qry.FieldByName('PROJE_KOD').AsString,
                          BELGE_ID,
                          BELGE_SID) then
        begin
          Result := False;
          Exit;
        end;

      //cari har end

  Result := True;
end;
end.

