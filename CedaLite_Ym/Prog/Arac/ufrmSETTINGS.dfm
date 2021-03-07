object frmSettings: TfrmSettings
  Left = 442
  Top = 330
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Web Cam Ayarlar'#305
  ClientHeight = 276
  ClientWidth = 277
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
  object btnSaveSettings: TButton
    Left = 176
    Top = 247
    Width = 95
    Height = 25
    Caption = 'Ayarlar'#305' Kaydet'
    TabOrder = 0
    OnClick = btnSaveSettingsClick
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 277
    Height = 241
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Generic'
      object Label2: TLabel
        Left = 4
        Top = 8
        Width = 45
        Height = 13
        Caption = 'Rastering'
      end
      object txtRastering: TEdit
        Left = 60
        Top = 4
        Width = 29
        Height = 21
        TabOrder = 0
        Text = '10'
      end
      object chkPRESCAN: TCheckBox
        Left = 4
        Top = 28
        Width = 201
        Height = 13
        Caption = 'PRE SCAN (Not Needed at Run Time)'
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Port ve WebCam Se'#231'imi'
      ImageIndex = 1
      object Label9: TLabel
        Left = 4
        Top = 6
        Width = 19
        Height = 13
        Caption = 'Port'
      end
      object Label10: TLabel
        Left = 106
        Top = 28
        Width = 89
        Height = 13
        Caption = 'Protocol I2C Direct'
      end
      object Label11: TLabel
        Left = 4
        Top = 44
        Width = 73
        Height = 13
        Caption = 'Kaynak S'#252'r'#252'c'#252
      end
      object cboPORTLIST: TComboBox
        Left = 3
        Top = 21
        Width = 101
        Height = 21
        ItemHeight = 13
        TabOrder = 0
      end
      object cboCAP_DEVICE: TComboBox
        Left = 3
        Top = 60
        Width = 233
        Height = 21
        ItemHeight = 13
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Image'
      ImageIndex = 2
      object Label1: TLabel
        Left = 2
        Top = 7
        Width = 51
        Height = 13
        Caption = 'Base Color'
      end
      object btnChooseBaseColor: TSpeedButton
        Left = 153
        Top = 3
        Width = 23
        Height = 25
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
        OnClick = btnChooseBaseColorClick
      end
      object sqColor: TShape
        Left = 180
        Top = 3
        Width = 22
        Height = 21
        Shape = stRoundSquare
      end
      object sqAvarage_Color: TShape
        Left = 180
        Top = 27
        Width = 22
        Height = 21
        Shape = stRoundSquare
      end
      object btnChooseAvarage_Color: TSpeedButton
        Left = 153
        Top = 27
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
        OnClick = btnChooseAvarage_ColorClick
      end
      object Label6: TLabel
        Left = 2
        Top = 31
        Width = 67
        Height = 13
        Caption = 'Average Color'
      end
      object Label7: TLabel
        Left = 2
        Top = 55
        Width = 52
        Height = 13
        Caption = 'Even Color'
      end
      object btnChooseEven_Color: TSpeedButton
        Left = 153
        Top = 51
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
          000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
          00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
          F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
          0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
          FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
          FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
          0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
          00333377737FFFFF773333303300000003333337337777777333}
        NumGlyphs = 2
        OnClick = btnChooseEven_ColorClick
      end
      object sqEven_Color: TShape
        Left = 180
        Top = 52
        Width = 22
        Height = 21
        Shape = stRoundSquare
      end
      object Label3: TLabel
        Left = 2
        Top = 79
        Width = 60
        Height = 13
        Caption = 'Image Width'
      end
      object Label8: TLabel
        Left = 2
        Top = 105
        Width = 63
        Height = 13
        Caption = 'Image Height'
      end
      object txtBaseColor: TEdit
        Left = 73
        Top = 3
        Width = 77
        Height = 21
        TabOrder = 0
      end
      object txtAverage_Color: TEdit
        Left = 73
        Top = 27
        Width = 77
        Height = 21
        TabOrder = 1
      end
      object txtEven_Color: TEdit
        Left = 73
        Top = 51
        Width = 77
        Height = 21
        TabOrder = 2
      end
      object txtImageWidth: TEdit
        Left = 73
        Top = 75
        Width = 77
        Height = 21
        ReadOnly = True
        TabOrder = 3
        Text = '1024'
      end
      object txtImageHeight: TEdit
        Left = 73
        Top = 99
        Width = 77
        Height = 21
        ReadOnly = True
        TabOrder = 4
        Text = '768'
      end
    end
  end
  object ColorDialog1: TColorDialog
    Options = [cdFullOpen, cdSolidColor]
    Left = 16
    Top = 247
  end
end
