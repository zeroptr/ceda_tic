object frmRaporSefer_Mazot1: TfrmRaporSefer_Mazot1
  Left = 251
  Top = 155
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'Sefer Mazot Ba'#287'lant'#305'lar'#305
  ClientHeight = 436
  ClientWidth = 663
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
  object Label36: TLabel
    Left = 10
    Top = 79
    Width = 56
    Height = 13
    Caption = 'Ta'#351#305'y'#305'c'#305' Cari'
  end
  object Label19: TLabel
    Left = 250
    Top = 79
    Width = 311
    Height = 13
    AutoSize = False
    Caption = 'Ta'#351#305'y'#305'c'#305' Cari Ad'#305
  end
  object Label22: TLabel
    Left = 10
    Top = 47
    Width = 41
    Height = 13
    Caption = 'Personel'
  end
  object Label18: TLabel
    Left = 250
    Top = 47
    Width = 311
    Height = 13
    AutoSize = False
    Caption = 'Personel Ad'#305
  end
  object Label20: TLabel
    Left = 10
    Top = 15
    Width = 50
    Height = 13
    Caption = 'Ara'#231' Kodu'
  end
  object LblPlaka: TLabel
    Left = 250
    Top = 15
    Width = 311
    Height = 13
    AutoSize = False
    Caption = 'Ara'#231' Plaka'
  end
  object Label1: TLabel
    Left = 10
    Top = 111
    Width = 34
    Height = 13
    Caption = 'M'#252#351'teri'
  end
  object Label2: TLabel
    Left = 250
    Top = 111
    Width = 311
    Height = 13
    AutoSize = False
    Caption = 'M'#252#351'teri Ad'#305
  end
  object TxtMazotcu: TEdit
    Left = 97
    Top = 76
    Width = 127
    Height = 21
    TabOrder = 4
    OnEnter = txtAracEnter
    OnExit = TxtMazotcuExit
    OnKeyPress = txtAracKeyPress
  end
  object Button7: TButton
    Left = 226
    Top = 76
    Width = 17
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = Button7Click
  end
  object Btn_Bul: TButton
    Left = 8
    Top = 160
    Width = 75
    Height = 25
    Caption = '&Bul'
    TabOrder = 8
    OnClick = Btn_BulClick
  end
  object IB_Grid1: TIB_Grid
    Left = 8
    Top = 200
    Width = 649
    Height = 201
    CustomGlyphsSupplied = []
    DataSource = IB_DataSource1
    TabOrder = 10
  end
  object Button1: TButton
    Left = 584
    Top = 160
    Width = 75
    Height = 25
    Caption = '&Kapat'
    TabOrder = 9
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 408
    Width = 137
    Height = 25
    Caption = '&Sefer Kayd'#305'na Git'
    Enabled = False
    TabOrder = 11
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 496
    Top = 408
    Width = 161
    Height = 25
    Caption = '&Mazot Fi'#351'ine Git'
    Enabled = False
    TabOrder = 12
    OnClick = Button3Click
  end
  object txtAlanPers: TEdit
    Left = 97
    Top = 44
    Width = 127
    Height = 21
    TabOrder = 2
    OnEnter = txtAracEnter
    OnExit = txtAlanPersExit
    OnKeyPress = txtAracKeyPress
  end
  object Button8: TButton
    Left = 226
    Top = 44
    Width = 17
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button8Click
  end
  object txtArac: TEdit
    Left = 97
    Top = 12
    Width = 127
    Height = 21
    TabOrder = 0
    OnEnter = txtAracEnter
    OnExit = txtAracExit
    OnKeyPress = txtAracKeyPress
  end
  object Button6: TButton
    Left = 226
    Top = 12
    Width = 17
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button6Click
  end
  object Edit1: TEdit
    Left = 97
    Top = 108
    Width = 127
    Height = 21
    TabOrder = 6
    OnEnter = txtAracEnter
    OnExit = Edit1Exit
    OnKeyPress = txtAracKeyPress
  end
  object Button4: TButton
    Left = 226
    Top = 108
    Width = 17
    Height = 20
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = Button4Click
  end
  object qrySefer: TIB_Query
    ColumnAttributes.Strings = (
      'BEKLEME_FAT_VAR=BOOLEAN=1,0'
      'SEFER_ALIS_FAT_ALINDI=BOOLEAN=1,0'
      'SEFER_SATIS_FAT_KESILDI=BOOLEAN=1,0'
      'SECIM=BOOLEAN=1,0'
      'BEKLEME_FATURASI_KESILDI=BOOLEAN=1,0'
      'SEFER_TAMAMLANDI=BOOLEAN=1,0')
    DatabaseName = 'C:\CedaLite\Trans_Db\Transport.FDB'
    FieldsDisplayLabel.Strings = (
      'FIS_NO=Fi'#351' No'
      'KASA_KOD=Kasa Kodu'
      'TARIH=Tarih'
      'DOV_BAZ_TAR=D'#246'viz Baz Tar'
      'ACIKLAMA=Hareket A'#231#305'klamas'#305
      'KASA_AD=Kasa Ad'#305
      'CH_ACIKLAMA=C/H A'#231#305'klama'
      'YEV_ACIKLAMA=Yevmiye Defteri A'#231#305'klama'
      'KASAHAR_ID=FIS NO'
      'ARAC_KOD=Mazot Ara'#231' Kodu'
      'SEFER_SAY=Sefer Say'#305's'#305
      'ARAC_PLAKA=Ara'#231' Plaka'
      'ALICI_KOD=Al'#305'c'#305' Kodu'
      'ALICI_ADI=Al'#305'c'#305' Ad'#305
      'SATICI_KOD=Sat'#305'c'#305' Kodu'
      'SATICI_ADI=Sat'#305'c'#305' Ad'#305
      'PERSONEL_KOD=Personel Kodu'
      'PERSONEL_ADI=Personel Ad'#305
      'OLCU_TIP='#214'l'#231#252' Tip'
      'OLCU_BIRIM='#214'l'#231#252' Birim'
      'TASINAN_ESYA=Ta'#351#305'nan E'#351'ya'
      'BAS_TAR=Ba'#351'lama Tarihi'
      'BIT_TAR=Biti'#351' Tarihi'
      'CIK_YER='#199#305'k'#305#351' Yeri'
      'BIT_YER=Var'#305#351' Yeri'
      'ALICI_BORC_BIRIM_FIY=Birim Fiyat'#305
      'ALICI_B_DOVKOD=D'#246'viz Kodu'
      'ALICI_BORC=Bor'#231
      'ALICI_BORC_VPB=Bor'#231' Vpb'
      'SATICI_ALACAK_BIRIM_FIY=Birim Fiyat'#305
      'SATICI_A_DOVKOD=D'#246'viz Kodu'
      'SATICI_ALACAK=Alacak'
      'SATICI_ALACAK_VPB=Alacak Vpb'
      'BEKLEME_FAT_VAR=Bekleme Faturas'#305
      'BEKLEME_FAT_TUTAR=Tutar'
      'BEKLEME_FAT_DOV_KOD=D'#246'viz Kodu'
      'BEKLEME_FAT_VPB=Tutar Vpb'
      'SEFER_NOTLARI=Sefer Notlar'#305
      'SEFER_ALIS_FAT_ALINDI=Al'#305#351' Faturas'#305' Al'#305'nd'#305
      'SEFER_SATIS_FAT_KESILDI=Sat'#305#351' Faturas'#305' Kesildi'
      'SEFER_ID=Sefer No'
      'MASRAF_MERK=Masraf Merkezi'
      'KOD1=Kod1'
      'KOD2=Kod2'
      'KOD3=Kod3'
      'KOD4=Kod4'
      'ALICI_B_DOV_BAZ_TAR=Al'#305'c'#305' D'#246'v.Baz.Tar'
      'SATICI_A_DOV_BAZ_TAR=Sat'#305'c'#305' D'#246'v.Baz.Tar'
      'BEKLEME_FAT_DOV_BAZ_TAR=Fatura D'#246'v.Baz.Tar'
      'SEFER_TAMAMLANDI=Sefer Tamamland'#305
      'DORSE_KOD=Dorse Kodu'
      'ALIS_URUN_HAR_ID=Al'#305#351' Faturas'#305' Hareket No'
      'SATIS_URUN_HAR_ID=Sat'#305#351' Faturas'#305' Hareket No'
      'SECIM=Se'#231'im'
      'BEKLEME_FATURASI_KESILDI=Bekleme Faturas'#305' Kesildi'
      'BEK_FAT_URUN_HAR_ID=Bekleme Faturas'#305' Al'#305#351' Hareket No'
      'FAT_IRS_ID=Fatura Fi'#351' no'
      'FAT_IRS_SERI=Fatura Seri No'
      'BELGE_NO=Fatura Belge No'
      'GENEL_TOP=Fatura Toplam Tutar'#305' Vpb'
      'DARAC_PLAKA=Dorse Plaka'
      'TUTAR_VPB=Mazot Tutar Vpb'
      'MARAC_PLAKA=Mazot Plaka'
      'VEREN_PERSONEL_KOD=Mazot Veren Personel'
      'MVEREN_PERSONEL_ADI=Mazot Veren Personel'
      'ALAN_PERSONEL_KOD=Mazot Alan Personel'
      'MALAN_PERSONEL_ADI=Mazot Alan Personel'
      'ALAN_CARI_KOD=Mazot Alan Cari'
      'MALAN_CARI_ADI=Mazot Alan Cari'
      'MAZOTCU_CARI_KOD=Mazotcu Cari'
      'MAZOTCU_CARI_ADI=Mazotcu Cari'
      'MAZOT_FIS_ID=Mazot No')
    FieldsDisplayWidth.Strings = (
      'ARAC_KOD=89'
      'TUTAR_VPB=101')
    FieldsIndex.Strings = (
      'SEFER.SEFER_ID'
      'SEFER.SEFER_SID'
      'SEFER.ALICI_KOD'
      'ALICI_ADI'
      'SEFER.SATICI_KOD'
      'SATICI_ADI'
      'SEFER.ARAC_KOD'
      'ARAC_PLAKA'
      'SEFER.DORSE_KOD'
      'SEFER.PERSONEL_KOD'
      'PERSONEL_ADI'
      'SEFER.ALICI_BORC_VPB'
      'SEFER.SATICI_ALACAK_VPB'
      'SEFER.BEKLEME_FAT_VPB'
      'DARAC_PLAKA'
      'MAZOT_FISI.MAZOT_FIS_ID'
      'MAZOT_FISI.MAZOT_FIS_SID'
      'MAZOT_FISI.FIS_NO'
      'MAZOT_FISI.TARIH'
      'MAZOT_FISI.TUTAR_VPB'
      'MAZOT_FISI.MAZOTCU_CARI_KOD'
      'MALAN_CARI_ADI'
      'MAZOT_FISI.ARAC_KOD'
      'MARAC_PLAKA'
      'MAZOT_FISI.VEREN_PERSONEL_KOD'
      'MVEREN_PERSONEL_ADI'
      'MAZOT_FISI.ALAN_PERSONEL_KOD'
      'MALAN_PERSONEL_ADI'
      'MAZOT_FISI.ALAN_CARI_KOD'
      'MAZOTCU_CARI_ADI')
    FieldsVisible.Strings = (
      'KASAHAR_ID=FALSE'
      'KASAHAR_SID=FALSE'
      'BELGE_TUR=FALSE'
      'BELGE_ID=FALSE'
      'BELGE_SID=FALSE'
      'SEFER_SID=FALSE'
      'ALICI_B_DOVKUR=FALSE'
      'SATICI_A_DOVKUR=FALSE'
      'BEKLEME_FAT_DOVKUR=FALSE'
      'FAT_IRS_TIP=FALSE'
      'FAT_IRS_SID=FALSE'
      'FAT_IRS_SEP=FALSE'
      'MAZOT_FIS_SID=FALSE'
      'DORSE_KOD=FALSE'
      'DARAC_PLAKA=FALSE'
      'ARAC_KOD=FALSE'
      'MARAC_PLAKA=FALSE')
    IB_Connection = DataMod.dbaMain
    SQL.Strings = (
      'SELECT '
      'S.SEFER_ID '
      ', S.SEFER_SID '
      ', S.ARAC_KOD '
      
        ', (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=SEFER.ARAC_KOD) AS' +
        ' ARAC_PLAKA '
      ', S.DORSE_KOD '
      
        ', (SELECT PLAKA FROM ARAC AR WHERE AR.ARAC_KOD=SEFER.DORSE_KOD) ' +
        'AS DARAC_PLAKA '
      ', S.ALICI_KOD '
      
        ', (SELECT CARI_AD FROM CARI WHERE CARI.CARI_KOD=SEFER.ALICI_KOD)' +
        ' AS ALICI_ADI '
      ', S.SATICI_KOD '
      
        ', (SELECT CARI_AD FROM CARI WHERE SEFER.SATICI_KOD=CARI.CARI_KOD' +
        ') AS SATICI_ADI '
      ', S.PERSONEL_KOD '
      
        ', (SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=S' +
        'EFER.PERSONEL_KOD) AS PERSONEL_ADI '
      ', S.ALICI_BORC_VPB '
      ', S.SATICI_ALACAK_VPB '
      ', S.BEKLEME_FAT_VPB '
      ',M.MAZOT_FIS_ID '
      ', M.MAZOT_FIS_SID '
      ', M.FIS_NO '
      ', M.TARIH '
      ', M.TUTAR_VPB '
      ', M.ARAC_KOD '
      
        ', (SELECT PLAKA FROM ARAC WHERE ARAC.ARAC_KOD=MAZOT_FISI.ARAC_KO' +
        'D) AS MARAC_PLAKA '
      ', M.VEREN_PERSONEL_KOD '
      
        ', (SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=M' +
        'AZOT_FISI.VEREN_PERSONEL_KOD) AS MVEREN_PERSONEL_ADI '
      ', M.ALAN_PERSONEL_KOD '
      
        ', (SELECT ADI_SOYADI FROM PERSONEL WHERE PERSONEL.PERSONEL_KOD=M' +
        'AZOT_FISI.ALAN_PERSONEL_KOD) AS MALAN_PERSONEL_ADI '
      ', M.ALAN_CARI_KOD '
      
        ', (SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.ALAN_CARI_KOD=CARI.' +
        'CARI_KOD) AS MALAN_CARI_ADI '
      ', M.MAZOTCU_CARI_KOD '
      
        ',(SELECT CARI_AD FROM CARI WHERE MAZOT_FISI.MAZOTCU_CARI_KOD=CAR' +
        'I.CARI_KOD) AS MAZOTCU_CARI_ADI '
      'FROM SEFER S '
      
        'INNER JOIN MAZOT_FISI M ON (MAZOT_FISI.ALIS_URUN_HAR_ID=SEFER.SE' +
        'FER_ID) '
      'WHERE MAZOT_FIS_ID<>0 ')
    AutoFetchAll = True
    ColorScheme = False
    DefaultValues.Strings = (
      'BELGE_SID=1'
      'BELGE_ID=0'
      'TIP=G'
      'KASADEGER=0'
      'ISLEM_TIP=1'
      'MC=C'
      'DOVKUR=0'
      'TUTAR=0'
      'TUTAR_VPB=0'
      'MIKTAR=0')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    CachedUpdates = True
    FetchWholeRows = True
    Left = 136
    Top = 144
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = qrySefer
    Left = 232
    Top = 144
  end
end
