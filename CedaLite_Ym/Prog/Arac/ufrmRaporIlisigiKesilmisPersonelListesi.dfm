object frmRaporIlisigiKesilmisPersonelListesi: TfrmRaporIlisigiKesilmisPersonelListesi
  Left = 276
  Top = 107
  Width = 332
  Height = 175
  Caption = 'frmRaporIlisigiKesilmisPersonelListesi'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object frxIBODts_IKes_Pers: TfrxIBODataset
    UserName = 'frxIBODts_IKes_Pers'
    CloseDataSource = False
    FieldAliases.Strings = (
      'PERSONEL_KOD=PERSONEL_KOD'
      'ADI_SOYADI=ADI_SOYADI'
      'SICIL_NO=SICIL_NO'
      'SSK_NO=SSK_NO'
      'GIRIS_TARIH=GIRIS_TARIH'
      'CIKIC_TARIH=CIKIC_TARIH'
      'DOGUM_TARIH=DOGUM_TARIH'
      'DOGUM_YER=DOGUM_YER'
      'CINSIYET=CINSIYET'
      'TAHSIL=TAHSIL'
      'EVLI=EVLI'
      'GOREVI=GOREVI'
      'VERGI_NO=VERGI_NO'
      'VERGI_DAIRE=VERGI_DAIRE'
      'VERGI_KARNE_TARIH=VERGI_KARNE_TARIH'
      'TEL_NO=TEL_NO'
      'LISTEDEN_CIKAR=LISTEDEN_CIKAR'
      'BORC=BORC'
      'ALACAK=ALACAK')
    DataSet = qryRapor
    Left = 56
    Top = 25
  end
  object frxReport1: TfrxReport
    Version = '4.0.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Varsay'#305'lan'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39136.775302905100000000
    ReportOptions.LastChange = 39164.740237627320000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    StoreInDFM = False
    OnBeforePrint = frxReport1BeforePrint
    Left = 48
    Top = 105
    Datasets = <
      item
        DataSet = frxIBODts_IKes_Pers
        DataSetName = 'frxIBODts_IKes_Pers'
      end>
    Variables = <>
    Style = <
      item
        Name = 'Title'
        Color = clGray
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Group header'
        Color = 16053492
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Data'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
      end
      item
        Name = 'Group footer'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header line'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        Frame.Width = 2.000000000000000000
      end>
  end
  object qryRapor: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT PERSONEL_KOD '
      ', ADI_SOYADI '
      ', SICIL_NO '
      ', SSK_NO '
      ', GIRIS_TARIH '
      ', CIKIC_TARIH '
      ', DOGUM_TARIH '
      ', DOGUM_YER '
      ', CINSIYET '
      ', TAHSIL '
      ', EVLI '
      ', GOREVI '
      ', VERGI_NO '
      ', VERGI_DAIRE '
      ', VERGI_KARNE_TARIH '
      ', TEL_NO '
      ', LISTEDEN_CIKAR '
      ', BORC '
      ', ALACAK '
      'FROM PERSONEL '
      '')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 104
    Top = 80
  end
end
