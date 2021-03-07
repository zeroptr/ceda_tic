object frmCARHAR_AKT: TfrmCARHAR_AKT
  Left = 279
  Top = 329
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cari Hareket Aktar'#305'm'#305
  ClientHeight = 178
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 2
    Width = 38
    Height = 13
    Caption = #304'lk Tarih'
  end
  object Label2: TLabel
    Left = 120
    Top = 0
    Width = 46
    Height = 13
    Caption = 'Son Tarih'
  end
  object Label3: TLabel
    Left = 156
    Top = 68
    Width = 18
    Height = 13
    Caption = '---->'
  end
  object lblSrcCARIAD: TLabel
    Left = 12
    Top = 88
    Width = 109
    Height = 49
    AutoSize = False
    WordWrap = True
  end
  object lblTgtCARIAD: TLabel
    Left = 188
    Top = 88
    Width = 109
    Height = 49
    AutoSize = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 12
    Top = 48
    Width = 36
    Height = 13
    Caption = 'Kaynak'
  end
  object Label5: TLabel
    Left = 188
    Top = 52
    Width = 29
    Height = 13
    Caption = 'Hedef'
  end
  object dtILKTAR: TDateTimePicker
    Left = 11
    Top = 17
    Width = 81
    Height = 21
    Date = 37998.472171157410000000
    Time = 37998.472171157410000000
    TabOrder = 0
  end
  object dtSONTAR: TDateTimePicker
    Left = 119
    Top = 16
    Width = 89
    Height = 21
    Date = 37998.472502465280000000
    Time = 37998.472502465280000000
    TabOrder = 1
  end
  object txtSrcCari: TEdit
    Left = 12
    Top = 64
    Width = 109
    Height = 21
    TabOrder = 2
  end
  object btnSrcSec: TButton
    Left = 124
    Top = 65
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = btnSrcSecClick
  end
  object txtTgtCari: TEdit
    Left = 188
    Top = 64
    Width = 109
    Height = 21
    TabOrder = 4
  end
  object btnTgtSec: TButton
    Left = 300
    Top = 65
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 5
    OnClick = btnTgtSecClick
  end
  object btnAKTAR: TButton
    Left = 240
    Top = 152
    Width = 89
    Height = 21
    Caption = 'Aktar'#305'm'#305' Yap'
    TabOrder = 6
    OnClick = btnAKTARClick
  end
  object chkMUHASEBE: TCheckBox
    Left = 8
    Top = 152
    Width = 213
    Height = 17
    Caption = 'Entegre Muhasebe Kay'#305'tlar'#305'n'#305'da D'#252'zelt'
    TabOrder = 7
    Visible = False
  end
end
