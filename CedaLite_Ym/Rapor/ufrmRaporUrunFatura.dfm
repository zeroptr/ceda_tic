object frmRaporUrunFatura: TfrmRaporUrunFatura
  Left = 452
  Top = 347
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Fatura Ayr'#305'nt'#305'l'#305' '#220'r'#252'n Listesi'
  ClientHeight = 224
  ClientWidth = 286
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
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 286
    Height = 187
    ActivePage = TabSheet1
    Align = alTop
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Parametreler'
      object chkSirket: TCheckBox
        Left = 42
        Top = 138
        Width = 213
        Height = 17
        Caption = 'Rapor '#252'st ba'#351'l'#305#287#305' olarak '#351'irket bilgisi ekle'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnEnter = chkSirketEnter
        OnExit = chkSirketExit
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 278
        Height = 43
        Align = alTop
        Caption = #220'r'#252'n Kod Aral'#305#287#305
        TabOrder = 0
        object txtUrunKod1: TEdit
          Left = 6
          Top = 16
          Width = 101
          Height = 21
          TabOrder = 0
          OnEnter = txtUrunKod1Enter
          OnExit = txtUrunKod1Exit
          OnKeyDown = txtUrunKod1KeyDown
          OnKeyPress = txtUrunKod1KeyPress
        end
        object txtUrunKod2: TEdit
          Left = 150
          Top = 16
          Width = 101
          Height = 21
          TabOrder = 2
          OnEnter = txtUrunKod1Enter
          OnExit = txtUrunKod1Exit
          OnKeyDown = txtUrunKod2KeyDown
          OnKeyPress = txtUrunKod1KeyPress
        end
        object btnUrunKod1: TButton
          Left = 108
          Top = 16
          Width = 19
          Height = 21
          Caption = '...'
          TabOrder = 1
          TabStop = False
          OnClick = btnUrunKod1Click
        end
        object btnUrunKod2: TButton
          Left = 252
          Top = 16
          Width = 19
          Height = 21
          Caption = '...'
          TabOrder = 3
          TabStop = False
          OnClick = btnUrunKod2Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 43
        Width = 278
        Height = 48
        Align = alTop
        Caption = 'Tarih Aral'#305#287#305
        TabOrder = 1
        object dtpTarih1: TDateTimePicker
          Left = 6
          Top = 18
          Width = 121
          Height = 21
          Date = 38121.617936157410000000
          Time = 38121.617936157410000000
          TabOrder = 0
          OnEnter = dtpTarih1Enter
          OnExit = dtpTarih1Exit
        end
        object dtpTarih2: TDateTimePicker
          Left = 150
          Top = 18
          Width = 121
          Height = 21
          Date = 38121.617936157410000000
          Time = 38121.617936157410000000
          TabOrder = 1
          OnEnter = dtpTarih1Enter
          OnExit = dtpTarih1Exit
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 91
        Width = 278
        Height = 42
        Align = alTop
        Caption = 'Fatura Tipi'
        TabOrder = 2
        object cmbFaturaTip: TComboBox
          Left = 72
          Top = 12
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          ItemIndex = 0
          TabOrder = 0
          Text = 'Sat'#305#351' Faturas'#305
          OnEnter = cmbFaturaTipEnter
          OnExit = cmbFaturaTipExit
          Items.Strings = (
            'Sat'#305#351' Faturas'#305
            'Al'#305#351' Faturas'#305
            'Hepsi')
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 191
    Width = 286
    Height = 33
    Align = alBottom
    TabOrder = 1
    object btnRapor: TButton
      Left = 11
      Top = 4
      Width = 76
      Height = 25
      Caption = '&Rapor'
      TabOrder = 0
      OnClick = btnRaporClick
    end
    object btnCikis: TButton
      Left = 200
      Top = 4
      Width = 75
      Height = 25
      Caption = #199#305'&k'#305#351
      TabOrder = 1
      OnClick = btnCikisClick
    end
  end
  object qryRapor: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    ReadOnly = True
    Left = 96
    Top = 56
  end
  object qryDekontD: TIB_Cursor
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT BA,MIKTAR FROM DEKONT_D '
      'WHERE DEKONT_D.KARSI_KOD = :PRM_KARSI_KOD'
      'AND DEKONT_D.MC='#39'U'#39)
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    Left = 156
    Top = 18
  end
end
