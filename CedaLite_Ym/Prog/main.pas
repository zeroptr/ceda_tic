{$INCLUDE directive.inc}

unit Main;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, Menus,
     StdCtrls, Dialogs, Messages, ExtCtrls, ComCtrls, ToolWin, ImgList,
     ShellApi,IB_Session,IB_Components,cxSSTypes,cxSSHeaders, XPMan,
     ActnMan, ActnColorMaps, Buttons, IB_Controls, frxClass, frxDBSet;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    mnuTanimlamalar: TMenuItem;
    mnuCari: TMenuItem;
    mnuUrun: TMenuItem;
    mnuDoviz: TMenuItem;
    mnuDepo: TMenuItem;
    mnuPlasiyer: TMenuItem;
    mnuProje: TMenuItem;
    mnuKasa: TMenuItem;
    mnuYeniCari: TMenuItem;
    mnuCariListe: TMenuItem;
    mnuCariGrup: TMenuItem;
    mnuYeniUrun: TMenuItem;
    mnuUrunListe: TMenuItem;
    mnuUrunGrup: TMenuItem;
    mnuDovizTanim: TMenuItem;
    mnuDovizKarti: TMenuItem;
    mnuBelgeler: TMenuItem;
    mnuCek: TMenuItem;
    mnuDekont: TMenuItem;
    mnuDekontListesi: TMenuItem;
    mnuKasaHareket: TMenuItem;
    mnuCariTahsilTediye: TMenuItem;
    mnuKasaHareketleriListesi: TMenuItem;
    mnuYardim: TMenuItem;
    mnuParametreler: TMenuItem;
    mnuOlcuBirimleri: TMenuItem;
    mnuSubeTanimlama: TMenuItem;
    mnuMonitor: TMenuItem;
    N1: TMenuItem;
    mnuHakkinda: TMenuItem;
    mnuFatura: TMenuItem;
    mnuMusteriCekleri: TMenuItem;
    mnuMusteriCekAK: TMenuItem;
    mnuBorcCekleri: TMenuItem;
    mnuMusteriCekListesi: TMenuItem;
    mnuBorcCekListesi: TMenuItem;
    mnuBorcCekAK: TMenuItem;
    mnuAlisFatura: TMenuItem;
    mnuSatisFatura: TMenuItem;
    mnuSenet: TMenuItem;
    mnuMusteriSenetleri: TMenuItem;
    mnuMusteriSenetleriListesi: TMenuItem;
    mnuMusteriSenetleriAK: TMenuItem;
    mnuBorcSenetleri: TMenuItem;
    mnuBorcSenetleriListesi: TMenuItem;
    Yeni1: TMenuItem;
    AlFaturasListesi1: TMenuItem;
    YeniSatFaturas1: TMenuItem;
    SatFaturasListesi1: TMenuItem;
    mnuFaturaParametreleri: TMenuItem;
    mnuBorcSenetleriAK: TMenuItem;
    mnuYeniKasa: TMenuItem;
    mnuKasaListesi: TMenuItem;
    mnuRapor: TMenuItem;
    mnuRaporCari: TMenuItem;
    mnuMCEKCIRO: TMenuItem;
    mnuMSENETCIRO: TMenuItem;
    mnuMuhasebeRaporKod: TMenuItem;
    mnuMCEKTahsil: TMenuItem;
    mnuMSENTahsil: TMenuItem;
    mnuBankadanGelenMCEKKarsiliksiz: TMenuItem;
    mnuSaticidanGelenMCEKKarsiliksiz: TMenuItem;
    mnuPortfoydekiMCEKKarsiliksiz: TMenuItem;
    mnuBankadanGelenMSENKarsiliksiz: TMenuItem;
    mnuSatGelenMSENKarsiliksiz: TMenuItem;
    mnuPortfoydekiMSENKarsiliksiz: TMenuItem;
    ToolBar1: TToolBar;
    ImageList2: TImageList;
    btnDovizKarti: TToolButton;
    ToolButton2: TToolButton;
    mnuSerbestDekont: TMenuItem;
    mnuBankGelenCekTahsilDek: TMenuItem;
    BankadanGelenMterisenediTahsildekontu1: TMenuItem;
    mnuMusCekIade: TMenuItem;
    MteriSenediiadeilemi1: TMenuItem;
    mnuYonetici: TMenuItem;
    mnuSirketTanimlama: TMenuItem;
    mnuKullaniciTanimlama: TMenuItem;
    mnuKullaniciModul: TMenuItem;
    mnuKullaniciHak: TMenuItem;
    mnuModulTanim: TMenuItem;
    mnuSirketIslemleri: TMenuItem;
    mnuSirketDegistirme: TMenuItem;
    mnuYeniSirket: TMenuItem;
    mnuDizinler: TMenuItem;
    mnuKodlamaParametreleri: TMenuItem;
    mnuMuhtelifTahsilTediye: TMenuItem;
    SenetTahsilTediyesi1: TMenuItem;
    ekTahsilTediyesi1: TMenuItem;
    mnuCEK_HAR_LIST: TMenuItem;
    BorekHareketleriListesi1: TMenuItem;
    MteriSenediHareketleri1: TMenuItem;
    BorSenediHareketleri1: TMenuItem;
    ToolButton1: TToolButton;
    btnHesapMak: TToolButton;
    mnuYaziciTasarimi: TMenuItem;
    mnuRaporGunlukKasaHareket: TMenuItem;
    mnuRaporKasaHareket: TMenuItem;
    Bor1: TMenuItem;
    BorekiadeAlmaDekontu1: TMenuItem;
    BorSenediadeAlmaDekontu1: TMenuItem;
    mnuKasalarArasiTransfer: TMenuItem;
    mnuRaporBelgeTuru: TMenuItem;
    mnuCariHareketAktarim: TMenuItem;
    mnuDevirKayitlari: TMenuItem;
    mnuRaporSerbestDekont: TMenuItem;
    mnuRaporGrupBazindaCariBakiyeliHareket: TMenuItem;
    BorSenetiTediyesi1: TMenuItem;
    BorekiTediyesi1: TMenuItem;
    SistemdenMteriekiSilme1: TMenuItem;
    SistemdenBorekiSilme1: TMenuItem;
    SistemdenMteriSenediSilme1: TMenuItem;
    SistemdenBorSenediSilme1: TMenuItem;
    mnuBakimIslemleri: TMenuItem;
    mnuRaporCariHareket: TMenuItem;
    mnuBelgeYazici: TMenuItem;
    mnuRaporTarihAralikliCariHareket: TMenuItem;
    mnuRaporFatura: TMenuItem;
    mnuRaporAlisFaturasi: TMenuItem;
    mnuRaporSatisFaturasi: TMenuItem;
    mnuFatAyUrunRap: TMenuItem;
    mnuMasraf: TMenuItem;
    mnuYeniMasraf: TMenuItem;
    mnuMasrafListesi: TMenuItem;
    mnuRaporMasraf: TMenuItem;
    mnuRaporMasrafListesi: TMenuItem;
    mnuRaporMasrafHareketleriListesi: TMenuItem;
    mnuBakiyeliMasrafHareketListesi: TMenuItem;
    mnuRaporUrun: TMenuItem;
    mnuRaporDepo: TMenuItem;
    mnuRaporDoviz: TMenuItem;
    mnuRaporKasa: TMenuItem;
    mnuRaporCek: TMenuItem;
    mnuRaporSenet: TMenuItem;
    mnuRaporProje: TMenuItem;
    mnuRaporPlasiyer: TMenuItem;
    mnuRaporPlasiyerListesi: TMenuItem;
    mnuRaporPlasiyerHareketleriListesi: TMenuItem;
    mnuRaporGenelProjeListesi: TMenuItem;
    mnuRaporProjeHareketleriListesi: TMenuItem;
    mnuRaporMusteriSenetleri: TMenuItem;
    mnuRaporBorcSenetleri: TMenuItem;
    mnuRaporMusteriCekleri: TMenuItem;
    mnuRaporBorcCekleri: TMenuItem;
    mnuRaporAylikKasa: TMenuItem;
    mnuRaporDovizKurlari: TMenuItem;
    mnuRaporDepoUrunListesi: TMenuItem;
    mnuRaporUrunListesi: TMenuItem;
    mnuRaporCariListesi: TMenuItem;
    mnuRaporCariBakiyeliHareketListesi: TMenuItem;
    mnuRaporAyBazindaCariBorcAlacak: TMenuItem;
    YENSATIFATURASI1: TMenuItem;
    YENALIFATURASI1: TMenuItem;
    YEN1: TMenuItem;
    YEN2: TMenuItem;
    Liste1: TMenuItem;
    mnuTERM_FF: TMenuItem;
    mnuPlasiyerTanim: TMenuItem;
    mnuPlasiyerListesi: TMenuItem;
    mnuProjeTanimlama: TMenuItem;
    mnuProjeListesi: TMenuItem;
    mnuDepoTanmlama: TMenuItem;
    mnuDepoListesi: TMenuItem;
    btnKULSIF: TToolButton;
    ToolButton4: TToolButton;
    mnuRaporKullaniciHak: TMenuItem;
    YeniDnemTanmlama1: TMenuItem;
    mnuUrunDekontu: TMenuItem;
    mnuYeniUrunDekontu: TMenuItem;
    mnuUrunDekontLst: TMenuItem;
    MasrafGruplar1: TMenuItem;
    mnuDekontSablon: TMenuItem;
    mnuDekontSablonListesi: TMenuItem;
    mnuKapanmisProjeListesi: TMenuItem;
    mnuAcikProjeListesi: TMenuItem;
    mnuPencereler: TMenuItem;
    mnuBasamakla: TMenuItem;
    mnuDose: TMenuItem;
    mnuIrsaliyeParametreleri: TMenuItem;
    mnuIrsaliye: TMenuItem;
    mnuAlisIrsaliyesi: TMenuItem;
    mnuSatisIrsaliyesi: TMenuItem;
    mnuYeniAlisIrsaliyesi: TMenuItem;
    mnuAlisIrsaliyesiListesi: TMenuItem;
    mnuYeniSatisIrsaliyesi: TMenuItem;
    mnuSatisIrsaliyesiListesi: TMenuItem;
    mnuSiparis: TMenuItem;
    GelenSiparii1: TMenuItem;
    Gidensipari1: TMenuItem;
    YeniGelenSipari1: TMenuItem;
    GelenSipariListesi1: TMenuItem;
    YeniGidenSipari1: TMenuItem;
    GidenSipariListesi1: TMenuItem;
    mnuRaporSiparis: TMenuItem;
    MteriSipariiListesi1: TMenuItem;
    SatcSipariiListesi1: TMenuItem;
    mnuRaporIrsaliye: TMenuItem;
    Alrsaliyesi1: TMenuItem;
    Satrsaliyesi1: TMenuItem;
    Memo1: TMemo;
    Lisans1: TMenuItem;
    KaytTarihlemleri1: TMenuItem;
    BakiyeDevirlemleri1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    mnuPaket: TMenuItem;
    PaketGirii1: TMenuItem;
    PaketListesi1: TMenuItem;
    mnuArac: TMenuItem;
    AraGirii1: TMenuItem;
    AraListesi1: TMenuItem;
    mnuPersonel: TMenuItem;
    PersonelGirii1: TMenuItem;
    PersonelListesi1: TMenuItem;
    mnuSefer: TMenuItem;
    mnuMazot: TMenuItem;
    SeferGirii1: TMenuItem;
    SeferListesi1: TMenuItem;
    MazotGiri1: TMenuItem;
    MazotListesi1: TMenuItem;
    mnuRaporArac: TMenuItem;
    mnuRaporPersonel: TMenuItem;
    AraListesi2: TMenuItem;
    AraHareketleri1: TMenuItem;
    PersonelListesi2: TMenuItem;
    PersonelHareketleri1: TMenuItem;
    mnuRaporSefer: TMenuItem;
    SeferListesi2: TMenuItem;
    mnuRaporMazot: TMenuItem;
    MazotListesi2: TMenuItem;
    liiiKesilmiPersonelListesi1: TMenuItem;
    AraPersonelListesi1: TMenuItem;
    SeferKaytlarListesi1: TMenuItem;
    AlcyaFaturalanmamSeferKaytlar1: TMenuItem;
    SatcnnFaturalamadSeferKaytlar1: TMenuItem;
    MazotAraRaporu1: TMenuItem;
    FaturaSeferBalantlar1: TMenuItem;
    FaturaMazotBalantlar1: TMenuItem;
    MazotSeferBalantlar1: TMenuItem;
    rnFiyatListesi1: TMenuItem;
    rnHareketleri1: TMenuItem;
    SeferMazotBalantlar1: TMenuItem;
    SirketAralarMaliyetRaporu1: TMenuItem;
    KiralkKamyonAlacakRaporu1: TMenuItem;
    mnuFatura_Tran: TMenuItem;
    AlFaturas1: TMenuItem;
    SatFaturas1: TMenuItem;
    YeniAlFaturas1: TMenuItem;
    AlFaturasListesi2: TMenuItem;
    YeniSatFaturas2: TMenuItem;
    SatFaturasListesi2: TMenuItem;
    KirketGnlkSeferRaporu1: TMenuItem;
    KKiralkGnlkSeferRaporu1: TMenuItem;
    KToplamcmalRaporu1: TMenuItem;
    mnuUrunMasrafTanimlama: TMenuItem;
    SirketExpert1: TMenuItem;
    qry_Sirket: TIB_Query;
    dts_Sirket: TIB_DataSource;
    mnuYuklemeFisi: TMenuItem;
    YeniYklemeFii1: TMenuItem;
    YklemeFiiListesi1: TMenuItem;
    mnuSofor: TMenuItem;
    YenifrTanmlama1: TMenuItem;
    frListesi1: TMenuItem;
    WebCamAyarlar1: TMenuItem;
    mnuRaporSofor: TMenuItem;
    SfrListesi1: TMenuItem;
    PersonelHareketleriSeferden1: TMenuItem;
    KullancRaporTanmlama1: TMenuItem;
    mnuKullaniciRaporlari: TMenuItem;
    lbl_Sirket_Adi: TLabel;
    amamlanmSeferler1: TMenuItem;
    amamlanmamSeferler1: TMenuItem;
    KiralkAraGnlkSeferRaporuTarihli1: TMenuItem;
    Lbl_Nerede: TLabel;
    ToolButton3: TToolButton;
    mnuBayi: TMenuItem;
    mnuSigorta: TMenuItem;
    mnuAraMarka: TMenuItem;
    mnuSrv_Arac: TMenuItem;
    YeniAraGirii1: TMenuItem;
    AraListesi3: TMenuItem;
    YeniBayiGirii1: TMenuItem;
    BayiListesi1: TMenuItem;
    YeniSigortairketiGirii1: TMenuItem;
    SigortairketiListesi1: TMenuItem;
    YeniAraMarkaGirii1: TMenuItem;
    AraMarkaListesi1: TMenuItem;
    mnuArizaTipleri: TMenuItem;
    YeniArzaTipGirii1: TMenuItem;
    ArzaTipiListesi1: TMenuItem;
    mnuOnarmFisi: TMenuItem;
    YeniOnarmFii1: TMenuItem;
    OnarmFiiListesi1: TMenuItem;
    MnuFatura_srv: TMenuItem;
    AlisFaturas1: TMenuItem;
    SatiFaturas1: TMenuItem;
    YeniAlFaturas2: TMenuItem;
    AlFaturasListesi3: TMenuItem;
    YeniSatFaturas3: TMenuItem;
    SatFaturasListesi3: TMenuItem;
    mnuRaporOnarim: TMenuItem;
    OnarmFiiListesi2: TMenuItem;
    mnuRapor_Srv_Arac: TMenuItem;
    AraListesi4: TMenuItem;
    mnuGelisNedeni: TMenuItem;
    YeniGeliNedeni1: TMenuItem;
    GeliNedeniListesi1: TMenuItem;
    mnuAracMasraf: TMenuItem;
    MasrafGirii1: TMenuItem;
    MasrrafListesi1: TMenuItem;
    oplamMazotRaporu1: TMenuItem;
    mnuKantar: TMenuItem;
    KantarGiri1: TMenuItem;
    KantarGirii1: TMenuItem;
    GiriListesi1: TMenuItem;
    Kantark1: TMenuItem;
    Kantark2: TMenuItem;
    kListesi1: TMenuItem;
    Raporlar1: TMenuItem;
    GiriListesi2: TMenuItem;
    kListesi2: TMenuItem;
    mnuPlaka: TMenuItem;
    YeniPlakaTanmlama1: TMenuItem;
    PlakaListesi1: TMenuItem;
    mnuESYA: TMenuItem;
    SeferAyrntRaporu1: TMenuItem;
    mnuANTREPO: TMenuItem;
    mnuYeniAntrepoGirisFisi: TMenuItem;
    mnuAntrepodakiMallar: TMenuItem;
    GiriFii1: TMenuItem;
    mnuGirsiFisiListesi: TMenuItem;
    mnuANT_Cikis_fis_list: TMenuItem;
    mnuANT_TumHareketler: TMenuItem;
    mnuAntrepoRap: TMenuItem;
    GeiciDepolamaGirivekStokListesi1: TMenuItem;
    AntrepoGirivekStokListesi1: TMenuItem;
    StokDefteri1: TMenuItem;
    mHareketDkm1: TMenuItem;
    ArdiyeGElirRaporu1: TMenuItem;
    BeyanTehlikesineGirenKalemler1: TMenuItem;
    mnuSeferTakip: TMenuItem;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    procedure HelpAbout1Execute(Sender: TObject);
    Function FindChildFrm(App : TApplication ; FrmName : String ): Boolean;
    Function FindChildFrm1(App : TApplication ; FrmName : String ): Boolean;
    procedure mnuCariGruplariClick(Sender: TObject);
    procedure lBirimleri1Click(Sender: TObject);
    procedure mnuDovizKartiClick(Sender: TObject);
    procedure mnuDovizTanimlamalariClick(Sender: TObject);
    procedure mnuParametrelerClick(Sender: TObject);
    procedure muYeniCariTanimlamaClick(Sender: TObject);
    procedure mnuYeniUrunTanimlamaClick(Sender: TObject);
    procedure mnuUrunGrubuTanimlamaClick(Sender: TObject);
    procedure mnuDekontListClick(Sender: TObject);
    procedure mnuMonitorClick(Sender: TObject);
    procedure mnuCariListeClick(Sender: TObject);
    procedure mnuUrunListeClick(Sender: TObject);
    procedure mnuMusteriCekAKClick(Sender: TObject);
    procedure mnuMusteriCekListesiClick(Sender: TObject);
    procedure mnuBorcCekListesiClick(Sender: TObject);
    procedure mnuBorcCekAKClick(Sender: TObject);
    procedure mnuMusteriSenetleriListesiClick(Sender: TObject);
    procedure mnuMusteriSenetleriAKClick(Sender: TObject);
    procedure mnuBorcSenetleriListesiClick(Sender: TObject);
    procedure Yeni1Click(Sender: TObject);
    procedure YeniSatFaturas1Click(Sender: TObject);
    procedure SatFaturasListesi1Click(Sender: TObject);
    procedure AlFaturasListesi1Click(Sender: TObject);
    procedure mnuFaturaParametreleriClick(Sender: TObject);
    procedure mnuBorcSenetleriAKClick(Sender: TObject);
    procedure mnuYeniKasaClick(Sender: TObject);
    procedure mnuKasaListesiClick(Sender: TObject);
    procedure mnuMCEKCIROClick(Sender: TObject);
    procedure mnuMSENETCIROClick(Sender: TObject);
    procedure mnuBankadanGelenMCEKKarsiliksizClick(Sender: TObject);
    procedure mnuSaticidanGelenMCEKKarsiliksizClick(Sender: TObject);
    procedure mnuPortfoydekiMCEKKarsiliksizClick(Sender: TObject);
    procedure mnuBankadanGelenMSENKarsiliksizClick(Sender: TObject);
    procedure mnuSatGelenMSENKarsiliksizClick(Sender: TObject);
    procedure mnuPortfoydekiMSENKarsiliksizClick(Sender: TObject);
    procedure mnuSerbestDekontClick(Sender: TObject);
    procedure mnuBankGelenCekTahsilDekClick(Sender: TObject);
    procedure BankadanGelenMterisenediTahsildekontu1Click(Sender: TObject);
    procedure mnuMusCekIadeClick(Sender: TObject);
    procedure MteriSenediiadeilemi1Click(Sender: TObject);
    procedure mnuSirketTanimlamaClick(Sender: TObject);
    procedure mnuKullaniciHakClick(Sender: TObject);
    procedure mnuModulTanimClick(Sender: TObject);
    procedure mnuSubeTanimlamaClick(Sender: TObject);
    procedure mnuSirketDegistirmeClick(Sender: TObject);
    procedure mnuKullaniciTanimlamaClick(Sender: TObject);
    procedure mnuDizinlerClick(Sender: TObject);
    procedure mnuKodlamaParametreleriClick(Sender: TObject);
    procedure mnuCariTahsilTediyeClick(Sender: TObject);
    procedure ekTahsilTediyesi1Click(Sender: TObject);
    procedure mnuKasaHareketleriListesiClick(Sender: TObject);
    procedure mnuCEK_HAR_LISTClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SenetTahsilTediyesi1Click(Sender: TObject);
    procedure BorekHareketleriListesi1Click(Sender: TObject);
    procedure btnHesapMakClick(Sender: TObject);
    procedure mnuMCEKTahsilClick(Sender: TObject);
    procedure mnuMSENTahsilClick(Sender: TObject);
    procedure mnuRaporCariBakiyeliHareketListesiClick(Sender: TObject);
    procedure mnuRaporAyBazindaCariBorcAlacakClick(Sender: TObject);
    procedure mnuRaporUrunListesiClick(Sender: TObject);
    procedure mnuRaporDepoUrunListesiClick(Sender: TObject);
    procedure mnuRaporDovizKurlariClick(Sender: TObject);
    procedure mnuRaporAylikKasaClick(Sender: TObject);
    procedure mnuRaporMusteriCekleriClick(Sender: TObject);
    procedure mnuRaporBorcCekleriClick(Sender: TObject);
    procedure mnuRaporMusteriSenetleriClick(Sender: TObject);
    procedure mnuRaporBorcSenetleriClick(Sender: TObject);
    procedure mnuRaporGenelProjeListesiClick(Sender: TObject);
    procedure mnuRaporProjeHareketleriListesiClick(Sender: TObject);
    procedure mnuRaporPlasiyerListesiClick(Sender: TObject);
    procedure mnuRaporPlasiyerHareketleriListesiClick(Sender: TObject);
    procedure mnuRaporCariListesiClick(Sender: TObject);
    procedure mnuMuhtelifTahsilTediyeClick(Sender: TObject);
    procedure mnuYaziciTasarimiClick(Sender: TObject);
    procedure mnuRaporGunlukKasaHareketClick(Sender: TObject);
    procedure mnuRaporKasaHareketClick(Sender: TObject);
    procedure Bor1Click(Sender: TObject);
    procedure mnuKasalarArasiTransferClick(Sender: TObject);
    procedure Rapor_Belge_Turu;
    procedure mnuRaporBelgeTuruClick(Sender: TObject);
    procedure BorekiadeAlmaDekontu1Click(Sender: TObject);
    procedure BorSenediadeAlmaDekontu1Click(Sender: TObject);
    procedure mnuCariHareketAktarimClick(Sender: TObject);
    procedure mnuDevirKayitlariClick(Sender: TObject);
    procedure mnuRaporSerbestDekontClick(Sender: TObject);
    procedure mnuRaporGrupBazindaCariBakiyeliHareketClick(Sender: TObject);
    procedure BorekiTediyesi1Click(Sender: TObject);
    procedure BorSenetiTediyesi1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SistemdenMteriekiSilme1Click(Sender: TObject);
    procedure SistemdenBorekiSilme1Click(Sender: TObject);
    procedure SistemdenMteriSenediSilme1Click(Sender: TObject);
    procedure SistemdenBorSenediSilme1Click(Sender: TObject);
    procedure mnuBakimIslemleriClick(Sender: TObject);
    procedure MteriSenediHareketleri1Click(Sender: TObject);
    procedure BorSenediHareketleri1Click(Sender: TObject);
    procedure mnuRaporCariHareketClick(Sender: TObject);
    procedure mnuBelgeYaziciClick(Sender: TObject);
    procedure mnuRaporTarihAralikliCariHareketClick(Sender: TObject);
    procedure mnuRaporAlisFaturasiClick(Sender: TObject);
    procedure mnuRaporSatisFaturasiClick(Sender: TObject);
    procedure mnuFatAyUrunRapClick(Sender: TObject);
    procedure mnuYeniMasrafClick(Sender: TObject);
    procedure mnuMasrafListesiClick(Sender: TObject);
    procedure mnuRaporMasrafListesiClick(Sender: TObject);
    procedure mnuRaporMasrafHareketleriListesiClick(Sender: TObject);
    procedure mnuBakiyeliMasrafHareketListesiClick(Sender: TObject);
    procedure YEN1Click(Sender: TObject);
    procedure YEN2Click(Sender: TObject);
    procedure Liste1Click(Sender: TObject);
    procedure mnuTERM_FFClick(Sender: TObject);
    procedure mnuPlasiyerTanimClick(Sender: TObject);
    procedure mnuPlasiyerListesiClick(Sender: TObject);
    procedure mnuProjeTanimlamaClick(Sender: TObject);
    procedure mnuProjeListesiClick(Sender: TObject);
    procedure mnuDepoTanmlamaClick(Sender: TObject);
    procedure mnuDepoListesiClick(Sender: TObject);
    procedure btnKULSIFClick(Sender: TObject);
    procedure mnuRaporKullaniciHakClick(Sender: TObject);
    procedure mnuYeniSirketClick(Sender: TObject);
    procedure YeniDnemTanmlama1Click(Sender: TObject);
    procedure BakiyeDevirlemleri1Click(Sender: TObject);
    procedure MasrafGruplar1Click(Sender: TObject);
    procedure KaytTarihlemleri1Click(Sender: TObject);
    procedure mnuDekontSablonClick(Sender: TObject);
    procedure mnuDekontSablonListesiClick(Sender: TObject);
    procedure mnuKapanmisProjeListesiClick(Sender: TObject);
    procedure mnuAcikProjeListesiClick(Sender: TObject);
    procedure mnuBasamaklaClick(Sender: TObject);
    procedure mnuDoseClick(Sender: TObject);
    procedure mnuIrsaliyeParametreleriClick(Sender: TObject);
    procedure mnuYeniAlisIrsaliyesiClick(Sender: TObject);
    procedure mnuYeniSatisIrsaliyesiClick(Sender: TObject);
    procedure mnuAlisIrsaliyesiListesiClick(Sender: TObject);
    procedure mnuSatisIrsaliyesiListesiClick(Sender: TObject);
    procedure YeniGelenSipari1Click(Sender: TObject);
    procedure GelenSipariListesi1Click(Sender: TObject);
    procedure YeniGidenSipari1Click(Sender: TObject);
    procedure GidenSipariListesi1Click(Sender: TObject);
    procedure MteriSipariiListesi1Click(Sender: TObject);
    procedure SatcSipariiListesi1Click(Sender: TObject);
    procedure Alrsaliyesi1Click(Sender: TObject);
    procedure Satrsaliyesi1Click(Sender: TObject);
    procedure Lisans1Click(Sender: TObject);
    procedure mnuMuhasebeRaporKodClick(Sender: TObject);
    procedure PaketGirii1Click(Sender: TObject);
    procedure PaketListesi1Click(Sender: TObject);
    procedure AraGirii1Click(Sender: TObject);
    procedure AraListesi1Click(Sender: TObject);
    procedure PersonelListesi1Click(Sender: TObject);
    procedure PersonelGirii1Click(Sender: TObject);
    procedure SeferGirii1Click(Sender: TObject);
    procedure MazotGiri1Click(Sender: TObject);
    procedure SeferListesi1Click(Sender: TObject);
    procedure MazotListesi1Click(Sender: TObject);
    procedure AraListesi2Click(Sender: TObject);
    procedure PersonelListesi2Click(Sender: TObject);
    procedure AraHareketleri1Click(Sender: TObject);
    procedure PersonelHareketleri1Click(Sender: TObject);
    procedure SeferListesi2Click(Sender: TObject);
    procedure MazotListesi2Click(Sender: TObject);
    procedure liiiKesilmiPersonelListesi1Click(Sender: TObject);
    procedure AraPersonelListesi1Click(Sender: TObject);
    procedure SeferKaytlarListesi1Click(Sender: TObject);
    procedure AlcyaFaturalanmamSeferKaytlar1Click(Sender: TObject);
    procedure SatcnnFaturalamadSeferKaytlar1Click(Sender: TObject);
    procedure MazotAraRaporu1Click(Sender: TObject);
    procedure FaturaSeferBalantlar1Click(Sender: TObject);
    procedure FaturaMazotBalantlar1Click(Sender: TObject);
    procedure MazotSeferBalantlar1Click(Sender: TObject);
    procedure rnFiyatListesi1Click(Sender: TObject);
    procedure rnHareketleri1Click(Sender: TObject);
    procedure SeferMazotBalantlar1Click(Sender: TObject);
    procedure SirketAralarMaliyetRaporu1Click(Sender: TObject);
    procedure KiralkKamyonAlacakRaporu1Click(Sender: TObject);
    procedure YeniAlFaturas1Click(Sender: TObject);
    procedure AlFaturasListesi2Click(Sender: TObject);
    procedure YeniSatFaturas2Click(Sender: TObject);
    procedure SatFaturasListesi2Click(Sender: TObject);
    procedure KirketGnlkSeferRaporu1Click(Sender: TObject);
    procedure KKiralkGnlkSeferRaporu1Click(Sender: TObject);
    procedure KToplamcmalRaporu1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuUrunMasrafTanimlamaClick(Sender: TObject);
    procedure SirketExpert1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure YeniYklemeFii1Click(Sender: TObject);
    procedure YklemeFiiListesi1Click(Sender: TObject);
    procedure YenifrTanmlama1Click(Sender: TObject);
    procedure frListesi1Click(Sender: TObject);
    procedure WebCamAyarlar1Click(Sender: TObject);
    procedure SfrListesi1Click(Sender: TObject);
    procedure PersonelHareketleriSeferden1Click(Sender: TObject);
    procedure amamlanmSeferler1Click(Sender: TObject);
    procedure amamlanmamSeferler1Click(Sender: TObject);
    procedure KiralkAraGnlkSeferRaporuTarihli1Click(Sender: TObject);
    procedure YeniBayiGirii1Click(Sender: TObject);
    procedure YeniSigortairketiGirii1Click(Sender: TObject);
    procedure YeniAraGirii1Click(Sender: TObject);
    procedure AraListesi3Click(Sender: TObject);
    procedure YeniArzaTipGirii1Click(Sender: TObject);
    procedure YeniAraMarkaGirii1Click(Sender: TObject);
    procedure BayiListesi1Click(Sender: TObject);
    procedure SigortairketiListesi1Click(Sender: TObject);
    procedure YeniOnarmFii1Click(Sender: TObject);
    procedure OnarmFiiListesi1Click(Sender: TObject);
    procedure YeniAlFaturas2Click(Sender: TObject);
    procedure AlFaturasListesi3Click(Sender: TObject);
    procedure YeniSatFaturas3Click(Sender: TObject);
    procedure SatFaturasListesi3Click(Sender: TObject);
    procedure OnarmFiiListesi2Click(Sender: TObject);
    procedure AraListesi4Click(Sender: TObject);
    procedure YeniGeliNedeni1Click(Sender: TObject);
    procedure ArzaTipiListesi1Click(Sender: TObject);
    procedure GeliNedeniListesi1Click(Sender: TObject);
    procedure MasrafGirii1Click(Sender: TObject);
    procedure MasrrafListesi1Click(Sender: TObject);
    procedure oplamMazotRaporu1Click(Sender: TObject);
    procedure YeniPlakaTanmlama1Click(Sender: TObject);
    procedure PlakaListesi1Click(Sender: TObject);
    procedure KantarGirii1Click(Sender: TObject);
    procedure GiriListesi1Click(Sender: TObject);
    procedure Kantark2Click(Sender: TObject);
    procedure kListesi1Click(Sender: TObject);
    procedure GiriListesi2Click(Sender: TObject);
    procedure kListesi2Click(Sender: TObject);
    procedure mnuESYAClick(Sender: TObject);
    procedure mnuKullaniciRaporlariClick(Sender: TObject);
    procedure SeferAyrntRaporu1Click(Sender: TObject);
    procedure mnuYeniAntrepoGirisFisiClick(Sender: TObject);
    procedure mnuGirsiFisiListesiClick(Sender: TObject);
    procedure mnuAntrepodakiMallarClick(Sender: TObject);
    procedure mnuANT_Cikis_fis_listClick(Sender: TObject);
    procedure mnuANT_TumHareketlerClick(Sender: TObject);
    procedure StokDefteri1Click(Sender: TObject);
    procedure mHareketDkm1Click(Sender: TObject);
    procedure GeiciDepolamaGirivekStokListesi1Click(Sender: TObject);
    procedure AntrepoGirivekStokListesi1Click(Sender: TObject);
    procedure ArdiyeGElirRaporu1Click(Sender: TObject);
    procedure BeyanTehlikesineGirenKalemler1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolBar1DblClick(Sender: TObject);
    procedure mnuSeferTakipClick(Sender: TObject);
  private
    FWallpaper: TBitmap;
    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure Sirket_Resim_Ara_Ac;

    { Private declarations }
  public
    { Public declarations }
  end;
var
  MainForm: TMainForm;

implementation
uses
  ufrmDovKart,
  unDataMod,
  ufrmDovTan,
  about,
  ufrmParameters,
  ufrmCariKart,
  ufrmCariGroup,
  ufrmProje,
  ufrmOlcuTip,
  ufrmDepo,
  ufrmCariSDLG,
  ufrmUrunSDLG,
  ufrmCek,
  ufrmPlasiyer,
  ufrmKasa,
  ufrmDEKONTT,
  ufrmDekontSDLG,
  ufrmFatParams,
  ufrmUrunTanA,
  ufrmSENET,
  ufrmCekSenSDLG,
  ufrmCEKSEN_CIRO,
  ufrmCEKSEN_IADE,
  ufrmSirketTanim,
  ufrmKulHakTanim,
  ufrmModul,
  ufrmSube,
  ufrmUrunGroup,
  ufrmKullaniciTanimlama,
  ufrmProgramHizmetleri,
  ufrmParametersTab,
  ufrmKASA_CARI,
  ufrmKasaSDGL,
  ufrmCekSenHarSDGL,
  unFunc,
  ufrmCEKSEN_KARS,
  ufrmCEKSEN_TAHSILVER,
  ufrmKASA_MUHTELIF,
  ufrmCEKSEN_BCEK_ODEME,
  ufrmKasalarArasiTransfer,
  ufrmCARHAR_AKT,
  ufrmDEVIRKAY,
  unCEKSENHAR,
  ufrmCEKSEN_KASA,
  ufrmCEKSEN_SIL,
  ufrmBELGE_YAZ,
  unYAZICI,
  ufrmRaporCariAylikBA,
  ufrmRaporCariBakiyeliHareket,
  ufrmRaporCariBakiyeliHareketTarihli,
  ufrmRaporCekSenet,
  ufrmRaporCiktisi,
  ufrmRaporDepoUrunListesi,
  ufrmRaporDovizKurlari,
  ufrmRaporGenelCariListesi,
  ufrmRaporGrupCBakiyeliHar,
  ufrmRaporKasaAralikliHareket,
  ufrmRaporKasaAylik,
  ufrmRaporKasaTekGunlukHareket,
  ufrmRaporPlasiyerHareketleri,
  ufrmRaporPlasiyerListesi,
  ufrmRaporProjeHAreketleri,
  ufrmRaporProjeListesi,
  ufrmRaporSerbestDekont,
  ufrmRaporUrunListesi,
  ufrmRaporCariBakiyeliHareketToplam,
  ufrmBAKIM,
  ufrmRaporUrunFatura,
  ufrmMasrafTan,
  ufrmRaporMasrafListesi,
  ufrmRaporMasrafHareket,
  ufrmRaporMasrafHareketTarihli,
  ufrmFAT_IRS,
  ufrmFAT_IRS_SDLG,
  ufrmTERM_FF,
  ufrmMAIN_NEW,
  unHARFUNCS, ufrmKulSifreDegis,
  ufrmRaporKullaniciHak,
  ufrmBakiyeDevret,
  unDmYonet,
  ufrmMasrafGroup,
  ufrmKayitTarihAyarla,
  ufrmDEKONT_AUT,
  unDEKONT_AUT,
  ufrmIRSALIYE, ufrmSiparis, ufrmSIP_SDLG,UnSec,
  ufrmMUHKODTanim, ufrmPaket, ufrmSirket_Expert,
  ufrmRaporUrunFiyatListesi,
  ufrmRaporUrunHareketleri,
  ufrmUrun_Masraf_Merkezi,
  {$IfDef TRANSPORT}
    ufrmArac, ufrmPersonel, ufrmSefer, ufrmMazot,
    ufrmSeferSDLG, ufrmMazotSDLG, ufrmRaporAracListesi,
    ufrmRaporPersonelListesi, ufrmRaporAracHareketleriListesi,
    ufrmRaporPersonelHareketleriListesi,
    ufrmRaporIlisigiKesilmisPersonelListesi, ufrmRaporAracPersonelListesi,
    ufrmRaporSefer, ufrmRaporMazotAracListesi, ufrmRaporFatura_Sefer,
    ufrmRaporFatura_Mazot, ufrmRaporSefer_Mazot,
    ufrmRaporSefer_Mazot1,
    ufrmRaporSkAracHareketleriRaporu, ufrmFAT_Tran, ufrmRaporSeferKasali,
    ufrmFoto_Ana,
    ufrmYukleme_Fisi, ufrmYuk_Fis_SDLG, ufrmSofor,
    ufrmRaporSoforListesi, ufrmRaporPersonelHareketleri_KasaliListesi,ufrnRAPOR_SEF_AYRINTI,
    ufrmArac_Masraf,
    ufrmAracMasrafSDGL,
    ufrmESYA_TAN,
    ufrmSefer_Takip,
  {$EndIf}

  {$IfDef SERVIS}
    ufrmRaporSrvAracListesi,
    ufrmArac_Marka,
    ufrmGelis_Neden,
    ufrmAriza,
    ufrmOnarim,
    ufrmOnarim_SDLG,
    ufrmFAT_Srv,
    ufrmBayi,
    ufrmSigorta,
    ufrmArac_Srv,
    ufrmRaporToplamArac,
  {$EndIf}
  ufrmFastRe_Giris,
  UDm_Fast_Report,
 {$IfDef KANTAR}
    ufrmPlaka,
    ufrm_Kantar,
    ufrm_Kantar_Sdlg,
  {$EndIf}

 {$IfDef ANTREPO}
  ufrmANT_GIRIS,
  ufrmANT_SDLG,
  ufrmANT_CIKIS,
  ufrmANT_REPORT,
 {$EndIf}
  ConvUtils, ufrmRaporToplamArac;
{$R *.DFM}

procedure TMainForm.Rapor_Belge_Turu();
var
  CHeader : TcxSSHeader;
  qryRapor :TIB_Cursor;
  belge_row,belge_col : Integer;
  CurCursor : TCursor;
begin
  DataMod.CreateCursor(qryRapor,nil,False,DataMod.dbaMain);
  with qryRapor do
  begin
    SQL.Add('SELECT BELGE_KOD');
    SQL.Add('      ,ADI');
    SQL.Add('FROM BELGETUR ORDER BY BELGE_TUR');
    Active := True;
  end;

  if (qryRapor.Eof and qryRapor.Bof) then
  begin
    Application.MessageBox('Tanýmlý hiçbir belge bulunamadý.','Dikkat',MB_ICONEXCLAMATION);
    DataMod.ReleaseCursor(qryRapor);
    exit;
  end
  else
  begin//start eof bof else
    belge_row := 0;
    belge_col := 0;
    CurCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      with frmRaporCiktisi do
      begin
        form_open();
        grdA.BeginUpdate;
        grdA.ActivePage := 0;
        SetCellText(belge_row,belge_col,'Belge Türü Raporu');
        SetCellFont(belge_col,belge_row,belge_col,belge_row,[fsBold],8,'MS Sans Serif',2);
        belge_row := 1;
        ////////////////////////////////////////////////////////////////////////
        //alan baþlýklarý yazýlýyor.
        ////////////////////////////////////////////////////////////////////////
        SetCellText(belge_row,belge_col,'Belge Kodu');
        SetCellText(belge_row,belge_col+1,'Belge Adý');
        SetCellFont(belge_col,belge_row,belge_col+1,belge_row,[fsBold],8,'MS Sans Serif',4);
      end;
      //////////////////////////////////////////////////////////////////////////
      belge_row := 2;
      qryRapor.First;
      while not qryRapor.Eof do
      begin
        with frmRaporCiktisi do
        begin
          SetCellText(belge_row,belge_col,qryRapor.FieldByName('BELGE_KOD').AsString);
          SetCellText(belge_row,belge_col+1,qryRapor.FieldByName('ADI').AsString);
        end;
        inc(belge_row);
        qryRapor.Next;
      end;
      CHeader := frmRaporCiktisi.grdA.ActiveSheet.Cols;
      CHeader.Size[0] := 120;
      CHeader.Size[1] := 200;
    finally
      frmRaporCiktisi.grdA.EndUpdate;
      frmRaporCiktisi.WindowState := wsMaximized;

      Screen.Cursor := CurCursor;
      DataMod.ReleaseCursor(qryRapor);
    end;//end try
  end;//end else eof bof
end;


function TMainForm.FindChildFrm( App : TApplication ; FrmName : String ): Boolean;
// Burak ÖZLER
// Amaç: MDI uygulamada adý geçen formu bulur ve daha önce açýlmýþsa gösterir
var
  ChildFrm : TComponent;
begin
  Result := False;
  ChildFrm := ( App.FindComponent(FrmName) );
  if ChildFrm <> nil then
  begin
    ( ChildFrm As TForm ).show;
    ( ChildFrm As TForm ).WindowState := wsNormal;
    Result:= True;
  end;
end;

function TMainForm.FindChildFrm1( App : TApplication ; FrmName : String ): Boolean;
// Burak ÖZLER
// Amaç: MDI uygulamada adý geçen formu bulur ve daha önce açýlmýþsa gösterir
var
  ChildFrm : TComponent;
begin
  Result := False;
  ChildFrm := ( App.FindComponent(FrmName) );
  if ChildFrm <> nil then
  begin
    //( ChildFrm As TForm ).show;
    //( ChildFrm As TForm ).WindowState := wsNormal;
    Result:= True;
  end;
end;


procedure TMainForm.HelpAbout1Execute(Sender: TObject);
begin
  Application.CreateForm(TAboutBox, AboutBox);
  AboutBox.ShowModal;
  AboutBox.Release;
end;

procedure TMainForm.mnuCariGruplariClick(Sender: TObject);
begin
  frmCariGroup.Form_Open(True);
end;

procedure TMainForm.lBirimleri1Click(Sender: TObject);
begin
  frmOlcuTip.Form_Open(True);
end;

procedure TMainForm.mnuDovizKartiClick(Sender: TObject);
begin
  frmDovKart.Form_Open(True);
end;

procedure TMainForm.mnuDovizTanimlamalariClick(Sender: TObject);
begin
  frmDovTan.Form_Open(True);
end;

procedure TMainForm.mnuParametrelerClick(Sender: TObject);
begin
  frmParameters.Form_Open(True);
end;

procedure TMainForm.muYeniCariTanimlamaClick(Sender: TObject);
begin
  frmCariKart.Form_Open(True,'',0);
end;

procedure TMainForm.mnuYeniUrunTanimlamaClick(Sender: TObject);
begin
  frmUrunTanA.Form_Open(True,'',0);
end;

procedure TMainForm.mnuUrunGrubuTanimlamaClick(Sender: TObject);
begin
  frmUrunGroup.Form_Open(True);
end;

procedure TMainForm.mnuDekontListClick(Sender: TObject);
var
  Dekont_ID,Dekont_SID:Integer;
begin
  if FindChildFrm( Application, 'frmDEKONTT') then
  begin
    Application.MessageBox ('Dekont Tanýmlama Formu açýk iken listeyi kullanamazsýnýz.','Dikkat', MB_ICONWARNING);
    exit;
  end;
  if frmDekontSDLG.Form_Open(True,Dekont_ID,Dekont_SID,1) then
  begin
    frmDEKONTT.Form_Open(True,Dekont_ID,Dekont_SID,1,1,True);
  end;
end;

procedure TMainForm.mnuMonitorClick(Sender: TObject);
begin
  DataMod.FBMon.Show;
end;

procedure TMainForm.mnuCariListeClick(Sender: TObject);
var
  CARI_KOD,CARI_AD:String;
begin
  if FindChildFrm(Application, 'frmCariKart') then
  begin
    Application.MessageBox('Cari formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if frmCariSDLG.Form_Open(True,CARI_KOD,CARI_AD,1) then
  begin
    frmCariKart.Form_Open(True,CARI_KOD,1);
  end;
end;

procedure TMainForm.mnuUrunListeClick(Sender: TObject);
var
  Urun_Kod,Urun_Ad:String;
begin
  if FindChildFrm(Application, 'frmUrunTanA') then
  begin
    Application.MessageBox ('Ürün formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if frmUrunSDLG.Form_Open(True,Urun_Kod,Urun_Ad,False) then
  begin
    frmUrunTanA.Form_Open(True,Urun_Kod,1);
  end;
end;

procedure TMainForm.mnuMusteriCekAKClick(Sender: TObject);
begin
  if FindChildFrm(Application,'frm_Cek') then
  begin
    Application.MessageBox('Çek formu açýk iken bu iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  frm_Cek.Form_Open(True,0,0,0,1,BT_MCEK_ALINDI,False);
end;

procedure TMainForm.mnuMusteriCekListesiClick(Sender: TObject);
var
  CekID,Cek_SID:Integer;
begin
  if FindChildFrm(Application,'frm_Cek') then
  begin
    Application.MessageBox('Çek formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmCekSenSDLG.Form_Open(True,1,CekID,Cek_SID,1,True,1,1) then
  begin
    frm_Cek.Form_Open(False,CekID,Cek_SID,1,1,6,False);
  end;
end;

procedure TMainForm.mnuBorcCekListesiClick(Sender: TObject);
var
  CekID,Cek_SID:Integer;
begin
  if FindChildFrm(Application,'frm_Cek') then
  begin
    Application.MessageBox('Çek formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmCekSenSDLG.Form_Open(True,1,CekID,Cek_SID,2,True,1,2) then
  begin
    frm_Cek.Form_Open(False,CekID,Cek_SID,1,2,4,False);
  end;
end;

procedure TMainForm.mnuBorcCekAKClick(Sender: TObject);
begin
  if FindChildFrm(Application,'frm_Cek') then
  begin
    Application.MessageBox('Çek formu açýk iken bu iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  frm_Cek.Form_Open(True,0,0,0,2,4,False);
end;

procedure TMainForm.mnuMusteriSenetleriListesiClick(Sender: TObject);
var
  SENET_ID,SENET_SID:Integer;
begin
  if FindChildFrm(Application, 'frmSENET') then
  begin
    Application.MessageBox('Senet formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmCekSenSDLG.Form_Open(True,2,SENET_ID,SENET_SID,1,True,1,1) then
  begin
    frmSENET.Form_Open(True,SENET_ID,SENET_SID,1,1,7,False);
  end;
end;

procedure TMainForm.mnuMusteriSenetleriAKClick(Sender: TObject);
begin
  if FindChildFrm(Application, 'frmSENET') then
  begin
    Application.MessageBox('Senet formu açýk iken bu iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  frmSenet.Form_Open(True,0,0,0,1,7,False);
end;

procedure TMainForm.mnuBorcSenetleriListesiClick(Sender: TObject);
var
  SENET_ID,SENET_SID:Integer;
begin
  if FindChildFrm(Application,'frmSENET') then
  begin
    Application.MessageBox ('Senet formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmCekSenSDLG.Form_Open(True,2,SENET_ID,SENET_SID,2,True,1,2) then
  begin
    frmSENET.Form_Open(True,SENET_ID,SENET_SID,1,2,18,False);
  end;
end;

procedure TMainForm.Yeni1Click(Sender: TObject);
begin
  frmFAT_IRS.Form_Open(True,1,0,0,0,2);
end;

procedure TMainForm.YeniSatFaturas1Click(Sender: TObject);
begin
  frmFAT_IRS.Form_Open(True,1,0,0,0,1);
end;

procedure TMainForm.SatFaturasListesi1Click(Sender: TObject);
//satýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if FindChildFrm(Application,'frmFAT_IRS') then
  begin
    Application.MessageBox ('Fatura formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,False) then
  begin
    frmFAT_IRS.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,1);
  end;

end;

procedure TMainForm.AlFaturasListesi1Click(Sender: TObject);
//alýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if FindChildFrm(Application,'frmFAT_IRS') then
  begin
    Application.MessageBox('Fatura formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,2,False) then
  begin
    frmFAT_IRS.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,2);
  end;
end;

procedure TMainForm.mnuFaturaParametreleriClick(Sender: TObject);
begin
  frmFatParams.Form_Open(True,1);
end;

procedure TMainForm.mnuGirsiFisiListesiClick(Sender: TObject);
var ANT_MAIN_ID,ANT_DETAIL_ID:Integer;
begin
 {$IfDef ANTREPO}
   if frmANT_SDLG.Form_Open(True,ANT_MAIN_ID,ANT_DETAIL_ID,1) then
   begin
     frmANT_GIRIS.Form_Open(True,ANT_MAIN_ID,ANT_DETAIL_ID);
   end;
  {$EndIf}
end;

procedure TMainForm.mnuBorcSenetleriAKClick(Sender: TObject);
begin
  if FindChildFrm(Application,'frmSENET') then
  begin
    Application.MessageBox('Senet formu açýk iken bu iþlemi yapamazsýnýz','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  frmSenet.Form_Open(True,0,0,0,2,18,False);
end;

procedure TMainForm.mnuYeniKasaClick(Sender: TObject);
begin
  frmKasa.Form_Open(True,'',0,14);
end;

procedure TMainForm.mnuKasaListesiClick(Sender: TObject);
var
  Kasa_Kod,Kasa_Ad,Dovkod:String;
begin
  if FindChildFrm(Application,'frmKasa') then
  begin
    Application.MessageBox('Kasa formu açýk iken bu iþlemi yapamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if DataMod.LS_KASA(Kasa_Kod,Kasa_Ad,Dovkod) then
  begin
    frmKasa.Form_Open(True,Kasa_Kod,1,14);
  end;
end;

procedure TMainForm.mnuMCEKCIROClick(Sender: TObject);
begin                              //ciro
  frmCEKSEN_CIRO.Form_Open(False,0,0,CEK,3);
end;

procedure TMainForm.mnuMSENETCIROClick(Sender: TObject);
begin                                //ciro
  frmCEKSEN_CIRO.Form_Open(False,0,0,SENET,3);
end;

procedure TMainForm.mnuBankadanGelenMCEKKarsiliksizClick(Sender: TObject);
begin
  //5- Tahsilden Gelen “Karþýlýksýz” Dekontu
  frmCEKSEN_KARS.Form_Open(True,0,0,CEK,5);
end;

procedure TMainForm.mnuSaticidanGelenMCEKKarsiliksizClick(Sender: TObject);
begin
  //6- Satýcýdan  Gelen “Karþýlýksýz”  Dekontu
  frmCEKSEN_KARS.Form_Open(True,0,0,CEK,6);
end;

procedure TMainForm.mnuPortfoydekiMCEKKarsiliksizClick(Sender: TObject);
begin
  //7- Portfoyde  “Karþýlýksýz” Dekontu
  frmCEKSEN_KARS.Form_Open(True,0,0,CEK,7);
end;

procedure TMainForm.mnuBankadanGelenMSENKarsiliksizClick(Sender: TObject);
begin
  //5- Tahsilden Gelen “Karþýlýksýz” Dekontu
  frmCEKSEN_KARS.Form_Open(True,0,0,SENET,5);
end;

procedure TMainForm.mnuSatGelenMSENKarsiliksizClick(Sender: TObject);
begin
  //6- Satýcýdan  Gelen “Karþýlýksýz”  Dekontu
  frmCEKSEN_KARS.Form_Open(True,0,0,SENET,6);
end;

procedure TMainForm.mnuPortfoydekiMSENKarsiliksizClick(Sender: TObject);
begin
  //7- Portfoyde  “Karþýlýksýz” Dekontu
  frmCEKSEN_KARS.Form_Open(True,0,0,SENET,7);
end;

procedure TMainForm.mnuSeferTakipClick(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmSefer_Takip.Form_Open(True,0,0,0);
 {$EndIf}
end;

procedure TMainForm.mnuSerbestDekontClick(Sender: TObject);
begin
  frmDEKONTT.Form_Open(True,0,0,0,1,False);
end;

procedure TMainForm.mnuBankGelenCekTahsilDekClick(Sender: TObject);
begin                              //tahsilden gelen tahsil dekontu
  frmCEKSEN_CIRO.Form_Open(True,0,0,CEK,4);
end;

procedure TMainForm.BankadanGelenMterisenediTahsildekontu1Click(
  Sender: TObject);
begin                                //tahsilden gelen tahsil dekontu
  frmCEKSEN_CIRO.Form_Open(True,0,0,SENET,4);
end;

procedure TMainForm.mnuMusCekIadeClick(Sender: TObject);
begin
  //müþteri çeki iade
  frmCEKSEN_IADE.Form_Open(True,0,0,CEK,BT_MCEK_IADE);
end;

procedure TMainForm.MteriSenediiadeilemi1Click(Sender: TObject);
begin
  //müþteri senedi iade
  frmCEKSEN_IADE.Form_Open(True,0,0,SENET,BT_MSEN_IADE);
end;

procedure TMainForm.mnuSirketTanimlamaClick(Sender: TObject);
begin
  frm_Sirket_Tanim.Form_Open(True,1);
end;

procedure TMainForm.mnuKullaniciHakClick(Sender: TObject);
begin
  frm_Kul_Hak_Tanim.Form_Open(True);
end;

procedure TMainForm.mnuKullaniciRaporlariClick(Sender: TObject);
begin
  if FindChildFrm(Application,'frmFastRe_Giris') then
  begin
    Application.MessageBox ('Rapor Tanýmlama Ekraný Açýk','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Application.CreateForm(TfrmFastRe_Giris, frmFastRe_Giris);
  frmFastRe_Giris.Show;
end;

procedure TMainForm.mnuModulTanimClick(Sender: TObject);
begin
  frmModul.Form_Open(True);
end;

procedure TMainForm.mnuSubeTanimlamaClick(Sender: TObject);
begin
  frm_Sube.Form_Open(True);
end;

procedure TMainForm.mnuSirketDegistirmeClick(Sender: TObject);
begin
  {if (FindChildFrm(Application,'frmFoto_Ana')) then
  begin
    frmFoto_Ana.FreeOnRelease;
    frmFoto_Ana.Destroy;
  end;
  }

  if MainForm.MDIChildCount <> 0 then
  begin
    Application.MessageBox('Þirket Deðiþtirebilmek için tüm modullerden çýkmalýsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  Application.CreateForm(TfrmMAIN_NEW,frmMAIN_NEW);
  frmMAIN_NEW.Form_Open(True);
  frmMAIN_NEW.Release;

 // Sirket_Resim_Ara_Ac;
 MainForm.FormShow(Self);
end;


procedure TMainForm.mnuKullaniciTanimlamaClick(Sender: TObject);
begin
  frm_Kullanici_Tanimlama.Form_Open(True);
end;

procedure TMainForm.mnuDizinlerClick(Sender: TObject);
begin
  if glb_YONETICI then
  begin
    Application.CreateForm(TfrmProgramHizmetleri, frmProgramHizmetleri);
    with frmProgramHizmetleri do
    begin
      Ayar_Yukle;
      ShowModal;
      Release;
    end;
  end
  else
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
end;

procedure TMainForm.mnuKodlamaParametreleriClick(Sender: TObject);
begin
  frmParametersTab.Form_Open(True);
end;

procedure TMainForm.mnuCariTahsilTediyeClick(Sender: TObject);
begin
  frmKASA_CARI.Form_Open(True,0,0,0);
end;

procedure TMainForm.SenetTahsilTediyesi1Click(Sender: TObject);
begin
  frmCEKSEN_KASA.Form_Open(True,0,0,SENET,9,1);
end;

procedure TMainForm.ekTahsilTediyesi1Click(Sender: TObject);
begin                               //9- Kasaya Tahsil
  frmCEKSEN_KASA.Form_Open(True,0,0,CEK,9,1);
end;

procedure TMainForm.mnuKasaHareketleriListesiClick(Sender: TObject);
var
  ISLEM_TIP,KASAHAR_ID,KASAHAR_SID:Integer;
  KASA_KOD,KASA_AD,KASA_DOVKOD:string;
begin
{
1- CARI
2- FATURA
3- SENET
4- ÇEK
5- MUHTELIF
6- TRANSFER FÝÞÝ
}
  if frmKasaSDGL.Form_Open(True,0, '' , ISLEM_TIP,KASAHAR_ID,KASAHAR_SID,KASA_KOD,KASA_AD,KASA_DOVKOD) then
  begin
    case ISLEM_TIP of
    1:
      begin
        frmKASA_CARI.Form_Open(True,KASAHAR_ID,KASAHAR_SID,1);
      end;
    3,4:
      begin
        //frmCEKSEN_KASA.Form_Open(True,KASAHAR_ID, KASAHAR_SID,0,1);
      end;
    5:
      begin
        frmKASA_MUHTELIF.Form_Open(True,KASAHAR_ID,KASAHAR_SID,1);
      end;
    6: frmKasalarArasiTransfer.Form_Open(True,KASAHAR_ID,KASAHAR_SID,1);
    end;//end case ISLEM_TIP of
  end;//end if
end;

procedure TMainForm.mnuCEK_HAR_LISTClick(Sender: TObject);
var
  ISLEM:Byte;
  CEKSENHAR_ID ,CEKSENHAR_SID,GELEN_BELGE_ID,GELEN_BELGE_SID: integer;
  qryTemp : TIB_Query;
begin
//müþteri çek hareketleri listesi
  if frmCekSenHarSDGL.Form_Open(True,
                                CEK
                                ,1
                                ,-1
                                ,FALSE
                                ,0
                                ,0
                                ,ISLEM
                                ,CEKSENHAR_ID
                                ,CEKSENHAR_SID) then
  begin
    case ISLEM of
      1://ALIM
        begin
          DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
          qryTemp.SQL.Add('SELECT BELGE_ID,BELGE_SID FROM CEKSENHAR WHERE CEKSENHAR_ID =' + inttostr(CEKSENHAR_ID) + ' AND CEKSENHAR_SID='+inttostr(CEKSENHAR_SID));
          qryTemp.Active := True;
          GELEN_BELGE_ID := qryTemp.Fieldbyname('BELGE_ID').AsInteger;
          GELEN_BELGE_SID := qryTemp.Fieldbyname('BELGE_SID').AsInteger;
          DataMod.ReleaseQuery(qryTemp);
          frm_Cek.Form_Open(True,GELEN_BELGE_ID,GELEN_BELGE_SID,1,1,BT_MCEK_ALINDI,False);
        end;
      2://tahsile verme
        begin
          frmCEKSEN_TAHSILVER.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK);
        end;
      3://CÝROLAMA
        begin
          frmCEKSEN_CIRO.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,3);
        end;
      4://TAHSÝLDEN GELEN TAHSÝL DEKONTU
        begin
          frmCEKSEN_CIRO.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,4);
        end;
      5://TAHSÝLDEN GELEN KARÞILIKSIZ DEKONTU
        begin
          frmCEKSEN_KARS.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,5);
        end;
      6://SATICIDAN GELEN KARÞILIKSIZ DEKONTU
        begin
          frmCEKSEN_KARS.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,6);
        end;
      7://PORTFOYDE KARÞILIKSIZ DEKONTU
        begin
          frmCEKSEN_KARS.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,7);
        end;
      8://PORTFOYDE IADE DEKONTU
        begin
          //müþteri çeki iade
          frmCEKSEN_IADE.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,BT_MCEK_IADE);
        end;
      9://KASAYA TAHSÝL
        begin
          //9- Kasaya Tahsil
          frmCEKSEN_KASA.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,9,1);
        end;
      end;//END CASE ISLEM OF
    end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MainForm.MDIChildCount <> 0 then
  begin

  if MainForm.MDIChildCount=1 then
  if (FindChildFrm(Application,'frmFoto_Ana')) then
  begin
    CanClose := True;
    Exit;
  end;

    Application.MessageBox('Programdan çýkmak için, açýk olan tüm modullerden çýkmalýsýnýz','Dikkat',MB_ICONWARNING);
    CanClose := False;
  end;
end;


procedure TMainForm.BorekHareketleriListesi1Click(Sender: TObject);
var
  ISLEM : Byte;
  CEKSENHAR_ID , CEKSENHAR_SID : integer;
  GELEN_BELGE_ID , GELEN_BELGE_SID : integer;
  qryTemp : TIB_Query;
begin
//borç çek hareketleri listesi
  if frmCekSenHarSDGL.Form_Open(True,
                                CEK
                                ,2
                                ,-1
                                ,TRUE
                                ,0
                                ,0
                                ,ISLEM
                                ,CEKSENHAR_ID
                                ,CEKSENHAR_SID) then
  begin
    case ISLEM of
    15://VERÝM
      begin
        DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
        qryTemp.SQL.Add('SELECT BELGE_ID,BELGE_SID FROM CEKSENHAR WHERE CEKSENHAR_ID =' + inttostr(CEKSENHAR_ID) + ' AND CEKSENHAR_SID='+inttostr(CEKSENHAR_SID));
        qryTemp.Active := True;
        GELEN_BELGE_ID := qryTemp.Fieldbyname('BELGE_ID').AsInteger;
        GELEN_BELGE_SID := qryTemp.Fieldbyname('BELGE_SID').AsInteger;
        DataMod.ReleaseQuery(qryTemp);
        frm_Cek.Form_Open(True,GELEN_BELGE_ID,GELEN_BELGE_SID,1,2,BT_BORC_CEK,False);
      end;
    16://ÝADE DEKONTU
      begin
        frmCEKSEN_IADE.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,BT_BORC_CEK_IADE);
      end;
    17://BANKADAN BORÇ ÇEKÝ ÖDEME
      begin
        frmCEKSEN_BCEK_ODEME.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID);
      end;
    18://KASADAN ÇEK/SENET ÖDEME
      begin
        //borç çeki tediyesi
        frmCEKSEN_KASA.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,CEK,9,2);
      end;
    end;//END CASE ISLEM OF
  end;//end if
end;

procedure TMainForm.btnHesapMakClick(Sender: TObject);
begin
{  if ((glb_PLATFORM = 'WIN9X') or (glb_PLATFORM = 'WINME')) then
     ExecNewProcess(glb_WINDOWS_DIR + '\calc.exe', False)
  else
     ExecNewProcess(glb_SYSTEM_DIR + '\calc.exe', False);}
  ShellExecute(Handle,'open',PChar('Calc.Exe'),nil,nil,SW_SHOWNORMAL);
end;

procedure TMainForm.mnuMCEKTahsilClick(Sender: TObject);
begin
  frmCEKSEN_TAHSILVER.Form_Open(True,0,0,CEK);
end;

procedure TMainForm.mnuMSENTahsilClick(Sender: TObject);
begin
  frmCEKSEN_TAHSILVER.Form_Open(True,0,0,SENET);
end;

procedure TMainForm.mnuRaporCariBakiyeliHareketListesiClick(Sender: TObject);
begin
  frmRaporCariBakiyeliHareket.Form_Open(True);
end;

procedure TMainForm.mnuRaporAyBazindaCariBorcAlacakClick(Sender: TObject);
begin
  frmRaporCariAylikBA.Form_Open;
end;

procedure TMainForm.mnuRaporUrunListesiClick(Sender: TObject);
begin
  frmRaporUrunListesi.Form_Open;
end;

procedure TMainForm.mnuRaporDepoUrunListesiClick(Sender: TObject);
begin
  frmRaporDepoUrunListesi.Form_Open;
end;

procedure TMainForm.mnuRaporDovizKurlariClick(Sender: TObject);
begin
  frmRaporDovizKurlari.Form_Open;
end;

procedure TMainForm.mnuRaporAylikKasaClick(Sender: TObject);
begin
  frmRaporKasaAylik.Form_Open;
end;

procedure TMainForm.mnuRaporMusteriCekleriClick(Sender: TObject);
begin
  frmRaporCekSenet.Form_Open(1);
end;

procedure TMainForm.mnuRaporBorcCekleriClick(Sender: TObject);
begin
  frmRaporCekSenet.Form_Open(2);
end;

procedure TMainForm.mnuRaporMusteriSenetleriClick(Sender: TObject);
begin
  frmRaporCekSenet.Form_Open(3);
end;

procedure TMainForm.mnuRaporBorcSenetleriClick(Sender: TObject);
begin
  frmRaporCekSenet.Form_Open(4);
end;

procedure TMainForm.mnuRaporGenelProjeListesiClick(Sender: TObject);
begin
  frmRaporProjeListesi.Form_Open;
end;

procedure TMainForm.mnuRaporProjeHareketleriListesiClick(Sender: TObject);
begin
  frmRaporProjeHareketleri.Form_Open;
end;

procedure TMainForm.mnuRaporPlasiyerListesiClick(Sender: TObject);
begin
  frmRaporPlasiyerListesi.Form_Open;
end;

procedure TMainForm.mnuRaporPlasiyerHareketleriListesiClick(Sender: TObject);
begin
  frmRaporPlasiyerHareketleri.Form_Open;
end;

procedure TMainForm.mnuRaporCariListesiClick(Sender: TObject);
begin
  frmRaporGenelCariListesi.Form_Open;
end;

procedure TMainForm.mnuMuhtelifTahsilTediyeClick(Sender: TObject);
begin
  frmKASA_MUHTELIF.Form_Open(True,0,glb_SID,0);
end;

procedure TMainForm.mnuYaziciTasarimiClick(Sender: TObject);
begin
//þubelerde tezcan ve bülent'in yazýcý dizayn ayarlarýný yapabilmeleri için
//geçici bir süre bu kod kapatýldý
  if not glb_YONETICI then
  begin
    Application.MessageBox('Yetkiniz yok.','Dikkat',MB_ICONWARNING);
    exit;
  end;
//****************************************************************************//
  if mainform.MDIChildCount = 0 then exit;
//****************************************************************************//
  {$IfDef TRANSPORT}
  if MainForm.ActiveMDIChild = frmFAT_Tran then
  begin
    if (frmFAT_Tran.qryFAT_IRS.State in [dssInsert])  then
    begin
      Application.MessageBox('Yeni kayýt durumunda tasarým yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    if frmFAT_Tran.qryFAT_IRS.State = dssPrepared then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.Fatura(frmFAT_Tran.qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger,frmFAT_Tran.qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger,4,1,frmFAT_Tran.qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);
  end
  else
  if MainForm.ActiveMDIChild = frmYukleme_Fisi then
  begin
    if (frmYukleme_Fisi.Prn_Id = 0) and (frmYukleme_Fisi.Prn_Sid = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.YUKLEME_FISI(frmYukleme_Fisi.prn_ID,frmYukleme_Fisi.prn_Sid,4);
  end;

  {$EndIf}
  if MainForm.ActiveMDIChild = frmFAT_IRS then
  begin
    if (frmFAT_IRS.qryFAT_IRS.State in [dssInsert])  then
    begin
      Application.MessageBox('Yeni kayýt durumunda tasarým yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    if frmFAT_IRS.qryFAT_IRS.State = dssPrepared then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.Fatura(frmFAT_IRS.qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger,frmFAT_IRS.qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger,4,1,frmFAT_IRS.qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);
  end
  else


  if MainForm.ActiveMDIChild = frmIRSALIYE then
  begin
    if (frmIRSALIYE.qryFAT_IRS.State in [dssInsert])  then
    begin
      Application.MessageBox('Yeni kayýt durumunda tasarým yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    if frmIRSALIYE.qryFAT_IRS.State = dssPrepared then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.Fatura(frmIRSALIYE.qryFAT_IRS.FieldByName('FAT_IRS_ID').AsInteger,frmIRSALIYE.qryFAT_IRS.FieldByName('FAT_IRS_SID').AsInteger,4,2,frmIRSALIYE.qryFAT_IRS.FieldByName('SEVK_ADRES_KOD').AsString);
  end
  else
  if MainForm.ActiveMDIChild = frmSIPARIS then
  begin
    if (frmSIPARIS.qrySiparis.State in [dssInsert])  then
    begin
      Application.MessageBox('Yeni kayýt durumunda tasarým yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    if frmSIPARIS.qrySiparis.State = dssPrepared then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.SIPARIS(frmSIPARIS.qrySiparis.FieldByName('FAT_IRS_ID').AsInteger,frmSIPARIS.qrySiparis.FieldByName('FAT_IRS_SID').AsInteger,1);
  end
  else
  if MainForm.ActiveMDIChild = frmDEKONTT then
  begin
    if frmDEKONTT.qryDEKONT.State = dssINSERT then
    begin
      Application.MessageBox('Yeni kayýt durumunda tasarým yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    if frmDEKONTT.qryDEKONT.State = dssPrepared then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.Dekont(frmDEKONTT.qryDEKONT.FieldByName('DEKONT_ID').AsInteger,frmDEKONTT.qryDEKONT.FieldByName('DEKONT_SID').AsInteger,4);
  end
  else
  if MainForm.ActiveMDIChild = frmKASA_MUHTELIF then
  begin
    if frmKASA_MUHTELIF.qryKASAHAR_MAS.State = dssINSERT then
    begin
      Application.MessageBox('Kayýt Ekleme Halinde tasarým yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    if frmKASA_MUHTELIF.qryKASAHAR_MAS.State = dssPrepared then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.KASAMUHTELIF(frmKASA_MUHTELIF.qryKASAHAR_MAS.FieldByName('KASAHAR_ID').AsInteger,frmKASA_MUHTELIF.qryKASAHAR_MAS.FieldByName('KASAHAR_SID').AsInteger,4);
  end
  else
  if MainForm.ActiveMDIChild = frmKASA_CARI then
  begin
    if frmKASA_CARI.qryKASAHAR.State = dssINSERT then
    begin
      Application.MessageBox('Kayýt Ekleme Halinde tasarým yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    if frmKASA_CARI.qryKASAHAR.State = dssPrepared then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.KASACARI(frmKASA_CARI.qryKASAHAR.FieldByName('KASAHAR_ID').AsInteger,frmKASA_CARI.qryKASAHAR.FieldByName('KASAHAR_SID').AsInteger,4);
  end
  else
  if MainForm.ActiveMDIChild = frm_Cek then
  begin
    if frm_Cek.qry_Cek.State = dssINSERT then
    begin
      Application.MessageBox('Kayýt Ekleme Halinde tasarým yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    if frm_Cek.qry_Cek.State = dssPrepared then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    case frm_Cek.prv_CekTip of
    1:Yazici.MUSTERICEKI(frm_Cek.qry_Cek.FieldByName('CEK_ID').AsInteger,frm_Cek.qry_Cek.FieldByName('CEK_SID').AsInteger,4);
    2:Yazici.BORCCEKI(frm_Cek.qry_Cek.FieldByName('CEK_ID').AsInteger,frm_Cek.qry_Cek.FieldByName('CEK_SID').AsInteger,4);
    end;
  end
  else
  if MainForm.ActiveMDIChild = frmCekIadeDekontu then
  begin
    if (frmCekIadeDekontu.prnCEKSENHARID = 0) and (frmCekIadeDekontu.prnCEKSENHARSID = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.MCEKIADE(frmCekIadeDekontu.prnCEKSENHARID,frmCekIadeDekontu.prnCEKSENHARSID,4);
  end
  else
  if MainForm.ActiveMDIChild = frmBorcCekIadeDekontu then
  begin
    if (frmBorcCekIadeDekontu.prnCEKSENHARID = 0) and (frmBorcCekIadeDekontu.prnCEKSENHARSID = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.BCEKIADE(frmBorcCekIadeDekontu.prnCEKSENHARID,frmBorcCekIadeDekontu.prnCEKSENHARSID,4);
  end
  else
  if MainForm.ActiveMDIChild = frmKasayaTahsilEdilenCek then
  begin
    if (frmKasayaTahsilEdilenCek.prnCEKSENHARID = 0) and (frmKasayaTahsilEdilenCek.prnCEKSENHARSID = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.KASAYACEKTAHSILI(frmKasayaTahsilEdilenCek.prnCEKSENHARID,frmKasayaTahsilEdilenCek.prnCEKSENHARSID,4);
  end
  else
  if MainForm.ActiveMDIChild = frmKasadanTediyeEdilenCek then
  begin
    if (frmKasadanTediyeEdilenCek.prnCEKSENHARID = 0) and (frmKasadanTediyeEdilenCek.prnCEKSENHARSID = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.KASADANCEKTEDIYESI(frmKasadanTediyeEdilenCek.prnCEKSENHARID,frmKasadanTediyeEdilenCek.prnCEKSENHARSID,4);
  end
  else
  if MainForm.ActiveMDIChild = frmKasadanTediyeEdilenSenet then
  begin
    if (frmKasadanTediyeEdilenSenet.prnCEKSENHARID = 0) and (frmKasadanTediyeEdilenSenet.prnCEKSENHARSID = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    //Yazici.KASACEKSENET(frmKasadanTediyeEdilenSenet.prnCEKSENHARID,frmKasadanTediyeEdilenSenet.prnCEKSENHARSID,4);
  end
  else
  if MainForm.ActiveMDIChild = frmKasayaTahsilEdilenSenet then
  begin
    if (frmKasayaTahsilEdilenSenet.prnCEKSENHARID = 0) and (frmKasayaTahsilEdilenSenet.prnCEKSENHARSID = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    //Yazici.KASACEKSENET(frmKasayaTahsilEdilenSenet.prnCEKSENHARID,frmKasayaTahsilEdilenSenet.prnCEKSENHARSID,4);
  end
  else
  if MainForm.ActiveMDIChild = frmKasalarArasiTransfer then
  begin
    if (frmKasalarArasiTransfer.prnBELGEID = 0) and (frmKasalarArasiTransfer.prnBELGESID = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.KASATRANSFER(frmKasalarArasiTransfer.prnBELGEID,frmKasalarArasiTransfer.prnBELGESID,4);
  end
  else
  if MainForm.ActiveMDIChild = frmCEKSEN_BCEK_ODEME then
  begin
    if (frmCEKSEN_BCEK_ODEME.prnCEKSENHARID = 0) and (frmCEKSEN_BCEK_ODEME.prnCEKSENHARSID = 0) then
    begin
      Application.MessageBox('Belge bilgisi olmadan düzenleme yapýlamaz.','Dikkat',MB_ICONWARNING);
      Exit;
    end;
    Yazici.BCEKODEME(frmCEKSEN_BCEK_ODEME.prnCEKSENHARID,frmCEKSEN_BCEK_ODEME.prnCEKSENHARSID,4);
  end;


end;

procedure TMainForm.mnuRaporGunlukKasaHareketClick(Sender: TObject);
begin
  frmRaporKasaTekGunlukHareket.Form_Open;
end;

procedure TMainForm.mnuRaporKasaHareketClick(Sender: TObject);
begin
  frmRaporKasaAralikliHareket.Form_Open;
end;

procedure TMainForm.Bor1Click(Sender: TObject);
begin
  frmCEKSEN_BCEK_ODEME.Form_Open(True,0,0);
end;

procedure TMainForm.mnuKasalarArasiTransferClick(Sender: TObject);
begin
  frmKasalarArasiTransfer.Form_Open(True,0,0,0);
end;

procedure TMainForm.mnuRaporBelgeTuruClick(Sender: TObject);
begin
  Rapor_Belge_Turu();
end;

procedure TMainForm.BorekiadeAlmaDekontu1Click(Sender: TObject);
begin
  //borç çeki iade
  frmCEKSEN_IADE.Form_Open(True,0,0,CEK,BT_BORC_CEK_IADE);
end;

procedure TMainForm.BorSenediadeAlmaDekontu1Click(Sender: TObject);
begin
  //borç senedi iade
  frmCEKSEN_IADE.Form_Open(True,0,0,SENET,BT_BORC_SEN_IADE);
end;

procedure TMainForm.mnuCariHareketAktarimClick(Sender: TObject);
begin
  frmCARHAR_AKT.Form_Open(True);
end;

procedure TMainForm.mnuDevirKayitlariClick(Sender: TObject);
begin
  frmDEVIRKAY.Form_Open(True);
end;

procedure TMainForm.mnuRaporSerbestDekontClick(Sender: TObject);
begin
  frmRaporSerbestDekont.Form_Open;
end;

procedure TMainForm.mnuRaporGrupBazindaCariBakiyeliHareketClick(Sender: TObject);
begin
  frmRaporGrupCBakiyeliHar.Form_Open;
end;

procedure TMainForm.BorekiTediyesi1Click(Sender: TObject);
begin
  frmCEKSEN_KASA.Form_Open(True,0,0,CEK,9,2);
end;

procedure TMainForm.BorSenetiTediyesi1Click(Sender: TObject);
begin
  frmCEKSEN_KASA.Form_Open(True,0,0,SENET,9,2);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin

  REG_STATUS(false);
 {$IfDef TAM}
     mnuPaket.Visible := True;
     mnuSiparis.Visible := True;
     mnuRaporSiparis.Visible := True;
  {$Else}
     mnuPaket.Visible := False;
     mnuSiparis.Visible := False;
     mnuRaporSiparis.Visible := False;
  {$EndIf}

  {$IfDef DEPO}
     mnuDepo.Visible := True;
     mnuRaporDepo.Visible := True;
  {$Else}
     mnuDepo.Visible := False;
     mnuRaporDepo.Visible := False;
  {$EndIf}

  {$IfDef PROJE}
     mnuProje.Visible := True;
     mnuRaporProje.Visible := True;
  {$Else}
     mnuProje.Visible := False;
     mnuRaporProje.Visible := False;
  {$EndIf}

  {$IfDef PLASIYER}
     mnuPlasiyer.Visible := True;
     mnuRaporPlasiyer.Visible := True;
  {$Else}
     mnuPlasiyer.Visible := False;
     mnuRaporPlasiyer.Visible := False;
  {$EndIf}

  {$IfDef CEK}
     mnuCek.Visible := True;
     mnuRaporCek.Visible := True;
  {$Else}
     mnuCek.Visible := False;
     mnuRaporCek.Visible := False;
  {$EndIf}


  {$IfDef SENET}
     mnuSenet.Visible := True;
     mnuRaporSenet.Visible := True;
  {$Else}
     mnuSenet.Visible := False;
     mnuRaporSenet.Visible := False;
  {$EndIf}

  {$IfDef URUNDEKONTU}
     mnuUrunDekontu.Visible := True;
  {$Else}
     mnuUrunDekontu.Visible := False;
  {$EndIf}


  {$IfnDef TRANSPORT}
     mnuArac.Visible := False;
     mnuPersonel.Visible := False;
     mnuSefer.Visible := False;
     mnuMazot.Visible := False;
     mnuRaporMazot.Visible := False;
     mnuRaporSefer.Visible := False;
     mnuRaporPersonel.Visible := False;
     mnuRaporArac.Visible := False;
     mnuFatura_Tran.Visible := False;
     mnuUrunMasrafTanimlama.Visible := False;
     mnuSofor.Visible := False;
     mnuRaporSofor.Visible := False;
     mnuYuklemeFisi.Visible := False;
     mnuAracMasraf.Visible := False;
     mnuESYA.Visible := False;
     Lbl_Nerede.Visible := False;
  {$EndIf}

  {$IfDef TRANSPORT}
     mnuDepo.Visible := False;
     mnuRaporDepo.Visible := False;
     mnuFatura.Visible := False;
     mnuCek.Visible := False;
     mnuSenet.Visible := False;
     mnuRaporCek.Visible := False;
     mnuRaporSenet.Visible := False;
     mnuRaporProje.Visible := False;
     mnuProje.Visible := False;
     mnuPaket.Visible := False;
     mnuPlasiyer.Visible := False;
     mnuSiparis.Visible := False;
     mnuIrsaliye.Visible := False;
     mnuRaporPlasiyer.Visible := False;
     mnuRaporIrsaliye.Visible := False;
     mnuRaporSiparis.Visible := False;
     mnuIrsaliyeParametreleri.Visible := False;
     mnuRaporBelgeTuru.Visible := False;
  {$EndIf}

  {$IfDef SERVIS}
     mnuRaporProje.Visible := False;
     mnuProje.Visible := False;
     mnuPlasiyer.Visible := False;
     mnuRaporPlasiyer.Visible := False;
     mnuArac.Visible := False;
     mnuFatura.Visible := False;

     mnuSiparis.Visible := False;
     mnuIrsaliye.Visible := False;
     mnuRaporIrsaliye.Visible := False;
     mnuRaporSiparis.Visible := False;

     mnuGelisNedeni.Visible := True;
    mnuSrv_Arac.Visible := True;
    mnuBayi.Visible := True;
    mnuSigorta.Visible := True;
    mnuAraMarka.Visible := True;
    mnuPersonel.Visible := True;
    mnuArizaTipleri.Visible := True;
    mnuOnarmFisi.Visible := True;
    MnuFatura_srv.Visible := True;
    mnuRaporOnarim.Visible := True;
    mnuRapor_Srv_Arac.Visible := True;

  {$EndIf}

  {$IfDef KANTAR}
     mnuCek.Visible := False;
     mnuSenet.Visible := False;
     mnuDekont.Visible := False;
     mnuKasaHareket.Visible := False;
     mnuRaporCek.Visible := False;
     mnuRaporSenet.Visible := False;
     //mnuRaporKasa.Visible := False;
     mnuRaporMasraf.Visible := False;
     mnuRaporSerbestDekont.Visible := False;

     mnuMasraf.Visible := False;
     mnuPaket.Visible := False;

     mnuRaporProje.Visible := False;
     mnuProje.Visible := False;
     mnuPlasiyer.Visible := False;
     mnuRaporPlasiyer.Visible := False;
     mnuArac.Visible := False;
     //mnuFatura.Visible := False;

     mnuSiparis.Visible := False;
     //mnuIrsaliye.Visible := False;
     //mnuRaporIrsaliye.Visible := False;
     mnuRaporSiparis.Visible := False;

     mnuPlaka.Visible := True;
     mnuKantar.Visible := True;
     mnuPersonel.Visible := True;
     //mnuBayi.Visible := True;
  {$EndIf}

  {$IfDef ANTREPO}
     mnuANTREPO.Visible := True;
     mnuAntrepoRap.Visible := True;
  {$Else}
     mnuANTREPO.Visible := False;
     mnuAntrepoRap.Visible := False;
  {$EndIf}
  MainForm.StatusBar.Panels[4].Text := 'Ver :'+ IntToStr(VER_MAJOR)+ '.' + IntToStr(VER_MINOR)+ '.' + IntToStr(VER_RELEASE);
end;

procedure TMainForm.SistemdenMteriekiSilme1Click(Sender: TObject);
begin
  frmCEKSEN_SIL.FORM_OPEN(True,0,0,CEK,1);
end;

procedure TMainForm.SistemdenBorekiSilme1Click(Sender: TObject);
begin
  frmCEKSEN_SIL.FORM_OPEN(True,0,0,CEK,2);
end;

procedure TMainForm.SistemdenMteriSenediSilme1Click(Sender: TObject);
begin
  frmCEKSEN_SIL.FORM_OPEN(True,0,0,SENET,1);
end;

procedure TMainForm.StokDefteri1Click(Sender: TObject);
begin
   {$IfDef ANTREPO}
      frmANT_REPORT.Form_Open(3);
   {$EndIf}
end;

procedure TMainForm.SistemdenBorSenediSilme1Click(Sender: TObject);
begin
  frmCEKSEN_SIL.FORM_OPEN(True,0,0,SENET,2);
end;

procedure TMainForm.mnuBakimIslemleriClick(Sender: TObject);
begin
  frmBAKIM.Form_Open(True);
end;

procedure TMainForm.MteriSenediHareketleri1Click(Sender: TObject);
var
  ISLEM : Byte;
  CEKSENHAR_ID , CEKSENHAR_SID : integer;
  GELEN_BELGE_ID , GELEN_BELGE_SID : integer;
  qryTemp : TIB_Query;
begin
//müþteri seneti hareketleri listesi
  if frmCekSenHarSDGL.Form_Open(True,
                                SENET
                                ,1
                                ,-1
                                ,TRUE
                                ,0
                                ,0
                                ,ISLEM
                                ,CEKSENHAR_ID
                                ,CEKSENHAR_SID) then
  begin
    case ISLEM of
    1://ALIM
      begin
        DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
        qryTemp.SQL.Add('SELECT BELGE_ID,BELGE_SID FROM CEKSENHAR WHERE CEKSENHAR_ID =' + inttostr(CEKSENHAR_ID) + ' AND CEKSENHAR_SID='+inttostr(CEKSENHAR_SID));
        qryTemp.Active := True;
        GELEN_BELGE_ID := qryTemp.Fieldbyname('BELGE_ID').AsInteger;
        GELEN_BELGE_SID := qryTemp.Fieldbyname('BELGE_SID').AsInteger;
        DataMod.ReleaseQuery(qryTemp);
        frmSenet.Form_Open(True,GELEN_BELGE_ID,GELEN_BELGE_SID,1,1,BT_MSEN_ALINDI,False);
      end;
    2://tahsile verme
      begin
        frmCEKSEN_TAHSILVER.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET);
      end;
    3://CÝROLAMA
      begin
        frmCEKSEN_CIRO.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,3);
      end;
    4://TAHSÝLDEN GELEN TAHSÝL DEKONTU
      begin
        frmCEKSEN_CIRO.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,4);
      end;
    5://TAHSÝLDEN GELEN KARÞILIKSIZ DEKONTU
      begin
        frmCEKSEN_KARS.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,5);
      end;
    6://SATICIDAN GELEN KARÞILIKSIZ DEKONTU
      begin
        frmCEKSEN_KARS.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,6);
      end;
    7://PORTFOYDE KARÞILIKSIZ DEKONTU
      begin
        frmCEKSEN_KARS.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,7);
      end;
    8://PORTFOYDE IADE DEKONTU
      begin
        //müþteri çeki iade
        frmCEKSEN_IADE.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,BT_MSEN_IADE);
      end;
    9://KASAYA TAHSÝL
      begin
        //9- Kasaya Tahsil
        frmCEKSEN_KASA.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,9,1);
      end;
    end;//END CASE ISLEM OF
  end;//end if
end;

procedure TMainForm.BorSenediHareketleri1Click(Sender: TObject);
var
  ISLEM : Byte;
  CEKSENHAR_ID ,CEKSENHAR_SID : integer;
  GELEN_BELGE_ID,GELEN_BELGE_SID : integer;
  qryTemp : TIB_Query;
begin
//borç çek hareketleri listesi
  if frmCekSenHarSDGL.Form_Open(True,
                                SENET
                                ,2
                                ,-1
                                ,TRUE
                                ,0
                                ,0
                                ,ISLEM
                                ,CEKSENHAR_ID
                                ,CEKSENHAR_SID) then
  begin
    case ISLEM of
    15://VERÝM
      begin
        DataMod.CreateQuery(qryTemp,Nil,False,DataMod.dbaMain);
        qryTemp.SQL.Add('SELECT BELGE_ID,BELGE_SID FROM CEKSENHAR WHERE CEKSENHAR_ID =' + inttostr(CEKSENHAR_ID) + ' AND CEKSENHAR_SID='+inttostr(CEKSENHAR_SID));
        qryTemp.Active := True;
        GELEN_BELGE_ID := qryTemp.Fieldbyname('BELGE_ID').AsInteger;
        GELEN_BELGE_SID := qryTemp.Fieldbyname('BELGE_SID').AsInteger;
        DataMod.ReleaseQuery(qryTemp);
        frmSenet.Form_Open(True,GELEN_BELGE_ID,GELEN_BELGE_SID,1,2,BT_BORC_SEN,False);
      end;
    16://ÝADE DEKONTU
      begin
        frmCEKSEN_IADE.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,BT_BORC_SEN_IADE);
      end;
    18://KASADAN ÇEK/SENET ÖDEME
      begin
        frmCEKSEN_KASA.Form_Open(True,CEKSENHAR_ID,CEKSENHAR_SID,SENET,9,2);
      end;
    end;//END CASE ISLEM OF
  end;//end if
end;

procedure TMainForm.mnuRaporCariHareketClick(Sender: TObject);
begin
  frmRaporCariBakiyeliHareketTarihli.Form_Open;
end;

procedure TMainForm.mnuBelgeYaziciClick(Sender: TObject);
begin
  frmBELGE_YAZ.Form_Open(True);
end;

procedure TMainForm.mnuRaporTarihAralikliCariHareketClick(Sender: TObject);
begin
  frmRaporCariBakiyeliHareketToplam.Form_Open;
end;

procedure TMainForm.mnuRaporAlisFaturasiClick(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,2,True);
end;

procedure TMainForm.mnuRaporSatisFaturasiClick(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,True);
end;

procedure TMainForm.mnuFatAyUrunRapClick(Sender: TObject);
begin
  frmRaporUrunFatura.Form_Open();
end;

procedure TMainForm.mnuYeniMasrafClick(Sender: TObject);
begin
  frmMasrafTan.Form_Open(True,'',0);
end;

procedure TMainForm.mnuMasrafListesiClick(Sender: TObject);
var
  MasrafKod : string;
begin
  if DataMod.LS_MASRAFTAN(MasrafKod) then
  begin
    frmMasrafTan.Form_Open(True,MasrafKod,1);
  end;
end;

procedure TMainForm.mnuRaporMasrafListesiClick(Sender: TObject);
begin
  frmRaporMasrafListesi.Form_Open;
end;

procedure TMainForm.mnuRaporMasrafHareketleriListesiClick(Sender: TObject);
begin
  frmRaporMasrafHareket.Form_Open;
end;

procedure TMainForm.mnuBakiyeliMasrafHareketListesiClick(Sender: TObject);
begin
  frmRaporMasrafHareketTarihli.Form_Open;
end;

procedure TMainForm.YEN1Click(Sender: TObject);
begin
  frmFAT_IRS.Form_Open(True,1,0,0,0,1);
end;

procedure TMainForm.YEN2Click(Sender: TObject);
begin
  frmFAT_IRS.Form_Open(True,1,0,0,0,2);
end;

procedure TMainForm.Liste1Click(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if FindChildFrm( Application, 'frmFAT_IRS') then
  begin
    Application.MessageBox ('Fatura Formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,False) then
  begin
    frmFAT_IRS.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,1);
  end;
end;

procedure TMainForm.mnuTERM_FFClick(Sender: TObject);
begin
  frmTERM_FF.Form_Open(True,1);
end;

procedure TMainForm.mnuPlasiyerTanimClick(Sender: TObject);
begin
  frmPlasiyer.Form_Open(True,'',1);
end;

procedure TMainForm.mnuPlasiyerListesiClick(Sender: TObject);
var
  PLASIYER_KOD,PLASIYER_AD:String;
begin
  if DataMod.LS_Plasiyer(PLASIYER_KOD,PLASIYER_AD,0) then
  begin
    frmPlasiyer.Form_Open(True,PLASIYER_KOD,0);
  end;
end;

procedure TMainForm.mnuProjeTanimlamaClick(Sender: TObject);
begin
  frmProje.Form_Open(True,'',1);
end;

procedure TMainForm.mnuDepoTanmlamaClick(Sender: TObject);
begin
  frmDepo.Form_Open(True,'',1);
end;

procedure TMainForm.mnuDepoListesiClick(Sender: TObject);
var
  DEPO_KOD,DEPO_AD:String;
begin
  if DataMod.LS_Depo(DEPO_KOD,DEPO_AD) then
  begin
    frmDepo.Form_Open(True,DEPO_KOD,0);
  end;
end;

procedure TMainForm.btnKULSIFClick(Sender: TObject);
begin
  frmKulSifreDegis.Form_Open;
end;

procedure TMainForm.mnuRaporKullaniciHakClick(Sender: TObject);
begin
  frmRaporKullaniciHak.Form_Open();
end;

procedure TMainForm.mnuYeniSirketClick(Sender: TObject);
begin
  frm_Sirket_Tanim.Form_Open(True,0);
end;

procedure TMainForm.YeniDnemTanmlama1Click(Sender: TObject);
begin
  frmTERM_FF.Form_Open(True,0);
end;

procedure TMainForm.BakiyeDevirlemleri1Click(Sender: TObject);
begin
  frmBakiyeDevret.Form_Open;
end;

procedure TMainForm.MasrafGruplar1Click(Sender: TObject);
begin
  frmMasrafGroup.Form_Open(True);
end;

procedure TMainForm.KaytTarihlemleri1Click(Sender: TObject);
begin
  frmKayitTarihAyarla.Form_Open(True);
end;

procedure TMainForm.mnuDekontSablonClick(Sender: TObject);
begin
  frmDEKONT_AUT.Form_Open(True,0,0,0,True);
end;

procedure TMainForm.mnuDekontSablonListesiClick(Sender: TObject);
var
  ID,SID : Integer;
begin
  if FindChildFrm( Application, 'frmDEKONT_AUT') then
  begin
    Application.MessageBox ('Dekont þablonu tanýmlama formu açýk iken listeyi kullanamazsýnýz.','Dikkat', MB_ICONWARNING);
    exit;
  end;

  if DataMod.LS_DEKONT_AUT(ID,SID) then
  begin
    frmDEKONT_AUT.Form_Open(True,ID,SID,1,True);
  end;

end;

procedure TMainForm.mnuProjeListesiClick(Sender: TObject);
var
  PROJE_KOD,PROJE_AD:String;
begin
//Tüm Projeler
  if DataMod.LS_Proje(PROJE_KOD,PROJE_AD,0) then
  begin
    frmProje.Form_Open(True,PROJE_KOD,0);
  end;
end;

procedure TMainForm.mHareketDkm1Click(Sender: TObject);
begin
   {$IfDef ANTREPO}
      frmANT_REPORT.Form_Open(4);
   {$EndIf}
end;

procedure TMainForm.mnuAcikProjeListesiClick(Sender: TObject);
var
  PROJE_KOD,PROJE_AD:String;
begin
//Açýk Projeler
  if DataMod.LS_Proje(PROJE_KOD,PROJE_AD,1) then
  begin
    frmProje.Form_Open(True,PROJE_KOD,0);
  end;
end;

procedure TMainForm.mnuKapanmisProjeListesiClick(Sender: TObject);
var
  PROJE_KOD,PROJE_AD:String;
begin
//Kapanmýþ Projeler
  if DataMod.LS_Proje(PROJE_KOD,PROJE_AD,2) then
  begin
    frmProje.Form_Open(True,PROJE_KOD,0);
  end;
end;

procedure TMainForm.mnuBasamaklaClick(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.mnuDoseClick(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.mnuIrsaliyeParametreleriClick(Sender: TObject);
begin
  frmFatParams.Form_Open(True,2);
end;

procedure TMainForm.mnuYeniAlisIrsaliyesiClick(Sender: TObject);
begin
  frmIRSALIYE.Form_Open(True,2,0,0,0,2);
end;

procedure TMainForm.mnuYeniSatisIrsaliyesiClick(Sender: TObject);
begin
  frmIRSALIYE.Form_Open(True,2,0,0,0,1);
end;

procedure TMainForm.mnuAlisIrsaliyesiListesiClick(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if FindChildFrm(Application,'frmIRSALIYE') then
  begin
    Application.MessageBox('Ýrsaliye formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,2,FAT_IRS_ID,FAT_IRS_SID,2,False) then
  begin
    frmIRSALIYE.Form_Open(True,2,FAT_IRS_ID,FAT_IRS_SID,1,2);
  end;
end;


procedure TMainForm.mnuAntrepodakiMallarClick(Sender: TObject);
var ANT_MAIN_ID,ANT_DETAIL_ID:Integer;
begin
   {$IfDef ANTREPO}
     frmANT_SDLG.Form_Open(True,ANT_MAIN_ID,ANT_DETAIL_ID,3);
   {$EndIf}
end;

procedure TMainForm.mnuANT_Cikis_fis_listClick(Sender: TObject);
var ANT_MAIN_ID,ANT_DETAIL_ID:Integer;
begin
 {$IfDef ANTREPO}
  if frmANT_SDLG.Form_Open(True,ANT_MAIN_ID,ANT_DETAIL_ID,2) then
    frmANT_CIKIS.Form_Open(True,ANT_MAIN_ID,glb_SID,ANT_DETAIL_ID);
 {$EndIf}
end;

procedure TMainForm.mnuANT_TumHareketlerClick(Sender: TObject);
var ANT_MAIN_ID,ANT_DETAIL_ID:Integer;
begin
   {$IfDef ANTREPO}
     frmANT_SDLG.Form_Open(True,ANT_MAIN_ID,ANT_DETAIL_ID,4);
  {$EndIf}
end;

procedure TMainForm.mnuSatisIrsaliyesiListesiClick(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if FindChildFrm(Application,'frmIRSALIYE') then
  begin
    Application.MessageBox('Ýrsaliye formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,2,FAT_IRS_ID,FAT_IRS_SID,1,False) then
  begin
    frmIRSALIYE.Form_Open(True,2,FAT_IRS_ID,FAT_IRS_SID,1,1);
  end;
end;

procedure TMainForm.YeniGelenSipari1Click(Sender: TObject);
begin
  frmSiparis.Form_Open(True,1,0,0,0,1);
end;

procedure TMainForm.GeiciDepolamaGirivekStokListesi1Click(Sender: TObject);
begin
 {$IfDef ANTREPO}
   frmANT_REPORT.Form_Open(1);
 {$EndIf}
end;

procedure TMainForm.GelenSipariListesi1Click(Sender: TObject);
//alýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if FindChildFrm(Application,'frmSiparis') then
  begin
    Application.MessageBox('Sipariþ formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmSIP_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,False) then
  begin
    frmSiparis.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,1);
  end;

end;

procedure TMainForm.YeniGidenSipari1Click(Sender: TObject);
begin
  frmSiparis.Form_Open(True,1,0,0,0,2);
end;

procedure TMainForm.GidenSipariListesi1Click(Sender: TObject);
//satýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  if FindChildFrm(Application,'frmSiparis') then
  begin
    Application.MessageBox ('Sipariþ formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmSIP_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,2,False) then
  begin
    frmSiparis.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,2);
  end;

end;

procedure TMainForm.MteriSipariiListesi1Click(Sender: TObject);
//alýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  frmSIP_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,True);
end;

procedure TMainForm.SatcSipariiListesi1Click(Sender: TObject);
//satýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  frmSIP_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,2,True);
end;

procedure TMainForm.Alrsaliyesi1Click(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  frmFAT_IRS_SDLG.Form_Open(True,2,FAT_IRS_ID,FAT_IRS_SID,2,True);
end;

procedure TMainForm.Satrsaliyesi1Click(Sender: TObject);
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
  frmFAT_IRS_SDLG.Form_Open(True,2,FAT_IRS_ID,FAT_IRS_SID,1,True);
end;


procedure TMainForm.Lisans1Click(Sender: TObject);
begin
  REG_STATUS(True);
end;

procedure TMainForm.mnuMuhasebeRaporKodClick(Sender: TObject);
begin
  frmMUHKODTanim.Form_Open(True);
end;

procedure TMainForm.PaketGirii1Click(Sender: TObject);
begin
 frmPaket.Form_Open(True,'',0,0);
end;

procedure TMainForm.PaketListesi1Click(Sender: TObject);
var
  PAKET_KOD,PAKET_ADI:String;
begin
  if FindChildFrm(Application, 'frmPaket') then
  begin
    Application.MessageBox ('Paket formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if datamod.LS_Paket(PAKET_KOD,PAKET_ADI) then
  begin
    frmPaket.Form_Open(True,PAKET_KOD,0,1);
  end;


end;





procedure TMainForm.rnFiyatListesi1Click(Sender: TObject);
begin
  frmRaporUrunFiyatListesi.Form_Open;
end;

procedure TMainForm.rnHareketleri1Click(Sender: TObject);
begin
  frmRaporUrunHareketleri.Form_Open();
end;





procedure TMainForm.mnuUrunMasrafTanimlamaClick(Sender: TObject);
begin
  frmUrun_Masraf_Merkezi.Form_Open(True);
end;

procedure TMainForm.SirketExpert1Click(Sender: TObject);
begin
     Application.CreateForm(TfrmSirket_Expert,frmSirket_Expert);
     frmSirket_Expert.ShowModal;
end;

procedure TMainForm.ToolBar1DblClick(Sender: TObject);
begin
    YeniDnemTanmlama1.Visible:=True;
    BakiyeDevirlemleri1.Visible:=True;
end;

procedure TMainForm.ToolButton3Click(Sender: TObject);
begin
//     Application.CreateForm(TfrmFoto_Ana,frmFoto_Ana);
end;


procedure TMainForm.FormShow(Sender: TObject);
var
a:Integer;
begin
//     Caption:='Ceda Yazýlým   Kara Nakliyat Programý' + '                 Aktif Þirket :           ' +glb_SIRKET_ADI;

//     Application.CreateForm(TfrmFoto_Ana,frmFoto_Ana);



  {if OpenDialog1.Execute then
  begin
    FWallpaper.LoadFromFile(OpenDialog1.FileName);
    Invalidate;
  end;
  }
   if glb_SIRKET_ID>0 then
   begin
   qry_Sirket.Active:=False;
   qry_Sirket.ParamByName('PRM_SIRKET_ID').AsInteger:=glb_SIRKET_ID;
   qry_Sirket.Active:=True;

   a:=Pos(' ',qry_Sirket.FieldByName('SIRKET_AD').AsString);
   if a<=1 then
   a:=Length(qry_Sirket.FieldByName('SIRKET_AD').AsString);
   lbl_Sirket_Adi.Caption:=
   Copy(
    qry_Sirket.FieldByName('SIRKET_AD').AsString,1,a);

   if glb_SERVER_NAME<>'' then
   Lbl_Nerede.Caption:='Ofis'
   else
   Lbl_Nerede.Caption:='Laptop';

   qry_Sirket.Active:=False;



   end;
{
qry_Sirket.FieldByName('LOGO').SaveToFile(glb_WINDOWS_DIR+'\sirket.bmp');

//  IB_Image1
    if not Assigned(FWallpaper) then
      FWallpaper := TBitmap.Create;

   FWallpaper.LoadFromFile(glb_WINDOWS_DIR+'\sirket.bmp');

       MainForm.Invalidate;   }
end;




procedure TMainForm.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
var
  row, col: Integer;
begin
  if not Assigned(FWallpaper) then
    inherited
  else
  begin
    {for Row := 0 to ClientHeight div FWallpaper.Height do
      for Col := 0 to ClientWidth div FWallpaper.Width do}
    for Row := 0 to  FWallpaper.Height do
      for Col := 0 to FWallpaper.Width do

        BitBlt(Msg.Dc,
          Col * FWallpaper.Width,
          Row * FWallpaper.Height,
          FWallpaper.Width,
          FWallpaper.Height,
          FWallpaper.Canvas.Handle,
          0,
          0,
          SRCCOPY);
    Msg.Result := 1;
  end;
end;



procedure TMainForm.FormDblClick(Sender: TObject);
begin
 { if not FindChildFrm(Application,'frmFoto_Ana') then
     Application.CreateForm(TfrmFoto_Ana,frmFoto_Ana); }

{
    if not Assigned(FWallpaper) then
      FWallpaper := TBitmap.Create;

   FWallpaper.LoadFromFile(glb_WINDOWS_DIR+'\sirket.bmp');



       MainForm.Invalidate;
}


//Yazici.get_is('ddd');
end;






procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Shift=[ssCtrl,ssAlt,ssShift] then
begin
  if key=VK_SPACE then
  begin
    YeniDnemTanmlama1.Visible:=True;
    BakiyeDevirlemleri1.Visible:=True;
  end;
end;

end;



// TRANSPORT
  procedure TMainForm.mnuESYAClick(Sender: TObject);
  begin
   {$IfDef TRANSPORT}
     frmESYA_TAN.Form_Open(True);
   {$EndIf}
  end;

  procedure TMainForm.Sirket_Resim_Ara_Ac;
  begin
   {$IfDef TRANSPORT}
    if (FindChildFrm(Application,'frmFoto_Ana')) then
    begin
      frmFoto_Ana.FreeOnRelease;
      frmFoto_Ana.Destroy;
      Application.CreateForm(TfrmFoto_Ana,frmFoto_Ana);
    end
    else
    begin
      Application.CreateForm(TfrmFoto_Ana,frmFoto_Ana);
    end;
   {$EndIf}
  end;
  procedure TMainForm.AntrepoGirivekStokListesi1Click(Sender: TObject);
begin
 {$IfDef ANTREPO}
   frmANT_REPORT.Form_Open(2);
 {$EndIf}
end;

procedure TMainForm.AraGirii1Click(Sender: TObject);
  begin
   {$IfDef TRANSPORT}
    frmArac.Form_Open(True,'',1);
    {$EndIf}
  end;

  procedure TMainForm.AraListesi1Click(Sender: TObject);
  var
   ARAC_KOD:String;
   PLAKA:String;
   CARI_KOD:String;
   PERSONEL_KOD:String;
   OZ_MAL:Integer;
   DORSE_KOD:String;
  begin
   {$IfDef TRANSPORT}
    if DataMod.LS_Arac(ARAC_KOD,PLAKA,CARI_KOD,PERSONEL_KOD,OZ_MAL, DORSE_KOD,0,'') then
    begin
      frmArac.Form_Open(True,ARAC_KOD,0);
    end;
    {$EndIf}
  end;

procedure TMainForm.PersonelListesi1Click(Sender: TObject);
var
  PERSONEL_KOD,PERSONEL_AD:String;
begin
 {$IfDef TRANSPORT}
  if DataMod.LS_Personel(PERSONEL_KOD,PERSONEL_AD) then
  begin
    frmPersonel.Form_Open(True,PERSONEL_KOD,0);
  end;
   {$EndIf}
end;

procedure TMainForm.PersonelGirii1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmPersonel.Form_Open(True,'',1);
 {$EndIf}
end;

procedure TMainForm.SeferAyrntRaporu1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
   frnRAPOR_SEF_AYRINTI.Form_Open;
  {$EndIf}
end;

procedure TMainForm.SeferGirii1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmSefer.Form_Open(True,0,0,0);
 {$EndIf}
end;

procedure TMainForm.MazotGiri1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmMazot.Form_Open(True,0,0,0);
 {$EndIf}
end;

procedure TMainForm.SeferListesi1Click(Sender: TObject);
var
  SEFER_ID,SEFER_SID:Integer;
begin
 {$IfDef TRANSPORT}
  if FindChildFrm(Application,'frmSefer') then
  begin
    Application.MessageBox('Sefer formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmSeferSDLG.Form_Open(True,SEFER_ID,SEFER_SID,False) then
  begin
    frmSefer.Form_Open(True,SEFER_ID,SEFER_SID,1);
  end;
  {$EndIf}
end;

procedure TMainForm.MazotListesi1Click(Sender: TObject);
var
  MAZOT_FIS_ID,MAZOT_FIS_SID:Integer;
begin
 {$IfDef TRANSPORT}
  if FindChildFrm(Application,'frmMazot') then
  begin
    Application.MessageBox('Mazot Fiþi formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmMazotSDLG.Form_Open(True,MAZOT_FIS_ID,MAZOT_FIS_SID,False) then
  begin
    frmMazot.Form_Open(True,MAZOT_FIS_ID,MAZOT_FIS_SID,1);
  end;
  {$EndIf}
end;
procedure TMainForm.AraListesi2Click(Sender: TObject);
begin
   {$IfDef TRANSPORT}
  frmRaporAracListesi.Form_Open;
   {$EndIf}
end;

procedure TMainForm.PersonelListesi2Click(Sender: TObject);
begin
  {$IfDef TRANSPORT}
  frmRaporPersonelListesi.Form_Open;
   {$EndIf}
end;

procedure TMainForm.AraHareketleri1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmRaporAracHareketleriListesi.Form_Open;
   {$EndIf}
end;

procedure TMainForm.PersonelHareketleri1Click(Sender: TObject);
begin
  {$IfDef TRANSPORT}
  frmRaporPersonelHareketleriListesi.Form_Open;
   {$EndIf}
end;

procedure TMainForm.SeferListesi2Click(Sender: TObject);
var
  SEFER_ID,SEFER_SID:Integer;
begin
 {$IfDef TRANSPORT}
  if FindChildFrm(Application,'frmSefer') then
  begin
    Application.MessageBox('Sefer formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmSeferSDLG.Form_Open(True,SEFER_ID,SEFER_SID,True) then
  begin
    frmSefer.Form_Open(True,SEFER_ID,SEFER_SID,1);
  end;
   {$EndIf}
end;

procedure TMainForm.MazotListesi2Click(Sender: TObject);
var
  MAZOT_FIS_ID,MAZOT_FIS_SID:Integer;
begin
 {$IfDef TRANSPORT}
  if FindChildFrm(Application,'frmMazot') then
  begin
    Application.MessageBox('Mazot Fiþi formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmMazotSDLG.Form_Open(True,MAZOT_FIS_ID,MAZOT_FIS_SID,True) then
  begin
    frmMazot.Form_Open(True,MAZOT_FIS_ID,MAZOT_FIS_SID,1);
  end;
   {$EndIf}
end;

procedure TMainForm.liiiKesilmiPersonelListesi1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
     Application.CreateForm(TfrmRaporIlisigiKesilmisPersonelListesi,frmRaporIlisigiKesilmisPersonelListesi);
     frmRaporIlisigiKesilmisPersonelListesi.Free;
 {$EndIf}
end;

procedure TMainForm.AraPersonelListesi1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
     Application.CreateForm(TfrmRaporAracPersonelListesi,frmRaporAracPersonelListesi);
     frmRaporAracPersonelListesi.Free;
   {$EndIf}
end;

procedure TMainForm.ArdiyeGElirRaporu1Click(Sender: TObject);
begin
 {$IfDef ANTREPO}
  frmANT_REPORT.Ardiye_Open;
{$EndIf}
end;

procedure TMainForm.SeferKaytlarListesi1Click(Sender: TObject);
begin
//sefer kayýtlarý raporu
 {$IfDef TRANSPORT}
    frmRaporSefer.Form_Open(0);
  {$EndIf}
end;

procedure TMainForm.AlcyaFaturalanmamSeferKaytlar1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
//alýcýya faturalanmamýþ
    frmRaporSefer.Form_Open(1);
  {$EndIf}
end;

procedure TMainForm.SatcnnFaturalamadSeferKaytlar1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
//satýcýný faturalamdýgý
    frmRaporSefer.Form_Open(2);
 {$EndIf}
end;

procedure TMainForm.MazotAraRaporu1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
    frmRaporMazotAracListesi.Form_Open();
  {$EndIf}
end;

procedure TMainForm.FaturaSeferBalantlar1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
 
     Application.CreateForm(TfrmRaporFatura_Sefer,frmRaporFatura_Sefer);
     //frmRaporFatura_Sefer.Free;
  {$EndIf}
end;

procedure TMainForm.FaturaMazotBalantlar1Click(Sender: TObject);
begin
   {$IfDef TRANSPORT}
     Application.CreateForm(TfrmRaporFatura_Mazot,frmRaporFatura_Mazot);
   {$EndIf}
end;

procedure TMainForm.MazotSeferBalantlar1Click(Sender: TObject);
begin
  {$IfDef TRANSPORT}
    Application.CreateForm(TfrmRaporSefer_Mazot,frmRaporSefer_Mazot);
  {$EndIf}
end;

procedure TMainForm.SeferMazotBalantlar1Click(Sender: TObject);
begin
  {$IfDef TRANSPORT}
     Application.CreateForm(TfrmRaporSefer_Mazot1,frmRaporSefer_Mazot1);
  {$EndIf}
end;

procedure TMainForm.SirketAralarMaliyetRaporu1Click(Sender: TObject);
begin
  {$IfDef TRANSPORT}
       frmRaporSkAracHareketleriRaporu.Form_Open('Sirket');
  {$EndIf}
end;

procedure TMainForm.KiralkKamyonAlacakRaporu1Click(Sender: TObject);
begin
  {$IfDef TRANSPORT}
    frmRaporSkAracHareketleriRaporu.Form_Open('Kiralýk');
  {$EndIf}
end;

procedure TMainForm.YeniAlFaturas1Click(Sender: TObject);
begin
  {$IfDef TRANSPORT}
    frmFAT_Tran.Form_Open(True,1,0,0,0,2);
  {$EndIf}
end;

procedure TMainForm.AlFaturasListesi2Click(Sender: TObject);
//alýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
{$IfDef TRANSPORT}
  if FindChildFrm(Application,'frmFAT_Tran') then
  begin
    Application.MessageBox('Fatura formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,2,False) then
  begin
    frmFAT_Tran.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,2);
  end;
  {$EndIf}
end;

procedure TMainForm.YeniSatFaturas2Click(Sender: TObject);
begin
{$IfDef TRANSPORT}
  frmFAT_Tran.Form_Open(True,1,0,0,0,1);
 {$EndIf}
end;

procedure TMainForm.SatFaturasListesi2Click(Sender: TObject);
//satýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
{$IfDef TRANSPORT}
  if FindChildFrm(Application,'frmFAT_Tran') then
  begin
    Application.MessageBox ('Fatura formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,False) then
  begin
    frmFAT_Tran.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,1);
  end;
 {$EndIf}
end;

procedure TMainForm.KirketGnlkSeferRaporu1Click(Sender: TObject);
begin
{$IfDef TRANSPORT}
    frmRaporSeferKasali.Form_Open(1);
{$EndIf}
end;

procedure TMainForm.KKiralkGnlkSeferRaporu1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
    frmRaporSeferKasali.Form_Open(2);
 {$EndIf}
end;

procedure TMainForm.KToplamcmalRaporu1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
    frmRaporSeferKasali.Form_Open(3);
 {$EndIf}
end;
procedure TMainForm.YeniYklemeFii1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmYukleme_Fisi.Form_Open(True,0,1);
 {$EndIf}
end;

procedure TMainForm.YklemeFiiListesi1Click(Sender: TObject);
var
  ID,SID:Integer;
begin
 {$IfDef TRANSPORT}
  {if DataMod.LS_Komisyon(ID) then
  begin
  end;
  }
  if frmYuk_Fis_SDLG.Form_Open(False,Id,Sid) then
  begin
    frmYukleme_Fisi.Form_Open(True,Id,0);
  end;
 {$EndIf}
end;

procedure TMainForm.YenifrTanmlama1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmSofor.Form_Open(True,'',1);
  {$EndIf}
end;

procedure TMainForm.frListesi1Click(Sender: TObject);
var
  SOFOR_KOD,SOFOR_AD:String;
begin
 {$IfDef TRANSPORT}
  if DataMod.LS_Sofor(SOFOR_KOD,SOFOR_AD) then
  begin
    frmSofor.Form_Open(True,SOFOR_KOD,0);
  end;
   {$EndIf}
end;

procedure TMainForm.WebCamAyarlar1Click(Sender: TObject);
begin
{  Application.CreateForm(TfrmSettings, frmSettings);
  frmSETTINGS.ShowModal;
  frmSettings.Release;  }
end;

procedure TMainForm.SfrListesi1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmRaporSoforListesi.Form_Open;
  {$EndIf}
end;

procedure TMainForm.PersonelHareketleriSeferden1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmRaporPersonelHareketleri_KasaliListesi.Form_Open;
  {$EndIf}
end;

procedure TMainForm.amamlanmSeferler1Click(Sender: TObject);
var
  SEFER_ID,SEFER_SID:Integer;
begin
 {$IfDef TRANSPORT}
  if FindChildFrm(Application,'frmSefer') then
  begin
    Application.MessageBox('Sefer formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmSeferSDLG.Form_Open(True,SEFER_ID,SEFER_SID,False,'1') then
  begin
    frmSefer.Form_Open(True,SEFER_ID,SEFER_SID,1);
  end;
  {$EndIf}
end;

procedure TMainForm.amamlanmamSeferler1Click(Sender: TObject);
var
  SEFER_ID,SEFER_SID:Integer;
begin
 {$IfDef TRANSPORT}
  if FindChildFrm(Application,'frmSefer') then
  begin
    Application.MessageBox('Sefer formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmSeferSDLG.Form_Open(True,SEFER_ID,SEFER_SID,False,'0') then
  begin
    frmSefer.Form_Open(True,SEFER_ID,SEFER_SID,1);
  end;
 {$EndIf}
end;

procedure TMainForm.KiralkAraGnlkSeferRaporuTarihli1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
    frmRaporSeferKasali.Form_Open(4);
  {$EndIf}
end;

 procedure TMainForm.MasrafGirii1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
  frmArac_Masraf.Form_Open(True,0,0,0);
  {$EndIf}
end;

procedure TMainForm.MasrrafListesi1Click(Sender: TObject);
var
   ARACHAR_ID, ARACHAR_SID: Integer;
begin
 {$IfDef TRANSPORT}
  if frmAracMAsrafSDGL.Form_Open(True,ARACHAR_ID,ARACHAR_SID) then
  begin
       frmARAC_MASRAF.Form_Open(True,ARACHAR_ID,ARACHAR_SID,1);
  end;
   {$EndIf}
end;



//SERVISLE ILGILI FONKSIYONLAR
procedure TMainForm.YeniBayiGirii1Click(Sender: TObject);
begin
 {$IfDef SERVIS}
  frmBayi.Form_Open(True,'',1);
 {$EndIf}
end;


procedure TMainForm.YeniSigortairketiGirii1Click(Sender: TObject);
begin
 {$IfDef SERVIS}
  frmSigorta.Form_Open(True,'',1);
 {$EndIf}
end;

procedure TMainForm.YeniAraGirii1Click(Sender: TObject);
begin
 {$IfDef SERVIS}
  frmArac_Srv.Form_Open(True,'',1);
  {$EndIf}
end;

procedure TMainForm.AraListesi3Click(Sender: TObject);
var
 ARAC_KOD:String;
 PLAKA:String;
 CARI_KOD:String;
 SASI_NO:String;
 MARKA_TIP:String;
begin
 {$IfDef SERVIS}
  if DataMod.LS_Arac_Srv(ARAC_KOD,PLAKA,CARI_KOD,SASI_NO,MARKA_TIP,'') then
  begin
    frmArac_srv.Form_Open(True,ARAC_KOD,0);
  end;
   {$EndIf}
end;

procedure TMainForm.YeniArzaTipGirii1Click(Sender: TObject);
begin
{$IfDef SERVIS}
  frmAriza.Form_Open(True,'',1);
{$EndIf}
end;

procedure TMainForm.YeniAraMarkaGirii1Click(Sender: TObject);
begin
{$IfDef SERVIS}
  frmArac_Marka.Form_Open(True,'',1);
{$EndIf}
end;

procedure TMainForm.BayiListesi1Click(Sender: TObject);
var
  BAYI_KOD,BAYI_AD:String;
begin
{$IfDef SERVIS}
  if DataMod.LS_Bayi(BAYI_KOD,BAYI_AD) then
  begin
     frmBayi.Form_Open(True,BAYI_KOD,0);
  end;
{$EndIf}
end;

procedure TMainForm.BeyanTehlikesineGirenKalemler1Click(Sender: TObject);
begin
  {$IfDef ANTREPO}
    frmANT_REPORT.BeyTehlike_Open;
  {$EndIf}
end;

procedure TMainForm.SigortairketiListesi1Click(Sender: TObject);
var
  SIGORTA_KOD,SIGOTA_AD:String;
begin
{$IfDef SERVIS}
  if DataMod.LS_Sigorta(SIGORTA_KOD,SIGOTA_AD) then
  begin
  frmSigorta.Form_Open(True,SIGORTA_KOD,0);
  end;
{$EndIf}
end;

procedure TMainForm.YeniOnarmFii1Click(Sender: TObject);
begin
{$IfDef SERVIS}
  frmOnarim.Form_Open(True,0,0,0);
{$EndIf}
end;

procedure TMainForm.OnarmFiiListesi1Click(Sender: TObject);
var
  ONARIM_ID,ONARIM_SID:Integer;
begin
{$IfDef SERVIS}
  if FindChildFrm(Application,'frmOnarim') then
  begin
    Application.MessageBox ('Onarým Fiþi açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmONARIM_SDLG.Form_Open(True,ONARIM_ID,ONARIM_SID,False) then
  begin
    frmOnarim.Form_Open(True,ONARIM_ID,ONARIM_SID,1);
  end;
{$EndIf}
end;

procedure TMainForm.YeniAlFaturas2Click(Sender: TObject);
begin
{$IfDef SERVIS}
  frmFAT_Srv.Form_Open(True,1,0,0,0,2);
{$EndIf}
end;

procedure TMainForm.AlFaturasListesi3Click(Sender: TObject);
//alýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
 {$IfDef SERVIS}
  if FindChildFrm(Application,'frmFAT_Tran') then
  begin
    Application.MessageBox('Fatura formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,2,False) then
  begin
    frmFAT_Srv.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,2);
  end;
 {$EndIf}
end;

procedure TMainForm.YeniSatFaturas3Click(Sender: TObject);
begin
 {$IfDef SERVIS}
  frmFAT_Srv.Form_Open(True,1,0,0,0,1);
 {$EndIf}
end;

procedure TMainForm.OnarmFiiListesi2Click(Sender: TObject);
var
  ONARIM_ID,ONARIM_SID:Integer;
begin
 {$IfDef SERVIS}
   frmONARIM_SDLG.Form_Open(True,ONARIM_ID,ONARIM_SID,True);
  {$EndIf}
end;

procedure TMainForm.AraListesi4Click(Sender: TObject);
begin
 {$IfDef SERVIS}
    frmRaporSrvAracListesi.Form_Open;
  {$EndIf}
end;

procedure TMainForm.YeniGeliNedeni1Click(Sender: TObject);
begin
 {$IfDef SERVIS}
  frmGelis_Neden.Form_Open(True,'',1);
 {$EndIf}
end;

procedure TMainForm.ArzaTipiListesi1Click(Sender: TObject);
var
  ARIZA_KOD, ARIZA_AD: String;
begin
 {$IfDef SERVIS}
  if DataMod.LS_Ariza(ARIZA_KOD,ARIZA_AD) then
  begin
  frmAriza.Form_Open(True,ARIZA_KOD,0);
  end;
{$EndIf}
end;

procedure TMainForm.GeliNedeniListesi1Click(Sender: TObject);
var
  NEDEN_KOD,ACIKLAMA:String;
begin
 {$IfDef SERVIS}
  if DataMod.LS_Gelis_Nedeni(NEDEN_KOD,ACIKLAMA) then
  begin
  frmGelis_Neden.Form_Open(True,NEDEN_KOD,0);
  end;
 {$EndIf}
 End;

procedure TMainForm.SatFaturasListesi3Click(Sender: TObject);
//satýþ faturasý listesi
var
  FAT_IRS_ID,FAT_IRS_SID:Integer;
begin
 {$IfDef SERVIS}
  if FindChildFrm(Application,'frmFAT_Srv') then
  begin
    Application.MessageBox ('Fatura formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    Exit;
  end;
  if frmFAT_IRS_SDLG.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,False) then
  begin
    frmFAT_Srv.Form_Open(True,1,FAT_IRS_ID,FAT_IRS_SID,1,1);
  end;
  {$EndIf}
end;

procedure TMainForm.oplamMazotRaporu1Click(Sender: TObject);
begin
 {$IfDef TRANSPORT}
    // frmRaporToplamArac.ShowModal;
     Application.CreateForm(TfrmRaporToplamArac,frmRaporToplamArac);
 {$EndIf}
end;
//KANTAR
procedure TMainForm.YeniPlakaTanmlama1Click(Sender: TObject);
begin
  {$IfDef KANTAR}
     frmPLAKA.Form_Open(False,'',0);
  {$EndIf}
end;

procedure TMainForm.PlakaListesi1Click(Sender: TObject);
var
  PLAKA_NO,ACIKLAMA,CARI_KOD,CARI_AD:String;
begin
{$IfDef KANTAR}
  if FindChildFrm(Application, 'frmPLAKA') then
  begin
    Application.MessageBox ('Plaka formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if datamod.LS_Plaka(PLAKA_NO,ACIKLAMA,CARI_KOD,CARI_AD) then
  begin
    frmPlaka.Form_Open(True,PLAKA_NO,1);
  end;
{$EndIf}
end;

procedure TMainForm.KantarGirii1Click(Sender: TObject);
begin
{$IfDef KANTAR}
    frm_Kantar.Form_Open(True,0,0);
{$EndIf}
end;

procedure TMainForm.GiriListesi1Click(Sender: TObject);
var
  KANTAR_NO:Integer;
begin
{$IfDef KANTAR}
  if FindChildFrm(Application, 'frm_Kantar') then
  begin
    Application.MessageBox ('Kantar formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if frm_Kantar_Sdlg.Form_Open(True,KANTAR_NO,False) then
  begin
    frm_Kantar.Form_Open(True,KANTAR_NO,1);
  end;
{$EndIf}
end;

procedure TMainForm.Kantark2Click(Sender: TObject);
var
  KANTAR_NO:Integer;
begin
{$IfDef KANTAR}
  if FindChildFrm(Application, 'frm_Kantar') then
  begin
    Application.MessageBox ('Kantar formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if frm_Kantar_Sdlg.Form_Open(True,KANTAR_NO,False) then
  begin
    frm_Kantar.Form_Open(False,KANTAR_NO,1);
  end;
{$EndIf}
end;

procedure TMainForm.kListesi1Click(Sender: TObject);
var
  KANTAR_NO:Integer;
begin
{$IfDef KANTAR}
  if FindChildFrm(Application, 'frm_Kantar') then
  begin
    Application.MessageBox ('Kantar formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  if frm_Kantar_Sdlg.Form_Open(False,KANTAR_NO,False) then
  begin
    frm_Kantar.Form_Open(False,KANTAR_NO,1);
  end;
{$EndIf}
end;

procedure TMainForm.GiriListesi2Click(Sender: TObject);
var
  KANTAR_NO:Integer;
begin
{$IfDef KANTAR}
  if FindChildFrm(Application, 'frm_Kantar') then
  begin
    Application.MessageBox ('Kantar formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  frm_Kantar_Sdlg.Form_Open(True,KANTAR_NO,True)
{$EndIf}
end;

procedure TMainForm.kListesi2Click(Sender: TObject);
var
  KANTAR_NO:Integer;
begin
{$IfDef KANTAR}
  if FindChildFrm(Application, 'frm_Kantar') then
  begin
    Application.MessageBox ('Kantar formu açýk iken listeyi kullanamazsýnýz.','Dikkat',MB_ICONWARNING);
    exit;
  end;
  frm_Kantar_Sdlg.Form_Open(False,KANTAR_NO,True)
{$EndIf}
end;
procedure TMainForm.mnuYeniAntrepoGirisFisiClick(Sender: TObject);
begin
{$IfDef ANTREPO}
  frmANT_GIRIS.Form_Open(True, 0,0 );
{$EndIf}
end;

end.


