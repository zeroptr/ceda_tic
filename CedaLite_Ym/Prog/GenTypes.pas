unit GenTypes;
interface
uses SysUtils, Classes, Controls;

  type TD_ACK=String[100];
  type TD_ACK30=String[30];
  type TD_ACK50=String[50];
  type TD_BARCODE=String[30];
  type TD_BOOLEAN=Smallint; //NOT NULL  CHECK ((VALUE = 0) or (VALUE =1));
  type TD_BORCALACAK = Char; //NOT NULL CHECK ((VALUE = 'A') or (VALUE ='B'));
  type TD_DKOD=String[5] ;
  type TD_FLOAT= Single;
  type TD_GTIP=String[20];
  type TD_ID_FIELD=Integer;
  type TD_IO= Char;//CHECK ((VALUE = 'G') or (VALUE ='C'));
  type TD_KOD=String[15];
  type TD_MEMO=WideString;
  type TD_MONEY = Currency;
  type TD_MUHKOD= String[30];
  type TD_TIME=TTime;
  type TD_SID=Byte;
  type TD_DATE=TDate;
  type TD_SMALLINT=Byte;
  type TD_URUN_KOD=String[35];
  type TD_INTEGER = Integer;
  type TD_DATETIME = TDateTime;
  type TD_BA = Char;

  type TBL_CEKSEN = Record
    CEKSEN:TD_SMALLINT;
    CEKSEN_ID:TD_ID_FIELD;
    CEKSEN_SID:TD_SID;
    CARI_KOD:TD_KOD;
    ISLEMTAR:TD_DATE;
    FIILI_TAR:TD_DATE;
    DOV_BAZ_TAR:TD_DATE;
    TANZIMTAR:TD_DATE;
    VADETAR:TD_DATE;
    BANKA_KOD:TD_KOD;
    BELGE_SAHIBI:TD_ACK50;
    BANKA_AD:TD_ACK50;
    HESAP_NO:TD_ACK30;
    CEK_NUM:TD_ACK30;
    TUTAR:TD_MONEY;
    DOVKUR:TD_MONEY;
    DOVKOD:TD_DKOD;
    DURUM:TD_SMALLINT;
    YER_KOD:TD_SMALLINT;
    TIP:TD_SMALLINT;
    ACIKLAMA:TD_ACK50;
    ASIL:TD_BOOLEAN;
    ODEME_TAR:TD_DATE;
    TUTAR_VPB:TD_MONEY;
    PROJE_KOD:TD_KOD;
    PLASIYER_KOD:TD_KOD;
    MASRAF_MERK:TD_KOD;
    KOD1:TD_KOD;
    KOD2:TD_KOD;
    KOD3:TD_KOD;
    KOD4:TD_KOD;
    SENET_SAHIBI,
    TANZIM_YER,
    KEFIL_1,
    KEFIL_2:TD_ACK50;
  end;

  type TBL_CEKSENHAR = Record
    CEKSENHAR_ID:TD_ID_FIELD;
    CEKSENHAR_SID:TD_SID;
    ISLEM_TAR,
    DOV_BAZ_TAR:TD_DATE;
    CEKSEN:TD_SMALLINT;
    CEKSEN_ID:TD_ID_FIELD;
    CEKSEN_SID:TD_SID;
    ISLEM:TD_SMALLINT;
    DOVKUR,
    TUTAR_VPB,
    KUR_FARKI:TD_MONEY;
    CARI_KOD,
    PLASIYER_KOD,
    PROJE_KOD:TD_KOD;
    CARIHAR_ACK,
    YEVMIYE_ACK:TD_ACK50;
    PROTESTO_MASRAF,
    GENEL_GIDER:TD_MONEY;
    GENEL_GIDER_MUH_KOD:TD_MUHKOD;
    BORCALHESAP:TD_MUHKOD;
    MASRAF_MERK,
    KOD1,
    KOD2,
    KOD3,
    KOD4,
    KASA_KOD:TD_KOD;
  end;

  type TBL_MUH_FIS_MAS = Record
    MUH_FIS_MAS_ID   :TD_ID_FIELD;
    MUH_FIS_MAS_SID  :TD_SID;
    TARIH            :TD_DATE;
    DOV_BAZ_TAR      :TD_DATE;
    FIS_TIP          :TD_SMALLINT;
    ACIKLAMA_1       :TD_ACK50;
    ACIKLAMA_2       :TD_ACK50;
    YEV_MAD_NO       :TD_INTEGER;
    MASRAF_MERK      ,
    KOD1             ,
    KOD2             ,
    KOD3             ,
    KOD4             :TD_KOD;
    HAR_SEBEP        :CHAR;
    FIS_GRUP         :TD_SMALLINT;
    ENT_ID           :TD_ID_FIELD;
    ENT_SID          :TD_SID;
  end;
  type TBL_MUH_FIS = Record
    MUH_FIS_ID       :TD_ID_FIELD;
    MUH_FIS_SID      :TD_SID;
    MUH_FIS_MAS_ID   :TD_ID_FIELD;
    MUH_FIS_MAS_SID  :TD_SID;
    HESAP_KOD        :TD_MUHKOD;
    ISLEM_TAR        :TD_DATE;
    DOV_BAZ_TAR      :TD_DATE;
    KAYIT_TAR        :TD_DATETIME;
    BA               :TD_BA;
    ACIKLAMA         :TD_ACK50;
    ACIKLAMA_2       :TD_ACK50;
    HAR_SEBEP        :CHAR;
    TUTAR            :TD_MONEY;
    DOVKOD           :TD_DKOD;
    DOVKUR           :TD_MONEY;
    TUTAR_VPB        :TD_MONEY;
    OLCUBIRIM        :TD_KOD;
    MIKTAR           :TD_MONEY;
    ISN              :TD_INTEGER;
    ENT_REF_CODE     :TD_ACK30;
    MASRAF_MERK      ,
    KOD1             ,
    KOD2             ,
    KOD3             ,
    KOD4             ,
    PROJE_KOD        :TD_KOD;
    ENT_ID           :TD_ID_FIELD;
    ENT_SID          :TD_SID;
  end;

  type MUHASEBE_FISI = Record
    MASTER:TBL_MUH_FIS_MAS;
    DETAIL: Array of TBL_MUH_FIS;
  end;
  type TBL_BELGE_YAZ = Record
    BELGE_TUR   :TD_ID_FIELD;
    SIRA_NO     :TD_SMALLINT;
    DOSYA_PATH  :String;
    YAZICI      :TD_ACK;
    ACIKLAMA    :TD_ACK30;
    ESC_MODE    :TD_SMALLINT;
    SATIR_SAY   :TD_INTEGER;
  end;
implementation

end.
