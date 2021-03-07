object Form1: TForm1
  Left = 350
  Top = 106
  Width = 696
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 392
    Top = 312
    Width = 75
    Height = 25
    Caption = 'frxi'#231'i'
    TabOrder = 1
    OnClick = Button2Click
  end
  object frxReport1: TfrxReport
    Version = '4.0.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39127.517050775500000000
    ReportOptions.LastChange = 39127.682170312510000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure Button1OnClick(Sender: TfrxComponent);'
      'var'
      'a:Integer;'
      'b:String;'
      'begin'
      '      IBXQuery1.Close;'
      '      IBXQuery2.Close;'
      '      IBXQuery1.Sql.Add ('#39'WHERE A.ARAC_KOD<>'#39#39#39#39' '#39');'
      '      //if not cb_listkul.Checked then'
      '      IBXQuery2.Sql.Add ('#39'WHERE A.ARAC_KOD=:ARAC_KOD '#39');'
      '      //WHERE A.ARAC_KOD=:ARAC_KOD'
      '      if DBLookupComboBox2.KeyValue<>null then'
      '      begin'
      '           IBXQuery1.Close;'
      '          IBXQuery1.Sql.Add ('#39' and A.ARAC_KOD=:ARAC_KOD'#39');'
      
        '          IBXQuery1.ParamByName('#39'ARAC_KOD'#39').value:=DBLookupCombo' +
        'Box2.KeyValue;'
      '          //IBXQuery1.Open;'
      '          //showmessage(DBLookupComboBox2.Text);'
      '          //showmessage(DBLookupComboBox2.KeyValue);'
      '      end;'
      '      if cbar_Kul.Checked then'
      '      begin'
      '           //showmessage(DateEdit1.Date);'
      '           IBXQuery2.Close;'
      '           // IBXQuery2.Sql.Add ('#39' and A.TARIH=:TARIH'#39');'
      
        '           IBXQuery2.Sql.Add ('#39' and A.TARIH BETWEEN :TARIH AND :' +
        'TARIH1'#39');'
      '           IBXQuery2.ParamByName('#39'TARIH'#39').Value:='
      '           Datetostr(DateEdit1.Date);'
      '           IBXQuery2.ParamByName('#39'TARIH1'#39').Value:='
      '           Datetostr(DateEdit2.Date);'
      '           DateEdit1.Date;'
      '           //IBXQuery2.Open;'
      '      end;'
      ''
      '      if cb_siralama.itemindex>-1 then'
      '      begin'
      '           if cb_siralama.itemindex=0 then'
      '           IBXQuery1.Sql.Add ('#39' ORDER BY A.ARAC_KOD'#39');'
      '           if cb_siralama.itemindex=1 then'
      '           IBXQuery1.Sql.Add ('#39' ORDER BY A.PLAKA'#39');'
      '      end;'
      ''
      '      if cb_listkul.Checked then'
      '      begin'
      '         //IBXQuery2.Sql.Add ('#39'WHERE A.ARAC_KOD IN :ARAC_KOD '#39');'
      
        '         //IBXQuery2.Sql.Add ('#39'WHERE A.ARAC_KOD IN '#39'+'#39'('#39#39'zsfsf'#39#39 +
        ')'#39');'
      '         // { }[]'
      '         //b:='#39'('#39';'
      '         if CheckListBox1.items.Count>=0 then'
      '         for a:=0 to CheckListBox1.items.Count-1 do'
      '         begin'
      '               if  CheckListBox1.Checked(a) then'
      '               begin'
      '                if a>0 then b:=b+'#39','#39';'
      
        '                // b:=b+'#39#39#39#39'+CheckListBox1.items.Strings(a)+'#39#39#39#39 +
        ';'
      '                b:=b+'#39#39#39#39'+CheckListBox1.items.Strings(a)+'#39#39#39#39';'
      '              end;'
      '         end;'
      '         // b:=b+'#39')'#39';'
      '         // IBXQuery2.Sql.Add ('#39'WHERE A.ARAC_KOD IN ('#39'+b+'#39') '#39');'
      '         // ShowMessage(b);'
      '         //IBXQuery2.ParamByName('#39'ARAC_KOD'#39').Value:=b;'
      '      end;'
      '      Memo15.Text:=           Datetostr(DateEdit2.Date);'
      'end;'
      ''
      'procedure DialogPage1OnShow(Sender: TfrxComponent);'
      'begin'
      '     IBXQuery1.Open;'
      '     while not IBXQuery1.Eof do'
      '     begin'
      
        '       CheckListBox1.items.add(IBXQuery1.FieldByname('#39'ARAC_KOD'#39')' +
        '.Value);'
      '       IBXQuery1.Next;'
      '     end;'
      '     IBXQuery1.First;'
      'end;'
      ''
      'procedure MasterData1OnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '     if cb_listkul.Checked then'
      '     begin'
      
        '        //Showmessage(Inttostr(CheckListBox1.Items.IndexOf(IBXQu' +
        'ery1.FieldByname('#39'ARAC_KOD'#39').Value)));'
      '        //Showmessage(IBXQuery1.FieldByname('#39'ARAC_KOD'#39').Value);'
      
        '         //if CheckListBox1.Items.IndexOf(IBXQuery1.FieldByname(' +
        #39'ARAC_KOD'#39').Value)>-1 then'
      
        '         //if CheckListBox1.Items.IndexOf(IBXQuery1.FieldByname(' +
        #39'ARAC_KOD'#39').Value)>-1 then'
      
        '         if CheckListBox1.Checked(CheckListBox1.Items.IndexOf(IB' +
        'XQuery1.FieldByname('#39'ARAC_KOD'#39').Value)) then'
      '         begin'
      '          MasterData1.Visible:=True;'
      '          DetailData1.Visible:=True;'
      '         end'
      '         else'
      '         begin'
      '          MasterData1.Visible:=False;'
      '          DetailData1.Visible:=False;'
      '         end;'
      '     end;'
      'end;'
      ''
      'procedure MasterData1OnMasterDetail(Sender: TfrxComponent);'
      'begin'
      '     //{'
      ''
      '     //}'
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnGetValue = frxReport1GetValue
    Left = 56
    Top = 80
    Datasets = <
      item
        DataSet = frxReport1.IBXQuery1
        DataSetName = 'IBXQuery1'
      end
      item
        DataSet = frxReport1.IBXQuery2
        DataSetName = 'IBXQuery2'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
      object IBXDatabase1: TfrxIBXDatabase
        DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
        LoginPrompt = False
        Params.Strings = (
          'user_name=sysdba'
          'password=masterkey'
          'lc_ctype=WIN1254')
        SQLDialect = 3
        Connected = True
        pLeft = 108
        pTop = 132
      end
      object IBXQuery1: TfrxIBXQuery
        UserName = 'IBXQuery1'
        CloseDataSource = True
        FieldAliases.Strings = (
          'ARAC_KOD=ARAC_KOD'
          'ARAC_SID=ARAC_SID'
          'PLAKA=PLAKA')
        Params = <>
        SQL.Strings = (
          'SELECT A.ARAC_KOD, A.ARAC_SID, A.PLAKA'
          'FROM'
          '    ARAC A')
        SQLSchema = 
          'eAGLdkksSXRKLE6N5eUKDvSxNbY0N7E0sDQy4+WKDklMykktBko42joGOTrrGJqC' +
          'kJGBAZAyAMq7F2WmAGUNwLLx3v4uOmBljjqGOgZgyMtlCJEL9sQiZ2Qb4OPo7Yip' +
          'KdonMy8bZC8A5QUlEg=='
        Database = frxReport1.IBXDatabase1
        pLeft = 108
        pTop = 192
        Parameters = <>
      end
      object IBXQuery2: TfrxIBXQuery
        UserName = 'IBXQuery2'
        CloseDataSource = True
        Master = frxReport1.IBXQuery1
        Params = <>
        SQL.Strings = (
          'SELECT A.BA, A.TARIH, A.DOVKOD, A.DOVKUR, A.TUTAR, A.ARAC_KOD'
          'FROM'
          '    ARACHAR A')
        SQLSchema = 
          'eAGLdkksSXRKLE6N5eUKDvSxNTYwNTcxMjA2t+Dlig5JTMpJLQbKONo6Bjk6ezgG' +
          '6RiagpCRgQGQMgAqcS/KTAEqMLB1ctSBqXHUMdQxAENeLkPbEMcgTw+scka2Lv5h' +
          '3v4uWCWNwZKhQVglTWxDQoHmYpUzBbs1Hpe50T6ZedkgPwEAGiI6Ig=='
        Database = frxReport1.IBXDatabase1
        pLeft = 212
        pTop = 192
        Parameters = <>
      end
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object ReportTitle1: TfrxReportTitle
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo11: TfrxMemoView
          Left = 540.472790000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[Date]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 631.181510000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[Time]')
          ParentFont = False
        end
        object Memo15: TfrxMemoView
          Left = 30.236240000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[DENE]')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 22.677180000000000000
        Top = 102.047310000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'MasterData1OnBeforePrint'
        DataSet = frxReport1.IBXQuery1
        DataSetName = 'IBXQuery1'
        KeepFooter = True
        RowCount = 0
        OnMasterDetail = 'MasterData1OnMasterDetail'
        object Memo2: TfrxMemoView
          Left = 37.795300000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DataField = 'ARAC_KOD'
          DataSet = frxReport1.IBXQuery1
          DataSetName = 'IBXQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[IBXQuery1."ARAC_KOD"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 234.330860000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          DataField = 'PLAKA'
          DataSet = frxReport1.IBXQuery1
          DataSetName = 'IBXQuery1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[IBXQuery1."PLAKA"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 22.677180000000000000
        Top = 321.260050000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Left = 642.520100000000000000
          Width = 75.590600000000000000
          Height = 18.897650000000000000
          HAlign = haRight
          Memo.UTF8 = (
            '[Page#]')
        end
        object Memo13: TfrxMemoView
          Left = 461.102660000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DataSet = frxReport1.IBXQuery2
          DataSetName = 'IBXQuery2'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[SUM(<IBXQuery2."TUTAR">,DetailData1,2) #n%2,2n]')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        Height = 22.677180000000000000
        Top = 147.401670000000000000
        Width = 718.110700000000000000
        OnBeforePrint = 'DetailData1OnBeforePrint'
        DataSet = frxReport1.IBXQuery2
        DataSetName = 'IBXQuery2'
        RowCount = 0
        OnMasterDetail = 'DetailData1OnMasterDetail'
        object Memo4: TfrxMemoView
          Left = 18.897650000000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          DataField = 'BA'
          DataSet = frxReport1.IBXQuery2
          DataSetName = 'IBXQuery2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[IBXQuery2."BA"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 109.606370000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'TARIH'
          DataSet = frxReport1.IBXQuery2
          DataSetName = 'IBXQuery2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[IBXQuery2."TARIH"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 238.110390000000000000
          Top = 3.779529999999994000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'DOVKOD'
          DataSet = frxReport1.IBXQuery2
          DataSetName = 'IBXQuery2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[IBXQuery2."DOVKOD"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 389.291590000000000000
          Top = 3.779529999999994000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'DOVKUR'
          DataSet = frxReport1.IBXQuery2
          DataSetName = 'IBXQuery2'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[IBXQuery2."DOVKUR"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 525.354670000000000000
          Top = 3.779529999999994000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          DataField = 'TUTAR'
          DataSet = frxReport1.IBXQuery2
          DataSetName = 'IBXQuery2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[IBXQuery2."TUTAR"]')
          ParentFont = False
        end
      end
      object ColumnFooter1: TfrxColumnFooter
        Height = 22.677180000000000000
        Top = 275.905690000000000000
        Width = 718.110700000000000000
        object Memo9: TfrxMemoView
          Left = 313.700990000000000000
          Top = 3.779530000000022000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DataSet = frxReport1.IBXQuery2
          DataSetName = 'IBXQuery2'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[SUM(<IBXQuery2."TUTAR">,DetailData1)]')
          ParentFont = False
        end
      end
      object Footer1: TfrxFooter
        Height = 22.677180000000000000
        Top = 192.756030000000000000
        Width = 718.110700000000000000
        object Memo14: TfrxMemoView
          Left = 464.882190000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            'CGHCGH')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 548.031850000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DataSet = frxReport1.IBXQuery2
          DataSetName = 'IBXQuery2'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '[SUM(<IBXQuery2."TUTAR">,DetailData1)]')
          ParentFont = False
        end
      end
    end
    object DialogPage1: TfrxDialogPage
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Height = 302.000000000000000000
      Left = 256.000000000000000000
      Top = 163.000000000000000000
      Width = 518.000000000000000000
      OnShow = 'DialogPage1OnShow'
      object Button1: TfrxButtonControl
        Left = 28.000000000000000000
        Top = 176.000000000000000000
        Width = 75.000000000000000000
        Height = 25.000000000000000000
        Caption = '&Rapor'
        ModalResult = 1
        OnClick = 'Button1OnClick'
      end
      object Button2: TfrxButtonControl
        Left = 156.000000000000000000
        Top = 176.000000000000000000
        Width = 75.000000000000000000
        Height = 25.000000000000000000
        Caption = '&Kapat'
        ModalResult = 2
      end
      object Edit1: TfrxEditControl
        Left = 56.000000000000000000
        Top = 28.000000000000000000
        Width = 101.000000000000000000
        Height = 21.000000000000000000
        Color = clWindow
        MaxLength = 0
        PasswordChar = #0
        Text = 'sdfsdf'
      end
      object Edit2: TfrxEditControl
        Left = 188.000000000000000000
        Top = 28.000000000000000000
        Width = 101.000000000000000000
        Height = 21.000000000000000000
        Color = clWindow
        MaxLength = 0
        PasswordChar = #0
        Text = 'Edit2'
      end
      object Button3: TfrxButtonControl
        Left = 56.000000000000000000
        Top = 52.000000000000000000
        Width = 75.000000000000000000
        Height = 25.000000000000000000
        Caption = 'Arac Kod Se'#231
        OnClick = 'Button3OnClick'
      end
      object Button4: TfrxButtonControl
        Left = 188.000000000000000000
        Top = 52.000000000000000000
        Width = 75.000000000000000000
        Height = 25.000000000000000000
        Caption = 'Arac Kod Se'#231
        OnClick = 'Button3OnClick'
      end
      object DBLookupComboBox2: TfrxDBLookupComboBox
        Left = 56.000000000000000000
        Top = 4.000000000000000000
        Width = 101.000000000000000000
        Height = 21.000000000000000000
        ListField = 'PLAKA'
        DataSet = frxReport1.IBXQuery1
        DataSetName = 'IBXQuery1'
        KeyField = 'ARAC_KOD'
      end
      object DBLookupComboBox3: TfrxDBLookupComboBox
        Left = 188.000000000000000000
        Top = 4.000000000000000000
        Width = 101.000000000000000000
        Height = 21.000000000000000000
        ListField = 'ARAC_KOD'
        DataSet = frxReport1.IBXQuery1
        DataSetName = 'IBXQuery1'
        KeyField = 'ARAC_KOD'
      end
      object DateEdit1: TfrxDateEditControl
        Left = 52.000000000000000000
        Top = 112.000000000000000000
        Width = 105.000000000000000000
        Height = 21.000000000000000000
        Color = clWindow
        Date = 39127.524005706000000000
        Time = 39127.524005706000000000
      end
      object ComboBox1: TfrxComboBoxControl
        Left = 176.000000000000000000
        Top = 84.000000000000000000
        Width = 105.000000000000000000
        Height = 21.000000000000000000
        Color = clWindow
        Text = 'ComboBox1'
        ItemIndex = -1
      end
      object DateEdit2: TfrxDateEditControl
        Left = 176.000000000000000000
        Top = 112.000000000000000000
        Width = 105.000000000000000000
        Height = 21.000000000000000000
        Color = clWindow
        Date = 39127.524005706000000000
        Time = 39127.524005706000000000
      end
      object cbar_Kul: TfrxCheckBoxControl
        Left = 52.000000000000000000
        Top = 132.000000000000000000
        Width = 97.000000000000000000
        Height = 17.000000000000000000
        Caption = 'Tarihi Kullan'
        Color = clBtnFace
      end
      object Panel1: TfrxPanelControl
        Left = 32.000000000000000000
        Top = 212.000000000000000000
        Width = 257.000000000000000000
        Height = 41.000000000000000000
        Color = clBtnFace
        OnClick = 'Panel1OnClick'
        object cb_siralama: TfrxComboBoxControl
          Left = 104.000000000000000000
          Top = 8.000000000000000000
          Width = 145.000000000000000000
          Height = 21.000000000000000000
          Color = clWindow
          Items.Strings = (
            'ARAC KODU'
            'PLAKA')
          ItemIndex = -1
        end
        object Label1: TfrxLabelControl
          Left = 4.000000000000000000
          Top = 12.000000000000000000
          Width = 46.000000000000000000
          Height = 13.000000000000000000
          Caption = 'S'#305'aralama'
          Color = clBtnFace
        end
      end
      object ListBox1: TfrxListBoxControl
        Left = 320.000000000000000000
        Top = 8.000000000000000000
        Width = 121.000000000000000000
        Height = 97.000000000000000000
        Color = clWindow
      end
      object CheckListBox1: TfrxCheckListBoxControl
        Left = 308.000000000000000000
        Top = 108.000000000000000000
        Width = 121.000000000000000000
        Height = 97.000000000000000000
        Color = clWindow
      end
      object cb_listkul: TfrxCheckBoxControl
        Left = 308.000000000000000000
        Top = 208.000000000000000000
        Width = 97.000000000000000000
        Height = 17.000000000000000000
        Caption = 'cb_listkul'
        Color = clBtnFace
      end
      object Label2: TfrxLabelControl
        Left = 8.000000000000000000
        Top = 8.000000000000000000
        Width = 31.000000000000000000
        Height = 13.000000000000000000
        Caption = 'Label2'
        Color = clBtnFace
      end
    end
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = 'C:\CedaLite\Trans_Db\TRANSPORT.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=WIN1254')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 200
    Top = 64
  end
  object fsIBXRTTI1: TfsIBXRTTI
    Left = 168
    Top = 144
  end
  object fsPascal1: TfsPascal
    Left = 136
    Top = 200
  end
end
