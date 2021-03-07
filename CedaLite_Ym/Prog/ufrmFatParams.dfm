object frmFatParams: TfrmFatParams
  Left = 286
  Top = 208
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Fatura  Parametreleri'
  ClientHeight = 383
  ClientWidth = 510
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
    Width = 510
    Height = 353
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Ac'#305'klama Bilgileri'
      object pnlAck: TPanel
        Left = 0
        Top = 22
        Width = 502
        Height = 303
        Align = alClient
        TabOrder = 1
        object IB_Edit2: TIB_Edit
          Left = 90
          Top = 5
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_30K_1_CAP'
          DataSource = dts_FatParams
          TabOrder = 0
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit1: TIB_Edit
          Left = 90
          Top = 26
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_30K_2_CAP'
          DataSource = dts_FatParams
          TabOrder = 1
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit3: TIB_Edit
          Left = 90
          Top = 47
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_30K_3_CAP'
          DataSource = dts_FatParams
          TabOrder = 2
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit4: TIB_Edit
          Left = 90
          Top = 69
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_50K_1_CAP'
          DataSource = dts_FatParams
          TabOrder = 3
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit5: TIB_Edit
          Left = 90
          Top = 92
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_50K_2_CAP'
          DataSource = dts_FatParams
          TabOrder = 4
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit6: TIB_Edit
          Left = 90
          Top = 114
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_50K_3_CAP'
          DataSource = dts_FatParams
          TabOrder = 5
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit7: TIB_Edit
          Left = 90
          Top = 137
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_50K_4_CAP'
          DataSource = dts_FatParams
          TabOrder = 6
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit8: TIB_Edit
          Left = 90
          Top = 161
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_50K_5_CAP'
          DataSource = dts_FatParams
          TabOrder = 7
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit9: TIB_Edit
          Left = 90
          Top = 184
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_100K_1_CAP'
          DataSource = dts_FatParams
          TabOrder = 8
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit10: TIB_Edit
          Left = 90
          Top = 206
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_100K_2_CAP'
          DataSource = dts_FatParams
          TabOrder = 9
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit11: TIB_Edit
          Left = 90
          Top = 228
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_100K_3_CAP'
          DataSource = dts_FatParams
          TabOrder = 10
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit12: TIB_Edit
          Left = 90
          Top = 250
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_100K_4_CAP'
          DataSource = dts_FatParams
          TabOrder = 11
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_Edit13: TIB_Edit
          Left = 90
          Top = 271
          Width = 300
          Height = 21
          AutoLabel.Kind = albLeft
          DataField = 'ACK_100K_5_CAP'
          DataSource = dts_FatParams
          TabOrder = 12
          OnEnter = IB_Edit2Enter
          OnExit = IB_Edit2Exit
        end
        object IB_CheckBox1: TIB_CheckBox
          Left = 393
          Top = 6
          Width = 97
          Height = 17
          DataField = 'ACK_30K_1_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 13
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox2: TIB_CheckBox
          Left = 393
          Top = 28
          Width = 97
          Height = 17
          DataField = 'ACK_30K_2_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 14
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox3: TIB_CheckBox
          Left = 393
          Top = 51
          Width = 97
          Height = 17
          DataField = 'ACK_30K_3_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 15
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox4: TIB_CheckBox
          Left = 393
          Top = 72
          Width = 97
          Height = 17
          DataField = 'ACK_50K_1_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 16
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox5: TIB_CheckBox
          Left = 393
          Top = 94
          Width = 97
          Height = 17
          DataField = 'ACK_50K_2_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 17
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox6: TIB_CheckBox
          Left = 393
          Top = 117
          Width = 97
          Height = 17
          DataField = 'ACK_50K_3_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 18
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox7: TIB_CheckBox
          Left = 393
          Top = 139
          Width = 97
          Height = 17
          DataField = 'ACK_50K_4_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 19
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox8: TIB_CheckBox
          Left = 393
          Top = 163
          Width = 97
          Height = 17
          DataField = 'ACK_50K_5_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 20
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox9: TIB_CheckBox
          Left = 393
          Top = 186
          Width = 97
          Height = 17
          DataField = 'ACK_100K_1_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 21
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox10: TIB_CheckBox
          Left = 393
          Top = 208
          Width = 97
          Height = 17
          DataField = 'ACK_100K_2_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 22
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox11: TIB_CheckBox
          Left = 393
          Top = 230
          Width = 97
          Height = 17
          DataField = 'ACK_100K_3_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 23
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox12: TIB_CheckBox
          Left = 393
          Top = 252
          Width = 97
          Height = 17
          DataField = 'ACK_100K_4_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 24
          Caption = 'Kullan'#305'ls'#305'n'
        end
        object IB_CheckBox13: TIB_CheckBox
          Left = 393
          Top = 273
          Width = 97
          Height = 17
          DataField = 'ACK_100K_5_KUL'
          DataSource = dts_FatParams
          BorderStyle = bsNone
          TabOrder = 25
          Caption = 'Kullan'#305'ls'#305'n'
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 502
        Height = 22
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 36
          Top = 3
          Width = 141
          Height = 13
          Caption = 'Ek Ac'#305'klama Kullan'#305'lacak m'#305' ?'
        end
        object chk_EK_ACK_KUL: TIB_CheckBox
          Left = 181
          Top = 2
          Width = 16
          Height = 17
          DataField = 'EK_ACK_KUL'
          DataSource = dts_FatParams
          OnClick = chk_EK_ACK_KULClick
          BorderStyle = bsNone
          TabOrder = 0
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Faturas'#305' Bilgileri'
      ImageIndex = 1
      object Label2: TLabel
        Left = 18
        Top = 13
        Width = 77
        Height = 13
        Caption = 'Fatura Numaras'#305
      end
      object Label3: TLabel
        Left = 148
        Top = 13
        Width = 65
        Height = 13
        Caption = 'Seri Numaras'#305
      end
      object txtFATNUM: TEdit
        Left = 18
        Top = 26
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object Button1: TButton
        Left = 276
        Top = 24
        Width = 75
        Height = 22
        Caption = 'Tamam'
        TabOrder = 1
        OnClick = Button1Click
      end
      object txtSERINO: TEdit
        Left = 147
        Top = 26
        Width = 121
        Height = 21
        TabOrder = 2
      end
      object IB_CheckBox14: TIB_CheckBox
        Left = 21
        Top = 58
        Width = 260
        Height = 17
        DataField = 'KAL_BAZ_ISK'
        DataSource = dts_FatParams
        BorderStyle = bsNone
        TabOrder = 3
        Caption = 'Kalem Baz'#305'nda Iskonto Uygulamas'#305' var m'#305'?'
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 353
    Width = 510
    Height = 30
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      510
      30)
    object btnTAMAM: TBitBtn
      Left = 424
      Top = 3
      Width = 75
      Height = 25
      Anchors = []
      Caption = 'Tamam'
      ModalResult = 1
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
      Left = 348
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #304'ptal'
      TabOrder = 1
      OnClick = btnIPTALClick
      Kind = bkCancel
    end
  end
  object qry_FatParams: TIB_Query
    ColumnAttributes.Strings = (
      'EK_ACK_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_30K_1_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_30K_2_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_30K_3_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_50K_1_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_50K_2_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_50K_3_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_50K_4_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_50K_5_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_100K_1_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_100K_2_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_100K_3_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_100K_4_KUL=BOOLEAN=1,0;REQUIRED'
      'ACK_100K_5_KUL=BOOLEAN=1,0;REQUIRED'
      'KAL_BAZ_ISK=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Db\CEVRESEL_2006.FDB'
    FieldsDisplayLabel.Strings = (
      'ACK_50K_3_CAP=Ac'#305'klama(50)'
      'ACK_50K_2_CAP=Ac'#305'klama(50)'
      'ACK_50K_1_CAP=Ac'#305'klama(50)'
      'ACK_30K_3_CAP=Ac'#305'klama(30)'
      'ACK_30K_2_CAP=Ac'#305'klama(30)'
      'ACK_30K_1_CAP=Ac'#305'klama(30)'
      'ACK_50K_4_CAP=Ac'#305'klama(50)'
      'ACK_50K_5_CAP=Ac'#305'klama(50)'
      'ACK_100K_1_CAP=Ac'#305'klama(100)'
      'ACK_100K_2_CAP=Ac'#305'klama(100)'
      'ACK_100K_3_CAP=Ac'#305'klama(100)'
      'ACK_100K_4_CAP=Ac'#305'klama(100)'
      'ACK_100K_5_CAP=Ac'#305'klama(100)'
      'EK_ACK_KUL=Ek Ac'#305'klama Kullan'#305'lacak m'#305' ?'
      'KAL_BAZ_ISK=Kalem Baz'#305'nda Iskonto Uygulan'#305'yor mu?')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT FAT_PARAMS_ID'
      '     , EK_ACK_KUL'
      '     , ACK_30K_1_CAP'
      '     , ACK_30K_2_CAP'
      '     , ACK_30K_3_CAP'
      '     , ACK_50K_1_CAP'
      '     , ACK_50K_2_CAP'
      '     , ACK_50K_3_CAP'
      '     , ACK_50K_4_CAP'
      '     , ACK_50K_5_CAP'
      '     , ACK_100K_1_CAP'
      '     , ACK_100K_2_CAP'
      '     , ACK_100K_3_CAP'
      '     , ACK_100K_4_CAP'
      '     , ACK_100K_5_CAP'
      '     , ACK_30K_1_KUL'
      '     , ACK_30K_2_KUL'
      '     , ACK_30K_3_KUL'
      '     , ACK_50K_1_KUL'
      '     , ACK_50K_2_KUL'
      '     , ACK_50K_3_KUL'
      '     , ACK_50K_4_KUL'
      '     , ACK_50K_5_KUL'
      '     , ACK_100K_1_KUL'
      '     , ACK_100K_2_KUL'
      '     , ACK_100K_3_KUL'
      '     , ACK_100K_4_KUL'
      '     , ACK_100K_5_KUL'
      '     , KAL_BAZ_ISK'
      'FROM FAT_PARAMS '
      'WHERE FAT_PARAMS_ID =:PRM_FAT_PARAMS_ID')
    ColorScheme = False
    KeyLinks.Strings = (
      'FAT_PARAMS.FAT_PARAMS_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BeforeDelete = qry_FatParamsBeforeDelete
    BeforePost = qry_FatParamsBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 106
    Top = 134
  end
  object dts_FatParams: TIB_DataSource
    Dataset = qry_FatParams
    Left = 216
    Top = 140
  end
end
