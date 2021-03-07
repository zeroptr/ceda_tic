object frmANT_REPORT: TfrmANT_REPORT
  Left = 0
  Top = 0
  Caption = 'frmANT_REPORT'
  ClientHeight = 287
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object qryANT_DETAIL: TIB_Query
    ColumnAttributes.Strings = (
      'YANICI=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'ANT_BEYAN_NO=Antrepo Bey. No'
      'ANT_BEYAN_TAR=Antrepo Bey. Tar'
      'KONSIMENTO=Kon'#351'imento No'
      'CARI_AD=Cari Ad'#305
      'CARI_KOD=Cari Kodu'
      'KAP_ADET=Kap Adet'
      'KILO=Kilo'
      'ESYA=E'#351'yan'#305'n Tan'#305'm'#305
      'YANICI=Yan'#305'c'#305
      'ARDIYE_FIY=Ardiye Fiyat'#305
      'ARD_DOVKOD=Para Birimi'
      'HAMM_DOVKOD=Para Birimi'
      'HAMMALIYE=Hammaliye')
    FieldsGridLabel.Strings = (
      'ANT_BEYAN_NO=Antrepo Bey. No'
      'KONSIMENTO=Kon'#351'imento No'
      'CARI_KOD=Cari Kodu'
      'CARI_AD=Cari Ad'#305
      'KAP_ADET=Kap Adet'
      'KILO=Kilo'
      'ESYA=E'#351'yan'#305'n Tan'#305'm'#305
      'YANICI=Yan'#305'c'#305
      'ARDIYE_FIY=Ardiye'
      'ARD_DOVKOD=Para Birimi'
      'HAMM_DOVKOD=Para Birimi'
      'HAMMALIYE=Hammaliye'
      'ANT_BEYAN_TAR=Antrepo Bey. Tar')
    FieldsDisplayWidth.Strings = (
      'CARI_KOD=64'
      'KONSIMENTO=86'
      'KAP_ADET=51'
      'KILO=73'
      'YANICI=36'
      'ARD_DOVKOD=54'
      'HAMM_DOVKOD=54'
      'ARDIYE_FIY=60'
      'HAMMALIYE=64'
      'CARI_AD=180'
      'ESYA=179')
    FieldsIndex.Strings = (
      'ANT_DETAIL_ID'
      'ANT_MAIN_ID'
      'ANT_BEYAN_NO'
      'ANT_BEYAN_TAR'
      'KONSIMENTO'
      'CARI_KOD'
      'CARI_AD'
      'KAP_ADET'
      'KILO'
      'ESYA'
      'YANICI'
      'ARDIYE_FIY'
      'ARD_DOVKOD'
      'HAMMALIYE'
      'HAMM_DOVKOD'
      'KALAN_KAP'
      'KALAN_KILO')
    FieldsVisible.Strings = (
      'ANT_DETAIL_ID=FALSE'
      'ANT_MAIN_ID=FALSE'
      'ANT_BEYAN_NO=FALSE'
      'ANT_BEYAN_TAR=FALSE'
      'KALAN_KAP=FALSE'
      'KALAN_KILO=FALSE'
      'ARD_DOVKOD=FALSE'
      'HAMM_DOVKOD=FALSE'
      'KAPANDI=FALSE'
      'CARI_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ANT_MAIN.ANT_MAIN_ID'
      '     , ANT_DETAIL.ANT_DETAIL_ID'
      '     , ANT_MAIN.DEF_SIRA_NO'
      '     , ANT_MAIN.TARIH'
      '     , ANT_MAIN.TASIYAN_ID'
      '     , ANT_MAIN.OZET_BEYAN_NO'
      '     , ANT_DETAIL.ANT_BEYAN_NO'
      '     , ANT_DETAIL.KONSIMENTO'
      '     , ANT_DETAIL.CARI_KOD'
      '     , ANT_DETAIL.CARI_AD'
      '     , ANT_DETAIL.KAP_ADET'
      '     , ANT_DETAIL.KILO'
      '     , ANT_DETAIL.KALAN_KAP'
      '     , ANT_DETAIL.KALAN_KILO'
      '     , ANT_DETAIL.ESYA'
      '     , ((CURRENT_DATE - ANT_MAIN.TARIH)+1) AS YASI'
      '     , ANT_MAIN.CIK_KAP'
      '     , ANT_MAIN.CIK_KILO'
      '     , GUM_VEZ_NO'
      '     , GUM_KOM_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI_KOD = ANT_MAIN.GUM_KO' +
        'M_KOD) AS GUM_KOM_AD'
      'FROM ANT_DETAIL'
      
        'INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MA' +
        'IN_ID)')
    ColorScheme = False
    DefaultValues.Strings = (
      'ANT_MAIN_ID=0'
      'DEF_SIRA_NO=0'
      'GIRIS_ANT_DETAIL_ID=0'
      'CIK_KILO=0'
      'FATURA_ID=0'
      'GUM_KOM_KOD=0'
      'ARD_DOVKOD=USD'
      'HAMM_DOVKOD=USD')
    KeyLinks.Strings = (
      'ANT_DETAIL.ANT_DETAIL_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 32
    Top = 96
  end
  object qryANT_MAIN: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ANT_MAIN.ANT_MAIN_ID'
      '     , ANT_DETAIL.ANT_DETAIL_ID     '
      '     , DEF_SIRA_NO'
      '     , ANT_MAIN.TARIH'
      '     , ANT_MAIN.TASIYAN_ID'
      '     , ANT_MAIN.OZET_BEYAN_NO'
      '     , ANT_MAIN.CIK_KAP'
      '     , ANT_MAIN.CIK_KILO'
      '     , GUM_VEZ_NO'
      '     , GUM_KOM_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI_KOD = ANT_MAIN.GUM_KO' +
        'M_KOD) AS GUM_KOM_AD'
      'FROM ANT_MAIN'
      
        'INNER JOIN ANT_DETAIL ON (ANT_MAIN.GIRIS_ANT_DETAIL_ID = ANT_DET' +
        'AIL.ANT_DETAIL_ID)'
      'WHERE ANT_MAIN.GIRIS_ANT_DETAIL_ID =:PRM_ANT_DETAIL_ID;')
    ColorScheme = False
    DefaultValues.Strings = (
      'ANT_MAIN_ID=0'
      'DEF_SIRA_NO=0'
      'GIRIS_ANT_DETAIL_ID=0'
      'CIK_KILO=0'
      'FATURA_ID=0'
      'GUM_KOM_KOD=0')
    KeyLinks.Strings = (
      'ANT_MAIN.ANT_MAIN_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 32
    Top = 40
  end
  object frxANT_MAIN: TfrxIBODataset
    UserName = 'frxANT_MAIN'
    CloseDataSource = False
    DataSet = qryANT_MAIN
    Left = 128
    Top = 40
  end
  object frxANT_DETAIL: TfrxIBODataset
    UserName = 'frxANT_DETAIL'
    CloseDataSource = False
    DataSet = qryANT_DETAIL
    Left = 128
    Top = 96
  end
  object frxReport1: TfrxReport
    Version = '4.7.61'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39139.806122685200000000
    ReportOptions.LastChange = 39891.451622893520000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Footer1OnAfterPrint(Sender: TfrxComponent);'
      'begin'
      ''
      'end;'
      ''
      'begin'
      '      '
      'end.')
    StoreInDFM = False
    OnClosePreview = frxReport1ClosePreview
    Left = 240
    Top = 151
  end
  object frxSIRKET: TfrxIBODataset
    UserName = 'frxSIRKET'
    CloseDataSource = False
    DataSet = qrySIRKET
    Left = 128
    Top = 160
  end
  object qrySIRKET: TIB_Query
    ColumnAttributes.Strings = (
      'YANICI=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'ANT_BEYAN_NO=Antrepo Bey. No'
      'ANT_BEYAN_TAR=Antrepo Bey. Tar'
      'KONSIMENTO=Kon'#351'imento No'
      'CARI_AD=Cari Ad'#305
      'CARI_KOD=Cari Kodu'
      'KAP_ADET=Kap Adet'
      'KILO=Kilo'
      'ESYA=E'#351'yan'#305'n Tan'#305'm'#305
      'YANICI=Yan'#305'c'#305
      'ARDIYE_FIY=Ardiye Fiyat'#305
      'ARD_DOVKOD=Para Birimi'
      'HAMM_DOVKOD=Para Birimi'
      'HAMMALIYE=Hammaliye')
    FieldsGridLabel.Strings = (
      'ANT_BEYAN_NO=Antrepo Bey. No'
      'KONSIMENTO=Kon'#351'imento No'
      'CARI_KOD=Cari Kodu'
      'CARI_AD=Cari Ad'#305
      'KAP_ADET=Kap Adet'
      'KILO=Kilo'
      'ESYA=E'#351'yan'#305'n Tan'#305'm'#305
      'YANICI=Yan'#305'c'#305
      'ARDIYE_FIY=Ardiye'
      'ARD_DOVKOD=Para Birimi'
      'HAMM_DOVKOD=Para Birimi'
      'HAMMALIYE=Hammaliye'
      'ANT_BEYAN_TAR=Antrepo Bey. Tar')
    FieldsDisplayWidth.Strings = (
      'CARI_KOD=64'
      'KONSIMENTO=86'
      'KAP_ADET=51'
      'KILO=73'
      'YANICI=36'
      'ARD_DOVKOD=54'
      'HAMM_DOVKOD=54'
      'ARDIYE_FIY=60'
      'HAMMALIYE=64'
      'CARI_AD=180'
      'ESYA=179')
    FieldsIndex.Strings = (
      'ANT_DETAIL_ID'
      'ANT_MAIN_ID'
      'ANT_BEYAN_NO'
      'ANT_BEYAN_TAR'
      'KONSIMENTO'
      'CARI_KOD'
      'CARI_AD'
      'KAP_ADET'
      'KILO'
      'ESYA'
      'YANICI'
      'ARDIYE_FIY'
      'ARD_DOVKOD'
      'HAMMALIYE'
      'HAMM_DOVKOD'
      'KALAN_KAP'
      'KALAN_KILO')
    FieldsVisible.Strings = (
      'ANT_DETAIL_ID=FALSE'
      'ANT_MAIN_ID=FALSE'
      'ANT_BEYAN_NO=FALSE'
      'ANT_BEYAN_TAR=FALSE'
      'KALAN_KAP=FALSE'
      'KALAN_KILO=FALSE'
      'ARD_DOVKOD=FALSE'
      'HAMM_DOVKOD=FALSE'
      'KAPANDI=FALSE'
      'CARI_KOD=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT *'
      'FROM SIRKET'
      'WHERE SIRKET_ID =:PRM_SIRKET_ID;')
    ColorScheme = False
    DefaultValues.Strings = (
      'ANT_MAIN_ID=0'
      'DEF_SIRA_NO=0'
      'GIRIS_ANT_DETAIL_ID=0'
      'CIK_KILO=0'
      'FATURA_ID=0'
      'GUM_KOM_KOD=0'
      'ARD_DOVKOD=USD'
      'HAMM_DOVKOD=USD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 32
    Top = 160
    ParamValues = (
      'PRM_SIRKET_ID=1')
  end
  object qryANT_RAPOR: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayWidth.Strings = (
      'OUT_G_ESYA=227')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT *'
      'FROM ANT_RAPOR(:PRM_RAPOR_TIP)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 32
    Top = 216
    ParamValues = (
      'PRM_RAPOR_TIP=4')
  end
  object frxANT_RAPOR: TfrxIBODataset
    UserName = 'frxANT_RAPOR'
    CloseDataSource = False
    FieldAliases.Strings = (
      'OUT_G_ANT_MAIN_ID=OUT_G_ANT_MAIN_ID'
      'OUT_G_ANT_DETAIL_ID=OUT_G_ANT_DETAIL_ID'
      'OUT_G_DEF_SIRA_NO=OUT_G_DEF_SIRA_NO'
      'OUT_G_TARIH=OUT_G_TARIH'
      'OUT_G_TASIYAN_ID=OUT_G_TASIYAN_ID'
      'OUT_G_OZET_BEYAN_NO=OUT_G_OZET_BEYAN_NO'
      'OUT_G_OZET_BEYAN_TAR=OUT_G_OZET_BEYAN_TAR'
      'OUT_G_ANT_BEYAN_NO=OUT_G_ANT_BEYAN_NO'
      'OUT_G_ANT_BEYAN_TAR=OUT_G_ANT_BEYAN_TAR'
      'OUT_G_KONSIMENTO=OUT_G_KONSIMENTO'
      'OUT_G_CARI_KOD=OUT_G_CARI_KOD'
      'OUT_G_CARI_AD=OUT_G_CARI_AD'
      'OUT_G_KAP_ADET=OUT_G_KAP_ADET'
      'OUT_G_KILO=OUT_G_KILO'
      'OUT_G_ESYA=OUT_G_ESYA'
      'OUT_C_DEF_SIRA_NO=OUT_C_DEF_SIRA_NO'
      'OUT_C_TARIH=OUT_C_TARIH'
      'OUT_C_CIK_BEYAN_NO=OUT_C_CIK_BEYAN_NO'
      'OUT_C_CIK_BEYAN_TAR=OUT_C_CIK_BEYAN_TAR'
      'OUT_C_GUM_VEZ_NO=OUT_C_GUM_VEZ_NO'
      'OUT_C_GUM_VEZ_TAR=OUT_C_GUM_VEZ_TAR'
      'OUT_C_KAP_BOL=OUT_C_KAP_BOL'
      'OUT_C_CIK_KAP=OUT_C_CIK_KAP'
      'OUT_C_CIK_KILO=OUT_C_CIK_KILO'
      'OUT_C_KALAN_KAP=OUT_C_KALAN_KAP'
      'OUT_C_KALAN_KILO=OUT_C_KALAN_KILO'
      'OUT_C_GUM_KOM_KOD=OUT_C_GUM_KOM_KOD'
      'OUT_C_GUM_KOM_AD=OUT_C_GUM_KOM_AD'
      'OUT_G_BEYAN_NO=OUT_G_BEYAN_NO'
      'OUT_G_BEYAN_TAR=OUT_G_BEYAN_TAR')
    DataSet = qryANT_RAPOR
    Left = 124
    Top = 220
  end
end
