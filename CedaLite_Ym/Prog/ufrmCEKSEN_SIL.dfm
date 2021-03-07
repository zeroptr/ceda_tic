object frmCEKSEN_SIL: TfrmCEKSEN_SIL
  Left = 258
  Top = 159
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmCEKSEN_SIL'
  ClientHeight = 406
  ClientWidth = 581
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lblNO: TLabel
    Left = 6
    Top = 11
    Width = 14
    Height = 13
    Caption = 'No'
  end
  object lblSUBEKODL: TLabel
    Left = 189
    Top = 9
    Width = 56
    Height = 13
    Caption = #350'ube Kodu:'
  end
  object lblSUBEKOD: TLabel
    Left = 249
    Top = 9
    Width = 45
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblCARIKOD: TLabel
    Left = 8
    Top = 36
    Width = 69
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblCARIAD: TLabel
    Left = 88
    Top = 36
    Width = 489
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTANZIMTAR: TLabel
    Left = 80
    Top = 56
    Width = 74
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTANZIMTARL: TLabel
    Left = 8
    Top = 56
    Width = 66
    Height = 13
    Caption = 'Tanzim Tarihi:'
  end
  object lblTUTARBIL: TLabel
    Left = 8
    Top = 80
    Width = 54
    Height = 13
    Caption = 'Tutar Bilgisi'
  end
  object lblDOVKOD: TLabel
    Left = 8
    Top = 96
    Width = 44
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblDOVKUR: TLabel
    Left = 58
    Top = 96
    Width = 99
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTUTAR: TLabel
    Left = 162
    Top = 96
    Width = 145
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblTUTAR_VPB: TLabel
    Left = 312
    Top = 96
    Width = 174
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object lblSAHIPL: TLabel
    Left = 164
    Top = 56
    Width = 29
    Height = 13
    Caption = 'Sahibi'
  end
  object lblCEKSAHIBI: TLabel
    Left = 198
    Top = 56
    Width = 379
    Height = 13
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object Label9: TLabel
    Left = 105
    Top = 80
    Width = 52
    Height = 13
    Caption = 'D'#246'viz Kuru'
  end
  object Label10: TLabel
    Left = 280
    Top = 80
    Width = 25
    Height = 13
    Caption = 'Tutar'
  end
  object Label11: TLabel
    Left = 436
    Top = 82
    Width = 49
    Height = 13
    Caption = 'Tutar VPB'
  end
  object lblCEKNUML: TLabel
    Left = 393
    Top = 9
    Width = 72
    Height = 13
    Caption = #199'ek Numaras'#305' :'
  end
  object lblCEKNUM: TLabel
    Left = 471
    Top = 9
    Width = 106
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '--'
    Color = clMoneyGreen
    ParentColor = False
  end
  object txtNO: TEdit
    Left = 27
    Top = 5
    Width = 125
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 0
  end
  object btnCEKSENLIST: TButton
    Left = 155
    Top = 6
    Width = 17
    Height = 20
    Caption = '...'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnCEKSENLISTClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 376
    Width = 581
    Height = 30
    Align = alBottom
    TabOrder = 2
    object btnYeni: TBitBtn
      Left = 3
      Top = 3
      Width = 70
      Height = 24
      Caption = 'Yeni (INS)'
      TabOrder = 0
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnIPTAL: TButton
      Left = 72
      Top = 3
      Width = 79
      Height = 24
      Caption = #304'ptal(CTRL+P)'
      Enabled = False
      TabOrder = 1
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 150
      Top = 3
      Width = 87
      Height = 24
      Caption = 'Sil (CTRL+DEL)'
      Enabled = False
      TabOrder = 2
      OnClick = btnSilClick
    end
    object btnCIKIS: TBitBtn
      Left = 508
      Top = 3
      Width = 67
      Height = 24
      Caption = #199#305'&k'#305#351
      TabOrder = 3
      OnClick = btnCIKISClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
        03333377777777777F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F333333337F333301111111110333337F333333337F33330111111111
        0333337F3333333F7F333301111111B10333337F333333737F33330111111111
        0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
        0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
        0333337F377777337F333301111111110333337F333333337F33330111111111
        0333337FFFFFFFFF7F3333000000000003333377777777777333}
      NumGlyphs = 2
    end
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 120
    Width = 571
    Height = 253
    Caption = 'Se'#231'ilen Belgeye Ait Hareket Listesi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object IB_Grid1: TIB_Grid
      Left = 12
      Top = 18
      Width = 547
      Height = 223
      CustomGlyphsSupplied = []
      DataSource = dtsCEKSENHAR
      BorderStyle = bsNone
      PreventDeleting = True
      PreventEditing = True
      PreventInserting = True
      ReadOnly = True
      TabOrder = 0
      RowSelect = True
      Ctl3DShallow = True
    end
  end
  object trnCekSenHar: TIB_Transaction
    IB_Connection = DataMod.dbaMain
    Isolation = tiCommitted
    Left = 97
    Top = 210
  end
  object dtsCEKSENHAR: TIB_DataSource
    AutoEdit = False
    AutoInsert = False
    Dataset = qryCEKSENHAR
    Left = 288
    Top = 210
  end
  object qryCEKSENHAR: TIB_Query
    CalculatedFields.Strings = (
      'ISLEM_ACK=VARCHAR(70)')
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'ISLEM_ACK='#304#351'lem A'#231#305'klamas'#305
      'CARIHAR_ACK=Cari Hareket A'#231#305'klamas'#305
      'CARI_KOD=Cari Kod'
      'ISLEM_TAR='#304#351'lem Tarihi')
    FieldsDisplayWidth.Strings = (
      'CARIHAR_ACK=318')
    FieldsIndex.Strings = (
      'CEKSENHAR_ID'
      'CEKSENHAR_SID'
      'ISLEM_TAR'
      'DOV_BAZ_TAR'
      'CEKSEN'
      'BELGE_ID'
      'BELGE_SID'
      'ISLEM'
      'DOVKUR'
      'KUR_FARKI'
      'CARI_KOD'
      'TUTAR_VPB'
      'ISLEM_ACK'
      'PLASIYER_KOD'
      'PROJE_KOD'
      'CARIHAR_ACK'
      'YEVMIYE_ACK'
      'PROTESTO_MASRAF'
      'GENEL_GIDER'
      'GENEL_GIDER_MUH_KOD'
      'BORCALHESAP'
      'MASRAF_MERK'
      'KOD1'
      'KOD2'
      'KOD3'
      'KOD4')
    FieldsVisible.Strings = (
      'CEKSENHAR_ID=FALSE'
      'CEKSENHAR_SID=FALSE'
      'DOV_BAZ_TAR=FALSE'
      'CEKSEN=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'ISLEM=FALSE'
      'DOVKUR=FALSE'
      'KUR_FARKI=FALSE'
      'PLASIYER_KOD=FALSE'
      'PROJE_KOD=FALSE'
      'YEVMIYE_ACK=FALSE'
      'PROTESTO_MASRAF=FALSE'
      'GENEL_GIDER=FALSE'
      'GENEL_GIDER_MUH_KOD=FALSE'
      'BORCALHESAP=FALSE'
      'MASRAF_MERK=FALSE'
      'KOD1=FALSE'
      'KOD2=FALSE'
      'KOD3=FALSE'
      'KOD4=FALSE'
      'KASA_KOD=FALSE')
    IB_Connection = DataMod.dbaMain
    IB_Transaction = trnCekSenHar
    SQL.Strings = (
      'SELECT * FROM CEKSENHAR')
    OnCalculateField = qryCEKSENHARCalculateField
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 192
    Top = 210
  end
end
