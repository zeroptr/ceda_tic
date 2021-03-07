object frmFoto_Ana: TfrmFoto_Ana
  Left = 255
  Top = 179
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsNone
  ClientHeight = 100
  ClientWidth = 104
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnDblClick = FormDblClick
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object IB_Image1: TIB_Image
    Left = 0
    Top = 0
    Width = 100
    Height = 100
    AutoLabel.Margin = -15
    DataField = 'LOGO'
    DataSource = dts_Sirket
    OnDblClick = IB_Image1DblClick
    PreventSearching = True
    TabOrder = 0
    AutoSize = True
    Stretch = True
  end
  object qry_Sirket: TIB_Query
    ColumnAttributes.Strings = (
      'AKTIF=BOOLEAN=1,0')
    DatabaseName = 'c:\CedaLite\Trans_Db\MAIN.FDB'
    FieldsDisplayFormat.Strings = (
      'TEL1=#(###)#######'
      'TEL2=#(###)#######'
      'FAX=#(###)#######'
      'VERNO=### ### ####'
      'PK=#####'
      'TOPLAM_SUBE_ADET=###'
      'SIRKET_KOD=#####')
    FieldsDisplayLabel.Strings = (
      'ADI='#350'irket Ad'#305' :'
      'YETKILI='#350'irket Yetkilisi :'
      'ADRES_1=Adres (1) :'
      'ADRES_2=Adres (2) :'
      'ILCE='#304'l'#231'e :'
      'SEHIR='#350'ehir :'
      'PK=Posta Kodu :'
      'TEL1=Telefon (1) :'
      'TEL2=Telefon (2) :'
      'FAX=Fax :'
      'VERDAIRE=Vergi Dairesi :'
      'VERNO=Vergi Numaras'#305' :'
      'LOGO='#350'irket Logosu :'
      'TOPLAM_SUBE_ADET=Toplam '#350'ube Adedi :'
      'SIRKET_KOD='#350'irket Kodu :'
      'TIC_SIC_NO=Ticaret Sicil No'
      'TIC_ODA_NO=Ticaret Oda No'
      'SSK_SIC_NO=SSK Sicil No'
      'SIRKET_AD='#350'irket Ad'#305
      'SIRKET_ID='#350'irket No')
    FieldsEditMask.Strings = (
      'TEL1=#(###)#######'
      'TEL2=#(###)#######'
      'FAX=#(###)#######'
      'VERNO=### ### ####'
      'PK=#####'
      'TOPLAM_SUBE_ADET=###'
      'SIRKET_KOD=#####')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SIRKET_ID'
      '     , SIRKET_AD'
      '     , YETKILI'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , PK'
      '     , TEL1'
      '     , TEL2'
      '     , FAX'
      '     , VERDAIRE'
      '     , VERNO'
      '     , LOGO'
      '     , TOPLAM_SUBE_ADET'
      '     , TIC_SIC_NO'
      '     , TIC_ODA_NO'
      '     , SSK_SIC_NO'
      '     , AKTIF'
      'FROM SIRKET'
      'WHERE SIRKET_ID=:PRM_SIRKET_ID;'
      '/*WHERE SIRKET_ID=1;*/'
      '')
    ColorScheme = False
    DefaultValues.Strings = (
      'AKTIF=1')
    KeyLinks.Strings = (
      'SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 452
    Top = 125
  end
  object dts_Sirket: TIB_DataSource
    Dataset = qry_Sirket
    Left = 500
    Top = 129
  end
end
