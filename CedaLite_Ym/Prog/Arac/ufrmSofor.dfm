object frmSofor: TfrmSofor
  Left = 332
  Top = 188
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #350#246'f'#246'r Tan'#305'mlama'
  ClientHeight = 328
  ClientWidth = 475
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
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 360
    Top = 0
    Width = 105
    Height = 105
    Stretch = True
    OnDblClick = IB_Image1DblClick
  end
  object IB_Edit1: TIB_Edit
    Left = 88
    Top = 8
    Width = 137
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'SOFOR_KOD'
    DataSource = dtsSofor
    TabOrder = 0
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    OnKeyPress = IB_Edit1KeyPress
  end
  object IB_Edit2: TIB_Edit
    Left = 88
    Top = 32
    Width = 216
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADI_SOYADI'
    DataSource = dtsSofor
    TabOrder = 1
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    OnKeyPress = IB_Edit2KeyPress
  end
  object IB_Edit5: TIB_Edit
    Left = 88
    Top = 104
    Width = 137
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'TEL_NO1'
    DataSource = dtsSofor
    TabOrder = 4
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit8: TIB_Edit
    Left = 88
    Top = 56
    Width = 249
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADRESI1'
    DataSource = dtsSofor
    TabOrder = 2
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit12: TIB_Edit
    Left = 88
    Top = 80
    Width = 249
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'ADRESI2'
    DataSource = dtsSofor
    TabOrder = 3
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit13: TIB_Edit
    Left = 88
    Top = 152
    Width = 225
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'VERGI_DAIRE'
    DataSource = dtsSofor
    TabOrder = 6
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object Panel1: TPanel
    Left = 0
    Top = 298
    Width = 475
    Height = 30
    Align = alBottom
    TabOrder = 17
    object btnCikis: TBitBtn
      Left = 424
      Top = 2
      Width = 49
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 0
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
    object btnAra: TBitBtn
      Left = 379
      Top = 2
      Width = 43
      Height = 25
      Caption = '&Ara'
      TabOrder = 1
      OnClick = btnAraClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
        3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
        33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
    end
    object btnYeni: TBitBtn
      Left = 3
      Top = 3
      Width = 62
      Height = 25
      Caption = 'Yeni (INS)'
      TabOrder = 2
      OnClick = btnYeniClick
      NumGlyphs = 2
    end
    object btnKaydet: TButton
      Left = 66
      Top = 3
      Width = 91
      Height = 25
      Caption = 'Kaydet (CTRL+S)'
      TabOrder = 3
      OnClick = btnKaydetClick
    end
    object btnIPTAL: TButton
      Left = 158
      Top = 3
      Width = 80
      Height = 25
      Caption = #304'ptal(CTRL+P)'
      TabOrder = 4
      OnClick = btnIPTALClick
    end
    object btnSil: TButton
      Left = 239
      Top = 3
      Width = 87
      Height = 25
      Caption = 'Sil (CTRL+DEL)'
      TabOrder = 5
      OnClick = btnSilClick
    end
    object Btn_Onceki: TButton
      Left = 328
      Top = 3
      Width = 25
      Height = 25
      Caption = '<'
      TabOrder = 6
      OnClick = Btn_OncekiClick
    end
    object Btn_Sonraki: TButton
      Left = 352
      Top = 3
      Width = 25
      Height = 25
      Caption = '>'
      TabOrder = 7
      OnClick = Btn_SonrakiClick
    end
  end
  object IB_Currency1: TIB_Currency
    Left = 224
    Top = 200
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'BORC'
    DataSource = dtsSofor
    Enabled = False
    Visible = False
    ReadOnly = True
    TabOrder = 12
    AlwaysShowButton = True
  end
  object IB_Currency3: TIB_Currency
    Left = 224
    Top = 176
    Width = 121
    Height = 21
    TabStop = False
    AutoLabel.Kind = albLeft
    DataField = 'ALACAK'
    DataSource = dtsSofor
    Enabled = False
    Visible = False
    ReadOnly = True
    TabOrder = 13
    AlwaysShowButton = True
  end
  object IB_Edit3: TIB_Edit
    Left = 88
    Top = 176
    Width = 137
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'VERGI_NO'
    DataSource = dtsSofor
    TabOrder = 7
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit10: TIB_Edit
    Left = 88
    Top = 200
    Width = 137
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'EHLIYET_NO'
    DataSource = dtsSofor
    TabOrder = 8
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_Edit15: TIB_Edit
    Left = 88
    Top = 128
    Width = 137
    Height = 21
    AutoLabel.Kind = albLeft
    DataField = 'TEL_NO2'
    DataSource = dtsSofor
    TabOrder = 5
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
  end
  object IB_CheckBox1: TIB_CheckBox
    Left = 368
    Top = 208
    Width = 97
    Height = 13
    DataField = 'LISTEDEN_CIKAR'
    DataSource = dtsSofor
    BorderStyle = bsNone
    TabOrder = 11
    Caption = 'Listeden '#199#305'kart'
  end
  object Button1: TButton
    Left = 360
    Top = 112
    Width = 107
    Height = 25
    Caption = 'Resim Se'#231
    TabOrder = 14
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 360
    Top = 136
    Width = 107
    Height = 25
    Caption = 'Resmi Sil'
    TabOrder = 15
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 360
    Top = 160
    Width = 107
    Height = 25
    Caption = 'WebCam Resim Al'
    TabOrder = 16
    Visible = False
    OnClick = Button3Click
  end
  object IB_CheckBox2: TIB_CheckBox
    Left = 368
    Top = 192
    Width = 97
    Height = 13
    DataField = 'KARA_LISTE'
    DataSource = dtsSofor
    BorderStyle = bsNone
    TabOrder = 10
    Caption = 'Kara Listeye Al'
  end
  object IB_Memo1: TIB_Memo
    Left = 88
    Top = 224
    Width = 385
    Height = 65
    AutoLabel.Kind = albLeft
    DataField = 'ACIKLAMA'
    DataSource = dtsSofor
    TabOrder = 9
    OnEnter = IB_Edit1Enter
    OnExit = IB_Edit1Exit
    AutoSize = False
  end
  object qrySofor: TIB_Query
    ColumnAttributes.Strings = (
      'LISTEDEN_CIKAR=BOOLEAN=1,0'
      'KARA_LISTE=BOOLEAN=1,0')
    DatabaseName = 'C:\Musteriler\ekinci\TRANSPORT_EKINCI.FDB'
    FieldsDisplayFormat.Strings = (
      'TELNO_1=0(###)#######'
      'TELNO_2=0(###)#######'
      'FAX=0(###)#######'
      'TEL_NO1=0(###)#######'
      'TEL_NO2=0(###)#######'
      'VERGI_NO=### ### ####')
    FieldsDisplayLabel.Strings = (
      'PLASIYER_KOD=Kodu:'
      'ADISOY=Ad'#305' Soyad'#305' :'
      'FIRMA_ID=Firma Ad'#305' :'
      'TELNO_1=Telefon(1) :'
      'TELNO_2=Telefon(2) :'
      'FAX=Fax :'
      'ADRES_1=Adres (1) :'
      'ADRES_2=Adres (2) :'
      'ILCE='#304'l'#231'e :'
      'SEHIR='#350'ehir :'
      'POSTAKOD=P. Kodu :'
      'EMAIL=E - Mail :'
      'WEBADDR=Web Adresi :'
      'BORC=Borc'
      'ALACAK=Alacak'
      'BORC_VPB=Borc VPB'
      'ALACAK_VPB=Alacak VPB'
      'DOVKOD=Para Birimi'
      'PERSONEL_KOD=Personel Kod'
      'ADI_SOYADI=Ad'#305' Soyad'#305
      'SICIL_NO=Sicil No'
      'SSK_NO=SSK No'
      'GIRIS_TARIH=Giri'#351' Tarihi'
      'CIKIC_TARIH='#199#305'k'#305#351' Tarihi'
      'DOGUM_TARIH=Do'#287'um Tarihi'
      'DOGUM_YER=Do'#287'um Yeri'
      'CINSIYET=Cinsiyeti'
      'TAHSIL=Tahsil Durumu'
      'EVLI=Medeni Durumu'
      'GOREVI=G'#246'revi'
      'VERGI_NO=Vergi Dairesi No'
      'VERGI_DAIRE=Vergi Dairesi'
      'VERGI_KARNE_TARIH=Vergi Karne Tarihi'
      'TEL_NO=Telefon No'
      'LISTEDEN_CIKAR=Listeden '#199#305'kar'
      'DEVREDEN_BORC=Devreden Borc'
      'DEVREDEN_ALACAK=Devreden Alacak'
      'SOFOR_KOD=Kodu'
      'ADRESI1=Adres1'
      'ADRESI2=Adres2'
      'TEL_NO1=Tel1'
      'TEL_NO2=Tel2'
      'EHLIYET_NO=Ehliyet No'
      'ACIKLAMA=A'#231#305'klama'
      'RESIM=Resim'
      'KARA_LISTE=Kara Listeye Al')
    FieldsEditMask.Strings = (
      'TELNO_1=0(###)#######'
      'TELNO_2=0(###)#######'
      'FAX=0(###)#######'
      'TEL_NO1=0(###)#######'
      'TEL_NO2=0(###)#######'
      'VERGI_NO=### ### ####')
    FieldsReadOnly.Strings = (
      'BORC=TRUE'
      'ALACAK=TRUE'
      'BORC_VPB=TRUE'
      'ALACAK_VPB=TRUE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT SOFOR_KOD'
      '     , SOFOR_SID'
      '     , ADI_SOYADI'
      '     , ADRESI1'
      '     , ADRESI2'
      '     , TEL_NO1'
      '     , TEL_NO2'
      '     , EHLIYET_NO'
      '     , VERGI_DAIRE'
      '     , VERGI_NO'
      '     , LISTEDEN_CIKAR'
      '     , ACIKLAMA'
      '     , BORC'
      '     , ALACAK'
      '     , DEVREDEN_BORC'
      '     , DEVREDEN_ALACAK'
      '     , RESIM'
      '     , KARA_LISTE'
      'FROM SOFOR'
      'WHERE SOFOR_KOD=:PRM_SOFOR_KOD')
    ColorScheme = False
    DefaultValues.Strings = (
      'BORC=0'
      'ALACAK=0'
      'BORC_VPB=0'
      'ALACAK_VPB=0'
      'PASIF=0')
    KeyLinks.Strings = (
      'SOFOR.SOFOR_KOD')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    AfterInsert = qrySoforAfterInsert
    AfterScroll = qrySoforAfterScroll
    BeforeDelete = qrySoforBeforeDelete
    BeforePost = qrySoforBeforePost
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 280
    Top = 120
    ParamValues = (
      'PRM_SOFOR_KOD=')
  end
  object dtsSofor: TIB_DataSource
    AutoInsert = False
    Dataset = qrySofor
    OnStateChanged = dtsSoforStateChanged
    Left = 320
    Top = 72
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 416
    Top = 16
  end
end
