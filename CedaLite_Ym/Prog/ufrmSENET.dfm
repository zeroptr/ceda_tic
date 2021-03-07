object frmSENET: TfrmSENET
  Left = 423
  Top = 194
  ActiveControl = pnlSENET
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Senet '#304#351'lemleri'
  ClientHeight = 329
  ClientWidth = 557
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 299
    Width = 557
    Height = 30
    Align = alBottom
    TabOrder = 0
    object btnYeni: TBitBtn
      Left = 5
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 0
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnAra: TBitBtn
      Left = 425
      Top = 3
      Width = 62
      Height = 25
      Caption = '&Ara'
      TabOrder = 1
      OnClick = btnAraClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
    object btnCikis: TBitBtn
      Left = 492
      Top = 3
      Width = 61
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 2
      OnClick = btnCIKISClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 69
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 3
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 163
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 4
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 244
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 5
      Visible = False
      OnClick = btnSILClick
    end
  end
  object pnlSENET: TPanel
    Left = 0
    Top = 0
    Width = 557
    Height = 295
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object rd_ASIL: TIB_RadioGroup
      Left = 300
      Top = 56
      Width = 88
      Height = 21
      DataField = 'ASIL'
      DataSource = dts_SENET
      TabOrder = 8
      OnEnter = rd_ASILEnter
      OnExit = rd_ASILExit
      Columns = 2
      Items.Strings = (
        'Ciro'
        'As'#305'l')
      Values.Strings = (
        '0'
        '1')
    end
    object IB_Date1: TIB_Date
      Left = 116
      Top = 16
      Width = 90
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'ISLEMTAR'
      DataSource = dts_SENET
      TabOrder = 2
      OnEnter = IB_Date1Enter
      OnExit = IB_Date1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Edit1: TIB_Edit
      Left = 395
      Top = 56
      Width = 146
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'TANZIM_YER'
      DataSource = dts_SENET
      TabOrder = 9
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
    end
    object IB_Edit2: TIB_Edit
      Left = 188
      Top = 96
      Width = 132
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KEFIL_1'
      DataSource = dts_SENET
      TabOrder = 11
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
    end
    object txt_SENETSahibi: TIB_Edit
      Left = 6
      Top = 95
      Width = 171
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'SENET_SAHIBI'
      DataSource = dts_SENET
      TabOrder = 10
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
    end
    object IB_Date2: TIB_Date
      Left = 212
      Top = 16
      Width = 90
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'TANZIMTAR'
      DataSource = dts_SENET
      TabOrder = 3
      OnEnter = IB_Date1Enter
      OnExit = IB_Date1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Date3: TIB_Date
      Left = 468
      Top = 96
      Width = 76
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'VADETAR'
      DataSource = dts_SENET
      TabOrder = 13
      OnEnter = IB_Date1Enter
      OnExit = IB_Date1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Edit7: TIB_Edit
      Left = 207
      Top = 168
      Width = 337
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'ACIKLAMA'
      DataSource = dts_SENET
      TabOrder = 20
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
    end
    object edt_tutar: TIB_Currency
      Left = 196
      Top = 132
      Width = 150
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'TUTAR'
      DataSource = dts_SENET
      TabOrder = 16
      OnEnter = edt_DovkurEnter
      OnExit = edt_tutarExit
      AlwaysShowButton = True
    end
    object IB_Date7: TIB_Date
      Left = 312
      Top = 16
      Width = 90
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'FIILI_TAR'
      DataSource = dts_SENET
      TabOrder = 4
      OnEnter = IB_Date1Enter
      OnExit = IB_Date1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Date8: TIB_Date
      Left = 408
      Top = 16
      Width = 89
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'DOV_BAZ_TAR'
      DataSource = dts_SENET
      TabOrder = 5
      OnEnter = IB_Date1Enter
      OnExit = IB_Date1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object edt_Dovkur: TIB_Currency
      Left = 104
      Top = 132
      Width = 82
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'DOVKUR'
      DataSource = dts_SENET
      TabOrder = 15
      OnEnter = edt_DovkurEnter
      OnExit = edt_DovkurExit
      AlwaysShowButton = True
    end
    object IB_Currency3: TIB_Currency
      Left = 356
      Top = 132
      Width = 188
      Height = 21
      TabStop = False
      DataField = 'TUTAR_VPB'
      DataSource = dts_SENET
      Color = clScrollBar
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      AlwaysShowButton = True
    end
    object cmb_Durum: TIB_ComboBox
      Left = 104
      Top = 170
      Width = 94
      Height = 22
      AutoLabel.Kind = albTop
      DataField = 'DURUM'
      DataSource = dts_SENET
      Color = clScrollBar
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      TabStop = False
      Style = csOwnerDrawVariable
      ItemHeight = 16
      Items.Strings = (
        'Beklemede'
        #214'denmi'#351
        'Protestolu'
        #304'ptal')
      ItemValues.Strings = (
        '1'
        '2'
        '3'
        '4')
    end
    object cmb_YerKod: TIB_ComboBox
      Left = 4
      Top = 170
      Width = 94
      Height = 22
      AutoLabel.Kind = albTop
      DataField = 'YER_KOD'
      DataSource = dts_SENET
      Color = clScrollBar
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      TabStop = False
      Style = csOwnerDrawVariable
      ItemHeight = 16
      Items.Strings = (
        'Portf'#246'yde'
        'Ciro'
        'Tahsil'
        'Teminat')
      ItemValues.Strings = (
        '1'
        '2'
        '3'
        '4')
    end
    object txtCARI_KOD: TIB_Edit
      Left = 8
      Top = 57
      Width = 84
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'CARI_KOD'
      DataSource = dts_SENET
      TabOrder = 6
      OnEnter = txtCARI_KODEnter
      OnExit = txtCARI_KODExit
      OnKeyDown = txtCARI_KODKeyDown
      OnKeyPress = IB_Edit4KeyPress
      ButtonStyle = ebsEllipsis
      OnButtonClick = txtCARI_KODButtonClick
    end
    object txtCARI_AD: TIB_Edit
      Left = 100
      Top = 57
      Width = 192
      Height = 21
      TabStop = False
      AutoLabel.Kind = albTop
      DataField = 'CARI_ADD'
      DataSource = dts_SENET
      Enabled = False
      ReadOnly = True
      TabOrder = 7
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
    end
    object IB_Edit4: TIB_Edit
      Left = 8
      Top = 14
      Width = 40
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'SENET_ID'
      DataSource = dts_SENET
      Enabled = False
      TabOrder = 0
    end
    object IB_Edit5: TIB_Edit
      Left = 60
      Top = 14
      Width = 44
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'SENET_SID'
      DataSource = dts_SENET
      Enabled = False
      TabOrder = 1
    end
    object txtPROJE_KOD: TIB_Edit
      Left = 4
      Top = 205
      Width = 84
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'PROJE_KOD'
      DataSource = dts_SENET
      TabOrder = 21
      OnEnter = txtCARI_ADEnter
      OnExit = txtPROJE_KODExit
      OnKeyDown = txtPROJE_KODKeyDown
      OnKeyPress = IB_Edit4KeyPress
      ButtonStyle = ebsEllipsis
      OnButtonClick = txtPROJE_KODButtonClick
    end
    object txtPROJE_AD: TIB_Edit
      Left = 96
      Top = 205
      Width = 148
      Height = 21
      TabStop = False
      AutoLabel.Kind = albTop
      DataField = 'PROJE_AD'
      DataSource = dts_SENET
      Enabled = False
      ReadOnly = True
      TabOrder = 22
    end
    object txtPLASIYER_KOD: TIB_Edit
      Left = 256
      Top = 205
      Width = 84
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'PLASIYER_KOD'
      DataSource = dts_SENET
      TabOrder = 23
      OnEnter = txtCARI_ADEnter
      OnExit = txtPLASIYER_KODExit
      OnKeyDown = txtPLASIYER_KODKeyDown
      OnKeyPress = IB_Edit4KeyPress
      ButtonStyle = ebsEllipsis
      OnButtonClick = txtPLASIYER_KODButtonClick
    end
    object txtPLASIYER_AD: TIB_Edit
      Left = 348
      Top = 205
      Width = 196
      Height = 21
      TabStop = False
      AutoLabel.Kind = albTop
      DataField = 'PLASIYER_AD'
      DataSource = dts_SENET
      Enabled = False
      ReadOnly = True
      TabOrder = 25
    end
    object IB_Edit3: TIB_Edit
      Left = 328
      Top = 96
      Width = 132
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'KEFIL_2'
      DataSource = dts_SENET
      TabOrder = 12
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
    end
    object cboDOVKOD: TIB_ComboBox
      Left = 6
      Top = 132
      Width = 89
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'D'#246'viz Kodu'
      DataField = 'DOVKOD'
      DataSource = dts_SENET
      TabOrder = 14
      OnEnter = cboDOVKODEnter
      OnExit = cboDOVKODExit
      Style = csDropDownList
      ItemHeight = 13
    end
    object grpRapKod: TGroupBox
      Left = 6
      Top = 234
      Width = 539
      Height = 55
      TabOrder = 24
      object IB_Edit8: TIB_Edit
        Left = 10
        Top = 22
        Width = 83
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = #304#351'lem Merkezi'
        DataField = 'MASRAF_MERK'
        DataSource = dts_SENET
        TabOrder = 0
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit8Exit
        OnKeyUp = IB_Edit8KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit8ButtonClick
      end
      object IB_Edit10: TIB_Edit
        Left = 118
        Top = 22
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD1'
        DataSource = dts_SENET
        TabOrder = 1
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit10Exit
        OnKeyUp = IB_Edit10KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit10ButtonClick
      end
      object IB_Edit11: TIB_Edit
        Left = 226
        Top = 22
        Width = 81
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD2'
        DataSource = dts_SENET
        TabOrder = 2
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit11Exit
        OnKeyUp = IB_Edit11KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit11ButtonClick
      end
      object IB_Edit12: TIB_Edit
        Left = 334
        Top = 22
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD3'
        DataSource = dts_SENET
        TabOrder = 3
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit12Exit
        OnKeyUp = IB_Edit12KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit12ButtonClick
      end
      object IB_Edit13: TIB_Edit
        Left = 446
        Top = 22
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD4'
        DataSource = dts_SENET
        TabOrder = 4
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit13Exit
        OnKeyUp = IB_Edit13KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit13ButtonClick
      end
    end
  end
  object qry_SENET: TIB_Query
    ColumnAttributes.Strings = (
      'TUTAR=CURRENCY'
      'DOVKUR=CURRENCY'
      'TUTAR_VPB=CURRENCY'
      'CARI_KODD=COMPUTED'
      'CARI_ADD=COMPUTED'
      'PROJE_AD=COMPUTED'
      'PLASIYER_AD=COMPUTED')
    DatabaseName = 'C:\project13100\DB\bos.FDB'
    FieldsDisplayLabel.Strings = (
      'SENET_KOD='#199'ek Kodu'
      'IADE_TAR='#304'ade Edildi'#287'i Tarih :'
      'IADE_CHAR_ACK='#304'ade A'#231#305'klamas'#305' :'
      'KARSILIKSIZ_TAR=Kar'#351#305'l'#305'ks'#305'z '#199#305'kt'#305#287#305' Tarih :'
      'KARSILIKSIZ_ACK=Kar'#351#305'l'#305'ks'#305'z '#199'ek A'#231#305'klamas'#305' :'
      'FIILI_TAR=Fiili Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tarihi'
      'DURUM=Durum'
      'ISLEMTAR='#304#351'lem Tarihi'
      'TANZIMTAR=Tanzim Tarihi'
      'VADETAR=Vade Tarihi'
      'SENET_SAHIBI=Senet Sahibi'
      'BANKA_AD=Banka Ad'#305
      'HESAP_NO=Hesap No'
      'TUTAR=Tutar'
      'DOVKUR=Kur'
      'DOVKOD=Para Birimi'
      'YER_KOD=Yer Kodu'
      'ACIKLAMA=A'#231#305'klama'
      'ASIL=As'#305'l'
      'TUTAR_VPB=Tutar VPB'
      'CARI_KODD=Cari Kodu'
      'CARI_ADD=Cari Ad'#305
      'CARI_KOD=Cari Kod'
      'SENET_ID=Senet No'
      'SENET_SID=Senet Sube'
      'PROJE_KOD=Proje Kodu'
      'PLASIYER_KOD=Plasiyer Kodu'
      'PROJE_AD=Proje Ad'
      'PLASIYER_AD=Plasiyer Ad'
      'TANZIM_YER=Tanzim Yeri'
      'KEFIL_1=Kefil 1'
      'KEFIL_2=Kefil 2')
    FieldsVisible.Strings = (
      'CS_BORDRO_ID=FALSE'
      'CS_BORDRO_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trn_SENET
    SQL.Strings = (
      'SELECT SENET_ID'
      '     , SENET_SID'
      '     , CARI_KOD'
      
        '     , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = SENET.CAR' +
        'I_KOD) AS CARI_ADD'
      '     , ISLEMTAR'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , SENET_SAHIBI'
      '     , TANZIMTAR'
      '     , VADETAR'
      '     , ODEME_TAR'
      '     , TANZIM_YER'
      '     , KEFIL_1'
      '     , KEFIL_2'
      '     , TUTAR'
      '     , DOVKUR'
      '     , DOVKOD'
      '     , DURUM'
      '     , YER_KOD'
      '     , TIP'
      '     , ACIKLAMA'
      '     , ASIL'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , TUTAR_VPB'
      '     , PROJE_KOD'
      
        '     , (SELECT PROJE.PROJE_AD FROM PROJE WHERE PROJE.PROJE_KOD =' +
        ' SENET.PROJE_KOD) AS PROJE_AD'
      '     , PLASIYER_KOD'
      
        '     , (SELECT PLASIYER.ADISOY FROM PLASIYER WHERE PLASIYER.PLAS' +
        'IYER_KOD = SENET.PLASIYER_KOD) AS PLASIYER_AD'
      '     , CS_BORDRO_ID'
      '     , CS_BORDRO_SID'
      'FROM SENET '
      'WHERE SENET_ID = :PRM_SENET_ID AND SENET_SID = :PRM_SENET_SID')
    ColorScheme = False
    DefaultValues.Strings = (
      'BORDRO_NO=0'
      'BORDRO_SID=0'
      'SENETCIRO_ID=0'
      'SENETCIRO_SID=0'
      'DURUM=1'
      'BORDRO_ID=0'
      'GIR_BORDRO_ID=0'
      'GIR_BORDRO_SID=0'
      'CIK_BORDRO_ID=0'
      'CIK_BORDRO_SID=0'
      'CS_BORDRO_ID=0'
      'CS_BORDRO_SID=0')
    GeneratorLinks.Strings = (
      'SENET.SENET_ID=GEN_SENET')
    KeyLinks.Strings = (
      'SENET.SENET_ID'
      'SENET.SENET_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 234
    Top = 162
    ParamValues = (
      'PRM_SENET_ID=0')
  end
  object dts_SENET: TIB_DataSource
    AutoInsert = False
    Dataset = qry_SENET
    OnDataChange = dts_SENETDataChange
    OnStateChanged = dts_SENETStateChanged
    Left = 236
    Top = 100
  end
  object trn_SENET: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 236
    Top = 44
  end
end
