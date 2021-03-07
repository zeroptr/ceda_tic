; -- Example2.iss --
; Same as Example1.iss, but creates its icon in the Programs folder of the
; Start Menu instead of in a subfolder, and also creates a desktop icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=Ceda Yazýlým Kara Nakliye Yazýlýmý
AppVerName=KaraNak V2.0.45
DefaultDirName=c:\CedaLite
; Since no icons will be created in "{group}", we don't need the wizard
; to ask for a Start Menu folder name:
DisableProgramGroupPage=yes
UninstallDisplayIcon={app}\CedaLite.exe
OutputBaseFilename=KaraNak_Ym_SetUp
OutputDir=C:\CedaLite_Ym\Kur

[Files]
Source: ..\Temp\CedaLite.exe; DestDir: {app}
Source: ..\Temp\Host.ini; DestDir: {app}
Source: ..\Temp\Aktar.ini; DestDir: {app}
Source: ..\Temp\Settings.ini; DestDir: {app}
Source: ..\Trans_Db\LOG.FDB; DestDir: {app}\DB
Source: ..\Trans_Db\MAIN.FDB; DestDir: {app}\DB
Source: ..\Trans_Db\TRANS_BOS.FDB; DestDir: {app}\DB
Source: ..\report\asl\Arac_Hareket.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Arac_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Arac_Mazot.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Arac_Pers.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Borc_Cek_Ode.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Borc_Ceki.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Borc_Ceki_Iade.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cari_Hareket.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cari_Hareket_Grup.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cari_Hareket_proc.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cari_Hareket_proc_deg.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cari_Hareket_Tarih.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cari_Hareket_Toplam.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cari_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cari_Listesi_iis.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cek_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Cek_Mus_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Dekont.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Depo_Urun_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Doviz_Kurlari.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Fatura_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\fatura_nokta5_kasali2.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Gunluk_Sefer.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Ikes_Pers.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Irsaliye.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kasa_Aylik.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kasa_Cari.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kasa_Cek_Senet.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kasa_Cek_Senet_Tediye.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kasa_Gunluk.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kasa_Muhtelif.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kasa_Transfer.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kiralik_Sefer.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kiralik_Sefer_ack.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Kiralik_Sefer_Ekinci.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Ma_Kiralik_Alacak.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Ma_Kiralik_Alacak_Alici.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Ma_Kiralik_Alacak_cari_grup.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Ma_Kiralik_Alacak_cari_grup_alici.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Ma_Sirket_Alacak.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Masraf_Hareket.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Masraf_Hareket_grp.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Masraf_Hareket_grpsuz.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Masraf_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\MazotLitreKm.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Musteri_Ceki.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Musteri_Ceki_Ciro.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Musteri_Ceki_Iade.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Onarim_Fisi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Onarim_Fisi_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Onarim_Fisi_Listesi_Det.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Onarim_Fisi_Listesi_Det.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Onarim_Fisi_Mu.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Personel_Hareket.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Personel_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Personel_Sefer.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Plasiyer_Hareket.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Plasiyer_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Proje_Hareket.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Proje_Hareket_Dov.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Proje_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Sefer_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Sefer_Listesi_Alicisiz.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Sefer_Listesi_Tek_satir.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Senet_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Senet_Mus_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Serbest_Dekont.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Siparis.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Siparis_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Sofor_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Srv_Arac_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Toplam_Kg_Sefer.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Toplam_Kg_Sefer_Detayli.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Urun_Fiyat_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Urun_Har_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Urun_Har_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Urun_Listesi.fr3; DestDir: {app}\REPORT
Source: ..\report\asl\Yukleme_Fisi.fr3; DestDir: {app}\REPORT



[Icons]
Name: {commonprograms}\KaraNak; Filename: {app}\CedaLite.exe; WorkingDir: {app}; IconIndex: 0
Name: {commondesktop}\KaraNak; Filename: {app}\CedaLite.exe; WorkingDir: {app}; IconIndex: 0
