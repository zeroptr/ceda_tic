object Yazici: TYazici
  OldCreateOrder = False
  Height = 533
  Width = 926
  object qryFatura: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    KeyLinks.Strings = (
      'FAT_IRS.FAT_IRS_SEP'
      'FAT_IRS.FAT_IRS_ID'
      'FAT_IRS.FAT_IRS_SID')
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryFaturaCalcFields
    SQL.Strings = (
      'SELECT * FROM FAT_IRS ')
    FieldOptions = []
    Left = 40
    Top = 16
    object qryFaturaFAT_IRS_SEP: TSmallintField
      FieldName = 'FAT_IRS_SEP'
      Required = True
    end
    object qryFaturaFAT_IRS_ID: TIntegerField
      FieldName = 'FAT_IRS_ID'
    end
    object qryFaturaFAT_IRS_SID: TSmallintField
      FieldName = 'FAT_IRS_SID'
      Required = True
    end
    object qryFaturaCARI_KOD: TStringField
      FieldName = 'CARI_KOD'
      Required = True
      Size = 15
    end
    object qryFaturaFAT_IRS_SERI: TStringField
      FieldName = 'FAT_IRS_SERI'
      Required = True
      Size = 15
    end
    object qryFaturaBELGE_NO: TStringField
      FieldName = 'BELGE_NO'
      Required = True
      Size = 50
    end
    object qryFaturaDOV_BAZ_TAR: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object qryFaturaTARIH: TDateField
      FieldName = 'TARIH'
    end
    object qryFaturaREF_BELGE_TUR: TSmallintField
      FieldName = 'REF_BELGE_TUR'
    end
    object qryFaturaREF_BELGE_ID: TIntegerField
      FieldName = 'REF_BELGE_ID'
    end
    object qryFaturaREF_BELGE_SID: TSmallintField
      FieldName = 'REF_BELGE_SID'
      Required = True
    end
    object qryFaturaACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Size = 100
    end
    object qryFaturaBRUT_TOP: TBCDField
      FieldName = 'BRUT_TOP'
      Size = 8
    end
    object qryFaturaNET_TOP: TBCDField
      FieldName = 'NET_TOP'
      Size = 8
    end
    object qryFaturaGENEL_TOP: TBCDField
      FieldName = 'GENEL_TOP'
      Size = 8
    end
    object qryFaturaKDV_TOP: TBCDField
      FieldName = 'KDV_TOP'
      Size = 8
    end
    object qryFaturaTIP: TSmallintField
      FieldName = 'TIP'
    end
    object qryFaturaFAT_IRS_TIP: TSmallintField
      FieldName = 'FAT_IRS_TIP'
    end
    object qryFaturaYAZILDI: TSmallintField
      FieldName = 'YAZILDI'
    end
    object qryFaturaIPTAL: TSmallintField
      FieldName = 'IPTAL'
      Required = True
    end
    object qryFaturaDEPO_KOD: TStringField
      FieldName = 'DEPO_KOD'
      Size = 15
    end
    object qryFaturaSAAT: TTimeField
      FieldName = 'SAAT'
    end
    object qryFaturaKALEM_ISKONTO_TOPLAM_VPB: TBCDField
      FieldName = 'KALEM_ISKONTO_TOPLAM_VPB'
      Size = 8
    end
    object qryFaturaISKONTO_TIP: TSmallintField
      FieldName = 'ISKONTO_TIP'
    end
    object qryFaturaISKONTO_ORAN: TSmallintField
      FieldName = 'ISKONTO_ORAN'
    end
    object qryFaturaISKONTO_TUTAR_VPB: TBCDField
      FieldName = 'ISKONTO_TUTAR_VPB'
      Size = 8
    end
    object qryFaturaISKONTO_TOPLAM_VPB: TBCDField
      FieldName = 'ISKONTO_TOPLAM_VPB'
      Size = 8
    end
    object qryFaturaKDV1: TBCDField
      FieldName = 'KDV1'
      Size = 8
    end
    object qryFaturaKDV2: TBCDField
      FieldName = 'KDV2'
      Size = 8
    end
    object qryFaturaKDV3: TBCDField
      FieldName = 'KDV3'
      Size = 8
    end
    object qryFaturaKDV4: TBCDField
      FieldName = 'KDV4'
      Size = 8
    end
    object qryFaturaKDV5: TBCDField
      FieldName = 'KDV5'
      Size = 8
    end
    object qryFaturaOTV: TBCDField
      FieldName = 'OTV'
      Size = 8
    end
    object qryFaturaVADE_GUN: TIntegerField
      FieldName = 'VADE_GUN'
    end
    object qryFaturaVADE_TARIH: TDateField
      FieldName = 'VADE_TARIH'
    end
    object qryFaturaKDV1_ORAN: TSmallintField
      FieldName = 'KDV1_ORAN'
    end
    object qryFaturaKDV2_ORAN: TSmallintField
      FieldName = 'KDV2_ORAN'
    end
    object qryFaturaKDV3_ORAN: TSmallintField
      FieldName = 'KDV3_ORAN'
    end
    object qryFaturaKDV4_ORAN: TSmallintField
      FieldName = 'KDV4_ORAN'
    end
    object qryFaturaKDV5_ORAN: TSmallintField
      FieldName = 'KDV5_ORAN'
    end
    object qryFaturaODEMETAR: TDateField
      FieldName = 'ODEMETAR'
    end
    object qryFaturaMUHTELIF: TSmallintField
      FieldName = 'MUHTELIF'
      Required = True
    end
    object qryFaturaKASA_KOD: TStringField
      FieldName = 'KASA_KOD'
      Size = 15
    end
    object qryFaturaPLASIYER_KOD: TStringField
      FieldName = 'PLASIYER_KOD'
      Size = 15
    end
    object qryFaturaPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object qryFaturaMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object qryFaturaKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object qryFaturaKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object qryFaturaKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object qryFaturaKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object qryFaturaYEV_ACIKLAMA: TStringField
      FieldName = 'YEV_ACIKLAMA'
      Size = 50
    end
    object qryFaturaGTYAZIILE: TStringField
      DisplayWidth = 255
      FieldKind = fkCalculated
      FieldName = 'GTYAZILE'
      Size = 255
      Calculated = True
    end
    object qryFaturaGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 255
      Calculated = True
    end
    object qryFaturaGTDOVIZ: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTDOVIZ'
      Size = 255
      Calculated = True
    end
    object qryFaturaGUN: TStringField
      FieldKind = fkCalculated
      FieldName = 'GUN'
      Size = 2
      Calculated = True
    end
    object qryFaturaAY: TStringField
      FieldKind = fkCalculated
      FieldName = 'AY'
      Size = 2
      Calculated = True
    end
    object qryFaturaYILX: TStringField
      FieldKind = fkCalculated
      FieldName = 'YILX'
      Size = 4
      Calculated = True
    end
    object qryFaturaYILSON: TStringField
      FieldKind = fkCalculated
      FieldName = 'YILSON'
      Size = 1
      Calculated = True
    end
  end
  object qryFaturaD: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    SQL.Strings = (
      'select * from URUNHAR where fatura_id=1068 and fatura_sid=1')
    FieldOptions = []
    Left = 40
    Top = 80
  end
  object qryCari: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    RequestLive = True
    SQL.Strings = (
      'SELECT * FROM CARI')
    FieldOptions = []
    Left = 40
    Top = 136
    object qryCariCARI_KOD: TStringField
      FieldName = 'CARI_KOD'
      Required = True
      Size = 15
    end
    object qryCariCARI_SID: TSmallintField
      FieldName = 'CARI_SID'
      Required = True
    end
    object qryCariCARI_AD: TStringField
      FieldName = 'CARI_AD'
      Size = 50
    end
    object qryCariYETKISI: TStringField
      FieldName = 'YETKISI'
      Size = 50
    end
    object qryCariVERDAIRE: TStringField
      FieldName = 'VERDAIRE'
    end
    object qryCariVERNO: TStringField
      FieldName = 'VERNO'
    end
    object qryCariADRES_1: TStringField
      FieldName = 'ADRES_1'
      Size = 50
    end
    object qryCariADRES_2: TStringField
      FieldName = 'ADRES_2'
      Size = 50
    end
    object qryCariILCE: TStringField
      FieldName = 'ILCE'
      Size = 30
    end
    object qryCariSEHIR: TStringField
      FieldName = 'SEHIR'
      Size = 30
    end
    object qryCariPOSTA_KOD: TStringField
      FieldName = 'POSTA_KOD'
      Size = 10
    end
    object qryCariTIP: TSmallintField
      FieldName = 'TIP'
    end
    object qryCariTEL_NO_1: TStringField
      FieldName = 'TEL_NO_1'
    end
    object qryCariTEL_NO_2: TStringField
      FieldName = 'TEL_NO_2'
    end
    object qryCariFAX: TStringField
      FieldName = 'FAX'
    end
    object qryCariE_MAIL: TStringField
      FieldName = 'E_MAIL'
      Size = 100
    end
    object qryCariWEB_ADDR: TStringField
      FieldName = 'WEB_ADDR'
      Size = 100
    end
    object qryCariNOTES: TMemoField
      FieldName = 'NOTES'
      BlobType = ftMemo
      Size = 8
    end
    object qryCariKREDILMT: TBCDField
      FieldName = 'KREDILMT'
      Size = 8
    end
    object qryCariRISK: TBCDField
      FieldName = 'RISK'
      Size = 8
    end
    object qryCariBORC: TBCDField
      FieldName = 'BORC'
      Size = 8
    end
    object qryCariALACAK: TBCDField
      FieldName = 'ALACAK'
      Size = 8
    end
    object qryCariULKE: TStringField
      FieldName = 'ULKE'
      Size = 30
    end
    object qryCariYURTDISI: TSmallintField
      FieldName = 'YURTDISI'
      Required = True
    end
    object qryCariISLEMTIP: TSmallintField
      FieldName = 'ISLEMTIP'
      Required = True
    end
    object qryCariMUHTELIF: TSmallintField
      FieldName = 'MUHTELIF'
      Required = True
    end
    object qryCariDEVREDEN_BORC: TBCDField
      FieldName = 'DEVREDEN_BORC'
      Size = 8
    end
    object qryCariDEVREDEN_ALACAK: TBCDField
      FieldName = 'DEVREDEN_ALACAK'
      Size = 8
    end
    object qryCariDOVIZLI: TSmallintField
      FieldName = 'DOVIZLI'
    end
    object qryCariDOVKOD: TStringField
      FieldName = 'DOVKOD'
      Size = 5
    end
  end
  object qryDekont: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    SQL.Strings = (
      'SELECT * FROM DEKONT WHERE DEKONT_ID=1172 AND DEKONT_SID=1')
    FieldOptions = []
    Left = 128
    Top = 16
  end
  object qryDekont_D: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    RequestLive = True
    SQL.Strings = (
      
        'SELECT BA,MC,ACIKLAMA1,KARSI_KOD,PROJE_KOD,TUTAR_VPB,(SELECT PRM' +
        '_KARSI_AD FROM GET_KARSI_AD(DEKONT_D.MC,DEKONT_D.KARSI_KOD)) AS ' +
        'KARSI_AD '
      'FROM DEKONT_D '
      'WHERE DEKONT_ID=1172 AND DEKONT_SID = 1 ORDER BY BA')
    FieldOptions = []
    Left = 128
    Top = 80
    object qryDekont_DALACAK: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ALACAK'
      Calculated = True
    end
    object qryDekont_DBORC: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'BORC'
      Calculated = True
    end
    object qryDekont_DBA: TStringField
      FieldName = 'BA'
      Required = True
      Size = 1
    end
    object qryDekont_DMC: TStringField
      FieldName = 'MC'
      Required = True
      Size = 1
    end
    object qryDekont_DKARSI_KOD: TStringField
      FieldName = 'KARSI_KOD'
      Required = True
      Size = 30
    end
    object qryDekont_DTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryDekont_DKARSI_AD: TStringField
      FieldName = 'KARSI_AD'
      ReadOnly = True
      Size = 50
    end
    object qryDekont_DACIKLAMA1: TStringField
      FieldName = 'ACIKLAMA1'
      Size = 100
    end
    object qryDekont_DPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
  end
  object qrySirket: TIBOQuery
    Params = <
      item
        DataType = ftInteger
        Name = 'PRM_SIRKET_ID'
        ParamType = ptInput
      end>
    DatabaseName = 'C:\Musteriler\ekinci\main.FDB'
    IB_Connection = DataMod.dbaANA
    ReadOnly = True
    RecordCountAccurate = True
    SQL.Strings = (
      
        'SELECT SIRKET_ID,SIRKET_AD,ADRES_1,ADRES_2,ILCE,SEHIR,VERDAIRE,V' +
        'ERNO FROM SIRKET'
      'WHERE SIRKET_ID=:PRM_SIRKET_ID')
    FieldOptions = []
    Left = 128
    Top = 136
    object qrySirketSIRKET_ID: TIntegerField
      FieldName = 'SIRKET_ID'
    end
    object qrySirketSIRKET_AD: TStringField
      FieldName = 'SIRKET_AD'
      Size = 100
    end
    object qrySirketADRES_1: TStringField
      FieldName = 'ADRES_1'
      Size = 50
    end
    object qrySirketADRES_2: TStringField
      FieldName = 'ADRES_2'
      Size = 50
    end
    object qrySirketILCE: TStringField
      FieldName = 'ILCE'
      Size = 30
    end
    object qrySirketSEHIR: TStringField
      FieldName = 'SEHIR'
      Size = 30
    end
    object qrySirketVERDAIRE: TStringField
      FieldName = 'VERDAIRE'
      Size = 50
    end
    object qrySirketVERNO: TStringField
      FieldName = 'VERNO'
      Size = 50
    end
  end
  object qryKASAHAR_D: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    RequestLive = True
    SQL.Strings = (
      
        'SELECT MC,KARSIKOD,TUTAR_VPB,(SELECT PRM_KARSI_AD FROM GET_KARSI' +
        '_AD(KASAHAR.MC,KASAHAR.KARSIKOD)) AS KARSI_AD'
      'FROM KASAHAR ')
    FieldOptions = []
    Left = 208
    Top = 80
    object qryKASAHAR_DMC: TStringField
      FieldName = 'MC'
      Size = 1
    end
    object qryKASAHAR_DKARSIKOD: TStringField
      FieldName = 'KARSIKOD'
      Required = True
      Size = 30
    end
    object qryKASAHAR_DTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryKASAHAR_DKARSI_AD: TStringField
      FieldName = 'KARSI_AD'
      ReadOnly = True
      Size = 50
    end
  end
  object qryKASAHARMAS: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryKASAHARMASCalcFields
    SQL.Strings = (
      'SELECT * FROM KASAHAR')
    FieldOptions = []
    Left = 208
    Top = 16
    object qryKASAHARMASKASAHAR_ID: TIntegerField
      FieldName = 'KASAHAR_ID'
    end
    object qryKASAHARMASKASAHAR_SID: TSmallintField
      FieldName = 'KASAHAR_SID'
      Required = True
    end
    object qryKASAHARMASKASA_KOD: TStringField
      FieldName = 'KASA_KOD'
      Required = True
      Size = 15
    end
    object qryKASAHARMASTARIH: TDateField
      FieldName = 'TARIH'
    end
    object qryKASAHARMASDOV_BAZ_TAR: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object qryKASAHARMASBELGE_TUR: TIntegerField
      FieldName = 'BELGE_TUR'
    end
    object qryKASAHARMASBELGE_ID: TIntegerField
      FieldName = 'BELGE_ID'
    end
    object qryKASAHARMASBELGE_SID: TSmallintField
      FieldName = 'BELGE_SID'
      Required = True
    end
    object qryKASAHARMASTIP: TStringField
      FieldName = 'TIP'
      Required = True
      Size = 1
    end
    object qryKASAHARMASACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Size = 50
    end
    object qryKASAHARMASKASADEGER: TBCDField
      FieldName = 'KASADEGER'
      Size = 8
    end
    object qryKASAHARMASISLEM_TIP: TSmallintField
      FieldName = 'ISLEM_TIP'
      Required = True
    end
    object qryKASAHARMASPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object qryKASAHARMASPLASIYER_KOD: TStringField
      FieldName = 'PLASIYER_KOD'
      Size = 15
    end
    object qryKASAHARMASMC: TStringField
      FieldName = 'MC'
      Size = 1
    end
    object qryKASAHARMASKARSIKOD: TStringField
      FieldName = 'KARSIKOD'
      Required = True
      Size = 30
    end
    object qryKASAHARMASSIRA_NO: TIntegerField
      FieldName = 'SIRA_NO'
    end
    object qryKASAHARMASDOVKOD: TStringField
      FieldName = 'DOVKOD'
      Size = 5
    end
    object qryKASAHARMASDOVKUR: TBCDField
      FieldName = 'DOVKUR'
      Size = 8
    end
    object qryKASAHARMASTUTAR: TBCDField
      FieldName = 'TUTAR'
      Size = 8
    end
    object qryKASAHARMASTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryKASAHARMASOLCUBIRIM: TStringField
      FieldName = 'OLCUBIRIM'
      Size = 15
    end
    object qryKASAHARMASMIKTAR: TBCDField
      FieldName = 'MIKTAR'
      Size = 8
    end
    object qryKASAHARMASMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object qryKASAHARMASKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object qryKASAHARMASKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object qryKASAHARMASKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object qryKASAHARMASKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object qryKASAHARMASYEVMIYE_ACK: TStringField
      FieldName = 'YEVMIYE_ACK'
      Size = 50
    end
    object qryKASAHARMASBASLIK: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASLIK'
      Size = 100
      Calculated = True
    end
    object qryKASAHARMASKARSI_AD: TStringField
      FieldName = 'KARSI_AD'
      Size = 50
    end
    object qryKASAHARMASGTYAZI: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 100
      Calculated = True
    end
    object qryKASAHARMASGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 100
      Calculated = True
    end
  end
  object rptYazdir: TprTxReport
    DesignerFormMode = fmMDIChild
    PreviewFormMode = fmMDIChild
    FromPage = 1
    ToPage = 1
    Values = <>
    Variables = <
      item
        Name = 'esers'
        ValueType = 'prvvtString'
        Value = 'tttttttttttttttttttt'
      end>
    PrinterName = 'EPSON LX-300+'
    OnUnknownVariable = rptYazdirUnknownVariable
    OnPrintComplete = rptYazdirPrintComplete
    ESCModelName = 'Epson printers'
    RecodeTableName = 'Auto_857_to_1254'
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 10
    FromLine = 1
    ToLine = 54
    Left = 440
    Top = 162
    SystemInfo = (
      'OS: WIN32_NT 5.1.2600 Service Pack 2'
      ''
      'PageSize: 4096'
      'ActiveProcessorMask: $1000'
      'NumberOfProcessors: 1'
      'ProcessorType: 586'
      ''
      'PReport version: 1.9.6')
    object prTxPage1: TprTxPage
      PageType = tptPage
      LineNum = 60
      ColNum = 80
      object prTxHTitleBand1: TprTxHTitleBand
        Height = 14
        object prTxMemoObj1: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'KASALAR ARASI TRANSFER F'#304#350#304)
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 24
          dRec.Top = 0
          dRec.Right = 57
          dRec.Bottom = 1
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[qrySirket.SIRKET_AD] '
                '[qrySirket.ADRES_1]'
                '[qrySirket.ADRES_2]'
                '[qrySirket.ILCE]-[qrySirket.SEHIR]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = True
              CanResizeY = True
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = True
              TxFontStyleEx = tfsNormal
            end>
          dRec.Left = 1
          dRec.Top = 2
          dRec.Right = 29
          dRec.Bottom = 8
        end
        object prTxMemoObj3: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Tarih      : [qryTRANSFER.TARIH]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 38
          dRec.Top = 2
          dRec.Right = 70
          dRec.Bottom = 3
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Bor'#231'lu Kasa   : [qryTRANSFER.KASA_AD]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 38
          dRec.Top = 3
          dRec.Right = 78
          dRec.Bottom = 4
        end
        object prTxMemoObj6: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[qryTRANSFER.YEVMIYE_ACK]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 12
          dRec.Right = 72
          dRec.Bottom = 13
        end
        object prTxMemoObj7: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Alacak Kasa   : [qryTRANSFER.KARSIAD]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 38
          dRec.Top = 4
          dRec.Right = 78
          dRec.Bottom = 5
        end
        object prTxHLineObj1: TprTxHLineObj
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 1
          dRec.Top = 11
          dRec.Right = 72
          dRec.Bottom = 12
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'YEVM'#304'YE A'#199'IKLAMASI')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 10
          dRec.Right = 29
          dRec.Bottom = 11
        end
        object prTxMemoObj9: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'TUTAR')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 21
          dRec.Top = 14
          dRec.Right = 44
          dRec.Bottom = 15
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 1
        DataSetName = 'qryTRANSFER'
        Bands = (
          'prTxHDetailHeaderBand1'
          'prTxHDetailFooterBand1')
        object prTxMemoObj12: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#.#,#>qryTRANSFER.TUTAR]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvBottom
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 21
          dRec.Top = 0
          dRec.Right = 44
          dRec.Bottom = 1
        end
        object prTxMemoObj13: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,#,#>qryTRANSFER.TUTAR_VPB]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvBottom
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 46
          dRec.Top = 0
          dRec.Right = 72
          dRec.Bottom = 1
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,#,#>qryTRANSFER.DOVKUR]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvBottom
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 19
          dRec.Bottom = 1
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 2
        DetailBand = rptYazdir.prTxHDetailBand1
        object prTxHLineObj2: TprTxHLineObj
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 19
          dRec.Bottom = 2
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'D'#214'V'#304'Z KURU')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 19
          dRec.Bottom = 1
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'TUTAR VPB')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 46
          dRec.Top = 0
          dRec.Right = 72
          dRec.Bottom = 1
        end
        object prTxHLineObj3: TprTxHLineObj
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 21
          dRec.Top = 1
          dRec.Right = 44
          dRec.Bottom = 2
        end
        object prTxHLineObj4: TprTxHLineObj
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 46
          dRec.Top = 1
          dRec.Right = 72
          dRec.Bottom = 2
        end
      end
      object prTxHDetailFooterBand1: TprTxHDetailFooterBand
        Height = 4
        DetailBand = rptYazdir.prTxHDetailBand1
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = False
        object prTxHLineObj5: TprTxHLineObj
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 19
          dRec.Bottom = 1
        end
        object prTxHLineObj6: TprTxHLineObj
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 21
          dRec.Top = 0
          dRec.Right = 44
          dRec.Bottom = 1
        end
        object prTxHLineObj7: TprTxHLineObj
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 46
          dRec.Top = 0
          dRec.Right = 72
          dRec.Bottom = 1
        end
        object prTxMemoObj14: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'YALNIZ [qryTRANSFER.GTYAZI]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 2
          dRec.Right = 72
          dRec.Bottom = 3
        end
      end
    end
  end
  object qryKASAHAR: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    KeyLinks.Strings = (
      'KASAHAR.KASAHAR_ID'
      'KASAHAR.KASAHAR_SID')
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryKASAHARCalcFields
    SQL.Strings = (
      'SELECT * FROM KASAHAR WHERE KASAHAR_ID=1257 AND KASAHAR_SID=1')
    FieldOptions = []
    Left = 208
    Top = 136
    object qryKASAHARKASAHAR_ID: TIntegerField
      FieldName = 'KASAHAR_ID'
    end
    object qryKASAHARKASAHAR_SID: TSmallintField
      FieldName = 'KASAHAR_SID'
      Required = True
    end
    object qryKASAHARKASA_KOD: TStringField
      FieldName = 'KASA_KOD'
      Required = True
      Size = 15
    end
    object qryKASAHARTARIH: TDateField
      FieldName = 'TARIH'
    end
    object qryKASAHARDOV_BAZ_TAR: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object qryKASAHARBELGE_TUR: TIntegerField
      FieldName = 'BELGE_TUR'
    end
    object qryKASAHARBELGE_ID: TIntegerField
      FieldName = 'BELGE_ID'
    end
    object qryKASAHARBELGE_SID: TSmallintField
      FieldName = 'BELGE_SID'
      Required = True
    end
    object qryKASAHARTIP: TStringField
      FieldName = 'TIP'
      Required = True
      Size = 1
    end
    object qryKASAHARACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Size = 50
    end
    object qryKASAHARKASADEGER: TBCDField
      FieldName = 'KASADEGER'
      Size = 8
    end
    object qryKASAHARISLEM_TIP: TSmallintField
      FieldName = 'ISLEM_TIP'
      Required = True
    end
    object qryKASAHARPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object qryKASAHARPLASIYER_KOD: TStringField
      FieldName = 'PLASIYER_KOD'
      Size = 15
    end
    object qryKASAHARMC: TStringField
      FieldName = 'MC'
      Size = 1
    end
    object qryKASAHARKARSIKOD: TStringField
      FieldName = 'KARSIKOD'
      Required = True
      Size = 30
    end
    object qryKASAHARSIRA_NO: TIntegerField
      FieldName = 'SIRA_NO'
    end
    object qryKASAHARDOVKOD: TStringField
      FieldName = 'DOVKOD'
      Size = 5
    end
    object qryKASAHARDOVKUR: TBCDField
      FieldName = 'DOVKUR'
      Size = 8
    end
    object qryKASAHARTUTAR: TBCDField
      FieldName = 'TUTAR'
      Size = 8
    end
    object qryKASAHARTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryKASAHAROLCUBIRIM: TStringField
      FieldName = 'OLCUBIRIM'
      Size = 15
    end
    object qryKASAHARMIKTAR: TBCDField
      FieldName = 'MIKTAR'
      Size = 8
    end
    object qryKASAHARMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object qryKASAHARKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object qryKASAHARKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object qryKASAHARKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object qryKASAHARKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object qryKASAHARYEVMIYE_ACK: TStringField
      FieldName = 'YEVMIYE_ACK'
      Size = 50
    end
    object qryKASAHARBASLIK: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASLIK'
      Calculated = True
    end
    object qryKASAHARGTYAZI: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 100
      Calculated = True
    end
    object qryKASAHARGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 100
      Calculated = True
    end
  end
  object qryMUHFIS: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryMUHFISCalcFields
    RequestLive = True
    SQL.Strings = (
      
        'SELECT BA,ACIKLAMA,HESAP_KOD,TUTAR_VPB,(Select MUH_PLAN.HESAP_AD' +
        'I FROM MUH_PLAN where MUH_PLAN.HESAP_KOD=MUH_FIS.HESAP_KOD) as H' +
        'ESAP_ADI'
      'FROM MUH_FIS'
      'WHERE MUH_FIS_MAS_ID=425 AND MUH_FIS_MAS_SID = 1 ORDER BY BA')
    FieldOptions = []
    Left = 304
    Top = 80
    object qryMUHFISBA: TStringField
      FieldName = 'BA'
      Required = True
      Size = 1
    end
    object qryMUHFISHESAP_KOD: TStringField
      FieldName = 'HESAP_KOD'
      Required = True
      Size = 30
    end
    object qryMUHFISTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryMUHFISHESAP_ADI: TStringField
      FieldName = 'HESAP_ADI'
      ReadOnly = True
      Size = 50
    end
    object qryMUHFISTUTAR_BORC: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TUTAR_BORC'
      Calculated = True
    end
    object qryMUHFISTUTAR_ALACAK: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'TUTAR_ALACAK'
      Calculated = True
    end
    object qryMUHFISACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Required = True
      Size = 50
    end
  end
  object qryMUHFISMAS: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    SQL.Strings = (
      
        'SELECT * FROM MUH_FIS_MAS WHERE MUH_FIS_MAS_ID=425 AND MUH_FIS_M' +
        'AS_SID=1')
    FieldOptions = []
    Left = 304
    Top = 16
  end
  object qryToplam: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryToplamCalcFields
    SQL.Strings = (
      
        'SELECT SUM(TUTAR_VPB) AS TOPLAM FROM DEKONT_D WHERE DEKONT_ID=11' +
        '72 AND DEKONT_SID=1 AND BA='#39'B'#39)
    FieldOptions = []
    Left = 304
    Top = 136
    object qryToplamTOPLAM: TBCDField
      FieldName = 'TOPLAM'
      ReadOnly = True
      Size = 8
    end
    object qryToplamGTYAZI: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 100
      Calculated = True
    end
    object qryToplamGTYTLILE: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 100
      Calculated = True
    end
  end
  object qryCek: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryCekCalcFields
    SQL.Strings = (
      'SELECT * FROM CEK WHERE CEK_ID=19487 AND CEK_SID=1')
    FieldOptions = []
    Left = 304
    Top = 256
    object qryCekCEK_ID: TIntegerField
      FieldName = 'CEK_ID'
    end
    object qryCekCEK_SID: TSmallintField
      FieldName = 'CEK_SID'
      Required = True
    end
    object qryCekCARI_KOD: TStringField
      FieldName = 'CARI_KOD'
      Required = True
      Size = 15
    end
    object qryCekISLEMTAR: TDateField
      FieldName = 'ISLEMTAR'
    end
    object qryCekFIILI_TAR: TDateField
      FieldName = 'FIILI_TAR'
    end
    object qryCekDOV_BAZ_TAR: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object qryCekTANZIMTAR: TDateField
      FieldName = 'TANZIMTAR'
    end
    object qryCekVADETAR: TDateField
      FieldName = 'VADETAR'
    end
    object qryCekBANKA_KOD: TStringField
      FieldName = 'BANKA_KOD'
      Size = 15
    end
    object qryCekCEK_SAHIBI: TStringField
      FieldName = 'CEK_SAHIBI'
      Size = 50
    end
    object qryCekBANKA_AD: TStringField
      FieldName = 'BANKA_AD'
      Size = 50
    end
    object qryCekHESAP_NO: TStringField
      FieldName = 'HESAP_NO'
      Size = 50
    end
    object qryCekCEK_NUM: TStringField
      FieldName = 'CEK_NUM'
      Size = 30
    end
    object qryCekTUTAR: TBCDField
      FieldName = 'TUTAR'
      Size = 8
    end
    object qryCekDOVKUR: TBCDField
      FieldName = 'DOVKUR'
      Size = 8
    end
    object qryCekDOVKOD: TStringField
      FieldName = 'DOVKOD'
      Size = 5
    end
    object qryCekDURUM: TSmallintField
      FieldName = 'DURUM'
      Required = True
    end
    object qryCekYER_KOD: TSmallintField
      FieldName = 'YER_KOD'
    end
    object qryCekTIP: TSmallintField
      FieldName = 'TIP'
    end
    object qryCekACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Size = 100
    end
    object qryCekASIL: TSmallintField
      FieldName = 'ASIL'
      Required = True
    end
    object qryCekODEME_TAR: TDateField
      FieldName = 'ODEME_TAR'
    end
    object qryCekTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryCekPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object qryCekPLASIYER_KOD: TStringField
      FieldName = 'PLASIYER_KOD'
      Size = 15
    end
    object qryCekMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object qryCekKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object qryCekKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object qryCekKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object qryCekKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object qryCekGTYAZI: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 100
      Calculated = True
    end
    object qryCekCIKTAR: TDateField
      FieldKind = fkCalculated
      FieldName = 'CIKTAR'
      Calculated = True
    end
    object qryCekGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 100
      Calculated = True
    end
  end
  object qryKASACEKSENET: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryKASACEKSENETCalcFields
    SQL.Strings = (
      '')
    FieldOptions = []
    Left = 304
    Top = 200
    object qryKASACEKSENETCEKSENHAR_ID: TIntegerField
      FieldName = 'CEKSENHAR_ID'
    end
    object qryKASACEKSENETCEKSENHAR_SID: TIntegerField
      FieldName = 'CEKSENHAR_SID'
    end
    object qryKASACEKSENETISLEM_TAR: TDateField
      FieldName = 'ISLEM_TAR'
    end
    object qryKASACEKSENETCEKSEN: TSmallintField
      FieldName = 'CEKSEN'
    end
    object qryKASACEKSENETBELGE_ID: TIntegerField
      FieldName = 'BELGE_ID'
    end
    object qryKASACEKSENETKASA_KOD: TStringField
      FieldName = 'KASA_KOD'
      Size = 15
    end
    object qryKASACEKSENETPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object qryKASACEKSENETTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
    end
    object qryKASACEKSENETCARIHAR_ACK: TStringField
      FieldName = 'CARIHAR_ACK'
      Size = 50
    end
    object qryKASACEKSENETBASLIK: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASLIK'
      Size = 100
      Calculated = True
    end
    object qryKASACEKSENETGTYAZI: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 150
      Calculated = True
    end
    object qryKASACEKSENETGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 100
      Calculated = True
    end
  end
  object qryTRANSFER: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
    OnCalcFields = qryTRANSFERCalcFields
    SQL.Strings = (
      'SELECT '
      'KASAHAR_ID,'
      'KASAHAR_SID,'
      'KASA_KOD,'
      
        '(SELECT KASA.ACIKLAMA FROM KASA WHERE KASA.KASA_KOD=KASAHAR.KASA' +
        '_KOD) AS KASA_AD,'
      'KARSIKOD,'
      
        '(SELECT KASA.ACIKLAMA FROM KASA WHERE KASA.KASA_KOD=KASAHAR.KARS' +
        'IKOD) AS KARSIAD,'
      'TARIH,'
      'DOVKUR,'
      'TUTAR,'
      'TUTAR_VPB,'
      'ACIKLAMA,'
      'YEVMIYE_ACK'
      
        'FROM KASAHAR WHERE KASAHAR.BELGE_ID=1250 AND KASAHAR.BELGE_SID =' +
        '1')
    FieldOptions = []
    Left = 40
    Top = 200
    object qryTRANSFERKASAHAR_ID: TIntegerField
      FieldName = 'KASAHAR_ID'
    end
    object qryTRANSFERKASAHAR_SID: TSmallintField
      FieldName = 'KASAHAR_SID'
      Required = True
    end
    object qryTRANSFERKASA_KOD: TStringField
      FieldName = 'KASA_KOD'
      Required = True
      Size = 15
    end
    object qryTRANSFERKASA_AD: TStringField
      FieldName = 'KASA_AD'
      ReadOnly = True
      Size = 50
    end
    object qryTRANSFERKARSIKOD: TStringField
      FieldName = 'KARSIKOD'
      Required = True
      Size = 30
    end
    object qryTRANSFERKARSIAD: TStringField
      FieldName = 'KARSIAD'
      ReadOnly = True
      Size = 50
    end
    object qryTRANSFERTARIH: TDateField
      FieldName = 'TARIH'
    end
    object qryTRANSFERDOVKUR: TBCDField
      FieldName = 'DOVKUR'
      Size = 8
    end
    object qryTRANSFERTUTAR: TBCDField
      FieldName = 'TUTAR'
      Size = 8
    end
    object qryTRANSFERTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryTRANSFERACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Size = 50
    end
    object qryTRANSFERYEVMIYE_ACK: TStringField
      FieldName = 'YEVMIYE_ACK'
      Size = 50
    end
    object qryTRANSFERGTYAZI: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 150
      Calculated = True
    end
    object qryTRANSFERGTYTLILE: TStringField
      DisplayWidth = 150
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 150
      Calculated = True
    end
  end
  object qryBCEKODEME: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryBCEKODEMECalcFields
    SQL.Strings = (
      'SELECT CEKSENHAR_ID'
      '      ,CEKSENHAR_SID'
      '      ,ISLEM_TAR'
      '      ,BELGE_ID'
      '      ,CARI_KOD'
      '      ,PROJE_KOD'
      '      ,TUTAR_VPB'
      '      ,CARIHAR_ACK'
      
        '      ,(SELECT CEK_NUM FROM CEK WHERE CEK.CEK_ID=CEKSENHAR.BELGE' +
        '_ID) AS CEK_NO'
      'FROM CEKSENHAR'
      '')
    FieldOptions = []
    Left = 128
    Top = 200
    object StringField5: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 150
      Calculated = True
    end
    object qryBCEKODEMECEKSENHAR_ID: TIntegerField
      FieldName = 'CEKSENHAR_ID'
    end
    object qryBCEKODEMECEKSENHAR_SID: TIntegerField
      FieldName = 'CEKSENHAR_SID'
    end
    object qryBCEKODEMEISLEM_TAR: TDateField
      FieldName = 'ISLEM_TAR'
    end
    object qryBCEKODEMEBELGE_ID: TIntegerField
      FieldName = 'BELGE_ID'
    end
    object qryBCEKODEMECARI_KOD: TStringField
      FieldName = 'CARI_KOD'
      Size = 15
    end
    object qryBCEKODEMEPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object qryBCEKODEMETUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
    end
    object qryBCEKODEMECARIHAR_ACK: TStringField
      FieldName = 'CARIHAR_ACK'
      Size = 50
    end
    object qryBCEKODEMEGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 100
      Calculated = True
    end
    object qryBCEKODEMECEK_NO: TStringField
      FieldName = 'CEK_NO'
      ReadOnly = True
      Size = 30
    end
  end
  object qryMCEKCIRO: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    KeyLinks.Strings = (
      'CEKSENHAR.CEKSENHAR_ID'
      'CEKSENHAR.CEKSENHAR_SID')
    RecordCountAccurate = True
    OnCalcFields = qryMCEKCIROCalcFields
    SQL.Strings = (
      'SELECT CEKSENHAR_ID'
      '     , CEKSENHAR_SID'
      '     , ISLEM_TAR'
      '     , DOV_BAZ_TAR'
      '     , CEKSEN'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , ISLEM'
      '     , DOVKUR'
      '     , TUTAR_VPB'
      '     , KUR_FARKI'
      '     , CARI_KOD'
      
        '     , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=CEKSENHAR.C' +
        'ARI_KOD) AS CARI_AD'
      '     , PLASIYER_KOD'
      '     , PROJE_KOD'
      '     , CARIHAR_ACK'
      '     , YEVMIYE_ACK'
      '     , PROTESTO_MASRAF'
      '     , GENEL_GIDER'
      '     , GENEL_GIDER_MUH_KOD'
      '     , BORCALHESAP'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , KASA_KOD'
      'FROM CEKSENHAR')
    FieldOptions = []
    Left = 40
    Top = 256
    object qryMCEKCIROGTYAZI: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 100
      Calculated = True
    end
    object qryMCEKCIROCIKTAR: TDateField
      FieldKind = fkCalculated
      FieldName = 'CIKTAR'
      Calculated = True
    end
    object qryMCEKCIROCEKSENHAR_ID: TIntegerField
      FieldName = 'CEKSENHAR_ID'
    end
    object qryMCEKCIROCEKSENHAR_SID: TIntegerField
      FieldName = 'CEKSENHAR_SID'
    end
    object qryMCEKCIROISLEM_TAR: TDateField
      FieldName = 'ISLEM_TAR'
    end
    object qryMCEKCIRODOV_BAZ_TAR: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object qryMCEKCIROCEKSEN: TSmallintField
      FieldName = 'CEKSEN'
    end
    object qryMCEKCIROBELGE_ID: TIntegerField
      FieldName = 'BELGE_ID'
    end
    object qryMCEKCIROBELGE_SID: TSmallintField
      FieldName = 'BELGE_SID'
      Required = True
    end
    object qryMCEKCIROISLEM: TSmallintField
      FieldName = 'ISLEM'
    end
    object qryMCEKCIRODOVKUR: TBCDField
      FieldName = 'DOVKUR'
      Size = 8
    end
    object qryMCEKCIROTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryMCEKCIROKUR_FARKI: TBCDField
      FieldName = 'KUR_FARKI'
      Size = 8
    end
    object qryMCEKCIROCARI_KOD: TStringField
      FieldName = 'CARI_KOD'
      Size = 15
    end
    object qryMCEKCIROCARI_AD: TStringField
      FieldName = 'CARI_AD'
      ReadOnly = True
      Size = 50
    end
    object qryMCEKCIROPLASIYER_KOD: TStringField
      FieldName = 'PLASIYER_KOD'
      Size = 15
    end
    object qryMCEKCIROPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object qryMCEKCIROCARIHAR_ACK: TStringField
      FieldName = 'CARIHAR_ACK'
      Size = 50
    end
    object qryMCEKCIROYEVMIYE_ACK: TStringField
      FieldName = 'YEVMIYE_ACK'
      Size = 50
    end
    object qryMCEKCIROPROTESTO_MASRAF: TBCDField
      FieldName = 'PROTESTO_MASRAF'
      Size = 8
    end
    object qryMCEKCIROGENEL_GIDER: TBCDField
      FieldName = 'GENEL_GIDER'
      Size = 8
    end
    object qryMCEKCIROGENEL_GIDER_MUH_KOD: TStringField
      FieldName = 'GENEL_GIDER_MUH_KOD'
      Size = 30
    end
    object qryMCEKCIROBORCALHESAP: TStringField
      FieldName = 'BORCALHESAP'
      Size = 15
    end
    object qryMCEKCIROMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object qryMCEKCIROKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object qryMCEKCIROKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object qryMCEKCIROKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object qryMCEKCIROKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object qryMCEKCIROKASA_KOD: TStringField
      FieldName = 'KASA_KOD'
      Size = 15
    end
    object qryMCEKCIROGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 100
      Calculated = True
    end
  end
  object qryMCEK: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    SQL.Strings = (
      'SELECT * FROM CEK WHERE CEK_ID=19487 AND CEK_SID=1')
    FieldOptions = []
    Left = 128
    Top = 256
    object IntegerField1: TIntegerField
      FieldName = 'CEK_ID'
    end
    object SmallintField1: TSmallintField
      FieldName = 'CEK_SID'
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'CARI_KOD'
      Required = True
      Size = 15
    end
    object DateField1: TDateField
      FieldName = 'ISLEMTAR'
    end
    object DateField2: TDateField
      FieldName = 'FIILI_TAR'
    end
    object DateField3: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object DateField4: TDateField
      FieldName = 'TANZIMTAR'
    end
    object DateField5: TDateField
      FieldName = 'VADETAR'
    end
    object StringField2: TStringField
      FieldName = 'BANKA_KOD'
      Size = 15
    end
    object StringField3: TStringField
      FieldName = 'CEK_SAHIBI'
      Size = 50
    end
    object StringField4: TStringField
      FieldName = 'BANKA_AD'
      Size = 50
    end
    object StringField6: TStringField
      FieldName = 'HESAP_NO'
      Size = 50
    end
    object StringField7: TStringField
      FieldName = 'CEK_NUM'
      Size = 30
    end
    object BCDField1: TBCDField
      FieldName = 'TUTAR'
      Size = 8
    end
    object BCDField2: TBCDField
      FieldName = 'DOVKUR'
      Size = 8
    end
    object StringField8: TStringField
      FieldName = 'DOVKOD'
      Size = 5
    end
    object SmallintField2: TSmallintField
      FieldName = 'DURUM'
      Required = True
    end
    object SmallintField3: TSmallintField
      FieldName = 'YER_KOD'
    end
    object SmallintField4: TSmallintField
      FieldName = 'TIP'
    end
    object StringField9: TStringField
      FieldName = 'ACIKLAMA'
      Size = 100
    end
    object SmallintField5: TSmallintField
      FieldName = 'ASIL'
      Required = True
    end
    object DateField6: TDateField
      FieldName = 'ODEME_TAR'
    end
    object BCDField3: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object StringField10: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object StringField11: TStringField
      FieldName = 'PLASIYER_KOD'
      Size = 15
    end
    object StringField12: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object StringField13: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object StringField14: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object StringField15: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object StringField16: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object StringField17: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 100
      Calculated = True
    end
    object DateField7: TDateField
      FieldKind = fkCalculated
      FieldName = 'CIKTAR'
      Calculated = True
    end
  end
  object qryBCEKIADE: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryBCEKIADECalcFields
    SQL.Strings = (
      'SELECT CEKSENHAR_ID'
      '      ,CEKSENHAR_SID'
      '      ,ISLEM_TAR'
      '      ,BELGE_ID'
      '      ,CARI_KOD'
      '      ,PROJE_KOD'
      '      ,TUTAR_VPB'
      '      ,CARIHAR_ACK'
      
        '      ,(SELECT CEK_NUM FROM CEK WHERE CEK.CEK_ID=CEKSENHAR.BELGE' +
        '_ID) AS CEK_NO'
      'FROM CEKSENHAR'
      '')
    FieldOptions = []
    Left = 208
    Top = 256
    object StringField18: TStringField
      DisplayWidth = 100
      FieldKind = fkCalculated
      FieldName = 'GTYAZI'
      Size = 150
      Calculated = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'CEKSENHAR_ID'
    end
    object IntegerField3: TIntegerField
      FieldName = 'CEKSENHAR_SID'
    end
    object DateField8: TDateField
      FieldName = 'ISLEM_TAR'
    end
    object IntegerField4: TIntegerField
      FieldName = 'BELGE_ID'
    end
    object StringField19: TStringField
      FieldName = 'CARI_KOD'
      Size = 15
    end
    object StringField20: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object BCDField4: TBCDField
      FieldName = 'TUTAR_VPB'
    end
    object StringField21: TStringField
      FieldName = 'CARIHAR_ACK'
      Size = 50
    end
    object StringField22: TStringField
      FieldName = 'CEK_NO'
      ReadOnly = True
      Size = 30
    end
    object qryBCEKIADEGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 100
      Calculated = True
    end
  end
  object qrySiparis: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
    OnCalcFields = qrySiparisCalcFields
    SQL.Strings = (
      
        'SELECT * FROM SIPARIS WHERE FAT_IRS_SEP = 1 AND FAT_IRS_ID=1 AND' +
        ' FAT_IRS_SID=1')
    FieldOptions = []
    Left = 208
    Top = 312
    object qrySiparisFAT_IRS_SEP: TSmallintField
      FieldName = 'FAT_IRS_SEP'
      Required = True
    end
    object qrySiparisFAT_IRS_ID: TIntegerField
      FieldName = 'FAT_IRS_ID'
    end
    object qrySiparisFAT_IRS_SID: TSmallintField
      FieldName = 'FAT_IRS_SID'
      Required = True
    end
    object qrySiparisCARI_KOD: TStringField
      FieldName = 'CARI_KOD'
      Required = True
      Size = 15
    end
    object qrySiparisFAT_IRS_SERI: TStringField
      FieldName = 'FAT_IRS_SERI'
      Required = True
      Size = 15
    end
    object qrySiparisBELGE_NO: TStringField
      FieldName = 'BELGE_NO'
      Required = True
      Size = 50
    end
    object qrySiparisDOV_BAZ_TAR: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object qrySiparisTARIH: TDateField
      FieldName = 'TARIH'
    end
    object qrySiparisREF_BELGE_TUR: TSmallintField
      FieldName = 'REF_BELGE_TUR'
    end
    object qrySiparisREF_BELGE_ID: TIntegerField
      FieldName = 'REF_BELGE_ID'
    end
    object qrySiparisREF_BELGE_SID: TSmallintField
      FieldName = 'REF_BELGE_SID'
      Required = True
    end
    object qrySiparisACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Size = 100
    end
    object qrySiparisBRUT_TOP: TBCDField
      FieldName = 'BRUT_TOP'
      Size = 8
    end
    object qrySiparisNET_TOP: TBCDField
      FieldName = 'NET_TOP'
      Size = 8
    end
    object qrySiparisGENEL_TOP: TBCDField
      FieldName = 'GENEL_TOP'
      Size = 8
    end
    object qrySiparisKDV_TOP: TBCDField
      FieldName = 'KDV_TOP'
      Size = 8
    end
    object qrySiparisTIP: TSmallintField
      FieldName = 'TIP'
    end
    object qrySiparisFAT_IRS_TIP: TSmallintField
      FieldName = 'FAT_IRS_TIP'
    end
    object qrySiparisYAZILDI: TSmallintField
      FieldName = 'YAZILDI'
    end
    object qrySiparisIPTAL: TSmallintField
      FieldName = 'IPTAL'
      Required = True
    end
    object qrySiparisDEPO_KOD: TStringField
      FieldName = 'DEPO_KOD'
      Size = 15
    end
    object qrySiparisSAAT: TTimeField
      FieldName = 'SAAT'
    end
    object qrySiparisKALEM_ISKONTO_TOPLAM_VPB: TBCDField
      FieldName = 'KALEM_ISKONTO_TOPLAM_VPB'
      Size = 8
    end
    object qrySiparisISKONTO_TIP: TSmallintField
      FieldName = 'ISKONTO_TIP'
    end
    object qrySiparisISKONTO_ORAN: TSmallintField
      FieldName = 'ISKONTO_ORAN'
    end
    object qrySiparisISKONTO_TUTAR_VPB: TBCDField
      FieldName = 'ISKONTO_TUTAR_VPB'
      Size = 8
    end
    object qrySiparisISKONTO_TOPLAM_VPB: TBCDField
      FieldName = 'ISKONTO_TOPLAM_VPB'
      Size = 8
    end
    object qrySiparisKDV1: TBCDField
      FieldName = 'KDV1'
      Size = 8
    end
    object qrySiparisKDV2: TBCDField
      FieldName = 'KDV2'
      Size = 8
    end
    object qrySiparisKDV3: TBCDField
      FieldName = 'KDV3'
      Size = 8
    end
    object qrySiparisKDV4: TBCDField
      FieldName = 'KDV4'
      Size = 8
    end
    object qrySiparisKDV5: TBCDField
      FieldName = 'KDV5'
      Size = 8
    end
    object qrySiparisOTV: TBCDField
      FieldName = 'OTV'
      Size = 8
    end
    object qrySiparisVADE_GUN: TIntegerField
      FieldName = 'VADE_GUN'
    end
    object qrySiparisVADE_TARIH: TDateField
      FieldName = 'VADE_TARIH'
    end
    object qrySiparisKDV1_ORAN: TSmallintField
      FieldName = 'KDV1_ORAN'
    end
    object qrySiparisKDV2_ORAN: TSmallintField
      FieldName = 'KDV2_ORAN'
    end
    object qrySiparisKDV3_ORAN: TSmallintField
      FieldName = 'KDV3_ORAN'
    end
    object qrySiparisKDV4_ORAN: TSmallintField
      FieldName = 'KDV4_ORAN'
    end
    object qrySiparisKDV5_ORAN: TSmallintField
      FieldName = 'KDV5_ORAN'
    end
    object qrySiparisODEMETAR: TDateField
      FieldName = 'ODEMETAR'
    end
    object qrySiparisMUHTELIF: TSmallintField
      FieldName = 'MUHTELIF'
      Required = True
    end
    object qrySiparisKASA_KOD: TStringField
      FieldName = 'KASA_KOD'
      Size = 15
    end
    object qrySiparisPLASIYER_KOD: TStringField
      FieldName = 'PLASIYER_KOD'
      Size = 15
    end
    object qrySiparisPROJE_KOD: TStringField
      FieldName = 'PROJE_KOD'
      Size = 15
    end
    object qrySiparisMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object qrySiparisKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object qrySiparisKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object qrySiparisKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object qrySiparisKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object qrySiparisYEV_ACIKLAMA: TStringField
      FieldName = 'YEV_ACIKLAMA'
      Size = 50
    end
    object qrySiparisGTYAZILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYAZILE'
      Size = 255
      Calculated = True
    end
    object qrySiparisGTYTLILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTYTLILE'
      Size = 255
      Calculated = True
    end
    object qrySiparisGTDOVIZ: TStringField
      FieldKind = fkCalculated
      FieldName = 'GTDOVIZ'
      Size = 255
      Calculated = True
    end
  end
  object QrySiparisD: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    KeyLinks.Strings = (
      'SIPARIS_D.URUNHAR_ID'
      'SIPARIS_D.URUNHAR_SID')
    RecordCountAccurate = True
    SQL.Strings = (
      
        'SELECT * FROM SIPARIS_D WHERE FATURA_ID=26 AND FATURA_SID =1 ORD' +
        'ER BY URUNHAR_ID')
    FieldOptions = []
    Left = 208
    Top = 368
    object QrySiparisDURUNHAR_ID: TIntegerField
      FieldName = 'URUNHAR_ID'
    end
    object QrySiparisDURUNHAR_SID: TSmallintField
      FieldName = 'URUNHAR_SID'
      Required = True
    end
    object QrySiparisDURUN_KOD: TStringField
      FieldName = 'URUN_KOD'
      Required = True
      Size = 35
    end
    object QrySiparisDTIP: TStringField
      FieldName = 'TIP'
      Required = True
      Size = 1
    end
    object QrySiparisDBELGE_TUR: TIntegerField
      FieldName = 'BELGE_TUR'
    end
    object QrySiparisDBELGE_ID: TIntegerField
      FieldName = 'BELGE_ID'
    end
    object QrySiparisDBELGE_SID: TSmallintField
      FieldName = 'BELGE_SID'
      Required = True
    end
    object QrySiparisDBELGE_SIRA_NO: TIntegerField
      FieldName = 'BELGE_SIRA_NO'
    end
    object QrySiparisDTARIH: TDateField
      FieldName = 'TARIH'
      Required = True
    end
    object QrySiparisDFIILI_TAR: TDateField
      FieldName = 'FIILI_TAR'
    end
    object QrySiparisDDOV_BAZ_TAR: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object QrySiparisDOLCUBIRIM: TStringField
      FieldName = 'OLCUBIRIM'
      Required = True
      Size = 15
    end
    object QrySiparisDMIKTAR: TBCDField
      FieldName = 'MIKTAR'
      Size = 8
    end
    object QrySiparisDDOVKOD: TStringField
      FieldName = 'DOVKOD'
      Size = 5
    end
    object QrySiparisDDOVKUR: TBCDField
      FieldName = 'DOVKUR'
      Size = 8
    end
    object QrySiparisDTUTAR: TBCDField
      FieldName = 'TUTAR'
      Size = 8
    end
    object QrySiparisDTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object QrySiparisDURUN_DOVKOD: TStringField
      FieldName = 'URUN_DOVKOD'
      Size = 5
    end
    object QrySiparisDTUTAR_URUN_DOVKOD: TBCDField
      FieldName = 'TUTAR_URUN_DOVKOD'
      Size = 8
    end
    object QrySiparisDBIRIM_FIY: TBCDField
      FieldName = 'BIRIM_FIY'
      Size = 8
    end
    object QrySiparisDBIRIM_FIY_VPB: TBCDField
      FieldName = 'BIRIM_FIY_VPB'
      Size = 8
    end
    object QrySiparisDBIRIM_FIY_URN_DOVKOD: TBCDField
      FieldName = 'BIRIM_FIY_URN_DOVKOD'
      Size = 8
    end
    object QrySiparisDISKONTO_TUTAR: TBCDField
      FieldName = 'ISKONTO_TUTAR'
      Size = 8
    end
    object QrySiparisDISKONTO_TUTAR_VPB: TBCDField
      FieldName = 'ISKONTO_TUTAR_VPB'
      Size = 8
    end
    object QrySiparisDOLCUBIRIM_URN_OB: TStringField
      FieldName = 'OLCUBIRIM_URN_OB'
      Required = True
      Size = 15
    end
    object QrySiparisDMIKTAR_URN_OB: TBCDField
      FieldName = 'MIKTAR_URN_OB'
      Size = 8
    end
    object QrySiparisDDEPO_KOD: TStringField
      FieldName = 'DEPO_KOD'
      Size = 15
    end
    object QrySiparisDMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object QrySiparisDKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object QrySiparisDKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object QrySiparisDKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object QrySiparisDKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object QrySiparisDACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Required = True
      Size = 50
    end
    object QrySiparisDISKONTO_TIP: TSmallintField
      FieldName = 'ISKONTO_TIP'
    end
    object QrySiparisDISKONTO_ORAN: TSmallintField
      FieldName = 'ISKONTO_ORAN'
    end
    object QrySiparisDFATURA_ID: TIntegerField
      FieldName = 'FATURA_ID'
    end
    object QrySiparisDFATURA_SID: TSmallintField
      FieldName = 'FATURA_SID'
      Required = True
    end
    object QrySiparisDIRSALIYE_ID: TIntegerField
      FieldName = 'IRSALIYE_ID'
    end
    object QrySiparisDIRSALIYE_SID: TSmallintField
      FieldName = 'IRSALIYE_SID'
      Required = True
    end
    object QrySiparisDKDV: TSmallintField
      FieldName = 'KDV'
    end
    object QrySiparisDKDV_TUTAR: TBCDField
      FieldName = 'KDV_TUTAR'
      Size = 8
    end
  end
  object qryRecete: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
    FieldOptions = []
    Left = 304
    Top = 312
  end
  object qryFaturaD_Tran: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    ReadOnly = True
    RecordCountAccurate = True
    OnCalcFields = qryFaturaD_TranCalcFields
    SQL.Strings = (
      'SELECT * FROM FATURA_D')
    FieldOptions = []
    Left = 40
    Top = 312
    object qryFaturaD_TranSon_Kayit: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Son_Kayit'
      Calculated = True
    end
    object qryFaturaD_TranURUNHAR_ID: TIntegerField
      FieldName = 'URUNHAR_ID'
    end
    object qryFaturaD_TranURUNHAR_SID: TSmallintField
      FieldName = 'URUNHAR_SID'
      Required = True
    end
    object qryFaturaD_TranURUN_KOD: TStringField
      FieldName = 'URUN_KOD'
      Size = 35
    end
    object qryFaturaD_TranTIP: TStringField
      FieldName = 'TIP'
      Required = True
      Size = 1
    end
    object qryFaturaD_TranBELGE_TUR: TIntegerField
      FieldName = 'BELGE_TUR'
    end
    object qryFaturaD_TranBELGE_ID: TIntegerField
      FieldName = 'BELGE_ID'
    end
    object qryFaturaD_TranBELGE_SID: TSmallintField
      FieldName = 'BELGE_SID'
      Required = True
    end
    object qryFaturaD_TranBELGE_SIRA_NO: TIntegerField
      FieldName = 'BELGE_SIRA_NO'
    end
    object qryFaturaD_TranTARIH: TDateField
      FieldName = 'TARIH'
    end
    object qryFaturaD_TranFIILI_TAR: TDateField
      FieldName = 'FIILI_TAR'
    end
    object qryFaturaD_TranDOV_BAZ_TAR: TDateField
      FieldName = 'DOV_BAZ_TAR'
    end
    object qryFaturaD_TranOLCUBIRIM: TStringField
      FieldName = 'OLCUBIRIM'
      Required = True
      Size = 15
    end
    object qryFaturaD_TranMIKTAR: TBCDField
      FieldName = 'MIKTAR'
      Size = 8
    end
    object qryFaturaD_TranDOVKOD: TStringField
      FieldName = 'DOVKOD'
      Size = 5
    end
    object qryFaturaD_TranDOVKUR: TBCDField
      FieldName = 'DOVKUR'
      Size = 8
    end
    object qryFaturaD_TranTUTAR: TBCDField
      FieldName = 'TUTAR'
      Size = 8
    end
    object qryFaturaD_TranTUTAR_VPB: TBCDField
      FieldName = 'TUTAR_VPB'
      Size = 8
    end
    object qryFaturaD_TranURUN_DOVKOD: TStringField
      FieldName = 'URUN_DOVKOD'
      Size = 5
    end
    object qryFaturaD_TranTUTAR_URUN_DOVKOD: TBCDField
      FieldName = 'TUTAR_URUN_DOVKOD'
      Size = 8
    end
    object qryFaturaD_TranBIRIM_FIY: TBCDField
      FieldName = 'BIRIM_FIY'
      Size = 8
    end
    object qryFaturaD_TranBIRIM_FIY_VPB: TBCDField
      FieldName = 'BIRIM_FIY_VPB'
      Size = 8
    end
    object qryFaturaD_TranBIRIM_FIY_URN_DOVKOD: TBCDField
      FieldName = 'BIRIM_FIY_URN_DOVKOD'
      Size = 8
    end
    object qryFaturaD_TranISKONTO_TUTAR: TBCDField
      FieldName = 'ISKONTO_TUTAR'
      Size = 8
    end
    object qryFaturaD_TranISKONTO_TUTAR_VPB: TBCDField
      FieldName = 'ISKONTO_TUTAR_VPB'
      Size = 8
    end
    object qryFaturaD_TranOLCUBIRIM_URN_OB: TStringField
      FieldName = 'OLCUBIRIM_URN_OB'
      Required = True
      Size = 15
    end
    object qryFaturaD_TranMIKTAR_URN_OB: TBCDField
      FieldName = 'MIKTAR_URN_OB'
      Size = 8
    end
    object qryFaturaD_TranDEPO_KOD: TStringField
      FieldName = 'DEPO_KOD'
      Size = 15
    end
    object qryFaturaD_TranMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object qryFaturaD_TranKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object qryFaturaD_TranKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object qryFaturaD_TranKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object qryFaturaD_TranKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object qryFaturaD_TranISKONTO_TIP: TSmallintField
      FieldName = 'ISKONTO_TIP'
    end
    object qryFaturaD_TranISKONTO_ORAN: TSmallintField
      FieldName = 'ISKONTO_ORAN'
    end
    object qryFaturaD_TranFATURA_ID: TIntegerField
      FieldName = 'FATURA_ID'
    end
    object qryFaturaD_TranFATURA_SID: TSmallintField
      FieldName = 'FATURA_SID'
      Required = True
    end
    object qryFaturaD_TranIRSALIYE_ID: TIntegerField
      FieldName = 'IRSALIYE_ID'
    end
    object qryFaturaD_TranIRSALIYE_SID: TSmallintField
      FieldName = 'IRSALIYE_SID'
      Required = True
    end
    object qryFaturaD_TranKDV: TSmallintField
      FieldName = 'KDV'
    end
    object qryFaturaD_TranKDV_TUTAR: TBCDField
      FieldName = 'KDV_TUTAR'
      Size = 8
    end
    object qryFaturaD_TranSECIM: TStringField
      FieldName = 'SECIM'
      Size = 1
    end
    object qryFaturaD_TranBIRIM_FIY_URN_OB: TBCDField
      FieldName = 'BIRIM_FIY_URN_OB'
      Size = 8
    end
    object qryFaturaD_TranCIKIS_MIKTAR: TBCDField
      FieldName = 'CIKIS_MIKTAR'
      Size = 8
    end
    object qryFaturaD_TranACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Required = True
      Size = 50
    end
    object qryFaturaD_TranSEFER_ID: TIntegerField
      FieldName = 'SEFER_ID'
    end
    object qryFaturaD_TranMAZOT_FISI_ID: TIntegerField
      FieldName = 'MAZOT_FISI_ID'
    end
    object qryFaturaD_TranSEFER_BEKLEME: TSmallintField
      FieldName = 'SEFER_BEKLEME'
      Required = True
    end
    object qryFaturaD_TranCINSI: TStringField
      FieldName = 'CINSI'
      Size = 30
    end
  end
  object qryKOMISYON: TIBOQuery
    Params = <>
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
    OnCalcFields = qryKOMISYONCalcFields
    SQL.Strings = (
      'SELECT *'
      'FROM KOMISYON')
    FieldOptions = []
    Left = 40
    Top = 376
    object qryKOMISYONID: TIntegerField
      FieldName = 'ID'
    end
    object qryKOMISYONSID: TSmallintField
      FieldName = 'SID'
      Required = True
    end
    object qryKOMISYONCARI_KOD: TStringField
      FieldName = 'CARI_KOD'
      Size = 15
    end
    object qryKOMISYONSEVK_ADRES_KOD: TStringField
      FieldName = 'SEVK_ADRES_KOD'
      Size = 15
    end
    object qryKOMISYONGONDEREN_FIRMA: TStringField
      FieldName = 'GONDEREN_FIRMA'
      Size = 50
    end
    object qryKOMISYONGON_FIR_ADRES1: TStringField
      FieldName = 'GON_FIR_ADRES1'
      Size = 50
    end
    object qryKOMISYONGON_FIR_ADRES2: TStringField
      FieldName = 'GON_FIR_ADRES2'
      Size = 50
    end
    object qryKOMISYONGON_FIR_TEL: TStringField
      FieldName = 'GON_FIR_TEL'
    end
    object qryKOMISYONGON_FIR_TEL1: TStringField
      FieldName = 'GON_FIR_TEL1'
    end
    object qryKOMISYONGIDECEGI_YER: TStringField
      FieldName = 'GIDECEGI_YER'
      Size = 50
    end
    object qryKOMISYONYUK_CINSI: TStringField
      FieldName = 'YUK_CINSI'
      Size = 30
    end
    object qryKOMISYONYUK_KILO: TBCDField
      FieldName = 'YUK_KILO'
      Size = 8
    end
    object qryKOMISYONYUK_OLCU_BIR: TStringField
      FieldName = 'YUK_OLCU_BIR'
      Size = 15
    end
    object qryKOMISYONYUK_OLCU_TIP: TStringField
      FieldName = 'YUK_OLCU_TIP'
      Size = 15
    end
    object qryKOMISYONTOPLAM_UCRET: TBCDField
      FieldName = 'TOPLAM_UCRET'
      Size = 8
    end
    object qryKOMISYONKDV_DAHIL: TSmallintField
      FieldName = 'KDV_DAHIL'
      Required = True
    end
    object qryKOMISYONKOMISYON_UCRET: TBCDField
      FieldName = 'KOMISYON_UCRET'
      Size = 8
    end
    object qryKOMISYONSOFOR_ADI_SOY: TStringField
      FieldName = 'SOFOR_ADI_SOY'
      Size = 50
    end
    object qryKOMISYONSOFOR_ADRESI: TStringField
      FieldName = 'SOFOR_ADRESI'
      Size = 50
    end
    object qryKOMISYONSOFOR_ADRESI1: TStringField
      FieldName = 'SOFOR_ADRESI1'
      Size = 50
    end
    object qryKOMISYONSOFOR_TEL: TStringField
      FieldName = 'SOFOR_TEL'
    end
    object qryKOMISYONSOFOR_TEL1: TStringField
      FieldName = 'SOFOR_TEL1'
    end
    object qryKOMISYONSOFOR_EHLIYET_NO: TStringField
      FieldName = 'SOFOR_EHLIYET_NO'
      Size = 30
    end
    object qryKOMISYONSOFOR_VERGI_DA: TStringField
      FieldName = 'SOFOR_VERGI_DA'
      Size = 30
    end
    object qryKOMISYONSOFOR_VERGI_DA_NO: TStringField
      FieldName = 'SOFOR_VERGI_DA_NO'
      Size = 30
    end
    object qryKOMISYONARAC_PLAKA: TStringField
      FieldName = 'ARAC_PLAKA'
      Size = 30
    end
    object qryKOMISYONARAC_MARKA: TStringField
      FieldName = 'ARAC_MARKA'
      Size = 30
    end
    object qryKOMISYONARAC_MODEL: TStringField
      FieldName = 'ARAC_MODEL'
      Size = 30
    end
    object qryKOMISYONARAC_SAHIBI: TStringField
      FieldName = 'ARAC_SAHIBI'
      Size = 50
    end
    object qryKOMISYONARAC_SAHIBI_ADRESI: TStringField
      FieldName = 'ARAC_SAHIBI_ADRESI'
      Size = 50
    end
    object qryKOMISYONARAC_SAHIBI_ADRESI1: TStringField
      FieldName = 'ARAC_SAHIBI_ADRESI1'
      Size = 50
    end
    object qryKOMISYONARAC_SAHIBI_TEL: TStringField
      FieldName = 'ARAC_SAHIBI_TEL'
    end
    object qryKOMISYONARAC_SAHIBI_TEL1: TStringField
      FieldName = 'ARAC_SAHIBI_TEL1'
    end
    object qryKOMISYONARAC_RUHSAT_NO: TStringField
      FieldName = 'ARAC_RUHSAT_NO'
      Size = 30
    end
    object qryKOMISYONACIKLAMA: TMemoField
      FieldName = 'ACIKLAMA'
      BlobType = ftMemo
    end
    object qryKOMISYONTARIH: TDateField
      FieldName = 'TARIH'
    end
    object qryKOMISYONKULLANICI: TStringField
      FieldName = 'KULLANICI'
      Size = 30
    end
    object qryKOMISYONFIS_NO: TStringField
      FieldName = 'FIS_NO'
      Size = 30
    end
    object qryKOMISYONMASRAF_MERK: TStringField
      FieldName = 'MASRAF_MERK'
      Size = 15
    end
    object qryKOMISYONKOD1: TStringField
      FieldName = 'KOD1'
      Size = 15
    end
    object qryKOMISYONKOD2: TStringField
      FieldName = 'KOD2'
      Size = 15
    end
    object qryKOMISYONKOD3: TStringField
      FieldName = 'KOD3'
      Size = 15
    end
    object qryKOMISYONKOD4: TStringField
      FieldName = 'KOD4'
      Size = 15
    end
    object qryKOMISYONKASA_KOD: TStringField
      FieldName = 'KASA_KOD'
      Size = 15
    end
    object qryKOMISYONARAC_KOD: TStringField
      FieldName = 'ARAC_KOD'
      Size = 15
    end
    object qryKOMISYONSOFOR_KOD: TStringField
      FieldName = 'SOFOR_KOD'
      Size = 15
    end
    object qryKOMISYONRESIM: TStringField
      FieldName = 'RESIM'
      Size = 255
    end
    object qryKOMISYONDORSE_PLAKA: TStringField
      FieldName = 'DORSE_PLAKA'
      Size = 30
    end
    object qryKOMISYONCL_YAZ_UCRET: TStringField
      FieldKind = fkCalculated
      FieldName = 'CL_YAZ_UCRET'
      Size = 200
      Calculated = True
    end
    object qryKOMISYONCL_YAZ_KOM: TStringField
      FieldKind = fkCalculated
      FieldName = 'CL_YAZ_KOM'
      Size = 200
      Calculated = True
    end
  end
end
