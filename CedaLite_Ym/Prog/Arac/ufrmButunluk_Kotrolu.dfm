object frmButunluk_Kotrolu: TfrmButunluk_Kotrolu
  Left = 176
  Top = 159
  Caption = 'B'#252't'#252'nl'#252'k Kontrol'#252
  ClientHeight = 453
  ClientWidth = 688
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
  object IB_Grid1: TIB_Grid
    Left = 16
    Top = 104
    Width = 657
    Height = 329
    CustomGlyphsSupplied = []
    DataSource = IB_DataSource1
    TabOrder = 0
    object Memo8: TMemo
      Left = 296
      Top = 5
      Width = 185
      Height = 89
      Lines.Strings = (
        'select'
        
          '(Select FAT_IRS_ID from fat_irs where FAT_IRS_SEP=1 and urunhar.' +
          'fatura_id=fat_irs_id) fat_irs_id,'
        
          'urunhar_id ,TIP,cast ('#39'URUNHAR Urunhar_id sefer satis_urun_har_i' +
          'd alan'#305'nda yok'#39' as varchar(250)) ACIKLAMA from urunhar'
        'where'
        'SEFER_ID>0'
        'and'
        'SEFER_ID=1999999'
        'and'
        'SEFER_BEKLEME=0'
        'and'
        
          'urunhar.Urunhar_id not IN (select satis_urun_har_id from sefer w' +
          'here satis_urun_har_id=urunhar.Urunhar_id and SEFER_SATIS_FAT_KE' +
          'SILDI=1)'
        ''
        'union all'
        'select'
        
          '(Select FAT_IRS_ID from fat_irs where FAT_IRS_SEP=1 and urunhar.' +
          'fatura_id=fat_irs_id) fat_irs_id,'
        
          'urunhar_id ,TIP,cast ('#39'URUNHAR Urunhar_id sefer BEK_FAT_URUN_HAR' +
          '_ID alan'#305'nda yok'#39' as varchar(250)) ACIKLAMA from urunhar'
        'where'
        'SEFER_ID>0'
        'and'
        'SEFER_ID=1999999'
        'and'
        'SEFER_BEKLEME=1'
        'and'
        
          'urunhar.Urunhar_id not IN (select BEK_FAT_URUN_HAR_ID from sefer' +
          ' where BEK_FAT_URUN_HAR_ID=urunhar.Urunhar_id and BEKLEME_FATURA' +
          'SI_KESILDI=1)'
        ''
        ''
        ''
        ''
        'union all'
        'select'
        
          '(Select FAT_IRS_ID from fat_irs where FAT_IRS_SEP=1 and urunhar.' +
          'fatura_id=fat_irs_id) fat_irs_id,'
        
          'urunhar_id ,TIP,cast ('#39'URUNHAR Urunhar_id sefer SBEK_FAT_URUN_HA' +
          'R_ID alan'#305'nda yok'#39' as varchar(250)) ACIKLAMA from urunhar'
        'where'
        'SEFER_ID>0'
        'and'
        'SEFER_ID=1999999'
        'and'
        'SSEFER_BEKLEME=1'
        'and'
        
          'urunhar.Urunhar_id not IN (select SBEK_FAT_URUN_HAR_ID from sefe' +
          'r where SBEK_FAT_URUN_HAR_ID=urunhar.Urunhar_id and SBEKLEME_FAT' +
          'URASI_KESILDI=1)'
        ''
        ''
        '')
      TabOrder = 0
      Visible = False
      WordWrap = False
    end
  end
  object cbSql: TComboBox
    Left = 16
    Top = 24
    Width = 657
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'Sefer Mazot -- Ara'#231' Cari Kontrollar'#305
    Items.Strings = (
      'Sefer Mazot -- Ara'#231' Cari Kontrollar'#305
      #220'r'#252'nhar -- Sefer Mazot Kontrolleri (kesilmemi'#351'lerden)'
      'Sefer Mazot -- '#220'r'#252'nhar Kontroleri'
      #220'r'#252'nhar -- Sefer Mazot Kontrolleri'
      'Sefer Cari Hareket Kontrolleri'
      'Sefer Mazot Personel Hareketleri'
      'Birlestirmeli Kontroller')
  end
  object Memo1: TMemo
    Left = 503
    Top = 112
    Width = 185
    Height = 89
    Lines.Strings = (
      
        'select SEFER_ID ID ,cast ('#39'SEFER ara'#231' hareketi ara'#231'har da yok'#39' a' +
        's varchar(255)) ACIKLAMA from SEFER'
      'where'
      'SEFER_TAMAMLANDI=1'
      'and'
      'SEFER_ID not IN (select belge_id from ARACHAR'
      
        'where ARACHAR.ARAC_KOD=sefer.ARAC_KOD and ARACHAR.belge_tur=41 a' +
        'nd SEFER.sefer_id=ARACHAR.belge_id)'
      ''
      'union all'
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER al'#305'c'#305' kod carihar da yok'#39' as va' +
        'rchar(255)) ACIKLAMA  from SEFER'
      'where'
      'SEFER_TAMAMLANDI=1'
      'and'
      'SEFER_SATIS_FAT_KESILDI=0'
      'and'
      'SEFER_ID NOT IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=sefer.ALICI_KOD and CARIHAR.belge_tur=41 ' +
        'and SEFER.sefer_id=CARIHAR.belge_id and Sira_No=2)'
      ''
      'union all'
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER al'#305'c'#305' kod beklemesi carihar da ' +
        'yok'#39' as varchar(255))  ACIKLAMA from SEFER'
      'where'
      'SEFER_TAMAMLANDI=1'
      'and'
      'BEKLEME_FATURASI_KESILDI=0 and BEKLEME_FAT_VAR=1'
      'and'
      'SEFER_ID NOT IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=sefer.ALICI_KOD and CARIHAR.belge_tur=41 ' +
        'and SEFER.sefer_id=CARIHAR.belge_id and Sira_No=3)'
      ''
      ''
      ''
      'union all'
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER sat'#305'c'#305' kod beklemesi carihar da' +
        ' yok'#39' as varchar(255))  ACIKLAMA from SEFER'
      'where'
      'SEFER_TAMAMLANDI=1'
      'and'
      'SBEKLEME_FATURASI_KESILDI=0 and SBEKLEME_FAT_VAR=1'
      'and'
      'SEFER_ID NOT IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=sefer.SATICI_KOD and CARIHAR.belge_tur=41' +
        ' and SEFER.sefer_id=CARIHAR.belge_id and Sira_No=4)'
      ''
      ''
      ''
      'union all'
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER sat'#305'c'#305' kod carihar da yok'#39' as v' +
        'archar(255))  ACIKLAMA from SEFER'
      'where'
      'SEFER_TAMAMLANDI=1'
      'and'
      'SEFER_ALIS_FAT_ALINDI=0'
      'AND'
      'SEFER.ARAC_KOD=(select ARAC_KOD from ARAC'
      'where ARAC.ARAC_KOD=sefer.ARAC_KOD and ARAC.OZ_MAL=0)'
      'and'
      'SEFER_ID NOT IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=sefer.SATICI_KOD and CARIHAR.belge_tur=41' +
        ' and SEFER.sefer_id=CARIHAR.belge_id)'
      ''
      'union all'
      ''
      
        'select MAZOT_FIS_ID ID ,cast ('#39'MAZOT_FISI alan cari kod carihar ' +
        'da yok'#39' as varchar(255))  ACIKLAMA from MAZOT_FISI'
      'where'
      'MAZOT_FIS_ID NOT IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=MAZOT_FISI.ALAN_CARI_KOD and CARIHAR.belg' +
        'e_tur=50 and MAZOT_FISI.MAZOT_FIS_ID=CARIHAR.belge_id)'
      ''
      'AND'
      'MAZOT_FISI.ARAC_KOD=(select ARAC_KOD from ARAC'
      'where ARAC.ARAC_KOD=MAZOT_FISI.ARAC_KOD and ARAC.OZ_MAL=0)'
      ''
      'union all'
      ''
      
        'select MAZOT_FIS_ID ID ,cast ('#39'MAZOT FISI mazot'#231'u cari kod  cari' +
        'har da yok'#39' as varchar(255)) ACIKLAMA  from MAZOT_FISI'
      'where'
      'ALIS_FATURASI_ALINDI=0'
      'AND'
      'MAZOT_FIS_ID NOT IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=MAZOT_FISI.MAZOTCU_CARI_KOD and CARIHAR.b' +
        'elge_tur=42 and MAZOT_FISI.MAZOT_FIS_ID=CARIHAR.belge_id)')
    TabOrder = 2
    Visible = False
    WordWrap = False
  end
  object Memo2: TMemo
    Left = 80
    Top = 121
    Width = 185
    Height = 89
    Lines.Strings = (
      'select '
      
        '(Select fat_irs.FAT_IRS_ID from fat_irs where fat_irs.FAT_IRS_SE' +
        'P=1 and TIP=1 and urunhar.fatura_id=fat_irs.fat_irs_id) fat_irs_' +
        'id,'
      
        'urunhar.urunhar_id ,urunhar.TIP,cast ('#39'URUNHAR SEFER_ID sefer fa' +
        'turas'#305' kesildi olarak  sefer_id alan'#305'nda yok'#39' as varchar(250)) A' +
        'CIKLAMA from urunhar'
      'where'
      'urunhar.TIP='#39'A'#39
      'and'
      'urunhar.SEFER_ID>0'
      'and'
      
        'urunhar.SEFER_ID IN (select sefer.sefer_id from sefer where sefe' +
        'r.sefer_id=urunhar.sefer_id AND sefer.SEFER_SATIS_FAT_KESILDI<>1' +
        ')'
      ''
      ''
      'union all'
      ''
      ''
      'select '
      
        '(Select fat_irs.FAT_IRS_ID from fat_irs where fat_irs.FAT_IRS_SE' +
        'P=1 and TIP=2 and urunhar.fatura_id=fat_irs.fat_irs_id) fat_irs_' +
        'id,'
      
        'urunhar.urunhar_id ,urunhar.TIP,cast ('#39'URUNHAR SEFER_ID sefer fa' +
        'turas'#305' kesildi olarak  sefer_id alan'#305'nda yok'#39' as varchar(250)) A' +
        'CIKLAMA from urunhar'
      'where'
      'urunhar.TIP='#39'B'#39
      'and'
      'urunhar.SEFER_ID>0'
      'and'
      
        'urunhar.SEFER_ID IN (select sefer.sefer_id from sefer where sefe' +
        'r.sefer_id=urunhar.sefer_id AND sefer.SEFER_ALIS_FAT_ALINDI<>1)'
      ''
      'union all'
      ''
      'select '
      
        '(Select fat_irs.FAT_IRS_ID from fat_irs where fat_irs.FAT_IRS_SE' +
        'P=1 and urunhar.fatura_id=fat_irs.fat_irs_id) fat_irs_id,'
      
        'urunhar.urunhar_id ,urunhar.TIP,cast ('#39'URUNHAR SEFER_BEKLEME sef' +
        'er faturas'#305' kesildi olarak sefer_id alan'#305'nda yok'#39' as varchar(250' +
        ')) ACIKLAMA  from urunhar'
      'where'
      'urunhar.TIP='#39'A'#39
      'and'
      'urunhar.SEFER_BEKLEME=1'
      'and'
      
        'urunhar.SEFER_ID IN (select sefer.sefer_id from sefer where sefe' +
        'r.sefer_id=urunhar.SEFER_ID AND sefer.BEKLEME_FATURASI_KESILDI<>' +
        '1)'
      ''
      'union all'
      ''
      ''
      'select '
      
        '(Select fat_irs.FAT_IRS_ID from fat_irs where fat_irs.FAT_IRS_SE' +
        'P=1 and TIP=2  and urunhar.fatura_id=fat_irs.fat_irs_id) fat_irs' +
        '_id,'
      
        'urunhar.urunhar_id ,urunhar.TIP,cast ('#39'URUNHAR SSEFER_BEKLEME se' +
        'fer faturas'#305' kesildi olarak sefer_id alan'#305'nda yok'#39' as varchar(25' +
        '0)) ACIKLAMA  from urunhar'
      'where'
      'urunhar.TIP='#39'B'#39
      'and'
      'urunhar.SSEFER_BEKLEME=1'
      'and'
      
        'urunhar.SEFER_ID IN (select sefer.sefer_id from sefer where sefe' +
        'r.sefer_id=urunhar.SEFER_ID AND sefer.SBEKLEME_FATURASI_KESILDI<' +
        '>1)'
      ''
      'union all'
      ''
      ''
      ''
      'select '
      
        '(Select fat_irs.FAT_IRS_ID from fat_irs where fat_irs.FAT_IRS_SE' +
        'P=1 and urunhar.fatura_id=fat_irs.fat_irs_id) fat_irs_id,'
      
        'urunhar.urunhar_id ,urunhar.TIP,cast ('#39'URUNHAR MAZOT_FISI_ID MAZ' +
        'OT_FISI faturas'#305' al'#305'nd'#305' olarak MAZOT_FIS_ID alan'#305'nda yok'#39' as var' +
        'char(250))  ACIKLAMA  from urunhar'
      'where'
      'urunhar.MAZOT_FISI_ID>0'
      'and'
      
        'urunhar.MAZOT_FISI_ID IN (select MAZOT_FISI.MAZOT_FIS_ID from MA' +
        'ZOT_FISI where MAZOT_FISI.MAZOT_FIS_ID=urunhar.MAZOT_FISI_ID AND' +
        ' MAZOT_FISI.ALIS_FATURASI_ALINDI<>1)')
    TabOrder = 3
    Visible = False
    WordWrap = False
  end
  object Memo3: TMemo
    Left = 80
    Top = 311
    Width = 185
    Height = 89
    Lines.Strings = (
      
        'select SEFER_ID ID ,cast ('#39'SEFER SATIS_URUN_HAR_ID urunhar da ur' +
        'unhar_id alan'#305'nda yok'#39' as varchar(250))   ACIKLAMA from SEFER'
      'where'
      '(SEFER_SATIS_FAT_KESILDI=1 or SATIS_URUN_HAR_ID<>0)'
      'and'
      
        'SATIS_URUN_HAR_ID not IN (select urunhar_id from urunhar where u' +
        'runhar_id=sefer.SATIS_URUN_HAR_ID)'
      ''
      'union all'
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER BEK_FAT_URUN_HAR_ID urunhar da ' +
        'urunhar_id alan'#305'nda yok'#39' as varchar(250))  ACIKLAMA  from SEFER'
      'where'
      '(BEKLEME_FATURASI_KESILDI=1 or BEK_FAT_URUN_HAR_ID<>0) '
      'and'
      
        'BEK_FAT_URUN_HAR_ID not IN (select urunhar_id from urunhar where' +
        ' urunhar_id=sefer.BEK_FAT_URUN_HAR_ID)'
      ''
      'union all'
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER SBEK_FAT_URUN_HAR_ID urunhar da' +
        ' urunhar_id alan'#305'nda yok'#39' as varchar(250))  ACIKLAMA  from SEFER'
      'where'
      '(SBEKLEME_FATURASI_KESILDI=1 or SBEK_FAT_URUN_HAR_ID<>0) '
      'and'
      
        'SBEK_FAT_URUN_HAR_ID not IN (select urunhar_id from urunhar wher' +
        'e urunhar_id=sefer.SBEK_FAT_URUN_HAR_ID)'
      ''
      'union all'
      ''
      ''
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER ALIS_URUN_HAR_ID urunhar da uru' +
        'nhar_id alan'#305'nda yok'#39' as varchar(250))   ACIKLAMA from SEFER'
      'where'
      '(SEFER_ALIS_FAT_ALINDI=1 or ALIS_URUN_HAR_ID<>0) '
      'and'
      
        'ALIS_URUN_HAR_ID not IN (select urunhar_id from urunhar where ur' +
        'unhar_id=sefer.ALIS_URUN_HAR_ID)'
      ''
      'union all'
      ''
      
        'select MAZOT_FIS_ID ID ,cast ('#39'MAZOT_FISI ALIS_URUN_HAR_ID urunh' +
        'ar da urunhar_id alan'#305'nda yok'#39' as varchar(250))  ACIKLAMA from M' +
        'AZOT_FISI'
      'where'
      '(ALIS_FATURASI_ALINDI=1 or ALIS_URUN_HAR_ID<>0) '
      'and'
      
        'ALIS_URUN_HAR_ID not IN (select urunhar_id from urunhar where ur' +
        'unhar_id=mazot_fisi.ALIS_URUN_HAR_ID)')
    TabOrder = 4
    Visible = False
    WordWrap = False
  end
  object Memo4: TMemo
    Left = 80
    Top = 216
    Width = 185
    Height = 89
    Lines.Strings = (
      'select'
      
        '(Select FAT_IRS_ID from fat_irs where FAT_IRS_SEP=1 and urunhar.' +
        'fatura_id=fat_irs_id) fat_irs_id,'
      
        'urunhar_id ,TIP,cast ('#39'URUNHAR SEFER_ID sefer sefer_id alan'#305'nda ' +
        'yok'#39' as varchar(250)) ACIKLAMA from urunhar'
      'where'
      'SEFER_ID>0'
      'and'
      'SEFER_ID<>1999999'
      'and'
      
        'SEFER_ID not IN (select sefer_id from sefer where sefer_id=urunh' +
        'ar.sefer_id)'
      ''
      'union all'
      ''
      'select'
      
        '(Select FAT_IRS_ID from fat_irs where FAT_IRS_SEP=1 and urunhar.' +
        'fatura_id=fat_irs_id) fat_irs_id,'
      
        'urunhar_id ,TIP,cast ('#39'URUNHAR SEFER_BEKLEME sefer sefer_id alan' +
        #305'nda yok'#39' as varchar(250)) ACIKLAMA  from urunhar'
      'where'
      'SEFER_BEKLEME=1'
      'and'
      'SEFER_ID<>1999999'
      'and'
      
        'SEFER_ID not IN (select sefer_id from sefer where sefer_id=urunh' +
        'ar.SEFER_ID)'
      ''
      'union all'
      ''
      ''
      'select'
      
        '(Select FAT_IRS_ID from fat_irs where FAT_IRS_SEP=1 and urunhar.' +
        'fatura_id=fat_irs_id) fat_irs_id,'
      
        'urunhar_id ,TIP,cast ('#39'URUNHAR SSEFER_BEKLEME sefer sefer_id ala' +
        'n'#305'nda yok'#39' as varchar(250)) ACIKLAMA  from urunhar'
      'where'
      'SSEFER_BEKLEME=1'
      'and'
      'SEFER_ID<>1999999'
      'and'
      
        'SEFER_ID not IN (select sefer_id from sefer where sefer_id=urunh' +
        'ar.SEFER_ID)'
      ''
      'union all'
      ''
      'select'
      
        '(Select FAT_IRS_ID from fat_irs where FAT_IRS_SEP=1 and urunhar.' +
        'fatura_id=fat_irs_id) fat_irs_id,'
      
        'urunhar_id ,TIP,cast ('#39'URUNHAR MAZOT_FISI_ID MAZOT_FISI MAZOT_FI' +
        'S_ID alan'#305'nda yok'#39' as varchar(250))  ACIKLAMA from urunhar'
      'where'
      'MAZOT_FISI_ID>0'
      'and'
      'MAZOT_FISI_ID<>1999999'
      'and'
      
        'MAZOT_FISI_ID not IN (select MAZOT_FIS_ID from MAZOT_FISI where ' +
        'MAZOT_FIS_ID=urunhar.MAZOT_FISI_ID)')
    TabOrder = 5
    Visible = False
    WordWrap = False
  end
  object Button1: TButton
    Left = 288
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Ara'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Memo5: TMemo
    Left = 16
    Top = 53
    Width = 185
    Height = 41
    ReadOnly = True
    TabOrder = 7
    WordWrap = False
  end
  object Memo6: TMemo
    Left = 312
    Top = 311
    Width = 185
    Height = 89
    Lines.Strings = (
      
        'select SEFER_ID ID ,cast ('#39'SEFER Al'#305'c'#305' kod  cari harda sefer ola' +
        'rak var'#39' as varchar(255)) ACIKLAMA from SEFER'
      'where'
      'SEFER_SATIS_FAT_KESILDI=1'
      'and'
      'SEFER_ID IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=sefer.ALICI_KOD and CARIHAR.belge_tur=41 ' +
        'and CARIHAR.Tip='#39'B'#39
      ' and SEFER.sefer_id=CARIHAR.belge_id and sira_no=2)'
      ''
      'union all'
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER Sat'#305'c'#305' kod cari har da sefer ol' +
        'arak var'#39' as varchar(255)) ACIKLAMA from SEFER'
      'where'
      'SEFER_ALIS_FAT_ALINDI=1'
      'and'
      'SEFER_ID IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=sefer.SATICI_KOD and CARIHAR.belge_tur=41' +
        ' and CARIHAR.Tip='#39'A'#39
      ' and SEFER.sefer_id=CARIHAR.belge_id)'
      ''
      'union all'
      ''
      
        'select SEFER_ID ID ,cast ('#39'SEFER Al'#305'c'#305' kod beklemesi cari harda ' +
        'sefer olarak var'#39' as varchar(255)) ACIKLAMA from SEFER'
      'where'
      'BEKLEME_FATURASI_KESILDI=1'
      'and'
      'SEFER_ID IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=sefer.ALICI_KOD and CARIHAR.belge_tur=41 ' +
        'and CARIHAR.Tip='#39'B'#39
      ' and SEFER.sefer_id=CARIHAR.belge_id and sira_no=3)'
      ''
      'union all'
      ''
      
        'select BELGE_ID ID ,cast ('#39'CARIHAR Belge Id sefer de Faturas'#305' ke' +
        'silmi'#351' olarak var'#39' as varchar(255)) ACIKLAMA from CARIHAR'
      'where'
      'CARIHAR.belge_tur=41 and CARIHAR.Tip='#39'B'#39'  and sira_no=2'
      'and'
      'BELGE_ID IN (select SEFER_ID from SEFER'
      
        'where SEFER.SEFER_SATIS_FAT_KESILDI=1 and CARIHAR.CARI_KOD=sefer' +
        '.ALICI_KOD )'
      ''
      'union all'
      ''
      
        'select BELGE_ID ID ,cast ('#39'CARIHAR Belge Id sefer de Al'#305#351' Fatura' +
        's'#305' Al'#305'nm'#305#351' olarak var'#39' as varchar(255)) ACIKLAMA from CARIHAR'
      'where'
      'CARIHAR.belge_tur=41 and CARIHAR.Tip='#39'A'#39
      'and'
      'BELGE_ID IN (select SEFER_ID from SEFER'
      
        'where SEFER.SEFER_ALIS_FAT_ALINDI=1 and CARIHAR.CARI_KOD=sefer.S' +
        'ATICI_KOD )'
      ''
      'union all'
      ''
      
        'select BELGE_ID ID ,cast ('#39'CARIHAR Belge Id sefer de bekleme Fat' +
        'uras'#305' kesilmi'#351' olarak var'#39' as varchar(255)) ACIKLAMA from CARIHA' +
        'R'
      'where'
      'CARIHAR.belge_tur=41 and CARIHAR.Tip='#39'B'#39' and sira_no=3'
      'and'
      'BELGE_ID IN (select SEFER_ID from SEFER'
      
        'where SEFER.BEKLEME_FATURASI_KESILDI=1 and CARIHAR.CARI_KOD=sefe' +
        'r.ALICI_KOD )'
      ''
      ''
      'union all'
      ''
      
        'select BELGE_ID ID ,cast ('#39'CARIHAR Belge Id sefer de bekleme Fat' +
        'uras'#305' kesilmi'#351' olarak var'#39' as varchar(255)) ACIKLAMA from CARIHA' +
        'R'
      'where'
      'CARIHAR.belge_tur=41 and CARIHAR.Tip='#39'A'#39' and sira_no=3'
      'and'
      'BELGE_ID IN (select SEFER_ID from SEFER'
      
        'where SEFER.SBEKLEME_FATURASI_KESILDI=1 and CARIHAR.CARI_KOD=sef' +
        'er.ALICI_KOD )'
      ''
      ''
      'union all'
      ''
      
        'select MAZOT_FIS_ID ID ,cast ('#39'MAZOT FISI MOZOTCU KOD kod cari h' +
        'ar da MAZOT olarak var'#39' as varchar(255)) ACIKLAMA from MAZOT_FIS' +
        'I'
      'where'
      'ALIS_FATURASI_ALINDI=1'
      'and'
      'MAZOT_FIS_ID IN (select belge_id from CARIHAR'
      
        'where CARIHAR.CARI_KOD=MAZOT_FISI.MAZOTCU_CARI_KOD and CARIHAR.b' +
        'elge_tur=42'
      ' and MAZOT_FISI.MAZOT_FIS_ID=CARIHAR.belge_id)'
      ''
      'union all'
      ''
      
        'select BELGE_ID ID ,cast ('#39'CARIHAR Belge Id Mazot fi'#351'inde al'#305#351' f' +
        'aturas'#305' al'#305'nd'#305' olarak var'#39' as varchar(255)) ACIKLAMA from CARIHA' +
        'R'
      'where'
      'CARIHAR.belge_tur=42'
      'and'
      'BELGE_ID IN (select MAZOT_FIS_ID from MAZOT_FISI'
      
        'where MAZOT_FISI.ALIS_FATURASI_ALINDI=1 and CARIHAR.CARI_KOD=MAZ' +
        'OT_FISI.MAZOTCU_CARI_KOD )')
    TabOrder = 8
    Visible = False
    WordWrap = False
  end
  object Memo7: TMemo
    Left = 312
    Top = 216
    Width = 185
    Height = 89
    Lines.Strings = (
      
        'select SEFER_ID ID ,cast ('#39'SEFER personel hareketi personehar da' +
        ' yok'#39' as varchar(255)) ACIKLAMA from SEFER'
      'where'
      'SEFER_TAMAMLANDI=1'
      'and'
      'SEFER.PERSONEL_KOD<>'#39#39
      'and'
      'SEFER_ID not IN (select belge_id from PERSONEL_HAR'
      
        'where PERSONEL_HAR.PERSONEL_KOD=sefer.PERSONEL_KOD and PERSONEL_' +
        'HAR.belge_tur=41 and SEFER.sefer_id=PERSONEL_HAR.belge_id and BA' +
        '='#39'A'#39')'
      ''
      'union all'
      ''
      
        'select MAZOT_FIS_ID ID ,cast ('#39'MAZOT_FISI personel hareketi pers' +
        'onehar da yok'#39' as varchar(255)) ACIKLAMA from MAZOT_FISI'
      'where'
      'MAZOT_FISI.ALAN_PERSONEL_KOD<>'#39#39
      'and'
      'MAZOT_FIS_ID not IN (select belge_id from PERSONEL_HAR'
      
        'where PERSONEL_HAR.PERSONEL_KOD=MAZOT_FISI.ALAN_PERSONEL_KOD and' +
        ' PERSONEL_HAR.belge_tur=42 and MAZOT_FISI.MAZOT_FIS_ID=PERSONEL_' +
        'HAR.belge_id and PERSONEL_HAR.BA='#39'B'#39')'
      ''
      'union all'
      ''
      
        'select MAZOT_FIS_ID ID ,cast ('#39'MAZOT_FISI personel hareketi pers' +
        'onehar da yok'#39' as varchar(255)) ACIKLAMA from MAZOT_FISI'
      'where'
      'MAZOT_FISI.VEREN_PERSONEL_KOD<>'#39#39
      'and'
      'MAZOT_FIS_ID not IN (select belge_id from PERSONEL_HAR'
      
        'where PERSONEL_HAR.PERSONEL_KOD=MAZOT_FISI.VEREN_PERSONEL_KOD an' +
        'd PERSONEL_HAR.belge_tur=42 and MAZOT_FISI.MAZOT_FIS_ID=PERSONEL' +
        '_HAR.belge_id and PERSONEL_HAR.BA='#39'A'#39')'
      ''
      'union all'
      ''
      
        'select PERSONELHAR_ID ID ,cast ('#39'PERSONELHAR personel hareketi S' +
        'efer de yok'#39' as varchar(255)) ACIKLAMA from PERSONEL_HAR '
      'where'
      'PERSONEL_HAR.belge_tur=41 and BA='#39'A'#39
      'and'
      'PERSONEL_HAR.belge_id  not IN (select sefer_id from SEFER'
      
        'where PERSONEL_HAR.PERSONEL_KOD=sefer.PERSONEL_KOD and SEFER_TAM' +
        'AMLANDI=1)'
      ''
      'union all'
      ''
      
        'select PERSONELHAR_ID ID ,cast ('#39'PERSONELHAR personel hareketi M' +
        'Azot Fi'#351'inde yok'#39' as varchar(255)) ACIKLAMA from PERSONEL_HAR '
      'where'
      'PERSONEL_HAR.belge_tur=42 and BA='#39'B'#39
      'and'
      
        'PERSONEL_HAR.belge_id  not IN (select MAZOT_FIS_ID from MAZOT_FI' +
        'SI'
      'where PERSONEL_HAR.PERSONEL_KOD=MAZOT_FISI.ALAN_PERSONEL_KOD)'
      ''
      'union all'
      ''
      
        'select PERSONELHAR_ID ID ,cast ('#39'PERSONELHAR personel hareketi M' +
        'Azot Fi'#351'inde yok'#39' as varchar(255)) ACIKLAMA from PERSONEL_HAR '
      'where'
      'PERSONEL_HAR.belge_tur=42 and BA='#39'A'#39
      'and'
      
        'PERSONEL_HAR.belge_id  not IN (select MAZOT_FIS_ID from MAZOT_FI' +
        'SI'
      'where PERSONEL_HAR.PERSONEL_KOD=MAZOT_FISI.VEREN_PERSONEL_KOD)')
    TabOrder = 9
    Visible = False
    WordWrap = False
  end
  object IB_DataSource1: TIB_DataSource
    Dataset = IB_Query1
    Left = 128
    Top = 128
  end
  object IB_Query1: TIB_Query
    IB_Connection = DataMod.dbaMain
    ColorScheme = False
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 256
    Top = 144
  end
end
