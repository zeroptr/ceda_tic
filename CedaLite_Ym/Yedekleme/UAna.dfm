object Form1: TForm1
  Left = 354
  Top = 156
  Caption = 'Data De'#287'i'#351'tirme Aktar'#305'm'#305' Program'#305
  ClientHeight = 251
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = TURKISH_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 16
    Top = 320
    Width = 80
    Height = 14
    Caption = 'Yerel Data Yeri'
  end
  object Label2: TLabel
    Left = 16
    Top = 352
    Width = 115
    Height = 14
    Caption = 'Ana Makine Data Yeri'
  end
  object Label3: TLabel
    Left = 80
    Top = 176
    Width = 232
    Height = 14
    Caption = 'Dikkat Bu '#304#351'lemin Hatas'#305'z Yap'#305'lbilmesi i'#231'in;'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 192
    Width = 381
    Height = 14
    Caption = 
      'Laptop'#39' ta ve Ofis'#39' te Transport Pogram'#305'n'#305'n '#199'al'#305#351'mas'#305' Gerekmekte' +
      'dir'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 64
    Top = 208
    Width = 265
    Height = 14
    Caption = 'A'#231#305'k Olan Programlar var ise Progralar'#305' Kapat'#305'n'#305'z'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lbl_Durum: TLabel
    Left = 16
    Top = 8
    Width = 38
    Height = 14
    Caption = #350'u An :'
  end
  object Label6: TLabel
    Left = 8
    Top = 424
    Width = 301
    Height = 14
    Caption = 'Laptop ve Ofis teki Dosya Adlar'#305' Ayn'#305' olmak zorundad'#305'r'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object txtYerel: TEdit
    Left = 144
    Top = 314
    Width = 217
    Height = 22
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 368
    Top = 312
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = Button1Click
  end
  object txtAg: TEdit
    Left = 144
    Top = 346
    Width = 217
    Height = 22
    TabOrder = 2
  end
  object Button2: TButton
    Left = 368
    Top = 344
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = Button2Click
  end
  object rg_Aktarma: TRadioGroup
    Left = 688
    Top = 368
    Width = 209
    Height = 49
    Caption = 'Aktarma Tipi'
    ItemIndex = 0
    Items.Strings = (
      'Yerelden Ana Makineye Aktar'
      'Ana Makineden Yerele Aktar')
    TabOrder = 5
    Visible = False
  end
  object Button3: TButton
    Left = 704
    Top = 312
    Width = 209
    Height = 33
    Caption = 'Aktarmay'#305' &Ba'#351'lat'
    TabOrder = 6
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 288
    Top = 376
    Width = 107
    Height = 25
    Caption = '&Ayarlar'#305' Kaydet'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Btn_Laptop_Ofis: TBitBtn
    Left = 17
    Top = 33
    Width = 377
    Height = 65
    Caption = 'Lapton'#39' tan -------------> Ofis'#39' e Aktar'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Btn_Ofis_Laptop: TBitBtn
    Left = 16
    Top = 104
    Width = 377
    Height = 65
    Caption = 'Ofis'#39' ten -------------> Laptop'#39' a Aktar'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button5: TButton
    Left = 744
    Top = 264
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 9
    Visible = False
    OnClick = Button5Click
  end
  object mp: TMediaPlayer
    Left = 640
    Top = 136
    Width = 253
    Height = 30
    Visible = False
    TabOrder = 10
  end
  object Button6: TButton
    Left = 784
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 11
    Visible = False
    OnClick = Button6Click
  end
  object cb_datacopy: TCheckBox
    Left = 16
    Top = 232
    Width = 233
    Height = 17
    Caption = 'Data Kopyalama Yapmadan Ge'#231'i'#351' Yap'
    TabOrder = 12
  end
  object Od: TOpenDialog
    Left = 352
    Top = 112
  end
  object IB_Conn: TIB_Connection
    SQLDialect = 3
    Params.Strings = (
      'CHARACTER SET=WIN1254'
      'USER NAME=sysdba'
      'SQL DIALECT=3'
      'PAGE SIZE=8192')
    Left = 232
    Top = 112
  end
  object Query_Dosya: TIB_Query
    IB_Connection = IB_Conn
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 168
    Top = 112
  end
end
