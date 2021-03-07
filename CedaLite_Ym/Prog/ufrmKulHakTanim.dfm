object frm_Kul_Hak_Tanim: Tfrm_Kul_Hak_Tanim
  Left = 290
  Top = 216
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kullan'#305'c'#305' Haklar'#305' Tan'#305'mlamalar'#305
  ClientHeight = 377
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 8
    Width = 71
    Height = 13
    Caption = 'Kullan'#305'c'#305' Listesi'
  end
  object IB_Grid1: TIB_Grid
    Left = 4
    Top = 24
    Width = 157
    Height = 317
    CustomGlyphsSupplied = []
    DataSource = dts_Kullanici
    BorderStyle = bsNone
    PreventDeleting = True
    TabOrder = 0
    RowSelect = True
    Ctl3DShallow = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 345
    Width = 517
    Height = 32
    Align = alBottom
    TabOrder = 1
    object btnExit: TBitBtn
      Left = 438
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'k'#305#351
      TabOrder = 0
      OnClick = btnExitClick
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
  object IB_Grid2: TIB_Grid
    Left = 168
    Top = 24
    Width = 345
    Height = 149
    CustomGlyphsSupplied = []
    DataSource = dts_Program
    PreventDeleting = True
    TabOrder = 2
    RowSelect = True
  end
  object IB_Grid4: TIB_Grid
    Left = 168
    Top = 180
    Width = 345
    Height = 161
    CustomGlyphsSupplied = []
    DataSource = dts_ModulHak
    PreventDeleting = True
    PreventInserting = True
    TabOrder = 3
  end
  object Panel2: TPanel
    Left = 168
    Top = 24
    Width = 345
    Height = 317
    TabOrder = 4
    Visible = False
    object Label2: TLabel
      Left = 56
      Top = 200
      Width = 241
      Height = 13
      Caption = 'Haklar'#305' kopyalanacak kullan'#305'c'#305'y'#305' sol taraftan se'#231'iniz'
    end
    object IB_Grid3: TIB_Grid
      Left = 8
      Top = 8
      Width = 329
      Height = 189
      CustomGlyphsSupplied = []
      DataSource = dts_Kopyala
      BorderStyle = bsNone
      TabOrder = 0
      RowSelect = True
      Ctl3DShallow = True
    end
    object Button1: TButton
      Left = 60
      Top = 216
      Width = 75
      Height = 21
      Caption = 'Kopyala'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 220
      Top = 216
      Width = 75
      Height = 21
      Caption = 'Vazge'#231
      TabOrder = 2
      OnClick = Button2Click
    end
  end
  object qry_Kullanici: TIB_Query
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'AD_SOY=Ad'#305' Soyad'#305
      'USER_NAME=Kullan'#305'c'#305' Ad'#305
      'PASS_WORD='#350'ifre')
    FieldsVisible.Strings = (
      'KULLANICI_ID=FALSE'
      'KULLANICI_SID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT KULLANICI_ID'
      '     , KULLANICI_SID'
      '     , AD_SOY'
      'FROM KULLANICI')
    ColorScheme = False
    KeyLinks.Strings = (
      'KULLANICI.KULLANICI_ID'
      'KULLANICI.KULLANICI_SID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterScroll = qry_ProgramAfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 36
    Top = 100
  end
  object dts_Kullanici: TIB_DataSource
    Dataset = qry_Kullanici
    Left = 100
    Top = 100
  end
  object qry_Program: TIB_Query
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'PROGRAM_ADI=Program Ad'#305
      'ACIKLAMA=A'#231#305'klama')
    FieldsDisplayWidth.Strings = (
      'PROGRAM_ADI=109')
    FieldsVisible.Strings = (
      'PROGRAM_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT PROGRAM_ID'
      '     , PROGRAM_ADI'
      '     , ACIKLAMA'
      'FROM PROGRAM')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    AfterScroll = qry_ProgramAfterScroll
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 308
    Top = 88
  end
  object dts_Program: TIB_DataSource
    Dataset = qry_Program
    Left = 384
    Top = 88
  end
  object qry_ModulHak: TIB_Query
    ColumnAttributes.Strings = (
      'IZLEME=BOOLEAN=1,0;REQUIRED'
      'DEGISTIRME=BOOLEAN=1,0;REQUIRED'
      'SILME=BOOLEAN=1,0;REQUIRED')
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'MODUL_ADI=Mod'#252'l Ad'#305
      'IZLEME='#304'zleme'
      'DEGISTIRME=De'#287'i'#351'tirme'
      'SILME=Silme')
    FieldsDisplayWidth.Strings = (
      'MODUL_ADI=89'
      'KULLANICI_SID=88'
      'IZLEME=64'
      'DEGISTIRME=83'
      'SILME=69')
    FieldsIndex.Strings = (
      'MODULHAK.MODUL_ID'
      'MODULHAK.KULLANICI_ID'
      'MODULHAK.KULLANICI_SID'
      'MODUL.MODUL_ADI'
      'MODULHAK.IZLEME'
      'MODULHAK.DEGISTIRME'
      'MODULHAK.SILME')
    FieldsVisible.Strings = (
      'KULLANICI_ID=FALSE'
      'KULLANICI_SID=FALSE'
      'MODUL_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT MODULHAK.MODUL_ID,'
      '       MODULHAK.KULLANICI_ID,'
      '       MODULHAK.KULLANICI_SID,'
      '       MODULHAK.IZLEME,'
      '       MODULHAK.DEGISTIRME,'
      '       MODULHAK.SILME,'
      '       MODUL.MODUL_ADI'
      'FROM PROGRAM'
      
        '   RIGHT OUTER JOIN MODUL ON (PROGRAM.PROGRAM_ID = MODUL.PROGRAM' +
        '_ID)'
      
        '   RIGHT OUTER JOIN MODULHAK ON (MODUL.MODUL_ID = MODULHAK.MODUL' +
        '_ID)'
      'WHERE '
      '   ('
      '      (MODULHAK.KULLANICI_ID =:PRM_KULLANICI_ID)'
      '   and '
      '      (MODULHAK.KULLANICI_SID =:PRM_KULLANICI_SID)'
      '   and '
      '      (PROGRAM.PROGRAM_ID =:PRM_PROGRAM_ID)'
      '   )')
    ColorScheme = False
    DeleteSQL.Strings = (
      'DELETE FROM MODULHAK'
      'WHERE'
      '   KULLANICI_ID = :OLD_KULLANICI_ID AND'
      '   KULLANICI_SID = :OLD_KULLANICI_SID AND'
      '   MODUL_ID = :OLD_MODUL_ID')
    EditSQL.Strings = (
      'UPDATE MODULHAK SET'
      '   KULLANICI_ID = :KULLANICI_ID, /*PK*/'
      '   KULLANICI_SID = :KULLANICI_SID, /*PK*/'
      '   MODUL_ID = :MODUL_ID, /*PK*/'
      '   IZLEME = :IZLEME,'
      '   DEGISTIRME = :DEGISTIRME,'
      '   SILME = :SILME'
      'WHERE'
      '   KULLANICI_ID = :OLD_KULLANICI_ID AND'
      '   KULLANICI_SID = :OLD_KULLANICI_SID AND'
      '   MODUL_ID = :OLD_MODUL_ID')
    InsertSQL.Strings = (
      'INSERT INTO MODULHAK('
      '   KULLANICI_ID, /*PK*/'
      '   KULLANICI_SID, /*PK*/'
      '   MODUL_ID, /*PK*/'
      '   IZLEME,'
      '   DEGISTIRME,'
      '   SILME)'
      'VALUES ('
      '   :KULLANICI_ID,'
      '   :KULLANICI_SID,'
      '   :MODUL_ID,'
      '   :IZLEME,'
      '   :DEGISTIRME,'
      '   :SILME)')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = False
    Left = 248
    Top = 270
    ParamValues = (
      'PRM_KULLANICI_ID=3'
      'PRM_KULLANICI_SID=1'
      'PRM_PROGRAM_ID=1')
  end
  object dts_ModulHak: TIB_DataSource
    Dataset = qry_ModulHak
    Left = 328
    Top = 270
  end
  object MainMenu1: TMainMenu
    Left = 212
    Top = 88
    object dERiLEMLER1: TMenuItem
      Caption = 'Di'#287'er '#304#351'lemler'
      object KullancModulKontrol1: TMenuItem
        Caption = 'Kullan'#305'c'#305' Modul Kontrol'
        OnClick = KullancModulKontrol1Click
      end
      object KullancHakkKopyalama1: TMenuItem
        Caption = 'Kullan'#305'c'#305' Hakk'#305' Kopyalama'
        OnClick = KullancHakkKopyalama1Click
      end
    end
  end
  object sp_KULLANICI_MODUL_KONTROL: TIB_StoredProc
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'EXECUTE PROCEDURE KULLANICI_MODUL_KONTROL')
    StoredProcName = 'KULLANICI_MODUL_KONTROL'
    Left = 86
    Top = 190
  end
  object qry_Kopyala: TIB_Query
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    FieldsDisplayLabel.Strings = (
      'AD_SOY=Ad'#305' Soyad'#305)
    FieldsVisible.Strings = (
      'KULLANICI_ID=FALSE'
      'KULLANICI_SID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT KULLANICI_ID'
      '     , KULLANICI_SID'
      '     , AD_SOY'
      'FROM KULLANICI')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 380
    Top = 200
  end
  object dts_Kopyala: TIB_DataSource
    Dataset = qry_Kopyala
    Left = 448
    Top = 196
  end
  object sp_KULLANICI_HAK_ESLE: TIB_StoredProc
    DatabaseName = 'c:\project13100\DB\MAIN.FDB'
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'EXECUTE PROCEDURE KULLANICI_HAK_ESLE'
      '  ?PRM_S_KULLANICI_ID,'
      '  ?PRM_S_KULLANICI_SID,'
      '  ?PRM_T_KULLANICI_ID,'
      '  ?PRM_T_KULLANICI_SID')
    ParamNames.Strings = (
      'PRM_S_KULLANICI_ID'
      'PRM_S_KULLANICI_SID'
      'PRM_T_KULLANICI_ID'
      'PRM_T_KULLANICI_SID')
    StoredProcName = 'KULLANICI_HAK_ESLE'
    Left = 88
    Top = 244
  end
end
