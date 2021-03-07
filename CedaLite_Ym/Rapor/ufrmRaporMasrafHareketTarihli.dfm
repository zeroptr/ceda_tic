object frmRaporMasrafHareketTarihli: TfrmRaporMasrafHareketTarihli
  Left = 344
  Top = 348
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tarih Aral'#305'kl'#305' Masraf Hareket Raporu'
  ClientHeight = 271
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
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 257
    Height = 235
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object GroupBox2: TGroupBox
        Left = 0
        Top = 49
        Width = 249
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 1
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
          OnEnter = dtpIslemTar1Enter
          OnExit = dtpIslemTar1Exit
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 95
        Width = 249
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
          OnEnter = cmbSubeEnter
          OnExit = cmbSubeExit
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 144
        Width = 249
        Height = 53
        Align = alTop
        TabOrder = 3
        object chkDEVIR: TCheckBox
          Left = 11
          Top = 14
          Width = 199
          Height = 17
          Caption = '   Rapora devir bakiyelerinide ekle'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnEnter = chkDEVIREnter
          OnExit = chkDEVIRExit
        end
        object chk_Sirket: TCheckBox
          Left = 11
          Top = 32
          Width = 213
          Height = 17
          Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnEnter = chkDEVIREnter
          OnExit = chkDEVIRExit
        end
      end
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 249
        Height = 49
        Align = alTop
        Caption = 'Grup Se'#231'imi'
        TabOrder = 0
        object txtGrpKod: TEdit
          Left = 11
          Top = 16
          Width = 200
          Height = 21
          TabOrder = 0
          OnEnter = txtGrpKodEnter
          OnExit = txtGrpKodExit
          OnKeyDown = txtGrpKodKeyDown
          OnKeyPress = txtGrpKodKeyPress
        end
        object btnMasrafGrpListe: TButton
          Left = 213
          Top = 16
          Width = 19
          Height = 21
          Caption = '...'
          TabOrder = 1
          TabStop = False
          OnClick = btnMasrafGrpListeClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object lblISLEMMERKEZI: TLabel
        Left = 60
        Top = 6
        Width = 64
        Height = 13
        Caption = #304#351'lem Merkezi'
      end
      object lblKOD1: TLabel
        Left = 60
        Top = 47
        Width = 29
        Height = 13
        Caption = 'KOD1'
      end
      object lblKOD2: TLabel
        Left = 60
        Top = 89
        Width = 29
        Height = 13
        Caption = 'KOD2'
      end
      object lblKOD3: TLabel
        Left = 60
        Top = 128
        Width = 29
        Height = 13
        Caption = 'KOD3'
      end
      object lblKOD4: TLabel
        Left = 59
        Top = 170
        Width = 29
        Height = 13
        Caption = 'KOD4'
      end
      object txtISLEMMERKEZI: TEdit
        Left = 59
        Top = 20
        Width = 79
        Height = 21
        TabOrder = 0
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtISLEMMERKEZIExit
        OnKeyUp = txtISLEMMERKEZIKeyUp
      end
      object btnISLEMMERKEZI: TButton
        Left = 139
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
        Left = 59
        Top = 61
        Width = 79
        Height = 21
        TabOrder = 2
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD1Exit
        OnKeyUp = txtKOD1KeyUp
      end
      object btnKOD1: TButton
        Left = 139
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
        Left = 59
        Top = 103
        Width = 79
        Height = 21
        TabOrder = 4
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD2Exit
        OnKeyUp = txtKOD2KeyUp
      end
      object btnKOD2: TButton
        Left = 139
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
        Left = 59
        Top = 143
        Width = 79
        Height = 21
        TabOrder = 6
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD3Exit
        OnKeyUp = txtKOD3KeyUp
      end
      object btnKOD3: TButton
        Left = 139
        Top = 143
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
        Left = 58
        Top = 183
        Width = 79
        Height = 21
        TabOrder = 8
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD4Exit
        OnKeyUp = txtKOD4KeyUp
      end
      object btnKOD4: TButton
        Left = 138
        Top = 184
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
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 238
    Width = 257
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
      Left = 175
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object btn_Fast: TButton
      Left = 92
      Top = 4
      Width = 72
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btn_FastClick
    end
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 67
    Top = 326
  end
  object qryToplam: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 134
    Top = 326
  end
  object frxIBODts_Ma_H_grp: TfrxIBODataset
    UserName = 'frxIBODts_Ma_H_grp'
    CloseDataSource = False
    FieldAliases.Strings = (
      'MASRAF_KOD=MASRAF_KOD'
      'CBORC=CBORC'
      'CALACAK=CALACAK'
      'TIP=TIP'
      'CALC_MASRAFADI=CALC_MASRAFADI'
      'BAKIYE=BAKIYE')
    DataSet = IB_Query2
    Left = 88
    Top = 89
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
    ReportOptions.LastChange = 39167.705865520830000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  borc,borc_bak:Double;'
      '  alacak,alacak_bak:Double;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '    // borc:=<frxIBODts_Masraf_Har."CBORC">;'
      '    // alacak:=<frxIBODts_Masraf_Har."CALACAK">;'
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
    Top = 1
    Datasets = <
      item
        DataSet = frxIBODts_Ma_H_grpsz
        DataSetName = 'frxIBODts_Ma_H_grpsz'
      end>
    Variables = <>
    Style = <>
  end
  object IB_Query1: TIB_Query
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=CHAR(50)'
      'CALC_BELGE_ID=INTEGER'
      'CALC_MASRAFADI=CHAR(50)')
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT'
      'MASRAFHAR.MASRAFHAR_ID,'
      'MASRAFHAR.MASRAF_KOD,'
      'MASRAFHAR.BA,'
      'MASRAFHAR.BELGE_TUR,'
      'MASRAFHAR.BELGE_ID,'
      'MASRAFHAR.BELGE_SID,'
      'MASRAFHAR.SIRA_NO,'
      'MASRAFHAR.TARIH,'
      'MASRAFHAR.DOV_BAZ_TAR,'
      'MASRAFHAR.DOVKOD,'
      'MASRAFHAR.DOVKUR,'
      'MASRAFHAR.TUTAR,'
      'MASRAFHAR.TUTAR_VPB,'
      'MASRAFHAR.ACIKLAMA'
      ',(case when  MASRAFHAR.BA='#39'B'#39' then'
      'MASRAFHAR.TUTAR_VPB else 0 end) CBorc'
      ',(case when  MASRAFHAR.BA='#39'A'#39' then'
      'MASRAFHAR.TUTAR_VPB else 0 end ) CAlacak'
      ''
      'FROM MASRAFHAR')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 8
  end
  object IB_Query2: TIB_Query
    CalculatedFields.Strings = (
      'TIP=CHAR(10)'
      'CALC_MASRAFADI=CHAR(50)'
      'BAKIYE=NUMERIC(15,4)')
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT'
      'MASRAFHAR.MASRAF_KOD'
      ',sum(case when  MASRAFHAR.BA='#39'B'#39' then'
      'MASRAFHAR.TUTAR_VPB else 0 end) CBorc'
      ',Sum(case when  MASRAFHAR.BA='#39'A'#39' then'
      'MASRAFHAR.TUTAR_VPB else 0 end) CAlacak'
      'fROM MASRAFHAR'
      'group by MASRAF_KOD')
    OnCalculateField = IB_Query2CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 88
  end
  object frxIBODts_Ma_H_grpsz: TfrxIBODataset
    UserName = 'frxIBODts_Ma_H_grpsz'
    CloseDataSource = False
    FieldAliases.Strings = (
      'MASRAFHAR_ID=MASRAFHAR_ID'
      'MASRAF_KOD=MASRAF_KOD'
      'BA=BA'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'BELGE_SID=BELGE_SID'
      'SIRA_NO=SIRA_NO'
      'TARIH=TARIH'
      'DOV_BAZ_TAR=DOV_BAZ_TAR'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'ACIKLAMA=ACIKLAMA'
      'CBORC=CBORC'
      'CALACAK=CALACAK'
      'DB_KEY=DB_KEY'
      'CALC_BELGE_TUR=CALC_BELGE_TUR'
      'CALC_BELGE_ID=CALC_BELGE_ID'
      'CALC_MASRAFADI=CALC_MASRAFADI')
    DataSet = IB_Query1
    Left = 64
    Top = 17
  end
end
