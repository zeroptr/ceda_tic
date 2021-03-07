object frmRaporPlasiyerHareketleri: TfrmRaporPlasiyerHareketleri
  Left = 255
  Top = 238
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Plasiyer Hareketleri Listesi'
  ClientHeight = 228
  ClientWidth = 274
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
    Width = 274
    Height = 209
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 25
        Top = 143
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 266
        Height = 49
        Align = alTop
        Caption = 'Plasiyer Kodu'
        TabOrder = 0
        object txtPlasiyerKod1: TEdit
          Left = 8
          Top = 16
          Width = 143
          Height = 21
          TabOrder = 0
          OnEnter = txtPlasiyerKod1Enter
          OnExit = txtPlasiyerKod1Exit
          OnKeyDown = txtPlasiyerKod1KeyDown
          OnKeyPress = txtPlasiyerKod1KeyPress
        end
        object Button1: TButton
          Left = 158
          Top = 14
          Width = 101
          Height = 25
          Caption = '&Plasiyer Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = Button1Click
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 95
        Width = 266
        Height = 41
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 1
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
        Width = 266
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 3
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
  end
  object Panel1: TPanel
    Left = 0
    Top = 195
    Width = 274
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 3
      Top = 4
      Width = 76
      Height = 25
      Caption = '&Rapor Ver'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 190
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
      OnClick = btn_FastClick
    end
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 198
    Top = 64
  end
  object qryPlasiyer: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 72
    Top = 64
  end
  object frxIBODts_Plasiyer_Har: TfrxIBODataset
    UserName = 'frxIBODts_Plasiyer_Har'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PLASIYER_KOD=PLASIYER_KOD'
      'ADISOY=ADISOY'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'TARIH=TARIH'
      'DOV_BAZ_TAR=DOV_BAZ_TAR'
      'TIP=TIP'
      'DOVKOD=DOVKOD'
      'TUTAR=TUTAR'
      'ACIKLAMA=ACIKLAMA'
      'DOVKUR=DOVKUR'
      'CBORC=CBORC'
      'CALACAK=CALACAK'
      'TUTAR_VPB=TUTAR_VPB'
      'CALC_BELGE_TUR=CALC_BELGE_TUR'
      'CALC_BELGE_ID=CALC_BELGE_ID')
    DataSet = IB_Query1
    Left = 32
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
    ReportOptions.LastChange = 39167.501441689800000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  borc,borc_bak:Double;'
      '  alacak,alacak_bak:Double;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     borc:=<frxIBODts_Plasiyer_Har."CBORC">;'
      '     alacak:=<frxIBODts_Plasiyer_Har."CALACAK">;'
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
    Left = 32
    Top = 89
    Datasets = <
      item
        DataSet = frxIBODts_Plasiyer_Har
        DataSetName = 'frxIBODts_Plasiyer_Har'
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
      'SELECT '
      'PLASIYER.PLASIYER_KOD'
      ',PLASIYER.ADISOY'
      ',CARIHAR.BELGE_TUR'
      ',CARIHAR.BELGE_ID'
      ',CARIHAR.TARIH'
      ',CARIHAR.DOV_BAZ_TAR'
      ',CARIHAR.TIP'
      ',CARIHAR.DOVKOD'
      ',CARIHAR.TUTAR'
      ',CARIHAR.ACIKLAMA'
      ',CARIHAR.DOVKUR'
      ',(case when  CARIHAR.TIP='#39'B'#39' then '
      'CARIHAR.TUTAR_VPB else 0 end) CBorc '
      ',(case when  CARIHAR.TIP='#39'A'#39' then '
      'CARIHAR.TUTAR_VPB else 0 end ) CAlacak '
      ',CARIHAR.TUTAR_VPB FROM PLASIYER'
      
        ' INNER JOIN CARIHAR ON (CARIHAR.PLASIYER_KOD = PLASIYER.PLASIYER' +
        '_KOD)')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 104
    Top = 16
  end
end
