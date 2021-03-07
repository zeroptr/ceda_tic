object frmPlasiyer: TfrmPlasiyer
  Left = 187
  Top = 191
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Plasiyer Tan'#305'mlama'
  ClientHeight = 318
  ClientWidth = 476
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
  object IB_Edit1: TIB_Edit
    Left = 60
    Top = 7
    Width = 92
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'PLASIYER_KOD'
    DataSource = dtsPlasiyer
    TabOrder = 0
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit2: TIB_Edit
    Left = 212
    Top = 7
    Width = 248
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADISOY'
    DataSource = dtsPlasiyer
    TabOrder = 1
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    OnKeyPress = IB_Edit2KeyPress
  end
  object IB_Edit4: TIB_Edit
    Left = 60
    Top = 104
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'TELNO_1'
    DataSource = dtsPlasiyer
    TabOrder = 7
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit5: TIB_Edit
    Left = 60
    Top = 128
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'TELNO_2'
    DataSource = dtsPlasiyer
    TabOrder = 8
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit6: TIB_Edit
    Left = 60
    Top = 152
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'FAX'
    DataSource = dtsPlasiyer
    TabOrder = 9
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit7: TIB_Edit
    Left = 60
    Top = 32
    Width = 400
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADRES_1'
    DataSource = dtsPlasiyer
    TabOrder = 2
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit8: TIB_Edit
    Left = 60
    Top = 56
    Width = 398
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADRES_2'
    DataSource = dtsPlasiyer
    TabOrder = 3
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit9: TIB_Edit
    Left = 60
    Top = 80
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ILCE'
    DataSource = dtsPlasiyer
    TabOrder = 4
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit10: TIB_Edit
    Left = 216
    Top = 80
    Width = 138
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'SEHIR'
    DataSource = dtsPlasiyer
    TabOrder = 5
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit11: TIB_Edit
    Left = 407
    Top = 80
    Width = 51
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'POSTAKOD'
    DataSource = dtsPlasiyer
    TabOrder = 6
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit12: TIB_Edit
    Left = 60
    Top = 201
    Width = 398
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'EMAIL'
    DataSource = dtsPlasiyer
    TabOrder = 11
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit13: TIB_Edit
    Left = 60
    Top = 233
    Width = 398
    Height = 21
    AutoLabel.Kind = albTop
    AutoLabel.Margin = -55
    DataField = 'WEBADDR'
    DataSource = dtsPlasiyer
    TabOrder = 12
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object Panel1: TPanel
    Left = 0
    Top = 288
    Width = 476
    Height = 30
    Align = alBottom
    TabOrder = 14
    object btnCikis: TBitBtn
      Left = 424
      Top = 2
      Width = 49
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 0
      OnClick = btnCikisClick
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
    object btnAra: TBitBtn
      Left = 381
      Top = 2
      Width = 43
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
    object btnYeni: TBitBtn
      Left = 3
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 2
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 66
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 3
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 158
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 4
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 239
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 5
      OnClick = btnSilClick
    end
    object Btn_Onceki: TButton
      Left = 329
      Top = 3
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 6
      OnClick = Btn_OncekiClick
    end
    object Btn_Sonraki: TButton
      Left = 353
      Top = 3
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 7
      OnClick = Btn_SonrakiClick
    end
  end
  object IB_Currency1: TIB_Currency
    Left = 337
    Top = 104
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'BORC'
    DataSource = dtsPlasiyer
    Enabled = False
    ReadOnly = True
    TabOrder = 15
    AlwaysShowButton = True
  end
  object IB_Currency2: TIB_Currency
    Left = 337
    Top = 152
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'BORC_VPB'
    DataSource = dtsPlasiyer
    Enabled = False
    ReadOnly = True
    TabOrder = 16
    AlwaysShowButton = True
  end
  object IB_Currency3: TIB_Currency
    Left = 337
    Top = 128
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'ALACAK'
    DataSource = dtsPlasiyer
    Enabled = False
    ReadOnly = True
    TabOrder = 17
    AlwaysShowButton = True
  end
  object IB_Currency4: TIB_Currency
    Left = 337
    Top = 176
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'ALACAK_VPB'
    DataSource = dtsPlasiyer
    Enabled = False
    ReadOnly = True
    TabOrder = 18
    AlwaysShowButton = True
  end
  object IB_CheckBox1: TIB_CheckBox
    Left = 404
    Top = 264
    Width = 53
    Height = 13
    DataField = 'PASIF'
    DataSource = dtsPlasiyer
    BorderStyle = bsNone
    TabOrder = 13
    Caption = 'Pasif'
  end
  object cboDOVKOD: TIB_ComboBox
    Left = 60
    Top = 177
    Width = 89
    Height = 21
    AutoLabel.Kind = albLeft
    AutoLabel.Caption = 'D'#246'viz Kodu'
    DataField = 'DOVKOD'
    DataSource = dtsPlasiyer
    TabOrder = 10
    OnEnter = cboDOVKODEnter
    OnExit = cboDOVKODExit
    Style = csDropDownList
    ItemHeight = 13
  end
  object qryPlasiyer: TIB_Query
    ColumnAttributes.Strings = (
      'PASIF=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    FieldsDisplayFormat.Strings = (
      'TELNO_1=0(###)#######'
      'TELNO_2=0(###)#######'
      'FAX=0(###)#######')
    FieldsDisplayLabel.Strings = (
      'PLASIYER_KOD=Kodu:'
      'ADISOY=Ad'#305' Soyad'#305' :'
      'FIRMA_ID=Firma Ad'#305' :'
      'TELNO_1=Telefon(1) :'
      'TELNO_2=Telefon(2) :'
      'FAX=Fax :'
      'ADRES_1=Adres (1) :'
      'ADRES_2=Adres (2) :'
      'ILCE='#304'l'#231'e :'
      'SEHIR='#350'ehir :'
      'POSTAKOD=P. Kodu :'
      'EMAIL=E - Mail :'
      'WEBADDR=Web Adresi :'
      'BORC=Borc'
      'ALACAK=Alacak'
      'BORC_VPB=Borc VPB'
      'ALACAK_VPB=Alacak VPB'
      'DOVKOD=Para Birimi')
    FieldsEditMask.Strings = (
      'TELNO_1=0(###)#######'
      'TELNO_2=0(###)#######'
      'FAX=0(###)#######')
    FieldsReadOnly.Strings = (
      'BORC=TRUE'
      'ALACAK=TRUE'
      'BORC_VPB=TRUE'
      'ALACAK_VPB=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT '
      '      PLASIYER_SID'
      '     , PLASIYER_KOD'
      '     , ADISOY'
      '     , FIRMA_ID'
      '     , TELNO_1'
      '     , TELNO_2'
      '     , FAX'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , POSTAKOD'
      '     , EMAIL'
      '     , WEBADDR'
      '     , DOVKOD'
      '     , BORC'
      '     , ALACAK'
      '     , BORC_VPB'
      '     , ALACAK_VPB'
      '     , PASIF'
      'FROM PLASIYER'
      'WHERE PLASIYER_KOD=:PRM_PLASIYER_KOD')
    ColorScheme = False
    DefaultValues.Strings = (
      'BORC=0'
      'ALACAK=0'
      'BORC_VPB=0'
      'ALACAK_VPB=0'
      'PASIF=0')
    KeyLinks.Strings = (
      'PLASIYER.PLASIYER_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryPlasiyerAfterInsert
    BeforeDelete = qryPlasiyerBeforeDelete
    BeforePost = qryPlasiyerBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 236
    Top = 28
  end
  object dtsPlasiyer: TIB_DataSource
    AutoInsert = False
    Dataset = qryPlasiyer
    OnStateChanged = dtsPlasiyerStateChanged
    Left = 320
    Top = 16
  end
end
