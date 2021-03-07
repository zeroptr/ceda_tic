object frmSefer_TakipSDLG: TfrmSefer_TakipSDLG
  Left = 0
  Top = 0
  Caption = 'Sefer Takip Listesi'
  ClientHeight = 493
  ClientWidth = 1047
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    1047
    493)
  PixelsPerInch = 96
  TextHeight = 13
  object cxButton2: TcxButton
    Left = 965
    Top = 456
    Width = 74
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #199#305'k'#305#351
    TabOrder = 0
    OnClick = cxButton2Click
  end
  object cxG1: TcxGrid
    Left = 0
    Top = 40
    Width = 1039
    Height = 410
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object cxG1DBTV1: TcxGridDBTableView
      NavigatorButtons.Insert.Visible = False
      NavigatorButtons.Append.Visible = False
      NavigatorButtons.Delete.Hint = 'Delete'
      NavigatorButtons.Delete.Visible = False
      NavigatorButtons.Edit.Hint = 'Ctrl E'
      NavigatorButtons.SaveBookmark.Visible = False
      NavigatorButtons.GotoBookmark.Visible = False
      DataController.DataModeController.GridMode = True
      DataController.DataModeController.SmartRefresh = True
      DataController.DataSource = dtsSefer_Takip
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Kind = skCount
          FieldName = 'GUN_SIRA'
          Column = cxG1DBTV1GUN_SIRA
        end
        item
          Format = '#,.##'
          Kind = skSum
          Position = spFooter
          FieldName = 'FATURA_TUTAR'
          Column = cxG1DBTV1FATURA_TUTAR
        end
        item
          Format = '#,.##'
          Kind = skSum
          Position = spFooter
          FieldName = 'SATICI_FATURA_TUTAR'
          Column = cxG1DBTV1SATICI_FATURA_TUTAR
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = '#,.##'
          Kind = skSum
          FieldName = 'FATURA_TUTAR'
          Column = cxG1DBTV1FATURA_TUTAR
        end
        item
          Format = '#,.##'
          Kind = skSum
          FieldName = 'SATICI_FATURA_TUTAR'
          Column = cxG1DBTV1SATICI_FATURA_TUTAR
        end
        item
          Kind = skCount
          FieldName = 'GUN_SIRA'
          Column = cxG1DBTV1GUN_SIRA
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.Navigator = True
      OptionsView.Footer = True
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupFooterMultiSummaries = True
      OptionsView.GroupFooters = gfAlwaysVisible
      object cxG1DBTV1SEFER_TAKIP_ID: TcxGridDBColumn
        Caption = #304'd'
        DataBinding.FieldName = 'SEFER_TAKIP_ID'
        Visible = False
        Options.Editing = False
        Width = 42
      end
      object cxG1DBTV1SEFER_TAKIP_SID: TcxGridDBColumn
        Caption = 'S'#304'd'
        DataBinding.FieldName = 'SEFER_TAKIP_SID'
        Visible = False
        Options.Editing = False
        Width = 32
      end
      object cxG1DBTV1GUN_SIRA: TcxGridDBColumn
        Caption = 'G'#252'n S'#305'ra'
        DataBinding.FieldName = 'GUN_SIRA'
        SortIndex = 0
        SortOrder = soAscending
        Width = 50
      end
      object cxG1DBTV1YUKLEME_TARIHI: TcxGridDBColumn
        Caption = 'Y'#252'kleme Tarihi'
        DataBinding.FieldName = 'YUKLEME_TARIHI'
        PropertiesClassName = 'TcxDateEditProperties'
        Width = 91
      end
      object cxG1DBTV1GIRIS_TARIHI: TcxGridDBColumn
        Caption = 'Giri'#351' Tarihi'
        DataBinding.FieldName = 'GIRIS_TARIHI'
        PropertiesClassName = 'TcxDateEditProperties'
        GroupIndex = 0
        Width = 93
      end
      object cxG1DBTV1CEKICI: TcxGridDBColumn
        Caption = #199'ekici'
        DataBinding.FieldName = 'CEKICI'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1CEKICI_PLAKA: TcxGridDBColumn
        Caption = #199'ekici Plaka'
        DataBinding.FieldName = 'CEKICI_PLAKA'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
      end
      object cxG1DBTV1KONT_ALINDI: TcxGridDBColumn
        Caption = 'Konteyn'#305'r Al'#305'nd'#305
        DataBinding.FieldName = 'KONT_ALINDI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        Width = 110
      end
      object cxG1DBTV1DORSE: TcxGridDBColumn
        Caption = 'Dorse'
        DataBinding.FieldName = 'DORSE'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1DORSE_PLAKA: TcxGridDBColumn
        Caption = 'Dorse Plaka'
        DataBinding.FieldName = 'DORSE_PLAKA'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
      end
      object cxG1DBTV1INDIREN: TcxGridDBColumn
        Caption = #304'ndiren'
        DataBinding.FieldName = 'INDIREN'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1INDIREN_PLAKA: TcxGridDBColumn
        Caption = #304'ndiren Plaka'
        DataBinding.FieldName = 'INDIREN_PLAKA'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
      end
      object cxG1DBTV1KIRALIK: TcxGridDBColumn
        Caption = 'Kiral'#305'k'
        DataBinding.FieldName = 'KIRALIK'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1KIRALIK_FIRMA_ADI: TcxGridDBColumn
        Caption = 'Kiral'#305'k'
        DataBinding.FieldName = 'KIRALIK_FIRMA_ADI'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Width = 134
      end
      object cxG1DBTV1KIRALIK_BILDIRILDI: TcxGridDBColumn
        Caption = 'Kiral'#305'k Bildirildi'
        DataBinding.FieldName = 'KIRALIK_BILDIRILDI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        Width = 100
      end
      object cxG1DBTV1GIDECEGI_YER: TcxGridDBColumn
        Caption = 'Gidece'#287'i Yer'
        DataBinding.FieldName = 'GIDECEGI_YER'
        PropertiesClassName = 'TcxMRUEditProperties'
        Properties.ShowEllipsis = False
        Width = 133
      end
      object cxG1DBTV1YUKLEYICI_FIRMA: TcxGridDBColumn
        Caption = 'Y'#252'kleyici Firma'
        DataBinding.FieldName = 'YUKLEYICI_FIRMA'
        PropertiesClassName = 'TcxMRUEditProperties'
        Properties.ShowEllipsis = False
        Width = 139
      end
      object cxG1DBTV1KONT_ALIS_YERI: TcxGridDBColumn
        Caption = 'Kont.Al'#305#351' Yeri'
        DataBinding.FieldName = 'KONT_ALIS_YERI'
        PropertiesClassName = 'TcxMRUEditProperties'
        Properties.ShowEllipsis = False
        Width = 144
      end
      object cxG1DBTV1KONT_TESLIM: TcxGridDBColumn
        Caption = 'Kont. Teslim'
        DataBinding.FieldName = 'KONT_TESLIM'
        PropertiesClassName = 'TcxMRUEditProperties'
        Properties.ShowEllipsis = False
        Width = 146
      end
      object cxG1DBTV1NEVI: TcxGridDBColumn
        Caption = 'Nevi'
        DataBinding.FieldName = 'NEVI'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1NEVI_ESYA_AD: TcxGridDBColumn
        Caption = 'Nevi'
        DataBinding.FieldName = 'NEVI_ESYA_AD'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Width = 143
      end
      object cxG1DBTV1KUMPANYA: TcxGridDBColumn
        Caption = 'Kumpanya'
        DataBinding.FieldName = 'KUMPANYA'
        PropertiesClassName = 'TcxMRUEditProperties'
        Properties.ShowEllipsis = False
        Width = 156
      end
      object cxG1DBTV1BOOKING_NO: TcxGridDBColumn
        Caption = 'Booking No'
        DataBinding.FieldName = 'BOOKING_NO'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 168
      end
      object cxG1DBTV1KONTROL_NO: TcxGridDBColumn
        Caption = 'Kont. No'
        DataBinding.FieldName = 'KONTROL_NO'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 156
      end
      object cxG1DBTV1FIRMAYA_BILDIRILDI: TcxGridDBColumn
        Caption = 'Firmaya Bildirildi'
        DataBinding.FieldName = 'FIRMAYA_BILDIRILDI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        Width = 109
      end
      object cxG1DBTV1MUHUR_NO: TcxGridDBColumn
        Caption = 'M'#252'h'#252'r No'
        DataBinding.FieldName = 'MUHUR_NO'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 158
      end
      object cxG1DBTV1GONDEREN_FIRMA: TcxGridDBColumn
        Caption = 'G'#246'nderen Firma'
        DataBinding.FieldName = 'GONDEREN_FIRMA'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1GONDEREN_FIRMA_ADI: TcxGridDBColumn
        Caption = 'G'#246'nderen Firma Ad'#305
        DataBinding.FieldName = 'GONDEREN_FIRMA_ADI'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.ReadOnly = True
        Width = 147
      end
      object cxG1DBTV1FIRMA_EKKOD: TcxGridDBColumn
        Caption = 'Firma Ek Kod'
        DataBinding.FieldName = 'FIRMA_EKKOD'
        PropertiesClassName = 'TcxMRUEditProperties'
        Properties.ShowEllipsis = False
      end
      object cxG1DBTV1GEMI_ADI: TcxGridDBColumn
        Caption = 'Gemi Ad'#305
        DataBinding.FieldName = 'GEMI_ADI'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 142
      end
      object cxG1DBTV1TAHLIYE_LIMANI: TcxGridDBColumn
        Caption = 'Tahliye Liman'#305
        DataBinding.FieldName = 'TAHLIYE_LIMANI'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 143
      end
      object cxG1DBTV1FATURA_NO: TcxGridDBColumn
        Caption = 'Fatura No'
        DataBinding.FieldName = 'FATURA_NO'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 94
      end
      object cxG1DBTV1FATURA_TUTAR: TcxGridDBColumn
        Caption = 'Fatura Tutar'#305
        DataBinding.FieldName = 'FATURA_TUTAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 103
      end
      object cxG1DBTV1SATICI_FATURA_TUTAR: TcxGridDBColumn
        Caption = 'Sat'#305'c'#305' Fatura Tutar'
        DataBinding.FieldName = 'SATICI_FATURA_TUTAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 114
      end
      object cxG1DBTV1SEFER_TAMAMLANDI: TcxGridDBColumn
        Caption = 'Sefer Tamamland'#305
        DataBinding.FieldName = 'SEFER_TAMAMLANDI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        Width = 119
      end
      object cxG1DBTV1SATIS_FATURASI_KESILDI: TcxGridDBColumn
        Caption = 'Sat'#305#351' Faturas'#305' Kesildi'
        DataBinding.FieldName = 'SATIS_FATURASI_KESILDI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ReadOnly = True
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        Options.Editing = False
        VisibleForCustomization = False
        Width = 119
      end
      object cxG1DBTV1ALIS_FATURASI_ALINDI: TcxGridDBColumn
        Caption = 'Al'#305#351' Faturas'#305' Al'#305'nd'#305
        DataBinding.FieldName = 'ALIS_FATURASI_ALINDI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ReadOnly = True
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        Options.Editing = False
        VisibleForCustomization = False
        Width = 123
      end
      object cxG1DBTV1PERSONEL_KOD: TcxGridDBColumn
        Caption = 'Personel Kod'
        DataBinding.FieldName = 'PERSONEL_KOD'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1PERSONEL_ADI: TcxGridDBColumn
        Caption = 'Personel Ad'#305
        DataBinding.FieldName = 'PERSONEL_ADI'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Width = 141
      end
      object cxG1DBTV1SEFERLESTI: TcxGridDBColumn
        Caption = 'Seferle'#351'ti'
        DataBinding.FieldName = 'SEFERLESTI'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ReadOnly = True
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Visible = False
        Options.Moving = False
        Width = 75
      end
      object cxG1DBTV1SEFER_ID: TcxGridDBColumn
        Caption = 'Sefer Id'
        DataBinding.FieldName = 'SEFER_ID'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1ACIKLAMA: TcxGridDBColumn
        Caption = 'A'#231#305'klama'
        DataBinding.FieldName = 'ACIKLAMA'
        Width = 354
      end
      object cxG1DBTV1BEKLEME_FAT_VAR: TcxGridDBColumn
        Caption = 'Bekleme Faturas'#305' Var'
        DataBinding.FieldName = 'BEKLEME_FAT_VAR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Width = 150
      end
      object cxG1DBTV1BEKLEME_FAT_TUTAR: TcxGridDBColumn
        Caption = 'Bekleme Fatura Tutar'
        DataBinding.FieldName = 'BEKLEME_FAT_TUTAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 150
      end
      object cxG1DBTV1BEKLEME_FAT_KESILDI: TcxGridDBColumn
        Caption = 'Bekleme Faturas'#305' Kesildi'
        DataBinding.FieldName = 'BEKLEME_FAT_KESILDI'
        Visible = False
        VisibleForCustomization = False
      end
      object cxG1DBTV1SBEKLEME_FAT_VAR: TcxGridDBColumn
        Caption = 'Sat'#305'c'#305' Bekleme Faturas'#305' Var'
        DataBinding.FieldName = 'SBEKLEME_FAT_VAR'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ValueChecked = 1
        Properties.ValueUnchecked = 0
        Width = 150
      end
      object cxG1DBTV1SBEKLEME_FAT_TUTAR: TcxGridDBColumn
        Caption = 'Sat'#305'c'#305' Bekleme Fatura Tutar'
        DataBinding.FieldName = 'SBEKLEME_FAT_TUTAR'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 150
      end
      object cxG1DBTV1SBEKLEME_FAT_KESILDI: TcxGridDBColumn
        DataBinding.FieldName = 'SBEKLEME_FAT_KESILDI'
        Visible = False
        VisibleForCustomization = False
      end
    end
    object cxGL1: TcxGridLevel
      GridView = cxG1DBTV1
    end
  end
  object cxBu_Kayit_Getir: TcxButton
    Left = 400
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Tarihler Aras'#305' Kay'#305'tlar'#305' Getir'
    TabOrder = 2
    OnClick = cxBu_Kayit_GetirClick
  end
  object cxDateEdit2: TcxDateEdit
    Left = 256
    Top = 8
    TabOrder = 3
    Width = 121
  end
  object cxLabel2: TcxLabel
    Left = 204
    Top = 8
    Caption = 'Son Tarih'
  end
  object cxLabel1: TcxLabel
    Left = 8
    Top = 8
    Caption = #304'lk Tarih'
  end
  object cxDateEdit1: TcxDateEdit
    Left = 56
    Top = 8
    TabOrder = 6
    Width = 121
  end
  object cxButton1: TcxButton
    Left = 8
    Top = 456
    Width = 74
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Se'#231
    TabOrder = 7
    OnClick = cxButton1Click
  end
  object cxLocalizer1: TcxLocalizer
    FileName = 'C:\CedaLite_Ym\devtrk\Tumu.ini'
    Left = 584
    Top = 280
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 560
    Top = 352
    PixelsPerInch = 96
  end
  object qry_Sefer_Takip: TIBOQuery
    Params = <
      item
        DataType = ftDate
        Name = 'TAR1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'TAR2'
        ParamType = ptInput
      end>
    DatabaseName = 'C:\DB2011.FDB'
    IB_Connection = DataMod.dbaMain
    KeyLinks.Strings = (
      'SEFER_TAKIP.SEFER_TAKIP_ID')
    RecordCountAccurate = True
    SQL.Strings = (
      'SELECT'
      '      SEFER_TAKIP_ID'
      '     , SEFER_TAKIP_SID'
      '     , GUN_SIRA'
      '     , YUKLEME_TARIHI'
      '     , GIRIS_TARIHI'
      '     , CEKICI'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.CE' +
        'KICI) AS CEKICI_PLAKA'
      ''
      '     , DORSE'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.DO' +
        'RSE) AS DORSE_PLAKA'
      '     , INDIREN'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.IN' +
        'DIREN) AS INDIREN_PLAKA'
      ''
      ''
      '     , KIRALIK'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SEFER_TAKIP.KIRALIK=CARI.C' +
        'ARI_KOD) AS KIRALIK_FIRMA_ADI'
      ''
      '     , GIDECEGI_YER'
      '     , YUKLEYICI_FIRMA'
      '     , KONT_ALIS_YERI'
      '     , KONT_TESLIM'
      '     , NEVI'
      
        '     ,(SELECT ESYA_AD FROM ESYA WHERE ESYA.ESYA_ID=SEFER_TAKIP.N' +
        'EVI) AS NEVI_ESYA_AD'
      ''
      '     , KUMPANYA'
      '     , BOOKING_NO'
      '     , KONTROL_NO'
      '     , MUHUR_NO'
      '     , GONDEREN_FIRMA'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SEFER_TAKIP.GONDEREN_FIRMA' +
        '=CARI.CARI_KOD) AS GONDEREN_FIRMA_ADI'
      ''
      '     , GEMI_ADI'
      '     , TAHLIYE_LIMANI'
      '     , FATURA_NO'
      '     , FATURA_TUTAR'
      '     , SATICI_FATURA_TUTAR'
      '     , SEFER_TAMAMLANDI'
      '     , SATIS_FATURASI_KESILDI'
      '     , ALIS_FATURASI_ALINDI'
      '     , PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=SEFER_TAKIP.PERSONEL_KOD) AS PERSONEL_ADI'
      '     , SEFERLESTI'
      '     , SEFER_ID'
      '     , KONT_ALINDI'
      '     , KIRALIK_BILDIRILDI'
      '     , FIRMAYA_BILDIRILDI'
      '     , FIRMA_EKKOD'
      '     , ACIKLAMA'
      '     , BEKLEME_FAT_VAR'
      '     , BEKLEME_FAT_TUTAR'
      '     , BEKLEME_FAT_KESILDI'
      '     , SBEKLEME_FAT_VAR'
      '     , SBEKLEME_FAT_TUTAR'
      '     , SBEKLEME_FAT_KESILDI'
      ''
      ''
      'FROM SEFER_TAKIP'
      ''
      'WHERE GIRIS_TARIHI>=:TAR1 AND '
      'GIRIS_TARIHI<=:TAR2'
      ''
      'ORDER BY SEFER_TAKIP_ID')
    FieldOptions = []
    Left = 96
    Top = 248
    object qry_Sefer_TakipSEFER_TAKIP_ID: TIntegerField
      FieldName = 'SEFER_TAKIP_ID'
    end
    object qry_Sefer_TakipSEFER_TAKIP_SID: TSmallintField
      FieldName = 'SEFER_TAKIP_SID'
      Required = True
    end
    object qry_Sefer_TakipGUN_SIRA: TIntegerField
      FieldName = 'GUN_SIRA'
    end
    object qry_Sefer_TakipYUKLEME_TARIHI: TDateField
      FieldName = 'YUKLEME_TARIHI'
    end
    object qry_Sefer_TakipGIRIS_TARIHI: TDateField
      FieldName = 'GIRIS_TARIHI'
    end
    object qry_Sefer_TakipCEKICI: TStringField
      FieldName = 'CEKICI'
      Size = 15
    end
    object qry_Sefer_TakipDORSE: TStringField
      FieldName = 'DORSE'
      Size = 15
    end
    object qry_Sefer_TakipINDIREN: TStringField
      FieldName = 'INDIREN'
      Size = 15
    end
    object qry_Sefer_TakipGIDECEGI_YER: TStringField
      FieldName = 'GIDECEGI_YER'
      Size = 30
    end
    object qry_Sefer_TakipYUKLEYICI_FIRMA: TStringField
      FieldName = 'YUKLEYICI_FIRMA'
      Size = 30
    end
    object qry_Sefer_TakipKONT_ALIS_YERI: TStringField
      FieldName = 'KONT_ALIS_YERI'
      Size = 30
    end
    object qry_Sefer_TakipKONT_TESLIM: TStringField
      FieldName = 'KONT_TESLIM'
      Size = 30
    end
    object qry_Sefer_TakipKUMPANYA: TStringField
      FieldName = 'KUMPANYA'
      Size = 30
    end
    object qry_Sefer_TakipBOOKING_NO: TStringField
      FieldName = 'BOOKING_NO'
      Size = 30
    end
    object qry_Sefer_TakipKONTROL_NO: TStringField
      FieldName = 'KONTROL_NO'
      Size = 30
    end
    object qry_Sefer_TakipMUHUR_NO: TStringField
      FieldName = 'MUHUR_NO'
      Size = 30
    end
    object qry_Sefer_TakipGONDEREN_FIRMA: TStringField
      FieldName = 'GONDEREN_FIRMA'
      Size = 15
    end
    object qry_Sefer_TakipGEMI_ADI: TStringField
      FieldName = 'GEMI_ADI'
      Size = 30
    end
    object qry_Sefer_TakipTAHLIYE_LIMANI: TStringField
      FieldName = 'TAHLIYE_LIMANI'
      Size = 30
    end
    object qry_Sefer_TakipFATURA_NO: TStringField
      FieldName = 'FATURA_NO'
      Size = 30
    end
    object qry_Sefer_TakipFATURA_TUTAR: TBCDField
      FieldName = 'FATURA_TUTAR'
      Size = 8
    end
    object qry_Sefer_TakipSATICI_FATURA_TUTAR: TBCDField
      FieldName = 'SATICI_FATURA_TUTAR'
      Size = 8
    end
    object qry_Sefer_TakipSEFER_TAMAMLANDI: TSmallintField
      FieldName = 'SEFER_TAMAMLANDI'
      Required = True
    end
    object qry_Sefer_TakipSATIS_FATURASI_KESILDI: TSmallintField
      FieldName = 'SATIS_FATURASI_KESILDI'
      Required = True
    end
    object qry_Sefer_TakipALIS_FATURASI_ALINDI: TSmallintField
      FieldName = 'ALIS_FATURASI_ALINDI'
      Required = True
    end
    object qry_Sefer_TakipPERSONEL_KOD: TStringField
      FieldName = 'PERSONEL_KOD'
      Size = 15
    end
    object qry_Sefer_TakipSEFERLESTI: TSmallintField
      FieldName = 'SEFERLESTI'
      Required = True
    end
    object qry_Sefer_TakipSEFER_ID: TIntegerField
      FieldName = 'SEFER_ID'
    end
    object qry_Sefer_TakipCEKICI_PLAKA: TStringField
      FieldName = 'CEKICI_PLAKA'
      ReadOnly = True
      Size = 15
    end
    object qry_Sefer_TakipDORSE_PLAKA: TStringField
      FieldName = 'DORSE_PLAKA'
      ReadOnly = True
      Size = 15
    end
    object qry_Sefer_TakipINDIREN_PLAKA: TStringField
      FieldName = 'INDIREN_PLAKA'
      ReadOnly = True
      Size = 15
    end
    object qry_Sefer_TakipNEVI_ESYA_AD: TStringField
      FieldName = 'NEVI_ESYA_AD'
      ReadOnly = True
      Size = 30
    end
    object qry_Sefer_TakipGONDEREN_FIRMA_ADI: TStringField
      FieldName = 'GONDEREN_FIRMA_ADI'
      ReadOnly = True
      Size = 50
    end
    object qry_Sefer_TakipPERSONEL_ADI: TStringField
      FieldName = 'PERSONEL_ADI'
      ReadOnly = True
      Size = 30
    end
    object qry_Sefer_TakipNEVI: TIntegerField
      FieldName = 'NEVI'
    end
    object qry_Sefer_TakipKIRALIK: TStringField
      FieldName = 'KIRALIK'
      Size = 15
    end
    object qry_Sefer_TakipKIRALIK_FIRMA_ADI: TStringField
      FieldName = 'KIRALIK_FIRMA_ADI'
      ReadOnly = True
      Size = 50
    end
    object qry_Sefer_TakipKONT_ALINDI: TSmallintField
      FieldName = 'KONT_ALINDI'
      Required = True
    end
    object qry_Sefer_TakipKIRALIK_BILDIRILDI: TSmallintField
      FieldName = 'KIRALIK_BILDIRILDI'
      Required = True
    end
    object qry_Sefer_TakipFIRMAYA_BILDIRILDI: TSmallintField
      FieldName = 'FIRMAYA_BILDIRILDI'
      Required = True
    end
    object qry_Sefer_TakipFIRMA_EKKOD: TStringField
      FieldName = 'FIRMA_EKKOD'
      Size = 30
    end
    object qry_Sefer_TakipACIKLAMA: TStringField
      FieldName = 'ACIKLAMA'
      Size = 100
    end
    object qry_Sefer_TakipBEKLEME_FAT_VAR: TSmallintField
      FieldName = 'BEKLEME_FAT_VAR'
      Required = True
    end
    object qry_Sefer_TakipBEKLEME_FAT_TUTAR: TBCDField
      FieldName = 'BEKLEME_FAT_TUTAR'
    end
    object qry_Sefer_TakipBEKLEME_FAT_KESILDI: TSmallintField
      FieldName = 'BEKLEME_FAT_KESILDI'
      Required = True
    end
    object qry_Sefer_TakipSBEKLEME_FAT_VAR: TSmallintField
      FieldName = 'SBEKLEME_FAT_VAR'
      Required = True
    end
    object qry_Sefer_TakipSBEKLEME_FAT_TUTAR: TBCDField
      FieldName = 'SBEKLEME_FAT_TUTAR'
    end
    object qry_Sefer_TakipSBEKLEME_FAT_KESILDI: TSmallintField
      FieldName = 'SBEKLEME_FAT_KESILDI'
      Required = True
    end
  end
  object dtsSefer_Takip: TDataSource
    AutoEdit = False
    DataSet = qry_Sefer_Takip
    Left = 96
    Top = 184
  end
end
