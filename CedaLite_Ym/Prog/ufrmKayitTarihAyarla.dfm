object frmKayitTarihAyarla: TfrmKayitTarihAyarla
  Left = 366
  Top = 226
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kullan'#305'c'#305' baz'#305'nda kay'#305't tarih i'#351'lemleri'
  ClientHeight = 388
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 357
    Width = 413
    Height = 31
    Align = alBottom
    TabOrder = 0
    object btnCikis: TBitBtn
      Left = 348
      Top = 4
      Width = 59
      Height = 25
      Caption = #199#305'k'#305#351
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
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 413
    Height = 357
    Align = alClient
    TabOrder = 1
    object GroupBox9: TGroupBox
      Left = 4
      Top = 294
      Width = 405
      Height = 55
      Caption = 'Kay'#305't Girilebilecek En Eski Tarih Uygulamas'#305
      TabOrder = 0
      object IB_CheckBox5: TIB_CheckBox
        Left = 6
        Top = 24
        Width = 145
        Height = 17
        DataField = 'KAY_TAR_UYG'
        DataSource = dts_Kullanici
        BorderStyle = bsNone
        TabOrder = 0
        Alignment = taLeftJustify
        Caption = 'Tarih Uygulamas'#305' Var m'#305' ?'
      end
      object IB_Date1: TIB_Date
        Left = 285
        Top = 23
        Width = 106
        Height = 21
        AutoLabel.Kind = albLeft
        DataField = 'EN_GER_KAY_TAR'
        DataSource = dts_Kullanici
        TabOrder = 1
        IncCellHeight = 1
        IncCellWidth = 2
        DrawYearArrow = False
      end
    end
    object grdKULLANICI1: TIB_Grid
      Left = 6
      Top = 15
      Width = 402
      Height = 274
      CustomGlyphsSupplied = []
      DataSource = dts_Kullanici
      BorderStyle = bsNone
      PreventDeleting = True
      PreventEditing = True
      PreventInserting = True
      PreventSearching = True
      ReadOnly = True
      TabOrder = 1
      RowSelect = True
      Ctl3DShallow = True
    end
  end
  object qry_Kullanici: TIB_Query
    ColumnAttributes.Strings = (
      'YONETICI=BOOLEAN=1,0;REQUIRED'
      'RAPKOD_UYG=BOOLEAN=1,0;REQUIRED'
      'SUBE_MUDAHALE=BOOLEAN=1,0'
      'KAY_TAR_UYG=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'AD_SOY=Ad'#305' Soyad'#305' :'
      'USER_NAME=Kullan'#305'c'#305' Ad'#305' :'
      'PASS_WORD='#350'ifre :'
      'YONETICI=Y'#246'netici'
      'RAPKOD=Rapor Kodu     '
      'EN_GER_KAY_TAR=En Eski Tarih')
    FieldsGridLabel.Strings = (
      'AD_SOY=Ad'#305' Soyad'#305
      'USER_NAME=Kullan'#305'c'#305' Ad'#305)
    FieldsDisplayWidth.Strings = (
      'AD_SOY=158'
      'USER_NAME=120'
      'YONETICI=79')
    FieldsVisible.Strings = (
      'KULLANICI_ID=FALSE'
      'KULLANICI_SID=FALSE'
      'PASS_WORD=FALSE'
      'E_MAIL=FALSE'
      'SMTP_SERVER=FALSE'
      'SMTP_USER=FALSE'
      'SMTP_PASSWOD=FALSE'
      'SUBE_ID=FALSE'
      'SMTP_AUTHENTICATE=FALSE'
      'RAPKOD_UYG=FALSE'
      'RAPKOD=FALSE'
      'RAPKOD_GOR=FALSE'
      'SUBE_MUDAHALE=FALSE'
      'EN_GER_KAY_TAR=FALSE'
      'KAY_TAR_UYG=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT KULLANICI_ID'
      '     , KULLANICI_SID'
      '     , AD_SOY'
      '     , USER_NAME'
      '     , PASS_WORD'
      '     , YONETICI'
      '     , E_MAIL'
      '     , SMTP_SERVER'
      '     , SMTP_USER'
      '     , SMTP_PASSWOD'
      '     , SMTP_AUTHENTICATE'
      '     , SUBE_ID'
      '     , SUBE_MUDAHALE'
      '     , EN_GER_KAY_TAR'
      '     , KAY_TAR_UYG'
      'FROM KULLANICI')
    ColorScheme = False
    DefaultValues.Strings = (
      'YONETICI=0'
      'SMTP_AUTHENTICATE=0'
      'RAPKOD_UYG=0'
      'RAPKOD_GOR=0'
      'SUBE_MUDAHALE=0')
    GeneratorLinks.Strings = (
      'KULLANICI.KULLANICI_ID=GEN_KULLANICI')
    KeyLinks.Strings = (
      'KULLANICI.KULLANICI_ID'
      'KULLANICI.KULLANICI_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'Ad'#305' Soyad'#305' :=AD_SOY;AD_SOY DESC'
      'Kullan'#305'c'#305' Ad'#305' :=USER_NAME;USER_NAME DESC')
    OrderingLinks.Strings = (
      'AD_SOY=ITEM=1'
      'USER_NAME=ITEM=2')
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 204
    Top = 58
  end
  object dts_Kullanici: TIB_DataSource
    Dataset = qry_Kullanici
    Left = 202
    Top = 118
  end
end
