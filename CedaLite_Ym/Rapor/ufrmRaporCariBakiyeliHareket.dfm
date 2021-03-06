object frmRaporCariBakiyeliHareket: TfrmRaporCariBakiyeliHareket
  Left = 298
  Top = 218
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cari Bakiyeli Hareket Listesi'
  ClientHeight = 320
  ClientWidth = 385
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 287
    Width = 385
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 7
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object btnCikis: TButton
      Left = 302
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = btnCikisClick
    end
    object Btn_Fast: TButton
      Left = 150
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 385
    Height = 281
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object Label4: TLabel
        Left = 296
        Top = 218
        Width = 63
        Height = 13
        Caption = 'Kay'#305'tlar'#305' Dahil'
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 169
        Height = 249
        Caption = 'Cari Kodu'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 204
          Width = 11
          Height = 13
          Caption = #304'lk'
        end
        object Label2: TLabel
          Left = 8
          Top = 228
          Width = 19
          Height = 13
          Caption = 'Son'
        end
        object btnCariListesi: TButton
          Left = 5
          Top = 155
          Width = 156
          Height = 24
          Caption = '&Cari Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = btnCariListesiClick
        end
        object lstCariKod: TListBox
          Left = 6
          Top = 15
          Width = 155
          Height = 138
          ItemHeight = 13
          TabOrder = 0
          OnKeyDown = lstCariKodKeyDown
        end
        object txt_ilk_Cari: TEdit
          Left = 32
          Top = 199
          Width = 109
          Height = 21
          TabOrder = 3
          OnEnter = txt_ilk_CariEnter
          OnExit = txt_ilk_CariExit
          OnKeyPress = txt_ilk_CariKeyPress
        end
        object txt_son_Cari: TEdit
          Left = 32
          Top = 223
          Width = 109
          Height = 21
          TabOrder = 5
          OnEnter = txt_ilk_CariEnter
          OnExit = txt_son_CariExit
          OnKeyPress = txt_ilk_CariKeyPress
        end
        object cb_Kod_Araligi: TCheckBox
          Left = 8
          Top = 180
          Width = 153
          Height = 17
          Caption = 'Kod Aral'#305#287#305'n'#305' Kullan'
          TabOrder = 2
        end
        object Button6: TButton
          Left = 144
          Top = 200
          Width = 17
          Height = 20
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnClick = Button6Click
        end
        object Button1: TButton
          Left = 144
          Top = 224
          Width = 17
          Height = 20
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = Button1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 172
        Top = 0
        Width = 187
        Height = 46
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 1
        object dtpIslemTar1: TDateTimePicker
          Left = 6
          Top = 16
          Width = 85
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
          OnEnter = dtpIslemTar1Enter
          OnExit = dtpIslemTar1Exit
        end
        object dtpIslemTar2: TDateTimePicker
          Left = 99
          Top = 15
          Width = 82
          Height = 21
          Date = 37554.733416122690000000
          Time = 37554.733416122690000000
          Checked = False
          TabOrder = 1
          OnEnter = dtpIslemTar2Enter
          OnExit = dtpIslemTar2Exit
        end
      end
      object GroupBox4: TGroupBox
        Left = 172
        Top = 46
        Width = 187
        Height = 52
        Caption = 'Para Birimi'
        TabOrder = 2
        object cmbParaBirimi: TComboBox
          Left = 33
          Top = 18
          Width = 130
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbParaBirimiEnter
          OnExit = cmbParaBirimiExit
        end
      end
      object grpSube: TGroupBox
        Left = 172
        Top = 98
        Width = 187
        Height = 49
        Caption = #350'ube Ad'#305
        TabOrder = 3
        object cmbSube: TComboBox
          Left = 34
          Top = 18
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbParaBirimiEnter
          OnExit = cmbParaBirimiExit
        end
      end
      object chk_Sirket: TCheckBox
        Left = 172
        Top = 169
        Width = 191
        Height = 14
        Caption = 'Rapor ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnEnter = chk_devirEnter
        OnExit = chk_devirExit
      end
      object chk_devir: TCheckBox
        Left = 172
        Top = 151
        Width = 205
        Height = 17
        Caption = 'Raporda devir bakiyesi kullan'#305'ls'#305'n'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = chk_devirEnter
        OnExit = chk_devirExit
      end
      object chk_Harmanla: TCheckBox
        Left = 172
        Top = 183
        Width = 188
        Height = 17
        Caption = 'Sonu'#231'lar'#305' harmanla'
        TabOrder = 6
      end
      object chk_Sayfalar: TCheckBox
        Left = 172
        Top = 199
        Width = 185
        Height = 17
        Caption = 'Raporu sayfalar halinde ver'
        TabOrder = 7
      end
      object chk_Sefer: TCheckBox
        Left = 172
        Top = 217
        Width = 53
        Height = 17
        Caption = 'Sefer'
        TabOrder = 8
      end
      object Memo1: TMemo
        Left = 376
        Top = 200
        Width = 185
        Height = 89
        Lines.Strings = (
          'devir bakiyesi '
          'harmanla olay'#305' '
          'para birimi yap'#305'lacak')
        TabOrder = 9
        Visible = False
      end
      object Cb_Cari_Yas: TCheckBox
        Left = 172
        Top = 233
        Width = 157
        Height = 17
        Caption = 'Cari Ya'#351'land'#305'rmal'#305' Rapor'
        TabOrder = 10
      end
      object chk_Mazot: TCheckBox
        Left = 228
        Top = 217
        Width = 53
        Height = 17
        Caption = 'Mazot'
        TabOrder = 11
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object lblISLEMMERKEZI: TLabel
        Left = 108
        Top = 6
        Width = 64
        Height = 13
        Caption = #304#351'lem Merkezi'
      end
      object lblKOD1: TLabel
        Left = 108
        Top = 47
        Width = 29
        Height = 13
        Caption = 'KOD1'
      end
      object lblKOD2: TLabel
        Left = 108
        Top = 89
        Width = 29
        Height = 13
        Caption = 'KOD2'
      end
      object lblKOD3: TLabel
        Left = 108
        Top = 132
        Width = 29
        Height = 13
        Caption = 'KOD3'
      end
      object lblKOD4: TLabel
        Left = 107
        Top = 173
        Width = 29
        Height = 13
        Caption = 'KOD4'
      end
      object Label3: TLabel
        Left = 40
        Top = 224
        Width = 52
        Height = 13
        Caption = 'Bakiye Tipi'
      end
      object txtISLEMMERKEZI: TEdit
        Left = 107
        Top = 20
        Width = 79
        Height = 21
        TabOrder = 0
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtISLEMMERKEZIExit
        OnKeyUp = txtISLEMMERKEZIKeyUp
      end
      object btnISLEMMERKEZI: TButton
        Left = 187
        Top = 20
        Width = 17
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = False
        OnClick = btnISLEMMERKEZIClick
      end
      object txtKOD1: TEdit
        Left = 107
        Top = 61
        Width = 79
        Height = 21
        TabOrder = 2
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD1Exit
        OnKeyUp = txtKOD1KeyUp
      end
      object btnKOD1: TButton
        Left = 187
        Top = 60
        Width = 18
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        TabStop = False
        OnClick = btnKOD1Click
      end
      object txtKOD2: TEdit
        Left = 107
        Top = 103
        Width = 79
        Height = 21
        TabOrder = 4
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD2Exit
        OnKeyUp = txtKOD2KeyUp
      end
      object btnKOD2: TButton
        Left = 187
        Top = 103
        Width = 17
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        TabStop = False
        OnClick = btnKOD2Click
      end
      object txtKOD3: TEdit
        Left = 107
        Top = 147
        Width = 79
        Height = 21
        TabOrder = 6
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD3Exit
        OnKeyUp = txtKOD3KeyUp
      end
      object btnKOD3: TButton
        Left = 187
        Top = 147
        Width = 17
        Height = 22
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        TabStop = False
        OnClick = btnKOD3Click
      end
      object txtKOD4: TEdit
        Left = 106
        Top = 189
        Width = 79
        Height = 21
        TabOrder = 8
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD4Exit
        OnKeyUp = txtKOD4KeyUp
      end
      object btnKOD4: TButton
        Left = 186
        Top = 189
        Width = 17
        Height = 20
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
        TabStop = False
        OnClick = btnKOD4Click
      end
      object cb_Bakiye: TComboBox
        Left = 106
        Top = 216
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 10
        Text = 'Hepsi'
        Items.Strings = (
          'Hepsi'
          'Borc Bakiyesi Verenler'
          'Alacak Bakiyesi Verenler')
      end
    end
  end
  object qryRapor: TIB_Cursor
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 157
    Top = 386
  end
  object qryToplam: TIB_Cursor
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 44
    Top = 356
  end
  object qryTemp: TIB_Cursor
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 269
    Top = 386
  end
  object frxReport1: TfrxReport
    Version = '4.7.181'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.MDIChild = True
    PreviewOptions.Modal = False
    PreviewOptions.Zoom = 1.000000000000000000
    PreviewOptions.ZoomMode = zmPageWidth
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39139.806122685200000000
    ReportOptions.LastChange = 39192.580357164300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure Memo10OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     Memo10.memo.text:=Memo31.memo.text;'
      'end;'
      ''
      'procedure Memo23OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     Memo23.memo.text:=Memo32.memo.text;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 100
    Top = 99
  end
  object frxIBOmaster: TfrxIBODataset
    UserName = 'frxIBOmaster'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PRM_CARI_KOD=PRM_CARI_KOD'
      'PRM_CARI_AD=PRM_CARI_AD'
      'PRM_CARI_BORC=PRM_CARI_BORC'
      'PRM_CARI_ALACAK=PRM_CARI_ALACAK'
      'PRM_CARI_DEV_BORC=PRM_CARI_DEV_BORC'
      'PRM_CARI_DEV_ALACAK=PRM_CARI_DEV_ALACAK'
      'PRM_CARI_BORC_BAKIYE=PRM_CARI_BORC_BAKIYE'
      'PRM_CARI_ALACAK_BAKIYE=PRM_CARI_ALACAK_BAKIYE')
    DataSet = IB_Query3
    Left = 160
    Top = 89
  end
  object frxIBOdetail: TfrxIBODataset
    UserName = 'frxIBOdetail'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PRM_CARI_KOD=PRM_CARI_KOD'
      'PRM_TARIH=PRM_TARIH'
      'PRM_BELGE_TUR=PRM_BELGE_TUR'
      'PRM_FIS_NO=PRM_FIS_NO'
      'PRM_ACIKLAMA=PRM_ACIKLAMA'
      'PRM_TIP=PRM_TIP'
      'PRM_BORC=PRM_BORC'
      'PRM_ALACAK=PRM_ALACAK'
      'PRM_CARI_BORC_BAKIYE=PRM_CARI_BORC_BAKIYE'
      'PRM_CARI_ALACAK_BAKIYE=PRM_CARI_ALACAK_BAKIYE'
      'PRM_CARI_DEV_BORC_BAKIYE=PRM_CARI_DEV_BORC_BAKIYE'
      'PRM_CARI_DEV_ALACAK_BAKIYE=PRM_CARI_DEV_ALACAK_BAKIYE'
      'CALC_BELGE_TUR=CALC_BELGE_TUR')
    DataSet = IB_Query4
    Left = 328
    Top = 133
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = IB_Query1
    Left = 272
    Top = 97
  end
  object IB_Query1: TIB_Query
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT CARI_KOD'
      '     , CARI_SID'
      '     , CARI_AD'
      '     , YETKISI'
      '     , VERDAIRE'
      '     , VERNO'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , POSTA_KOD'
      '     , TIP'
      '     , TEL_NO_1'
      '     , TEL_NO_2'
      '     , FAX'
      '     , E_MAIL'
      '     , WEB_ADDR'
      '     , NOTES'
      '     , KREDILMT'
      '     , RISK'
      '     , BORC'
      '     , ALACAK'
      '     , ULKE'
      '     , YURTDISI'
      '     , ISLEMTIP'
      '     , MUHTELIF'
      '     , DEVREDEN_BORC'
      '     , DEVREDEN_ALACAK'
      '     , DOVIZLI'
      '     , DOVKOD'
      'FROM CARI')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    AfterScroll = IB_Query1AfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 280
    Top = 104
  end
  object IB_Query2: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=VARCHAR(30)'
      'CALC_BORC=NUMERIC(15,4)'
      'CALC_ALACAK=NUMERIC(15,4)')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT CARIHAR_ID'
      '     , CARIHAR_SID'
      '     , CARI_KOD'
      '     , TIP'
      '     , BELGE_TUR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , TARIH'
      '     , SIRA_NO'
      '     , FIILI_TAR'
      '     , DOV_BAZ_TAR'
      '     , VADETAR'
      '     , DOVKOD'
      '     , DOVKUR'
      '     , TUTAR'
      '     , TUTAR_VPB'
      '     , ACIKLAMA'
      '     , MASRAF_MERK'
      '     , KOD1'
      '     , KOD2'
      '     , KOD3'
      '     , KOD4'
      '     , PLASIYER_KOD'
      '     , PROJE_KOD'
      '    ,'
      '    (CASE'
      '    WHEN TIP='#39'B'#39' THEN  TUTAR_VPB'
      '    ELSE 0'
      '    END) BORC'
      '    ,(CASE'
      '    WHEN TIP='#39'A'#39' THEN  TUTAR_VPB'
      '    ELSE 0'
      '    END) ALACAK'
      ''
      'FROM CARIHAR')
    OnCalculateField = IB_Query2CalculateField
    ColorScheme = False
    KeyLinks.Strings = (
      'CARIHAR.CARIHAR_ID'
      'CARIHAR.CARIHAR_SID')
    MasterSource = IB_DataSource1
    MasterLinks.Strings = (
      'CARI_KOD=CARI_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 356
    Top = 91
    ParamValues = (
      'MLNK_CARI_KOD_0=')
  end
  object IB_Query3: TIB_Query
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select '
      '    prm_cari_kod,'
      '    prm_cari_ad,'
      '    prm_cari_borc,'
      '    prm_cari_alacak,'
      '    prm_cari_dev_borc,'
      '    prm_cari_dev_alacak,'
      '    prm_cari_borc_bakiye,'
      '    prm_cari_alacak_bakiye'
      ''
      ' from cari_liste(0,'#39#39','#39#39','#39#39',1,null,null)')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 136
    Top = 61
  end
  object IB_Query4: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=VARCHAR(30)')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select '
      '    prm_cari_kod,'
      '    prm_tarih,'
      '    prm_belge_tur,'
      '    prm_fis_no,'
      '    prm_aciklama,'
      '    prm_tip,'
      '    prm_borc,'
      '    prm_alacak,'
      '    prm_cari_borc_bakiye,'
      '    prm_cari_alacak_bakiye,'
      '    prm_cari_dev_borc_bakiye,'
      '    prm_cari_dev_alacak_bakiye'
      ''
      
        ' from cari_liste_har(1,:prm_cari_kod1,null,'#39'01.01.2001'#39','#39'01.01.2' +
        '008'#39',1,1,null)')
    OnCalculateField = IB_Query4CalculateField
    ColorScheme = False
    MasterSource = IB_DataSource2
    MasterLinks.Strings = (
      'prm_cari_kod=prm_cari_kod')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 212
    Top = 147
    ParamValues = (
      'PRM_CARI_KOD1='
      'MLNK_PRM_CARI_KOD_0=AR-017')
  end
  object IB_DataSource2: TIB_DataSource
    Dataset = IB_Query3
    Left = 56
    Top = 61
  end
end
