object frmRaporSerbestDekont: TfrmRaporSerbestDekont
  Left = 312
  Top = 229
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Serbest Dekont Listesi'
  ClientHeight = 154
  ClientWidth = 549
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
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 549
    Height = 48
    Align = alTop
    TabOrder = 0
    object Label9: TLabel
      Left = 426
      Top = 4
      Width = 29
      Height = 13
      Caption = 'KOD4'
    end
    object Label8: TLabel
      Left = 322
      Top = 4
      Width = 29
      Height = 13
      Caption = 'KOD3'
    end
    object Label7: TLabel
      Left = 216
      Top = 4
      Width = 29
      Height = 13
      Caption = 'KOD2'
    end
    object Label4: TLabel
      Left = 115
      Top = 4
      Width = 29
      Height = 13
      Caption = 'KOD1'
    end
    object Label3: TLabel
      Left = 8
      Top = 4
      Width = 83
      Height = 13
      Caption = #304#350'LEM MERKEZ'#304
    end
    object chkRAPKOD: TCheckBox
      Left = 529
      Top = 19
      Width = 15
      Height = 17
      TabOrder = 10
      OnEnter = chkRAPKODEnter
      OnExit = chkRAPKODExit
    end
    object Button5: TButton
      Left = 506
      Top = 18
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
      OnClick = Button5Click
    end
    object txtKOD4: TEdit
      Left = 425
      Top = 18
      Width = 79
      Height = 21
      TabOrder = 8
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
    end
    object Button4: TButton
      Left = 403
      Top = 18
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      TabStop = False
      OnClick = Button4Click
    end
    object txtKOD3: TEdit
      Left = 321
      Top = 18
      Width = 79
      Height = 21
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
    end
    object Button3: TButton
      Left = 296
      Top = 18
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      TabStop = False
      OnClick = Button3Click
    end
    object txtKOD2: TEdit
      Left = 215
      Top = 18
      Width = 79
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
    end
    object Button2: TButton
      Left = 193
      Top = 18
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      TabStop = False
      OnClick = Button2Click
    end
    object txtKOD1: TEdit
      Left = 113
      Top = 18
      Width = 79
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
    end
    object Button1: TButton
      Left = 92
      Top = 18
      Width = 16
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      TabStop = False
      OnClick = Button1Click
    end
    object txtISLEMMERKEZI: TEdit
      Left = 7
      Top = 18
      Width = 84
      Height = 21
      TabOrder = 0
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 48
    Width = 549
    Height = 39
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 5
      Top = 13
      Width = 64
      Height = 13
      Caption = 'Dekont Tarihi'
    end
    object dtpIslemTar: TDateTimePicker
      Left = 78
      Top = 9
      Width = 101
      Height = 21
      Date = 37607.473179270840000000
      Time = 37607.473179270840000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 0
      OnEnter = dtpIslemTarEnter
      OnExit = dtpIslemTarExit
    end
    object dtpIslemTar2: TDateTimePicker
      Left = 186
      Top = 9
      Width = 94
      Height = 21
      Date = 37607.490494988430000000
      Time = 37607.490494988430000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 1
      OnEnter = dtpIslemTarEnter
      OnExit = dtpIslemTarExit
    end
    object chk_Sirket: TCheckBox
      Left = 288
      Top = 11
      Width = 169
      Height = 17
      Caption = 'Ba'#351'l'#305'k olarak '#351'irket bilgisi ekle'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnEnter = chkRAPKODEnter
      OnExit = chkRAPKODExit
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 87
    Width = 549
    Height = 34
    Align = alTop
    TabOrder = 2
    object cmbSube: TComboBox
      Left = 304
      Top = 6
      Width = 135
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnEnter = cmbSubeEnter
      OnExit = cmbSubeExit
    end
  end
  object btnAraTar: TButton
    Left = 2
    Top = 124
    Width = 131
    Height = 25
    Caption = '&Excel Rapor'
    TabOrder = 3
    OnClick = btnAraTarClick
  end
  object btn_Fast: TButton
    Left = 153
    Top = 124
    Width = 88
    Height = 25
    Caption = 'Rapor Olu'#351'tur'
    TabOrder = 4
    OnClick = btn_FastClick
  end
  object Button6: TButton
    Left = 470
    Top = 124
    Width = 75
    Height = 25
    Caption = #199#305'&k'#305#351
    TabOrder = 5
    OnClick = Button6Click
  end
  object qry_Dekont: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 174
    Top = 52
  end
  object qry_Dekont_D: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT MC,BA,KARSI_KOD,DOVKOD,DOVKUR,TUTAR,TUTAR_VPB,PROJE_KOD,A' +
        'CIKLAMA1 FROM DEKONT_D '
      'WHERE DEKONT_ID=:PRM_DEKONT_ID AND DEKONT_SID=:PRM_DEKONT_SID')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 258
    Top = 58
    ParamValues = (
      'PRM_DEKONT_ID=0')
  end
  object frxIBODts_Serbes_Dekont: TfrxIBODataset
    UserName = 'frxIBODts_Serbes_Dekont'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ISLEM_TAR=ISLEM_TAR'
      'ACIKLAMA=ACIKLAMA'
      'DEKONT_ID=DEKONT_ID'
      'DEKONT_SID=DEKONT_SID'
      'MASRAF_MERK=MASRAF_MERK'
      'MC=MC'
      'BA=BA'
      'KARSI_KOD=KARSI_KOD'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'PROJE_KOD=PROJE_KOD'
      'ACIKLAMA1=ACIKLAMA1'
      'CALC_KARS_AD=CALC_KARS_AD')
    DataSet = IB_Query1
    Left = 56
    Top = 17
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'CALC_KARS_AD=CHAR(50)')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT DEKONT.ISLEM_TAR'
      ', DEKONT.ACIKLAMA'
      ', DEKONT.DEKONT_ID'
      ', DEKONT.DEKONT_SID'
      ', DEKONT.MASRAF_MERK'
      ',DEKONT_D.MC,'
      'DEKONT_D.BA,'
      'DEKONT_D.KARSI_KOD,'
      'DEKONT_D.DOVKOD,'
      'DEKONT_D.DOVKUR,'
      'DEKONT_D.TUTAR,'
      'DEKONT_D.TUTAR_VPB,'
      'DEKONT_D.PROJE_KOD,'
      'DEKONT_D.ACIKLAMA1 '
      'FROM DEKONT'
      
        'LEFT OUTER JOIN DEKONT_D ON ( DEKONT_D.DEKONT_ID=DEKONT.DEKONT_I' +
        'D AND DEKONT_D.DEKONT_SID=DEKONT.DEKONT_SID)'
      ''
      ''
      'ORDER BY DEKONT.DEKONT_ID,DEKONT.ISLEM_TAR')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    DefaultValues.Strings = (
      'DEKONT_ID=0'
      'DOVKOD=YTL'
      'DOVKUR=0'
      'TUTAR=0'
      'TUTAR_VPB=0')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 120
    Top = 32
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
    ReportOptions.LastChange = 39163.628400787030000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 56
    Top = 65
    Datasets = <
      item
        DataSet = frxIBODts_Serbes_Dekont
        DataSetName = 'frxIBODts_Serbes_Dekont'
      end>
    Variables = <>
    Style = <>
  end
end
