object frmRaporPersonelHareketleriListesi: TfrmRaporPersonelHareketleriListesi
  Left = 283
  Top = 260
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Genel Personel Hareketleri Listesi'
  ClientHeight = 257
  ClientWidth = 271
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
    Width = 271
    Height = 225
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chk_Sirket: TCheckBox
        Left = 23
        Top = 176
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
        Top = 46
        Width = 263
        Height = 73
        Align = alTop
        Caption = 'Personel Kod Aral'#305#287#305
        TabOrder = 0
        object txtProjeKod1: TEdit
          Left = 8
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 0
          OnEnter = txtProjeKod1Enter
          OnExit = txtProjeKod1Exit
          OnKeyDown = txtProjeKod1KeyDown
          OnKeyPress = txtProjeKod1KeyPress
        end
        object Button1: TButton
          Left = 8
          Top = 38
          Width = 119
          Height = 25
          Caption = '&Personel Listesi'
          TabOrder = 1
          TabStop = False
          OnClick = Button1Click
        end
        object txtProjeKod2: TEdit
          Left = 134
          Top = 16
          Width = 119
          Height = 21
          TabOrder = 2
          OnEnter = txtProjeKod1Enter
          OnExit = txtProjeKod2Exit
          OnKeyDown = txtProjeKod2KeyDown
          OnKeyPress = txtProjeKod1KeyPress
        end
        object Button2: TButton
          Left = 134
          Top = 38
          Width = 119
          Height = 25
          Caption = 'P&ersonel Listesi'
          TabOrder = 3
          TabStop = False
          OnClick = Button2Click
        end
      end
      object grpSube: TGroupBox
        Left = 0
        Top = 119
        Width = 263
        Height = 49
        Align = alTop
        Caption = #350'ube Ad'#305
        TabOrder = 1
        Visible = False
        object cmbSube: TComboBox
          Left = 70
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
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 263
        Height = 46
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 3
        object dtpIslemTar1: TDateTimePicker
          Left = 14
          Top = 16
          Width = 100
          Height = 21
          Date = 37554.733220983800000000
          Time = 37554.733220983800000000
          Checked = False
          TabOrder = 0
        end
        object dtpIslemTar2: TDateTimePicker
          Left = 131
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
        Top = -2
        Width = 40
        Height = 13
        Caption = 'S'#305'ralama'
      end
      object cmb_sirala: TComboBox
        Left = 6
        Top = 12
        Width = 250
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'Personel Koduna G'#246're'
        OnEnter = cmbSubeEnter
        OnExit = cmbSubeExit
        Items.Strings = (
          'Personel Koduna G'#246're'
          'Personel Ad'#305'na G'#246're')
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 224
    Width = 271
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
      Left = 192
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = Button3Click
    end
    object Btn_Fast: TButton
      Left = 98
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 2
      OnClick = btnRaporClick
    end
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 152
    Top = 80
  end
  object qryRaporH: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 120
    Top = 120
  end
  object frxIBODts_Pers_Hark: TfrxIBODataset
    UserName = 'frxIBODts_Pers_Hark'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PERSONEL_KOD=PERSONEL_KOD'
      'ADI_SOYADI=ADI_SOYADI'
      'SICIL_NO=SICIL_NO'
      'SSK_NO=SSK_NO'
      'GIRIS_TARIH=GIRIS_TARIH'
      'CIKIC_TARIH=CIKIC_TARIH'
      'DOGUM_TARIH=DOGUM_TARIH'
      'CINSIYET=CINSIYET'
      'TAHSIL=TAHSIL'
      'EVLI=EVLI'
      'GOREVI=GOREVI'
      'VERGI_NO=VERGI_NO'
      'VERGI_DAIRE=VERGI_DAIRE'
      'VERGI_KARNE_TARIH=VERGI_KARNE_TARIH'
      'TEL_NO=TEL_NO'
      'LISTEDEN_CIKAR=LISTEDEN_CIKAR'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'PERSONELHAR_ID=PERSONELHAR_ID'
      'PERSONELHAR_SID=PERSONELHAR_SID'
      'PERSONEL_KOD=PERSONEL_KOD'
      'BA=BA'
      'TARIH=TARIH'
      'DOVKOD=DOVKOD'
      'DOVKUR=DOVKUR'
      'TUTAR=TUTAR'
      'TUTAR_VPB=TUTAR_VPB'
      'ACIKLAMA=ACIKLAMA'
      'BELGE_TUR=BELGE_TUR'
      'BELGE_ID=BELGE_ID'
      'BELGE_SID=BELGE_SID'
      'SIRA_NO=SIRA_NO'
      'MASRAF_MERK=MASRAF_MERK'
      'KOD1=KOD1'
      'KOD2=KOD2'
      'KOD3=KOD3'
      'KOD4=KOD4'
      'CBORC=CBORC'
      'CALACAK=CALACAK'
      'CALC_BELGE_TUR=CALC_BELGE_TUR')
    DataSet = IB_Query1
    Left = 56
    Top = 25
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
    ReportOptions.LastChange = 39164.619600694440000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 48
    Top = 105
    Datasets = <
      item
        DataSet = frxIBODts_Pers_Hark
        DataSetName = 'frxIBODts_Pers_Hark'
      end>
    Variables = <
      item
        Name = ' New Category1'
        Value = Null
      end
      item
        Name = 'Ba'
        Value = 
          'IIF(SUM(<frxIBODts_Pers_Hark."CBORC">,MasterData1)>SUM(<frxIBODt' +
          's_Pers_Hark."CALACAK">,MasterData1),'#39'Borc'#39',IIF(SUM(<frxIBODts_Pe' +
          'rs_Hark."CALACAK">,MasterData1)>SUM(<frxIBODts_Pers_Hark."CBORC"' +
          '>,MasterData1),'#39'Alacak'#39','#39#39'))'
      end
      item
        Name = 'Bak'
        Value = 
          'IIF(SUM(<frxIBODts_Pers_Hark."CBORC">,MasterData1)>SUM(<frxIBODt' +
          's_Pers_Hark."CALACAK">,MasterData1),SUM(<frxIBODts_Pers_Hark."CB' +
          'ORC">,MasterData1)-SUM(<frxIBODts_Pers_Hark."CALACAK">,MasterDat' +
          'a1),SUM(<frxIBODts_Pers_Hark."CALACAK">,MasterData1)-SUM(<frxIBO' +
          'Dts_Pers_Hark."CBORC">,MasterData1))'
      end
      item
        Name = 'Ba1'
        Value = 
          'IIF(SUM(<frxIBODts_Pers_Hark."CBORC">,MasterData1,2)>SUM(<frxIBO' +
          'Dts_Pers_Hark."CALACAK">,MasterData1,2),'#39'Borc'#39',IIF(SUM(<frxIBODt' +
          's_Pers_Hark."CALACAK">,MasterData1,2)>SUM(<frxIBODts_Pers_Hark."' +
          'CBORC">,MasterData1,2),'#39'Alacak'#39','#39#39'))'
      end
      item
        Name = 'Bak1'
        Value = 
          'IIF(SUM(<frxIBODts_Pers_Hark."CBORC">,MasterData1,2)>SUM(<frxIBO' +
          'Dts_Pers_Hark."CALACAK">,MasterData1,2),SUM(<frxIBODts_Pers_Hark' +
          '."CBORC">,MasterData1,2)-SUM(<frxIBODts_Pers_Hark."CALACAK">,Mas' +
          'terData1,2),SUM(<frxIBODts_Pers_Hark."CALACAK">,MasterData1,2)-S' +
          'UM(<frxIBODts_Pers_Hark."CBORC">,MasterData1,2))'
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
    CalculatedFields.Strings = (
      'CALC_BELGE_TUR=CHAR(50)')
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT PERSONEL.PERSONEL_KOD'
      ', PERSONEL.ADI_SOYADI'
      ', PERSONEL.SICIL_NO'
      ', PERSONEL.SSK_NO'
      ', PERSONEL.GIRIS_TARIH'
      ', PERSONEL.CIKIC_TARIH'
      ', PERSONEL.DOGUM_TARIH'
      ', PERSONEL.CINSIYET'
      ', PERSONEL.TAHSIL'
      ', PERSONEL.EVLI'
      ', PERSONEL.GOREVI'
      ', PERSONEL.VERGI_NO'
      ', PERSONEL.VERGI_DAIRE'
      ', PERSONEL.VERGI_KARNE_TARIH'
      ', PERSONEL.TEL_NO'
      ', PERSONEL.LISTEDEN_CIKAR'
      ', PERSONEL.BORC'
      ', PERSONEL.ALACAK'
      ''
      ',PERSONEL_HAR.PERSONELHAR_ID'
      ',PERSONEL_HAR.PERSONELHAR_SID'
      ',PERSONEL_HAR.PERSONEL_KOD'
      ',PERSONEL_HAR.BA'
      ',PERSONEL_HAR.TARIH'
      ',PERSONEL_HAR.DOVKOD'
      ',PERSONEL_HAR.DOVKUR'
      ',PERSONEL_HAR.TUTAR'
      ',PERSONEL_HAR.TUTAR_VPB'
      ',PERSONEL_HAR.ACIKLAMA'
      ',PERSONEL_HAR.BELGE_TUR'
      ',PERSONEL_HAR.BELGE_ID'
      ',PERSONEL_HAR.BELGE_SID'
      ',PERSONEL_HAR.SIRA_NO'
      ',PERSONEL_HAR.MASRAF_MERK'
      ',PERSONEL_HAR.KOD1'
      ',PERSONEL_HAR.KOD2'
      ',PERSONEL_HAR.KOD3'
      ',PERSONEL_HAR.KOD4'
      ''
      ',(case when  ba='#39'B'#39' then'
      'PERSONEL_HAR.TUTAR_VPB else 0 end) CBorc'
      ',(case when  ba='#39'A'#39' then'
      'PERSONEL_HAR.TUTAR_VPB else 0 end ) CAlacak'
      ''
      ' FROM PERSONEL'
      
        ' INNER JOIN PERSONEL_HAR ON (PERSONEL_HAR.PERSONEL_KOD=PERSONEL.' +
        'PERSONEL_KOD)')
    OnCalculateField = IB_Query1CalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 148
    Top = 3
  end
end
