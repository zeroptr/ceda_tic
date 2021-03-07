object frmCariSDLG: TfrmCariSDLG
  Left = 258
  Top = 151
  ActiveControl = txtVeri
  BorderIcons = []
  Caption = 'Cari Arama'
  ClientHeight = 394
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 644
    Height = 144
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 8
      Top = 120
      Width = 39
      Height = 13
      Caption = 'Alan Ad'#305
    end
    object Label4: TLabel
      Left = 190
      Top = 120
      Width = 67
      Height = 13
      Caption = 'Aranacak Veri'
    end
    object txtVeri: TEdit
      Left = 261
      Top = 117
      Width = 164
      Height = 21
      TabOrder = 4
      OnEnter = txtVeriEnter
      OnExit = txtVeriExit
      OnKeyDown = txtVeriKeyDown
      OnKeyPress = txtVeriKeyPress
    end
    object btnAra: TButton
      Left = 425
      Top = 116
      Width = 48
      Height = 22
      Caption = '&Ara'
      TabOrder = 5
      OnClick = btnAraClick
    end
    object cboAlanAdi: TComboBox
      Left = 51
      Top = 117
      Width = 125
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnEnter = cboAlanAdiEnter
      OnExit = cboAlanAdiExit
      Items.Strings = (
        'Kodu'
        'Cari Ad'#305)
    end
    object rdoTip: TRadioGroup
      Left = 90
      Top = -3
      Width = 422
      Height = 31
      Columns = 3
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'Hepsi'
        'Al'#305'c'#305'lar'
        'Sat'#305'c'#305'lar')
      TabOrder = 1
      OnClick = rdoTipClick
      OnEnter = rdoTipEnter
      OnExit = rdoTipExit
    end
    object chkGrup: TCheckBox
      Left = 8
      Top = 7
      Width = 78
      Height = 17
      Hint = 'T'#252'm gruplu veya grupsuz carilerde aram yapmak i'#231'in i'#351'aretleyiniz'
      Caption = 'Cari Gruplar'#305
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = chkGrupClick
      OnEnter = chkGrupEnter
      OnExit = chkGrupExit
    end
    object IB_Grid1: TIB_Grid
      Left = 4
      Top = 30
      Width = 633
      Height = 83
      CustomGlyphsSupplied = []
      DataSource = dtsCari_Grup
      Enabled = False
      OnDblClick = btnAraClick
      BorderStyle = bsNone
      TabOrder = 2
      RowSelect = True
      Ctl3DShallow = True
      TabMovesOut = True
    end
    object rg_Bakiye: TRadioGroup
      Left = 477
      Top = 113
      Width = 161
      Height = 30
      Caption = 'Bakiye'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Kartan '
        'Hareketten')
      TabOrder = 6
      OnClick = rg_BakiyeClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 364
    Width = 644
    Height = 30
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      644
      30)
    object btnTamam: TBitBtn
      Left = 564
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Tamam'
      TabOrder = 0
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
    object cmdCancel: TBitBtn
      Left = 478
      Top = 3
      Width = 85
      Height = 25
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
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
  end
  object IB_Grid2: TIB_Grid
    Left = 0
    Top = 144
    Width = 644
    Height = 220
    CustomGlyphsSupplied = []
    DataSource = dtsCari
    Align = alClient
    OnDblClick = btnTamamClick
    BorderStyle = bsNone
    TabOrder = 1
    RowSelect = True
    Ctl3DShallow = True
    TabMovesOut = True
  end
  object qryCari_Grup: TIB_Query
    ColumnAttributes.Strings = (
      'TIP=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'CGADI=Cari Grup Ad'#305
      'TIP=Al'#305'c'#305
      'CGKOD=Cari Grup Kodu'
      'CG_KOD=Cari Grup Kodu'
      'CARI_GRUP_KOD=Cari Grup Kod')
    FieldsDisplayWidth.Strings = (
      'CGKOD=73'
      'CGADI=339'
      'TIP=28'
      'CG_KOD=91')
    FieldsVisible.Strings = (
      'CARI_GRUP_ID=FALSE'
      'CARI_GRUP_SID=FALSE'
      'CGACK=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'Select * From CARI_GRUP')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'Cari Grup Ad'#305'=CGADI;CGADI DESC'
      'CARI_GRUP_KOD=CARI_GRUP_KOD;CARI_GRUP_KOD DESC')
    OrderingLinks.Strings = (
      'CGADI=ITEM=1'
      'CARI_GRUP_KOD=ITEM=2')
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 244
    Top = 158
  end
  object qryCari: TIB_Query
    CalculatedFields.Strings = (
      'BA=VARCHAR(1)'
      'BAKIYE=NUMERIC(18,4)')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayLabel.Strings = (
      'CKOD=Cari Kodu'
      'CARIAD=Cari Ad'#305
      'YETKISI=Yetkili Ki'#351'i'
      'CARI_KOD=Cari Kod'
      'CARI_AD=Cari Ad'
      'MUHASKOD=Muhasebe Kodu'
      'BAKIYE=Bakiye'
      'BA=BA')
    FieldsDisplayWidth.Strings = (
      'CARIAD=220'
      'CKOD=60'
      'YETKISI=201'
      'CARI_AD=379'
      'CARI_KOD=81'
      'MUHASKOD=84'
      'BA=20')
    FieldsVisible.Strings = (
      'CARIID=FALSE'
      'CARI_SID=FALSE'
      'CARI_ID=FALSE'
      'BORC=FALSE'
      'ALACAK=FALSE'
      'DEVREDEN_BORC=FALSE'
      'DEVREDEN_ALACAK=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      
        'SELECT CARI_KOD,CARI_AD,BORC,ALACAK,DEVREDEN_BORC,DEVREDEN_ALACA' +
        'K FROM CARI')
    OnCalculateField = qryCariCalculateField
    ColorScheme = False
    DefaultValues.Strings = (
      'BORC=0'
      'ALACAK=0'
      'DEVREDEN_BORC=0'
      'DEVREDEN_ALACAK=0')
    KeyLinksAutoDefine = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    OrderingItemNo = 1
    OrderingItems.Strings = (
      'Cari Kod=CARI.CARI_KOD;CARI.CARI_KOD DESC'
      'Cari Ad=CARI.CARI_AD;CARI.CARI_AD DESC')
    OrderingLinks.Strings = (
      'CARI_KOD=ITEM=1'
      'CARI_AD=ITEM=2')
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 178
    Top = 156
  end
  object dtsCari_Grup: TIB_DataSource
    Dataset = qryCari_Grup
    Left = 246
    Top = 220
  end
  object dtsCari: TIB_DataSource
    Dataset = qryCari
    Left = 182
    Top = 220
  end
end
