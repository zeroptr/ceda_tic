object frmSrcDlg: TfrmSrcDlg
  Left = 392
  Top = 167
  Width = 545
  Height = 307
  ActiveControl = txtAra
  BorderIcons = []
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 537
    Height = 50
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 4
      Width = 46
      Height = 13
      Caption = '&Saha Ad'#305':'
      FocusControl = cboFields
    end
    object Label2: TLabel
      Left = 130
      Top = 4
      Width = 67
      Height = 13
      Caption = 'Aranacak &Veri'
      FocusControl = txtAra
    end
    object txtAra: TEdit
      Left = 128
      Top = 19
      Width = 302
      Height = 21
      TabOrder = 1
      OnEnter = txtAraEnter
      OnExit = txtAraExit
      OnKeyDown = txtAraKeyDown
      OnKeyPress = txtAraKeyPress
    end
    object btnAra: TButton
      Left = 433
      Top = 19
      Width = 37
      Height = 21
      Caption = '&Ara'
      TabOrder = 2
      OnClick = btnAraClick
    end
    object cboFields: TComboBox
      Left = 11
      Top = 19
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnClick = cboFieldsClick
      OnEnter = cboFieldsEnter
      OnExit = cboFieldsExit
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 250
    Width = 537
    Height = 30
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      537
      30)
    object cmdOK: TBitBtn
      Left = 448
      Top = 3
      Width = 85
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = '&Tamam'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = cmdOKClick
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
    object cmdCancel: TBitBtn
      Left = 361
      Top = 3
      Width = 85
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = #304'&ptal'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = cmdCancelClick
      Kind = bkCancel
    end
  end
  object grdSel: TIB_Grid
    Left = 0
    Top = 50
    Width = 537
    Height = 200
    CustomGlyphsSupplied = []
    DataSource = IB_DataSource1
    Align = alClient
    OnDblClick = cmdOKClick
    TabOrder = 1
    RowSelect = True
    TabMovesOut = True
  end
  object qrySRCDLG: TIB_Query
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 256
    Top = 128
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = qrySRCDLG
    Left = 160
    Top = 128
  end
end
