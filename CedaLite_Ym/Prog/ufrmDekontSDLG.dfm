object frmDekontSDLG: TfrmDekontSDLG
  Left = 184
  Top = 156
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Dekont Listesi'
  ClientHeight = 478
  ClientWidth = 611
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 50
    Width = 611
    Height = 161
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 370
      Top = 112
      Width = 30
      Height = 13
      Caption = 'Fi'#351' No'
    end
    object Label10: TLabel
      Left = 233
      Top = 139
      Width = 43
      Height = 13
      Caption = 'A'#231#305'klama'
    end
    object txtDekontKod: TEdit
      Left = 406
      Top = 108
      Width = 111
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtDekontKodExit
      OnKeyPress = txtDekontKodKeyPress
    end
    object btnAraTar: TButton
      Left = 523
      Top = 131
      Width = 70
      Height = 24
      Caption = '&Ara'
      TabOrder = 5
      OnClick = btnAraTarClick
    end
    object cmbSube: TComboBox
      Left = 235
      Top = 108
      Width = 124
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnEnter = cmbSubeEnter
      OnExit = cmbSubeExit
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 50
      Width = 609
      Height = 44
      Align = alTop
      TabOrder = 1
      object Label5: TLabel
        Left = 6
        Top = 17
        Width = 59
        Height = 13
        Caption = 'Tutar Aral'#305#287#305' '
      end
      object Label6: TLabel
        Left = 201
        Top = 17
        Width = 21
        Height = 13
        Caption = '> - <'
      end
      object TutarBas: TIB_Currency
        Left = 68
        Top = 13
        Width = 125
        Height = 21
        TabOrder = 0
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object TutarSon: TIB_Currency
        Left = 232
        Top = 13
        Width = 131
        Height = 21
        TabOrder = 1
        OnEnter = TutarBasEnter
        OnExit = TutarBasExit
        AlwaysShowButton = True
      end
      object chkTutar: TCheckBox
        Left = 587
        Top = 16
        Width = 17
        Height = 17
        TabOrder = 3
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
      object cmbIslemTip: TComboBox
        Left = 382
        Top = 13
        Width = 195
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'Dekont Toplam Tutar'#305' Baz'#305'nda'
        OnEnter = cmbSubeEnter
        OnExit = cmbSubeExit
        Items.Strings = (
          'Dekont Toplam Tutar'#305' Baz'#305'nda'
          'Dekont Kalem Tutar'#305' Baz'#305'nda')
      end
    end
    object GroupBox1: TGroupBox
      Left = 2
      Top = 94
      Width = 225
      Height = 44
      Caption = 'Tarih Aral'#305#287#305
      TabOrder = 2
      object dtpIslemTar: TDateTimePicker
        Left = 7
        Top = 16
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
        Left = 117
        Top = 16
        Width = 99
        Height = 21
        Date = 37607.490494988430000000
        Time = 37607.490494988430000000
        ShowCheckbox = True
        Checked = False
        TabOrder = 1
        OnEnter = dtpIslemTarEnter
        OnExit = dtpIslemTarExit
      end
    end
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 609
      Height = 49
      Align = alTop
      TabOrder = 0
      object Label2: TLabel
        Left = 198
        Top = 21
        Width = 19
        Height = 13
        Caption = 'Kod'
      end
      object rgCM: TRadioGroup
        Left = 6
        Top = 7
        Width = 185
        Height = 35
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Cari'
          'Masraf')
        TabOrder = 0
        OnEnter = rgCMEnter
        OnExit = rgCMExit
      end
      object txtKod: TEdit
        Left = 228
        Top = 18
        Width = 133
        Height = 21
        TabOrder = 1
        OnEnter = txtISLEMMERKEZIEnter
        OnExit = txtDekontKodExit
        OnKeyDown = txtKodKeyDown
      end
      object btnLstCM: TButton
        Left = 362
        Top = 18
        Width = 18
        Height = 21
        Caption = '...'
        TabOrder = 2
        TabStop = False
        OnClick = btnLstCMClick
      end
      object chkKod: TCheckBox
        Left = 588
        Top = 18
        Width = 13
        Height = 17
        TabOrder = 3
        OnEnter = chkRAPKODEnter
        OnExit = chkRAPKODExit
      end
    end
    object Edt_Ack: TEdit
      Left = 304
      Top = 135
      Width = 213
      Height = 21
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtDekontKodExit
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 446
    Width = 611
    Height = 32
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      611
      32)
    object cmdCancel: TBitBtn
      Left = 445
      Top = 3
      Width = 85
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = cmdCancelClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnTamam: TBitBtn
      Left = 530
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Tamam'
      TabOrder = 1
      OnClick = btnTamamClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 211
    Width = 611
    Height = 235
    CustomGlyphsSupplied = []
    DataSource = dts_Dekont
    Align = alClient
    OnDblClick = btnTamamClick
    BorderStyle = bsNone
    TabOrder = 2
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
    ExplicitTop = 196
    ExplicitHeight = 250
  end
  object pnlRAPKOD: TPanel
    Left = 0
    Top = 0
    Width = 611
    Height = 50
    Align = alTop
    TabOrder = 0
    object Label9: TLabel
      Left = 438
      Top = 9
      Width = 29
      Height = 13
      Caption = 'KOD4'
    end
    object Label8: TLabel
      Left = 331
      Top = 9
      Width = 29
      Height = 13
      Caption = 'KOD3'
    end
    object Label7: TLabel
      Left = 222
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD2'
    end
    object Label4: TLabel
      Left = 115
      Top = 7
      Width = 29
      Height = 13
      Caption = 'KOD1'
    end
    object Label3: TLabel
      Left = 8
      Top = 7
      Width = 64
      Height = 13
      Caption = #304#351'lem Merkezi'
    end
    object chkRAPKOD: TCheckBox
      Left = 588
      Top = 25
      Width = 15
      Height = 17
      TabOrder = 10
      OnEnter = chkRAPKODEnter
      OnExit = chkRAPKODExit
    end
    object Button5: TButton
      Left = 510
      Top = 23
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
      Left = 437
      Top = 23
      Width = 72
      Height = 21
      TabOrder = 8
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD4Exit
    end
    object Button4: TButton
      Left = 404
      Top = 23
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
      Left = 330
      Top = 23
      Width = 72
      Height = 21
      TabOrder = 6
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD3Exit
    end
    object Button3: TButton
      Left = 296
      Top = 23
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
      Left = 221
      Top = 23
      Width = 72
      Height = 21
      TabOrder = 4
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD2Exit
    end
    object Button2: TButton
      Left = 187
      Top = 23
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
      Top = 23
      Width = 72
      Height = 21
      TabOrder = 2
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtKOD1Exit
    end
    object Button1: TButton
      Left = 77
      Top = 23
      Width = 17
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
      Top = 23
      Width = 68
      Height = 21
      TabOrder = 0
      OnEnter = txtISLEMMERKEZIEnter
      OnExit = txtISLEMMERKEZIExit
    end
  end
  object dts_Dekont: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qry_Dekont
    Left = 334
    Top = 236
  end
  object qry_Dekont: TIB_Query
    DatabaseName = 'C:\Musteriler\ekinci\EKINCI2008.FDB'
    FieldsDisplayLabel.Strings = (
      'ISLEM_TAR='#304#351'lem Tarihi'
      'ACIKLAMA=A'#231#305'klama'
      'DEKONT_ID=Fi'#351' No'
      'DEKONT_TOPLAMI=Dekont Toplam'#305
      'CARI_KOD=Cari Kod'
      'CARI_ADI=Cari Ad'#305)
    FieldsDisplayWidth.Strings = (
      'ACIKLAMA=210'
      'ISLEM_TAR=80'
      'CARI_ADI=168'
      'CARI_KOD=94')
    FieldsIndex.Strings = (
      'DEKONT_ID'
      'ISLEM_TAR'
      'CARI_KOD'
      'CARI_ADI'
      'ACIKLAMA'
      'DEKONT_SID'
      'DEKONT_TOPLAMI')
    FieldsVisible.Strings = (
      'DEKONT_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT '
      'DEKONT.ISLEM_TAR,'
      'DEKONT.ACIKLAMA,'
      'DEKONT.DEKONT_ID,'
      'DEKONT.DEKONT_SID,'
      'DEKONT.CARI_KOD,'
      
        '(SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=DEKONT.CARI_KOD) A' +
        'S CARI_ADI,'
      'SUM(DEKONT_D.TUTAR_VPB) AS DEKONT_TOPLAMI '
      'FROM DEKONT '
      
        'INNER JOIN DEKONT_D ON (DEKONT_D.DEKONT_ID = DEKONT.DEKONT_ID AN' +
        'D DEKONT_D.DEKONT_SID = DEKONT.DEKONT_SID) '
      'WHERE '
      'DEKONT_D.BA = '#39'B'#39' '
      'AND '
      'DEKONT.TIP = 1 '
      'AND '
      'DEKONT.DEKONT_ID = 17664 '
      
        'GROUP BY DEKONT.ISLEM_TAR,DEKONT.ACIKLAMA,DEKONT.DEKONT_ID,DEKON' +
        'T.DEKONT_SID,DEKONT.CARI_KOD')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItems.Strings = (
      #304#351'lem Tarihi=ISLEM_TAR;ISLEM_TAR DESC'
      'Cari Kod=CARI_KOD;CARI_KOD DESC'
      'A'#231#305'klama=ACIKLAMA;ACIKLAMA DESC')
    OrderingLinks.Strings = (
      'ISLEM_TAR=ITEM=1'
      'CARI_KOD=ITEM=2'
      'ACIKLAMA=ITEM=3')
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 264
    Top = 234
  end
end
