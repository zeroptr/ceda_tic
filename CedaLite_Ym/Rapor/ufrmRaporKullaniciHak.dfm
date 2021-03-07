object frmRaporKullaniciHak: TfrmRaporKullaniciHak
  Left = 418
  Top = 258
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Kullan'#305'c'#305' Haklar'#305' Raporu'
  ClientHeight = 124
  ClientWidth = 243
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 91
    Width = 243
    Height = 33
    Align = alBottom
    TabOrder = 0
    object btnRapor: TButton
      Left = 53
      Top = 4
      Width = 77
      Height = 25
      Caption = '&Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object btnCikis: TButton
      Left = 129
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = btnCikisClick
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 243
    Height = 91
    ActivePage = TabSheet1
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object cmbUsers: TComboBox
        Left = 3
        Top = 21
        Width = 229
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnEnter = cmbUsersEnter
        OnExit = cmbUsersExit
      end
    end
  end
end
