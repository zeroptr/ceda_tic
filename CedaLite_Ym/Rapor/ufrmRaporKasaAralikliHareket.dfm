object frmRaporKasaAralikliHareket: TfrmRaporKasaAralikliHareket
  Left = 321
  Top = 271
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Tarih Aral'#305'kl'#305' Kasa Hareket Raporu'
  ClientHeight = 300
  ClientWidth = 235
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 235
    Height = 283
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 7
        Top = 214
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnEnter = chk_SirketEnter
        OnExit = chk_SirketExit
      end
      object rdCins: TRadioGroup
        Left = 0
        Top = 49
        Width = 227
        Height = 60
        Align = alTop
        ItemIndex = 0
        Items.Strings = (
          'Kasan'#305'n Para Birimi Cinsinden'
          'Varsay'#305'lan Para Birimi Cinsinden')
        TabOrder = 1
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 227
        Height = 49
        Align = alTop
        Caption = 'Kasa Kodu'
        TabOrder = 0
        object txt_KasaKod: TEdit
          Left = 10
          Top = 16
          Width = 105
          Height = 21
          TabOrder = 0
          OnEnter = txt_KasaKodEnter
          OnExit = txt_KasaKodExit
          OnKeyDown = txt_KasaKodKeyDown
          OnKeyPress = txt_KasaKodKeyPress
        end
        object btnKasa: TButton
          Left = 119
          Top = 14
          Width = 102
          Height = 23
          Caption = 'Kasa Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = btnKasaClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 109
        Width = 227
        Height = 49
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 2
        object dtp_Tarih_1: TDateTimePicker
          Left = 6
          Top = 16
          Width = 103
          Height = 21
          Date = 37938.616184074070000000
          Time = 37938.616184074070000000
          TabOrder = 0
          OnEnter = dtp_Tarih_1Enter
          OnExit = dtp_Tarih_1Exit
        end
        object dtp_Tarih_2: TDateTimePicker
          Left = 114
          Top = 16
          Width = 103
          Height = 21
          Date = 37938.616184074070000000
          Time = 37938.616184074070000000
          TabOrder = 1
          OnEnter = dtp_Tarih_2Enter
          OnExit = dtp_Tarih_2Exit
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 158
        Width = 227
        Height = 49
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 3
        object cmbSube: TComboBox
          Left = 36
          Top = 16
          Width = 157
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Ko'#351'ullar'
      ImageIndex = 1
      object Label12: TLabel
        Left = 6
        Top = 0
        Width = 64
        Height = 13
        Caption = #304#351'lem Merkezi'
      end
      object lblKOD1: TLabel
        Left = 114
        Top = -1
        Width = 29
        Height = 13
        Caption = 'KOD1'
      end
      object Label14: TLabel
        Left = 6
        Top = 41
        Width = 29
        Height = 13
        Caption = 'KOD2'
      end
      object Label15: TLabel
        Left = 114
        Top = 42
        Width = 29
        Height = 13
        Caption = 'KOD3'
      end
      object Label16: TLabel
        Left = 71
        Top = 85
        Width = 29
        Height = 13
        Caption = 'KOD4'
      end
      object txtISLEMMERKEZI: TEdit
        Left = 5
        Top = 14
        Width = 79
        Height = 21
        TabOrder = 0
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtISLEMMERKEZIExit
        OnKeyUp = txtISLEMMERKEZIKeyUp
      end
      object Button4: TButton
        Left = 85
        Top = 14
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
        OnClick = Button4Click
      end
      object txtKOD1: TEdit
        Left = 113
        Top = 14
        Width = 79
        Height = 21
        TabOrder = 2
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD1Exit
        OnKeyUp = txtKOD1KeyUp
      end
      object btnKOD1: TButton
        Left = 193
        Top = 14
        Width = 17
        Height = 21
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
        Left = 5
        Top = 55
        Width = 79
        Height = 21
        TabOrder = 4
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD2Exit
        OnKeyUp = txtKOD2KeyUp
      end
      object Button6: TButton
        Left = 85
        Top = 55
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
        OnClick = Button6Click
      end
      object txtKOD3: TEdit
        Left = 113
        Top = 55
        Width = 79
        Height = 21
        TabOrder = 6
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD3Exit
        OnKeyUp = txtKOD3KeyUp
      end
      object Button7: TButton
        Left = 193
        Top = 55
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
        OnClick = Button7Click
      end
      object txtKOD4: TEdit
        Left = 70
        Top = 99
        Width = 79
        Height = 21
        TabOrder = 8
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtKOD4Exit
        OnKeyUp = txtKOD4KeyUp
      end
      object Button8: TButton
        Left = 150
        Top = 100
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
        OnClick = Button8Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 267
    Width = 235
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 7
      Top = 4
      Width = 74
      Height = 25
      Caption = '&Excel Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object Button3: TButton
      Left = 167
      Top = 4
      Width = 60
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object btn_Fast: TButton
      Left = 88
      Top = 4
      Width = 72
      Height = 25
      Caption = 'Rapor Olu'#351'tur'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qry_Kasa: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 20
    Top = 400
  end
  object qry_Rapor: TIB_Cursor
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 68
    Top = 400
  end
  object qryDEVREDEN: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 110
    Top = 400
  end
  object frxIBODts_Kasa_Gunluk: TfrxIBODataset
    UserName = 'frxIBODts_Kasa_Gunluk'
    CloseDataSource = False
    FieldAliases.Strings = (
      'TARIH=TARIH'
      'KASA_KOD=KASA_KOD'
      'KASAHAR_ID=KASAHAR_ID'
      'BELGE_ID=BELGE_ID'
      'ACIKLAMA=ACIKLAMA'
      'DOVKOD=DOVKOD'
      'TIP=TIP'
      'TUTAR=TUTAR'
      'BORC=BORC'
      'ALACAK=ALACAK')
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
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39162.400112303240000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      '  borc,borc_bak:Double;'
      '  alacak,alacak_bak:Double;'
      ''
      '//     a:=a+<frxIBODts_Kasa_Aylik."BORC">;'
      'procedure Memo1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '   // Memo1.memo.text:=Floattostr(A);'
      '   // Memo1.memo.text:='#39'12312'#39';'
      '   // Memo1.memo.text:=<frxIBODts_Kasa_Aylik."BORC">;'
      '   //  Memo1.memo.text:=Floattostr(borc_bak);'
      '     Memo1.memo.text:=FormatFloat('#39'#,.00'#39',borc_bak);'
      'end;'
      ''
      'procedure Memo2OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     //Memo2.memo.text:=Floattostr(alacak_bak);'
      '     Memo2.memo.text:=FormatFloat('#39'#,.00'#39',alacak_bak);'
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     borc:=<frxIBODts_Kasa_Gunluk."BORC">;'
      '     alacak:=<frxIBODts_Kasa_Gunluk."ALACAK">;'
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
      'end;'
      ''
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
        DataSet = frxIBODts_Kasa_Gunluk
        DataSetName = 'frxIBODts_Kasa_Gunluk'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'ssm'
        Value = '<ssm>+<frxIBODts_Kasa_Aylik."ALACAK">'
      end>
    Style = <
      item
        Name = 'Title'
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Group header'
        Color = 16053492
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Data'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
      end
      item
        Name = 'Group footer'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header line'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        Frame.Width = 2.000000000000000000
      end>
  end
  object IB_Query1: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_FIDAN.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'select'
      'tarih,'
      'kasa_kod,'
      'kasahar_id,'
      'belge_id,'
      'aciklama,'
      'dovkod,'
      'tip,'
      ''
      'kasadeger Tutar,'
      'case'
      'when Tip='#39'G'#39' then'
      'kasadeger'
      'end borc'
      ''
      ',case'
      'when Tip='#39'C'#39' then'
      'kasadeger'
      'end alacak'
      ''
      'from kasahar'
      'where kasa_kod=:kasa_kod'
      '')
    ColorScheme = False
    KeyLinksAutoDefine = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 8
    ParamValues = (
      'KASA_KOD=')
  end
end
