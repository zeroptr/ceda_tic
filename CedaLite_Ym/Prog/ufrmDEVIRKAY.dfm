object frmDEVIRKAY: TfrmDEVIRKAY
  Left = 228
  Top = 162
  Caption = 'Devir Kay'#305'tlar'#305
  ClientHeight = 451
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object tcDEVIR: TTabControl
    Left = 0
    Top = 0
    Width = 555
    Height = 451
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    Tabs.Strings = (
      'Cari'
      #220'r'#252'n'
      'Kasa'
      'Proje'
      'Plasiyer'
      'Masraf'
      'Ara'#231
      'Personel')
    TabIndex = 0
    OnChange = tcDEVIRChange
    OnChanging = tcDEVIRChanging
    object Splitter1: TSplitter
      Left = 4
      Top = 229
      Width = 547
      Height = 10
      Cursor = crVSplit
      Align = alTop
    end
    object grdCARIDOV: TIB_Grid
      Left = 4
      Top = 239
      Width = 547
      Height = 167
      CustomGlyphsSupplied = []
      DataSource = dtsCARIDOV
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 0
      Ctl3DShallow = True
    end
    object Panel1: TPanel
      Left = 4
      Top = 406
      Width = 547
      Height = 41
      Align = alBottom
      TabOrder = 1
      DesignSize = (
        547
        41)
      object btnAra: TBitBtn
        Left = 450
        Top = 9
        Width = 90
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = '&Ara'
        TabOrder = 2
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
      object btnKaydet: TButton
        Left = 12
        Top = 9
        Width = 90
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Kaydet (CTRL+S)'
        TabOrder = 0
        OnClick = btnKaydetClick
      end
      object btnIPTAL: TButton
        Left = 106
        Top = 9
        Width = 90
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = #304'ptal(CTRL+P)'
        TabOrder = 1
        OnClick = btnIPTALClick
      end
      object dtDEVIRTAR: TDateTimePicker
        Left = 224
        Top = 12
        Width = 89
        Height = 21
        Date = 38008.630702037040000000
        Time = 38008.630702037040000000
        TabOrder = 3
      end
      object btnDOVHES: TButton
        Left = 334
        Top = 9
        Width = 90
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'D'#246'viz Hesapla'
        TabOrder = 4
        OnClick = btnDOVHESClick
      end
    end
    object grdDEVIR: TIB_Grid
      Left = 4
      Top = 27
      Width = 547
      Height = 202
      CustomGlyphsSupplied = []
      DataSource = dtsDEVIR
      Align = alTop
      BorderStyle = bsNone
      TabOrder = 2
      Ctl3DShallow = True
    end
  end
  object qryDEVIR: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT CARI_KOD'
      '     , CARI_AD'
      '     , DEVREDEN_BORC'
      '     , DEVREDEN_ALACAK'
      'FROM CARI')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    PreventInserting = True
    PreventDeleting = True
    RequestLive = True
    AfterScroll = qryDEVIRAfterScroll
    BeforeDelete = qryDEVIRBeforeDelete
    BeforePost = qryDEVIRBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 54
    Top = 69
  end
  object dtsDEVIR: TIB_DataSource
    Dataset = qryDEVIR
    OnStateChanged = dtsDEVIRStateChanged
    Left = 56
    Top = 133
  end
  object qryCARIDOV: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsDisplayLabel.Strings = (
      'DOVKOD=D'#246'viz T'#252'r'#252
      'DEVREDEN_BORC=Devreden Borc'
      'DEVREDEN_ALACAK=Devreden Alacak')
    FieldsVisible.Strings = (
      'CARI_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT DOVKOD'
      '     , DEVREDEN_BORC'
      '     , DEVREDEN_ALACAK'
      '     , CARI_KOD'
      'FROM CARI_DOV'
      'WHERE CARI_KOD=:PRM_CARI_KOD;')
    ColorScheme = False
    KeyLinks.Strings = (
      'CARI_DOV.CARI_KOD'
      'CARI_DOV.DOVKOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BeforeDelete = qryCARIDOVBeforeDelete
    BeforePost = qryCARIDOVBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 134
    Top = 73
    ParamValues = (
      'PRM_CARI_KOD=')
  end
  object dtsCARIDOV: TIB_DataSource
    Dataset = qryCARIDOV
    Left = 134
    Top = 133
  end
  object qryDOVKART: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT *'
      'FROM DOVKART'
      'WHERE TAKIP = 1;')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 228
    Top = 137
  end
  object dsqlCARI_DOV_INSERT: TIB_DSQL
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'INSERT INTO CARI_DOV (CARI_KOD,DOVKOD,KREDILMT,RISK,BORC,ALACAK,' +
        'DEVREDEN_BORC,DEVREDEN_ALACAK) VALUES '
      '(:PRM_CARI_KOD,:PRM_DOVKOD,0,0,0,0,0,0);')
    Left = 236
    Top = 71
  end
end
