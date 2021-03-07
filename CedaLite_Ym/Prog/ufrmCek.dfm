object frm_Cek: Tfrm_Cek
  Left = 298
  Top = 330
  ActiveControl = pnlCEK
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #199'ek '#304#351'lemleri'
  ClientHeight = 361
  ClientWidth = 535
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
  object pnlCEK: TPanel
    Left = 0
    Top = 0
    Width = 535
    Height = 361
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object rd_ASIL: TIB_RadioGroup
      Left = 404
      Top = 56
      Width = 120
      Height = 21
      DataField = 'ASIL'
      DataSource = dts_Cek
      TabOrder = 9
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
      DataSource = dts_Cek
      TabOrder = 2
      OnEnter = IB_Date1Enter
      OnExit = IB_Date1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Edit1: TIB_Edit
      Left = 99
      Top = 92
      Width = 157
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'BANKA_AD'
      DataSource = dts_Cek
      Enabled = False
      TabOrder = 11
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
      OnKeyPress = IB_Edit4KeyPress
    end
    object IB_Edit2: TIB_Edit
      Left = 260
      Top = 92
      Width = 76
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'HESAP_NO'
      DataSource = dts_Cek
      TabOrder = 12
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
    end
    object IB_Edit3: TIB_Edit
      Left = 300
      Top = 56
      Width = 98
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'CEK_NUM'
      DataSource = dts_Cek
      TabOrder = 8
      OnEnter = txtCARI_ADEnter
      OnExit = IB_Edit3Exit
    end
    object txt_CekSahibi: TIB_Edit
      Left = 337
      Top = 92
      Width = 104
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'CEK_SAHIBI'
      DataSource = dts_Cek
      TabOrder = 13
      OnEnter = txtCARI_ADEnter
      OnExit = txtCARI_ADExit
      OnKeyPress = IB_Edit4KeyPress
    end
    object IB_Date2: TIB_Date
      Left = 212
      Top = 16
      Width = 90
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'TANZIMTAR'
      DataSource = dts_Cek
      TabOrder = 3
      OnEnter = IB_Date1Enter
      OnExit = IB_Date1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Date3: TIB_Date
      Left = 444
      Top = 92
      Width = 90
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'VADETAR'
      DataSource = dts_Cek
      TabOrder = 14
      OnEnter = IB_Date1Enter
      OnExit = IB_Date1Exit
      IncCellHeight = 1
      IncCellWidth = 2
      DrawYearArrow = False
    end
    object IB_Edit7: TIB_Edit
      Left = 204
      Top = 168
      Width = 325
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'ACIKLAMA'
      DataSource = dts_Cek
      TabOrder = 21
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
      DataSource = dts_Cek
      TabOrder = 17
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
      DataSource = dts_Cek
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
      DataSource = dts_Cek
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
      DataSource = dts_Cek
      TabOrder = 16
      OnEnter = edt_DovkurEnter
      OnExit = edt_DovkurExit
      AlwaysShowButton = True
    end
    object IB_Currency3: TIB_Currency
      Left = 360
      Top = 132
      Width = 168
      Height = 21
      TabStop = False
      DataField = 'TUTAR_VPB'
      DataSource = dts_Cek
      Color = clScrollBar
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      AlwaysShowButton = True
    end
    object cmb_Durum: TIB_ComboBox
      Left = 104
      Top = 170
      Width = 94
      Height = 22
      AutoLabel.Kind = albTop
      DataField = 'DURUM'
      DataSource = dts_Cek
      Color = clScrollBar
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 20
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
      DataSource = dts_Cek
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
      DataSource = dts_Cek
      TabOrder = 6
      OnEnter = txtCARI_ADEnter
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
      DataSource = dts_Cek
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
      DataField = 'CEK_ID'
      DataSource = dts_Cek
      Enabled = False
      TabOrder = 0
    end
    object IB_Edit5: TIB_Edit
      Left = 60
      Top = 14
      Width = 44
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'CEK_SID'
      DataSource = dts_Cek
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
      DataSource = dts_Cek
      TabOrder = 22
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
      DataSource = dts_Cek
      Enabled = False
      ReadOnly = True
      TabOrder = 23
    end
    object txtPLASIYER_KOD: TIB_Edit
      Left = 256
      Top = 205
      Width = 84
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'PLASIYER_KOD'
      DataSource = dts_Cek
      TabOrder = 24
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
      Width = 181
      Height = 21
      TabStop = False
      AutoLabel.Kind = albTop
      DataField = 'PLASIYER_AD'
      DataSource = dts_Cek
      Enabled = False
      ReadOnly = True
      TabOrder = 26
    end
    object IB_Edit6: TIB_Edit
      Left = 8
      Top = 93
      Width = 84
      Height = 21
      AutoLabel.Kind = albTop
      DataField = 'BANKA_KOD'
      DataSource = dts_Cek
      TabOrder = 10
      OnEnter = txtCARI_ADEnter
      OnExit = IB_Edit6Exit
      OnKeyDown = IB_Edit6KeyDown
      OnKeyPress = IB_Edit4KeyPress
      ButtonStyle = ebsEllipsis
      OnButtonClick = IB_Edit6ButtonClick
    end
    object Panel1: TPanel
      Left = 0
      Top = 331
      Width = 535
      Height = 30
      Align = alBottom
      TabOrder = 27
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
        Left = 400
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
        Left = 465
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
    object rgYAZICI: TRadioGroup
      Left = 2
      Top = 291
      Width = 425
      Height = 31
      Caption = 'Yazd'#305'rma'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Yazd'#305'r'
        #214'n '#304'zleme'
        'Sadece Kay'#305't')
      TabOrder = 28
      OnEnter = rgYAZICIEnter
      OnExit = rgYAZICIExit
    end
    object cboDOVKOD: TIB_ComboBox
      Left = 5
      Top = 132
      Width = 89
      Height = 21
      AutoLabel.Kind = albTop
      AutoLabel.Caption = 'D'#246'viz Kodu'
      DataField = 'DOVKOD'
      DataSource = dts_Cek
      TabOrder = 15
      OnEnter = cboDOVKODEnter
      OnExit = cboDOVKODExit
      Style = csDropDownList
      ItemHeight = 13
    end
    object btnCikti: TButton
      Left = 431
      Top = 296
      Width = 100
      Height = 26
      Caption = 'Yaz'#305'c'#305' '#199#305'kt'#305's'#305
      TabOrder = 29
      TabStop = False
      OnClick = btnCiktiClick
    end
    object grpRapKod: TGroupBox
      Left = 3
      Top = 230
      Width = 528
      Height = 58
      TabOrder = 25
      object IB_Edit8: TIB_Edit
        Left = 16
        Top = 25
        Width = 83
        Height = 21
        AutoLabel.Kind = albTop
        AutoLabel.Caption = #304#351'lem Merkezi'
        DataField = 'MASRAF_MERK'
        DataSource = dts_Cek
        TabOrder = 0
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit8Exit
        OnKeyUp = IB_Edit8KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit8ButtonClick
      end
      object IB_Edit10: TIB_Edit
        Left = 116
        Top = 25
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD1'
        DataSource = dts_Cek
        TabOrder = 1
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit10Exit
        OnKeyUp = IB_Edit10KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit10ButtonClick
      end
      object IB_Edit11: TIB_Edit
        Left = 220
        Top = 25
        Width = 81
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD2'
        DataSource = dts_Cek
        TabOrder = 2
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit11Exit
        OnKeyUp = IB_Edit11KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit11ButtonClick
      end
      object IB_Edit12: TIB_Edit
        Left = 323
        Top = 24
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD3'
        DataSource = dts_Cek
        TabOrder = 3
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit12Exit
        OnKeyUp = IB_Edit12KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit12ButtonClick
      end
      object IB_Edit13: TIB_Edit
        Left = 427
        Top = 23
        Width = 85
        Height = 21
        AutoLabel.Kind = albTop
        DataField = 'KOD4'
        DataSource = dts_Cek
        TabOrder = 4
        OnEnter = txtCARI_ADEnter
        OnExit = IB_Edit13Exit
        OnKeyUp = IB_Edit13KeyUp
        ButtonStyle = ebsEllipsis
        OnButtonClick = IB_Edit13ButtonClick
      end
    end
  end
  object qry_Cek: TIB_Query
    ColumnAttributes.Strings = (
      'TUTAR=CURRENCY'
      'DOVKUR=CURRENCY'
      'TUTAR_VPB=CURRENCY'
      'CARI_KODD=COMPUTED'
      'CARI_ADD=COMPUTED'
      'PROJE_AD=COMPUTED'
      'PLASIYER_AD=COMPUTED')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'CEK_KOD='#199'ek Kodu'
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
      'CEK_SAHIBI='#199'ek Sahibi'
      'BANKA_AD=Banka Ad'#305
      'HESAP_NO=Hesap No'
      'CEK_NUM='#199'ek No'
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
      'CEK_ID='#199'ek No'
      'CEK_SID='#199'ek Sube'
      'PROJE_KOD=Proje Kodu'
      'PLASIYER_KOD=Plasiyer Kodu'
      'PROJE_AD=Proje Ad'
      'PLASIYER_AD=Plasiyer Ad'
      'BANKA_KOD=Banka Kod')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trn_Cek
    SQL.Strings = (
      'SELECT CEK_ID'
      '     , CEK_SID'
      '     , CARI_KOD'
      
        '     , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = CEK.CARI_' +
        'KOD) AS CARI_ADD'
      '     , ISLEMTAR'
      '     , TANZIMTAR'
      '     , VADETAR'
      '     , CEK_SAHIBI'
      '     , BANKA_KOD'
      '     , BANKA_AD'
      '     , HESAP_NO'
      '     , CEK_NUM'
      '     , TUTAR'
      '     , DOVKUR'
      '     , DOVKOD'
      '     , DURUM'
      '     , YER_KOD'
      '     , TIP'
      '     , ACIKLAMA'
      '     , ASIL'
      '     , ODEME_TAR'
      '     , TUTAR_VPB'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2 '
      '     , KOD3'
      '     , KOD4'
      '     , PROJE_KOD'
      
        '     , (SELECT PROJE.PROJE_AD FROM PROJE WHERE PROJE.PROJE_KOD =' +
        ' CEK.PROJE_KOD) AS PROJE_AD'
      '     , PLASIYER_KOD'
      
        '     , (SELECT PLASIYER.ADISOY FROM PLASIYER WHERE PLASIYER.PLAS' +
        'IYER_KOD = CEK.PLASIYER_KOD) AS PLASIYER_AD'
      '     , CS_BORDRO_ID'
      '     , CS_BORDRO_SID'
      'FROM CEK '
      'WHERE CEK_ID = :PRM_CEK_ID AND CEK_SID = :PRM_CEK_SID')
    ColorScheme = False
    DefaultValues.Strings = (
      'CEK_ID=0'
      'TUTAR=0'
      'DOVKUR=0'
      'DOVKOD=TRL'
      'TUTAR_VPB=0'
      'CS_BORDRO_ID=0'
      'CS_BORDRO_SID=0')
    GeneratorLinks.Strings = (
      'CEK.CEK_ID=GEN_CEK')
    KeyLinks.Strings = (
      'CEK.CEK_ID'
      'CEK.CEK_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 240
    Top = 88
    ParamValues = (
      'PRM_CEK_ID=0')
  end
  object dts_Cek: TIB_DataSource
    AutoInsert = False
    Dataset = qry_Cek
    OnDataChange = dts_CekDataChange
    OnStateChanged = dts_CekStateChanged
    Left = 240
    Top = 142
  end
  object trn_Cek: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 242
    Top = 32
  end
end
