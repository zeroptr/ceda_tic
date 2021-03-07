object frmOlcuTip: TfrmOlcuTip
  Left = 210
  Top = 329
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = #214'l'#231#252' '#304#351'lemleri'
  ClientHeight = 271
  ClientWidth = 456
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
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 456
    Height = 271
    ActivePage = TabSheet2
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    object TabSheet1: TTabSheet
      Caption = #214'l'#231#252' Tipleri'
      object Panel1: TPanel
        Left = 0
        Top = 210
        Width = 448
        Height = 30
        Align = alBottom
        TabOrder = 0
        object IB_UpdateBar1: TIB_UpdateBar
          Left = 4
          Top = 3
          Width = 121
          Height = 25
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
          DataSource = dtsOlcu_Tip
          ReceiveFocus = False
          CustomGlyphsSupplied = []
        end
        object IB_NavigationBar1: TIB_NavigationBar
          Left = 126
          Top = 3
          Width = 121
          Height = 25
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
          DataSource = dtsOlcu_Tip
          ReceiveFocus = False
          CustomGlyphsSupplied = []
        end
        object btnCikis: TBitBtn
          Left = 381
          Top = 4
          Width = 61
          Height = 25
          Caption = #199#305'&k'#305#351
          TabOrder = 2
          OnClick = btnCikisClick
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
      object IB_Grid1: TIB_Grid
        Left = 0
        Top = 0
        Width = 448
        Height = 210
        CustomGlyphsSupplied = []
        DataSource = dtsOlcu_Tip
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 1
        OnKeyPress = IB_Grid1KeyPress
        EditLinksAuto = True
        Ctl3DShallow = True
      end
    end
    object TabSheet2: TTabSheet
      Caption = #214'l'#231#252'ler'
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 210
        Width = 448
        Height = 30
        Align = alBottom
        TabOrder = 0
        object btnVarSay: TButton
          Left = 281
          Top = 2
          Width = 163
          Height = 25
          Caption = 'Se'#231'ili Kayd'#305' Dominant Yap'
          TabOrder = 0
          OnClick = btnVarSayClick
        end
        object IB_NavigationBar2: TIB_NavigationBar
          Left = 127
          Top = 3
          Width = 121
          Height = 25
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 1
          DataSource = dtsOlcu_Bir
          ReceiveFocus = False
          CustomGlyphsSupplied = []
        end
        object IB_UpdateBar2: TIB_UpdateBar
          Left = 4
          Top = 2
          Width = 121
          Height = 25
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 2
          DataSource = dtsOlcu_Bir
          ReceiveFocus = False
          CustomGlyphsSupplied = []
        end
      end
      object IB_Grid2: TIB_Grid
        Left = 0
        Top = 26
        Width = 448
        Height = 184
        CustomGlyphsSupplied = []
        DataSource = dtsOlcu_Bir
        Align = alClient
        TabOrder = 1
        OnKeyPress = IB_Grid1KeyPress
        EditLinksAuto = True
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 448
        Height = 26
        Align = alTop
        TabOrder = 2
        object IB_Text1: TIB_Text
          Left = 8
          Top = 6
          Width = 43
          Height = 13
          AutoSize = True
          DataField = 'OLCU_TIP'
          DataSource = dtsOlcu_Tip
        end
      end
    end
  end
  object qryOlcu_Tip: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    FieldsDisplayLabel.Strings = (
      'OLCU_TIP='#214'l'#231#252' Tipi')
    FieldsGridLabel.Strings = (
      'TIP='#214'l'#231#252' Tipi'
      'ACK=Ac'#305'klama')
    FieldsDisplayWidth.Strings = (
      'TIP=112'
      'ACK=298'
      'OLCU_TIP=106')
    FieldsVisible.Strings = (
      'OLCUTIPID=FALSE'
      'OLCUTIP_SID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT OLCU_TIP'
      '     , ACK'
      'FROM OLCUTIP')
    ColorScheme = False
    KeyLinks.Strings = (
      'OLCUTIP.OLCU_TIP')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryOlcu_TipAfterInsert
    AfterPost = qryOlcu_TipAfterPost
    BeforeDelete = qryOlcu_TipBeforeDelete
    BeforePost = qryOlcu_TipBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 180
    Top = 42
  end
  object qryOlcu_Bir: TIB_Query
    ColumnAttributes.Strings = (
      'DOMINANT=BOOLEAN=1,0;REQUIRED')
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    FieldsDisplayLabel.Strings = (
      'OLCUBIR='#214'l'#231#252' Birimi'
      'DEGERTODOM=Dominant De'#287'er '
      'DOMINANT=Dominant'
      'OLCUBIRIM='#214'l'#231#252' Birimi')
    FieldsDisplayWidth.Strings = (
      'OLCUBIR=128'
      'DEGERTODOM=217'
      'DOMINANT=54')
    FieldsReadOnly.Strings = (
      'DOMINANT=TRUE')
    FieldsVisible.Strings = (
      'OLCUBIRID=FALSE'
      'OLCUBIR_SID=FALSE'
      'OLCUTIPID=FALSE'
      'OLCUTIP_SID=FALSE'
      'OLCU_TIP=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT OLCUBIRIM'
      '     , OLCU_TIP'
      '     , DEGERTODOM'
      '     /*, Cast(DEGERTODOM as Numeric(10,4)) as  DEGERTODOM*/'
      '     , DOMINANT'
      'FROM OLCUBIR')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryOlcu_BirAfterInsert
    BeforeDelete = qryOlcu_BirBeforeDelete
    BeforePost = qryOlcu_BirBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 264
    Top = 40
  end
  object dtsOlcu_Tip: TIB_DataSource
    Dataset = qryOlcu_Tip
    Left = 388
    Top = 92
  end
  object dtsOlcu_Bir: TIB_DataSource
    Dataset = qryOlcu_Bir
    Left = 392
    Top = 36
  end
end
