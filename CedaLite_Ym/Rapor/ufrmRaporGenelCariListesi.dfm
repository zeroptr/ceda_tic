object frmRaporGenelCariListesi: TfrmRaporGenelCariListesi
  Left = 403
  Top = 94
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cari Listesi'
  ClientHeight = 483
  ClientWidth = 257
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 257
    Height = 449
    ActivePage = TabSheet2
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object Label4: TLabel
        Left = 154
        Top = 402
        Width = 63
        Height = 13
        Caption = 'Kay'#305'tlar'#305' Dahil'
      end
      object chk_Sirket: TCheckBox
        Left = 18
        Top = 350
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object chkDEVIR: TCheckBox
        Left = 18
        Top = 330
        Width = 205
        Height = 17
        Caption = '    Raporda devir bakiyesi kullan'#305'ls'#305'n'
        Checked = True
        State = cbChecked
        TabOrder = 7
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 249
        Height = 73
        Align = alTop
        Caption = 'Cari Kod Aral'#305#287#305
        TabOrder = 0
        object txtCariKod2: TEdit
          Left = 128
          Top = 16
          Width = 113
          Height = 21
          TabOrder = 1
          OnEnter = txtCariKod1Enter
          OnExit = txtCariKod1Exit
          OnKeyPress = txtCariKod2KeyPress
        end
        object txtCariKod1: TEdit
          Left = 8
          Top = 16
          Width = 113
          Height = 21
          TabOrder = 0
          OnEnter = txtCariKod1Enter
          OnExit = txtCariKod1Exit
          OnKeyPress = txtCariKod1KeyPress
        end
        object Button1: TButton
          Left = 8
          Top = 38
          Width = 113
          Height = 25
          Caption = '&Cari Listesi'
          TabOrder = 2
          TabStop = False
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 128
          Top = 38
          Width = 113
          Height = 25
          Caption = 'C&ari Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = Button2Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 121
        Width = 249
        Height = 49
        Align = alTop
        Caption = 'Carinin Tipi'
        TabOrder = 2
        object cmbTip: TComboBox
          Left = 48
          Top = 16
          Width = 128
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Al'#305'c'#305
          OnEnter = cmbTipEnter
          OnExit = cmbTipExit
          Items.Strings = (
            'Al'#305'c'#305
            'Sat'#305'c'#305
            'Banka'
            'Di'#287'er'
            'Mazot'#231'u'
            'Hepsi')
        end
        object Cb_Cari_Tipi: TCheckBox
          Left = 216
          Top = 16
          Width = 17
          Height = 17
          TabOrder = 1
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 170
        Width = 249
        Height = 49
        Align = alTop
        Caption = 'Firma Tipi'
        TabOrder = 3
        object cmb_yurtdisi: TComboBox
          Left = 48
          Top = 19
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Yurti'#231'i Firmalar'#305
          OnEnter = cmbTipEnter
          OnExit = cmbTipExit
          Items.Strings = (
            'Yurti'#231'i Firmalar'#305
            'Yurtd'#305#351#305' Firmalar'#305
            'Hepsi')
        end
        object cb_Firma_Tipi: TCheckBox
          Left = 216
          Top = 16
          Width = 17
          Height = 17
          TabOrder = 1
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 219
        Width = 249
        Height = 52
        Align = alTop
        Caption = 'Para Birimi'
        TabOrder = 4
        object cmbParaBirimi: TComboBox
          Left = 47
          Top = 18
          Width = 130
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbTipEnter
          OnExit = cmbTipExit
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 271
        Width = 249
        Height = 49
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 5
        object cmbSube: TComboBox
          Left = 64
          Top = 18
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbTipEnter
          OnExit = cmbTipExit
        end
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 73
        Width = 249
        Height = 48
        Align = alTop
        Caption = 'Grup Se'#231'imi'
        TabOrder = 1
        object txtGrpKod: TEdit
          Left = 6
          Top = 18
          Width = 215
          Height = 21
          TabOrder = 0
          OnEnter = txtCariKod1Enter
          OnExit = txtGrpKodExit
          OnKeyDown = txtGrpKodKeyDown
          OnKeyPress = txtGrpKodKeyPress
        end
        object btnCariGrpListe: TButton
          Left = 223
          Top = 18
          Width = 20
          Height = 21
          Caption = '...'
          TabOrder = 1
          TabStop = False
          OnClick = btnCariGrpListeClick
        end
      end
      object cbBakiye: TCheckBox
        Left = 18
        Top = 374
        Width = 213
        Height = 17
        Caption = 'Borc Alaca'#287#305' olmayanlar g'#246'r'#252'nt'#252'lenmesin'
        Checked = True
        State = cbChecked
        TabOrder = 8
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object chk_Sefer: TCheckBox
        Left = 20
        Top = 401
        Width = 53
        Height = 17
        Caption = 'Sefer'
        TabOrder = 9
      end
      object chk_Mazot: TCheckBox
        Left = 84
        Top = 401
        Width = 53
        Height = 17
        Caption = 'Mazot'
        TabOrder = 10
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label5: TLabel
        Left = 2
        Top = 1
        Width = 56
        Height = 13
        Caption = 'Gruplamalar'
      end
      object Label3: TLabel
        Left = 4
        Top = 46
        Width = 51
        Height = 13
        Caption = 'S'#305'ralamalar'
      end
      object Label1: TLabel
        Left = 10
        Top = 89
        Width = 54
        Height = 13
        Caption = 'B/A Bakiye'
      end
      object cmbGrup: TComboBox
        Left = 2
        Top = 16
        Width = 245
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 2
        TabOrder = 0
        Text = 'Gruplama Yapma'
        OnEnter = cmbTipEnter
        OnExit = cmbTipExit
        Items.Strings = (
          'Varsay'#305'lan Cari Grubuna G'#246're Gruplama'
          'Hi'#231'bir Cari Grubuna '#220'ye Olmayanlar'
          'Gruplama Yapma')
      end
      object cmb_sirala: TComboBox
        Left = 4
        Top = 60
        Width = 243
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = 'Cari Koda G'#246're'
        OnEnter = cmbTipEnter
        OnExit = cmbTipExit
        Items.Strings = (
          'Cari Koda G'#246're'
          'Cari Ada G'#246're')
      end
      object cmb_Bakiye: TComboBox
        Left = 4
        Top = 104
        Width = 245
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        OnEnter = cmbTipEnter
        OnExit = cmbTipExit
        Items.Strings = (
          'Borc Bakiyesi S'#305'f'#305'rdan B'#252'y'#252'k Olanlar'
          'Alacak Bakiyesi S'#305'f'#305'rdan B'#252'y'#252'k Olanlar'
          'T'#252'm'#252)
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 450
    Width = 257
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 5
      Top = 4
      Width = 76
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = Btn_FastClick
    end
    object Button3: TButton
      Left = 176
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 93
      Top = 4
      Width = 72
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = Btn_FastClick
    end
  end
  object qryCari_CariDov: TIB_Cursor
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 180
    Top = 264
  end
  object qryGrup_GrupUye: TIB_Cursor
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 176
    Top = 174
  end
  object frxReport1: TfrxReport
    Version = '4.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.AllowEdit = False
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39169.575887939800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 36
    Top = 51
  end
  object frxIBOCarilis: TfrxIBODataset
    UserName = 'frxIBOCarilis'
    CloseDataSource = False
    FieldAliases.Strings = (
      'CARI_KOD=CARI_KOD'
      'CARI_AD=CARI_AD'
      'BORC=BORC'
      'ILCE=ILCE'
      'SEHIR=SEHIR'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'TIP=TIP'
      'BAKIYE=BAKIYE'
      'DB_KEY=DB_KEY')
    DataSet = IB_Query1
    Left = 136
    Top = 64
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'c:\CedaLite\Db\Cevresel_2006.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select '
      '    cari.cari_kod,'
      '    cari.cari_ad,'
      '    cari.borc,'
      '    cari.ilce,'
      '    cari.sehir,'
      'borc,alacak,'
      '    (CASE'
      '    WHEN (cari.borc>cari.Alacak) THEN'
      '    '#39'B'#39
      
        'WHEN (cari.borc+cari.devreden_borc<cari.Alacak+cari.devreden_Ala' +
        'cak) THEN'
      #39'A'#39
      'ELSE '
      #39'-'#39
      '    END) Tip,'
      ''
      '    (CASE'
      
        '    WHEN (cari.borc+cari.devreden_borc>cari.Alacak+cari.devreden' +
        '_Alacak) THEN'
      
        '    (cari.borc+cari.devreden_borc)-(cari.Alacak+cari.devreden_Al' +
        'acak)'
      '    else'
      
        '    (cari.Alacak+cari.devreden_Alacak)-(cari.borc+cari.devreden_' +
        'borc)'
      '    END) Bakiye'
      'from cari')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 180
    Top = 110
  end
end
