object frmRaporCariBakiyeliHareketTarihli: TfrmRaporCariBakiyeliHareketTarihli
  Left = 713
  Top = 208
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cari Hareket Raporu'
  ClientHeight = 360
  ClientWidth = 252
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 252
    Height = 329
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 244
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 0
        object dtpIslemTar1: TDateTimePicker
          Left = 6
          Top = 16
          Width = 100
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
          OnEnter = dtpIslemTar1Enter
          OnExit = dtpIslemTar1Exit
        end
        object dtpIslemTar2: TDateTimePicker
          Left = 123
          Top = 15
          Width = 100
          Height = 21
          Date = 37554.733416122690000000
          Time = 37554.733416122690000000
          Checked = False
          TabOrder = 1
          OnEnter = dtpIslemTar2Enter
          OnExit = dtpIslemTar2Exit
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 46
        Width = 244
        Height = 45
        Align = alTop
        Caption = 'Para Birimi'
        TabOrder = 1
        object cmbParaBirimi: TComboBox
          Left = 58
          Top = 16
          Width = 129
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbParaBirimiEnter
          OnExit = cmbParaBirimiExit
        end
      end
      object chkDEVIR: TCheckBox
        Left = 11
        Top = 239
        Width = 199
        Height = 17
        Caption = '   Rapora devir bakiyelerinide ekle'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnEnter = chkDEVIREnter
        OnExit = chkDEVIRExit
      end
      object chk_Sirket: TCheckBox
        Left = 11
        Top = 261
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = chkDEVIREnter
        OnExit = chkDEVIRExit
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 91
        Width = 244
        Height = 49
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 2
        object cmbSube: TComboBox
          Left = 58
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
      object CheckBox1: TCheckBox
        Left = 12
        Top = 282
        Width = 181
        Height = 17
        Caption = 'Sefer ve Mazot Kay'#305'tlar'#305' Dahil'
        TabOrder = 5
      end
      object TGroupBox
        Left = 0
        Top = 144
        Width = 241
        Height = 89
        TabOrder = 6
        object Label1: TLabel
          Left = 16
          Top = 36
          Width = 11
          Height = 13
          Caption = #304'lk'
        end
        object Label2: TLabel
          Left = 16
          Top = 60
          Width = 19
          Height = 13
          Caption = 'Son'
        end
        object cb_Kod_Araligi: TCheckBox
          Left = 3
          Top = 5
          Width = 153
          Height = 17
          Caption = 'Kod Aral'#305#287#305'n'#305' Kullan'
          TabOrder = 0
        end
        object txt_ilk_Cari: TEdit
          Left = 56
          Top = 28
          Width = 109
          Height = 21
          TabOrder = 1
          OnEnter = txt_ilk_CariEnter
          OnExit = txt_ilk_CariExit
        end
        object Button6: TButton
          Left = 168
          Top = 53
          Width = 17
          Height = 20
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = Button6Click
        end
        object txt_son_Cari: TEdit
          Left = 56
          Top = 52
          Width = 109
          Height = 21
          TabOrder = 3
          OnEnter = txt_son_CariEnter
          OnExit = txt_son_CariExit
        end
        object Button1: TButton
          Left = 168
          Top = 29
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
          OnClick = Button1Click
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 327
    Width = 252
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 3
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 173
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 88
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 199
    Top = 204
  end
  object qryToplam: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 204
    Top = 256
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=VARCHAR(50)')
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select'
      '    cari_liste.prm_cari_kod,'
      '    cari_liste.prm_cari_ad,'
      '    cari_liste.prm_cari_borc,'
      '    cari_liste.prm_cari_alacak,'
      '    cari_liste.prm_cari_dev_borc,'
      '    cari_liste.prm_cari_dev_alacak,'
      '    cari_liste.prm_cari_borc_bakiye,'
      '    cari_liste.prm_cari_alacak_bakiye,'
      '    cari_liste_har.prm_cari_kod,'
      '    cari_liste_har.prm_tarih,'
      '    cari_liste_har.prm_belge_tur,'
      '    cari_liste_har.prm_fis_no,'
      '    cari_liste_har.prm_aciklama,'
      '    cari_liste_har.prm_tip,'
      '    cari_liste_har.prm_borc,'
      '    cari_liste_har.prm_alacak,'
      '    cari_liste_har.prm_cari_borc_bakiye,'
      '    cari_liste_har.prm_cari_alacak_bakiye,'
      '    cari_liste_har.prm_cari_dev_borc_bakiye,'
      '    cari_liste_har.prm_cari_dev_alacak_bakiye'
      ''
      ' from cari_liste(0,'#39#39','#39#39','#39#39',1,null,null)'
      
        ' inner join cari_liste_har(1,null,null,'#39'01.01.2001'#39','#39'01.01.2008'#39 +
        ',1,1,0) on'
      ' (cari_liste.prm_cari_kod=cari_liste_har.prm_cari_kod)'
      ' order by  prm_fis_no ,cari_liste_har.prm_cari_kod,prm_tarih')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 192
    Top = 150
  end
  object frxReport1: TfrxReport
    Version = '4.3'
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
    ReportOptions.LastChange = 39147.672908518500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 60
    Top = 83
  end
  object frxIBOHarTar: TfrxIBODataset
    UserName = 'frxIBOHarTar'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PRM_CARI_KOD=PRM_CARI_KOD'
      'PRM_CARI_AD=PRM_CARI_AD'
      'PRM_CARI_BORC=PRM_CARI_BORC'
      'PRM_CARI_ALACAK=PRM_CARI_ALACAK'
      'PRM_CARI_DEV_BORC=PRM_CARI_DEV_BORC'
      'PRM_CARI_DEV_ALACAK=PRM_CARI_DEV_ALACAK'
      'PRM_CARI_BORC_BAKIYE=PRM_CARI_BORC_BAKIYE'
      'PRM_CARI_ALACAK_BAKIYE=PRM_CARI_ALACAK_BAKIYE'
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
    DataSet = IB_Query1
    Left = 140
    Top = 84
  end
end
