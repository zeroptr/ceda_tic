object frmRaporProjeHareketleri: TfrmRaporProjeHareketleri
  Left = 372
  Top = 230
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Proje Hareketleri Listesi'
  ClientHeight = 355
  ClientWidth = 269
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 269
    Height = 321
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 28
        Top = 267
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object rdSec: TRadioGroup
        Left = 0
        Top = 95
        Width = 261
        Height = 70
        Align = alTop
        Caption = 'Se'#231'enekler'
        ItemIndex = 0
        Items.Strings = (
          'Hareketleri ger'#231'ekle'#351'en d'#246'viz kodu cinsinden'
          'Proje d'#246'viz kodu cinsinden'
          'Varsay'#305'lan para birimi cinsinden')
        TabOrder = 1
        OnEnter = rdSecEnter
        OnExit = rdSecExit
      end
      object rdTablo: TRadioGroup
        Left = 0
        Top = 165
        Width = 261
        Height = 61
        Align = alTop
        BiDiMode = bdLeftToRight
        ItemIndex = 0
        Items.Strings = (
          'Proje hareketleri '#252'zerinden'
          'Cari hareketler '#252'zerinden')
        ParentBiDiMode = False
        TabOrder = 2
        OnEnter = rdSecEnter
        OnExit = rdSecExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 261
        Height = 49
        Align = alTop
        Caption = 'Proje Kodu'
        TabOrder = 0
        object txtProjeKod1: TEdit
          Left = 8
          Top = 18
          Width = 143
          Height = 21
          TabOrder = 0
          OnEnter = txtProjeKod1Enter
          OnExit = txtProjeKod1Exit
          OnKeyDown = txtProjeKod1KeyDown
          OnKeyPress = txtProjeKod1KeyPress
        end
        object Button1: TButton
          Left = 152
          Top = 16
          Width = 101
          Height = 25
          Caption = '&Proje Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = Button1Click
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 226
        Width = 261
        Height = 41
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 3
        object cmbSube: TComboBox
          Left = 58
          Top = 12
          Width = 135
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
          OnEnter = cmbSubeEnter
          OnExit = cmbSubeExit
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 49
        Width = 261
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 5
        object dtpIslemTar1: TDateTimePicker
          Left = 6
          Top = 16
          Width = 100
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
        end
        object dtpIslemTar2: TDateTimePicker
          Left = 135
          Top = 15
          Width = 100
          Height = 21
          Date = 37554.733416122690000000
          Time = 37554.733416122690000000
          Checked = False
          TabOrder = 1
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label3: TLabel
        Left = 6
        Top = 4
        Width = 40
        Height = 13
        Caption = 'S'#305'ralama'
      end
      object cmb_sirala: TComboBox
        Left = 6
        Top = 17
        Width = 253
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Proje Koduna G'#246're'
        OnEnter = cmbSubeEnter
        OnExit = cmbSubeExit
        Items.Strings = (
          'Proje Koduna G'#246're'
          'Proje Ad'#305'na G'#246're')
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 322
    Width = 269
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
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 189
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object btn_Fast: TButton
      Left = 100
      Top = 5
      Width = 72
      Height = 24
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryProje: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 66
    Top = 408
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 174
    Top = 420
  end
  object frxIBODts_Proje_Har: TfrxIBODataset
    UserName = 'frxIBODts_Proje_Har'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PROJE_KOD=PROJE_KOD'
      'PROJE_AD=PROJE_AD'
      'PROJE_DOVKOD=PROJE_DOVKOD'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'TARIH=TARIH'
      'DOV_BAZ_TAR=DOV_BAZ_TAR'
      'TIP=TIP'
      'DOVKOD=DOVKOD'
      'TUTAR=TUTAR'
      'ACIKLAMA=ACIKLAMA'
      'DOVKUR=DOVKUR'
      'TUTAR_PROJE_DOVKOD=TUTAR_PROJE_DOVKOD'
      'CBORC=CBORC'
      'CALACAK=CALACAK'
      'TUTAR_VPB=TUTAR_VPB'
      'CALC_BELGE_TUR=CALC_BELGE_TUR'
      'CALC_BELGE_ID=CALC_BELGE_ID')
    DataSet = IB_Query1
    Left = 64
    Top = 41
  end
  object frxReport1: TfrxReport
    Version = '4.0.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39139.806122685200000000
    ReportOptions.LastChange = 39167.648477465300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  borc,borc_bak:Double;'
      '  alacak,alacak_bak:Double;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     //borc:=<frxIBODts_Proje_Har."CBORC">;'
      '     //alacak:=<frxIBODts_Proje_Har."CALACAK">;'
      ''
      '     if borc>alacak then'
      '     borc_bak:=borc_bak+(borc-alacak);'
      ''
      '     if alacak>borc then'
      '     alacak_bak:=alacak_bak+(alacak-borc);'
      ''
      '     if borc_bak>alacak_bak then'
      '     begin'
      '        borc_bak:=borc_bak-alacak_bak;'
      '        alacak_bak:=0;'
      '     end;'
      ''
      '     if alacak_bak>borc_bak then'
      '     begin'
      '        alacak_bak:=alacak_bak-borc_bak;'
      '        borc_bak:=0;'
      '     end;'
      ''
      ''
      'end;'
      ''
      ''
      ''
      ''
      ''
      'procedure ReportTitle1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  borc:=0;'
      '  alacak:=0;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 112
    Top = 41
    Datasets = <
      item
        DataSet = frxIBODts_Proje_Har
        DataSetName = 'frxIBODts_Proje_Har'
      end>
    Variables = <>
    Style = <>
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=CHAR(50)'
      'CALC_BELGE_ID=INTEGER')
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT  PROJE.PROJE_KOD'
      ',PROJE.PROJE_AD'
      ',PROJE.DOVKOD AS PROJE_DOVKOD'
      ',PROJEHAR.BELGE_TUR'
      ',PROJEHAR.BELGE_ID'
      ',PROJEHAR.TARIH'
      ',PROJEHAR.DOV_BAZ_TAR'
      ',PROJEHAR.TIP'
      ',PROJEHAR.DOVKOD'
      ',PROJEHAR.TUTAR'
      ',PROJEHAR.ACIKLAMA'
      ',PROJEHAR.DOVKUR'
      ',PROJEHAR.TUTAR_PROJE_DOVKOD'
      ',(case when  PROJEHAR.TIP='#39'B'#39' then'
      'PROJEHAR.TUTAR_VPB else 0 end) CBorc'
      ',(case when  PROJEHAR.TIP='#39'A'#39' then'
      'PROJEHAR.TUTAR_VPB else 0 end ) CAlacak'
      ''
      ',PROJEHAR.TUTAR_VPB FROM PROJE'
      ''
      ' INNER JOIN PROJEHAR ON (PROJEHAR.PROJE_KOD = PROJE.PROJE_KOD)')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 56
  end
end
