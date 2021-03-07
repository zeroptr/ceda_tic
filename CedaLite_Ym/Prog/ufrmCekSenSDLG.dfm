object frmCekSenSDLG: TfrmCekSenSDLG
  Left = 190
  Top = 99
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #199'ek Listesi'
  ClientHeight = 448
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 418
    Width = 670
    Height = 30
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      670
      30)
    object btnTAMAM: TBitBtn
      Left = 585
      Top = 2
      Width = 85
      Height = 26
      Anchors = [akLeft, akBottom]
      Caption = 'T&amam'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnTAMAMClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnIPTAL: TBitBtn
      Left = 498
      Top = 2
      Width = 85
      Height = 26
      Anchors = [akLeft, akBottom]
      Caption = #304'p&tal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnIPTALClick
      Kind = bkCancel
    end
  end
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 670
    Height = 49
    Align = alTop
    TabOrder = 0
    Visible = False
    object Label1: TLabel
      Left = 50
      Top = 8
      Width = 64
      Height = 13
      Caption = #304#351'lem Merkezi'
    end
    object Label4: TLabel
      Left = 162
      Top = 8
      Width = 29
      Height = 13
      Caption = 'KOD1'
    end
    object Label7: TLabel
      Left = 271
      Top = 8
      Width = 29
      Height = 13
      Caption = 'KOD2'
    end
    object Label8: TLabel
      Left = 382
      Top = 8
      Width = 29
      Height = 13
      Caption = 'KOD3'
    end
    object Label9: TLabel
      Left = 492
      Top = 8
      Width = 29
      Height = 13
      Caption = 'KOD4'
    end
    object txtISLEMMERKEZI: TEdit
      Left = 49
      Top = 22
      Width = 79
      Height = 21
      TabOrder = 0
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
    end
    object txtKOD1: TEdit
      Left = 160
      Top = 22
      Width = 79
      Height = 21
      TabOrder = 1
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD1Exit
    end
    object txtKOD2: TEdit
      Left = 270
      Top = 22
      Width = 79
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD2Exit
    end
    object txtKOD3: TEdit
      Left = 380
      Top = 22
      Width = 79
      Height = 21
      TabOrder = 3
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD3Exit
    end
    object txtKOD4: TEdit
      Left = 490
      Top = 22
      Width = 79
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD4Exit
    end
    object Button1: TButton
      Left = 129
      Top = 22
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
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 240
      Top = 22
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
      TabStop = False
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 350
      Top = 22
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
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 460
      Top = 22
      Width = 17
      Height = 20
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      TabStop = False
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 571
      Top = 22
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
    object chkRAPKOD: TCheckBox
      Left = 640
      Top = 21
      Width = 15
      Height = 17
      TabOrder = 10
      OnEnter = chkRAPKODEnter
      OnExit = chkRAPKODExit
    end
  end
  object pnlCek: TPanel
    Left = 0
    Top = 158
    Width = 670
    Height = 35
    Align = alTop
    TabOrder = 2
    object txtCekNo: TEdit
      Left = 368
      Top = 6
      Width = 121
      Height = 21
      TabOrder = 1
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtCekNoExit
      OnKeyPress = txtCekNoKeyPress
    end
    object cboCEKIDNUM: TComboBox
      Left = 272
      Top = 6
      Width = 93
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = #199'ek Numaras'#305
      OnEnter = cboCEKIDNUMEnter
      OnExit = cboCEKIDNUMExit
      Items.Strings = (
        #199'ek Numaras'#305
        #199'ek Fi'#351' No')
    end
    object cmbSube: TComboBox
      Left = 498
      Top = 6
      Width = 109
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnEnter = cboCEKIDNUMEnter
      OnExit = cboCEKIDNUMExit
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 193
    Width = 670
    Height = 225
    CustomGlyphsSupplied = []
    DataSource = dts_Liste
    Align = alClient
    OnDblClick = btnTAMAMClick
    BorderStyle = bsNone
    TabOrder = 3
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 49
    Width = 670
    Height = 109
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 4
      Top = 40
      Width = 74
      Height = 13
      Caption = 'Tanzim Tarihleri'
    end
    object Label5: TLabel
      Left = 198
      Top = 40
      Width = 21
      Height = 13
      Caption = '> - <'
    end
    object Label3: TLabel
      Left = 355
      Top = 40
      Width = 65
      Height = 13
      Caption = 'Vade Tarihleri'
    end
    object Label6: TLabel
      Left = 538
      Top = 40
      Width = 21
      Height = 13
      Caption = '> - <'
    end
    object dtpTanzimTar1: TDateTimePicker
      Left = 89
      Top = 36
      Width = 102
      Height = 21
      Date = 37554.393445972200000000
      Time = 37554.393445972200000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 1
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object dtpTanzimTar2: TDateTimePicker
      Left = 227
      Top = 36
      Width = 101
      Height = 21
      Date = 0.393445972200425000
      Time = 0.393445972200425000
      ShowCheckbox = True
      Checked = False
      TabOrder = 2
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object dtpVadeTar1: TDateTimePicker
      Left = 436
      Top = 37
      Width = 100
      Height = 21
      Date = 37375.393445972200000000
      Time = 37375.393445972200000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 3
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object dtpVadeTar2: TDateTimePicker
      Left = 562
      Top = 37
      Width = 102
      Height = 21
      Date = 37375.393445972200000000
      Time = 37375.393445972200000000
      ShowCheckbox = True
      Checked = False
      TabOrder = 4
      OnEnter = dtpTanzimTar1Enter
      OnExit = dtpTanzimTar1Exit
    end
    object rgDURUM: TRadioGroup
      Left = 0
      Top = 60
      Width = 305
      Height = 41
      Caption = 'Durum'
      Columns = 5
      ItemIndex = 4
      Items.Strings = (
        'Beklemede'
        #214'denmi'#351
        'Protestolu'
        #304'ptal'
        'Hepsi')
      TabOrder = 5
      OnEnter = rgDURUMEnter
      OnExit = rgDURUMExit
    end
    object rgYERKOD: TRadioGroup
      Left = 306
      Top = 60
      Width = 294
      Height = 41
      Caption = 'Yer Kodu'
      Columns = 4
      ItemIndex = 3
      Items.Strings = (
        'Portfoyde'
        'Ciro'
        'Tahsil'
        'Hepsi')
      TabOrder = 6
      OnEnter = rgDURUMEnter
      OnExit = rgDURUMExit
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 664
      Height = 33
      TabOrder = 0
      object lbl_CARIKOD: TLabel
        Left = 96
        Top = 12
        Width = 64
        Height = 13
        Caption = 'lbl_CARIKOD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl_CARI: TLabel
        Left = 176
        Top = 12
        Width = 41
        Height = 13
        Caption = 'lbl_CARI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btnCARI: TButton
        Left = 4
        Top = 9
        Width = 87
        Height = 21
        Caption = '&Cari Listesi'
        TabOrder = 0
        OnClick = btnCARIClick
      end
      object chkCARI: TCheckBox
        Left = 639
        Top = 11
        Width = 17
        Height = 17
        TabOrder = 1
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object btn_Ara: TButton
      Left = 607
      Top = 70
      Width = 56
      Height = 24
      Caption = '&Ara'
      TabOrder = 7
      OnClick = btn_AraClick
    end
  end
  object qry_Cek_Liste: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'ISLEMTAR='#304#351'lem Tarihi'
      'TANZIMTAR=Tanzim Tarihi'
      'VADETAR=Vade Tarihi'
      'CEK_SAHIBI='#199'ek Sahibi'
      'BANKA_AD=Banka Ad'#305
      'HESAP_NO=Hesap Numaras'#305
      'CEK_NUM='#199'ek Numaras'#305
      'TUTAR=Tutar'
      'DOVKOD=D'#246'viz Kodu'
      'ACIKLAMA=A'#231#305'klama'
      'ODEME_TAR='#214'deme Tarihi'
      'CARI_KOD=Cari Kod'
      'CARI_AD=Cari Ad'
      'CEK_ID='#199'ek No'
      'TUTAR_VPB=Tutar VPB')
    FieldsDisplayWidth.Strings = (
      'CEK_NUM=78'
      'CARI_AD=133'
      'BANKA_AD=116'
      'CARI_KOD=70')
    FieldsIndex.Strings = (
      'CEK_ID'
      'CEK_SID'
      'TANZIMTAR'
      'VADETAR'
      'CEK_NUM'
      'CARI_KOD'
      'CARI_AD'
      'BANKA_AD')
    FieldsVisible.Strings = (
      'CEK_ID=TRUE'
      'CEK_SID=FALSE'
      'CARI_ID=FALSE'
      'CARI_SID=FALSE'
      'DURUM=FALSE'
      'TIP=FALSE'
      'ASIL=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT CEK_ID'
      '     , CEK_SID'
      '     , TANZIMTAR'
      '     , VADETAR'
      '     , CEK_NUM'
      '     , CARI_KOD'
      
        '     , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = CEK.CARI_' +
        'KOD) AS CARI_AD'
      '     , BANKA_AD'
      '     , DOVKOD'
      '     , TUTAR'
      '     , TUTAR_VPB'
      'FROM CEK'
      '')
    ColorScheme = False
    KeyLinks.Strings = (
      'CEK.CEK_ID'
      'CEK.CEK_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      #199'ek No=CEK_ID;CEK_ID DESC'
      'Tanzim Tarihi=TANZIMTAR;TANZIMTAR DESC'
      'Vade Tarihi=VADETAR;VADETAR DESC'
      #199'ek Numaras'#305'=CEK_NUM;CEK_NUM DESC'
      'Banka Ad'#305'=BANKA_AD;BANKA_AD DESC'
      'Tutar=TUTAR;TUTAR DESC'
      'Tutar VPB=TUTAR_VPB;TUTAR_VPB DESC'
      'Cari Kod=CARI_KOD;CARI_KOD DESC')
    OrderingLinks.Strings = (
      'CEK_ID=ITEM=1'
      'TANZIMTAR=ITEM=2'
      'VADETAR=ITEM=3'
      'CEK_NUM=ITEM=4'
      'BANKA_AD=ITEM=5'
      'TUTAR=ITEM=6'
      'TUTAR_VPB=ITEM=7'
      'CARI_KOD=ITEM=8')
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 218
    Top = 190
  end
  object dts_Liste: TIB_DataSource
    Left = 354
    Top = 208
  end
  object qry_Senet_Liste: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsGridLabel.Strings = (
      'SENET_ID=Senet No'
      'TANZIMTAR=Tanzim Tar'
      'VADETAR=Vade Tar'
      'CARI_KOD=Cari Kodu'
      'CARI_AD=Cari Ad'#305
      'TANZIM_YER=Tanzim Yer'
      'DOVKOD=Para Birimi'
      'TUTAR=Tutar'
      'TUTAR_VPB=Tutar VPB')
    FieldsDisplayWidth.Strings = (
      'TANZIMTAR=60'
      'SENET_ID=52'
      'CARI_KOD=67'
      'CARI_AD=109'
      'TANZIM_YER=90'
      'DOVKOD=53')
    FieldsVisible.Strings = (
      'SENET_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT SENET_ID'
      '     , SENET_SID'
      '     , TANZIMTAR'
      '     , VADETAR'
      '     , CARI_KOD'
      
        '     , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = SENET.CAR' +
        'I_KOD) AS CARI_AD'
      '     , TANZIM_YER'
      '     , DOVKOD'
      '     , TUTAR'
      '     , TUTAR_VPB'
      'FROM SENET')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'SENET_ID=SENET_ID;SENET_ID DESC'
      'TANZIMTAR=TANZIMTAR;TANZIMTAR DESC'
      'VADETAR=VADETAR;VADETAR DESC'
      'TUTAR=TUTAR;TUTAR DESC'
      'TUTAR_VPB=TUTAR_VPB;TUTAR_VPB DESC'
      'CARI_KOD=CARI_KOD;CARI_KOD DESC')
    OrderingLinks.Strings = (
      'SENET_ID=ITEM=1'
      'TANZIMTAR=ITEM=2'
      'VADETAR=ITEM=3'
      'TUTAR=ITEM=4'
      'TUTAR_VPB=ITEM=5'
      'CARI_KOD=ITEM=6')
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 495
    Top = 252
  end
end
