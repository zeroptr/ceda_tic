object MainForm: TMainForm
  Left = 183
  Top = 115
  Caption = 'Ceda Yaz'#305'l'#305'm   Kara Nakliyat Program'#305
  ClientHeight = 568
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = True
  Position = poDesigned
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDblClick = FormDblClick
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_Sirket_Adi: TLabel
    Left = 24
    Top = 48
    Width = 695
    Height = 136
    Caption = 'Ceda Yaz'#305'l'#305'm'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clGray
    Font.Height = -96
    Font.Name = 'Arial Black'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Lbl_Nerede: TLabel
    Left = 24
    Top = 288
    Width = 33
    Height = 136
    Font.Charset = TURKISH_CHARSET
    Font.Color = clGray
    Font.Height = -96
    Font.Name = 'Arial Black'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 549
    Width = 752
    Height = 19
    AutoHint = True
    Panels = <
      item
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Width = 200
      end
      item
        Alignment = taCenter
        Text = 'Kullan'#305'c'#305
        Width = 100
      end
      item
        Alignment = taCenter
        Text = 'Y'#305'l'
        Width = 150
      end
      item
        Alignment = taCenter
        Text = 'Tarih'
        Width = 75
      end
      item
        Alignment = taCenter
        Text = 'Version'
        Width = 100
      end
      item
        Text = #350'irket'
        Width = 50
      end>
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 752
    Height = 29
    ButtonWidth = 24
    Caption = 'ToolBar1'
    Color = clBtnFace
    Customizable = True
    Images = ImageList2
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnDblClick = ToolBar1DblClick
    object ToolButton2: TToolButton
      Left = 0
      Top = 0
      Width = 25
      Caption = 'ToolButton2'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnDovizKarti: TToolButton
      Left = 25
      Top = 0
      Hint = 'D'#246'viz Kurlar'#305
      Caption = 'D'#246'viz Kart'#305
      ImageIndex = 3
      MenuItem = mnuDovizKarti
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton1: TToolButton
      Left = 49
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object btnHesapMak: TToolButton
      Left = 57
      Top = 0
      Hint = 'Hesap Makinas'#305
      Caption = 'btnHesapMak'
      ImageIndex = 11
      OnClick = btnHesapMakClick
    end
    object ToolButton4: TToolButton
      Left = 81
      Top = 0
      Width = 46
      Caption = 'ToolButton4'
      ImageIndex = 28
      Style = tbsSeparator
    end
    object btnKULSIF: TToolButton
      Left = 127
      Top = 0
      Hint = 'Kullan'#305'c'#305' Bilgilerim ve '#350'ifre De'#287'i'#351'tirme'
      ImageIndex = 10
      OnClick = btnKULSIFClick
    end
    object ToolButton3: TToolButton
      Left = 151
      Top = 0
      Hint = #350'irket De'#287'i'#351'tirme'
      Caption = #350'i'
      ImageIndex = 0
      OnClick = mnuSirketDegistirmeClick
    end
    object ToolButton6: TToolButton
      Left = 175
      Top = 0
      Width = 42
      Caption = 'ToolButton6'
      ImageIndex = 8
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 217
      Top = 0
      Caption = 'Sefer Takip'
      ImageIndex = 7
      OnClick = mnuSeferTakipClick
    end
  end
  object Memo1: TMemo
    Left = 344
    Top = 336
    Width = 185
    Height = 73
    Lines.Strings = (
      'servis 65 cari harlar 60 olacak'
      'lite ta  transport da '
      'urunhar tablosundaki sefermazot  id '
      'yoktur'
      ''
      ''
      ''
      'muhasebe rapor sat'#305'r renklendirme')
    TabOrder = 1
    Visible = False
  end
  object MainMenu: TMainMenu
    Images = ImageList2
    Left = 204
    Top = 224
    object mnuTanimlamalar: TMenuItem
      Caption = 'Tan'#305'mlamalar'
      SubMenuImages = ImageList2
      object mnuCari: TMenuItem
        Caption = 'Cari'
        ImageIndex = 5
        object mnuYeniCari: TMenuItem
          Caption = 'Yeni Cari Tan'#305'mlama'
          ImageIndex = 5
          OnClick = muYeniCariTanimlamaClick
        end
        object mnuCariListe: TMenuItem
          Caption = 'Cari Listesi'
          ImageIndex = 5
          OnClick = mnuCariListeClick
        end
        object mnuCariGrup: TMenuItem
          Caption = 'Cari Gruplar'#305
          ImageIndex = 5
          OnClick = mnuCariGruplariClick
        end
        object mnuCariHareketAktarim: TMenuItem
          Caption = 'Cari Hareket Aktar'#305'm'#305
          ImageIndex = 5
          Visible = False
          OnClick = mnuCariHareketAktarimClick
        end
      end
      object mnuUrun: TMenuItem
        Caption = #220'r'#252'n'
        ImageIndex = 9
        object mnuYeniUrun: TMenuItem
          Caption = 'Yeni '#220'r'#252'n Tan'#305'mlama'
          ImageIndex = 9
          OnClick = mnuYeniUrunTanimlamaClick
        end
        object mnuUrunListe: TMenuItem
          Caption = #220'r'#252'n Listesi'
          ImageIndex = 9
          OnClick = mnuUrunListeClick
        end
        object mnuUrunGrup: TMenuItem
          Caption = #220'r'#252'n Gruplar'#305
          ImageIndex = 9
          OnClick = mnuUrunGrubuTanimlamaClick
        end
      end
      object mnuDoviz: TMenuItem
        Caption = 'D'#246'viz'
        ImageIndex = 3
        object mnuDovizTanim: TMenuItem
          Caption = 'D'#246'viz Tan'#305'mlamalar'#305
          ImageIndex = 3
          OnClick = mnuDovizTanimlamalariClick
        end
        object mnuDovizKarti: TMenuItem
          Caption = 'D'#246'viz Kart'#305
          Hint = 'D'#246'viz Kurlar'#305
          ImageIndex = 3
          OnClick = mnuDovizKartiClick
        end
      end
      object mnuDepo: TMenuItem
        Caption = 'Depo'
        ImageIndex = 44
        object mnuDepoTanmlama: TMenuItem
          Caption = 'Depo Tan'#305'mlama'
          ImageIndex = 44
          OnClick = mnuDepoTanmlamaClick
        end
        object mnuDepoListesi: TMenuItem
          Caption = 'Depo Listesi'
          ImageIndex = 55
          OnClick = mnuDepoListesiClick
        end
      end
      object mnuPlasiyer: TMenuItem
        Caption = 'Plasiyer'
        ImageIndex = 53
        object mnuPlasiyerTanim: TMenuItem
          Caption = 'Plasiyer Tan'#305'mlama'
          ImageIndex = 53
          OnClick = mnuPlasiyerTanimClick
        end
        object mnuPlasiyerListesi: TMenuItem
          Caption = 'Plasiyer Listesi'
          ImageIndex = 55
          OnClick = mnuPlasiyerListesiClick
        end
      end
      object mnuProje: TMenuItem
        Caption = 'Proje'
        ImageIndex = 42
        object mnuProjeTanimlama: TMenuItem
          Caption = 'Proje Tan'#305'mlama'
          ImageIndex = 42
          OnClick = mnuProjeTanimlamaClick
        end
        object mnuProjeListesi: TMenuItem
          Caption = 'Proje Listesi'
          ImageIndex = 55
          OnClick = mnuProjeListesiClick
        end
        object mnuKapanmisProjeListesi: TMenuItem
          Caption = 'Kapanm'#305#351' Proje Listesi'
          OnClick = mnuKapanmisProjeListesiClick
        end
        object mnuAcikProjeListesi: TMenuItem
          Caption = 'A'#231#305'k Proje Listesi'
          OnClick = mnuAcikProjeListesiClick
        end
      end
      object mnuKasa: TMenuItem
        Caption = 'Kasa'
        ImageIndex = 52
        object mnuYeniKasa: TMenuItem
          Caption = 'Yeni Kasa'
          ImageIndex = 52
          OnClick = mnuYeniKasaClick
        end
        object mnuKasaListesi: TMenuItem
          Caption = 'Kasa Listesi'
          ImageIndex = 55
          OnClick = mnuKasaListesiClick
        end
      end
      object mnuMasraf: TMenuItem
        Caption = 'Masraf'
        object mnuYeniMasraf: TMenuItem
          Caption = 'Yeni Masraf Tan'#305'mlamas'#305
          OnClick = mnuYeniMasrafClick
        end
        object mnuMasrafListesi: TMenuItem
          Caption = 'Masraf Listesi'
          OnClick = mnuMasrafListesiClick
        end
        object MasrafGruplar1: TMenuItem
          Caption = 'Masraf Gruplar'#305
          OnClick = MasrafGruplar1Click
        end
      end
      object mnuPaket: TMenuItem
        Caption = 'Paket'
        object PaketGirii1: TMenuItem
          Caption = 'Paket Giri'#351'i'
          OnClick = PaketGirii1Click
        end
        object PaketListesi1: TMenuItem
          Caption = 'Paket Listesi'
          OnClick = PaketListesi1Click
        end
      end
      object mnuArac: TMenuItem
        Caption = 'Ara'#231
        object AraGirii1: TMenuItem
          Caption = 'Yeni Ara'#231' Giri'#351'i'
          OnClick = AraGirii1Click
        end
        object AraListesi1: TMenuItem
          Caption = 'Ara'#231' Listesi'
          OnClick = AraListesi1Click
        end
      end
      object mnuPersonel: TMenuItem
        Caption = 'Personel'
        object PersonelGirii1: TMenuItem
          Caption = 'Yeni Personel Giri'#351'i'
          OnClick = PersonelGirii1Click
        end
        object PersonelListesi1: TMenuItem
          Caption = 'Personel Listesi'
          OnClick = PersonelListesi1Click
        end
      end
      object mnuSofor: TMenuItem
        Caption = #350#246'f'#246'r'
        object YenifrTanmlama1: TMenuItem
          Caption = 'Yeni '#350#246'f'#246'r Tan'#305'mlama'
          OnClick = YenifrTanmlama1Click
        end
        object frListesi1: TMenuItem
          Caption = #350#246'f'#246'r Listesi'
          OnClick = frListesi1Click
        end
      end
      object mnuSrv_Arac: TMenuItem
        Caption = 'Ara'#231
        Visible = False
        object YeniAraGirii1: TMenuItem
          Caption = 'Yeni Ara'#231' Giri'#351'i'
          OnClick = YeniAraGirii1Click
        end
        object AraListesi3: TMenuItem
          Caption = 'Ara'#231' Listesi'
          OnClick = AraListesi3Click
        end
      end
      object mnuBayi: TMenuItem
        Caption = 'Bayi'
        Visible = False
        object YeniBayiGirii1: TMenuItem
          Caption = 'Yeni Bayi Giri'#351'i'
          OnClick = YeniBayiGirii1Click
        end
        object BayiListesi1: TMenuItem
          Caption = 'Bayi Listesi'
          OnClick = BayiListesi1Click
        end
      end
      object mnuSigorta: TMenuItem
        Caption = 'Sigorta'
        Visible = False
        object YeniSigortairketiGirii1: TMenuItem
          Caption = 'Yeni Sigorta '#350'irketi Giri'#351'i'
          OnClick = YeniSigortairketiGirii1Click
        end
        object SigortairketiListesi1: TMenuItem
          Caption = 'Sigorta '#350'irketi Listesi'
          OnClick = SigortairketiListesi1Click
        end
      end
      object mnuAraMarka: TMenuItem
        Caption = 'Ara'#231' Marka'
        Visible = False
        object YeniAraMarkaGirii1: TMenuItem
          Caption = 'Yeni Ara'#231' Marka Giri'#351'i'
          OnClick = YeniAraMarkaGirii1Click
        end
        object AraMarkaListesi1: TMenuItem
          Caption = 'Ara'#231' Marka Listesi'
          Visible = False
        end
      end
      object mnuArizaTipleri: TMenuItem
        Caption = 'Ar'#305'za Tipleri'
        Visible = False
        object YeniArzaTipGirii1: TMenuItem
          Caption = 'Yeni Ar'#305'za Tip Giri'#351'i'
          OnClick = YeniArzaTipGirii1Click
        end
        object ArzaTipiListesi1: TMenuItem
          Caption = 'Ar'#305'za Tipi Listesi'
          OnClick = ArzaTipiListesi1Click
        end
      end
      object mnuGelisNedeni: TMenuItem
        Caption = 'Geli'#351' Nedeni'
        Visible = False
        object YeniGeliNedeni1: TMenuItem
          Caption = 'Yeni Geli'#351' Nedeni'
          OnClick = YeniGeliNedeni1Click
        end
        object GeliNedeniListesi1: TMenuItem
          Caption = 'Geli'#351' Nedeni Listesi'
          OnClick = GeliNedeniListesi1Click
        end
      end
      object mnuPlaka: TMenuItem
        Caption = 'Plaka'
        Visible = False
        object YeniPlakaTanmlama1: TMenuItem
          Caption = 'Yeni Plaka Tan'#305'mlama'
          OnClick = YeniPlakaTanmlama1Click
        end
        object PlakaListesi1: TMenuItem
          Caption = 'Plaka Listesi'
          OnClick = PlakaListesi1Click
        end
      end
      object mnuESYA: TMenuItem
        Caption = 'E'#351'ya Tan'#305'mlama'
        OnClick = mnuESYAClick
      end
    end
    object mnuBelgeler: TMenuItem
      Caption = 'Belgeler'
      object mnuCek: TMenuItem
        Caption = #199'ek'
        ImageIndex = 61
        object mnuMusteriCekleri: TMenuItem
          Caption = 'M'#252#351'teri '#199'ekleri'
          ImageIndex = 61
          object mnuMusteriCekAK: TMenuItem
            Caption = 'M'#252#351'teri '#199'ek Al'#305'nd'#305' Kayd'#305
            ImageIndex = 61
            OnClick = mnuMusteriCekAKClick
          end
          object N2: TMenuItem
            Caption = '-'
          end
          object mnuPortfoydekiMCEKKarsiliksiz: TMenuItem
            Caption = 'Portfoydeki M'#252#351'teri '#199'eki Kar'#351#305'l'#305'ks'#305'z Dekontu'
            ImageIndex = 61
            OnClick = mnuPortfoydekiMCEKKarsiliksizClick
          end
          object mnuMusCekIade: TMenuItem
            Caption = 'M'#252#351'teri '#199'eki '#304'ade '#304#351'lemi'
            ImageIndex = 61
            OnClick = mnuMusCekIadeClick
          end
          object ekTahsilTediyesi1: TMenuItem
            Caption = 'Kasaya M'#252#351'teri '#199'eki Tahsili'
            ImageIndex = 61
            OnClick = ekTahsilTediyesi1Click
          end
          object N3: TMenuItem
            Caption = '-'
          end
          object mnuMCEKCIRO: TMenuItem
            Caption = 'M'#252#351'teri '#199'eki Cirolama'
            ImageIndex = 61
            OnClick = mnuMCEKCIROClick
          end
          object mnuSaticidanGelenMCEKKarsiliksiz: TMenuItem
            Caption = 'Sat'#305'c'#305'dan Gelen M'#252#351'teri '#199'eki Kar'#351#305'l'#305'ks'#305'z Dekontu'
            ImageIndex = 61
            OnClick = mnuSaticidanGelenMCEKKarsiliksizClick
          end
          object N4: TMenuItem
            Caption = '-'
          end
          object mnuMCEKTahsil: TMenuItem
            Caption = 'M'#252#351'teri '#199'eki Tahsile Verme'
            ImageIndex = 61
            OnClick = mnuMCEKTahsilClick
          end
          object mnuBankadanGelenMCEKKarsiliksiz: TMenuItem
            Caption = 'Bankadan Gelen M'#252#351'teri '#199'eki Kar'#351#305'l'#305'ks'#305'z Dekontu'
            ImageIndex = 61
            OnClick = mnuBankadanGelenMCEKKarsiliksizClick
          end
          object mnuBankGelenCekTahsilDek: TMenuItem
            Caption = 'Bankadan Gelen M'#252#351'teri '#199'eki Tahsil Dekontu'
            ImageIndex = 61
            OnClick = mnuBankGelenCekTahsilDekClick
          end
          object N5: TMenuItem
            Caption = '-'
          end
          object mnuMusteriCekListesi: TMenuItem
            Caption = 'M'#252#351'teri Cek Listesi'
            ImageIndex = 55
            OnClick = mnuMusteriCekListesiClick
          end
          object mnuCEK_HAR_LIST: TMenuItem
            Caption = 'M'#252#351'teri '#199'ek Hareketleri Listesi'
            ImageIndex = 55
            OnClick = mnuCEK_HAR_LISTClick
          end
          object SistemdenMteriekiSilme1: TMenuItem
            Caption = 'Sistemden M'#252#351'teri '#199'eki Silme'
            OnClick = SistemdenMteriekiSilme1Click
          end
        end
        object mnuBorcCekleri: TMenuItem
          Caption = 'Bor'#231' '#199'eki'
          ImageIndex = 61
          object mnuBorcCekAK: TMenuItem
            Caption = 'Bor'#231' '#199'ek Kayd'#305
            ImageIndex = 61
            OnClick = mnuBorcCekAKClick
          end
          object Bor1: TMenuItem
            Caption = 'Bor'#231' '#199'eki '#214'deme Kayd'#305
            ImageIndex = 61
            OnClick = Bor1Click
          end
          object BorekiadeAlmaDekontu1: TMenuItem
            Caption = 'Bor'#231' '#199'eki '#304'ade Alma Dekontu'
            ImageIndex = 61
            OnClick = BorekiadeAlmaDekontu1Click
          end
          object BorekiTediyesi1: TMenuItem
            Caption = 'Kasadan Bor'#231' '#199'eki Tediyesi'
            ImageIndex = 61
            OnClick = BorekiTediyesi1Click
          end
          object N6: TMenuItem
            Caption = '-'
          end
          object mnuBorcCekListesi: TMenuItem
            Caption = 'Bor'#231' '#199'ek Listesi'
            ImageIndex = 55
            OnClick = mnuBorcCekListesiClick
          end
          object BorekHareketleriListesi1: TMenuItem
            Caption = 'Bor'#231' '#199'ek Hareketleri Listesi'
            ImageIndex = 55
            OnClick = BorekHareketleriListesi1Click
          end
          object SistemdenBorekiSilme1: TMenuItem
            Caption = 'Sistemden Bor'#231' '#199'eki Silme'
            OnClick = SistemdenBorekiSilme1Click
          end
        end
      end
      object mnuSenet: TMenuItem
        Caption = 'Senet'
        ImageIndex = 62
        object mnuMusteriSenetleri: TMenuItem
          Caption = 'M'#252#351'teri Senetleri'
          ImageIndex = 62
          object mnuMusteriSenetleriAK: TMenuItem
            Caption = 'M'#252#351'teri Senedi Al'#305'nd'#305' Kayd'#305
            ImageIndex = 62
            OnClick = mnuMusteriSenetleriAKClick
          end
          object N7: TMenuItem
            Caption = '-'
          end
          object mnuPortfoydekiMSENKarsiliksiz: TMenuItem
            Caption = 'Portfoydeki M'#252#351'teri Senedi Kar'#351#305'l'#305'ks'#305'z  Dekontu'
            ImageIndex = 62
            OnClick = mnuPortfoydekiMSENKarsiliksizClick
          end
          object MteriSenediiadeilemi1: TMenuItem
            Caption = 'M'#252#351'teri Senedi '#304'ade i'#351'lemi'
            ImageIndex = 62
            OnClick = MteriSenediiadeilemi1Click
          end
          object SenetTahsilTediyesi1: TMenuItem
            Caption = 'Kasaya M'#252#351'teri Seneti Tahsili '
            ImageIndex = 62
            OnClick = SenetTahsilTediyesi1Click
          end
          object N8: TMenuItem
            Caption = '-'
          end
          object mnuMSENETCIRO: TMenuItem
            Caption = 'M'#252#351'teri Senedi Cirolama'
            ImageIndex = 62
            OnClick = mnuMSENETCIROClick
          end
          object mnuSatGelenMSENKarsiliksiz: TMenuItem
            Caption = 'Sat'#305'c'#305'dan Gelen M'#252#351'teri Senedi Kar'#351#305'l'#305'ks'#305'z Dekontu'
            ImageIndex = 62
            OnClick = mnuSatGelenMSENKarsiliksizClick
          end
          object N9: TMenuItem
            Caption = '-'
          end
          object mnuMSENTahsil: TMenuItem
            Caption = 'M'#252#351'teri Senedi Tahsile Verme'
            ImageIndex = 62
            OnClick = mnuMSENTahsilClick
          end
          object mnuBankadanGelenMSENKarsiliksiz: TMenuItem
            Caption = 'Bankadan Gelen M'#252#351'teri Senedi  Kar'#351#305'l'#305'ks'#305'z Dekontu'
            ImageIndex = 62
            OnClick = mnuBankadanGelenMSENKarsiliksizClick
          end
          object BankadanGelenMterisenediTahsildekontu1: TMenuItem
            Caption = 'Bankadan Gelen M'#252#351'teri Senedi Tahsil Dekontu'
            ImageIndex = 62
            OnClick = BankadanGelenMterisenediTahsildekontu1Click
          end
          object N10: TMenuItem
            Caption = '-'
          end
          object mnuMusteriSenetleriListesi: TMenuItem
            Caption = 'M'#252#351'teri Senetleri Listesi'
            ImageIndex = 55
            OnClick = mnuMusteriSenetleriListesiClick
          end
          object MteriSenediHareketleri1: TMenuItem
            Caption = 'M'#252#351'teri Senedi Hareketleri'
            ImageIndex = 55
            OnClick = MteriSenediHareketleri1Click
          end
          object SistemdenMteriSenediSilme1: TMenuItem
            Caption = 'Sistemden M'#252#351'teri Senedi Silme'
            OnClick = SistemdenMteriSenediSilme1Click
          end
        end
        object mnuBorcSenetleri: TMenuItem
          Caption = 'Bor'#231' Senetleri'
          ImageIndex = 62
          object mnuBorcSenetleriAK: TMenuItem
            Caption = 'Bor'#231' Senedi Kayd'#305
            ImageIndex = 62
            OnClick = mnuBorcSenetleriAKClick
          end
          object BorSenediadeAlmaDekontu1: TMenuItem
            Caption = 'Bor'#231' Senedi '#304'ade Alma Dekontu'
            ImageIndex = 62
            OnClick = BorSenediadeAlmaDekontu1Click
          end
          object BorSenetiTediyesi1: TMenuItem
            Caption = 'Kasadan Bor'#231' Seneti Tediyesi'
            ImageIndex = 62
            OnClick = BorSenetiTediyesi1Click
          end
          object N11: TMenuItem
            Caption = '-'
          end
          object mnuBorcSenetleriListesi: TMenuItem
            Caption = 'Bor'#231' Senetleri Listesi'
            ImageIndex = 55
            OnClick = mnuBorcSenetleriListesiClick
          end
          object BorSenediHareketleri1: TMenuItem
            Caption = 'Bor'#231' Senedi Hareketleri'
            ImageIndex = 55
            OnClick = BorSenediHareketleri1Click
          end
          object SistemdenBorSenediSilme1: TMenuItem
            Caption = 'Sistemden Bor'#231' Senedi Silme'
            OnClick = SistemdenBorSenediSilme1Click
          end
        end
      end
      object mnuAracMasraf: TMenuItem
        Caption = 'Ara'#231' Masraf'
        object MasrafGirii1: TMenuItem
          Caption = 'Masraf Giri'#351'i'
          OnClick = MasrafGirii1Click
        end
        object MasrrafListesi1: TMenuItem
          Caption = 'Masrraf Listesi'
          OnClick = MasrrafListesi1Click
        end
      end
      object mnuDekont: TMenuItem
        Caption = 'Dekont'
        ImageIndex = 61
        object mnuSerbestDekont: TMenuItem
          Caption = 'Serbest Dekont'
          OnClick = mnuSerbestDekontClick
        end
        object mnuDekontListesi: TMenuItem
          Caption = 'Dekont Listesi'
          ImageIndex = 55
          OnClick = mnuDekontListClick
        end
        object mnuDekontSablon: TMenuItem
          Caption = 'Dekont '#350'ablonu Tan'#305'mlama'
          OnClick = mnuDekontSablonClick
        end
        object mnuDekontSablonListesi: TMenuItem
          Caption = 'Dekont '#350'ablon Listesi'
          OnClick = mnuDekontSablonListesiClick
        end
      end
      object mnuKasaHareket: TMenuItem
        Caption = 'Kasa Hareketleri'
        ImageIndex = 61
        object mnuCariTahsilTediye: TMenuItem
          Caption = 'Cariden Tahsil / Tediye'
          ImageIndex = 52
          OnClick = mnuCariTahsilTediyeClick
        end
        object mnuMuhtelifTahsilTediye: TMenuItem
          Caption = 'Muhtelif Tahsil / Tediye'
          ImageIndex = 52
          OnClick = mnuMuhtelifTahsilTediyeClick
        end
        object mnuKasalarArasiTransfer: TMenuItem
          Caption = 'Kasalar Aras'#305' Transfer'
          ImageIndex = 52
          Visible = False
          OnClick = mnuKasalarArasiTransferClick
        end
        object mnuKasaHareketleriListesi: TMenuItem
          Caption = 'Kasa Hareketleri Listesi'
          ImageIndex = 55
          OnClick = mnuKasaHareketleriListesiClick
        end
      end
      object mnuSiparis: TMenuItem
        Caption = 'Siparis'
        object Gidensipari1: TMenuItem
          Caption = 'Sat'#305'c'#305' Sipari'#351'i'
          object YeniGidenSipari1: TMenuItem
            Caption = 'Yeni Sat'#305'c'#305' Sipari'#351
            OnClick = YeniGidenSipari1Click
          end
          object GidenSipariListesi1: TMenuItem
            Caption = 'Sat'#305'c'#305' Sipari'#351' Listesi'
            OnClick = GidenSipariListesi1Click
          end
        end
        object GelenSiparii1: TMenuItem
          Caption = 'M'#252#351'teri Sipari'#351'i'
          object YeniGelenSipari1: TMenuItem
            Caption = 'Yeni M'#252#351'teri  Sipari'#351
            OnClick = YeniGelenSipari1Click
          end
          object GelenSipariListesi1: TMenuItem
            Caption = 'M'#252#351'teri Sipari'#351' Listesi'
            OnClick = GelenSipariListesi1Click
          end
        end
      end
      object mnuIrsaliye: TMenuItem
        Caption = #304'rsaliye'
        object mnuAlisIrsaliyesi: TMenuItem
          Caption = 'Al'#305#351' '#304'rsaliyesi'
          object mnuYeniAlisIrsaliyesi: TMenuItem
            Caption = 'Yeni Al'#305#351' '#304'rsaliyesi'
            OnClick = mnuYeniAlisIrsaliyesiClick
          end
          object mnuAlisIrsaliyesiListesi: TMenuItem
            Caption = 'Al'#305#351' '#304'rsaliyesi Listesi'
            OnClick = mnuAlisIrsaliyesiListesiClick
          end
        end
        object mnuSatisIrsaliyesi: TMenuItem
          Caption = 'Sat'#305#351' '#304'rsaliyesi'
          object mnuYeniSatisIrsaliyesi: TMenuItem
            Caption = 'Yeni Sat'#305#351' '#304'rsaliyesi'
            OnClick = mnuYeniSatisIrsaliyesiClick
          end
          object mnuSatisIrsaliyesiListesi: TMenuItem
            Caption = 'Sat'#305#351' '#304'rsaliyesi Listesi'
            OnClick = mnuSatisIrsaliyesiListesiClick
          end
        end
      end
      object mnuFatura: TMenuItem
        Caption = 'Fatura'
        ImageIndex = 61
        object mnuAlisFatura: TMenuItem
          Caption = 'Al'#305#351' Faturas'#305
          ImageIndex = 49
          object Yeni1: TMenuItem
            Caption = 'Yeni Al'#305#351' Faturas'#305
            ImageIndex = 48
            OnClick = Yeni1Click
          end
          object AlFaturasListesi1: TMenuItem
            Caption = 'Al'#305#351' Faturas'#305' Listesi'
            ImageIndex = 55
            OnClick = AlFaturasListesi1Click
          end
        end
        object mnuSatisFatura: TMenuItem
          Caption = 'Sat'#305#351' Faturas'#305
          ImageIndex = 46
          object YeniSatFaturas1: TMenuItem
            Caption = 'Yeni Sat'#305#351' Faturas'#305
            ImageIndex = 45
            OnClick = YeniSatFaturas1Click
          end
          object SatFaturasListesi1: TMenuItem
            Caption = 'Sat'#305#351' Faturas'#305' Listesi'
            ImageIndex = 55
            OnClick = SatFaturasListesi1Click
          end
        end
        object YENSATIFATURASI1: TMenuItem
          Caption = 'YEN'#304' SATI'#350' FATURASI'
          Visible = False
          object YEN1: TMenuItem
            Caption = 'YEN'#304
            OnClick = YEN1Click
          end
          object Liste1: TMenuItem
            Caption = 'Liste'
            OnClick = Liste1Click
          end
        end
        object YENALIFATURASI1: TMenuItem
          Caption = 'YEN'#304' ALI'#350' FATURASI'
          Visible = False
          object YEN2: TMenuItem
            Caption = 'YEN'#304
            OnClick = YEN2Click
          end
        end
      end
      object mnuUrunDekontu: TMenuItem
        Caption = #220'r'#252'n Dekontu'
        ImageIndex = 61
        Visible = False
        object mnuYeniUrunDekontu: TMenuItem
          Caption = 'Yeni '#220'r'#252'n Dekontu'
          ImageIndex = 56
        end
        object mnuUrunDekontLst: TMenuItem
          Caption = #220'r'#252'n Dekont Listesi'
          ImageIndex = 55
        end
      end
      object mnuSefer: TMenuItem
        Caption = 'Sefer'
        object mnuSeferTakip: TMenuItem
          Caption = 'Sefer Takip'
          OnClick = mnuSeferTakipClick
        end
        object SeferGirii1: TMenuItem
          Caption = 'Yeni Sefer Giri'#351'i'
          OnClick = SeferGirii1Click
        end
        object SeferListesi1: TMenuItem
          Caption = 'Sefer Listesi'
          OnClick = SeferListesi1Click
        end
        object amamlanmSeferler1: TMenuItem
          Caption = 'Tamamlanm'#305#351' Seferler'
          OnClick = amamlanmSeferler1Click
        end
        object amamlanmamSeferler1: TMenuItem
          Caption = 'Tamamlanmam'#305#351' Seferler'
          OnClick = amamlanmamSeferler1Click
        end
      end
      object mnuMazot: TMenuItem
        Caption = 'Mazot'
        object MazotGiri1: TMenuItem
          Caption = 'Yeni Mazot Fi'#351'i Giri'#351'i'
          OnClick = MazotGiri1Click
        end
        object MazotListesi1: TMenuItem
          Caption = 'Mazot Fi'#351'i Listesi'
          OnClick = MazotListesi1Click
        end
      end
      object mnuFatura_Tran: TMenuItem
        Caption = 'Fatura'
        object AlFaturas1: TMenuItem
          Caption = 'Al'#305#351' Faturas'#305
          object YeniAlFaturas1: TMenuItem
            Caption = 'Yeni Al'#305#351' Faturas'#305
            OnClick = YeniAlFaturas1Click
          end
          object AlFaturasListesi2: TMenuItem
            Caption = 'Al'#305#351' Faturas'#305' Listesi'
            OnClick = AlFaturasListesi2Click
          end
        end
        object SatFaturas1: TMenuItem
          Caption = 'Sat'#305#351' Faturas'#305
          object YeniSatFaturas2: TMenuItem
            Caption = 'Yeni Sat'#305#351' Faturas'#305
            OnClick = YeniSatFaturas2Click
          end
          object SatFaturasListesi2: TMenuItem
            Caption = 'Sat'#305#351' Faturas'#305' Listesi'
            OnClick = SatFaturasListesi2Click
          end
        end
      end
      object mnuYuklemeFisi: TMenuItem
        Caption = 'Y'#252'kleme Fi'#351'i'
        object YeniYklemeFii1: TMenuItem
          Caption = 'Yeni Y'#252'kleme Fi'#351'i'
          OnClick = YeniYklemeFii1Click
        end
        object YklemeFiiListesi1: TMenuItem
          Caption = 'Y'#252'kleme Fi'#351'i Listesi'
          OnClick = YklemeFiiListesi1Click
        end
      end
      object MnuFatura_srv: TMenuItem
        Caption = 'Fatura'
        Visible = False
        object AlisFaturas1: TMenuItem
          Caption = 'Alis Faturas'#305
          object YeniAlFaturas2: TMenuItem
            Caption = 'Yeni Al'#305#351' Faturas'#305
            OnClick = YeniAlFaturas2Click
          end
          object AlFaturasListesi3: TMenuItem
            Caption = 'Al'#305#351' Faturas'#305' Listesi'
            OnClick = AlFaturasListesi3Click
          end
        end
        object SatiFaturas1: TMenuItem
          Caption = 'Sati'#351' Faturas'#305
          object YeniSatFaturas3: TMenuItem
            Caption = 'Yeni Sat'#305#351' Faturas'#305
            OnClick = YeniSatFaturas3Click
          end
          object SatFaturasListesi3: TMenuItem
            Caption = 'Sat'#305#351' Faturas'#305' Listesi'
            OnClick = SatFaturasListesi3Click
          end
        end
      end
      object mnuOnarmFisi: TMenuItem
        Caption = 'Onar'#305'm Fi'#351'i'
        Visible = False
        object YeniOnarmFii1: TMenuItem
          Caption = 'Yeni Onar'#305'm Fi'#351'i'
          OnClick = YeniOnarmFii1Click
        end
        object OnarmFiiListesi1: TMenuItem
          Caption = 'Onar'#305'm Fi'#351'i Listesi'
          OnClick = OnarmFiiListesi1Click
        end
      end
      object mnuKantar: TMenuItem
        Caption = 'Kantar'
        Visible = False
        object KantarGiri1: TMenuItem
          Caption = 'Kantar Giri'#351
          object KantarGirii1: TMenuItem
            Caption = 'Kantar Giri'#351'i'
            OnClick = KantarGirii1Click
          end
          object GiriListesi1: TMenuItem
            Caption = 'Giri'#351' Listesi'
            OnClick = GiriListesi1Click
          end
        end
        object Kantark1: TMenuItem
          Caption = 'Kantar '#199#305'k'#305#351#305
          Visible = False
          object Kantark2: TMenuItem
            Caption = 'Kantar '#199#305'k'#305#351#305
            OnClick = Kantark2Click
          end
          object kListesi1: TMenuItem
            Caption = #199#305'k'#305#351' Listesi'
            OnClick = kListesi1Click
          end
        end
        object Raporlar1: TMenuItem
          Caption = 'Raporlar'
          object GiriListesi2: TMenuItem
            Caption = 'Giri'#351' Listesi'
            OnClick = GiriListesi2Click
          end
          object kListesi2: TMenuItem
            Caption = #199#305'k'#305#351' Listesi'
            OnClick = kListesi2Click
          end
        end
      end
      object mnuANTREPO: TMenuItem
        Caption = 'Antrepo'
        object GiriFii1: TMenuItem
          Caption = 'Giri'#351' Fi'#351'i'
          object mnuYeniAntrepoGirisFisi: TMenuItem
            Caption = 'Yeni Giri'#351' Fi'#351'i'
            OnClick = mnuYeniAntrepoGirisFisiClick
          end
          object mnuGirsiFisiListesi: TMenuItem
            Caption = 'Giri'#351' Fi'#351'i Listesi'
            OnClick = mnuGirsiFisiListesiClick
          end
        end
        object mnuANT_Cikis_fis_list: TMenuItem
          Caption = #199#305'k'#305#351' Fi'#351'leri Listesi'
          OnClick = mnuANT_Cikis_fis_listClick
        end
        object mnuAntrepodakiMallar: TMenuItem
          Caption = 'Antrepodaki Mallar'
          OnClick = mnuAntrepodakiMallarClick
        end
        object mnuANT_TumHareketler: TMenuItem
          Caption = 'T'#252'm Antrepo Hareketleri'
          OnClick = mnuANT_TumHareketlerClick
        end
      end
    end
    object mnuRapor: TMenuItem
      Caption = 'Raporlar'
      SubMenuImages = ImageList2
      object mnuRaporCari: TMenuItem
        Caption = 'Cari'
        object mnuRaporCariListesi: TMenuItem
          Caption = 'Cari Listesi'
          OnClick = mnuRaporCariListesiClick
        end
        object mnuRaporCariBakiyeliHareketListesi: TMenuItem
          Caption = 'Cari Bakiyeli Hareket Listesi'
          OnClick = mnuRaporCariBakiyeliHareketListesiClick
        end
        object mnuRaporAyBazindaCariBorcAlacak: TMenuItem
          Caption = 'Ay Baz'#305'nda Cari Bor'#231' Alacak Raporu'
          OnClick = mnuRaporAyBazindaCariBorcAlacakClick
        end
        object mnuRaporGrupBazindaCariBakiyeliHareket: TMenuItem
          Caption = 'Grup Baz'#305'nda Cari Bakiyeli Hareket Raporu'
          OnClick = mnuRaporGrupBazindaCariBakiyeliHareketClick
        end
        object mnuRaporCariHareket: TMenuItem
          Caption = 'Cari Hareket Raporu'
          OnClick = mnuRaporCariHareketClick
        end
        object mnuRaporTarihAralikliCariHareket: TMenuItem
          Caption = 'Tarih Aral'#305'kl'#305' Cari Hareket Raporu'
          OnClick = mnuRaporTarihAralikliCariHareketClick
        end
      end
      object mnuRaporFatura: TMenuItem
        Caption = 'Fatura'
        object mnuRaporAlisFaturasi: TMenuItem
          Caption = 'Al'#305#351' Faturas'#305' Raporu'
          OnClick = mnuRaporAlisFaturasiClick
        end
        object mnuRaporSatisFaturasi: TMenuItem
          Caption = 'Sat'#305#351' Faturas'#305' Raporu'
          OnClick = mnuRaporSatisFaturasiClick
        end
      end
      object mnuRaporIrsaliye: TMenuItem
        Caption = #304'rsaliye'
        object Alrsaliyesi1: TMenuItem
          Caption = 'Al'#305#351' '#304'rsaliyesi'
          OnClick = Alrsaliyesi1Click
        end
        object Satrsaliyesi1: TMenuItem
          Caption = 'Sat'#305#351' '#304'rsaliyesi'
          OnClick = Satrsaliyesi1Click
        end
      end
      object mnuRaporSiparis: TMenuItem
        Caption = 'Sipari'#351
        object MteriSipariiListesi1: TMenuItem
          Caption = 'M'#252#351'teri Sipari'#351'i Listesi'
          OnClick = MteriSipariiListesi1Click
        end
        object SatcSipariiListesi1: TMenuItem
          Caption = 'Sat'#305'c'#305' Sipari'#351'i Listesi'
          OnClick = SatcSipariiListesi1Click
        end
      end
      object mnuRaporUrun: TMenuItem
        Caption = #220'r'#252'n'
        object mnuRaporUrunListesi: TMenuItem
          Caption = #220'r'#252'n Listesi'
          OnClick = mnuRaporUrunListesiClick
        end
        object mnuFatAyUrunRap: TMenuItem
          Caption = 'Fatura Ayr'#305'nt'#305'l'#305' '#220'r'#252'n Raporu'
          Enabled = False
          Visible = False
          OnClick = mnuFatAyUrunRapClick
        end
        object rnFiyatListesi1: TMenuItem
          Caption = #220'r'#252'n Fiyat Listesi'
          OnClick = rnFiyatListesi1Click
        end
        object rnHareketleri1: TMenuItem
          Caption = #220'r'#252'n Hareketleri'
          OnClick = rnHareketleri1Click
        end
      end
      object mnuRaporDepo: TMenuItem
        Caption = 'Depo'
        object mnuRaporDepoUrunListesi: TMenuItem
          Caption = 'Depo '#220'r'#252'n Listesi'
          OnClick = mnuRaporDepoUrunListesiClick
        end
      end
      object mnuRaporDoviz: TMenuItem
        Caption = 'D'#246'viz'
        object mnuRaporDovizKurlari: TMenuItem
          Caption = 'D'#246'viz Kurlar'#305' Raporu'
          OnClick = mnuRaporDovizKurlariClick
        end
      end
      object mnuRaporKasa: TMenuItem
        Caption = 'Kasa'
        ImageIndex = 52
        object mnuRaporAylikKasa: TMenuItem
          Caption = 'Ayl'#305'k Kasa Raporu'
          ImageIndex = 52
          OnClick = mnuRaporAylikKasaClick
        end
        object mnuRaporGunlukKasaHareket: TMenuItem
          Caption = 'G'#252'nl'#252'k Kasa Hareket Raporu'
          ImageIndex = 52
          OnClick = mnuRaporGunlukKasaHareketClick
        end
        object mnuRaporKasaHareket: TMenuItem
          Caption = 'Kasa Hareket Raporu'
          ImageIndex = 52
          OnClick = mnuRaporKasaHareketClick
        end
      end
      object mnuRaporCek: TMenuItem
        Caption = #199'ek'
        object mnuRaporMusteriCekleri: TMenuItem
          Caption = 'M'#252#351'teri '#199'ekleri Raporu'
          OnClick = mnuRaporMusteriCekleriClick
        end
        object mnuRaporBorcCekleri: TMenuItem
          Caption = 'Bor'#231' '#199'ekleri Raporu'
          OnClick = mnuRaporBorcCekleriClick
        end
      end
      object mnuRaporSenet: TMenuItem
        Caption = 'Senet'
        object mnuRaporMusteriSenetleri: TMenuItem
          Caption = 'M'#252#351'teri Senetleri Raporu'
          OnClick = mnuRaporMusteriSenetleriClick
        end
        object mnuRaporBorcSenetleri: TMenuItem
          Caption = 'Bor'#231' Senetleri Raporu'
          OnClick = mnuRaporBorcSenetleriClick
        end
      end
      object mnuRaporProje: TMenuItem
        Caption = 'Proje'
        ImageIndex = 42
        object mnuRaporGenelProjeListesi: TMenuItem
          Caption = 'Genel Proje Listesi'
          ImageIndex = 42
          OnClick = mnuRaporGenelProjeListesiClick
        end
        object mnuRaporProjeHareketleriListesi: TMenuItem
          Caption = 'Proje Hareketleri Listesi'
          ImageIndex = 42
          OnClick = mnuRaporProjeHareketleriListesiClick
        end
      end
      object mnuRaporMasraf: TMenuItem
        Caption = 'Masraf'
        object mnuRaporMasrafListesi: TMenuItem
          Caption = 'Masraf Listesi'
          OnClick = mnuRaporMasrafListesiClick
        end
        object mnuRaporMasrafHareketleriListesi: TMenuItem
          Caption = 'Masraf Hareketleri Listesi'
          OnClick = mnuRaporMasrafHareketleriListesiClick
        end
        object mnuBakiyeliMasrafHareketListesi: TMenuItem
          Caption = 'Bakiyeli Masraf Hareket Listesi'
          OnClick = mnuBakiyeliMasrafHareketListesiClick
        end
      end
      object mnuRaporPlasiyer: TMenuItem
        Caption = 'Plasiyer'
        ImageIndex = 53
        object mnuRaporPlasiyerListesi: TMenuItem
          Caption = 'Plasiyer Listesi'
          ImageIndex = 53
          OnClick = mnuRaporPlasiyerListesiClick
        end
        object mnuRaporPlasiyerHareketleriListesi: TMenuItem
          Caption = 'Plasiyer Hareketleri Listesi'
          ImageIndex = 53
          OnClick = mnuRaporPlasiyerHareketleriListesiClick
        end
      end
      object mnuRaporSofor: TMenuItem
        Caption = 'S'#246'f'#246'r'
        object SfrListesi1: TMenuItem
          Caption = 'S'#246'f'#246'r Listesi'
          OnClick = SfrListesi1Click
        end
      end
      object mnuRaporArac: TMenuItem
        Caption = 'Ara'#231
        object AraListesi2: TMenuItem
          Caption = 'Ara'#231' Listesi'
          OnClick = AraListesi2Click
        end
        object AraHareketleri1: TMenuItem
          Caption = 'Ara'#231' Hareketleri'
          OnClick = AraHareketleri1Click
        end
        object SirketAralarMaliyetRaporu1: TMenuItem
          Caption = 'Sirket Ara'#231'lar'#305' Maliyet Raporu'
          OnClick = SirketAralarMaliyetRaporu1Click
        end
        object KiralkKamyonAlacakRaporu1: TMenuItem
          Caption = 'Kiral'#305'k Kamyon Alacak Raporu'
          OnClick = KiralkKamyonAlacakRaporu1Click
        end
      end
      object mnuRaporPersonel: TMenuItem
        Caption = 'Personel'
        object PersonelListesi2: TMenuItem
          Caption = 'Personel Listesi'
          OnClick = PersonelListesi2Click
        end
        object PersonelHareketleri1: TMenuItem
          Caption = 'Personel Hareketleri'
          OnClick = PersonelHareketleri1Click
        end
        object liiiKesilmiPersonelListesi1: TMenuItem
          Caption = #304'li'#351'i'#287'i Kesilmi'#351' Personel Listesi'
          OnClick = liiiKesilmiPersonelListesi1Click
        end
        object AraPersonelListesi1: TMenuItem
          Caption = 'Ara'#231' Personel Listesi'
          OnClick = AraPersonelListesi1Click
        end
        object PersonelHareketleriSeferden1: TMenuItem
          Caption = 'Personel '#304#351' Hareketleri Seferden'
          OnClick = PersonelHareketleriSeferden1Click
        end
      end
      object mnuRaporSefer: TMenuItem
        Caption = 'Sefer'
        object SeferListesi2: TMenuItem
          Caption = 'Sefer Listesi'
          OnClick = SeferListesi2Click
        end
        object SeferKaytlarListesi1: TMenuItem
          Caption = 'Sefer Kay'#305'tlar'#305' Listesi'
          OnClick = SeferKaytlarListesi1Click
        end
        object AlcyaFaturalanmamSeferKaytlar1: TMenuItem
          Caption = 'Al'#305'c'#305'ya Faturalanmam'#305#351' Sefer Kay'#305'tlar'#305
          OnClick = AlcyaFaturalanmamSeferKaytlar1Click
        end
        object SatcnnFaturalamadSeferKaytlar1: TMenuItem
          Caption = 'Sat'#305'c'#305'n'#305'n Faturalamad'#305#287#305' Sefer Kay'#305'tlar'#305
          OnClick = SatcnnFaturalamadSeferKaytlar1Click
        end
        object FaturaSeferBalantlar1: TMenuItem
          Caption = 'Fatura Sefer Ba'#287'lant'#305'lar'#305
          OnClick = FaturaSeferBalantlar1Click
        end
        object SeferMazotBalantlar1: TMenuItem
          Caption = 'Sefer Mazot Ba'#287'lant'#305'lar'#305
          OnClick = SeferMazotBalantlar1Click
        end
        object KirketGnlkSeferRaporu1: TMenuItem
          Caption = #350'irket G'#252'nl'#252'k Sefer Raporu'
          OnClick = KirketGnlkSeferRaporu1Click
        end
        object KToplamcmalRaporu1: TMenuItem
          Caption = 'Toplam '#304'cmal Raporu'
          OnClick = KToplamcmalRaporu1Click
        end
        object KKiralkGnlkSeferRaporu1: TMenuItem
          Caption = 'Kiral'#305'k Ara'#231' G'#252'nl'#252'k Sefer Raporu'
          OnClick = KKiralkGnlkSeferRaporu1Click
        end
        object KiralkAraGnlkSeferRaporuTarihli1: TMenuItem
          Caption = 'Kiral'#305'k Ara'#231' G'#252'nl'#252'k Sefer Raporu Tarihli'
          OnClick = KiralkAraGnlkSeferRaporuTarihli1Click
        end
        object SeferAyrntRaporu1: TMenuItem
          Caption = 'Sefer Ayr'#305'nt'#305' Raporu'
          OnClick = SeferAyrntRaporu1Click
        end
      end
      object mnuRaporMazot: TMenuItem
        Caption = 'Mazot'
        object MazotListesi2: TMenuItem
          Caption = 'Mazot Listesi'
          OnClick = MazotListesi2Click
        end
        object MazotAraRaporu1: TMenuItem
          Caption = 'Mazot Ara'#231' Raporu'
          OnClick = MazotAraRaporu1Click
        end
        object FaturaMazotBalantlar1: TMenuItem
          Caption = 'Fatura Mazot Ba'#287'lant'#305'lar'#305
          OnClick = FaturaMazotBalantlar1Click
        end
        object MazotSeferBalantlar1: TMenuItem
          Caption = 'Mazot Sefer Ba'#287'lant'#305'lar'#305
          OnClick = MazotSeferBalantlar1Click
        end
        object oplamMazotRaporu1: TMenuItem
          Caption = 'Toplam Mazot Raporu'
          OnClick = oplamMazotRaporu1Click
        end
      end
      object mnuRapor_Srv_Arac: TMenuItem
        Caption = 'Ara'#231
        Visible = False
        object AraListesi4: TMenuItem
          Caption = 'Ara'#231' Listesi'
          OnClick = AraListesi4Click
        end
      end
      object mnuRaporOnarim: TMenuItem
        Caption = 'Onarim Fi'#351'i'
        Visible = False
        object OnarmFiiListesi2: TMenuItem
          Caption = 'Onar'#305'm Fi'#351'i Listesi'
          OnClick = OnarmFiiListesi2Click
        end
      end
      object mnuRaporBelgeTuru: TMenuItem
        Caption = 'Belge T'#252'r'#252' Raporu'
        OnClick = mnuRaporBelgeTuruClick
      end
      object mnuRaporSerbestDekont: TMenuItem
        Caption = 'Serbest Dekont Raporu'
        OnClick = mnuRaporSerbestDekontClick
      end
      object KullancRaporTanmlama1: TMenuItem
        Caption = 'Kullan'#305'c'#305' Raporlar'#305
        Visible = False
      end
      object mnuAntrepoRap: TMenuItem
        Caption = 'Antrepo'
        object GeiciDepolamaGirivekStokListesi1: TMenuItem
          Caption = 'Ge'#231'ici Depolama Giri'#351' ve '#199#305'k'#305#351' Stok Listesi'
          OnClick = GeiciDepolamaGirivekStokListesi1Click
        end
        object AntrepoGirivekStokListesi1: TMenuItem
          Caption = 'Antrepo Giri'#351' ve '#199#305'k'#305#351' Stok Listesi'
          OnClick = AntrepoGirivekStokListesi1Click
        end
        object StokDefteri1: TMenuItem
          Caption = 'Stok Defteri'
          OnClick = StokDefteri1Click
        end
        object mHareketDkm1: TMenuItem
          Caption = 'T'#252'm Hareket D'#246'k'#252'm'#252
          OnClick = mHareketDkm1Click
        end
        object BeyanTehlikesineGirenKalemler1: TMenuItem
          Caption = 'Beyan Tehlikesine Giren Kalemler'
          OnClick = BeyanTehlikesineGirenKalemler1Click
        end
        object ArdiyeGElirRaporu1: TMenuItem
          Caption = 'Ardiye Gelir Raporu'
          OnClick = ArdiyeGElirRaporu1Click
        end
      end
    end
    object mnuPencereler: TMenuItem
      Caption = 'Pencereler'
      object mnuBasamakla: TMenuItem
        Caption = 'Basamakla'
        OnClick = mnuBasamaklaClick
      end
      object mnuDose: TMenuItem
        Caption = 'D'#246#351'e'
        OnClick = mnuDoseClick
      end
    end
    object mnuYonetici: TMenuItem
      Caption = 'Y'#246'netici'
      SubMenuImages = ImageList2
      object mnuSubeTanimlama: TMenuItem
        Caption = #350'ube Tan'#305'mlamalar'#305
        ImageIndex = 59
        OnClick = mnuSubeTanimlamaClick
      end
      object mnuMonitor: TMenuItem
        Caption = 'Monit'#246'r'
        Visible = False
        OnClick = mnuMonitorClick
      end
      object mnuMuhasebeRaporKod: TMenuItem
        Caption = 'Rapor Kodlar'#305
        ImageIndex = 59
        OnClick = mnuMuhasebeRaporKodClick
      end
      object mnuParametreler: TMenuItem
        Caption = 'Parametreler'
        ImageIndex = 59
        OnClick = mnuParametrelerClick
      end
      object mnuFaturaParametreleri: TMenuItem
        Caption = 'Fatura Parametreleri'
        ImageIndex = 59
        OnClick = mnuFaturaParametreleriClick
      end
      object mnuIrsaliyeParametreleri: TMenuItem
        Caption = #304'rsaliye Parametreleri'
        OnClick = mnuIrsaliyeParametreleriClick
      end
      object mnuKodlamaParametreleri: TMenuItem
        Caption = 'Kodlama Parametreleri'
        ImageIndex = 59
        OnClick = mnuKodlamaParametreleriClick
      end
      object mnuUrunMasrafTanimlama: TMenuItem
        Caption = #220'r'#252'n Masraf Tan'#305'mlama'
        OnClick = mnuUrunMasrafTanimlamaClick
      end
      object mnuDizinler: TMenuItem
        Caption = 'Dizinler'
        ImageIndex = 60
        OnClick = mnuDizinlerClick
      end
      object mnuOlcuBirimleri: TMenuItem
        Caption = #214'l'#231#252' Birimleri'
        OnClick = lBirimleri1Click
      end
      object mnuKullaniciModul: TMenuItem
        Caption = 'Kullan'#305'c'#305' / Modul'
        object mnuModulTanim: TMenuItem
          Caption = 'Modul Tan'#305'mlama'
          OnClick = mnuModulTanimClick
        end
        object mnuKullaniciTanimlama: TMenuItem
          Caption = 'Kullan'#305'c'#305' Tan'#305'mlama'
          OnClick = mnuKullaniciTanimlamaClick
        end
        object mnuKullaniciHak: TMenuItem
          Caption = 'Kullan'#305'c'#305' Haklar'#305' Tan'#305'mlama'
          OnClick = mnuKullaniciHakClick
        end
        object mnuRaporKullaniciHak: TMenuItem
          Caption = 'Kullan'#305'c'#305' Haklar'#305' Raporu'
          OnClick = mnuRaporKullaniciHakClick
        end
      end
      object mnuSirketIslemleri: TMenuItem
        Caption = #350'irket '#304#351'lemleri'
        object mnuSirketDegistirme: TMenuItem
          Caption = #350'irket De'#287'i'#351'tirme'
          OnClick = mnuSirketDegistirmeClick
        end
        object mnuSirketTanimlama: TMenuItem
          Caption = 'Aktif '#350'irket Bilgileri G'#246'rme, De'#287'i'#351'iklik'
          OnClick = mnuSirketTanimlamaClick
        end
        object mnuYeniSirket: TMenuItem
          Caption = 'Yeni '#350'irket Tan'#305'mlama'
          OnClick = mnuYeniSirketClick
        end
        object mnuTERM_FF: TMenuItem
          Caption = #350'irket D'#246'nem '#304#351'lemleri'
          OnClick = mnuTERM_FFClick
        end
        object YeniDnemTanmlama1: TMenuItem
          Caption = 'Yeni D'#246'nem Tan'#305'mlama , '#214'nceki D'#246'nemden Devir'
          Visible = False
          OnClick = YeniDnemTanmlama1Click
        end
        object SirketExpert1: TMenuItem
          Caption = #350'irket '#304#351'lemleri Expert'
          Visible = False
          OnClick = SirketExpert1Click
        end
        object BakiyeDevirlemleri1: TMenuItem
          Caption = 'Bakiye Devir '#304#351'lemleri'
          Visible = False
          OnClick = BakiyeDevirlemleri1Click
        end
        object mnuDevirKayitlari: TMenuItem
          Caption = 'Devir Kay'#305'tlar'#305
          ImageIndex = 59
          OnClick = mnuDevirKayitlariClick
        end
      end
      object KaytTarihlemleri1: TMenuItem
        Caption = 'Kay'#305't Tarih '#304#351'lemleri'
        OnClick = KaytTarihlemleri1Click
      end
      object mnuYaziciTasarimi: TMenuItem
        Caption = 'Yaz'#305'c'#305' Tasar'#305'm'#305
        OnClick = mnuYaziciTasarimiClick
      end
      object mnuBelgeYazici: TMenuItem
        Caption = 'Belge - Yaz'#305'c'#305' '#304#351'lemleri'
        OnClick = mnuBelgeYaziciClick
      end
      object mnuBakimIslemleri: TMenuItem
        Caption = 'Bak'#305'm '#304#351'lemleri'
        ImageIndex = 51
        OnClick = mnuBakimIslemleriClick
      end
      object WebCamAyarlar1: TMenuItem
        Caption = 'Web Cam Ayarlar'#305
        Visible = False
        OnClick = WebCamAyarlar1Click
      end
      object mnuKullaniciRaporlari: TMenuItem
        Caption = 'Kullan'#305'c'#305' Raporlar'#305'  Tan'#305'mlama'
        Visible = False
        OnClick = mnuKullaniciRaporlariClick
      end
    end
    object mnuYardim: TMenuItem
      Caption = 'Yard'#305'm'
      object N1: TMenuItem
        Caption = '-'
      end
      object mnuHakkinda: TMenuItem
        Caption = 'Hakk'#305'nda'
        ImageIndex = 57
        OnClick = HelpAbout1Execute
      end
      object Lisans1: TMenuItem
        Caption = 'Lisans'
        OnClick = Lisans1Click
      end
    end
  end
  object ImageList2: TImageList
    Left = 88
    Top = 218
    Bitmap = {
      494C01010C000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084868400848684008486
      8400848684008486840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B696B004A494A004A494A004A49
      4A004A494A0063616300CECFCE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084868400000000000000
      000000000000000000000000000000000000943008009C3008009C3008009C30
      08009C3008009C3008009C3000009C3000009C3008009C300800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A494A0000000000000000000000
      0000000000000000000000000000000000009C9E9C00FFFFFF00F7F7F700E7E7
      E700DEDFDE009C9E9C00CECFCE0084868400000000004A494A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848684000000000084868400000000000000
      0000000000000000000000000000000000009430080094300000C6381000EF41
      3100F7513900F7594200F7614A00F7514200EF413100B5381800943008000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B696B00D6D7D60084868400000000000000
      00000000000000000000000000000000000000000000DEDFDE00F7F7F700F7F7
      F700F7F7F700DEDFDE0063616300393839008486840031303100212021000000
      0000000000000000000000000000000000000000000000000000000000008486
      8400000000008486840000000000C6C7C6000000000000000000000000000000
      000084868400000000000000000000000000943008009C300800CE381800F751
      3900FF714A00FF614200FFAE9C00FFB6B500EF412900BD382100943008000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052515200F7F7F700FFFFFF00737173004A494A000808
      0800000000000000000000000000000000000000000000000000000000009496
      9400393839006B696B009C9E9C00ADAEAD009C9E9C0039383900393839000808
      080000000000000000000000000000000000000000000000000084868400C6C7
      C600C6C7C6008486840084868400848684008486840084868400848684008486
      840000000000848684000000000000000000000000009C300800DE412100FF71
      5200FF714A00FF715200FFEFE700FFEFE700F7614200B5381800943008000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004A494A00F7F7F700FFFFFF006B696B005A595A007B797B006361
      630018181800000000000000000000000000000000008486840039383900ADAE
      AD00C6C7C600E7E7E7009C9E9C00ADAEAD00ADAEAD0039383900393839004A49
      4A0031303100393839000000000000000000000000000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600FFFFFF00C6C7C6008486
      840000000000000000000000000000000000000000009C300800CE492900FF71
      4200F7613900D6A69400E7F7F700FFCFBD00FF715200C6492100943008000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039383900F7F7F700FFFFFF006B696B0073695A0084797300636163006361
      6300737173003130310000000000000000004A494A00CECFCE00DEDFDE00F7F7
      F70084868400ADAEAD00ADAEAD00C6C7C6009C9E9C0039383900393839003938
      390039383900393839002120210000000000000000008486840084868400C6C7
      C600C6C7C600C6C7C600C6C7C600000000008486840084868400FFFFFF008486
      8400000000008486840084868400000000000000000000000000DE5121007B28
      29003120520010286B002130730052385200CE512900C6491800000000000000
      0000000000000000000000000000000000000000000000000000000000002928
      2900F7F7F700FFFFFF00737173007B6963008479730063595A009C8E7B006B61
      6300525152004A494A007371730000000000F7F7F700C6C7C60094969400DEDF
      DE00CECFCE00C6C7C600C6C7C600E7E7E700ADAEAD0039383900393839003938
      390039383900393839003938390021202100848684000000000000000000FFFF
      FF00C6C7C600C6C7C600C6C7C600000000008486840084868400C6C7C6008486
      8400000000000000000000000000000000000000000000000000000000000818
      7B0000209C0000208C0000188400001073001818630000000000000000000000
      000000000000000000000000000000000000000000000000000018181800EFEF
      EF00FFFFFF007371730084716300847973005A595A00AD9E84005A5963009C8E
      730063616300C6C7C600D6D7D60000000000F7F7F700E7E7E700E7E7E700E7E7
      E700E7E7E700E7E7E700C6C7C600C6C7C600ADAEAD0031303100313031004A49
      4A003938390039383900393839000000000084868400C6C7C600C6C7C600FFFF
      FF00848684000000000000000000000000000000000000000000C6C7C6008486
      8400C6C7C6008486840000000000000000000000000000000000000829000838
      BD000838AD000838AD000838AD000838AD000020940000000000000000000000
      0000000000000000000000000000000000000000000010101000EFEFEF00FFFF
      FF008C8E8C008C796B008486730063595A00BDA68C0052595A00AD967B005A59
      5A00C6C7C600E7E7E7000000000000000000F7F7F700F7F7F700E7E7E700C6C7
      C600C6C7C600DEDFDE00DEDFDE00F7F7F700E7E7E7009C9E9C00393839003938
      39004A494A00393839003938390008080800848684000000000000000000FFFF
      FF0084868400C6C7C600FFFFFF0000000000C6C7C600C6C7C600C6C7C6008486
      8400000000000000000000000000000000000000000000000000082063001059
      EF001049CE000849C6000841BD001049C6000841B50000000000000000000000
      00000000000000000000000000000000000008080800EFEFEF00F7F7F7008CC7
      A500B5D7C600A5A6A50063595200BDAE8C0052515A00C6AE8C0063616300D6D7
      D600E7E7E700000000000000000000000000F7F7F700C6C7C600E7E7E700E7E7
      E700F7F7F700FFFFFF009C9E9C00CECFCE00C6C7C600ADAEAD00C6C7C6009496
      940031303100393839003938390008080800000000000000000000000000C6C7
      C6000000000084868400C6C7C60000000000C6C7C600C6C7C600C6C7C6008486
      840000000000000000000000000000000000000000000000000000205A001059
      CE001049AD000849BD000841B5001051D6001051D60000000000000008000000
      00000020FF0000000000000010000000000094969400EFEFEF00BDBEBD008496
      8C007BC7A5008CC7A500DEDFDE0063616B00B59E840084797300DEDFDE00E7E7
      E70000000000000000000000000000000000F7F7F700F7F7F700F7F7F700ADAE
      AD006B696B00ADAEAD00ADAEAD004A494A004A494A00E7E7E700DEDFDE00E7E7
      E700F7F7F700313031003938390008080800000000000000000000000000C6C7
      C600FFFFFF00000000008486840084868400C6C7C600C6C7C600C6C7C6008486
      8400000000008486840000000000000000000000000000000000000008000000
      0000082852001879EF001871EF001879F7001059E70000000000000021000020
      FF00000000000020FF0000107B0000000000000000009C9E9C00636163007371
      73009496940084C7A5007BBE9C00F7F7F7008C8E8C00E7E7E700EFEFEF000000
      000000000000000000000000000000000000DEDFDE00CECFCE006B696B00F7F7
      F700FFFFFF00FFFFFF00F7F7F700E7E7E700ADAEAD0063616300C6C7C600C6C7
      C600393839006B696B003938390008080800000000000000000084868400C6C7
      C600C6C7C600C6C7C600FFFFFF00FFFFFF00FFFFFF00C6C7C600848684008486
      8400000000000000000000000000000000000000000021202100212021002118
      1800001839001071CE00218EEF001886EF000830A50000000000000018000000
      000000000000000000000020F700000000000000000000000000292829006B69
      6B009C9E9C009C969C0084BEA50073BE9C00F7F7F700EFEFEF00000000000000
      0000000000000000000000000000000000000000000000000000ADAEAD00CECF
      CE00393839004A494A004A494A00848684009C9E9C003938390008080800CECF
      CE006B696B00E7E7E700FFD7E700080808000000000000000000000000008486
      8400000000000000000000000000C6C7C6000000000084868400000000000000
      0000000000000000000000000000000000000000000000000000212021005A59
      5A0052494A002128310008102900001021000000000000000000000000000000
      0000000000000000000000086B000020FF000000000000000000000000002928
      290063616300BDBEBD00BDB6BD00CED7D600EFEFEF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEDFDE006B696B00393839002120210039383900ADAEAD00F7F7F700F7F7
      F700C6C7C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C7C6000000000084868400000000000000
      0000000000000000000000000000000000000000000000000000000000007B71
      73007B7173006B615A0018181000000000000000000000000000000000000000
      00000000000000000000000000000018DE000000000000000000000000000000
      00000000000052515200C6C7C600EFEFEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CECFCE00C6C7C600FFFFFF00DEDFDE00C6C7C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084868400848684008486840084868400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084868400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005251520052515200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000CFFF0000CFFF000061FF000061FF0052515200525152005251
      5200000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005251520031619C0000306300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003161CE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000CFFF0000CFFF000061FF000061FF0052515200525152005251
      5200525152005251520000000000000000000000000000000000008E0000008E
      0000008E0000008E000000510000FFFFFF00FFFFFF00FFFFFF00FFFFFF000051
      0000008E00000000000000000000000000000000000000000000000000000000
      00000000000052515200C6C7C600636163000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003161CE009CCFFF009CCFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000CFFF0000CFFF000061FF000061FF0052515200525152005251
      5200525152000000000000000000000000000000000000000000008E000000AE
      000000AE0000008E0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00005100000000000000000000000000000000000000000000000000005251
      5200C6C7C6006361630000000000639ECE009CCFFF00639ECE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003161CE009CCFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000CFFF0000CFFF000061FF000061FF0052515200525152000000
      0000000000000000000000000000000000000000000000000000008E000000AE
      0000008E0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000061
      CE000061CE000000000000000000000000000000000052515200C6C7C6006361
      630000000000639ECE009CCFFF009CCFFF009CCFFF009CCFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000031619C003161CE009CCFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000CFFF0000CFFF0000CFFF000030CE0000000000000000000000
      0000000000000000000000000000000000000000000000000000008E0000008E
      0000FFFFFF00FFFFFF0000008C0000008C000000000000000000000000000000
      000031CFFF00000000000000000000000000000000000000000000000000639E
      CE009CCFFF009CCFFF009CCFFF009CCFFF009CCFFF009CCFFF00639ECE000000
      000000000000000000000000000000000000000000000000000031619C000000
      00003161CE000000000031619C0031619C0031619C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000CFFF0000CFFF0000CFFF000061FF0000000000000000000000
      000000000000000000000000000000000000000000000000000000510000FFFF
      FF0000008C00CE000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000031CF
      FF0031CFFF00000000000000000000000000000000000000000000000000639E
      CE009CCFFF009CCFFF00003063009CCFFF00003063009CCFFF009CCFFF00639E
      CE0000000000000000000000000000000000000000000000000031619C003161
      CE0031CFFF009CCFFF009CCFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000CFFF0000CFFF0000CFFF0000CFFF000061FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0000008C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      00009CCFFF009CCFFF00003063009CCFFF009CCFFF0031619C00639ECE003161
      9C00639ECE000000000000000000000000000000000031619C0031619C003161
      CE0031CFFF0031CFFF009CCFFF009CCFFF0031CFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000CFFF0000CFFF0000CFFF0000CFFF000061FF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000008C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000639ECE009CCFFF009CCFFF0031619C00639ECE0031619C00639ECE009CCF
      FF0000306300639ECE0000000000000000000000000031619C00000000009CCF
      FF009CCFFF009CCFFF009CCFFF009CCFFF009CCFFF0031CFFF009CCFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000CFFF0000CFFF0000CFFF00FFFFFF000061FF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000008C00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000639ECE00639ECE0031619C00639ECE009CCFFF00003063009CCF
      FF009CCFFF00639ECE0000000000000000000000000031619C003161CE0031CF
      FF0031CFFF009CCFFF009CCFFF009CCFFF009CCFFF009CCFFF009CCFFF009CCF
      FF003161CE000000000000000000000000000000000000000000000000000000
      000000CFFF00FFFFFF000061FF000061FF000061FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000008C00CE000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000639ECE00003063009CCFFF00003063009CCF
      FF00639ECE000000000031619C00000000000000000031619C003161CE0031CF
      FF009CCFFF009CCFFF0031CFFF0031CFFF009CCFFF0031CFFF009CCFFF009CCF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052515200525152000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008E0000FFFF
      FF00FFFFFF00FFFFFF0000008C00CE000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00008E00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000639ECE00003063009CCFFF00639ECE000000
      000052515200C6C7C600000000000000000000000000000000003161CE009CCF
      FF009CCFFF009CCFFF0031CFFF009CCFFF009CCFFF0031CFFF009CCFFF009CCF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000A5A6A500DEDFDE009C9E9C000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000008C000000
      8C0000008C0000008C00CE000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000AE
      0000008E00000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000639ECE000000000052515200C6C7
      C600636163000000000000000000000000000000000000000000000000000000
      00003161CE003161CE009CCFFF0031CFFF0031CFFF009CCFFF009CCFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEDFDE00FFFFFF00A5A6A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000008C00CE000000008E
      0000008E0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00008E0000008E
      0000008E00000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000052515200C6C7C600636163000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003161CE009CCFFF009CCFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000010101000424142000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE0000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C7C6006361630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003161CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000008C00CE00
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C6000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000086840000868400000000000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000000000FF
      FF0000FFFF00000000000000FF000000FF000000FF00000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084868400000000000000000000868400008684000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF00008684000000000000000000000000000000000000FFFF000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000084868400000000000000000000000000008684000086
      84000086840000868400008684000086840000FFFF0000FFFF0000FFFF000086
      840000FFFF0000FFFF0000FFFF00000000000000000000FFFF00000000000000
      FF000000FF000000000000FFFF0000FFFF0000FFFF00000000000000FF000000
      FF000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C60084868400C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000084868400000000000000000000868400008684000086
      84000086840000868400008684000086840000FFFF0000FFFF000086840000FF
      FF0000FFFF000086840000FFFF00000000000000000000FFFF000000FF000000
      FF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      FF000000FF000000000000FFFF0000000000C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C6000000000000000000848684000000000000868400000000000000000000FF
      FF0000FFFF0000FFFF00008684000086840000FFFF0000FFFF000086840000FF
      FF00000000000086840000FFFF000000000000FFFF00000000000000FF000000
      FF0000FFFF0000FFFF00000000000000FF000000FF000000000000FFFF000000
      00000000FF000000000000FFFF0000000000C6C7C6000000000000000000C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600000000000000
      0000C6C7C600C6C7C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000084868400000000000086840000868400008684000086
      84000086840000868400008684000086840000FFFF00008684000086840000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF00000000000000FF000000
      000000FFFF00000000000000FF000000FF000000FF000000FF0000FFFF0000FF
      FF000000FF000000FF0000FFFF00000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000084868400000000000000000000000000008684000086
      840000000000000000000000000000000000000000000086840000FFFF000086
      84000086840000FFFF00000000000000000000FFFF00000000000000FF000000
      000000FFFF00000000000000FF000000FF000000FF000000FF0000FFFF0000FF
      FF000000FF000000FF0000FFFF00000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C60000000000000000008486840000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000086840000FF
      FF0000FFFF0000000000000000000000000000FFFF00000000000000FF000000
      000000FFFF0000FFFF000000FF000000FF000000FF000000000000FFFF0000FF
      FF000000FF000000FF0000FFFF00000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000084868400000000000000000000000000000000000000
      000000FFFF00C6C7C600C6C7C600C6C7C600C6C7C60000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000FF000000
      FF0000FFFF0000FFFF0000FFFF00000000000000000000FFFF0000FFFF000000
      00000000FF000000000000FFFF00000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C6000000000000000000C6C7C600C6C7C600C6C7C600C6C7
      C60000000000000000008486840000000000000000000000000000868400C6C7
      C6000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      FF000000FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      FF000000FF0000FFFF0000FFFF00000000000000000000000000000000000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000084868400000000000000000000000000000000000086
      840000868400FFFFFF00FFFFFF00FFFFFF000086840000868400008684000086
      840000868400000000000000000000000000000000000000000000FFFF000000
      00000000FF000000FF000000000000000000000000000000FF000000FF000000
      FF000000000000FFFF0000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600000000000000000084868400000000000000000000000000000000000000
      0000008684000086840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000086
      840000000000000000000000000000000000000000000000000000FFFF0000FF
      FF00000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084868400000000000000000000000000000000000000
      00000086840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00008684000086
      8400000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF000000000000000000000000000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000008684000000000000000000000000000000000000000000000000000000
      0000000000000086840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084868400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C7C600C6C7
      C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7C600C6C7
      C600C6C7C600C6C7C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000083FFFFFFFFFFFFFF01FFFE3F003FFF7F
      00BFFC3F001FFE1F801FE027001FFC0FE00FC003801FF8078003E007801FF003
      00018001C03FE00100000001E07FC00100000001C07F80030000000180410007
      0000E0078055000F0000E0038049801F0000C007805DC03FC000E42FC0C0E07F
      F007FC3FE1FEF8FFF83FFC3FFFFFFDFFFFFFFC3FFFFFFF3FFEFFF00F8003FC3F
      F827F0038003F03FEC1FF0078003C03FFC2FF01F8000001FCC1FF07F8000001F
      807FF03F8000E007807FF03F8001E003803FF03F8001F003000FF03F8003F803
      0007F03F8003FC000007F0FF8003FE00800FF87F8003FE03E01FF87F8003FE0F
      FC1FFCFF8003FC3FFF3FFFFFCEFFFEFFFC3F9FCFFFFFFFFFE00F9FCF0003C003
      C00787C300018001800387C30001800180010000000100010001000000010001
      0000000000010001000097CB00018001000097CB00018003000097CB0001800F
      000197CB0001800F000187C30001C0078001E7F30001E007C003F7FB0001E007
      E007F7FB0001F81FF01FFFFF8001FFFF00000000000000000000000000000000
      000000000000}
  end
  object qry_Sirket: TIB_Query
    ColumnAttributes.Strings = (
      'AKTIF=BOOLEAN=1,0')
    FieldsDisplayFormat.Strings = (
      'TEL1=#(###)#######'
      'TEL2=#(###)#######'
      'FAX=#(###)#######'
      'VERNO=### ### ####'
      'PK=#####'
      'TOPLAM_SUBE_ADET=###'
      'SIRKET_KOD=#####')
    FieldsDisplayLabel.Strings = (
      'ADI='#350'irket Ad'#305' :'
      'YETKILI='#350'irket Yetkilisi :'
      'ADRES_1=Adres (1) :'
      'ADRES_2=Adres (2) :'
      'ILCE='#304'l'#231'e :'
      'SEHIR='#350'ehir :'
      'PK=Posta Kodu :'
      'TEL1=Telefon (1) :'
      'TEL2=Telefon (2) :'
      'FAX=Fax :'
      'VERDAIRE=Vergi Dairesi :'
      'VERNO=Vergi Numaras'#305' :'
      'LOGO='#350'irket Logosu :'
      'TOPLAM_SUBE_ADET=Toplam '#350'ube Adedi :'
      'SIRKET_KOD='#350'irket Kodu :'
      'TIC_SIC_NO=Ticaret Sicil No'
      'TIC_ODA_NO=Ticaret Oda No'
      'SSK_SIC_NO=SSK Sicil No'
      'SIRKET_AD='#350'irket Ad'#305
      'SIRKET_ID='#350'irket No')
    FieldsEditMask.Strings = (
      'TEL1=#(###)#######'
      'TEL2=#(###)#######'
      'FAX=#(###)#######'
      'VERNO=### ### ####'
      'PK=#####'
      'TOPLAM_SUBE_ADET=###'
      'SIRKET_KOD=#####')
    FieldsVisible.Strings = (
      'SIRKET_ID=FALSE')
    IB_Connection = DataMod.dbaANA
    SQL.Strings = (
      'SELECT SIRKET_ID'
      '     , SIRKET_AD'
      '     , YETKILI'
      '     , ADRES_1'
      '     , ADRES_2'
      '     , ILCE'
      '     , SEHIR'
      '     , PK'
      '     , TEL1'
      '     , TEL2'
      '     , FAX'
      '     , VERDAIRE'
      '     , VERNO'
      '     , LOGO'
      '     , TOPLAM_SUBE_ADET'
      '     , TIC_SIC_NO'
      '     , TIC_ODA_NO'
      '     , SSK_SIC_NO'
      '     , AKTIF'
      'FROM SIRKET'
      'WHERE SIRKET_ID=:PRM_SIRKET_ID;'
      '/*WHERE SIRKET_ID=1;*/'
      '')
    ColorScheme = False
    DefaultValues.Strings = (
      'AKTIF=1')
    KeyLinks.Strings = (
      'SIRKET.SIRKET_ID')
    MasterSearchFlags = [msfOpenMasterOnOpen, msfSearchAppliesToMasterOnly]
    RequestLive = True
    BufferSynchroFlags = []
    FetchWholeRows = True
    Left = 452
    Top = 125
  end
  object dts_Sirket: TIB_DataSource
    Dataset = qry_Sirket
    Left = 500
    Top = 129
  end
end
