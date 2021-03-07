object frmBELGE_YAZ: TfrmBELGE_YAZ
  Left = 317
  Top = 179
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Belge - Yaz'#305'c'#305' '#304#351'lemleri'
  ClientHeight = 534
  ClientWidth = 634
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
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object IB_Text1: TIB_Text
    Left = 42
    Top = 6
    Width = 264
    Height = 13
    DataField = 'BELGETUR.ADI'
    DataSource = dtsBELGE_YAZ
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object IB_Text2: TIB_Text
    Left = 366
    Top = 6
    Width = 265
    Height = 14
    DataField = 'BELGE_YAZ.ACIKLAMA'
    DataSource = dtsBELGE_YAZ
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 6
    Top = 6
    Width = 33
    Height = 13
    Caption = 'Belge :'
  end
  object Label4: TLabel
    Left = 312
    Top = 6
    Width = 49
    Height = 13
    Caption = 'A'#231#305'klama :'
  end
  object Panel1: TPanel
    Left = 0
    Top = 504
    Width = 634
    Height = 30
    Align = alBottom
    TabOrder = 0
    object btnCikis: TBitBtn
      Left = 566
      Top = 3
      Width = 61
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
    object btnKaydet: TButton
      Left = 1
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 99
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
  end
  object grdBELGE_YAZ: TIB_Grid
    Left = 0
    Top = 156
    Width = 634
    Height = 348
    CustomGlyphsSupplied = []
    DataSource = dtsBELGE_YAZ
    Align = alBottom
    BorderStyle = bsNone
    PreventDeleting = True
    PreventInserting = True
    PreventSearching = True
    TabOrder = 1
    Ctl3DShallow = True
  end
  object IB_Edit2: TIB_Edit
    Left = 2
    Top = 40
    Width = 629
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'BELGE_YAZ.DOSYA_PATH'
    DataSource = dtsBELGE_YAZ
    TabOrder = 2
    ButtonStyle = ebsEllipsis
    OnButtonClick = IB_Edit2ButtonClick
  end
  object GroupBox1: TGroupBox
    Left = 3
    Top = 66
    Width = 628
    Height = 85
    Caption = 'Bu Makina '#304#231'in'
    TabOrder = 3
    object Label1: TLabel
      Left = 284
      Top = 16
      Width = 39
      Height = 13
      Caption = 'Yaz'#305'c'#305'lar'
    end
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 39
      Height = 13
      Caption = 'Yaz'#305'c'#305'lar'
    end
    object cboPRINTERS: TComboBox
      Left = 284
      Top = 32
      Width = 263
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object btnRegKaydet: TButton
      Left = 551
      Top = 32
      Width = 71
      Height = 21
      Caption = 'Kaydet'
      TabOrder = 1
      OnClick = btnRegKaydetClick
    end
    object txtPRINTER: TEdit
      Left = 8
      Top = 32
      Width = 263
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object chkPRNVARSAY: TCheckBox
      Left = 10
      Top = 60
      Width = 129
      Height = 13
      Caption = 'Varsay'#305'lan Yaz'#305'c'#305'  Yap'
      TabOrder = 3
    end
  end
  object cboSUBE: TIB_LookupCombo
    Left = 287
    Top = 123
    Width = 121
    Height = 21
    DataSource = dtsSUBE
    TabOrder = 4
    DisplayField = 'ADI'
    ShowButton = True
  end
  object qryBELGE_YAZ: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    FieldsDisplayLabel.Strings = (
      'ADI=Belge'
      'ACIKLAMA=A'#231#305'klama'
      'DOSYA_PATH=Dosya'
      'YAZICI=Yaz'#305'c'#305
      'ESC_MODE=ESC Mode'
      'SATIR_SAY=Sayfa Sat'#305'r Say'#305's'#305)
    FieldsDisplayWidth.Strings = (
      'ADI=112'
      'ACIKLAMA=205'
      'DOSYA_PATH=274'
      'YAZICI=136')
    FieldsIndex.Strings = (
      'BELGE_YAZ.BELGE_TUR'
      'BELGE_YAZ.SIRA_NO'
      'BELGETUR.ADI'
      'BELGE_YAZ.ACIKLAMA'
      'BELGE_YAZ.DOSYA_PATH'
      'BELGE_YAZ.YAZICI')
    FieldsVisible.Strings = (
      'BELGE_TUR=FALSE'
      'SIRA_NO=FALSE'
      'ESC_MODE=FALSE'
      'SATIR_SAY=FALSE'
      'SUBE_ID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT BELGE_YAZ.*'
      '   ,    BELGETUR.ADI '
      'FROM BELGE_YAZ'
      'INNER JOIN BELGETUR ON BELGE_YAZ.BELGE_TUR = BELGETUR.BELGE_TUR'
      'ORDER BY BELGE_YAZ.BELGE_TUR')
    ColorScheme = False
    EditSQL.Strings = (
      'UPDATE BELGE_YAZ SET'
      '   BELGE_TUR = :BELGE_TUR, /*PK*/'
      '   SIRA_NO = :SIRA_NO, /*PK*/'
      '   SUBE_ID = :SUBE_ID, /*PK*/'
      '   ACIKLAMA = :ACIKLAMA,'
      '   DOSYA_PATH = :DOSYA_PATH'
      'WHERE'
      '   BELGE_TUR = :OLD_BELGE_TUR AND'
      '   SIRA_NO = :OLD_SIRA_NO AND'
      '   SUBE_ID = :OLD_SUBE_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterScroll = qryBELGE_YAZAfterScroll
    BeforePost = qryBELGE_YAZBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 216
    Top = 234
  end
  object dtsBELGE_YAZ: TIB_DataSource
    Dataset = qryBELGE_YAZ
    OnStateChanged = dtsBELGE_YAZStateChanged
    Left = 116
    Top = 232
  end
  object dlgBELGE: TOpenDialog
    DefaultExt = '*.fr3'
    Filter = 'Yaz'#305'c'#305' Tasar'#305'm Dosyalar'#305'|*.fr3'
    Left = 316
    Top = 236
  end
  object qrySUBE: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\main.FDB'
    FieldsVisible.Strings = (
      'SUBEID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SUBE_ID'
      '     , ADI'
      'FROM SUBE'
      'WHERE SIRKET_ID =:PRM_SIRKET_ID')
    ColorScheme = False
    KeyLinks.Strings = (
      'SUBE.SUBE_ID=BELGE_YAZ.SUBE_ID')
    KeySource = dtsBELGE_YAZ
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    PreventEditing = True
    PreventInserting = True
    PreventDeleting = True
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 424
    Top = 220
  end
  object dtsSUBE: TIB_DataSource
    Dataset = qrySUBE
    Left = 436
    Top = 294
  end
end
