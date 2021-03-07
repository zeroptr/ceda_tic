object frmPaket: TfrmPaket
  Left = 347
  Top = 232
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Paket Tan'#305'mlama'
  ClientHeight = 363
  ClientWidth = 618
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pg: TPageControl
    Left = 0
    Top = 0
    Width = 618
    Height = 363
    ActivePage = tabRecete
    Align = alClient
    TabOrder = 0
    OnChange = pgChange
    OnChanging = pgChanging
    object tabRecete: TTabSheet
      Caption = 'Paket'
      object txtReceteKodu: TIB_Edit
        Left = 75
        Top = 24
        Width = 121
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PAKET_KOD'
        DataSource = dts_Paket
        TabOrder = 0
        OnEnter = IB_Edit2Enter
        OnExit = IB_Edit2Exit
        OnKeyPress = txtReceteKoduKeyPress
      end
      object IB_Edit1: TIB_Edit
        Left = 75
        Top = 48
        Width = 274
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'PAKET_ADI'
        DataSource = dts_Paket
        TabOrder = 1
        OnEnter = IB_Edit2Enter
        OnExit = IB_Edit2Exit
        OnKeyPress = txtReceteKoduKeyPress
      end
      object IB_Edit3: TIB_Edit
        Left = 75
        Top = 72
        Width = 182
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'BARKOD'
        DataSource = dts_Paket
        TabOrder = 2
        OnEnter = IB_Edit2Enter
        OnExit = IB_Edit2Exit
      end
      object Panel5: TPanel
        Left = 0
        Top = 305
        Width = 610
        Height = 30
        Align = alBottom
        TabOrder = 4
        TabStop = True
        object btnAra: TBitBtn
          Left = 486
          Top = 3
          Width = 62
          Height = 25
          Caption = '&Ara'
          TabOrder = 4
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
          Left = 547
          Top = 3
          Width = 61
          Height = 25
          Caption = #199#305'&k'#305#351
          TabOrder = 5
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
        object btnYeni: TBitBtn
          Left = 6
          Top = 3
          Width = 82
          Height = 25
          Caption = 'Yeni (INS)'
          TabOrder = 0
          OnClick = btnYeniClick
        end
        object btnTRN_KAYDET: TButton
          Left = 87
          Top = 3
          Width = 119
          Height = 25
          Caption = 'Kaydet ( CTRL + END)'
          TabOrder = 1
          OnClick = btnTRN_KAYDETClick
        end
        object btnTRN_IPTAL: TButton
          Left = 205
          Top = 3
          Width = 108
          Height = 25
          Caption = 'Iptal (CTRL + A)'
          TabOrder = 2
          OnClick = btnTRN_IPTALClick
        end
        object btnReceteSil: TBitBtn
          Left = 312
          Top = 2
          Width = 92
          Height = 26
          Caption = 'Sil (CTRL + DEL)'
          TabOrder = 3
          OnClick = btnReceteSilClick
        end
        object Btn_Onceki: TButton
          Left = 424
          Top = 3
          Width = 25
          Height = 25
          Caption = '<'
          TabOrder = 6
          OnClick = Btn_OncekiClick
        end
        object Btn_Sonraki: TButton
          Left = 448
          Top = 3
          Width = 25
          Height = 25
          Caption = '>'
          TabOrder = 7
          OnClick = Btn_SonrakiClick
        end
      end
      object IB_Edit2: TIB_Edit
        Left = 75
        Top = 96
        Width = 454
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'ACIKLAMA'
        DataSource = dts_Paket
        TabOrder = 3
        OnEnter = IB_Edit2Enter
        OnExit = IB_Edit2Exit
      end
    end
    object tabMamul: TTabSheet
      Caption = 'Paket Detaylar'#305
      ImageIndex = 1
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 610
        Height = 123
        Align = alTop
        TabOrder = 0
        object txtMamulKod: TIB_Edit
          Left = 75
          Top = 22
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'URUN_KOD'
          DataSource = dts_Paket_Detay
          TabOrder = 0
          OnEnter = txtMamulKodEnter
          OnExit = txtMamulKodExit
          OnKeyUp = txtMamulKodKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtMamulKodButtonClick
        end
        object IB_Currency7: TIB_Currency
          Left = 75
          Top = 46
          Width = 120
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'MIKTAR'
          DataSource = dts_Paket_Detay
          TabOrder = 2
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
          AlwaysShowButton = True
        end
        object IB_Edit8: TIB_Edit
          Left = 270
          Top = 22
          Width = 277
          Height = 21
          TabStop = False
          AutoLabel.Kind = albLeft
          DataField = 'URUN_ADI'
          DataSource = dts_Paket_Detay
          Enabled = False
          TabOrder = 1
        end
        object btnMamulEKLE: TButton
          Left = 13
          Top = 100
          Width = 60
          Height = 23
          Caption = 'Ekle (INS)'
          TabOrder = 4
          OnClick = btnMamulEKLEClick
        end
        object btnMamulKaydet: TButton
          Left = 72
          Top = 100
          Width = 94
          Height = 23
          Caption = 'Kaydet (CTRL+S)'
          TabOrder = 5
          OnClick = btnMamulKaydetClick
        end
        object btnMamulIptal: TButton
          Left = 165
          Top = 100
          Width = 86
          Height = 23
          Caption = #304'ptal(CTRL+P)'
          TabOrder = 6
          OnClick = btnMamulIptalClick
        end
        object btnMamulSil: TButton
          Left = 462
          Top = 100
          Width = 97
          Height = 23
          Caption = 'Sil (CTRL + DEL)'
          TabOrder = 7
          OnClick = btnMamulSilClick
        end
        object txtOlcuBirim: TIB_Edit
          Left = 270
          Top = 43
          Width = 121
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'OLCU_BIRIM'
          DataSource = dts_Paket_Detay
          TabOrder = 3
          OnEnter = txtOlcuBirimEnter
          OnExit = txtOlcuBirimExit
          OnKeyPress = txtOlcuBirimKeyPress
          OnKeyUp = txtOlcuBirimKeyUp
          ButtonStyle = ebsEllipsis
          OnButtonClick = txtOlcuBirimButtonClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 123
        Width = 610
        Height = 212
        Align = alClient
        TabOrder = 1
        object IB_Grid1: TIB_Grid
          Left = 1
          Top = 1
          Width = 608
          Height = 210
          CustomGlyphsSupplied = []
          DataSource = dts_Paket_Detay
          Align = alClient
          ReadOnly = True
          TabOrder = 0
          RowSelect = True
          OnCellDblClick = IB_Grid1CellDblClick
        end
      end
    end
  end
  object qry_Paket: TIB_Query
    ColumnAttributes.Strings = (
      'URETIM_KAYDI=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'RECETE_ADI=Recete Ad'#305
      'ACIKLAMA=A'#231#305'klama'
      'URETIM_KAYDI='#220'retim Kayd'#305' Yap'#305'ls'#305'n'
      'MAKINE_KOD=Makine Kodu'
      'ISCI_SAYISI='#304#351#231'i Say'#305's'#305
      'URETIM_SURE='#220'retim S'#252'resi'
      'RECETE_KOD=Recete Kodu'
      'MAK_KOD=Makine Kodu'
      'MAKINE_AD=Makine Ad'#305
      'PAKET_KOD=Paket Kodu'
      'PAKAET_ADI=Paket Ad'#305
      'BARKOD=Barkod'
      'PAKET_ADI=Paket Ad'#305)
    FieldsVisible.Strings = (
      'PAKET_SID=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT PAKET_KOD'
      '     , PAKET_SID'
      '     , PAKET_ADI'
      '     , BARKOD'
      '     , ACIKLAMA'
      'FROM PAKET'
      'Where PAKET_KOD=:PAKET_KOD')
    ColorScheme = False
    DefaultValues.Strings = (
      'PAKET_SID=0')
    KeyLinks.Strings = (
      'PAKET.PAKET_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_PaketAfterInsert
    BeforePost = qry_PaketBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 88
    Top = 216
    ParamValues = (
      'PAKET_KOD=')
  end
  object dts_Paket: TIB_DataSource
    AutoInsert = False
    Dataset = qry_Paket
    OnStateChanged = dts_PaketStateChanged
    Left = 88
    Top = 168
  end
  object qry_Paket_Detay: TIB_Query
    ColumnAttributes.Strings = (
      'ANA_MAMUL=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    FieldsDisplayFormat.Strings = (
      'MIKTAR=#,##.0000')
    FieldsDisplayLabel.Strings = (
      'MAMUL_KOD=Mam'#252'l Kodu'
      'MAMUL_ADI=Mam'#252'l Ad'#305
      'MIKTAR=Miktar'
      'OLCUBIRIM='#214'l'#231#252' Birimi'
      'ANA_MAMUL=Ana Mam'#252'l'
      'PAKET_KOD=Paket Kodu'
      'URUN_KOD='#220'r'#252'n Kodu'
      'URUN_ADI='#220'r'#252'n Ad'#305
      'OLCUBIRIMI='#214'l'#231#252' Birimi'
      'OLCU_BIRIM='#214'l'#231#252' Birimi')
    FieldsDisplayWidth.Strings = (
      'MAMUL_KOD=131'
      'MIKTAR=62'
      'ANA_MAMUL=58'
      'PAKET_KOD=125'
      'URUN_KOD=137'
      'URUN_ADI=155'
      'OLCUBIRIMI=87'
      'OLCU_BIRIM=84')
    FieldsVisible.Strings = (
      'RECETE_MAMUL_ID=FALSE'
      'RECETE_MAMUL_SID=FALSE'
      'RECETE_KOD=FALSE'
      'RECETE_SID=FALSE'
      'URUN_SID=FALSE'
      'PAKET_D_ID=FALSE'
      'PAKET_D_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT PAKET_KOD'
      '     , PAKET_D_ID'
      '     , PAKET_D_SID'
      '     , URUN_KOD'
      
        '     , (Select URUN.URUN_AD FROM URUN WHERE URUN.URUN_KOD=PAKET_' +
        'D.URUN_KOD ) as URUN_ADI'
      '     , OLCU_BIRIM'
      '     , MIKTAR'
      'FROM PAKET_D'
      'Where PAKET_KOD=:PAKET_KOD')
    CheckRequired = False
    ColorScheme = False
    KeyLinks.Strings = (
      'PAKET_D.PAKET_KOD'
      'PAKET_D.PAKET_D_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_Paket_DetayAfterInsert
    BeforePost = qry_Paket_DetayBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 208
    Top = 216
    ParamValues = (
      'PAKET_KOD=')
  end
  object dts_Paket_Detay: TIB_DataSource
    AutoInsert = False
    Dataset = qry_Paket_Detay
    OnStateChanged = dts_Paket_DetayStateChanged
    Left = 208
    Top = 168
  end
end
