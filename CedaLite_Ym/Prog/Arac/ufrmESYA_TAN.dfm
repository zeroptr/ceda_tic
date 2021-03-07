object frmESYA_TAN: TfrmESYA_TAN
  Left = 436
  Top = 219
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'E'#351'ya Tan'#305'mlamalar'#305
  ClientHeight = 229
  ClientWidth = 232
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object IB_Grid1: TIB_Grid
    Left = 0
    Top = 0
    Width = 232
    Height = 185
    CustomGlyphsSupplied = []
    DataSource = dtsESYA
    Align = alTop
    BorderStyle = bsNone
    TabOrder = 0
    OnKeyPress = IB_Grid1KeyPress
    Ctl3DShallow = True
  end
  object IB_UpdateBar1: TIB_UpdateBar
    Left = 3
    Top = 194
    Width = 151
    Height = 33
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    DataSource = dtsESYA
    ReceiveFocus = False
    AppendOnInsert = True
    CustomGlyphsSupplied = []
  end
  object qryESYA: TIB_Query
    DatabaseName = 'C:\CedaLite\Antrepo\DB\ANT_2009.FDB'
    FieldsGridLabel.Strings = (
      'ESYA_ID=E'#351'ya No'
      'ESYA_AD=E'#351'ya')
    FieldsDisplayWidth.Strings = (
      'ESYA_ID=73')
    FieldsVisible.Strings = (
      'ESYA_ID=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT *'
      'FROM ESYA')
    ColorScheme = False
    KeyLinks.Strings = (
      'ESYA.ESYA_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qryESYAAfterInsert
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 32
    Top = 128
  end
  object dtsESYA: TIB_DataSource
    Dataset = qryESYA
    Left = 80
    Top = 128
  end
end
