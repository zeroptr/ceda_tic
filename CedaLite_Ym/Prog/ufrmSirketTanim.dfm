object frm_Sirket_Tanim: Tfrm_Sirket_Tanim
  Left = 205
  Top = 256
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #350'irket Bilgileri'
  ClientHeight = 268
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 237
    Width = 633
    Height = 31
    Align = alBottom
    TabOrder = 17
    object IB_UpdateBar1: TIB_UpdateBar
      Left = 1
      Top = 1
      Width = 121
      Height = 29
      Align = alLeft
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      Visible = False
      DataSource = dts_Sirket
      ReceiveFocus = False
      CustomGlyphsSupplied = []
    end
    object btnExit: TBitBtn
      Left = 550
      Top = 3
      Width = 75
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 1
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
  end
  object IB_Edit3: TIB_Edit
    Left = 195
    Top = 28
    Width = 415
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'SIRKET_AD'
    DataSource = dts_Sirket
    TabOrder = 1
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = IB_Edit3KeyPress
  end
  object IB_Edit4: TIB_Edit
    Left = 195
    Top = 52
    Width = 415
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'YETKILI'
    DataSource = dts_Sirket
    TabOrder = 2
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = IB_Edit3KeyPress
  end
  object IB_Edit5: TIB_Edit
    Left = 195
    Top = 76
    Width = 415
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADRES_1'
    DataSource = dts_Sirket
    TabOrder = 3
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
  end
  object IB_Edit6: TIB_Edit
    Left = 195
    Top = 100
    Width = 415
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADRES_2'
    DataSource = dts_Sirket
    TabOrder = 4
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
  end
  object IB_Edit7: TIB_Edit
    Left = 195
    Top = 128
    Width = 132
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ILCE'
    DataSource = dts_Sirket
    TabOrder = 5
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = IB_Edit3KeyPress
  end
  object IB_Edit8: TIB_Edit
    Left = 367
    Top = 128
    Width = 132
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'SEHIR'
    DataSource = dts_Sirket
    TabOrder = 6
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = IB_Edit3KeyPress
  end
  object edt_Pk: TIB_Edit
    Left = 564
    Top = 127
    Width = 45
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'PK'
    DataSource = dts_Sirket
    TabOrder = 7
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = edt_PkKeyPress
  end
  object IB_Edit10: TIB_Edit
    Left = 59
    Top = 166
    Width = 84
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TEL1'
    DataSource = dts_Sirket
    TabOrder = 8
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = edt_PkKeyPress
  end
  object IB_Edit11: TIB_Edit
    Left = 148
    Top = 166
    Width = 82
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TEL2'
    DataSource = dts_Sirket
    TabOrder = 9
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = edt_PkKeyPress
  end
  object IB_Edit12: TIB_Edit
    Left = 236
    Top = 166
    Width = 81
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'FAX'
    DataSource = dts_Sirket
    TabOrder = 10
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = edt_PkKeyPress
  end
  object IB_Edit13: TIB_Edit
    Left = 320
    Top = 166
    Width = 132
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'VERDAIRE'
    DataSource = dts_Sirket
    TabOrder = 11
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyPress = IB_Edit3KeyPress
  end
  object IB_Image1: TIB_Image
    Left = 19
    Top = 16
    Width = 98
    Height = 81
    AutoLabel.Kind = albTop
    AutoLabel.Margin = -15
    DataField = 'LOGO'
    DataSource = dts_Sirket
    BorderStyle = bsNone
    PreventSearching = True
    TabOrder = 18
    Stretch = True
  end
  object edt_Ver_No: TIB_Edit
    Left = 456
    Top = 166
    Width = 132
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'VERNO'
    DataSource = dts_Sirket
    TabOrder = 12
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
    OnKeyDown = edt_Ver_NoKeyDown
    OnKeyPress = edt_Ver_NoKeyPress
  end
  object Button1: TButton
    Left = 19
    Top = 100
    Width = 98
    Height = 25
    Caption = 'Resim Se'#231
    TabOrder = 16
    OnClick = Button1Click
  end
  object IB_Edit2: TIB_Edit
    Left = 194
    Top = 4
    Width = 121
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'SIRKET_ID'
    DataSource = dts_Sirket
    Enabled = False
    TabOrder = 0
    OnEnter = IB_Edit3Enter
    OnExit = IB_Edit3Exit
  end
  object IB_Edit1: TIB_Edit
    Left = 58
    Top = 208
    Width = 115
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TIC_SIC_NO'
    DataSource = dts_Sirket
    TabOrder = 13
    OnEnter = IB_Edit3Exit
  end
  object IB_Edit9: TIB_Edit
    Left = 178
    Top = 208
    Width = 115
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'TIC_ODA_NO'
    DataSource = dts_Sirket
    TabOrder = 14
    OnEnter = IB_Edit3Exit
  end
  object IB_Edit14: TIB_Edit
    Left = 298
    Top = 208
    Width = 115
    Height = 21
    AutoLabel.Kind = albTop
    DataField = 'SSK_SIC_NO'
    DataSource = dts_Sirket
    TabOrder = 15
    OnEnter = IB_Edit3Exit
  end
  object Button2: TButton
    Left = 20
    Top = 128
    Width = 97
    Height = 25
    Caption = 'Resmi Sil'
    TabOrder = 19
    OnClick = Button2Click
  end
  object IB_CheckBox1: TIB_CheckBox
    Left = 472
    Top = 200
    Width = 53
    Height = 17
    DataField = 'AKTIF'
    DataSource = dts_Sirket
    BorderStyle = bsNone
    TabOrder = 20
    Caption = 'Aktif'
  end
  object qry_Sirket: TIB_Query
    ColumnAttributes.Strings = (
      'AKTIF=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\MAIN.FDB'
    FieldsDisplayFormat.Strings = (
      'TEL1=#(###)#######'
      'TEL2=#(###)#######'
      'FAX=#(###)#######'
      'VERNO=### ### ####'
      'PK=#####'
      'TOPLAM_SUBE_ADET=###'
      'SIRKET_KOD=#####')
    FieldsDisplayLabel.Strings = (
      'ADI='#350'irket Ad'#305' :'
      'YETKILI='#350'irket Yetkilisi :'
      'ADRES_1=Adres (1) :'
      'ADRES_2=Adres (2) :'
      'ILCE='#304'l'#231'e :'
      'SEHIR='#350'ehir :'
      'PK=Posta Kodu :'
      'TEL1=Telefon (1) :'
      'TEL2=Telefon (2) :'
      'FAX=Fax :'
      'VERDAIRE=Vergi Dairesi :'
      'VERNO=Vergi Numaras'#305' :'
      'LOGO='#350'irket Logosu :'
      'TOPLAM_SUBE_ADET=Toplam '#350'ube Adedi :'
      'SIRKET_KOD='#350'irket Kodu :'
      'TIC_SIC_NO=Ticaret Sicil No'
      'TIC_ODA_NO=Ticaret Oda No'
      'SSK_SIC_NO=SSK Sicil No'
      'SIRKET_AD='#350'irket Ad'#305
      'SIRKET_ID='#350'irket No')
    FieldsEditMask.Strings = (
      'TEL1=#(###)#######'
      'TEL2=#(###)#######'
      'FAX=#(###)#######'
      'VERNO=### ### ####'
      'PK=#####'
      'TOPLAM_SUBE_ADET=###'
      'SIRKET_KOD=#####')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SIRKET_ID'
      '     , SIRKET_AD'
      '     , YETKILI'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , PK'
      '     , TEL1'
      '     , TEL2'
      '     , FAX'
      '     , VERDAIRE'
      '     , VERNO'
      '     , LOGO'
      '     , TOPLAM_SUBE_ADET'
      '     , TIC_SIC_NO'
      '     , TIC_ODA_NO'
      '     , SSK_SIC_NO'
      '     , AKTIF'
      'FROM SIRKET'
      'WHERE SIRKET_ID=:PRM_SIRKET_ID;')
    ColorScheme = False
    DefaultValues.Strings = (
      'AKTIF=1')
    KeyLinks.Strings = (
      'SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qry_SirketAfterInsert
    BeforeDelete = qry_SirketBeforeDelete
    BeforePost = qry_SirketBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 420
    Top = 53
    ParamValues = (
      'PRM_SIRKET_ID=1')
  end
  object dts_Sirket: TIB_DataSource
    Dataset = qry_Sirket
    Left = 540
    Top = 41
  end
  object OpenPictureDialog1: TOpenPictureDialog
    DefaultExt = '*.bmp'
    Left = 348
    Top = 17
  end
end
