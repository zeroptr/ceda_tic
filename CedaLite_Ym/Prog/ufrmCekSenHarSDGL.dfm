object frmCekSenHarSDGL: TfrmCekSenHarSDGL
  Left = 263
  Top = 199
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 345
  ClientWidth = 595
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
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 315
    Width = 595
    Height = 30
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      595
      30)
    object btnTamam: TBitBtn
      Left = 519
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
      Left = 430
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 595
    Height = 38
    Align = alTop
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 593
      Height = 36
      Align = alClient
      TabOrder = 0
      object lblCekSen_KOD: TLabel
        Left = 62
        Top = 11
        Width = 106
        Height = 17
        AutoSize = False
        Color = clMoneyGreen
        ParentColor = False
      end
      object lblKodName: TLabel
        Left = 11
        Top = 14
        Width = 19
        Height = 13
        Caption = #199'ek'
      end
      object btnSec: TButton
        Left = 511
        Top = 9
        Width = 72
        Height = 20
        Caption = '&Se'#231
        TabOrder = 0
        OnClick = btnSecClick
      end
    end
  end
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 38
    Width = 595
    Height = 277
    CustomGlyphsSupplied = []
    DataSource = dts_Liste
    Align = alClient
    OnDblClick = btnTamamClick
    BorderStyle = bsNone
    PreventDeleting = True
    PreventEditing = True
    PreventInserting = True
    TabOrder = 2
    OnKeyPress = IB_Grid1KeyPress
    RowSelect = True
    Ctl3DShallow = True
  end
  object qry_Hareket_Liste: TIB_Query
    CalculatedFields.Strings = (
      'ISLEM_ACK=VARCHAR(30)')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayFormat.Strings = (
      'TUTAR=###,##')
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
      'TUTAR_VPB=Tutar VPB'
      'DOVKUR=D'#246'v. Kur'
      'CARIHAR_ACK=A'#231#305'klama'
      'ISLEM_ACK='#304#351'lem Cinsi')
    FieldsDisplayWidth.Strings = (
      'CEK_NUM=78'
      'CARI_AD=104'
      'BANKA_AD=116'
      'CARI_KOD=70'
      'ISLEM_ACK=99'
      'TUTAR_VPB=98'
      'DOVKUR=93')
    FieldsIndex.Strings = (
      'CARI_KOD'
      'ISLEM_TAR'
      'CARI_AD'
      'CEKSENHAR_ID'
      'CEKSENHAR_SID'
      'BELGE_ID'
      'BELGE_SID'
      'CEKSEN'
      'ISLEM'
      'ISLEM_ACK'
      'TUTAR_VPB'
      'DOVKUR'
      'CARIHAR_ACK')
    FieldsVisible.Strings = (
      'CEK_ID=TRUE'
      'CEK_SID=FALSE'
      'CARI_ID=FALSE'
      'CARI_SID=FALSE'
      'DURUM=FALSE'
      'TIP=FALSE'
      'ASIL=FALSE'
      'CARI_KOD=FALSE'
      'CEKSENHAR_ID=FALSE'
      'CEKSENHAR_SID=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'CEKSEN=FALSE'
      'ISLEM=FALSE'
      'ISLEM_ACK=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT CEKSENHAR_ID'
      '     , CEKSENHAR_SID'
      '     , ISLEM_TAR'
      '     , BELGE_ID'
      '     , BELGE_SID'
      '     , CEKSEN'
      '     , ISLEM'
      '     , TUTAR_VPB'
      '     , DOVKUR'
      '     , CARI_KOD'
      
        '     , (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD = CEKSENHAR' +
        '.CARI_KOD) AS CARI_AD'
      '     , CARIHAR_ACK'
      'FROM CEKSENHAR'
      'Where BELGE_ID=:PRM_BELGE_ID and'
      '      BELGE_SID=:PRM_BELGE_SID and'
      '      ISLEM=:PRM_BELGE_SID')
    OnCalculateField = qry_Hareket_ListeCalculateField
    ColorScheme = False
    KeyLinks.Strings = (
      'CEKSENHAR.CEKSENHAR_ID'
      'CEKSENHAR.CEKSENHAR_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 78
    Top = 141
  end
  object dts_Liste: TIB_DataSource
    Dataset = qry_Hareket_Liste
    Left = 176
    Top = 140
  end
end
