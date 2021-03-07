object frmRaporMasrafHareket: TfrmRaporMasrafHareket
  Left = 366
  Top = 265
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Bakiyeli Masraf Hareket Listesi'
  ClientHeight = 266
  ClientWidth = 251
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
    Width = 251
    Height = 247
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 243
        Height = 49
        Align = alTop
        Caption = 'Masraf Kodu'
        TabOrder = 0
        object txtMasrafKod: TEdit
          Left = 9
          Top = 19
          Width = 126
          Height = 21
          TabOrder = 0
          OnEnter = txtMasrafKodEnter
          OnExit = txtMasrafKodExit
          OnKeyDown = txtMasrafKodKeyDown
        end
        object Button1: TButton
          Left = 141
          Top = 17
          Width = 94
          Height = 24
          Caption = '&Masraf Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = Button1Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 49
        Width = 243
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
          Left = 135
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
        Width = 243
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
      object chk_Sirket: TCheckBox
        Left = 22
        Top = 181
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = chk_devirEnter
        OnExit = chk_devirExit
      end
      object chk_devir: TCheckBox
        Left = 22
        Top = 157
        Width = 205
        Height = 17
        Caption = '    Raporda devir bakiyesi kullan'#305'ls'#305'n'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnEnter = chk_devirEnter
        OnExit = chk_devirExit
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 233
    Width = 251
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 1
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
    object btn_Fast: TButton
      Left = 92
      Top = 5
      Width = 72
      Height = 24
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
    Left = 121
    Top = 338
  end
  object qryToplam: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 44
    Top = 332
  end
  object frxIBODts_Masraf_Har: TfrxIBODataset
    UserName = 'frxIBODts_Masraf_Har'
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
      'CALC_BELGE_TUR=CALC_BELGE_TUR')
    DataSet = IB_Query1
    Left = 64
    Top = 17
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
    ReportOptions.LastChange = 39165.538514895830000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  borc,borc_bak:Double;'
      '  alacak,alacak_bak:Double;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     borc:=<frxIBODts_Masraf_Har."CBORC">;'
      '     alacak:=<frxIBODts_Masraf_Har."CALACAK">;'
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
      'procedure Memo31OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '       Memo31.memo.text:=FormatFloat('#39'#,.00'#39',borc_bak);'
      'end;'
      ''
      'procedure Memo32OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '       Memo32.memo.text:=FormatFloat('#39'#,.00'#39',alacak_bak);'
      'end;'
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
        DataSet = frxIBODts_Masraf_Har
        DataSetName = 'frxIBODts_Masraf_Har'
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
end
