{$INCLUDE directive.inc}

unit unYazici;

interface

uses
  SysUtils, Classes, DB, IBODataset, pr_Common, pr_TxClasses,pr_TxDesigner,pr_TxConsts, pr_Utils,GenTypes,IB_Components,
  Forms,Windows,Printers,Messages,pr_Classes,DateUtils,pr_Parser, Dialogs,Winspool;

type
  TYazici = class(TDataModule)
    qryFatura: TIBOQuery;
    qryFaturaD: TIBOQuery;
    qryCari: TIBOQuery;
    qryDekont: TIBOQuery;
    qryDekont_D: TIBOQuery;
    qryDekont_DALACAK: TCurrencyField;
    qryDekont_DBORC: TCurrencyField;
    qryDekont_DBA: TStringField;
    qryDekont_DMC: TStringField;
    qryDekont_DKARSI_KOD: TStringField;
    qryDekont_DTUTAR_VPB: TBCDField;
    qryDekont_DKARSI_AD: TStringField;
    qrySirket: TIBOQuery;
    qryKASAHAR_D: TIBOQuery;
    qryKASAHARMAS: TIBOQuery;
    qryKASAHARMASKASAHAR_ID: TIntegerField;
    qryKASAHARMASKASAHAR_SID: TSmallintField;
    qryKASAHARMASKASA_KOD: TStringField;
    qryKASAHARMASTARIH: TDateField;
    qryKASAHARMASDOV_BAZ_TAR: TDateField;
    qryKASAHARMASBELGE_TUR: TIntegerField;
    qryKASAHARMASBELGE_ID: TIntegerField;
    qryKASAHARMASBELGE_SID: TSmallintField;
    qryKASAHARMASTIP: TStringField;
    qryKASAHARMASACIKLAMA: TStringField;
    qryKASAHARMASKASADEGER: TBCDField;
    qryKASAHARMASISLEM_TIP: TSmallintField;
    qryKASAHARMASPROJE_KOD: TStringField;
    qryKASAHARMASPLASIYER_KOD: TStringField;
    qryKASAHARMASMC: TStringField;
    qryKASAHARMASKARSIKOD: TStringField;
    qryKASAHARMASSIRA_NO: TIntegerField;
    qryKASAHARMASDOVKOD: TStringField;
    qryKASAHARMASDOVKUR: TBCDField;
    qryKASAHARMASTUTAR: TBCDField;
    qryKASAHARMASTUTAR_VPB: TBCDField;
    qryKASAHARMASOLCUBIRIM: TStringField;
    qryKASAHARMASMIKTAR: TBCDField;
    qryKASAHARMASMASRAF_MERK: TStringField;
    qryKASAHARMASKOD1: TStringField;
    qryKASAHARMASKOD2: TStringField;
    qryKASAHARMASKOD3: TStringField;
    qryKASAHARMASKOD4: TStringField;
    qryKASAHARMASYEVMIYE_ACK: TStringField;
    qryKASAHARMASBASLIK: TStringField;
    qryKASAHARMASKARSI_AD: TStringField;
    qryKASAHAR: TIBOQuery;
    qryKASAHARKASAHAR_ID: TIntegerField;
    qryKASAHARKASAHAR_SID: TSmallintField;
    qryKASAHARKASA_KOD: TStringField;
    qryKASAHARTARIH: TDateField;
    qryKASAHARDOV_BAZ_TAR: TDateField;
    qryKASAHARBELGE_TUR: TIntegerField;
    qryKASAHARBELGE_ID: TIntegerField;
    qryKASAHARBELGE_SID: TSmallintField;
    qryKASAHARTIP: TStringField;
    qryKASAHARACIKLAMA: TStringField;
    qryKASAHARKASADEGER: TBCDField;
    qryKASAHARISLEM_TIP: TSmallintField;
    qryKASAHARPROJE_KOD: TStringField;
    qryKASAHARPLASIYER_KOD: TStringField;
    qryKASAHARMC: TStringField;
    qryKASAHARKARSIKOD: TStringField;
    qryKASAHARSIRA_NO: TIntegerField;
    qryKASAHARDOVKOD: TStringField;
    qryKASAHARDOVKUR: TBCDField;
    qryKASAHARTUTAR: TBCDField;
    qryKASAHARTUTAR_VPB: TBCDField;
    qryKASAHAROLCUBIRIM: TStringField;
    qryKASAHARMIKTAR: TBCDField;
    qryKASAHARMASRAF_MERK: TStringField;
    qryKASAHARKOD1: TStringField;
    qryKASAHARKOD2: TStringField;
    qryKASAHARKOD3: TStringField;
    qryKASAHARKOD4: TStringField;
    qryKASAHARYEVMIYE_ACK: TStringField;
    qryKASAHARBASLIK: TStringField;
    qryMUHFIS: TIBOQuery;
    qryMUHFISMAS: TIBOQuery;
    qryDekont_DACIKLAMA1: TStringField;
    qryToplam: TIBOQuery;
    qryToplamTOPLAM: TBCDField;
    qryToplamGTYAZI: TStringField;
    qryKASAHARMASGTYAZI: TStringField;
    qryDekont_DPROJE_KOD: TStringField;
    qryCek: TIBOQuery;
    qryCekCEK_ID: TIntegerField;
    qryCekCEK_SID: TSmallintField;
    qryCekCARI_KOD: TStringField;
    qryCekISLEMTAR: TDateField;
    qryCekFIILI_TAR: TDateField;
    qryCekDOV_BAZ_TAR: TDateField;
    qryCekTANZIMTAR: TDateField;
    qryCekVADETAR: TDateField;
    qryCekBANKA_KOD: TStringField;
    qryCekCEK_SAHIBI: TStringField;
    qryCekBANKA_AD: TStringField;
    qryCekHESAP_NO: TStringField;
    qryCekCEK_NUM: TStringField;
    qryCekTUTAR: TBCDField;
    qryCekDOVKUR: TBCDField;
    qryCekDOVKOD: TStringField;
    qryCekDURUM: TSmallintField;
    qryCekYER_KOD: TSmallintField;
    qryCekTIP: TSmallintField;
    qryCekACIKLAMA: TStringField;
    qryCekASIL: TSmallintField;
    qryCekODEME_TAR: TDateField;
    qryCekTUTAR_VPB: TBCDField;
    qryCekPROJE_KOD: TStringField;
    qryCekPLASIYER_KOD: TStringField;
    qryCekMASRAF_MERK: TStringField;
    qryCekKOD1: TStringField;
    qryCekKOD2: TStringField;
    qryCekKOD3: TStringField;
    qryCekKOD4: TStringField;
    qryCekGTYAZI: TStringField;
    qryCekCIKTAR: TDateField;
    qryKASACEKSENET: TIBOQuery;
    qryKASACEKSENETCEKSENHAR_ID: TIntegerField;
    qryKASACEKSENETCEKSENHAR_SID: TIntegerField;
    qryKASACEKSENETISLEM_TAR: TDateField;
    qryKASACEKSENETCEKSEN: TSmallintField;
    qryKASACEKSENETBELGE_ID: TIntegerField;
    qryKASACEKSENETKASA_KOD: TStringField;
    qryKASACEKSENETTUTAR_VPB: TBCDField;
    qryKASACEKSENETCARIHAR_ACK: TStringField;
    qryKASACEKSENETBASLIK: TStringField;
    qryKASACEKSENETGTYAZI: TStringField;
    qryKASACEKSENETPROJE_KOD: TStringField;
    qryMUHFISBA: TStringField;
    qryMUHFISHESAP_KOD: TStringField;
    qryMUHFISTUTAR_VPB: TBCDField;
    qryMUHFISHESAP_ADI: TStringField;
    qryMUHFISTUTAR_BORC: TCurrencyField;
    qryMUHFISTUTAR_ALACAK: TCurrencyField;
    qryMUHFISACIKLAMA: TStringField;
    qryTRANSFER: TIBOQuery;
    qryTRANSFERKASAHAR_ID: TIntegerField;
    qryTRANSFERKASAHAR_SID: TSmallintField;
    qryTRANSFERKASA_KOD: TStringField;
    qryTRANSFERKASA_AD: TStringField;
    qryTRANSFERKARSIKOD: TStringField;
    qryTRANSFERKARSIAD: TStringField;
    qryTRANSFERTARIH: TDateField;
    qryTRANSFERDOVKUR: TBCDField;
    qryTRANSFERTUTAR: TBCDField;
    qryTRANSFERTUTAR_VPB: TBCDField;
    qryTRANSFERACIKLAMA: TStringField;
    qryTRANSFERYEVMIYE_ACK: TStringField;
    qryTRANSFERGTYAZI: TStringField;
    qryBCEKODEME: TIBOQuery;
    StringField5: TStringField;
    qryBCEKODEMECEKSENHAR_ID: TIntegerField;
    qryBCEKODEMECEKSENHAR_SID: TIntegerField;
    qryBCEKODEMEISLEM_TAR: TDateField;
    qryBCEKODEMEBELGE_ID: TIntegerField;
    qryBCEKODEMECARI_KOD: TStringField;
    qryBCEKODEMEPROJE_KOD: TStringField;
    qryBCEKODEMETUTAR_VPB: TBCDField;
    qryBCEKODEMECARIHAR_ACK: TStringField;
    qryMCEKCIRO: TIBOQuery;
    qryMCEKCIROGTYAZI: TStringField;
    qryMCEKCIROCIKTAR: TDateField;
    qryMCEK: TIBOQuery;
    IntegerField1: TIntegerField;
    SmallintField1: TSmallintField;
    StringField1: TStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    DateField3: TDateField;
    DateField4: TDateField;
    DateField5: TDateField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    BCDField1: TBCDField;
    BCDField2: TBCDField;
    StringField8: TStringField;
    SmallintField2: TSmallintField;
    SmallintField3: TSmallintField;
    SmallintField4: TSmallintField;
    StringField9: TStringField;
    SmallintField5: TSmallintField;
    DateField6: TDateField;
    BCDField3: TBCDField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField16: TStringField;
    StringField17: TStringField;
    DateField7: TDateField;
    qryMCEKCIROCEKSENHAR_ID: TIntegerField;
    qryMCEKCIROCEKSENHAR_SID: TIntegerField;
    qryMCEKCIROISLEM_TAR: TDateField;
    qryMCEKCIRODOV_BAZ_TAR: TDateField;
    qryMCEKCIROCEKSEN: TSmallintField;
    qryMCEKCIROBELGE_ID: TIntegerField;
    qryMCEKCIROBELGE_SID: TSmallintField;
    qryMCEKCIROISLEM: TSmallintField;
    qryMCEKCIRODOVKUR: TBCDField;
    qryMCEKCIROTUTAR_VPB: TBCDField;
    qryMCEKCIROKUR_FARKI: TBCDField;
    qryMCEKCIROCARI_KOD: TStringField;
    qryMCEKCIROCARI_AD: TStringField;
    qryMCEKCIROPLASIYER_KOD: TStringField;
    qryMCEKCIROPROJE_KOD: TStringField;
    qryMCEKCIROCARIHAR_ACK: TStringField;
    qryMCEKCIROYEVMIYE_ACK: TStringField;
    qryMCEKCIROPROTESTO_MASRAF: TBCDField;
    qryMCEKCIROGENEL_GIDER: TBCDField;
    qryMCEKCIROGENEL_GIDER_MUH_KOD: TStringField;
    qryMCEKCIROBORCALHESAP: TStringField;
    qryMCEKCIROMASRAF_MERK: TStringField;
    qryMCEKCIROKOD1: TStringField;
    qryMCEKCIROKOD2: TStringField;
    qryMCEKCIROKOD3: TStringField;
    qryMCEKCIROKOD4: TStringField;
    qryMCEKCIROKASA_KOD: TStringField;
    qryFaturaFAT_IRS_SEP: TSmallintField;
    qryFaturaFAT_IRS_ID: TIntegerField;
    qryFaturaFAT_IRS_SID: TSmallintField;
    qryFaturaCARI_KOD: TStringField;
    qryFaturaFAT_IRS_SERI: TStringField;
    qryFaturaBELGE_NO: TStringField;
    qryFaturaDOV_BAZ_TAR: TDateField;
    qryFaturaTARIH: TDateField;
    qryFaturaREF_BELGE_TUR: TSmallintField;
    qryFaturaREF_BELGE_ID: TIntegerField;
    qryFaturaREF_BELGE_SID: TSmallintField;
    qryFaturaACIKLAMA: TStringField;
    qryFaturaBRUT_TOP: TBCDField;
    qryFaturaNET_TOP: TBCDField;
    qryFaturaGENEL_TOP: TBCDField;
    qryFaturaKDV_TOP: TBCDField;
    qryFaturaTIP: TSmallintField;
    qryFaturaFAT_IRS_TIP: TSmallintField;
    qryFaturaYAZILDI: TSmallintField;
    qryFaturaIPTAL: TSmallintField;
    qryFaturaDEPO_KOD: TStringField;
    qryFaturaSAAT: TTimeField;
    qryFaturaKALEM_ISKONTO_TOPLAM_VPB: TBCDField;
    qryFaturaISKONTO_TIP: TSmallintField;
    qryFaturaISKONTO_ORAN: TSmallintField;
    qryFaturaISKONTO_TUTAR_VPB: TBCDField;
    qryFaturaISKONTO_TOPLAM_VPB: TBCDField;
    qryFaturaKDV1: TBCDField;
    qryFaturaKDV2: TBCDField;
    qryFaturaKDV3: TBCDField;
    qryFaturaKDV4: TBCDField;
    qryFaturaKDV5: TBCDField;
    qryFaturaOTV: TBCDField;
    qryFaturaVADE_GUN: TIntegerField;
    qryFaturaVADE_TARIH: TDateField;
    qryFaturaKDV1_ORAN: TSmallintField;
    qryFaturaKDV2_ORAN: TSmallintField;
    qryFaturaKDV3_ORAN: TSmallintField;
    qryFaturaKDV4_ORAN: TSmallintField;
    qryFaturaKDV5_ORAN: TSmallintField;
    qryFaturaODEMETAR: TDateField;
    qryFaturaMUHTELIF: TSmallintField;
    qryFaturaKASA_KOD: TStringField;
    qryFaturaPLASIYER_KOD: TStringField;
    qryFaturaPROJE_KOD: TStringField;
    qryFaturaMASRAF_MERK: TStringField;
    qryFaturaKOD1: TStringField;
    qryFaturaKOD2: TStringField;
    qryFaturaKOD3: TStringField;
    qryFaturaKOD4: TStringField;
    qryFaturaYEV_ACIKLAMA: TStringField;
    qryFaturaGTYAZIILE: TStringField;
    qryFaturaGTYTLILE: TStringField;
    qryBCEKIADE: TIBOQuery;
    StringField18: TStringField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    DateField8: TDateField;
    IntegerField4: TIntegerField;
    StringField19: TStringField;
    StringField20: TStringField;
    BCDField4: TBCDField;
    StringField21: TStringField;
    StringField22: TStringField;
    qryToplamGTYTLILE: TStringField;
    qryTRANSFERGTYTLILE: TStringField;
    qryCekGTYTLILE: TStringField;
    qryMCEKCIROGTYTLILE: TStringField;
    qryBCEKODEMEGTYTLILE: TStringField;
    qryBCEKODEMECEK_NO: TStringField;
    qryKASAHARMASGTYTLILE: TStringField;
    qryKASAHARGTYAZI: TStringField;
    qryKASAHARGTYTLILE: TStringField;
    qryKASACEKSENETGTYTLILE: TStringField;
    qryBCEKIADEGTYTLILE: TStringField;
    qryFaturaGTDOVIZ: TStringField;
    qrySiparis: TIBOQuery;
    qrySiparisFAT_IRS_SEP: TSmallintField;
    qrySiparisFAT_IRS_ID: TIntegerField;
    qrySiparisFAT_IRS_SID: TSmallintField;
    qrySiparisCARI_KOD: TStringField;
    qrySiparisFAT_IRS_SERI: TStringField;
    qrySiparisBELGE_NO: TStringField;
    qrySiparisDOV_BAZ_TAR: TDateField;
    qrySiparisTARIH: TDateField;
    qrySiparisREF_BELGE_TUR: TSmallintField;
    qrySiparisREF_BELGE_ID: TIntegerField;
    qrySiparisREF_BELGE_SID: TSmallintField;
    qrySiparisACIKLAMA: TStringField;
    qrySiparisBRUT_TOP: TBCDField;
    qrySiparisNET_TOP: TBCDField;
    qrySiparisGENEL_TOP: TBCDField;
    qrySiparisKDV_TOP: TBCDField;
    qrySiparisTIP: TSmallintField;
    qrySiparisFAT_IRS_TIP: TSmallintField;
    qrySiparisYAZILDI: TSmallintField;
    qrySiparisIPTAL: TSmallintField;
    qrySiparisDEPO_KOD: TStringField;
    qrySiparisSAAT: TTimeField;
    qrySiparisKALEM_ISKONTO_TOPLAM_VPB: TBCDField;
    qrySiparisISKONTO_TIP: TSmallintField;
    qrySiparisISKONTO_ORAN: TSmallintField;
    qrySiparisISKONTO_TUTAR_VPB: TBCDField;
    qrySiparisISKONTO_TOPLAM_VPB: TBCDField;
    qrySiparisKDV1: TBCDField;
    qrySiparisKDV2: TBCDField;
    qrySiparisKDV3: TBCDField;
    qrySiparisKDV4: TBCDField;
    qrySiparisKDV5: TBCDField;
    qrySiparisOTV: TBCDField;
    qrySiparisVADE_GUN: TIntegerField;
    qrySiparisVADE_TARIH: TDateField;
    qrySiparisKDV1_ORAN: TSmallintField;
    qrySiparisKDV2_ORAN: TSmallintField;
    qrySiparisKDV3_ORAN: TSmallintField;
    qrySiparisKDV4_ORAN: TSmallintField;
    qrySiparisKDV5_ORAN: TSmallintField;
    qrySiparisODEMETAR: TDateField;
    qrySiparisMUHTELIF: TSmallintField;
    qrySiparisKASA_KOD: TStringField;
    qrySiparisPLASIYER_KOD: TStringField;
    qrySiparisPROJE_KOD: TStringField;
    qrySiparisMASRAF_MERK: TStringField;
    qrySiparisKOD1: TStringField;
    qrySiparisKOD2: TStringField;
    qrySiparisKOD3: TStringField;
    qrySiparisKOD4: TStringField;
    qrySiparisYEV_ACIKLAMA: TStringField;
    QrySiparisD: TIBOQuery;
    QrySiparisDURUNHAR_ID: TIntegerField;
    QrySiparisDURUNHAR_SID: TSmallintField;
    QrySiparisDURUN_KOD: TStringField;
    QrySiparisDTIP: TStringField;
    QrySiparisDBELGE_TUR: TIntegerField;
    QrySiparisDBELGE_ID: TIntegerField;
    QrySiparisDBELGE_SID: TSmallintField;
    QrySiparisDBELGE_SIRA_NO: TIntegerField;
    QrySiparisDTARIH: TDateField;
    QrySiparisDFIILI_TAR: TDateField;
    QrySiparisDDOV_BAZ_TAR: TDateField;
    QrySiparisDOLCUBIRIM: TStringField;
    QrySiparisDMIKTAR: TBCDField;
    QrySiparisDDOVKOD: TStringField;
    QrySiparisDDOVKUR: TBCDField;
    QrySiparisDTUTAR: TBCDField;
    QrySiparisDTUTAR_VPB: TBCDField;
    QrySiparisDURUN_DOVKOD: TStringField;
    QrySiparisDTUTAR_URUN_DOVKOD: TBCDField;
    QrySiparisDBIRIM_FIY: TBCDField;
    QrySiparisDBIRIM_FIY_VPB: TBCDField;
    QrySiparisDBIRIM_FIY_URN_DOVKOD: TBCDField;
    QrySiparisDISKONTO_TUTAR: TBCDField;
    QrySiparisDISKONTO_TUTAR_VPB: TBCDField;
    QrySiparisDOLCUBIRIM_URN_OB: TStringField;
    QrySiparisDMIKTAR_URN_OB: TBCDField;
    QrySiparisDDEPO_KOD: TStringField;
    QrySiparisDMASRAF_MERK: TStringField;
    QrySiparisDKOD1: TStringField;
    QrySiparisDKOD2: TStringField;
    QrySiparisDKOD3: TStringField;
    QrySiparisDKOD4: TStringField;
    QrySiparisDACIKLAMA: TStringField;
    QrySiparisDISKONTO_TIP: TSmallintField;
    QrySiparisDISKONTO_ORAN: TSmallintField;
    QrySiparisDFATURA_ID: TIntegerField;
    QrySiparisDFATURA_SID: TSmallintField;
    QrySiparisDIRSALIYE_ID: TIntegerField;
    QrySiparisDIRSALIYE_SID: TSmallintField;
    QrySiparisDKDV: TSmallintField;
    QrySiparisDKDV_TUTAR: TBCDField;
    qrySiparisGTYAZILE: TStringField;
    qrySiparisGTYTLILE: TStringField;
    qrySiparisGTDOVIZ: TStringField;
    qryRecete: TIBOQuery;
    qryFaturaD_Tran: TIBOQuery;
    qryKOMISYON: TIBOQuery;
    qryKOMISYONID: TIntegerField;
    qryKOMISYONSID: TSmallintField;
    qryKOMISYONCARI_KOD: TStringField;
    qryKOMISYONSEVK_ADRES_KOD: TStringField;
    qryKOMISYONGONDEREN_FIRMA: TStringField;
    qryKOMISYONGON_FIR_ADRES1: TStringField;
    qryKOMISYONGON_FIR_ADRES2: TStringField;
    qryKOMISYONGON_FIR_TEL: TStringField;
    qryKOMISYONGON_FIR_TEL1: TStringField;
    qryKOMISYONGIDECEGI_YER: TStringField;
    qryKOMISYONYUK_CINSI: TStringField;
    qryKOMISYONYUK_KILO: TBCDField;
    qryKOMISYONYUK_OLCU_BIR: TStringField;
    qryKOMISYONYUK_OLCU_TIP: TStringField;
    qryKOMISYONTOPLAM_UCRET: TBCDField;
    qryKOMISYONKDV_DAHIL: TSmallintField;
    qryKOMISYONKOMISYON_UCRET: TBCDField;
    qryKOMISYONSOFOR_ADI_SOY: TStringField;
    qryKOMISYONSOFOR_ADRESI: TStringField;
    qryKOMISYONSOFOR_ADRESI1: TStringField;
    qryKOMISYONSOFOR_TEL: TStringField;
    qryKOMISYONSOFOR_TEL1: TStringField;
    qryKOMISYONSOFOR_EHLIYET_NO: TStringField;
    qryKOMISYONSOFOR_VERGI_DA: TStringField;
    qryKOMISYONSOFOR_VERGI_DA_NO: TStringField;
    qryKOMISYONARAC_PLAKA: TStringField;
    qryKOMISYONARAC_MARKA: TStringField;
    qryKOMISYONARAC_MODEL: TStringField;
    qryKOMISYONARAC_SAHIBI: TStringField;
    qryKOMISYONARAC_SAHIBI_ADRESI: TStringField;
    qryKOMISYONARAC_SAHIBI_ADRESI1: TStringField;
    qryKOMISYONARAC_SAHIBI_TEL: TStringField;
    qryKOMISYONARAC_SAHIBI_TEL1: TStringField;
    qryKOMISYONARAC_RUHSAT_NO: TStringField;
    qryKOMISYONACIKLAMA: TMemoField;
    qryKOMISYONTARIH: TDateField;
    qryKOMISYONKULLANICI: TStringField;
    qryKOMISYONFIS_NO: TStringField;
    qryKOMISYONMASRAF_MERK: TStringField;
    qryKOMISYONKOD1: TStringField;
    qryKOMISYONKOD2: TStringField;
    qryKOMISYONKOD3: TStringField;
    qryKOMISYONKOD4: TStringField;
    qryKOMISYONKASA_KOD: TStringField;
    qryKOMISYONARAC_KOD: TStringField;
    qryKOMISYONSOFOR_KOD: TStringField;
    qryKOMISYONRESIM: TStringField;
    qryCariCARI_KOD: TStringField;
    qryCariCARI_SID: TSmallintField;
    qryCariCARI_AD: TStringField;
    qryCariYETKISI: TStringField;
    qryCariVERDAIRE: TStringField;
    qryCariVERNO: TStringField;
    qryCariADRES_1: TStringField;
    qryCariADRES_2: TStringField;
    qryCariILCE: TStringField;
    qryCariSEHIR: TStringField;
    qryCariPOSTA_KOD: TStringField;
    qryCariTIP: TSmallintField;
    qryCariTEL_NO_1: TStringField;
    qryCariTEL_NO_2: TStringField;
    qryCariFAX: TStringField;
    qryCariE_MAIL: TStringField;
    qryCariWEB_ADDR: TStringField;
    qryCariNOTES: TMemoField;
    qryCariKREDILMT: TBCDField;
    qryCariRISK: TBCDField;
    qryCariBORC: TBCDField;
    qryCariALACAK: TBCDField;
    qryCariULKE: TStringField;
    qryCariYURTDISI: TSmallintField;
    qryCariISLEMTIP: TSmallintField;
    qryCariMUHTELIF: TSmallintField;
    qryCariDEVREDEN_BORC: TBCDField;
    qryCariDEVREDEN_ALACAK: TBCDField;
    qryCariDOVIZLI: TSmallintField;
    qryCariDOVKOD: TStringField;
    qryKASAHAR_DMC: TStringField;
    qryKASAHAR_DKARSIKOD: TStringField;
    qryKASAHAR_DTUTAR_VPB: TBCDField;
    qryKASAHAR_DKARSI_AD: TStringField;
    qryFaturaD_TranSon_Kayit: TIntegerField;
    qryFaturaD_TranURUNHAR_ID: TIntegerField;
    qryFaturaD_TranURUNHAR_SID: TSmallintField;
    qryFaturaD_TranURUN_KOD: TStringField;
    qryFaturaD_TranTIP: TStringField;
    qryFaturaD_TranBELGE_TUR: TIntegerField;
    qryFaturaD_TranBELGE_ID: TIntegerField;
    qryFaturaD_TranBELGE_SID: TSmallintField;
    qryFaturaD_TranBELGE_SIRA_NO: TIntegerField;
    qryFaturaD_TranTARIH: TDateField;
    qryFaturaD_TranFIILI_TAR: TDateField;
    qryFaturaD_TranDOV_BAZ_TAR: TDateField;
    qryFaturaD_TranOLCUBIRIM: TStringField;
    qryFaturaD_TranMIKTAR: TBCDField;
    qryFaturaD_TranDOVKOD: TStringField;
    qryFaturaD_TranDOVKUR: TBCDField;
    qryFaturaD_TranTUTAR: TBCDField;
    qryFaturaD_TranTUTAR_VPB: TBCDField;
    qryFaturaD_TranURUN_DOVKOD: TStringField;
    qryFaturaD_TranTUTAR_URUN_DOVKOD: TBCDField;
    qryFaturaD_TranBIRIM_FIY: TBCDField;
    qryFaturaD_TranBIRIM_FIY_VPB: TBCDField;
    qryFaturaD_TranBIRIM_FIY_URN_DOVKOD: TBCDField;
    qryFaturaD_TranISKONTO_TUTAR: TBCDField;
    qryFaturaD_TranISKONTO_TUTAR_VPB: TBCDField;
    qryFaturaD_TranOLCUBIRIM_URN_OB: TStringField;
    qryFaturaD_TranMIKTAR_URN_OB: TBCDField;
    qryFaturaD_TranDEPO_KOD: TStringField;
    qryFaturaD_TranMASRAF_MERK: TStringField;
    qryFaturaD_TranKOD1: TStringField;
    qryFaturaD_TranKOD2: TStringField;
    qryFaturaD_TranKOD3: TStringField;
    qryFaturaD_TranKOD4: TStringField;
    qryFaturaD_TranISKONTO_TIP: TSmallintField;
    qryFaturaD_TranISKONTO_ORAN: TSmallintField;
    qryFaturaD_TranFATURA_ID: TIntegerField;
    qryFaturaD_TranFATURA_SID: TSmallintField;
    qryFaturaD_TranIRSALIYE_ID: TIntegerField;
    qryFaturaD_TranIRSALIYE_SID: TSmallintField;
    qryFaturaD_TranKDV: TSmallintField;
    qryFaturaD_TranKDV_TUTAR: TBCDField;
    qryFaturaD_TranSECIM: TStringField;
    qryFaturaD_TranBIRIM_FIY_URN_OB: TBCDField;
    qryFaturaD_TranCIKIS_MIKTAR: TBCDField;
    qryFaturaD_TranACIKLAMA: TStringField;
    qryFaturaD_TranSEFER_ID: TIntegerField;
    qryFaturaD_TranMAZOT_FISI_ID: TIntegerField;
    qryFaturaD_TranSEFER_BEKLEME: TSmallintField;
    qryFaturaD_TranCINSI: TStringField;
    qryKOMISYONDORSE_PLAKA: TStringField;
    qryFaturaGUN: TStringField;
    qryFaturaAY: TStringField;
    qryFaturaYILX: TStringField;
    qryFaturaYILSON: TStringField;
    qryKOMISYONCL_YAZ_UCRET: TStringField;
    qryKOMISYONCL_YAZ_KOM: TStringField;
    rptYazdir: TprTxReport;
    qrySirketSIRKET_ID: TIntegerField;
    qrySirketSIRKET_AD: TStringField;
    qrySirketADRES_1: TStringField;
    qrySirketADRES_2: TStringField;
    qrySirketILCE: TStringField;
    qrySirketSEHIR: TStringField;
    qrySirketVERDAIRE: TStringField;
    qrySirketVERNO: TStringField;
//****************************************************************************//
    procedure DEKONT(ID, SID: Integer; Tip: Byte);
    procedure FATURA(ID, SID: Integer; Tip: Byte; Sep:Integer;Adres:String);

//****************************************************************************//
    procedure KASAMUHTELIF(ID, SID: Integer; Tip: Byte);
    procedure KASACARI(ID, SID: Integer; Tip: Byte);
//****************************************************************************//
    procedure MUSTERICEKI(ID, SID: Integer; Tip: Byte);
    procedure BORCCEKI(ID, SID: Integer; Tip: Byte);
//****************************************************************************//
    procedure BANKADANMUSTERICEKTAHSIL(ID, SID: Integer; Tip: Byte);
    procedure KASAYACEKTAHSILI(ID, SID: Integer; Tip: Byte);
    procedure KASADANCEKTEDIYESI(ID, SID: Integer; Tip: Byte);
    procedure KASATRANSFER(ID, SID: Integer; Tip: Byte);
//****************************************************************************//
    procedure BCEKIADE(ID, SID: Integer; Tip: Byte);
    procedure BCEKODEME(ID, SID: Integer; Tip: Byte);
//****************************************************************************//
    procedure MCEKIADE(ID, SID: Integer; Tip: Byte);
    procedure MCEKCIRO(ID, SID: Integer; Tip: Byte);
//****************************************************************************//

    procedure SIPARIS(ID, SID: Integer; Tip: Byte);
    procedure YUKLEME_FISI(ID, SID: Integer; Tip: Byte);
//****************************************************************************//

    procedure qryToplamCalcFields(DataSet: TDataSet);
    procedure qryCekCalcFields(DataSet: TDataSet);
    procedure qryFaturaCalcFields(DataSet: TDataSet);
    procedure qryKASAHARMASCalcFields(DataSet: TDataSet);
    procedure qryKASACEKSENETCalcFields(DataSet: TDataSet);
    procedure qryMUHFISCalcFields(DataSet: TDataSet);
    procedure qryTRANSFERCalcFields(DataSet: TDataSet);
    procedure qryBCEKODEMECalcFields(DataSet: TDataSet);
    procedure qryKASAHARCalcFields(DataSet: TDataSet);
    procedure qryMCEKCIROCalcFields(DataSet: TDataSet);
////////////////////////////////////////////////////////////////////////////////
    function GET_DSGN_SETTINGS_MODAL(PRM_BELGE_TUR:Integer;PRM_SIRA_NO:Byte;ReportObj:TprTxReport):Boolean;
    function GET_DSGN_SETTINGS(PRM_BELGE_TUR:Integer;PRM_SIRA_NO:Byte;ReportObj:TprTxReport):Boolean;
    function GET_DSGN_SETTINGS_A4(PRM_BELGE_TUR:Integer;PRM_SIRA_NO:Byte;ReportObj:TprReport):Boolean;
    function GetDefaultPrinterName:string;
    function GetBelgePrinter(PRM_BELGE_TUR,PRM_SIRANO:Integer):String;
    procedure WriteBelgePrinter(PRM_BELGE_TUR,PRM_SIRANO:Integer;PrinterName:String);
    procedure SetDefaultPrinter(PrinterName:string);
    function GetDefaultPrinter2:string;
    procedure qryBCEKIADECalcFields(DataSet: TDataSet);
    procedure rptYazdirUnknownVariable(Sender: TObject; const VarName: String; var Value: TprVarValue; var IsProcessed: Boolean);
    procedure qrySiparisCalcFields(DataSet: TDataSet);
    procedure rptYazdirPrintComplete(Sender: TObject);
    procedure qryFaturaD_TranCalcFields(DataSet: TDataSet);
    procedure qryKOMISYONCalcFields(DataSet: TDataSet);

////////////////////////////////////////////////////////////////////////////////
  private
         prv_Yazdirma_No:Integer;
         prv_Sep,prv_Id,prv_Sid:Integer;

    { Private declarations }
  public

    Yeni_Rapor:Boolean;
    Function get_is(PrinterName: string):Integer;
    { Public declarations }
  end;

var
  Yazici: TYazici;

implementation

uses unDataMod,unFunc,unRegistry,unCEKSENHAR,unLogger;

{$R *.dfm}

procedure TYazici.DEKONT(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;
  qryDekont.Active := False;
  qryDekont_D.Active := False;
  qryTOPLAM.Active := False;
  with qryDekont do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM DEKONT WHERE DEKONT_ID='+inttostr(ID)+' AND DEKONT_SID='+inttostr(SID));
  end;
  with qryDekont_D do
  begin
    SQL.Clear;
    SQL.Add('SELECT BA,MC,KARSI_KOD,ACIKLAMA1,PROJE_KOD,TUTAR_VPB,(SELECT PRM_KARSI_AD FROM GET_KARSI_AD(DEKONT_D.MC,DEKONT_D.KARSI_KOD)) AS KARSI_AD');
    SQL.Add('FROM DEKONT_D WHERE DEKONT_ID='+inttostr(ID)+' AND DEKONT_SID ='+inttostr(SID)+' ORDER BY BA');
  end;

  with qryToplam do
  begin
    SQL.Clear;
    SQL.Add('SELECT SUM(TUTAR_VPB) AS TOPLAM FROM DEKONT_D WHERE DEKONT_ID ='+inttostr(ID)+' AND DEKONT_SID ='+inttostr(SID)+' AND BA='+ SQL_Katar('B'));
  end;


  qrySirket.Active := True;
  qryDekont.Active := True;
  qryDekont_D.Active := True;
  qryToplam.Active := True;

  If Yeni_Rapor then Exit;

  if not GET_DSGN_SETTINGS(17,1,rptYazdir) then Exit;
  case Tip of
  0://yazdýr
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(False);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(17,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryDekont.Active := False;
  qryDekont_D.Active := False;
  qryToplam.Active := False;
end;



procedure TYazici.FATURA(ID, SID: Integer; Tip: Byte; Sep:Integer;Adres:String);
var
  qryDeg:TIB_Query;
begin
     prv_Yazdirma_No:=1;
     prv_Sep:=Sep;
     prv_Id:=Id;
     prv_Sid:=Sid;

  qryFatura.Active := False;
  qryFaturaD.Active := False;
  qryFaturaD_Tran.Active := False;  
  qryCari.Active := False;
  with qryFatura do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_SEP = '+inttostr(Sep)+' AND FAT_IRS_ID='+inttostr(ID)+' AND FAT_IRS_SID='+inttostr(SID));
  end;
  {with qryFaturaD do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM URUNHAR WHERE FATURA_ID='+inttostr(ID)+' AND FATURA_SID ='+inttostr(SID)+' ORDER BY URUNHAR_ID');
  end;}
  {$IfDef TRANSPORT}
  if sep=1 then
  begin
  with qryFaturaD do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM FATURA_D WHERE FATURA_ID='+inttostr(ID)+' AND FATURA_SID ='+inttostr(SID)+' ORDER BY URUNHAR_ID');
  end;
  end;

  if sep=2 then
  begin
  with qryFaturaD do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM FATURA_D WHERE IRSALIYE_ID='+inttostr(ID)+' AND IRSALIYE_SID ='+inttostr(SID)+' ORDER BY URUNHAR_ID');
  end;
  end;


  if sep=1 then
  begin
  with qryFaturaD_Tran do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM FATURA_D WHERE FATURA_ID='+inttostr(ID)+' AND FATURA_SID ='+inttostr(SID)+' ORDER BY URUNHAR_ID');
  end;
  end;

  if sep=2 then
  begin
  with qryFaturaD_Tran do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM FATURA_D WHERE IRSALIYE_ID='+inttostr(ID)+' AND IRSALIYE_SID ='+inttostr(SID)+' ORDER BY URUNHAR_ID');
  end;

  end;

  {$EndIf}




  {$IfnDef TRANSPORT}
  if sep=1 then
  begin
  with qryFaturaD do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM URUNHAR WHERE FATURA_ID='+inttostr(ID)+' AND FATURA_SID ='+inttostr(SID)+' ORDER BY URUNHAR_ID');
  end;
  end;

  if sep=2 then
  begin
  with qryFaturaD do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM URUNHAR WHERE IRSALIYE_ID='+inttostr(ID)+' AND IRSALIYE_SID ='+inttostr(SID)+' ORDER BY URUNHAR_ID');
  end;
  end;

  {$EndIf}


  {$IfDef TRANSPORT}
  qryFaturaD_Tran.Active := True;
  {$EndIf}

  qryFaturaD.Active := True;
  qryFatura.Active := True;


  if qryFatura.FieldByName('MUHTELIF').AsInteger = 0 then
  begin
    with qryCari do
    begin
      Active := False;
      SQL.Clear;
      if Trim(Adres)<>'' then
      SQL.Add(
      ' SELECT  CARI_KOD '+
      '      , CARI_SID '+
      '      , MUHASKOD '+
      '      , CARI_AD '+
      '      , YETKISI '+
      '      , VERDAIRE '+
      '      , VERNO '+
      '      , (Select CARI_SEVKAD.ADRES_1 From CARI_SEVKAD where CARI_SEVKAD.CARI_KOD =CARI.CARI_KOD and CARI_SEVKAD.CARI_SID =CARI.CARI_SID and CARI_SEVKAD.CARI_SEVK_KOD='+SQL_Katar(Adres)+') as ADRES_1 '+
      '      , (Select CARI_SEVKAD.ADRES_2 From CARI_SEVKAD where CARI_SEVKAD.CARI_KOD =CARI.CARI_KOD and CARI_SEVKAD.CARI_SID =CARI.CARI_SID and CARI_SEVKAD.CARI_SEVK_KOD='+SQL_Katar(Adres)+') as ADRES_2 '+
      '      , ILCE '+
      '      , SEHIR '+
      '      , POSTA_KOD '+
      '      , TIP '+
      '      , TEL_NO_1 '+
      '      , TEL_NO_2 '+
      '      , FAX '+
      '      , E_MAIL '+
      '      , WEB_ADDR '+
      '      , NOTES '+
      '      , KREDILMT '+
      '      , RISK '+
      '      , BORC '+
      '      , ALACAK '+
      '      , ULKE '+
      '      , YURTDISI '+
      '      , ISLEMTIP '+
      '      , MUHTELIF '+
      '      , DOVIZLI '+
      '      , DOVKOD '+
      ' FROM CARI Where CARI_KOD='+SQL_Katar(qryFatura.FieldByName('CARI_KOD').AsString))
      else
      SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+SQL_Katar(qryFatura.FieldByName('CARI_KOD').AsString));

//      SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+SQL_Katar(qryFatura.FieldByName('CARI_KOD').AsString));
      Active := True;
    end;
  end
  else
  begin
    with qryCari do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM FAT_IRS_MUH_CARI WHERE FAT_IRS_ID='+inttostr(ID)+' AND FAT_IRS_SID ='+inttostr(SID));
//      SQL.Add('SELECT * FROM FAT_MUH_CARI WHERE CARI_KOD ='+SQL_Katar(qryFatura.FieldByName('CARI_KOD').AsString));
      Active := True;
    end;
  end;






  If Yeni_Rapor then Exit;

  if Sep=1 then
  if not GET_DSGN_SETTINGS(20,1,rptYazdir) then Exit;

  if Sep=2 then
  if not GET_DSGN_SETTINGS(36,1,rptYazdir) then Exit;


  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;

      end;
    end;

  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(False);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(20,ID,SID,1,3,'','');
  qryFatura.Active := False;
  qryFaturaD.Active := False;
  qryFaturaD_Tran.Active := False;
  qryCari.Active := False;
end;


procedure TYazici.SIPARIS(ID, SID: Integer; Tip: Byte);
begin
  prv_Yazdirma_No:=2;
  prv_Id:=Id;
  prv_Sid:=Sid;

  qrySiparis.Active := False;
  qrySiparisD.Active := False;
  qryCari.Active := False;
  with qrySiparis do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM SIPARIS WHERE FAT_IRS_SEP = 1 AND FAT_IRS_ID='+inttostr(ID)+' AND FAT_IRS_SID='+inttostr(SID));
  end;
  with qrySiparisD do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM SIPARIS_D WHERE FATURA_ID='+inttostr(ID)+' AND FATURA_SID ='+inttostr(SID)+' ORDER BY URUNHAR_ID');
  end;


  qrySiparisD.Active := True;
  qrySiparis.Active := True;


  if qrySiparis.FieldByName('MUHTELIF').AsInteger = 0 then
  begin
    with qryCari do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+SQL_Katar(qrySiparis.FieldByName('CARI_KOD').AsString));
      Active := True;
    end;
  end
  else
  begin
    with qryCari do
    begin
      Active := False;
      SQL.Clear;
      SQL.Add('SELECT * FROM FAT_IRS_MUH_CARI WHERE FAT_IRS_ID='+inttostr(ID)+' AND FAT_IRS_SID ='+inttostr(SID));
//      SQL.Add('SELECT * FROM FAT_MUH_CARI WHERE CARI_KOD ='+SQL_Katar(qryFatura.FieldByName('CARI_KOD').AsString));
      Active := True;
    end;
  end;


  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(37,1,rptYazdir) then Exit;
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;

  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(False);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(37,ID,SID,1,3,'','');
  qrySiparis.Active := False;
  qrySiparisD.Active := False;
  qryCari.Active := False;
end;



procedure TYazici.KASAMUHTELIF(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;
  qryKASAHAR.Active := False;
  qryKASAHAR_D.Active := False;
  with qryKASAHAR do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM KASAHAR WHERE KASAHAR_ID='+inttostr(ID)+' AND KASAHAR_SID='+inttostr(SID));
  end;
  with qryKASAHAR_D do
  begin
    SQL.Clear;
    SQL.Add('SELECT MC,KARSIKOD,TUTAR_VPB,(SELECT PRM_KARSI_AD FROM GET_KARSI_AD(KASAHAR.MC,KASAHAR.KARSIKOD)) AS KARSI_AD');
    SQL.Add(' FROM KASAHAR WHERE KASAHAR.BELGE_ID='+inttostr(ID)+' AND KASAHAR.BELGE_SID ='+inttostr(SID));
  end;

  qrySirket.Active := True;
  qryKASAHAR.Active := True;
  qryKASAHAR_D.Active := True;

  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(14,2,rptYazdir) then Exit;

  case Tip of
  0://yazdýr
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(False);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(14,ID,SID,2,3,'','');
  qrySirket.Active := False;
  qryKASAHAR.Active := False;
  qryKASAHAR_D.Active := False;
  qryKASAHAR.SQL.Clear;
  qryKASAHAR_D.SQL.Clear;
end;


procedure TYazici.KASACARI(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;
  qryKASAHARMAS.Active := False;
  with qryKASAHARMAS do
  begin
    SQL.Clear;
    SQL.Add('SELECT KASAHAR_ID,KASAHAR_SID,KASA_KOD,TARIH,DOV_BAZ_TAR,BELGE_TUR,BELGE_ID,BELGE_SID,TIP,ACIKLAMA,KASADEGER,ISLEM_TIP,PROJE_KOD,');
    SQL.Add('PLASIYER_KOD,MC,KARSIKOD,SIRA_NO,DOVKOD,DOVKUR,TUTAR,TUTAR_VPB,OLCUBIRIM,MIKTAR,MASRAF_MERK,KOD1,KOD2,KOD3,KOD4,YEVMIYE_ACK,');
    SQL.Add('(SELECT PRM_KARSI_AD FROM GET_KARSI_AD(KASAHAR.MC,KASAHAR.KARSIKOD)) AS KARSI_AD FROM KASAHAR WHERE KASAHAR_ID='+inttostr(ID)+' AND KASAHAR_SID='+inttostr(SID));
  end;

  qrySirket.Active := True;
  qryKASAHARMAS.Active := True;

  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(14,1,rptYazdir) then Exit;

  case Tip of
  0://yazdýr
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(False);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(14,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryKASAHARMAS.Active := False;
end;

procedure TYazici.MUSTERICEKI(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;

  qryCek.Active := False;
  qryCari.Active := False;
  with qryCek do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM CEK WHERE CEK_ID='+inttostr(ID)+' AND CEK_SID='+inttostr(SID));
  end;
  qrySirket.Active := True;
  qryCek.Active := True;
  with qryCari do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+SQL_Katar(qryCek.FieldByName('CARI_KOD').AsString));
    Active := True;
  end;
  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(6,1,rptYazdir) then Exit;
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(6,ID,SID,1,3,'','');
  qryCek.Active := False;
  qryCari.Active := False;
end;

procedure TYazici.BORCCEKI(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;

  qryCek.Active := False;
  qryCari.Active := False;
  with qryCek do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM CEK WHERE CEK_ID='+inttostr(ID)+' AND CEK_SID='+inttostr(SID));
  end;

  qrySirket.Active := True;
  qryCek.Active := True;
  with qryCari do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+SQL_Katar(qryCek.FieldByName('CARI_KOD').AsString));
    Active := True;
  end;

  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(4,1,rptYazdir) then Exit;
    
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(4,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryCek.Active := False;
  qryCari.Active := False;
end;

procedure TYazici.KASADANCEKTEDIYESI(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;

  qryKASACEKSENET.Active := False;
  with qryKASACEKSENET do
  begin
    SQL.Clear;
    SQL.Add('SELECT CEKSENHAR_ID');
    SQL.Add(', CEKSENHAR_SID');
    SQL.Add(', ISLEM_TAR');
    SQL.Add(', CEKSEN');
    SQL.Add(', BELGE_ID');
    SQL.Add(', KASA_KOD');
    SQL.Add(', PROJE_KOD');
    SQL.Add(', TUTAR_VPB');
    SQL.Add(', CARIHAR_ACK');
    SQL.Add('FROM CEKSENHAR WHERE CEKSENHAR_ID ='+inttostr(ID)+' AND CEKSENHAR_SID ='+inttostr(SID));
  end;

  qrySirket.Active := True;
  qryKASACEKSENET.Active := True;
  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(34,1,rptYazdir) then Exit;
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(34,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryKASACEKSENET.Active := False;
end;


procedure TYazici.KASAYACEKTAHSILI(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;

  qryKASACEKSENET.Active := False;
  with qryKASACEKSENET do
  begin
    SQL.Clear;
    SQL.Add('SELECT CEKSENHAR_ID');
    SQL.Add(', CEKSENHAR_SID');
    SQL.Add(', ISLEM_TAR');
    SQL.Add(', CEKSEN');
    SQL.Add(', BELGE_ID');
    SQL.Add(', KASA_KOD');
    SQL.Add(', PROJE_KOD');
    SQL.Add(', TUTAR_VPB');
    SQL.Add(', CARIHAR_ACK');
    SQL.Add('FROM CEKSENHAR WHERE CEKSENHAR_ID ='+inttostr(ID)+' AND CEKSENHAR_SID ='+inttostr(SID));
  end;

  qrySirket.Active := True;
  qryKASACEKSENET.Active := True;
  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(33,1,rptYazdir) then Exit;
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(33,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryKASACEKSENET.Active := False;
end;


procedure TYazici.BANKADANMUSTERICEKTAHSIL(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;

  qryKASACEKSENET.Active := False;
  with qryKASACEKSENET do
  begin
    SQL.Clear;
    SQL.Add('SELECT CEKSENHAR_ID');
    SQL.Add(', CEKSENHAR_SID');
    SQL.Add(', ISLEM_TAR');
    SQL.Add(', CEKSEN');
    SQL.Add(', BELGE_ID');
    SQL.Add(', KASA_KOD');
    SQL.Add(', PROJE_KOD');
    SQL.Add(', TUTAR_VPB');
    SQL.Add(', CARIHAR_ACK');
    SQL.Add('FROM CEKSENHAR WHERE CEKSENHAR_ID ='+inttostr(ID)+' AND CEKSENHAR_SID ='+inttostr(SID));
  end;

  qrySirket.Active := True;
  qryKASACEKSENET.Active := True;

  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(28,1,rptYazdir) then Exit;

  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(28,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryKASACEKSENET.Active := False;
end;

procedure TYazici.KASATRANSFER(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;
  qryTRANSFER.Active := False;
  with qryTRANSFER do
  begin
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('KASAHAR_ID,');
    SQL.Add('KASAHAR_SID,');
    SQL.Add('KASA_KOD,');
    SQL.Add('(SELECT KASA.ACIKLAMA FROM KASA WHERE KASA.KASA_KOD=KASAHAR.KASA_KOD) AS KASA_AD,');
    SQL.Add('KARSIKOD,');
    SQL.Add('(SELECT KASA.ACIKLAMA FROM KASA WHERE KASA.KASA_KOD=KASAHAR.KARSIKOD) AS KARSIAD,');
    SQL.Add('TARIH,');
    SQL.Add('DOVKUR,');
    SQL.Add('TUTAR,');
    SQL.Add('TUTAR_VPB,');
    SQL.Add('ACIKLAMA,');
    SQL.Add('YEVMIYE_ACK');
    SQL.Add('FROM KASAHAR WHERE KASAHAR.BELGE_ID='+inttostr(ID)+' AND KASAHAR.BELGE_SID ='+inttostr(SID)+' AND KASAHAR.ISLEM_TIP=6');
  end;


  qrySirket.Active := True;
  qryTRANSFER.Active := True;
  If Yeni_Rapor then Exit;

  if not GET_DSGN_SETTINGS(14,4,rptYazdir) then Exit;
  case Tip of
  0://yazdýr
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(False);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(14,ID,SID,4,3,'','');
  qrySirket.Active := False;
  qryTRANSFER.Active := False;
end;

procedure TYazici.BCEKIADE(ID, SID: Integer; Tip: Byte);
var
  strSQL : String;
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;
  qryCari.Active := False;
  qryBCEKIADE.Active := False;
  strSQL := 'SELECT CEKSENHAR_ID,CEKSENHAR_SID,ISLEM_TAR,BELGE_ID,'
           +'(SELECT CEK_NUM FROM CEK WHERE CEK.CEK_ID=CEKSENHAR.BELGE_ID) AS CEK_NO'
           +',CARI_KOD,PROJE_KOD,TUTAR_VPB,CARIHAR_ACK FROM CEKSENHAR WHERE'
           +' CEKSENHAR_ID ='+inttostr(ID)+' AND CEKSENHAR_SID ='+inttostr(SID);
  with qryBCEKIADE do
  begin
    SQL.Clear;
    SQL.Add(strSQL);
  end;

  qrySirket.Active := True;
  qryBCEKIADE.Active := True;
  with qryCari do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+SQL_Katar(qryBCEKIADE.FieldByName('CARI_KOD').AsString));
    Active := True;
  end;
  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(30,1,rptYazdir) then Exit;
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(30,ID,SID,1,3,'','');
  qryCari.Active := False;
  qrySirket.Active := False;
  qryBCEKIADE.Active := False;
end;

procedure TYazici.BCEKODEME(ID, SID: Integer; Tip: Byte);
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;
  qryBCEKODEME.Active := False;
  with qryBCEKODEME do
  begin
    SQL.Clear;
    SQL.Add('SELECT CEKSENHAR_ID');
    SQL.Add(', CEKSENHAR_SID');
    SQL.Add(', ISLEM_TAR');
    SQL.Add(', BELGE_ID');
    SQL.Add(', CARI_KOD');
    SQL.Add(', PROJE_KOD');
    SQL.Add(', TUTAR_VPB');
    SQL.Add(', CARIHAR_ACK');
    SQL.Add(', CARIHAR_ACK as CEK_NO');
    SQL.Add('FROM CEKSENHAR WHERE CEKSENHAR_ID ='+inttostr(ID)+' AND CEKSENHAR_SID ='+inttostr(SID));
  end;

  qrySirket.Active := True;
  qryBCEKODEME.Active := True;

  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(29,1,rptYazdir) then Exit;
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(29,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryBCEKODEME.Active := False;
end;


procedure TYazici.MCEKIADE(ID, SID: Integer; Tip: Byte);
var
  strSQL : String;
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;
  qryCari.Active := False;
  qryBCEKODEME.Active := False;
  strSQL := 'SELECT CEKSENHAR_ID,CEKSENHAR_SID,ISLEM_TAR,BELGE_ID,'
           +'(SELECT CEK_NUM FROM CEK WHERE CEK.CEK_ID=CEKSENHAR.BELGE_ID) AS CEK_NO'
           +',CARI_KOD,PROJE_KOD,TUTAR_VPB,CARIHAR_ACK FROM CEKSENHAR WHERE'
           +' CEKSENHAR_ID ='+inttostr(ID)+' AND CEKSENHAR_SID ='+inttostr(SID);
  with qryBCEKODEME do
  begin
    SQL.Clear;
    SQL.Add(strSQL);
  end;

  qrySirket.Active := True;
  qryBCEKODEME.Active := True;
  with qryCari do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+SQL_Katar(qryBCEKODEME.FieldByName('CARI_KOD').AsString));
    Active := True;
  end;
  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(11,1,rptYazdir) then Exit;
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(11,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryCari.Active := False;
  qryBCEKODEME.Active := False;
end;

procedure TYazici.MCEKCIRO(ID, SID: Integer; Tip: Byte);
var
  strSQL : String;
begin
  with qrySirket do
  begin
    Active := False;
    ParamByName('PRM_SIRKET_ID').AsInteger := glb_SIRKET_ID;
  end;
  qryMCEK.Active := False;
  qryMCEKCIRO.Active := False;
  qryCari.Active := False;
  with qryMCEKCIRO do
  begin
    SQL.Clear;
    strSQL := 'SELECT CEKSENHAR_ID'
             +'  , CEKSENHAR_SID'
             +'  , ISLEM_TAR'
             +'  , DOV_BAZ_TAR'
             +'  , CEKSEN'
             +'  , BELGE_ID'
             +'  , BELGE_SID'
             +'  , ISLEM'
             +'  , DOVKUR'
             +'  , TUTAR_VPB'
             +'  , KUR_FARKI'
             +'  , CARI_KOD'
             +'  , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=CEKSENHAR.CARI_KOD) AS CARI_AD'
             +'  , PLASIYER_KOD'
             +'  , PROJE_KOD'
             +'  , CARIHAR_ACK'
             +'  , YEVMIYE_ACK'
             +'  , PROTESTO_MASRAF'
             +'  , GENEL_GIDER'
             +'  , GENEL_GIDER_MUH_KOD'
             +'  , BORCALHESAP'
             +'  , MASRAF_MERK'
             +'  , KOD1'
             +'  , KOD2'
             +'  , KOD3'
             +'  , KOD4'
             +'  , KASA_KOD'
             +' FROM CEKSENHAR WHERE CEKSENHAR_ID='+inttostr(ID)+' AND CEKSENHAR_SID='+inttostr(SID);
    SQL.Add(strSQL);
  end;
  qryMCEKCIRO.Active := True;
  with qryMCEK do
  begin
    SQL.Clear;
    SQL.Add('SELECT * FROM CEK WHERE CEK_ID = '+ qryMCEKCIRO.FieldByName('BELGE_ID').AsString+ ' AND CEK_SID = '+qryMCEKCIRO.FieldByName('BELGE_SID').AsString);
  end;
  qryMCEK.Active := True;


  qrySirket.Active := True;

  with qryCari do
  begin
    Active := False;
    SQL.Clear;
    SQL.Add('SELECT * FROM CARI WHERE CARI_KOD ='+SQL_Katar(qryMCEKCIRO.FieldByName('CARI_KOD').AsString));
    Active := True;
  end;
  If Yeni_Rapor then Exit;
  if not GET_DSGN_SETTINGS(8,1,rptYazdir) then Exit;
  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(8,ID,SID,1,3,'','');
  qrySirket.Active := False;
  qryMCEK.Active := False;
  qryMCEKCIRO.Active := False;
  qryCari.Active := False;
end;

procedure TYazici.qryMCEKCIROCalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TUTAR_VPB').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.fieldbyname('TUTAR_VPB').AsCurrency) + ' TL.';
    end;
    DataSet.FieldByName('CIKTAR').AsDateTime := DataMod.GET_SERVER_DATETIME;
    DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.fieldbyname('TUTAR_VPB').AsCurrency);
    }

    DataSet.FieldByName('CIKTAR').AsDateTime := DataMod.GET_SERVER_DATETIME;
    DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.fieldbyname('TUTAR_VPB').AsCurrency);
  end;
end;

procedure TYazici.qryFaturaCalcFields(DataSet: TDataSet);
var
  SONUC : Currency;
  qryCariUrunHar : TIB_Cursor;
        Year, Month, Day, Hour, Min, Sec, MSec: Word;
begin
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZILE').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('GENEL_TOP').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZILE').AsString := param(Dataset.FieldByName('GENEL_TOP').AsCurrency) + ' TL.';
    end;

    if DataMod.KurluDonustur(DataSet.FieldByName('TARIH').AsDateTime,glb_DEFCUR,1,'YTL',Dataset.FieldByName('GENEL_TOP').AsCurrency,glb_SATISKUR,True,SONUC) then
       DataSet.FieldByName('GTYTLILE').AsString := YeniParam(SONUC);
    }

       DataSet.FieldByName('GTYAZILE').AsString := YeniParam(Dataset.FieldByName('GENEL_TOP').AsCurrency);
       DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.FieldByName('GENEL_TOP').AsCurrency);




//  Present:=Dataset.FieldByName('TARIH').AsDateTime;
  DecodeDate(Dataset.FieldByName('TARIH').AsDateTime, Year, Month, Day);

       DataSet.FieldByName('GUN').AsString :=Inttostr(Day);
       if Length(Trim(DataSet.FieldByName('GUN').AsString))=1 then
       DataSet.FieldByName('GUN').AsString :='0'+Inttostr(Day);

       DataSet.FieldByName('AY').AsString := Inttostr(Month);
       if Length(Trim(DataSet.FieldByName('AY').AsString))=1 then
       DataSet.FieldByName('AY').AsString :='0'+Inttostr(Day);


       DataSet.FieldByName('YILX').AsString := Inttostr(Year);
       DataSet.FieldByName('YILSON').AsString := COPY(DataSet.FieldByName('YILX').AsString,4,1);


    DataMod.CreateCursor(qryCariUrunHar,nil,False,DataMod.dbaMain);
    with qryCariUrunHar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT DOVIZLI FROM CARI WHERE CARI_KOD = '+SQL_Katar(DataSet.FieldByName('CARI_KOD').AsString));
      Open;
    end;
    if qryCariUrunHar.FieldByName('DOVIZLI').AsSmallint = 1 then
    begin
      with qryCariUrunHar do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT SUM(TUTAR) AS DOVIZ_TOPLAM FROM URUNHAR WHERE FATURA_ID='+DataSet.FieldByName('FAT_IRS_ID').AsString+' AND FATURA_SID='+DataSet.FieldByName('FAT_IRS_SID').AsString);
        Open;
      end;
      DataSet.FieldByName('GTDOVIZ').AsString := '1 '+qryFaturaD.FieldByName('DOVKOD').AsString+' = ' + FormatCurr(glb_DOV_KUR_PF,qryFaturaD.FieldByName('DOVKUR').AsCurrency) + ' = '+ FormatCurr(glb_DOV_FIELD_PF,qryCariUrunHar.FieldByName('DOVIZ_TOPLAM').AsCurrency);
    end;
    DataMod.ReleaseCursor(qryCariUrunHar);
  end;
end;

procedure TYazici.qryKASAHARMASCalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    if DataSet.FieldByName('TIP').AsString = 'C' then
       DataSet.FieldByName('BASLIK').AsString := 'TEDÝYE MAKBUZU'
    else
       DataSet.FieldByName('BASLIK').AsString := 'TAHSÝL MAKBUZU';

    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TUTAR_VPB').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.FieldByName('TUTAR_VPB').AsCurrency) + ' TL.';
    end;
    DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
    }
      DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
  end;
end;

procedure TYazici.qryToplamCalcFields(DataSet: TDataSet);
begin
//  if DataSet.Active then
//     DataSet.FieldByName('GTYAZI').AsString := param(Dataset.fieldbyname('TOPLAM').AsCurrency) + ' TL.';
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TOPLAM').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.FieldByName('TOPLAM').AsCurrency) + ' TL.';
    end;
//  if DataMod.KurluDonustur(Date,glb_DEFCUR,1,'YTL',Dataset.FieldByName('TOPLAM').AsCurrency,glb_SATISKUR,True,SONUC) then
    DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.FieldByName('TOPLAM').AsCurrency);
    }
      DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.FieldByName('TOPLAM').AsCurrency);
  end
  ;

end;

procedure TYazici.qryCekCalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TUTAR_VPB').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.fieldbyname('TUTAR_VPB').AsCurrency) + ' TL.';
    end;
    DataSet.FieldByName('CIKTAR').AsDateTime := DataMod.GET_SERVER_DATETIME;
    DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.fieldbyname('TUTAR_VPB').AsCurrency);
    }

    DataSet.FieldByName('CIKTAR').AsDateTime := DataMod.GET_SERVER_DATETIME;
    DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.fieldbyname('TUTAR_VPB').AsCurrency);
  end;
end;

procedure TYazici.qryKASACEKSENETCalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TUTAR_VPB').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.FieldByName('TUTAR_VPB').AsCurrency) + ' TL.';
    end;
//    if DataMod.KurluDonustur(DataSet.FieldByName('TARIH').AsDateTime,glb_DEFCUR,1,'YTL',Dataset.FieldByName('GENEL_TOP').AsCurrency,glb_SATISKUR,True,SONUC) then
       DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);

     }

      DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
  end;
end;

procedure TYazici.qryMUHFISCalcFields(DataSet: TDataSet);
begin
  if qryMUHFIS.FieldByName('BA').AsString = 'A' then
     qryMUHFIS.FieldByName('TUTAR_ALACAK').AsCurrency := qryMUHFIS.FieldByName('TUTAR_VPB').AsCurrency
  else
     qryMUHFIS.FieldByName('TUTAR_BORC').AsCurrency := qryMUHFIS.FieldByName('TUTAR_VPB').AsCurrency;
end;

procedure TYazici.qryTRANSFERCalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TUTAR_VPB').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.FieldByName('TUTAR_VPB').AsCurrency) + ' TL.';
    end;
//    if DataMod.KurluDonustur(DataSet.FieldByName('TARIH').AsDateTime,glb_DEFCUR,1,'YTL',Dataset.FieldByName('GENEL_TOP').AsCurrency,glb_SATISKUR,True,SONUC) then
       DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
      }

      DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
  end;
end;

procedure TYazici.qryBCEKODEMECalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
   { if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TUTAR_VPB').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.FieldByName('TUTAR_VPB').AsCurrency) + ' TL.';
    end;
//    if DataMod.KurluDonustur(DataSet.FieldByName('TARIH').AsDateTime,glb_DEFCUR,1,'YTL',Dataset.FieldByName('GENEL_TOP').AsCurrency,glb_SATISKUR,True,SONUC) then
       DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
      }

      DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
  end;
end;

procedure TYazici.qryKASAHARCalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    if DataSet.FieldByName('TIP').AsString = 'C' then
       DataSet.FieldByName('BASLIK').AsString := 'TEDÝYE MAKBUZU'
    else
       DataSet.FieldByName('BASLIK').AsString := 'TAHSÝL MAKBUZU';

    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TUTAR_VPB').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.FieldByName('TUTAR_VPB').AsCurrency) + ' TL.';
    end;
    DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
    }

      DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);

  end;
end;

procedure TYazici.qryBCEKIADECalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('TUTAR_VPB').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZI').AsString := param(Dataset.FieldByName('TUTAR_VPB').AsCurrency) + ' TL.';
    end;
    DataSet.FieldByName('GTYTLILE').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
    }
      DataSet.FieldByName('GTYAZI').AsString := YeniParam(Dataset.FieldByName('TUTAR_VPB').AsCurrency);
  end;
end;

function TYazici.GET_DSGN_SETTINGS_A4(PRM_BELGE_TUR:Integer;PRM_SIRA_NO:Byte;ReportObj:TprReport):Boolean;
var
  qryBELGE_YAZ:TIB_Query;
  Dosya_Ad:String;
begin
  try
    try
      DataMod.CreateQuery(qryBELGE_YAZ,nil,False,DataMod.dbaMain);
      qryBELGE_YAZ.SQL.Add('SELECT * FROM BELGE_YAZ WHERE BELGE_TUR = ' + IntToStr(PRM_BELGE_TUR) + ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO) + 'AND SUBE_ID = ' + inttostr(glb_SID));
      qryBELGE_YAZ.Open;
      if qryBELGE_YAZ.RecordCount <> 0 then
      begin
        ReportObj.PreviewFormMode := fmMDIChild;
        //ReportObj.LoadTemplateFromFile(qryBELGE_YAZ.FieldByName('DOSYA_PATH').AsString,false);
        Dosya_Ad:=glb_REPORTS_DIR+'\'+ExtractFilename(qryBELGE_YAZ.FieldByName('DOSYA_PATH').AsString);
        ReportObj.LoadTemplateFromFile(Dosya_Ad,false);

        ReportObj.PrinterName := GetBelgePrinter(PRM_BELGE_TUR,PRM_SIRA_NO);
        qryBELGE_YAZ.Close;
        Result := True;
      end
      else
      begin
        Result := False;
        Application.MessageBox('Gönderilen Yazýcý tasarýmýna ait kayýt yok','Dikkat',MB_ICONHAND);
      end;
    except
      Result := False;
    end;
  finally
    DataMod.ReleaseQuery(qryBELGE_YAZ);
  end;
end;

function TYazici.GET_DSGN_SETTINGS(PRM_BELGE_TUR:Integer;PRM_SIRA_NO:Byte;ReportObj:TprTxReport):Boolean;
var
  dosya_Ad:String;
  qryBELGE_YAZ:TIB_Query;
  Yazici_Is:Integer;
begin

  try
    try
      DataMod.CreateQuery(qryBELGE_YAZ,nil,False,DataMod.dbaMain);
      qryBELGE_YAZ.SQL.Add('SELECT * FROM BELGE_YAZ WHERE BELGE_TUR = ' + IntToStr(PRM_BELGE_TUR) + ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO) + 'AND SUBE_ID = ' + inttostr(glb_SID));
      qryBELGE_YAZ.Open;
      if qryBELGE_YAZ.RecordCount <> 0 then
      begin
        ReportObj.PaperType := ptPage;
        ReportObj.DesignerFormMode := fmMDIChild;
        ReportObj.PreviewFormMode := fmMDIChild;
        //ReportObj.LoadTemplateFromFile(qryBELGE_YAZ.FieldByName('DOSYA_PATH').AsString,false);

        Dosya_Ad:=glb_REPORTS_DIR+'\'+ExtractFilename(qryBELGE_YAZ.FieldByName('DOSYA_PATH').AsString);

        ReportObj.LoadTemplateFromFile(Dosya_Ad,false);


        ReportObj.PrinterName := GetBelgePrinter(PRM_BELGE_TUR,PRM_SIRA_NO);

        if glb_Yazici_Is_Bildir then
        begin
            Yazici_Is:=Yazici.get_is(ReportObj.PrinterName);
            if Yazici_Is>0 then
            begin
                 if Application.MessageBox(Pchar('Yazýcýda '+
                 Inttostr(Yazici_Is)+' Adet Ýþ Beklemektedir. Yazdýrmaya Devam Edilsin mi?'),
                 'Dikkat',MB_YESNO + MB_DEFBUTTON1+ MB_ICONQUESTION) = IDNO then ABORT;
            end;
        end;

        ReportObj.ESCModelName := 'Epson printers';
        qryBELGE_YAZ.Close;
        Result := True;
      end
      else
      begin
        Result := False;
        Application.MessageBox('Gönderilen Yazýcý tasarýmýna ait kayýt yok.','Dikkat',MB_ICONHAND);
      end;
    except
      Result := False;
    end;
  finally
    DataMod.ReleaseQuery(qryBELGE_YAZ);
  end;
end;

function TYazici.GetBelgePrinter(PRM_BELGE_TUR,PRM_SIRANO:Integer):String;
begin
  Result := ReadStringFromRegistry(RegSection+'\'+ PrintSubSection + '\' + IntToStr(PRM_BELGE_TUR) , IntToStr(PRM_SIRANO) );
  if Trim(Result) = '' then
  begin
    Result := GetDefaultPrinter2;
    if Trim(Result) = '' then Application.MessageBox('Sisteminizde hiç yazýcý tanýmlanmamýþ, Lütfen bir yazýcý tanýmlayýn','Dikkat', MB_ICONHAND);
  end;
end;

Procedure TYazici.WriteBelgePrinter(PRM_BELGE_TUR,PRM_SIRANO:Integer;PrinterName:String);
begin
  WriteToRegistry(RegSection+'\'+ PrintSubSection + '\' + IntToStr(PRM_BELGE_TUR) , IntToStr(PRM_SIRANO), PrinterName);
end;

function TYazici.GetDefaultPrinterName : string;
begin
  if (Printer.PrinterIndex > 0) then
  begin
    Result := Printer.Printers[Printer.PrinterIndex];
  end
  else
  begin
    Result := '';
  end;
end;

function TYazici.get_is(PrinterName: string):Integer;

function GetCurrentPrinterHandle(PrinterName: string): THandle;
var
  Device, Driver, Port: array[0..255] of Char;
  hDeviceMode: THandle;
  I:Integer;
begin
    if Printer.Printers.Count<=0 then
    begin
        Application.MessageBox('Tanýmlanmýþ Yazýcý Bulunamadý Ýþlem Ýptal Edilecek ','Dikkat',MB_ICONWARNING);
        Abort;
    end;

    for I := 0 to Printer.Printers.Count - 1 do
    begin
      if Printer.Printers[I] = PrinterName then
      begin
         Printer.PrinterIndex := i;
         Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
         if not OpenPrinter(@Device, Result, nil) then
         RaiseLastWin32Error;
         Exit;
      end;
    end;
end;

type
  TJobs  = array [0..1000] of JOB_INFO_1;
  PJobs = ^TJobs;
var
  hPrinter: THandle;
  bytesNeeded, numJobs, i: Cardinal;
  pJ: PJobs;
begin
  Result:=0;
  try
    hPrinter := GetCurrentPrinterHandle(PrinterName) ;

    EnumJobs(hPrinter, 0, 1000, 1, nil, 0, bytesNeeded,numJobs);
    pJ := AllocMem(bytesNeeded);
    if not EnumJobs(hPrinter, 0, 1000, 1, pJ, bytesNeeded,bytesNeeded, numJobs) then RaiseLastWin32Error;

    //if numJobs <> 0 then
    //ShowMessage(InttoStr(numJobs)+ 'Adet Ýs Var');
    Result:=numJobs;
   Finally
   ClosePrinter(hPrinter);
   end;

end;

procedure TYazici.SetDefaultPrinter(PrinterName: string);
var
  I: Integer;
  Device: PChar;
  Driver: PChar;
  Port: PChar;
  HdeviceMode: THandle;
  aPrinter: TPrinter;
begin
  Printer.PrinterIndex := -1;
  GetMem(Device, 255);
  GetMem(Driver, 255);
  GetMem(Port, 255);
  aPrinter := TPrinter.Create;
  try
    for I := 0 to Printer.Printers.Count - 1 do
    begin
      if Printer.Printers[I] = PrinterName then
      begin
        aprinter.PrinterIndex := i;
        aPrinter.getprinter(device, driver, port, HdeviceMode);
        StrCat(Device, ',');
        StrCat(Device, Driver);
        StrCat(Device, Port);
        WriteProfileString('windows', 'device', Device);
        StrCopy(Device, 'windows');
        SendMessage(HWND_BROADCAST, WM_WININICHANGE ,0, Longint(@Device));
      end;
    end;
  finally
    aPrinter.Free;
  end;
  FreeMem(Device, 255);
  FreeMem(Driver, 255);
  FreeMem(Port, 255);
end;

function TYazici.GetDefaultPrinter2: string;
var
  ResStr: array[0..255] of Char;
begin
  GetProfileString('Windows', 'device', '', ResStr, 255);
  Result := StrPas(ResStr);
  Result := Copy(Result,1, Pos(',',Result)-1);
end;

function TYazici.GET_DSGN_SETTINGS_MODAL(PRM_BELGE_TUR: Integer; PRM_SIRA_NO: Byte; ReportObj: TprTxReport): Boolean;
var
  qryBELGE_YAZ:TIB_Query;
  Dosya_Ad:String;
begin
  try
    try
      DataMod.CreateQuery(qryBELGE_YAZ,nil,False,DataMod.dbaMain);
      qryBELGE_YAZ.sql.Add('SELECT * FROM BELGE_YAZ WHERE BELGE_TUR = ' + IntToStr(PRM_BELGE_TUR) + ' AND SIRA_NO = ' + IntToStr(PRM_SIRA_NO));
      qryBELGE_YAZ.Open;
      if qryBELGE_YAZ.RecordCount <> 0 then
      begin
        ReportObj.PaperType := ptPage;
        ReportObj.DesignerFormMode := fmNormal;
        ReportObj.PreviewFormMode := fmNormal;
        //ReportObj.LoadTemplateFromFile(qryBELGE_YAZ.FieldByName('DOSYA_PATH').AsString,false);
        Dosya_Ad:=glb_REPORTS_DIR+'\'+ExtractFilename(qryBELGE_YAZ.FieldByName('DOSYA_PATH').AsString);
        ReportObj.LoadTemplateFromFile(Dosya_Ad,false);

        ReportObj.PrinterName := GetBelgePrinter(PRM_BELGE_TUR,PRM_SIRA_NO);
        ReportObj.ESCModelName := 'Epson printers';
        qryBELGE_YAZ.Close;
        Result := True;
      end
      else
      begin
        Result := False;
        Application.MessageBox('Gönderilen Yazýcý tasarýmýna ait kayýt yok','Dikkat',MB_ICONHAND);
      end;
    except
      Result := False;
    end;
  finally
    DataMod.ReleaseQuery(qryBELGE_YAZ);
  end;


end;


procedure TYazici.rptYazdirUnknownVariable(Sender: TObject; const VarName: String; var Value: TprVarValue; var IsProcessed: Boolean);
//var
//  s : string;
begin
{
  if StrToInt(DataMod.GETPARAM(16,'SUBEAD')) = 1 then
  begin
    if AnsiCompareText(VarName,'SUBEAD')=0 then
    begin
      s := DataMod.SubeID2Ad(True,qryFatura.FieldByName('FAT_IRS_SID').AsInteger);
      _vSetAsString(Value,s);
      IsProcessed := true;
    end;
  end
  else
  begin
    if AnsiCompareText(VarName,'SUBEAD')=0 then
    begin
      s := '';
      _vSetAsString(Value,s);
      IsProcessed := true;
    end;
  end;
}
end;

procedure TYazici.qrySiparisCalcFields(DataSet: TDataSet);

var
  SONUC : Currency;
  qryCariUrunHar : TIB_Cursor;
begin
  if DataSet.Active then
  begin
    {if (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 0) or (CompareDate(glb_DONEM_BAS,StrToDate('01'+DateSeparator+'01'+DateSeparator+'2005')) = 1) then
    begin
      DataSet.FieldByName('GTYAZILE').AsString := param(StrToCurr(FormatCurr('#.00',Dataset.FieldByName('GENEL_TOP').AsCurrency))*1000000) + ' TL.';
    end
    else
    begin
      DataSet.FieldByName('GTYAZILE').AsString := param(Dataset.FieldByName('GENEL_TOP').AsCurrency) + ' TL.';
    end;

    if DataMod.KurluDonustur(DataSet.FieldByName('TARIH').AsDateTime,glb_DEFCUR,1,'YTL',Dataset.FieldByName('GENEL_TOP').AsCurrency,glb_SATISKUR,True,SONUC) then
       DataSet.FieldByName('GTYTLILE').AsString := YeniParam(SONUC);
    }
      DataSet.FieldByName('GTYAZILE').AsString := YeniParam(Dataset.FieldByName('GENEL_TOP').AsCurrency);


    DataMod.CreateCursor(qryCariUrunHar,nil,False,DataMod.dbaMain);
    with qryCariUrunHar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT DOVIZLI FROM CARI WHERE CARI_KOD = '+SQL_Katar(DataSet.FieldByName('CARI_KOD').AsString));
      Open;
    end;
    if qryCariUrunHar.FieldByName('DOVIZLI').AsSmallint = 1 then
    begin
      with qryCariUrunHar do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT SUM(TUTAR) AS DOVIZ_TOPLAM FROM URUNHAR WHERE FATURA_ID='+DataSet.FieldByName('FAT_IRS_ID').AsString+' AND FATURA_SID='+DataSet.FieldByName('FAT_IRS_SID').AsString);
        Open;
      end;
      DataSet.FieldByName('GTDOVIZ').AsString := '1 '+QrySiparisD.FieldByName('DOVKOD').AsString+' = ' + FormatCurr(glb_DOV_KUR_PF,QrySiparisD.FieldByName('DOVKUR').AsCurrency) + ' = '+ FormatCurr(glb_DOV_FIELD_PF,qryCariUrunHar.FieldByName('DOVIZ_TOPLAM').AsCurrency);
    end;
    DataMod.ReleaseCursor(qryCariUrunHar);
  end;

end;








procedure TYazici.YUKLEME_FISI(ID, SID: Integer; Tip: Byte);
var
  strSQL : String;
begin

  qryKOMISYON.Active := False;
  strSQL :=

' SELECT ID '+#13+
'     , SID '+#13+
'     , GONDEREN_FIRMA '+#13+
'     , GON_FIR_ADRES1 '+#13+
'     , GON_FIR_ADRES2 '+#13+
'     , GON_FIR_TEL '+#13+
'     , GIDECEGI_YER '+#13+
'     , YUK_CINSI '+#13+
'     , YUK_KILO '+#13+
'     , YUK_OLCU_BIR '+#13+
'     , TOPLAM_UCRET '+#13+
'     , KOMISYON_UCRET '+#13+
'     , SOFOR_ADI_SOY '+#13+
'     , ARAC_PLAKA '+#13+
'     , SOFOR_ADRESI '+#13+
'     , SOFOR_TEL '+#13+
'     , SOFOR_EHLIYET_NO '+#13+
'     , SOFOR_VERGI_DA '+#13+
'     , SOFOR_VERGI_DA_NO '+#13+
'     , ARAC_SAHIBI '+#13+
'     , ARAC_SAHIBI_ADRESI '+#13+
'     , ARAC_SAHIBI_TEL '+#13+
'     , ARAC_RUHSAT_NO '+#13+
'     , ACIKLAMA '+#13+
'     , TARIH '+#13+
'     , KULLANICI '+#13+
'     , FIS_NO '+#13+
'     , KDV_DAHIL '+#13+
'     , YUK_OLCU_TIP '+#13+
'     , CARI_KOD '+#13+
'     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=KOMISYON.CARI_KOD) AS CARI_ADI '+#13+
'     ,SEVK_ADRES_KOD '+#13+
'     , MASRAF_MERK '+#13+
'     , KOD1 '+#13+
'     , KOD2 '+#13+
'     , KOD3 '+#13+
'     , KOD4 '+#13+
'     , GON_FIR_TEL1 '+#13+
'     , SOFOR_TEL1 '+#13+
'     , ARAC_SAHIBI_TEL1 '+#13+
'     , KASA_KOD '+#13+
'     , (SELECT ACIKLAMA FROM KASA WHERE KOMISYON.KASA_KOD = KASA.KASA_KOD) AS KASA_AD '+#13+
'     , ARAC_KOD '+#13+
'     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=KOMISYON.ARAC_KOD) AS ARAC_PLAKA_CO '+#13+
'     , SOFOR_KOD '+#13+
'     ,(SELECT ADI_SOYADI FROM SOFOR WHERE SOFOR.SOFOR_KOD=KOMISYON.SOFOR_KOD) AS SOFOR_ADI_CO '+#13+
'     , ARAC_MARKA '+#13+
'     , ARAC_MODEL '+#13+
'     , SOFOR_ADRESI1 '+#13+
'     , ARAC_SAHIBI_ADRESI1 '+#13+
'     , RESIM '+#13+
'     , DORSE_PLAKA '+#13+
' FROM KOMISYON '+#13+
  'WHERE ID='+Inttostr(ID);



  with qryKOMISYON do
  begin
    SQL.Clear;
    SQL.Add(strSQL);
  end;


  qryKOMISYON.Active := True;
  If Yeni_Rapor then Exit;

  if not GET_DSGN_SETTINGS(43,1,rptYazdir) then Exit;

  case Tip of
  0://yazdir
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PrintPreparedReport;
      end;
    end;
  1://göster
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.PreviewPreparedReport(false);
      end;
    end;
  4://dizayn
    begin
      if rptYazdir.PrepareReport then
      begin
        rptYazdir.DesignReport(false);
      end;
    end;
  end;//end case Tip of
  dmLOGGER.Write2Log(43,ID,SID,1,3,'','');
  qryKOMISYON.Active := False;
end;



procedure TYazici.rptYazdirPrintComplete(Sender: TObject);
var
   qryDeg:TIb_Query;
begin

    // ShowMessage('Print Complate');
if prv_Yazdirma_No=1 then
begin
      DataMod.CreateQuery(qryDeg,Nil,True,DataMod.dbaMain);
      qryDeg.Active:=False;
      qryDeg.SQL.Clear;
      qryDeg.SQL.Add('SELECT * FROM FAT_IRS WHERE FAT_IRS_SEP = '+inttostr(prv_Sep)+' AND FAT_IRS_ID='+inttostr(Prv_ID)+' AND FAT_IRS_SID='+inttostr(prv_SID));
      qryDeg.Open;
      qryDeg.Edit;
      qryDeg.FieldByName('YAZILDI').AsInteger:=1;
      qryDeg.Post;
      qryDeg.Active:=False;
end;

if prv_Yazdirma_No=2 then
begin
      DataMod.CreateQuery(qryDeg,Nil,True,DataMod.dbaMain);
      qryDeg.Active:=False;
      qryDeg.SQL.Clear;
      qryDeg.SQL.Add('SELECT * FROM SIPARIS WHERE FAT_IRS_SEP = 1 AND FAT_IRS_ID='+inttostr(prv_ID)+' AND FAT_IRS_SID='+inttostr(prv_SID));
      qryDeg.Open;
      qryDeg.Edit;
      qryDeg.FieldByName('YAZILDI').AsInteger:=1;
      qryDeg.Post;
      qryDeg.Active:=False;
end;


prv_Yazdirma_No:=0;

end;

procedure TYazici.qryFaturaD_TranCalcFields(DataSet: TDataSet);
begin
{  if DataSet.Active then
  begin
       if qryFaturaD_Tran.Eof then

         DataSet.FieldByName('Son_Kayit').AsInteger:=0
         else
         DataSet.FieldByName('Son_Kayit').AsInteger:=1;
  end;}
end;

procedure TYazici.qryKOMISYONCalcFields(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
       DataSet.FieldByName('CL_YAZ_UCRET').AsString := YeniParam(Dataset.FieldByName('TOPLAM_UCRET').AsCurrency);
       DataSet.FieldByName('CL_YAZ_KOM').AsString := YeniParam(Dataset.FieldByName('KOMISYON_UCRET').AsCurrency);
  end;
end;

end.
