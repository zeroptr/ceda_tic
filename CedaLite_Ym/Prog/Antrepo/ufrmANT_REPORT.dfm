object frmANT_REPORT: TfrmANT_REPORT
  Left = 0
  Top = 0
  Caption = 'Rapor Kriterleri'
  ClientHeight = 87
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 311
    Height = 46
    Align = alTop
    Caption = 'Tarih Aral'#305#287#305
    TabOrder = 0
    object dtpIslemTar1: TDateTimePicker
      Left = 14
      Top = 16
      Width = 100
      Height = 21
      Date = 37554.733220983800000000
      Time = 37554.733220983800000000
      Checked = False
      TabOrder = 0
    end
    object dtpIslemTar2: TDateTimePicker
      Left = 131
      Top = 15
      Width = 100
      Height = 21
      Date = 37554.733416122690000000
      Time = 37554.733416122690000000
      Checked = False
      TabOrder = 1
    end
  end
  object chk_Sirket: TCheckBox
    Left = 18
    Top = 175
    Width = 213
    Height = 17
    Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
    Checked = True
    State = cbChecked
    TabOrder = 1
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 54
    Width = 311
    Height = 33
    Align = alBottom
    TabOrder = 2
    object btnRapor: TButton
      Left = 5
      Top = 4
      Width = 76
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      Visible = False
    end
    object Button3: TButton
      Left = 192
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 4
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = Btn_FastClick
    end
  end
  object frxReport1: TfrxReport
    Version = '4.7.181'
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
    ReportOptions.LastChange = 41675.637769085600000000
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
    Left = 256
    Top = 15
  end
  object qryANT_MAIN: TIBOQuery
    Params = <
      item
        DataType = ftInteger
        Name = 'PRM_ANT_DETAIL_ID'
        ParamType = ptInput
      end>
    DatabaseName = 'C:\ekinci_deg\EKINCI2013.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
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
    FieldOptions = []
    Left = 76
    Top = 12
  end
  object qryANT_DETAIL: TIBOQuery
    Params = <>
    DatabaseName = 'C:\ekinci_deg\EKINCI2013.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
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
    FieldOptions = []
    Left = 20
    Top = 88
  end
  object qrySIRKET: TIBOQuery
    Params = <
      item
        DataType = ftUnknown
        Name = 'PRM_SIRKET_ID'
        ParamType = ptUnknown
      end>
    IB_Connection = DataMod.dbaANA
    KeyLinks.Strings = (
      'SIRKET.SIRKET_ID')
    RecordCountAccurate = True
    SQL.Strings = (
      'SELECT *'
      'FROM SIRKET'
      'WHERE SIRKET_ID =:PRM_SIRKET_ID;')
    FieldOptions = []
    Left = 24
    Top = 132
  end
  object qryARDIYE: TIBOQuery
    Params = <>
    DatabaseName = 'C:\ekinci_deg\EKINCI2013.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
    SQL.Strings = (
      'SELECT *'
      'FROM ARDIYE')
    FieldOptions = []
    Left = 28
    Top = 188
  end
  object frxANT_MAIN: TfrxDBDataset
    UserName = 'frxANT_MAIN'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ANT_MAIN_ID=ANT_MAIN_ID'
      'ANT_DETAIL_ID=ANT_DETAIL_ID'
      'DEF_SIRA_NO=DEF_SIRA_NO'
      'TARIH=TARIH'
      'TASIYAN_ID=TASIYAN_ID'
      'OZET_BEYAN_NO=OZET_BEYAN_NO'
      'CIK_KAP=CIK_KAP'
      'CIK_KILO=CIK_KILO'
      'GUM_VEZ_NO=GUM_VEZ_NO'
      'GUM_KOM_KOD=GUM_KOM_KOD'
      'GUM_KOM_AD=GUM_KOM_AD')
    DataSet = qryANT_MAIN
    BCDToCurrency = False
    Left = 180
    Top = 12
  end
  object frxANT_DETAIL: TfrxDBDataset
    UserName = 'frxANT_DETAIL'
    CloseDataSource = False
    DataSet = qryANT_DETAIL
    BCDToCurrency = False
    Left = 124
    Top = 88
  end
  object frxSIRKET: TfrxDBDataset
    UserName = 'frxSIRKET'
    CloseDataSource = False
    FieldAliases.Strings = (
      'SIRKET_ID=SIRKET_ID'
      'SIRKET_AD=SIRKET_AD'
      'YETKILI=YETKILI'
      'ADRES_1=ADRES_1'
      'ADRES_2=ADRES_2'
      'ILCE=ILCE'
      'SEHIR=SEHIR'
      'PK=PK'
      'TEL1=TEL1'
      'TEL2=TEL2'
      'FAX=FAX'
      'VERDAIRE=VERDAIRE'
      'VERNO=VERNO'
      'LOGO=LOGO'
      'TOPLAM_SUBE_ADET=TOPLAM_SUBE_ADET'
      'TIC_SIC_NO=TIC_SIC_NO'
      'TIC_ODA_NO=TIC_ODA_NO'
      'SSK_SIC_NO=SSK_SIC_NO'
      'AKTIF=AKTIF')
    DataSet = qrySIRKET
    BCDToCurrency = False
    Left = 128
    Top = 132
  end
  object frxARDIYE: TfrxDBDataset
    UserName = 'frxARDIYE'
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
      'OUT_G_KALAN_KAP=OUT_G_KALAN_KAP'
      'OUT_G_KALAN_KILO=OUT_G_KALAN_KILO'
      'OUT_G_GUN=OUT_G_GUN'
      'OUT_G_ARDIYE_B_FIY=OUT_G_ARDIYE_B_FIY'
      'OUT_G_ARDIYE_DOVKOD=OUT_G_ARDIYE_DOVKOD'
      'OUT_G_HAMMALIYE_B_F=OUT_G_HAMMALIYE_B_F'
      'OUT_G_HAMM_DOVKOD=OUT_G_HAMM_DOVKOD'
      'OUT_G_HAMMALIYE=OUT_G_HAMMALIYE'
      'OUT_G_ARDIYE=OUT_G_ARDIYE'
      'OUT_G_TOPLAM=OUT_G_TOPLAM'
      'OUT_G_BEYAN_NO=OUT_G_BEYAN_NO'
      'OUT_G_BEYAN_TAR=OUT_G_BEYAN_TAR')
    DataSet = qryARDIYE
    BCDToCurrency = False
    Left = 124
    Top = 188
  end
  object qryANT_REPORT: TIBOQuery
    Params = <>
    DatabaseName = 'C:\ekinci_deg\EKINCI2013.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
    SQL.Strings = (
      'SELECT *'
      'FROM ANT_RAPOR(4)')
    FieldOptions = []
    Left = 20
    Top = 236
  end
  object frxANT_RAPOR: TfrxDBDataset
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
    DataSet = qryANT_REPORT
    BCDToCurrency = False
    Left = 116
    Top = 236
  end
  object qryBEY_TEKLIKE: TIBOQuery
    Params = <
      item
        DataType = ftUnknown
        Name = 'TAR1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TAR2'
        ParamType = ptUnknown
      end>
    DatabaseName = 'C:\ekinci_deg\EKINCI2013.FDB'
    IB_Connection = DataMod.dbaMain
    RecordCountAccurate = True
    SQL.Strings = (
      'SELECT ANT_MAIN.ANT_MAIN_ID'
      '      , ANT_DETAIL.ANT_DETAIL_ID'
      '      , ANT_MAIN.DEF_SIRA_NO'
      '      , ANT_MAIN.TARIH'
      '      , ANT_MAIN.TASIYAN_ID'
      '      , ANT_MAIN.OZET_BEYAN_NO'
      '      , ANT_MAIN.OZET_BEYAN_TAR'
      '      , ANT_DETAIL.KONSIMENTO'
      '      , ANT_DETAIL.CARI_KOD'
      '      , ANT_DETAIL.CARI_AD'
      '      , ANT_DETAIL.KAP_ADET'
      '      , ANT_DETAIL.KILO'
      '      , ANT_DETAIL.ESYA'
      'FROM ANT_DETAIL'
      
        'INNER JOIN ANT_MAIN ON (ANT_DETAIL.ANT_MAIN_ID = ANT_MAIN.ANT_MA' +
        'IN_ID)'
      
        'WHERE (LTRIM(RTRIM(ANT_DETAIL.ANT_BEYAN_NO)) = '#39#39') AND (ANT_DETA' +
        'IL.KALAN_KAP <> 0) AND  '
      
        '((ANT_MAIN.TASIYAN = 1 AND (CURRENT_DATE >= (ANT_MAIN.TARIH + 15' +
        '))) or'
      
        '(ANT_MAIN.TASIYAN = 2 AND (CURRENT_DATE >= (ANT_MAIN.TARIH + 40)' +
        '))  )'
      'AND (ANT_MAIN.TARIH BETWEEN :TAR1 and :TAR2)'
      
        'ORDER BY ANT_MAIN.DEVIR DESCENDING, ANT_MAIN.DEF_SIRA_NO, ANT_DE' +
        'TAIL.ANT_DETAIL_ID')
    FieldOptions = []
    Left = 28
    Top = 284
  end
  object frxBEY_TEKLIKE: TfrxDBDataset
    UserName = 'frxBEY_TEKLIKE'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ANT_MAIN_ID=ANT_MAIN_ID'
      'ANT_DETAIL_ID=ANT_DETAIL_ID'
      'DEF_SIRA_NO=DEF_SIRA_NO'
      'TARIH=TARIH'
      'TASIYAN_ID=TASIYAN_ID'
      'OZET_BEYAN_NO=OZET_BEYAN_NO'
      'OZET_BEYAN_TAR=OZET_BEYAN_TAR'
      'KONSIMENTO=KONSIMENTO'
      'CARI_KOD=CARI_KOD'
      'CARI_AD=CARI_AD'
      'KAP_ADET=KAP_ADET'
      'KILO=KILO'
      'ESYA=ESYA')
    DataSet = qryBEY_TEKLIKE
    BCDToCurrency = False
    Left = 124
    Top = 284
  end
end
