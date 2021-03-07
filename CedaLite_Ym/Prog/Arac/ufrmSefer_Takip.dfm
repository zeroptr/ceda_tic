object frmSefer_Takip: TfrmSefer_Takip
  Left = 0
  Top = 0
  Caption = 'Sefer Takip'
  ClientHeight = 615
  ClientWidth = 1144
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    1144
    615)
  PixelsPerInch = 96
  TextHeight = 13
  object cxG1: TcxGrid
    Left = 8
    Top = 37
    Width = 1128
    Height = 539
    Anchors = [akLeft, akTop, akRight, akBottom]
    PopupMenu = PoMen
    TabOrder = 0
    object cxG1DBTV1: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      NavigatorButtons.Insert.Visible = True
      NavigatorButtons.Append.Visible = True
      NavigatorButtons.Delete.Hint = 'Delete'
      NavigatorButtons.Edit.Hint = 'Ctrl E'
      NavigatorButtons.SaveBookmark.Visible = False
      NavigatorButtons.GotoBookmark.Visible = False
      OnCustomDrawCell = cxG1DBTV1CustomDrawCell
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
        end
        item
          Format = '#,.##'
          Kind = skSum
          Position = spFooter
          FieldName = 'BEKLEME_FAT_TUTAR'
          Column = cxG1DBTV1BEKLEME_FAT_TUTAR
        end
        item
          Format = '#,.##'
          Kind = skSum
          Position = spFooter
          FieldName = 'SBEKLEME_FAT_TUTAR'
          Column = cxG1DBTV1SBEKLEME_FAT_TUTAR
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
        end
        item
          Format = '#,.##'
          Kind = skSum
          FieldName = 'BEKLEME_FAT_TUTAR'
          Column = cxG1DBTV1BEKLEME_FAT_TUTAR
        end
        item
          Format = '#,.##'
          Kind = skSum
          FieldName = 'SBEKLEME_FAT_TUTAR'
          Column = cxG1DBTV1SBEKLEME_FAT_TUTAR
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Appending = True
      OptionsData.DeletingConfirmation = False
      OptionsView.Navigator = True
      OptionsView.Footer = True
      OptionsView.FooterMultiSummaries = True
      OptionsView.GroupFooterMultiSummaries = True
      OptionsView.GroupFooters = gfAlwaysVisible
      Styles.Background = cxStyle1
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
        OnCustomDrawCell = cxG1DBTV1YUKLEME_TARIHICustomDrawCell
        Width = 91
      end
      object cxG1DBTV1GIRIS_TARIHI: TcxGridDBColumn
        Caption = 'Giri'#351' Tarihi'
        DataBinding.FieldName = 'GIRIS_TARIHI'
        PropertiesClassName = 'TcxDateEditProperties'
        Visible = False
        GroupIndex = 0
        SortIndex = 1
        SortOrder = soAscending
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
        Properties.OnButtonClick = cxG1DBTV1CEKICI_PLAKAPropertiesButtonClick
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
        Caption = 'Alan Plaka'
        DataBinding.FieldName = 'DORSE'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1DORSE_PLAKA: TcxGridDBColumn
        Caption = 'Alan Plaka'
        DataBinding.FieldName = 'DORSE_PLAKA'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = cxG1DBTV1DORSE_PLAKAPropertiesButtonClick
      end
      object cxG1DBTV1Y_DORSE_PLAKA: TcxGridDBColumn
        Caption = 'Dorse Plaka Kod'
        DataBinding.FieldName = 'Y_DORSE_PLAKA'
        Visible = False
      end
      object cxG1DBTV1Y_DORSE_PLAKAS: TcxGridDBColumn
        Caption = 'Dorse Plaka'
        DataBinding.FieldName = 'Y_DORSE_PLAKAS'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = cxG1DBTV1Y_DORSE_PLAKASPropertiesButtonClick
      end
      object cxG1DBTV1NOTLAR: TcxGridDBColumn
        Caption = 'Notlar'
        DataBinding.FieldName = 'NOTLAR'
        Width = 138
      end
      object cxG1DBTV1INDIREN: TcxGridDBColumn
        Caption = #304'ndiren'
        DataBinding.FieldName = 'INDIREN'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1MASTER_S_TAKIP_ID: TcxGridDBColumn
        Caption = 'Ana Sefer Takip'
        DataBinding.FieldName = 'MASTER_S_TAKIP_ID'
        Options.Editing = False
        SortIndex = 2
        SortOrder = soDescending
        Width = 90
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
        Properties.OnButtonClick = cxG1DBTV1INDIREN_PLAKAPropertiesButtonClick
      end
      object cxG1DBTV1KIRALIK: TcxGridDBColumn
        Caption = 'Kiral'#305'k'
        DataBinding.FieldName = 'KIRALIK'
        Visible = False
        Options.Editing = False
      end
      object cxG1DBTV1NOTLAR_IND: TcxGridDBColumn
        Caption = 'Notlar '#304'ndiren'
        DataBinding.FieldName = 'NOTLAR_IND'
        Width = 164
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
        Properties.OnButtonClick = cxG1DBTV1KIRALIK_FIRMA_ADIPropertiesButtonClick
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
        Properties.OnButtonClick = cxG1DBTV1NEVI_ESYA_ADPropertiesButtonClick
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
        Properties.OnButtonClick = cxG1DBTV1GONDEREN_FIRMA_ADIPropertiesButtonClick
        Width = 147
      end
      object cxG1DBTV1FIRMA_EKKOD: TcxGridDBColumn
        Caption = 'Firma Ek Kod'
        DataBinding.FieldName = 'FIRMA_EKKOD'
        PropertiesClassName = 'TcxTextEditProperties'
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
        Properties.OnButtonClick = cxG1DBTV1PERSONEL_ADIPropertiesButtonClick
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
      object cxG1DBTV1HARCIRAH: TcxGridDBColumn
        Caption = 'Harc'#305'rah'
        DataBinding.FieldName = 'HARCIRAH'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 90
      end
    end
    object cxG1TableView1: TcxGridTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
    end
    object cxGL1: TcxGridLevel
      GridView = cxG1DBTV1
    end
  end
  object cxBu_Seferlerstir: TcxButton
    Left = 466
    Top = 582
    Width = 129
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Aktif Kayd'#305' Seferle'#351'tir'
    TabOrder = 1
    Visible = False
    OnClick = cxBu_SeferlerstirClick
  end
  object cxButton2: TcxButton
    Left = 1062
    Top = 582
    Width = 74
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #199#305'k'#305#351
    TabOrder = 2
    OnClick = cxButton2Click
  end
  object cxBu_Sefere_Git: TcxButton
    Left = 751
    Top = 582
    Width = 129
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Aktif Kayd'#305'n Seferine Git'
    TabOrder = 3
    Visible = False
    OnClick = cxBu_Sefere_GitClick
  end
  object cxDateEdit1: TcxDateEdit
    Left = 56
    Top = 8
    TabOrder = 4
    Width = 121
  end
  object cxDateEdit2: TcxDateEdit
    Left = 256
    Top = 8
    TabOrder = 5
    Width = 121
  end
  object cxLabel1: TcxLabel
    Left = 8
    Top = 8
    Caption = #304'lk Tarih'
  end
  object cxLabel2: TcxLabel
    Left = 204
    Top = 8
    Caption = 'Son Tarih'
  end
  object cxBu_Kayit_Getir: TcxButton
    Left = 400
    Top = 8
    Width = 153
    Height = 25
    Caption = 'Tarihler Aras'#305' Kay'#305'tlar'#305' Getir'
    TabOrder = 8
    OnClick = cxBu_Kayit_GetirClick
  end
  object cxBu_Sefer_Kaydi_Iptal_Et: TcxButton
    Left = 601
    Top = 582
    Width = 144
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Aktif Kayd'#305'n Seferini '#304'ptal Et'
    TabOrder = 9
    Visible = False
    OnClick = cxBu_Sefer_Kaydi_Iptal_EtClick
  end
  object cxBu_GKa: TcxButton
    Left = 1031
    Top = 8
    Width = 105
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Grid D'#252'zeni Kaydet'
    TabOrder = 10
    OnClick = cxBu_GKaClick
  end
  object cxBu_GGe: TcxButton
    Left = 942
    Top = 8
    Width = 83
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Grid D'#252'zeni Al'
    TabOrder = 11
    OnClick = cxBu_GGeClick
  end
  object cxButton1: TcxButton
    Left = 678
    Top = 8
    Width = 55
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Yaz'#305'c'#305
    TabOrder = 12
    OnClick = cxButton1Click
  end
  object cxButton3: TcxButton
    Left = 755
    Top = 8
    Width = 73
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Excel Export'
    TabOrder = 13
    OnClick = cxButton3Click
  end
  object cxChGd: TcxCheckBox
    Left = 834
    Top = 10
    Anchors = [akTop, akRight]
    Caption = 'Farkl'#305' Kaydet/A'#231
    TabOrder = 14
    Width = 106
  end
  object cxBu_Yapistir: TcxButton
    Left = 82
    Top = 582
    Width = 129
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Adet Kay'#305't Ekle'
    Enabled = False
    TabOrder = 15
    OnClick = cxBu_YapistirClick
  end
  object cxSp_Kay_Say: TcxSpinEdit
    Left = 8
    Top = 584
    Anchors = [akLeft, akBottom]
    Properties.MaxValue = 100.000000000000000000
    TabOrder = 16
    Value = 1
    Width = 57
  end
  object dtsSefer_Takip: TDataSource
    AutoEdit = False
    DataSet = qry_Sefer_Takip
    Left = 104
    Top = 184
  end
  object qry_Sefer_Takip: TIBOQuery
    Params = <
      item
        DataType = ftUnknown
        Name = 'TAR1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TAR2'
        ParamType = ptUnknown
      end>
    DatabaseName = 'C:\ekinci_data\EKINCI2020.FDB'
    IB_Connection = DataMod.dbaMain
    KeyLinks.Strings = (
      'SEFER_TAKIP.SEFER_TAKIP_ID')
    RecordCountAccurate = True
    BeforeCancel = qry_Sefer_TakipBeforeCancel
    BeforeDelete = qry_Sefer_TakipBeforeDelete
    AfterInsert = qry_Sefer_TakipAfterInsert
    AfterScroll = qry_Sefer_TakipAfterScroll
    BeforePost = qry_Sefer_TakipBeforePost
    RequestLive = True
    SQL.Strings = (
      'SELECT'
      '      SEFER_TAKIP_ID'
      '     , SEFER_TAKIP_SID'
      '     , GUN_SIRA'
      '     , YUKLEME_TARIHI'
      '     , GIRIS_TARIHI'
      '     , CEKICI'
      
        '     , (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.C' +
        'EKICI) AS CEKICI_PLAKA'
      '     , DORSE'
      
        '     , (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.D' +
        'ORSE) AS DORSE_PLAKA'
      '     , INDIREN'
      
        '     , (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.I' +
        'NDIREN) AS INDIREN_PLAKA'
      '     , Y_DORSE_PLAKA'
      
        '     , (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER_TAKIP.Y' +
        '_DORSE_PLAKA) AS Y_DORSE_PLAKAS'
      '     , KIRALIK'
      
        '     , (SELECT CARI_AD FROM CARI WHERE SEFER_TAKIP.KIRALIK=CARI.' +
        'CARI_KOD) AS KIRALIK_FIRMA_ADI'
      '     , GIDECEGI_YER'
      '     , YUKLEYICI_FIRMA'
      '     , KONT_ALIS_YERI'
      '     , KONT_TESLIM'
      '     , NEVI'
      
        '     ,(SELECT ESYA_AD FROM ESYA WHERE ESYA.ESYA_ID=SEFER_TAKIP.N' +
        'EVI) AS NEVI_ESYA_AD'
      '     , KUMPANYA'
      '     , BOOKING_NO'
      '     , KONTROL_NO'
      '     , MUHUR_NO'
      '     , GONDEREN_FIRMA'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SEFER_TAKIP.GONDEREN_FIRMA' +
        '=CARI.CARI_KOD) AS GONDEREN_FIRMA_ADI'
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
      '     , HARCIRAH'
      '     , NOTLAR'
      '     , NOTLAR_IND'
      '     , MASTER_S_TAKIP_ID'
      'FROM SEFER_TAKIP'
      
        'WHERE SEFER_TAKIP.GIRIS_TARIHI>=:TAR1 AND SEFER_TAKIP.GIRIS_TARI' +
        'HI<=:TAR2 '
      'ORDER BY SEFER_TAKIP.SEFER_TAKIP_ID')
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
      Size = 8
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
      Size = 8
    end
    object qry_Sefer_TakipSBEKLEME_FAT_KESILDI: TSmallintField
      FieldName = 'SBEKLEME_FAT_KESILDI'
      Required = True
    end
    object qry_Sefer_TakipY_DORSE_PLAKA: TStringField
      FieldName = 'Y_DORSE_PLAKA'
      Size = 15
    end
    object qry_Sefer_TakipY_DORSE_PLAKAS: TStringField
      FieldName = 'Y_DORSE_PLAKAS'
      ReadOnly = True
      Size = 15
    end
    object qry_Sefer_TakipHARCIRAH: TBCDField
      FieldName = 'HARCIRAH'
      Size = 8
    end
    object qry_Sefer_TakipNOTLAR: TStringField
      FieldName = 'NOTLAR'
      Size = 50
    end
    object qry_Sefer_TakipNOTLAR_IND: TStringField
      FieldName = 'NOTLAR_IND'
      Size = 50
    end
    object qry_Sefer_TakipMASTER_S_TAKIP_ID: TIntegerField
      FieldName = 'MASTER_S_TAKIP_ID'
    end
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = cxG1
    PopupMenus = <>
    Left = 848
    Top = 224
  end
  object qrySefer: TIB_Query
    ColumnAttributes.Strings = (
      'BEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SEFER_ALIS_FAT_ALINDI=BOOLEAN=1,0'
      'SEFER_SATIS_FAT_KESILDI=BOOLEAN=1,0'
      'SEFER_TAMAMLANDI=BOOLEAN=1,0'
      'BEKLEME_FATURASI_KESILDI=BOOLEAN=1,0'
      'SBEKLEME_FAT_VAR=BOOLEAN=1,0')
    DatabaseName = 'C:\ekinci_data\EKINCI2020.FDB'
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=Hareket A'#231#305'klamas'#305
      'KASA_AD=Kasa Ad'#305
      'CH_ACIKLAMA=C/H A'#231#305'klama'
      'YEV_ACIKLAMA=Yevmiye Defteri A'#231#305'klama'
      'KASAHAR_ID=FIS NO'
      'ARAC_KOD=Ara'#231' Kodu'
      'SEFER_SAY=Sefer Say'#305's'#305
      'ARAC_PLAKA=Ara'#231' Plaka'
      'ALICI_KOD=Al'#305'c'#305' Kodu'
      'ALICI_ADI=Al'#305'c'#305' Ad'#305
      'SATICI_KOD=Sat'#305'c'#305' Kodu'
      'SATICI_ADI=Sat'#305'c'#305' Ad'#305
      'PERSONEL_KOD=Personel Kodu'
      'PERSONEL_ADI=Personel Ad'#305
      'OLCU_TIP='#214'l'#231#252' Tip'
      'OLCU_BIRIM='#214'l'#231#252' Birim'
      'TASINAN_ESYA=Ta'#351#305'nan E'#351'ya'
      'BAS_TAR=Ba'#351'lama Tarihi'
      'BIT_TAR=Biti'#351' Tarihi'
      'CIK_YER='#199#305'k'#305#351' Yeri'
      'BIT_YER=Var'#305#351' Yeri'
      'ALICI_BORC_BIRIM_FIY=Birim Fiyat'#305
      'ALICI_B_DOVKOD=D'#246'viz Kodu'
      'ALICI_BORC=Bor'#231
      'ALICI_BORC_VPB=Bor'#231' Vpb'
      'SATICI_ALACAK_BIRIM_FIY=Birim Fiyat'#305
      'SATICI_A_DOVKOD=D'#246'viz Kodu'
      'SATICI_ALACAK=Alacak'
      'SATICI_ALACAK_VPB=Alacak Vpb'
      'BEKLEME_FAT_VAR=Bekleme Faturas'#305
      'BEKLEME_FAT_TUTAR=Tutar'
      'BEKLEME_FAT_DOV_KOD=D'#246'viz Kodu'
      'BEKLEME_FAT_VPB=Tutar Vpb'
      'SEFER_NOTLARI=Sefer Notlar'#305
      'SEFER_ALIS_FAT_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305
      'SEFER_SATIS_FAT_KESILDI=Sat'#305#351' Faturas'#305' Kesildi'
      'SEFER_ID=Sefer No'
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4'
      'ALICI_B_DOV_BAZ_TAR=Al'#305'c'#305' D'#246'v.Baz.Tar'
      'SATICI_A_DOV_BAZ_TAR=Sat'#305'c'#305' D'#246'v.Baz.Tar'
      'BEKLEME_FAT_DOV_BAZ_TAR=Fatura D'#246'v.Baz.Tar'
      'DORSE_KOD=Dorse Kod'
      'DARAC_PLAKA=Drose Plaka'
      'SEFER_TAMAMLANDI=Sefer Tamamland'#305
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'SATIS_URUN_HAR_ID=Sat'#305#351' Faturas'#305' Hareket No'
      'BEKLEME_FATURASI_KESILDI=Bekleme Faturas'#305' Kesildi'
      'MIKTAR=Miktar'#305
      'FATURA_MIK_SEF=Fa. Sef.Say.Mik.'
      'KONTEYNER_NO=Konteyner No'
      'SBEKLEME_FAT_DOV_KOD=D'#246'viz Kodu'
      'SBEKLEME_FAT_TUTAR=Tutar'
      'SBEKLEME_FAT_VAR=Bekleme Faturas'#305
      'SBEKLEME_FATURASI_KESILDI=sBekleme Faturas'#305' Kesildi'
      'SBEKLEME_FAT_VPB=Tutar Vpb'
      'SBEKLEME_FAT_DOV_BAZ_TAR=D'#246'v Baz Tar')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'SECIM=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnSefer
    SQL.Strings = (
      'SELECT SEFER_ID'
      '     , SEFER_SID'
      '     , SEFER_SAY'
      '     , ARAC_KOD'
      
        '     ,(SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD' +
        ') AS ARAC_PLAKA'
      '     , ALICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_' +
        'KOD) AS ALICI_ADI'
      '     , SATICI_KOD'
      
        '     ,(SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI' +
        '_KOD) AS SATICI_ADI'
      '     , PERSONEL_KOD'
      
        '     ,(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_K' +
        'OD=SEFER.PERSONEL_KOD) AS PERSONEL_ADI'
      '     , OLCU_TIP'
      '     , OLCU_BIRIM'
      '     , TASINAN_ESYA'
      '     , BAS_TAR'
      '     , BIT_TAR'
      '     , CIK_YER'
      '     , BIT_YER'
      '     , ALICI_BORC_BIRIM_FIY'
      '     , ALICI_B_DOVKOD'
      '     , ALICI_BORC'
      '     , ALICI_BORC_VPB'
      '     , SATICI_ALACAK_BIRIM_FIY'
      '     , SATICI_A_DOVKOD'
      '     , SATICI_ALACAK'
      '     , SATICI_ALACAK_VPB'
      '     , BEKLEME_FAT_VAR'
      '     , BEKLEME_FAT_TUTAR'
      '     , BEKLEME_FAT_DOV_KOD'
      '     , BEKLEME_FAT_VPB'
      '     , SEFER_NOTLARI'
      '     , SEFER_ALIS_FAT_ALINDI'
      '     , SEFER_SATIS_FAT_KESILDI'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , ALICI_B_DOV_BAZ_TAR'
      '     , SATICI_A_DOV_BAZ_TAR'
      '     , BEKLEME_FAT_DOV_BAZ_TAR'
      '     , ALICI_B_DOVKUR'
      '     , SATICI_A_DOVKUR'
      '     , BEKLEME_FAT_DOVKUR'
      '     , DORSE_KOD '
      
        '     ,(SELECT PLAKA FROM ARAC AR WHERE AR.ARAC_KOD=SEFER.DORSE_K' +
        'OD) AS DARAC_PLAKA'
      '     , SEFER_TAMAMLANDI'
      '     , ALIS_URUN_HAR_ID'
      '     , SATIS_URUN_HAR_ID'
      '     , BEKLEME_FATURASI_KESILDI'
      '     , BEK_FAT_URUN_HAR_ID'
      '     , SECIM'
      '     , MIKTAR'
      '     , FATURA_MIK_SEF'
      '     , ESYA_ID'
      '     , KONTEYNER_NO'
      '   , SBEKLEME_FAT_VAR'
      '   , SBEKLEME_FAT_TUTAR'
      '   , SBEKLEME_FAT_DOV_KOD'
      '   , SBEKLEME_FAT_VPB'
      '   , SBEKLEME_FAT_DOV_BAZ_TAR'
      '   , SBEKLEME_FAT_DOVKUR'
      '   , SBEKLEME_FATURASI_KESILDI'
      '   , SBEK_FAT_URUN_HAR_ID'
      '   , SEFER_TAKIP_ID'
      '   , YUKLEYICI_FIRMA'
      ''
      'FROM SEFER'
      'WHERE SEFER_ID=:PRM_SEFER_ID AND SEFER_SID=:PRM_SEFER_SID')
    AutoFetchAll = True
    ColorScheme = False
    DefaultValues.Strings = (
      'BELGE_SID=1'
      'BELGE_ID=0'
      'TIP=G'
      'KASADEGER=0'
      'ISLEM_TIP=1'
      'MC=C'
      'DOVKUR=0'
      'TUTAR=0'
      'TUTAR_VPB=0'
      'MIKTAR=0')
    KeyLinks.Strings = (
      'SEFER.SEFER_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qrySeferAfterInsert
    BeforeEdit = qrySeferBeforeEdit
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 432
    Top = 168
    ParamValues = (
      'PRM_SEFER_ID=0')
  end
  object dtsSefer: TIB_DataSource
    AutoInsert = False
    Dataset = qrySefer
    OnDataChange = dtsSeferDataChange
    Left = 384
    Top = 168
  end
  object trnSefer: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    LockWait = True
    Left = 488
    Top = 168
  end
  object PoMen: TPopupMenu
    Left = 712
    Top = 216
    object mnuALT_SEFER: TMenuItem
      Caption = 'Alt Sefer Ekle'
      OnClick = mnuALT_SEFERClick
    end
    object AktifKaydiSeferlestir: TMenuItem
      Caption = 'Aktif Kayd'#305' Seferle'#351'tir'
      OnClick = cxBu_SeferlerstirClick
    end
    object AktifKaydnSeferiniGncelle1: TMenuItem
      Caption = 'Aktif Kayd'#305'n Seferini G'#252'ncelle'
      OnClick = cxBu_SeferlerstirClick
    end
    object AktifKaydinSeferiniIptalEt: TMenuItem
      Caption = 'Aktif Kayd'#305'n Seferini '#304'ptal Et'
      OnClick = cxBu_Sefer_Kaydi_Iptal_EtClick
    end
    object AktifKaydinSeferineGit: TMenuItem
      Caption = 'Aktif Kayd'#305'n Seferine Git'
      OnClick = cxBu_Sefere_GitClick
    end
    object AklamaOlutur1: TMenuItem
      Caption = 'A'#231#305'klama Olu'#351'tur'
      OnClick = AklamaOlutur1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object KonteynirAlindi: TMenuItem
      Caption = 'Konteyn'#305'r Al'#305'nd'#305
      OnClick = KonteynirAlindiClick
    end
    object KiralikBildirildi: TMenuItem
      Caption = 'Kiral'#305'k Bildirildi'
      OnClick = KiralikBildirildiClick
    end
    object FirmayaBildirildi: TMenuItem
      Caption = 'Firmaya Bildirildi'
      OnClick = FirmayaBildirildiClick
    end
    object SeferTamamlandi: TMenuItem
      Caption = 'Sefer Tamamland'#305
      OnClick = SeferTamamlandiClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object GruplarKapat1: TMenuItem
      Caption = 'Gruplar'#305' Kapat'
      OnClick = GruplarKapat1Click
    end
    object GruplarA1: TMenuItem
      Caption = 'Gruplar'#305' A'#231
      OnClick = GruplarA1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Kopyala1: TMenuItem
      Caption = 'Kopyala'
      OnClick = Kopyala1Click
    end
  end
  object dxComponentPrinter1: TdxComponentPrinter
    CurrentLink = dxComponentPrinter1Link1
    Version = 0
    Left = 840
    Top = 152
    object dxComponentPrinter1Link1: TdxGridReportLink
      Active = True
      Component = cxG1
      PrinterPage.DMPaper = 1
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageSize.X = 215900
      PrinterPage.PageSize.Y = 279400
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 44162.127671354170000000
      ShrinkToPageWidth = True
      OptionsExpanding.ExpandCards = True
      OptionsExpanding.ExpandGroupRows = True
      OptionsExpanding.ExpandMasterRows = True
      OptionsSize.AutoWidth = True
      BuiltInReportLink = True
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.gdz'
    Filter = 'Grid D'#252'zeni Dosyalar'#305'|*.gdz'
    Left = 712
    Top = 144
  end
  object cxLocalizer1: TcxLocalizer
    Active = True
    FileName = 'C:\CedaLite_Ym\devtrk\Tumu.ini'
    Left = 584
    Top = 280
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 936
    Top = 152
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clInactiveCaptionText
    end
  end
  object SaveDialog2: TSaveDialog
    FilterIndex = 0
    Left = 624
    Top = 144
  end
end
