object frmRaporAracPersonelListesi: TfrmRaporAracPersonelListesi
  Left = 276
  Top = 107
  Width = 278
  Height = 177
  Caption = 'frmRaporAracPersonelListesi'
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
  object qryRapor: TIB_Query
    DatabaseName = 'C:\CedaLite\Servis_Db\BOS.FDB'
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT ARAC_KOD'
      ', PLAKA '
      ', ARAC_TIP '
      ', OZ_MAL '
      ', CARI_KOD '
      
        ',(SELECT CARI_AD FROM CARI WHERE ARAC.CARI_KOD=CARI.CARI_KOD) AS' +
        ' CARI_ADI '
      ', ACIKLAMA '
      ', BORC '
      ', ALACAK '
      ', AKTIF_DEGIL '
      ', YAKIT_LITRE '
      ', TRF_SIG_GEC_TAR '
      ', KASKO_SIG_GEC_TAR '
      ', PERSONEL_KOD '
      
        ',(SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=AR' +
        'AC.PERSONEL_KOD) AS PERSONEL_ADI '
      
        ',(SELECT SICIL_NO FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=ARAC' +
        '.PERSONEL_KOD) AS PERSONEL_SICIL_NO '
      'FROM ARAC '
      ' WHERE ARAC.OZ_MAL=1')
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 104
    Top = 80
  end
  object frxIBODts_Arc_Pers: TfrxIBODataset
    UserName = 'frxIBODts_Arc_Pers'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ARAC_KOD=ARAC_KOD'
      'PLAKA=PLAKA'
      'ARAC_TIP=ARAC_TIP'
      'OZ_MAL=OZ_MAL'
      'CARI_KOD=CARI_KOD'
      'CARI_ADI=CARI_ADI'
      'ACIKLAMA=ACIKLAMA'
      'BORC=BORC'
      'ALACAK=ALACAK'
      'AKTIF_DEGIL=AKTIF_DEGIL'
      'YAKIT_LITRE=YAKIT_LITRE'
      'TRF_SIG_GEC_TAR=TRF_SIG_GEC_TAR'
      'KASKO_SIG_GEC_TAR=KASKO_SIG_GEC_TAR'
      'PERSONEL_KOD=PERSONEL_KOD'
      'PERSONEL_ADI=PERSONEL_ADI'
      'PERSONEL_SICIL_NO=PERSONEL_SICIL_NO')
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
    ReportOptions.LastChange = 39164.737515000000000000
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
        DataSet = frxIBODts_Arc_Pers
        DataSetName = 'frxIBODts_Arc_Pers'
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
end
