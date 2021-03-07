object frm_Sube: Tfrm_Sube
  Left = 134
  Top = 95
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #350'ube Tan'#305'mlamalar'#305
  ClientHeight = 298
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 267
    Width = 682
    Height = 31
    Align = alBottom
    TabOrder = 14
    object btnExit: TBitBtn
      Left = 600
      Top = 3
      Width = 75
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 5
      OnClick = btnExitClick
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
      Width = 76
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 0
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 83
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 1
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 175
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 2
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 256
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 3
      OnClick = btnSilClick
    end
    object btnDuzenle: TButton
      Left = 344
      Top = 3
      Width = 94
      Height = 25
      Caption = 'D'#252'zenle (Ctrl+D)'
      TabOrder = 4
      OnClick = btnDuzenleClick
    end
  end
  object IB_Edit1: TIB_Edit
    Left = 56
    Top = 32
    Width = 377
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADI'
    DataSource = dts_Sube
    TabOrder = 2
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyPress = IB_Edit1KeyPress
  end
  object IB_Edit2: TIB_Edit
    Left = 56
    Top = 56
    Width = 377
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADRESI_1'
    DataSource = dts_Sube
    TabOrder = 3
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
  end
  object IB_Edit3: TIB_Edit
    Left = 56
    Top = 80
    Width = 377
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADRESI_2'
    DataSource = dts_Sube
    TabOrder = 4
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
  end
  object IB_Edit4: TIB_Edit
    Left = 264
    Top = 104
    Width = 169
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'SEHIR'
    DataSource = dts_Sube
    TabOrder = 6
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyPress = IB_Edit4KeyPress
  end
  object IB_Edit5: TIB_Edit
    Left = 56
    Top = 104
    Width = 173
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ILCE'
    DataSource = dts_Sube
    TabOrder = 5
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyPress = IB_Edit5KeyPress
  end
  object IB_Edit6: TIB_Edit
    Left = 264
    Top = 128
    Width = 77
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'POSTAKOD'
    DataSource = dts_Sube
    TabOrder = 8
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyPress = IB_Edit6KeyPress
  end
  object IB_Edit7: TIB_Edit
    Left = 64
    Top = 128
    Width = 133
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'TEL_1'
    DataSource = dts_Sube
    TabOrder = 7
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyPress = IB_Edit7KeyPress
  end
  object IB_Edit8: TIB_Edit
    Left = 64
    Top = 152
    Width = 133
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'TEL_2'
    DataSource = dts_Sube
    TabOrder = 9
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyPress = IB_Edit8KeyPress
  end
  object IB_CheckBox1: TIB_CheckBox
    Left = 248
    Top = 4
    Width = 97
    Height = 17
    DisplayLabelAsCaption = True
    DataField = 'VARSAYILAN'
    DataSource = dts_Sube
    BorderStyle = bsNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    Caption = 'Varsay'#305'lan'
  end
  object IB_Edit9: TIB_Edit
    Left = 263
    Top = 152
    Width = 133
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'FAX'
    DataSource = dts_Sube
    TabOrder = 10
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
    OnKeyPress = IB_Edit9KeyPress
  end
  object edt_Sirket: TIB_Edit
    Left = 56
    Top = 8
    Width = 49
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'SUBE_ID'
    DataSource = dts_Sube
    TabOrder = 0
    OnEnter = edt_SirketEnter
    OnExit = edt_SirketExit
  end
  object IB_Edit10: TIB_Edit
    Left = 102
    Top = 180
    Width = 243
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'TIC_SIC_NO'
    DataSource = dts_Sube
    TabOrder = 11
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
  end
  object IB_Edit11: TIB_Edit
    Left = 102
    Top = 210
    Width = 241
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'TIC_ODA_NO'
    DataSource = dts_Sube
    TabOrder = 12
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
  end
  object IB_Edit12: TIB_Edit
    Left = 102
    Top = 240
    Width = 241
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'SSK_SIC_NO'
    DataSource = dts_Sube
    TabOrder = 13
    OnEnter = IB_Edit2Enter
    OnExit = IB_Edit2Exit
  end
  object IB_Grid1: TIB_Grid
    Left = 438
    Top = 30
    Width = 241
    Height = 235
    CustomGlyphsSupplied = []
    DataSource = dts_Sube
    PreventDeleting = True
    PreventEditing = True
    PreventInserting = True
    ReadOnly = True
    TabOrder = 15
    RowSelect = True
  end
  object qry_Sube: TIB_Query
    ColumnAttributes.Strings = (
      'VARSAYILAN=BOOLEAN=1,0;REQUIRED')
    FieldsDisplayFormat.Strings = (
      'TEL_1=#(###)#######'
      'TEL_2=#(###)#######'
      'FAX=#(###)#######')
    FieldsDisplayLabel.Strings = (
      'ADI='#350'ube Ad'#305' :'
      'ADRESI_1=Adres (1) :'
      'ADRESI_2=Adres (2) :'
      'SEHIR='#350'ehir :'
      'ILCE='#304'l'#231'e :'
      'POSTAKOD=Posta Kodu :'
      'TEL_1=Telefon (1) :'
      'TEL_2=Telefon (2) :'
      'FAX=Fax :'
      'VARSAYILAN=Varsay'#305'lan'
      'SIRKET_AD='#350'irket Ad'#305
      'SUBEID='#350'ube Numaras'#305' :'
      'TIC_SIC_NO=Ticari Sicil No'
      'TIC_ODA_NO=Ticaret Odas'#305' No'
      'SSK_SIC_NO=SSK Sicil No'
      'SUBE_ID='#350'ube No')
    FieldsEditMask.Strings = (
      'TEL_1=#(###)#######'
      'TEL_2=#(###)#######'
      'FAX=#(###)#######')
    FieldsVisible.Strings = (
      'SUBEID=FALSE'
      'SIRKET_ID=FALSE'
      'ADRESI_1=FALSE'
      'ADRESI_2=FALSE'
      'SEHIR=FALSE'
      'ILCE=FALSE'
      'POSTAKOD=FALSE'
      'TEL_1=FALSE'
      'TEL_2=FALSE'
      'FAX=FALSE'
      'VARSAYILAN=FALSE'
      'TIC_SIC_NO=FALSE'
      'TIC_ODA_NO=FALSE'
      'SSK_SIC_NO=FALSE'
      'SUBE_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SUBE_ID'
      '     , ADI'
      '     , ADRESI_1'
      '     , ADRESI_2'
      '     , SEHIR'
      '     , ILCE'
      '     , POSTAKOD'
      '     , TEL_1'
      '     , TEL_2'
      '     , FAX'
      '     , VARSAYILAN'
      '     , TIC_SIC_NO'
      '     , TIC_ODA_NO'
      '     , SSK_SIC_NO'
      '     , SIRKET_ID'
      'FROM SUBE'
      'WHERE SIRKET_ID=:PRM_SIRKET_ID')
    ColorScheme = False
    DefaultValues.Strings = (
      'VARSAYILAN=0')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterDelete = qry_SubeAfterDelete
    AfterInsert = qry_SubeAfterInsert
    AfterPost = qry_SubeAfterPost
    BeforeDelete = qry_SubeBeforeDelete
    BeforePost = qry_SubeBeforePost
    BeforeScroll = qry_SubeBeforeScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 294
    Top = 32
    ParamValues = (
      'PRM_SIRKET_ID=0')
  end
  object dts_Sube: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qry_Sube
    Left = 180
    Top = 32
  end
end
