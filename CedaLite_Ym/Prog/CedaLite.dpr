{$INCLUDE directive.inc}
program CedaLite;

uses
  Forms,
  Dialogs,
  about in 'about.pas' {AboutBox},
  main in 'main.pas' {MainForm},
  ufrmCARHAR_AKT in 'ufrmCARHAR_AKT.pas' {frmCARHAR_AKT},
  ufrmCariGroup in 'ufrmCariGroup.pas' {frmCariGroup},
  ufrmCariKart in 'ufrmCariKart.pas' {frmCariKart},
  ufrmCariSDLG in 'ufrmCariSDLG.pas' {frmCariSDLG},
  ufrmCek in 'ufrmCek.pas' {frm_Cek},
  ufrmCekSenHarSDGL in 'ufrmCekSenHarSDGL.pas' {frmCekSenHarSDGL},
  ufrmCekSenSDLG in 'ufrmCekSenSDLG.pas' {frmCekSenSDLG},
  ufrmDekontSDLG in 'ufrmDekontSDLG.pas' {frmDekontSDLG},
  ufrmDEKONTT in 'ufrmDEKONTT.pas' {frmDEKONTT},
  ufrmDEVIRKAY in 'ufrmDEVIRKAY.pas' {frmDEVIRKAY},
  ufrmDovKart in 'ufrmDovKart.pas' {frmDovKart},
  ufrmDovTan in 'ufrmDovTan.pas' {frmDovTan},
  ufrmFatParams in 'ufrmFatParams.pas' {frmFatParams},
  ufrmISN_ERRORS in 'ufrmISN_ERRORS.pas' {frmISN_ERRORS},
  ufrmKasa in 'ufrmKasa.pas' {frmKasa},
  ufrmKASA_MUHTELIF in 'ufrmKASA_MUHTELIF.pas' {frmKASA_MUHTELIF},
  ufrmKasalarArasiTransfer in 'ufrmKasalarArasiTransfer.pas' {frmKasalarArasiTransfer},
  ufrmKulHakTanim in 'ufrmKulHakTanim.pas' {frm_Kul_Hak_Tanim},
  ufrmKullaniciTanimlama in 'ufrmKullaniciTanimlama.pas' {frm_Kullanici_Tanimlama},
  ufrmModul in 'ufrmModul.pas' {frmModul},
  ufrmOlcuTip in 'ufrmOlcuTip.pas' {frmOlcuTip},
  ufrmParameters in 'ufrmParameters.pas' {frmParameters},
  ufrmParametersTab in 'ufrmParametersTab.pas' {frmParametersTab},
  ufrmProgramHizmetleri in 'ufrmProgramHizmetleri.pas' {frmProgramHizmetleri},
  ufrmProje in 'ufrmProje.pas' {frmProje},
  ufrmSDLG in 'ufrmSDLG.pas' {frmSrcDlg},
  ufrmSENET in 'ufrmSENET.pas' {frm_SENET},
  ufrmSirketTanim in 'ufrmSirketTanim.pas' {frm_Sirket_Tanim},
  ufrmSube in 'ufrmSube.pas' {frm_Sube},
  ufrmUrunGroup in 'ufrmUrunGroup.pas' {frmUrunGroup},
  ufrmUrunSDLG in 'ufrmUrunSDLG.pas' {frmUrunSDLG},
  ufrmUrunTanA in 'ufrmUrunTanA.pas' {frmUrunTanA},
  unDataMod in 'unDataMod.pas' {DataMod: TDataModule},
  unFUNC in 'unFUNC.pas',
  unHARFUNCS in 'unHARFUNCS.pas' {dmHARFUNCS: TDataModule},
  unCEKSENHAR in 'unCEKSENHAR.pas' {dmCEKSENHAR: TDataModule},
  GenTypes in 'GenTypes.pas',
  ufrmCEKSEN_TAHSILVER in 'ufrmCEKSEN_TAHSILVER.pas' {frmCEKSEN_TAHSILVER},
  ufrmCEKSEN_CIRO in 'ufrmCEKSEN_CIRO.pas' {frmCEKSEN_CIRO},
  ufrmCEKSEN_IADE in 'ufrmCEKSEN_IADE.pas' {frmCEKSEN_IADE},
  ufrmCEKSEN_KARS in 'ufrmCEKSEN_KARS.pas' {frmCEKSEN_KARS},
  ufrmCEKSEN_KASA in 'ufrmCEKSEN_KASA.pas' {frmCEKSEN_KASA},
  ufrmCEKSEN_BCEK_ODEME in 'ufrmCEKSEN_BCEK_ODEME.pas' {frmCEKSEN_BCEK_ODEME},
  ufrmCEKSEN_SIL in 'ufrmCEKSEN_SIL.pas' {frmCEKSEN_SIL},
  ufrmBELGE_YAZ in 'ufrmBELGE_YAZ.pas' {frmBELGE_YAZ},
  unYazici in 'unYazici.pas' {Yazici: TDataModule},
  unRegistry in 'unRegistry.pas',
  ufrmRaporCariAylikBA in '..\Rapor\ufrmRaporCariAylikBA.pas' {frmRaporCariAylikBA},
  ufrmRaporCariBakiyeliHareket in '..\Rapor\ufrmRaporCariBakiyeliHareket.pas' {frmRaporCariBakiyeliHareket},
  ufrmRaporCariBakiyeliHareketTarihli in '..\Rapor\ufrmRaporCariBakiyeliHareketTarihli.pas' {frmRaporCariBakiyeliHareketTarihli},
  ufrmRaporCekSenet in '..\Rapor\ufrmRaporCekSenet.pas' {frmRaporCekSenet},
  ufrmRaporCiktisi in '..\Rapor\ufrmRaporCiktisi.pas' {frmRaporCiktisi},
  ufrmRaporDepoUrunListesi in '..\Rapor\ufrmRaporDepoUrunListesi.pas' {frmRaporDepoUrunListesi},
  ufrmRaporDovizKurlari in '..\Rapor\ufrmRaporDovizKurlari.pas' {frmRaporDovizKurlari},
  ufrmRaporGenelCariListesi in '..\Rapor\ufrmRaporGenelCariListesi.pas' {frmRaporGenelCariListesi},
  ufrmRaporGrupCBakiyeliHar in '..\Rapor\ufrmRaporGrupCBakiyeliHar.pas' {frmRaporGrupCBakiyeliHar},
  ufrmRaporKasaAralikliHareket in '..\Rapor\ufrmRaporKasaAralikliHareket.pas' {frmRaporKasaAralikliHareket},
  ufrmRaporKasaAylik in '..\Rapor\ufrmRaporKasaAylik.pas' {frmRaporKasaAylik},
  ufrmRaporKasaTekGunlukHareket in '..\Rapor\ufrmRaporKasaTekGunlukHareket.pas' {frmRaporKasaTekGunlukHareket},
  ufrmRaporPlasiyerHareketleri in '..\Rapor\ufrmRaporPlasiyerHareketleri.pas' {frmRaporPlasiyerHareketleri},
  ufrmRaporPlasiyerListesi in '..\Rapor\ufrmRaporPlasiyerListesi.pas' {frmRaporPlasiyerListesi},
  ufrmRaporProjeHareketleri in '..\Rapor\ufrmRaporProjeHareketleri.pas' {frmRaporProjeHareketleri},
  ufrmRaporPersonelHareketleri_KasaliListesi in 'Arac\ufrmRaporPersonelHareketleri_KasaliListesi.pas' {frmRaporPersonelHareketleri_KasaliListesi},
  ufrmRaporSerbestDekont in '..\Rapor\ufrmRaporSerbestDekont.pas' {frmRaporSerbestDekont},
  ufrmRaporUrunListesi in '..\Rapor\ufrmRaporUrunListesi.pas' {frmRaporUrunListesi},
  ufrmRaporCariBakiyeliHareketToplam in '..\Rapor\ufrmRaporCariBakiyeliHareketToplam.pas' {frmRaporCariBakiyeliHareketToplam},
  ufrmRaporProjeListesi in '..\Rapor\ufrmRaporProjeListesi.pas' {frmRaporProjeListesi},
  ufrmBAKIM in 'ufrmBAKIM.pas' {frmBAKIM},
  ufrmRaporUrunFatura in '..\Rapor\ufrmRaporUrunFatura.pas' {frmRaporUrunFatura},
  ufrmMasrafTan in 'ufrmMasrafTan.pas' {frmMasrafTan},
  ufrmRaporMasrafListesi in '..\Rapor\ufrmRaporMasrafListesi.pas' {frmRaporMasrafListesi},
  ufrmRaporMasrafHareket in '..\Rapor\ufrmRaporMasrafHareket.pas' {frmRaporMasrafHareket},
  ufrmRaporMasrafHareketTarihli in '..\Rapor\ufrmRaporMasrafHareketTarihli.pas' {frmRaporMasrafHareketTarihli},
  ufrmTERM_FF in 'ufrmTERM_FF.pas' {frmTERM_FF},
  ufrmMAIN_NEW in 'ufrmMAIN_NEW.pas' {frmMAIN_NEW},
  ufrmLOGIN in 'ufrmLOGIN.pas' {frmLOGIN},
  unLogger in 'unLogger.pas' {dmLOGGER: TDataModule},
  ufrmUrun_Masraf_Merkezi in 'Arac\ufrmUrun_Masraf_Merkezi.pas' {frmUrun_Masraf_Merkezi},
  ufrmKulSifreDegis in 'ufrmKulSifreDegis.pas' {frmKulSifreDegis},
  ufrmRaporKullaniciHak in '..\Rapor\ufrmRaporKullaniciHak.pas' {frmRaporKullaniciHak},
  unDmYonet in 'unDmYonet.pas' {DmYonet: TDataModule},
  ufrmBakiyeDevret in 'ufrmBakiyeDevret.pas' {frmBakiyeDevret},
  ufrmMasrafGroup in 'ufrmMasrafGroup.pas' {frmMasrafGroup},
  ufrmKayitTarihAyarla in 'ufrmKayitTarihAyarla.pas' {frmKayitTarihAyarla},
  ufrmDEKONT_AUT in 'ufrmDEKONT_AUT.pas' {frmDEKONT_AUT},
  unDEKONT_AUT in 'unDEKONT_AUT.pas' {DEKONT_AUT: TDataModule},
  ufrmIRSALIYE in 'ufrmIRSALIYE.pas' {frmIRSALIYE},
  ufrmSiparis in 'ufrmSiparis.pas' {frmSiparis},
  ufrmSIP_SDLG in 'ufrmSIP_SDLG.pas' {frmSIP_SDLG},
  ufrmIrsaliye_Fatura in 'ufrmIrsaliye_Fatura.pas' {frmIrsaliye_Fatura},
  ufrmLisans in 'ufrmLisans.pas' {frmLisans},
  ufrmMUHKODTanim in 'ufrmMUHKODTanim.pas' {frmMUHKODTanim},
  Un_Kul_Con_Fb in 'Un_Kul_Con_Fb.pas',
  ufrmPaket in 'ufrmPaket.pas' {frmPaket},
  ufrmPlasiyer in 'ufrmPlasiyer.pas' {frmPlasiyer},
  ufrmYeniYil_Devri in 'ufrmYeniYil_Devri.pas' {frmYeniYil_Devri},
  UDm_Fast_Report in 'UDm_Fast_Report.pas' {Dm_Fast_Report: TDataModule},
  ufrmFastRe_Giris in 'ufrmFastRe_Giris.pas' {frmFastRe_Giris},
  ufrmSirket_Expert in 'ufrmSirket_Expert.pas' {frmSirket_Expert},
  ufrmFoto_Ana in 'ufrmFoto_Ana.pas' {frmFoto_Ana},
  ufrmDepo in 'ufrmDepo.pas' {frmDepo},
  UDm1_Fast_Report in 'UDm1_Fast_Report.pas' {Dm1_Fast_Report: TDataModule},
  ufrmFAT_IRS in 'ufrmFAT_IRS.pas' {frmFAT_IRS},
  ufrmSiparis_Fatura in 'ufrmSiparis_Fatura.pas' {frmSiparis_Fatura},
  ufrmFAT_IRS_SDLG in 'ufrmFAT_IRS_SDLG.pas' {frmFAT_IRS_SDLG},
  ufrmRaporUrunFiyatListesi in '..\Rapor\ufrmRaporUrunFiyatListesi.pas' {frmRaporUrunFiyatListesi},
  ufrmRaporUrunHareketleri in '..\Rapor\ufrmRaporUrunHareketleri.pas' {frmRaporUrunHareketleri},
  ufrmKASA_CARI in 'ufrmKASA_CARI.pas' {frmKASA_CARI},
  ufrmKasaSDGL in 'ufrmKasaSDGL.pas' {frmKasaSDGL},
  ufrmPlaka in 'Kantar\ufrmPlaka.pas' {frmPlaka},
  ufrm_Kantar in 'Kantar\ufrm_Kantar.pas' {frm_Kantar},
  ufrm_Kantar_Sdlg in 'Kantar\ufrm_Kantar_Sdlg.pas' {frm_Kantar_Sdlg},
  ufrm_Kantar_Cikis in 'Kantar\ufrm_Kantar_Cikis.pas' {frm_Kantar_Cikis},
  ufrm_Kantar_Degistir in 'Kantar\ufrm_Kantar_Degistir.pas' {frm_Kantar_Degistir},
  ufrmSefer in 'Arac\ufrmSefer.pas' {frmSefer},
  ufrmMazot in 'Arac\ufrmMazot.pas' {frmMazot},
  ufrmMazotSDLG in 'Arac\ufrmMazotSDLG.pas' {frmMazotSDLG},
  ufrmRaporSkAracHareketleriRaporu in 'Arac\ufrmRaporSkAracHareketleriRaporu.pas' {frmRaporSkAracHareketleriRaporu},
  ufrmRaporSoforListesi in 'Arac\ufrmRaporSoforListesi.pas' {frmRaporSoforListesi},
  ufrmRaporSeferKasali in 'Arac\ufrmRaporSeferKasali.pas' {frmRaporSeferKasali},
  ufrmRaporAracPersonelListesi in 'Arac\ufrmRaporAracPersonelListesi.pas' {frmRaporAracPersonelListesi},
  ufrmRaporIlisigiKesilmisPersonelListesi in 'Arac\ufrmRaporIlisigiKesilmisPersonelListesi.pas' {frmRaporIlisigiKesilmisPersonelListesi},
  ufrmRaporMazotAracListesi in 'Arac\ufrmRaporMazotAracListesi.pas' {frmRaporMazotAracListesi},
  ufrmRaporFatura_Mazot in 'Arac\ufrmRaporFatura_Mazot.pas' {frmRaporFatura_Mazot},
  ufrmRaporSefer_Mazot1 in 'Arac\ufrmRaporSefer_Mazot1.pas' {frmRaporSefer_Mazot1},
  ufrmRaporFatura_Sefer in 'Arac\ufrmRaporFatura_Sefer.pas' {frmRaporFatura_Sefer},
  ufrmRaporSefer_Mazot in 'Arac\ufrmRaporSefer_Mazot.pas' {frmRaporSefer_Mazot},
  ufrmRaporAracHareketleriListesi in 'Arac\ufrmRaporAracHareketleriListesi.pas' {frmRaporAracHareketleriListesi},
  ufrmRaporSefer in 'Arac\ufrmRaporSefer.pas' {frmRaporSefer},
  ufrmYuk_Fis_SDLG in 'Arac\ufrmYuk_Fis_SDLG.pas' {frmYuk_Fis_SDLG},
  ufrmPersonel in 'Arac\ufrmPersonel.pas' {frmPersonel},
  ufrmSofor in 'Arac\ufrmSofor.pas' {frmSofor},
  ufrmRaporPersonelListesi in 'Arac\ufrmRaporPersonelListesi.pas' {frmRaporPersonelListesi},
  ufrmRaporPersonelHareketleriListesi in 'Arac\ufrmRaporPersonelHareketleriListesi.pas' {frmRaporPersonelHareketleriListesi},
  ufrmSeferSDLG in 'Arac\ufrmSeferSDLG.pas' {frmSeferSDLG},
  ufrmArac_Masraf in 'Arac\ufrmArac_Masraf.pas' {frmArac_Masraf},
  ufrmAracMasrafSDGL in 'Arac\ufrmAracMasrafSDGL.pas' {frmAracMasrafSDGL},
  ufrnRAPOR_SEF_AYRINTI in 'Arac\ufrnRAPOR_SEF_AYRINTI.pas' {frnRAPOR_SEF_AYRINTI},
  ufrmButunluk_Kotrolu in 'Arac\ufrmButunluk_Kotrolu.pas' {frmButunluk_Kotrolu},
  ufrmESYA_TAN in 'Arac\ufrmESYA_TAN.pas' {frmESYA_TAN},
  ufrmYukleme_Fisi in 'Arac\ufrmYukleme_Fisi.pas' {frmYukleme_Fisi},
  ufrmArac in 'Arac\ufrmArac.pas' {frmArac},
  ufrmRaporAracListesi in 'Arac\ufrmRaporAracListesi.pas' {frmRaporAracListesi},
  ufrmFAT_Tran in 'Arac\ufrmFAT_Tran.pas' {frmFAT_Tran},
  ufrmResimTamEkran in 'Arac\ufrmResimTamEkran.pas' {frmResimTamEkran},
  ufrmRaporToplamArac in 'Arac\ufrmRaporToplamArac.pas' {frmRaporToplamArac},
  ufrmRaporSrvAracListesi in 'servis\ufrmRaporSrvAracListesi.pas' {frmRaporSrvAracListesi},
  ufrmArac_Srv in 'servis\ufrmArac_Srv.pas' {frmArac_Srv},
  ufrmOnarim_Fatura in 'servis\ufrmOnarim_Fatura.pas' {frmOnarim_Fatura},
  ufrmArac_Marka in 'servis\ufrmArac_Marka.pas' {frmArac_Marka},
  ufrmAriza in 'servis\ufrmAriza.pas' {frmAriza},
  ufrmSigorta in 'servis\ufrmSigorta.pas' {frmSigorta},
  ufrmGelis_Neden in 'servis\ufrmGelis_Neden.pas' {frmGelis_Neden},
  ufrmBayi in 'servis\ufrmBayi.pas' {frmBayi},
  ufrmFAT_Srv in 'servis\ufrmFAT_Srv.pas' {frmFAT_Srv},
  ufrmOnarim_SDLG in 'servis\ufrmOnarim_SDLG.pas' {frmOnarim_SDLG},
  ufrmOnarim in 'servis\ufrmOnarim.pas' {frmOnarim},
  ufrmOnarim_Fatura_Bir in 'servis\ufrmOnarim_Fatura_Bir.pas' {frmOnarim_Fatura_Bir},
  UnSec in 'UnSec.pas',
  ufrmANT_CIKIS in 'Antrepo\ufrmANT_CIKIS.pas' {frmANT_CIKIS},
  ufrmANT_SDLG in 'Antrepo\ufrmANT_SDLG.pas' {frmANT_SDLG},
  ufrmANT_GIRIS in 'Antrepo\ufrmANT_GIRIS.pas' {frmANT_GIRIS},
  ufrmANT_REPORT in 'Antrepo\ufrmANT_REPORT.pas' {frmANT_REPORT},
  ufrmDevirSifre in 'ufrmDevirSifre.pas' {frmDevirSifre},
  ufrmSefer_TakipSDLG in 'Arac\ufrmSefer_TakipSDLG.pas' {frmSefer_TakipSDLG},
  ufrmSefer_Takip in 'Arac\ufrmSefer_Takip.pas' {frmSefer_Takip};

{$R *.RES}
begin
  Application.Initialize;
  Application.Title := 'Ceda Yazýlým';
//  Un_Kul_Con_Fb.Fb_Calistir;
  Application.CreateForm(TDataMod, DataMod);
  Application.CreateForm(TDmYonet, DmYonet);
  Application.CreateForm(TdmLOGGER, dmLOGGER);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TdmCEKSENHAR, dmCEKSENHAR);
  Application.CreateForm(TYazici, Yazici);
  Application.CreateForm(TfrmISN_ERRORS, frmISN_ERRORS);
  Application.CreateForm(TfrmProgramHizmetleri, frmProgramHizmetleri);
  Application.CreateForm(TfrmLOGIN, frmLOGIN);
  Application.CreateForm(TfrmLisans, frmLisans);
  Application.CreateForm(TfrmDevirSifre, frmDevirSifre);
  Application.CreateForm(TfrmSefer_TakipSDLG, frmSefer_TakipSDLG);
  Application.CreateForm(TfrmSefer_Takip, frmSefer_Takip);
  //  Application.CreateForm(TfrmSefer_Takip, frmSefer_Takip);
  frmProgramHizmetleri.Ayar_Yukle;
  frmLOGIN.Form_Open;
  if not frmLOGIN.pbl_Cikis=True then
  begin

  Application.CreateForm(TfrmMAIN_NEW,frmMAIN_NEW);
  if not frmMAIN_NEW.Form_Open(False) then
  begin
    frmProgramHizmetleri.Release;
    frmLOGIN.Release;
    frmMAIN_NEW.Release;
    Application.Terminate;
  end
  else
  begin
    try
       Application.CreateForm(TDm1_Fast_Report, Dm1_Fast_Report);
       Application.CreateForm(TDm_Fast_Report, Dm_Fast_Report);
    except
       ShowMessage('Ahada hatayý buldum');
    end;
    frmProgramHizmetleri.Release;
    frmLOGIN.Release;
    frmMAIN_NEW.Release;
    Application.Run;
  end;
  end
  else
  begin
    frmLOGIN.FreeOnRelease;
    frmProgramHizmetleri.Release;
    //frmSettings.Release;
    frmLisans.Release;
   //Application.Destroy;
end;



end.
