unit frxrcDesgn;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1254">  <StrRes Name='+
'"2000" Text="Nesne Yöneticisi"/>  <StrRes Name="oiProp" Text="Özellikler"/>  <St'+
'rRes Name="oiEvent" Text="Olaylar"/>  <StrRes Name="2100" Text="Veri Aðacý"/>  <'+
'StrRes Name="2101" Text="Veri"/>  <StrRes Name="2102" Text="Deðiþkenler"/>  <Str'+
'Res Name="2103" Text="Fonksiyonlar"/>  <StrRes Name="2104" Text="Saha oluþtur"/>'+
'  <StrRes Name="2105" Text="Etiket oluþtur"/>  <StrRes Name="2106" Text="Classes'+
'"/>  <StrRes Name="dtNoData" Text="Kullanýlabilir veri yok"/>  <StrRes Name="dtN'+
'oData1" Text="Raporunuz için mevcut dataset''i eklemek için menüden &#38;#34;Rapo'+
'r|Veri...&#38;#34; kýsmýna gidin &#38;#34;Veri&#38;#34; sekmesini açýp  ve yeni '+
'dataset oluþturun."/>  <StrRes Name="dtData" Text="Veri"/>  <StrRes Name="dtSysV'+
'ar" Text="Sistem deðiþkenleri"/>  <StrRes Name="dtVar" Text="Deðiþkenler"/>  <St'+
'rRes Name="dtFunc" Text="Fonksiyonlar"/>  <StrRes Name="2200" Text="Rapor Aðacý"'+
'/>  <StrRes Name="2300" Text="Programcýk Dosyasý Aç"/>  <StrRes Name="2301" Text'+
'="Programcýk Dosyasýný Kaydet"/>  <StrRes Name="2302" Text="Programcýk Çalýþtýr"'+
'/>  <StrRes Name="2303" Text="Ýçe gir"/>  <StrRes Name="2304" Text="Programcýk s'+
'onlandýr"/>  <StrRes Name="2305" Text="Deðerlendirme"/>  <StrRes Name="2306" Tex'+
't="Dil:"/>  <StrRes Name="2307" Text="Hizalama"/>  <StrRes Name="2308" Text="Sol'+
'a Hizala"/>  <StrRes Name="2309" Text="Ortala"/>  <StrRes Name="2310" Text="Saða'+
' Hizala"/>  <StrRes Name="2311" Text="Üste Hizala"/>  <StrRes Name="2312" Text="'+
'Ortala"/>  <StrRes Name="2313" Text="Alta Hizala"/>  <StrRes Name="2314" Text="Y'+
'atay Boþluk"/>  <StrRes Name="2315" Text="Dikey Boþluk"/>  <StrRes Name="2316" T'+
'ext="Bandýn Ýçinde Yatay Ortala"/>  <StrRes Name="2317" Text="Bandýn Ýçinde Dike'+
'y Ortala"/>  <StrRes Name="2318" Text="Ayný Geniþlik"/>  <StrRes Name="2319" Tex'+
't="Ayný Yükseklik"/>  <StrRes Name="2320" Text="Metin"/>  <StrRes Name="2321" Te'+
'xt="Biçim"/>  <StrRes Name="2322" Text="Yazý Tipi Adý"/>  <StrRes Name="2323" Te'+
'xt="Yazý Tipi Büyüklüðü"/>  <StrRes Name="2324" Text="Kalýn"/>  <StrRes Name="23'+
'25" Text="Ýtalik"/>  <StrRes Name="2326" Text="Altý Çizgili"/>  <StrRes Name="23'+
'27" Text="Yazý Rengi"/>  <StrRes Name="2328" Text="Vurgu"/>  <StrRes Name="2329"'+
' Text="Metin Döndürme Açýsý"/>  <StrRes Name="2330" Text="Sola Hizala"/>  <StrRe'+
's Name="2331" Text="Ortala"/>  <StrRes Name="2332" Text="Saða Hizala"/>  <StrRes'+
' Name="2333" Text="Ýki Yana Hizala"/>  <StrRes Name="2334" Text="Üste Hizala"/> '+
' <StrRes Name="2335" Text="Ortala"/>  <StrRes Name="2336" Text="Alta Hizala"/>  '+
'<StrRes Name="2337" Text="Çerçeve"/>  <StrRes Name="2338" Text="Üst Çizgi"/>  <S'+
'trRes Name="2339" Text="Alt Çizgi"/>  <StrRes Name="2340" Text="Sol Çizgi"/>  <S'+
'trRes Name="2341" Text="Sað Çizgi"/>  <StrRes Name="2342" Text="Tüm Çerçeve Çizg'+
'ileri"/>  <StrRes Name="2343" Text="Çerçeve Yok"/>  <StrRes Name="2344" Text="Gö'+
'lge"/>  <StrRes Name="2345" Text="Arkaplan Rengi"/>  <StrRes Name="2346" Text="Ç'+
'erçeve Rengi"/>  <StrRes Name="2347" Text="Çerçeve Biçimi"/>  <StrRes Name="2348'+
'" Text="Çerçeve Geniþliði"/>  <StrRes Name="2349" Text="Standart"/>  <StrRes Nam'+
'e="2350" Text="Yeni Rapor"/>  <StrRes Name="2351" Text="Rapor Aç"/>  <StrRes Nam'+
'e="2352" Text="Rapor Kaydet"/>  <StrRes Name="2353" Text="Önizleme"/>  <StrRes N'+
'ame="2354" Text="Yeni Rapor Sayfasý"/>  <StrRes Name="2355" Text="Yeni Diyalog S'+
'ayfasý"/>  <StrRes Name="2356" Text="Sayfa Sil"/>  <StrRes Name="2357" Text="Say'+
'fa Ayarlarý"/>  <StrRes Name="2358" Text="Deðiþkenler"/>  <StrRes Name="2359" Te'+
'xt="Kes"/>  <StrRes Name="2360" Text="Kopyala"/>  <StrRes Name="2361" Text="Yapý'+
'þtýr"/>  <StrRes Name="2362" Text="Biçim Kopyalama"/>  <StrRes Name="2363" Text='+
'"Geri Al"/>  <StrRes Name="2364" Text="Yenile"/>  <StrRes Name="2365" Text="Grup'+
'la"/>  <StrRes Name="2366" Text="Grup Çöz"/>  <StrRes Name="2367" Text="Çizgiler'+
'i Göster"/>  <StrRes Name="2368" Text="Çizgilere Hizala"/>  <StrRes Name="2369" '+
'Text="Çizgilere Sýðdýr"/>  <StrRes Name="2370" Text="Yaklaþ"/>  <StrRes Name="23'+
'71" Text="Ekstra Araçlar"/>  <StrRes Name="2372" Text="Seçim Aracý"/>  <StrRes N'+
'ame="2373" Text="El Aracý"/>  <StrRes Name="2374" Text="Yakýnlaþtýrma Aracý"/>  '+
'<StrRes Name="2375" Text="Metin Düzenleme Aracý"/>  <StrRes Name="2376" Text="Bi'+
'çim Kopyalama Aracý"/>  <StrRes Name="2377" Text="Band Aracý"/>  <StrRes Name="2'+
'378" Text="&amp;Dosya"/>  <StrRes Name="2379" Text="Dü&amp;zen"/>  <StrRes Name='+
'"2380" Text="Bul..."/>  <StrRes Name="2381" Text="Sonrakini Bul"/>  <StrRes Name'+
'="2382" Text="Deðiþtir..."/>  <StrRes Name="2383" Text="&amp;Rapor"/>  <StrRes N'+
'ame="2384" Text="Veri..."/>  <StrRes Name="2385" Text="Seçenekler..."/>  <StrRes'+
' Name="2386" Text="Biçimler..."/>  <StrRes Name="2387" Text="&amp;Görünüm"/>  <S'+
'trRes Name="2388" Text="Araç Kutusu"/>  <StrRes Name="2389" Text="Standart"/>  <'+
'StrRes Name="2390" Text="Metin"/>  <StrRes Name="2391" Text="Çerçeve"/>  <StrRes'+
' Name="2392" Text="Hizalama Paleti"/>  <StrRes Name="2393" Text="Ekstra Araçlar"'+
'/>  <StrRes Name="2394" Text="Nesne Yöneticisi"/>  <StrRes Name="2395" Text="Ver'+
'i Aðacý"/>  <StrRes Name="2396" Text="Rapor Aðacý"/>  <StrRes Name="2397" Text="'+
'Kurallar"/>  <StrRes Name="2398" Text="Rehberler"/>  <StrRes Name="2399" Text="R'+
'ehber Sil"/>  <StrRes Name="2400" Text="Seçenekler..."/>  <StrRes Name="2401" Te'+
'xt="&amp;Yardým"/>  <StrRes Name="2402" Text="Ýçindekiler..."/>  <StrRes Name="2'+
'403" Text="FastReport Hakkýnda..."/>  <StrRes Name="2404" Text="Tab Sýrasý..."/>'+
'  <StrRes Name="2405" Text="Geri Al"/>  <StrRes Name="2406" Text="Yenile"/>  <St'+
'rRes Name="2407" Text="Kes"/>  <StrRes Name="2408" Text="Kopyala"/>  <StrRes Nam'+
'e="2409" Text="Yapýþtýr"/>  <StrRes Name="2410" Text="Grupla"/>  <StrRes Name="2'+
'411" Text="Grup çöz"/>  <StrRes Name="2412" Text="Sil"/>  <StrRes Name="2413" Te'+
'xt="Sayfa Sil"/>  <StrRes Name="2414" Text="Tümünü Seç"/>  <StrRes Name="2415" T'+
'ext="Düzenle..."/>  <StrRes Name="2416" Text="Öne Getir"/>  <StrRes Name="2417" '+
'Text="Alta Gönder"/>  <StrRes Name="2418" Text="Yeni..."/>  <StrRes Name="2419" '+
'Text="Yeni Rapor"/>  <StrRes Name="2420" Text="Yeni Sayfa"/>  <StrRes Name="2421'+
'" Text="Yeni Diyalog"/>  <StrRes Name="2422" Text="Aç..."/>  <StrRes Name="2423"'+
' Text="Kaydet"/>  <StrRes Name="2424" Text="Farklý Kaydet..."/>  <StrRes Name="2'+
'425" Text="Deðiþkenler..."/>  <StrRes Name="2426" Text="Sayfa Ayarlarý..."/>  <S'+
'trRes Name="2427" Text="Önizleme"/>  <StrRes Name="2428" Text="Çýkýþ"/>  <StrRes'+
' Name="2429" Text="Rapor Baþlýðý"/>  <StrRes Name="2430" Text="Rapor Özeti"/>  <'+
'StrRes Name="2431" Text="Sayfa Baþlýðý"/>  <StrRes Name="2432" Text="Sayfa Sonu"'+
'/>  <StrRes Name="2433" Text="Üst Baþlýk"/>  <StrRes Name="2434" Text="Alt Baþlý'+
'k"/>  <StrRes Name="2435" Text="Asýl Veri"/>  <StrRes Name="2436" Text="Detay Ve'+
'ri"/>  <StrRes Name="2437" Text="Altdetay Veri"/>  <StrRes Name="2438" Text="4. '+
'Seviye Veri"/>  <StrRes Name="2439" Text="5. Seviye Veri"/>  <StrRes Name="2440"'+
' Text="6. Seviye Veri"/>  <StrRes Name="2441" Text="Grup Baþlýðý"/>  <StrRes Nam'+
'e="2442" Text="Grup Sonu"/>  <StrRes Name="2443" Text="Çocuk"/>  <StrRes Name="2'+
'444" Text="Kolon Baþlýðý"/>  <StrRes Name="2445" Text="Kolon Sonu"/>  <StrRes Na'+
'me="2446" Text="Yardýmcý"/>  <StrRes Name="2447" Text="Dikey Bandlar"/>  <StrRes'+
' Name="2448" Text="Üst Baþlýk"/>  <StrRes Name="2449" Text="Alt Baþlýk"/>  <StrR'+
'es Name="2450" Text="Asýl Veri"/>  <StrRes Name="2451" Text="Detay Veri"/>  <Str'+
'Res Name="2452" Text="Altdetay Veri"/>  <StrRes Name="2453" Text="Grup Baþlýðý"/'+
'>  <StrRes Name="2454" Text="Grup Sonu"/>  <StrRes Name="2455" Text="Çocuk"/>  <'+
'StrRes Name="2456" Text="0°"/>  <StrRes Name="2457" Text="45°"/>  <StrRes Name="'+
'2458" Text="90°"/>  <StrRes Name="2459" Text="180°"/>  <StrRes Name="2460" Text='+
'"270°"/>  <StrRes Name="2461" Text="Yazý Tipi Ayarlarý"/>  <StrRes Name="2462" T'+
'ext="Kalýn"/>  <StrRes Name="2463" Text="Ýtalik"/>  <StrRes Name="2464" Text="Al'+
'tý Çizgili"/>  <StrRes Name="2465" Text="Üst Simge"/>  <StrRes Name="2466" Text='+
'"Alt Simge"/>  <StrRes Name="2467" Text="Sýkýþtýrýlmýþ"/>  <StrRes Name="2468" T'+
'ext="Geniþ"/>  <StrRes Name="2469" Text="12 cpi"/>  <StrRes Name="2470" Text="15'+
' cpi"/>  <StrRes Name="2471" Text="Rapor (*.fr3)|*.fr3"/>  <StrRes Name="2472" T'+
'ext="Pascal dosyalarý (*.pas)|*.pas|C++ dosyalarý (*.cpp)|*.cpp|Java Programcýk '+
'dosyalarý (*.js)|*.js|Basic dosyalarý (*.vb)|*.vb|Tüm dosyalar|*.*"/>  <StrRes N'+
'ame="2473" Text="Pascal dosyalarý (*.pas)|*.pas|C++ dosyalarý (*.cpp)|*.cpp|Java'+
' Programcýk dosyalarý (*.js)|*.js|Basic dosyalarý (*.vb)|*.vb|Tüm dosyalar|*.*"/'+
'>  <StrRes Name="2474" Text="Baglantýlar..."/>  <StrRes Name="2475" Text="Lisan"'+
'/>  <StrRes Name="2476" Text="Toggle breakpoint"/>  <StrRes Name="2477" Text="Ru'+
'n to cursor"/>  <StrRes Name="2478" Text="Çocuk band ekle"/>  <StrRes Name="dsCm'+
'" Text="Santimetre"/>  <StrRes Name="dsInch" Text="Ýnç"/>  <StrRes Name="dsPix" '+
'Text="Piksel"/>  <StrRes Name="dsChars" Text="Karakter"/>  <StrRes Name="dsCode"'+
' Text="Kod"/>  <StrRes Name="dsData" Text="Data"/>  <StrRes Name="dsPage" Text="'+
'Sayfa"/>  <StrRes Name="dsRepFilter" Text="Rapor (*.fr3)|*.fr3"/>  <StrRes Name='+
'"dsComprRepFilter" Text="Sýkýþtýrýþmýþ Rapor (*.fr3)|*.fr3"/>  <StrRes Name="dsS'+
'avePreviewChanges" Text="Önizleme sayfasýndaki deðiþiklikler kaydedilsin mi?"/> '+
' <StrRes Name="dsSaveChangesTo" Text="Deðiþikleri Kaydet "/>  <StrRes Name="dsCa'+
'ntLoad" Text="Dosya Açýlamadý"/>  <StrRes Name="dsStyleFile" Text="Biçim Dosyasý'+
'"/>  <StrRes Name="dsCantFindProc" Text="Ana prosedür bulunamadý"/>  <StrRes Nam'+
'e="dsClearScript" Text="Tüm kod silinecek. Devam etmek istiyor musunuz?"/>  <Str'+
'Res Name="dsNoStyle" Text="Biçim yok"/>  <StrRes Name="dsStyleSample" Text="Örne'+
'k biçim"/>  <StrRes Name="dsTextNotFound" Text="''%s'' metni bulunamadý"/>  <StrRe'+
's Name="dsReplace" Text="''%s'' metnini deðiþtirmek istiyor musunuz?"/>  <StrRes N'+
'ame="2600" Text="FastReport Hakkýnda"/>  <StrRes Name="2601" Text="Daha fazla bi'+
'lgi için Web sayfamýzý ziyaret edin:"/>  <StrRes Name="2602" Text="Satýþ:"/>  <S'+
'trRes Name="2603" Text="Destek:"/>  <StrRes Name="2700" Text="Sayfa Seçenekleri"'+
'/>  <StrRes Name="2701" Text="Kaðýt"/>  <StrRes Name="2702" Text="Geniþlik"/>  <'+
'StrRes Name="2703" Text="Yükseklik"/>  <StrRes Name="2704" Text="Ölçü"/>  <StrRe'+
's Name="2705" Text="Yönlendirme"/>  <StrRes Name="2706" Text="Sol"/>  <StrRes Na'+
'me="2707" Text="Üst"/>  <StrRes Name="2708" Text="Sað"/>  <StrRes Name="2709" Te'+
'xt="Alt"/>  <StrRes Name="2710" Text="Boþluklar"/>  <StrRes Name="2711" Text="Ka'+
'ðýt Kaynaðý"/>  <StrRes Name="2712" Text="Ýlk sayfa"/>  <StrRes Name="2713" Text'+
'="Diðer sayfalar"/>  <StrRes Name="2714" Text="Dikey"/>  <StrRes Name="2715" Tex'+
't="Yatay"/>  <StrRes Name="2716" Text="Diðer Seçenekler"/>  <StrRes Name="2717" '+
'Text="Kolonlar"/>  <StrRes Name="2718" Text="Sayý"/>  <StrRes Name="2719" Text="'+
'Geniþlik"/>  <StrRes Name="2720" Text="Konumlar"/>  <StrRes Name="2721" Text="Di'+
'ðer"/>  <StrRes Name="2722" Text="Çift Yönlü"/>  <StrRes Name="2723" Text="Öncek'+
'i sayfayý yazdýr"/>  <StrRes Name="2724" Text="Boþluklarý yansýt"/>  <StrRes Nam'+
'e="2725" Text="Dizayn aþamasýnda sayfalar büyük uzunlukta"/>  <StrRes Name="2726'+
'" Text="Kesintisiz sayfa geniþliði"/>  <StrRes Name="2727" Text="Kesintisiz sayf'+
'a uzunluðu"/>  <StrRes Name="2800" Text="Rapor Dataset''ini Seç"/>  <StrRes Name='+
'"2900" Text="Deðiþkenleri Düzenle"/>  <StrRes Name="2901" Text="Kategori"/>  <St'+
'rRes Name="2902" Text="Deðiþken"/>  <StrRes Name="2903" Text="Düzenle"/>  <StrRe'+
's Name="2904" Text="Sil"/>  <StrRes Name="2905" Text="Liste"/>  <StrRes Name="29'+
'06" Text="Yükle"/>  <StrRes Name="2907" Text="Kaydet"/>  <StrRes Name="2908" Tex'+
't=" Ýfade:"/>  <StrRes Name="2909" Text="Sözlük (*.fd3)|*.fd3"/>  <StrRes Name="'+
'2910" Text="Sözlük (*.fd3)|*.fd3"/>  <StrRes Name="vaNoVar" Text="(deðiþlem taný'+
'mlanmamýþ)"/>  <StrRes Name="vaVar" Text="Deðiþlenler"/>  <StrRes Name="vaDupNam'+
'e" Text="Ayný isim"/>  <StrRes Name="3000" Text="Dizayn Seçenekleri"/>  <StrRes '+
'Name="3001" Text="Tablo"/>  <StrRes Name="3002" Text="Tür"/>  <StrRes Name="3003'+
'" Text="Ölçü"/>  <StrRes Name="3004" Text="Diyalog pencersi:"/>  <StrRes Name="3'+
'005" Text="Diðer"/>  <StrRes Name="3006" Text="Yazý Tipileri"/>  <StrRes Name="3'+
'007" Text="Kode penceresi"/>  <StrRes Name="3008" Text="Text düzenleyici"/>  <St'+
'rRes Name="3009" Text="Ölçü"/>  <StrRes Name="3010" Text="Ölçü"/>  <StrRes Name='+
'"3011" Text="Renkler"/>  <StrRes Name="3012" Text="Bandlar arasýndaki boþluk:"/>'+
'  <StrRes Name="3013" Text="cm"/>  <StrRes Name="3014" Text="in"/>  <StrRes Name'+
'="3015" Text="pt"/>  <StrRes Name="3016" Text="pt"/>  <StrRes Name="3017" Text="'+
'pt"/>  <StrRes Name="3018" Text="Santimetre:"/>  <StrRes Name="3019" Text="Ýnç:"'+
'/>  <StrRes Name="3020" Text="Pixel:"/>  <StrRes Name="3021" Text="Tabloyu göste'+
'r"/>  <StrRes Name="3022" Text="Tabloya Hizala"/>  <StrRes Name="3023" Text="Ekl'+
'edikten sonra düzenle"/>  <StrRes Name="3024" Text="Nesnenin yazý tipi ayarlarýn'+
'ý kullan"/>  <StrRes Name="3025" Text="Çalýþma Alaný"/>  <StrRes Name="3026" Tex'+
't="Araç Penceresi"/>  <StrRes Name="3027" Text="LCD tablo rengi"/>  <StrRes Name'+
'="3028" Text="Boþ band alaný"/>  <StrRes Name="3029" Text="Açýlýr sahalarý görün'+
'tüle"/>  <StrRes Name="3030" Text="Açýlýþ ekraný görüntüle"/>  <StrRes Name="303'+
'1" Text="Varsayýlan ayarlara dön"/>  <StrRes Name="3032" Text="Band etiketlerini'+
' göster"/>  <StrRes Name="3100" Text="DataSet seç"/>  <StrRes Name="3101" Text="'+
'Kayýt sayýsý:"/>  <StrRes Name="dbNotAssigned" Text="[atanmamýþ]"/>  <StrRes Nam'+
'e="3200" Text="Grup"/>  <StrRes Name="3201" Text="Kes"/>  <StrRes Name="3202" Te'+
'xt="Seçenekler"/>  <StrRes Name="3203" Text="Veri Sahasý"/>  <StrRes Name="3204"'+
' Text="Ýfade"/>  <StrRes Name="3205" Text="Grubu birlikte tut"/>  <StrRes Name="'+
'3206" Text="Yeni sayfaya baþla"/>  <StrRes Name="3207" Text="Ana hatlar içinde g'+
'öster"/>  <StrRes Name="3300" Text="Sistem Metni"/>  <StrRes Name="3301" Text="V'+
'eri Bandý"/>  <StrRes Name="3302" Text="DataSet"/>  <StrRes Name="3303" Text="Ve'+
'riSahasý"/>  <StrRes Name="3304" Text="Fonksiyon"/>  <StrRes Name="3305" Text="Ý'+
'fade"/>  <StrRes Name="3306" Text="Toplam Deðer"/>  <StrRes Name="3307" Text="Si'+
'stem Deðiþkeni"/>  <StrRes Name="3308" Text="Görünmez bandlarýn sayýsý"/>  <StrR'+
'es Name="3309" Text="Metin"/>  <StrRes Name="3310" Text="Toplam Çalýþtýrýlan"/> '+
' <StrRes Name="agAggregate" Text="Toplam Ekle"/>  <StrRes Name="vt1" Text="[DATE'+
']"/>  <StrRes Name="vt2" Text="[TIME]"/>  <StrRes Name="vt3" Text="[PAGE#]"/>  <'+
'StrRes Name="vt4" Text="[TOTALPAGES#]"/>  <StrRes Name="vt5" Text="[PAGE#] / [TO'+
'TALPAGES#]"/>  <StrRes Name="vt6" Text="[LINE#]"/>  <StrRes Name="3400" Text="OL'+
'E Nesnesi"/>  <StrRes Name="3401" Text="Ekle..."/>  <StrRes Name="3402" Text="Dü'+
'zenle..."/>  <StrRes Name="3403" Text="Çýkýþ"/>  <StrRes Name="olStretched" Text'+
'="Uzatýlmýþ"/>  <StrRes Name="3500" Text="Barkod Düzenleyici"/>  <StrRes Name="3'+
'501" Text="Kod"/>  <StrRes Name="3502" Text="Bar''ýn Türü"/>  <StrRes Name="3503"'+
' Text="Yaklaþtýr:"/>  <StrRes Name="3504" Text="Seçenekler"/>  <StrRes Name="350'+
'5" Text="Döndürme Açýsý"/>  <StrRes Name="3506" Text="Saðlamasýný Yap "/>  <StrR'+
'es Name="3507" Text="Rakamlarý Göster"/>  <StrRes Name="3508" Text="0°"/>  <StrR'+
'es Name="3509" Text="90°"/>  <StrRes Name="3510" Text="180°"/>  <StrRes Name="35'+
'11" Text="270°"/>  <StrRes Name="bcCalcChecksum" Text="Saðlamasýný Yap"/>  <StrR'+
'es Name="bcShowText" Text="Metni Göster"/>  <StrRes Name="3600" Text="Görünen ad'+
'ý düzenle"/>  <StrRes Name="3601" Text="Maddeyi düzenlemek için ENTER tuþuna bas'+
'ýn"/>  <StrRes Name="3602" Text="Dataset görünen adý"/>  <StrRes Name="3603" Tex'+
't="Sahalarýn görünen adý"/>  <StrRes Name="3604" Text="Sýfýrla"/>  <StrRes Name='+
'"3605" Text="Güncelle"/>  <StrRes Name="alUserName" Text="Kullanýcý Adý"/>  <Str'+
'Res Name="alOriginal" Text="Orjinal Adý"/>  <StrRes Name="3700" Text="Parametre '+
'Düzenleyici"/>  <StrRes Name="qpName" Text="Adý"/>  <StrRes Name="qpDataType" Te'+
'xt="Veri Türü"/>  <StrRes Name="qpValue" Text="Deðeri"/>  <StrRes Name="3800" Te'+
'xt="Asýl-Detay baðlantýsý"/>  <StrRes Name="3801" Text="Detay sahalarý"/>  <StrR'+
'es Name="3802" Text="Asýl sahalar"/>  <StrRes Name="3803" Text="Baðlantý sahalar'+
'ý"/>  <StrRes Name="3804" Text="Ekle"/>  <StrRes Name="3805" Text="Temizle"/>  <'+
'StrRes Name="3900" Text="Metin"/>  <StrRes Name="3901" Text="Ýfade Ekle"/>  <Str'+
'Res Name="3902" Text="Toplam Ekle"/>  <StrRes Name="3903" Text="Biçimleme Ekle"/'+
'>  <StrRes Name="3904" Text="Sözcük Kaydýr"/>  <StrRes Name="3905" Text="Text"/>'+
'  <StrRes Name="3906" Text="Format"/>  <StrRes Name="3907" Text="Highlight"/>  <'+
'StrRes Name="4000" Text="Resim"/>  <StrRes Name="4001" Text="Yükle"/>  <StrRes N'+
'ame="4002" Text="Kopyala"/>  <StrRes Name="4003" Text="Yapýþtýr"/>  <StrRes Name'+
'="4004" Text="Temizle"/>  <StrRes Name="piEmpty" Text="Boþ"/>  <StrRes Name="410'+
'0" Text="Grafik Düzenleyici"/>  <StrRes Name="4101" Text="Seri Ekle"/>  <StrRes '+
'Name="4102" Text="Seri Sil"/>  <StrRes Name="4103" Text="Grafik düzenle"/>  <Str'+
'Res Name="4104" Text="Band kaynaðý"/>  <StrRes Name="4105" Text="Sabit Veri"/>  '+
'<StrRes Name="4106" Text="Dataset"/>  <StrRes Name="4107" Text="Veri kaynaðý"/> '+
' <StrRes Name="4108" Text="Deðerler"/>  <StrRes Name="4109" Text="Grafik serisi '+
'seçin yada yeni bir tane ekleyin."/>  <StrRes Name="4114" Text="Diðer seçenekler'+
'"/>  <StrRes Name="4115" Text="Enüst N deðeri"/>  <StrRes Name="4116" Text="Enüs'+
't N etiketi"/>  <StrRes Name="4117" Text="Sýralama"/>  <StrRes Name="4126" Text='+
'"X Ekseni"/>  <StrRes Name="ch3D" Text="3D Görüntü"/>  <StrRes Name="chAxis" Tex'+
't="Ekseni göster"/>  <StrRes Name="chsoNone" Text="Yok"/>  <StrRes Name="chsoAsc'+
'ending" Text="Artan"/>  <StrRes Name="chsoDescending" Text="Azalan"/>  <StrRes N'+
'ame="chxtText" Text="Metin"/>  <StrRes Name="chxtNumber" Text="Sayýsal"/>  <StrR'+
'es Name="chxtDate" Text="Tarih"/>  <StrRes Name="4200" Text="Zengin Metin Düzenl'+
'eyici"/>  <StrRes Name="4201" Text="Dosya Aç"/>  <StrRes Name="4202" Text="Dosya'+
' Kaydet"/>  <StrRes Name="4203" Text="Geri"/>  <StrRes Name="4204" Text="Yazý Ti'+
'pi"/>  <StrRes Name="4205" Text="Ýfade Ekle"/>  <StrRes Name="4206" Text="Kalýn"'+
'/>  <StrRes Name="4207" Text="Ýtalik"/>  <StrRes Name="4208" Text="Altý Çizgili"'+
'/>  <StrRes Name="4209" Text="Sola Hizalý"/>  <StrRes Name="4210" Text="Ortalý"/'+
'>  <StrRes Name="4211" Text="Saða Hizalý"/>  <StrRes Name="4212" Text="Ýki Yana '+
'Hizalý"/>  <StrRes Name="4213" Text="Madde Ými"/>  <StrRes Name="4300" Text="Tab'+
'lo Düzenleyici"/>  <StrRes Name="4301" Text="Kaynak Veri"/>  <StrRes Name="4302"'+
' Text="Boyutlar"/>  <StrRes Name="4303" Text="Satýrlar"/>  <StrRes Name="4304" T'+
'ext="Kolonlar"/>  <StrRes Name="4305" Text="Hücreler"/>  <StrRes Name="4306" Tex'+
't="Tablo Yapýsý"/>  <StrRes Name="4307" Text="Satýr baþlýðý"/>  <StrRes Name="43'+
'08" Text="Kolon baþlýðý"/>  <StrRes Name="4309" Text="Satýr genel toplamý"/>  <S'+
'trRes Name="4310" Text="Kolon genel toplamý"/>  <StrRes Name="4311" Text="Satýrl'+
'arý/Kolonlarý deðiþtir"/>  <StrRes Name="4312" Text="Stil seç"/>  <StrRes Name="'+
'4313" Text="Mevcut stili kaydet..."/>  <StrRes Name="4314" Text="Baþlýk göster"/'+
'>  <StrRes Name="4315" Text="Köþe göster"/>  <StrRes Name="4316" Text="Baþlýklar'+
'ý yeni sayfada yazdýr"/>  <StrRes Name="4317" Text="Otomatik boyutlandýr"/>  <St'+
'rRes Name="4318" Text="Hücre etrafý çerçeveler"/>  <StrRes Name="4319" Text="Çap'+
'raz bastýr"/>  <StrRes Name="4320" Text="Taraf tarafa hücreler"/>  <StrRes Name='+
'"4321" Text="Eþit hücreleri birleþtir"/>  <StrRes Name="4322" Text="Yok"/>  <Str'+
'Res Name="4323" Text="Toplam"/>  <StrRes Name="4324" Text="Mininum"/>  <StrRes N'+
'ame="4325" Text="Maksimum"/>  <StrRes Name="4326" Text="Ortalama"/>  <StrRes Nam'+
'e="4327" Text="Sayý"/>  <StrRes Name="4328" Text="Artan Sýralama (A-Z)"/>  <StrR'+
'es Name="4329" Text="Azalan Sýralama (Z-A)"/>  <StrRes Name="4330" Text="Sýralam'+
'a Yok"/>  <StrRes Name="crStName" Text="Stil adý girin:"/>  <StrRes Name="crResi'+
'ze" Text="Çapraz tabloyu yeniden boyutlandýr, Bunun için Autosize''ý false yapýn.'+
'"/>  <StrRes Name="crSubtotal" Text="Alttoplam"/>  <StrRes Name="crNone" Text="Y'+
'ok"/>  <StrRes Name="crSum" Text="Top"/>  <StrRes Name="crMin" Text="Min"/>  <St'+
'rRes Name="crMax" Text="Max"/>  <StrRes Name="crAvg" Text="Ort"/>  <StrRes Name='+
'"crCount" Text="Sayý"/>  <StrRes Name="crAsc" Text="A-Z"/>  <StrRes Name="crDesc'+
'" Text="Z-A"/>  <StrRes Name="crFillMx" Text="Tablo dolduruluyor..."/>  <StrRes '+
'Name="crBuildMx" Text="Tablo yapýlandýrýlýyor..."/>  <StrRes Name="4400" Text="Ý'+
'fade Düzenleyici"/>  <StrRes Name="4401" Text="Ýfade:"/>  <StrRes Name="4500" Te'+
'xt="Görüntü Biçimi"/>  <StrRes Name="4501" Text="Kategori"/>  <StrRes Name="4502'+
'" Text="Biçim"/>  <StrRes Name="4503" Text="Biçim metni:"/>  <StrRes Name="4504"'+
' Text="Ondalýk ayracý:"/>  <StrRes Name="fkText" Text="Metin (biçimlendirilmemiþ'+
')"/>  <StrRes Name="fkNumber" Text="Sayý"/>  <StrRes Name="fkDateTime" Text="Tar'+
'ih/Saat"/>  <StrRes Name="fkBoolean" Text="Doðru/Yanlýþ"/>  <StrRes Name="fkNumb'+
'er1" Text="1234.5;%g"/>  <StrRes Name="fkNumber2" Text="1234.50;%2.2f"/>  <StrRe'+
's Name="fkNumber3" Text="1,234.50;%2.2n"/>  <StrRes Name="fkNumber4" Text="$1,23'+
'4.50;%2.2m"/>  <StrRes Name="fkDateTime1" Text="11.28.2002;mm.dd.yyyy"/>  <StrRe'+
's Name="fkDateTime2" Text="28 ksm 2002;dd mmm yyyy"/>  <StrRes Name="fkDateTime3'+
'" Text="Kasým 28, 2002;mmmm dd, yyyy"/>  <StrRes Name="fkDateTime4" Text="02:14;'+
'hh:mm"/>  <StrRes Name="fkDateTime5" Text="02:14am;hh:mm am/pm"/>  <StrRes Name='+
'"fkDateTime6" Text="02:14:00;hh:mm:ss"/>  <StrRes Name="fkDateTime7" Text="02:14'+
'am, Kasým 28, 2002;hh:mm am/pm, mmmm dd, yyyy"/>  <StrRes Name="fkBoolean1" Text'+
'="0,1;0,1"/>  <StrRes Name="fkBoolean2" Text="Hayýr,Evet;Hayýr,Evet"/>  <StrRes '+
'Name="fkBoolean3" Text="_,x;_,x"/>  <StrRes Name="fkBoolean4" Text="Yanlýþ,Doðru'+
';Yanlýþ,Doðru"/>  <StrRes Name="4600" Text="Vurgu"/>  <StrRes Name="4601" Text="'+
'Renk..."/>  <StrRes Name="4602" Text="Renk..."/>  <StrRes Name="4603" Text="Koþu'+
'l"/>  <StrRes Name="4604" Text="Yazý Tipi"/>  <StrRes Name="4605" Text="Arkaplan'+
'"/>  <StrRes Name="4606" Text="Kalýn"/>  <StrRes Name="4607" Text="Ýtalik"/>  <S'+
'trRes Name="4608" Text="Altý Çizgili"/>  <StrRes Name="4609" Text="Saydam"/>  <S'+
'trRes Name="4610" Text="Diðer"/>  <StrRes Name="4700" Text="Rapor Ayarlarý"/>  <'+
'StrRes Name="4701" Text="Genel"/>  <StrRes Name="4702" Text="Yazýcý Ayarlarý"/> '+
' <StrRes Name="4703" Text="Kopya"/>  <StrRes Name="4704" Text="Genel"/>  <StrRes'+
' Name="4705" Text="Þifre"/>  <StrRes Name="4706" Text="Harmanlý kopya"/>  <StrRe'+
's Name="4707" Text="Ýkinci Geçiþ"/>  <StrRes Name="4708" Text="Boþsa Yaz"/>  <St'+
'rRes Name="4709" Text="Tanýmlama"/>  <StrRes Name="4710" Text="Adý"/>  <StrRes N'+
'ame="4711" Text="Tanýmlama"/>  <StrRes Name="4712" Text="Resim"/>  <StrRes Name='+
'"4713" Text="Yazar"/>  <StrRes Name="4714" Text="Majör"/>  <StrRes Name="4715" T'+
'ext="Minör"/>  <StrRes Name="4716" Text="Sunum"/>  <StrRes Name="4717" Text="Yap'+
'ý"/>  <StrRes Name="4718" Text="Oluþturuldu"/>  <StrRes Name="4719" Text="Deðiþt'+
'iriildi"/>  <StrRes Name="4720" Text="Tanýmlama"/>  <StrRes Name="4721" Text="Ve'+
'rsiyon"/>  <StrRes Name="4722" Text="Göz At..."/>  <StrRes Name="4723" Text="Mir'+
'as ayarlarý"/>  <StrRes Name="4724" Text="Seçenekleri seçin:"/>  <StrRes Name="4'+
'725" Text="Deðiþtirme"/>  <StrRes Name="4726" Text="Ana rapordan ayýr"/>  <StrRe'+
's Name="4727" Text="Ana rapordan miras al:"/>  <StrRes Name="4728" Text="Miras"/'+
'>  <StrRes Name="rePrnOnPort" Text="üzerinde"/>  <StrRes Name="riNotInherited" T'+
'ext="Bu rapor miras almamýþ."/>  <StrRes Name="riInherited" Text="Bu rapor þu an'+
'a rapordan miras almýþ: %s"/>  <StrRes Name="4800" Text="Satýr"/>  <StrRes Name='+
'"4900" Text="SQL"/>  <StrRes Name="4901" Text="Query Builder"/>  <StrRes Name="5'+
'000" Text="Þifre"/>  <StrRes Name="5001" Text="Þifreyi girin:"/>  <StrRes Name="'+
'5100" Text="Biçim Düzenleyici"/>  <StrRes Name="5101" Text="Renk..."/>  <StrRes '+
'Name="5102" Text="Yazý Tipi..."/>  <StrRes Name="5103" Text="Çerçeve..."/>  <Str'+
'Res Name="5104" Text="Ekle"/>  <StrRes Name="5105" Text="Sil"/>  <StrRes Name="5'+
'106" Text="Düzenle"/>  <StrRes Name="5107" Text="Yükle"/>  <StrRes Name="5108" T'+
'ext="Kaydet"/>  <StrRes Name="5200" Text="Çerçeve Düzenleyici"/>  <StrRes Name="'+
'5201" Text="Çerçeve"/>  <StrRes Name="5202" Text="Çerçeve Çizgisi"/>  <StrRes Na'+
'me="5203" Text="Gölge"/>  <StrRes Name="5204" Text="Üst Çizgi"/>  <StrRes Name="'+
'5205" Text="Alt Çizgi"/>  <StrRes Name="5206" Text="Sol Çizgi"/>  <StrRes Name="'+
'5207" Text="Sað Çizgi"/>  <StrRes Name="5208" Text="Tüm Çerçeve Çizgileri"/>  <S'+
'trRes Name="5209" Text="Çerçeve Yok"/>  <StrRes Name="5210" Text="Çerçeve Rengi"'+
'/>  <StrRes Name="5211" Text="Çerçeve Biçimi"/>  <StrRes Name="5212" Text="Çerçe'+
've Geniþliði"/>  <StrRes Name="5213" Text="Gölge"/>  <StrRes Name="5214" Text="G'+
'ölge Rengi"/>  <StrRes Name="5215" Text="Gölge Geniþliði"/>  <StrRes Name="5300"'+
' Text="Yeni Madde"/>  <StrRes Name="5301" Text="Maddeler"/>  <StrRes Name="5302"'+
' Text="Þablonlar"/>  <StrRes Name="5303" Text="Rapor miras"/>  <StrRes Name="540'+
'0" Text="Tab Sýrasý"/>  <StrRes Name="5401" Text="Tab sýrasýna göre nesne listes'+
'i:"/>  <StrRes Name="5402" Text="Yukarý Taþý"/>  <StrRes Name="5403" Text="Aþaðý'+
' Taþý"/>  <StrRes Name="5500" Text="Deðerlendirme"/>  <StrRes Name="5501" Text="'+
'Ýfade"/>  <StrRes Name="5502" Text="Sonuç"/>  <StrRes Name="5600" Text="Rapor Si'+
'hirbazý"/>  <StrRes Name="5601" Text="Veri"/>  <StrRes Name="5602" Text="Sahalar'+
'"/>  <StrRes Name="5603" Text="Gruplar"/>  <StrRes Name="5604" Text="Alan"/>  <S'+
'trRes Name="5605" Text="Biçim"/>  <StrRes Name="5606" Text="Adým 1. dataset seç.'+
'"/>  <StrRes Name="5607" Text="Adým 2. Görüntülenecek sahalarý seç."/>  <StrRes '+
'Name="5608" Text="Adým 3. Gruplarý oluþtur (seçime baðlý)."/>  <StrRes Name="560'+
'9" Text="Adým 4. Sayfa yönünü ve veri þeklini tanýmla."/>  <StrRes Name="5610" T'+
'ext="Adým 5. Rapor stilini seç."/>  <StrRes Name="5611" Text="Ekle &#62;"/>  <St'+
'rRes Name="5612" Text="Hepsini ekle &#62;&#62;"/>  <StrRes Name="5613" Text="&#6'+
'0; Kaldýr"/>  <StrRes Name="5614" Text="&#60;&#60; Hepsini kaldýr"/>  <StrRes Na'+
'me="5615" Text="Ekle &#62;"/>  <StrRes Name="5616" Text="&#60; Kaldýr"/>  <StrRe'+
's Name="5617" Text="Seçili sahalar:"/>  <StrRes Name="5618" Text="Kullanýlabilir'+
' sahalar:"/>  <StrRes Name="5619" Text="Gruplar:"/>  <StrRes Name="5620" Text="Y'+
'önlendirme"/>  <StrRes Name="5621" Text="Yerleþtirme "/>  <StrRes Name="5622" Te'+
'xt="Dikey"/>  <StrRes Name="5623" Text="Yatay"/>  <StrRes Name="5624" Text="List'+
'e Þekli"/>  <StrRes Name="5625" Text="Kart Þekli"/>  <StrRes Name="5626" Text="S'+
'ahalarý sayfa geniþliðine sýðdýr"/>  <StrRes Name="5627" Text="&#60;&#60; Geri"/'+
'>  <StrRes Name="5628" Text="Ýleri &#62;&#62;"/>  <StrRes Name="5629" Text="Son"'+
'/>  <StrRes Name="5630" Text="Yeni tablo..."/>  <StrRes Name="5631" Text="Yeni s'+
'orgu..."/>  <StrRes Name="5632" Text="Veri tabaný baðlantýsý seç:"/>  <StrRes Na'+
'me="5633" Text="Tablo seç:"/>  <StrRes Name="5634" Text="veya"/>  <StrRes Name="'+
'5635" Text="Sorgu yarat..."/>  <StrRes Name="5636" Text="Baðlantýlarý düzenle"/>'+
'  <StrRes Name="wzStd" Text="Standart Rapor Sihirbazý"/>  <StrRes Name="wzDMP" T'+
'ext="Nokta-Vuruþlu Rapor Sihirbazý"/>  <StrRes Name="wzStdEmpty" Text="Standart '+
'Rapor"/>  <StrRes Name="wzDMPEmpty" Text="Nokta-Vuruþlu Rapor"/>  <StrRes Name="'+
'5700" Text="Baglantý sihirbazý"/>  <StrRes Name="5701" Text="Baglantý"/>  <StrRe'+
's Name="5702" Text="Baglantý tipini seçiniz:"/>  <StrRes Name="5703" Text="Verit'+
'abaný seçiniz:"/>  <StrRes Name="5704" Text="Kullanýcý"/>  <StrRes Name="5705" T'+
'ext="Sifre"/>  <StrRes Name="5706" Text="Giriþ ekraný sor"/>  <StrRes Name="5707'+
'" Text="Kullanýcý adý/þifre kullan:"/>  <StrRes Name="5708" Text="Tablo"/>  <Str'+
'Res Name="5709" Text="Tablo ismi seciniz:"/>  <StrRes Name="5710" Text="Kayýtlar'+
'ý sorgula:"/>  <StrRes Name="5711" Text="Sorgu"/>  <StrRes Name="5712" Text="SQL'+
' ifadesi:"/>  <StrRes Name="5713" Text="Query Builder"/>  <StrRes Name="5714" Te'+
'xt="Query Parametreleri düzenle"/>  <StrRes Name="ftAllFiles" Text="Tüm Dosyalar'+
'"/>  <StrRes Name="ftPictures" Text="Resimler"/>  <StrRes Name="ftDB" Text="Veri'+
' Dosyalarý"/>  <StrRes Name="ftRichFile" Text="Zengin Metin Dosyasý"/>  <StrRes '+
'Name="ftTextFile" Text="Metin Dosyasý"/>  <StrRes Name="prNotAssigned" Text="(at'+
'anmamýþ)"/>  <StrRes Name="prInvProp" Text="Özellik deðeri geçersiz"/>  <StrRes '+
'Name="prDupl" Text="Tekrarlanan ad"/>  <StrRes Name="prPict" Text="(Resim)"/>  <'+
'StrRes Name="mvExpr" Text="Ýfadelere Ýzin Ver"/>  <StrRes Name="mvStretch" Text='+
'"Sýðdýr"/>  <StrRes Name="mvStretchToMax" Text="Maksimum Yüksekliðe Sýðdýr"/>  <'+
'StrRes Name="mvShift" Text="Kaydýr"/>  <StrRes Name="mvShiftOver" Text="Üzerine '+
'Bindiðinde Kaydýr"/>  <StrRes Name="mvVisible" Text="Görünür"/>  <StrRes Name="m'+
'vPrintable" Text="Yazdýrýlabilir"/>  <StrRes Name="mvFont" Text="Yazý Tipi..."/>'+
'  <StrRes Name="mvFormat" Text="Görüntü Biçimi..."/>  <StrRes Name="mvClear" Tex'+
't="Ýçindekileri Temizle"/>  <StrRes Name="mvAutoWidth" Text="Otomatik Geniþlik"/'+
'>  <StrRes Name="mvWWrap" Text="Sözcük Kaydýr"/>  <StrRes Name="mvSuppress" Text'+
'="Tekrarlanan Deðerleri Gizle"/>  <StrRes Name="mvHideZ" Text="Sýfýrlarý Gizle"/'+
'>  <StrRes Name="mvHTML" Text="HTML Koduna Ýzin ver"/>  <StrRes Name="lvDiagonal'+
'" Text="Çapraz"/>  <StrRes Name="pvAutoSize" Text="Otomatik Boyutlandýr"/>  <Str'+
'Res Name="pvCenter" Text="Ortala"/>  <StrRes Name="pvAspect" Text="Yön Oranýný T'+
'ut"/>  <StrRes Name="bvSplit" Text="Bölünmeye Ýzin Ver"/>  <StrRes Name="bvKeepC'+
'hild" Text="Çocuklarý Birlikte Tut"/>  <StrRes Name="bvPrintChild" Text="Görünme'+
'zse Çocuðu Yazdýr"/>  <StrRes Name="bvStartPage" Text="Yeni Sayfada Baþla"/>  <S'+
'trRes Name="bvPrintIfEmpty" Text="Detayý Boþsa Yazdýr"/>  <StrRes Name="bvKeepDe'+
'tail" Text="Detayý Birlikte Tut"/>  <StrRes Name="bvKeepFooter" Text="Sayfa Sonu'+
'nu Birlikte Tut"/>  <StrRes Name="bvReprint" Text="Yeni Sayfada Tekrar Yazdýr"/>'+
'  <StrRes Name="bvOnFirst" Text="Ýlk Sayfada Yazdýr"/>  <StrRes Name="bvOnLast" '+
'Text="Son Sayfada Yazdýr"/>  <StrRes Name="bvKeepGroup" Text="Birlikte Tut"/>  <'+
'StrRes Name="bvFooterAfterEach" Text="Her Satýrdan Sonra Alt Sayfa Sonu"/>  <Str'+
'Res Name="bvDrillDown" Text="Drill-Down"/>  <StrRes Name="bvResetPageNo" Text="S'+
'ayfa numaralarýný sýfýrla"/>  <StrRes Name="srParent" Text="Üzerinde Bulunduðu N'+
'esnede Yazdýr"/>  <StrRes Name="bvKeepHeader" Text="Baþlýðý birlikte tut"/>  <St'+
'rRes Name="obCatDraw" Text="Çizim"/>  <StrRes Name="obCatOther" Text="Diðer nesn'+
'eler"/>  <StrRes Name="obCatOtherControls" Text="Diðer kontroller"/>  <StrRes Na'+
'me="obDiagLine" Text="Çapraz çizgi"/>  <StrRes Name="obRect" Text="Dikdörtgen"/>'+
'  <StrRes Name="obRoundRect" Text="yuvarlanmýþ dikdörtgen"/>  <StrRes Name="obEl'+
'lipse" Text="Elips"/>  <StrRes Name="obTrian" Text="Üçgen"/>  <StrRes Name="obDi'+
'amond" Text="Karo"/>  <StrRes Name="obLabel" Text="Etiket kontrolü"/>  <StrRes N'+
'ame="obEdit" Text="Metin kontrolü"/>  <StrRes Name="obMemoC" Text="Yazý kontrolü'+
'"/>  <StrRes Name="obButton" Text="Düðme kontrolü"/>  <StrRes Name="obChBoxC" Te'+
'xt="Onay Kutusu kontrolü"/>  <StrRes Name="obRButton" Text="Radyo Düðme kontrolü'+
'"/>  <StrRes Name="obLBox" Text="Liste Kutusu kontrolü"/>  <StrRes Name="obCBox"'+
' Text="Açýlan Liste Kutusu kontrolü"/>  <StrRes Name="obDateEdit" Text="Tarih ko'+
'ntrolü"/>  <StrRes Name="obImageC" Text="Resim kontrolü"/>  <StrRes Name="obPane'+
'l" Text="Panel kontrolü"/>  <StrRes Name="obGrBox" Text="Grup Kutusu kontrolü"/>'+
'  <StrRes Name="obBBtn" Text="Resimli Düðme kontrolü"/>  <StrRes Name="obSBtn" T'+
'ext="Hýzlý Düðme kontrolü"/>  <StrRes Name="obMEdit" Text="Biçimli Metin kontrol'+
'ü"/>  <StrRes Name="obChLB" Text="OnayListesiKutusu kontrolü"/>  <StrRes Name="o'+
'bDBLookup" Text="DBSorguluAçýlanListeKutusu kontrolü"/>  <StrRes Name="obBevel" '+
'Text="Bevel kontrolü"/>  <StrRes Name="obShape" Text="Þekil nesnesi"/>  <StrRes '+
'Name="obText" Text="Metin nesnesi"/>  <StrRes Name="obSysText" Text="Sistem metn'+
'i"/>  <StrRes Name="obLine" Text="Çizgi nesnesi"/>  <StrRes Name="obPicture" Tex'+
't="Resim nesnesi"/>  <StrRes Name="obBand" Text="Band object"/>  <StrRes Name="o'+
'bDataBand" Text="Veri bandý"/>  <StrRes Name="obSubRep" Text="Alt rapor nesnesi"'+
'/>  <StrRes Name="obDlgPage" Text="Diyalog formu"/>  <StrRes Name="obRepPage" Te'+
'xt="Rapor sayfasý"/>  <StrRes Name="obReport" Text="Rapor nesnesi"/>  <StrRes Na'+
'me="obRich" Text="Zengin metin nesnesi"/>  <StrRes Name="obOLE" Text="OLE nesnes'+
'i"/>  <StrRes Name="obChBox" Text="Onay kutusu nesnesi"/>  <StrRes Name="obChart'+
'" Text="Grafik nesnesi"/>  <StrRes Name="obBarC" Text="Barkod nesnesi"/>  <StrRe'+
's Name="obCross" Text="Çapraz tablo nesnesi"/>  <StrRes Name="obDBCross" Text="D'+
'B Çapraz tablo nesnesi"/>  <StrRes Name="obGrad" Text="Dereceli renk nesnesi"/> '+
' <StrRes Name="obDMPText" Text="Nokta-vuruþlu metin nesnesi"/>  <StrRes Name="ob'+
'DMPLine" Text="Nokta-vuruþlu satýr nesnesi"/>  <StrRes Name="obDMPCmd" Text="Dot'+
'-matrix komut nesnesi"/>  <StrRes Name="obBDEDB" Text="BDE Veritabaný"/>  <StrRe'+
's Name="obBDETb" Text="BDE Tablosu"/>  <StrRes Name="obBDEQ" Text="BDE Sorgusu"/'+
'>  <StrRes Name="obBDEComps" Text="BDE Komponentleri"/>  <StrRes Name="obIBXDB" '+
'Text="IBX Veritabaný"/>  <StrRes Name="obIBXTb" Text="IBX Tablo"/>  <StrRes Name'+
'="obIBXQ" Text="IBX Sorgusu"/>  <StrRes Name="obIBXComps" Text="IBX Komponentler'+
'i"/>  <StrRes Name="obADODB" Text="ADO Veritabaný"/>  <StrRes Name="obADOTb" Tex'+
't="ADO Tablosu"/>  <StrRes Name="obADOQ" Text="ADO Sorgusu"/>  <StrRes Name="obA'+
'DOComps" Text="ADO Komponentleri"/>  <StrRes Name="obDBXDB" Text="DBX Veritabaný'+
'"/>  <StrRes Name="obDBXTb" Text="DBX Tablosu"/>  <StrRes Name="obDBXQ" Text="DB'+
'X Sorgusu"/>  <StrRes Name="obDBXComps" Text="DBX Komponentleri"/>  <StrRes Name'+
'="obFIBDB" Text="FIB veritabani"/>  <StrRes Name="obFIBTb" Text="FIB tablo"/>  <'+
'StrRes Name="obFIBQ" Text="FIB sorgu"/>  <StrRes Name="obFIBComps" Text="FIB Kom'+
'ponentleri"/>  <StrRes Name="ctString" Text="Metin"/>  <StrRes Name="ctDate" Tex'+
't="Tarih ve Saat"/>  <StrRes Name="ctConv" Text="Deðiþim"/>  <StrRes Name="ctFor'+
'mat" Text="Biçim"/>  <StrRes Name="ctMath" Text="Matematiksel"/>  <StrRes Name="'+
'ctOther" Text="Diðer"/>  <StrRes Name="IntToStr" Text="Rakamsal deðeri metin biç'+
'imine dönüþtürür"/>  <StrRes Name="FloatToStr" Text="Ondalýklý deðeri metin biçi'+
'mine dönüþtürür"/>  <StrRes Name="DateToStr" Text="Tarih deðeri metin biçimine d'+
'önüþtürür"/>  <StrRes Name="TimeToStr" Text="Saat deðeri metin biçimine dönüþtür'+
'ür"/>  <StrRes Name="DateTimeToStr" Text="Tarih-saat deðeri metin biçimine dönüþ'+
'türür"/>  <StrRes Name="VarToStr" Text="Deðiþebilir deðeri metin biçimine dönüþt'+
'ürür"/>  <StrRes Name="StrToInt" Text="Metni rakamsal biçime dönüþtürür"/>  <Str'+
'Res Name="StrToInt64" Text="Converts a string to an Int64 value"/>  <StrRes Name'+
'="StrToFloat" Text="Metni ondalýklý biçime dönüþtürür"/>  <StrRes Name="StrToDat'+
'e" Text="Metni tarih biçimine dönüþtürür"/>  <StrRes Name="StrToTime" Text="Metn'+
'i saat biçimine dönüþtürür"/>  <StrRes Name="StrToDateTime" Text="Metni tarih-sa'+
'at biçimine dönüþtürür"/>  <StrRes Name="Format" Text="Verilen bir dizi ve metni'+
' biçimlendirerek yeni bir metin döndürür"/>  <StrRes Name="FormatFloat" Text="On'+
'dalýklý deðeri belirli bir formata çevirir"/>  <StrRes Name="FormatDateTime" Tex'+
't="Tarih-saat deðerini belirli bir formata çevirir"/>  <StrRes Name="FormatMaskT'+
'ext" Text="Metni belirli bir formata çevirir"/>  <StrRes Name="EncodeDate" Text='+
'"Yýl, Ay ve Gün olarak gelen bir deðeri Tarih-Saat tipine çevirir"/>  <StrRes Na'+
'me="DecodeDate" Text="Tarih-Saat deðerini Yýl, Ay ve Gün olarak döndürür"/>  <St'+
'rRes Name="EncodeTime" Text="Saat, Dakika, Saniye ve Milisaniye olarak gelen bir'+
' deðeri Tarih-Saat tipine çevirir"/>  <StrRes Name="DecodeTime" Text="Tarih-Saat'+
' deðerini, Saat, Dakika, Saniye ve Milisaniye olarak döndürür"/>  <StrRes Name="'+
'Date" Text="Geçerli tarihi döndürür"/>  <StrRes Name="Time" Text="Geçerli saati '+
'döndürür"/>  <StrRes Name="Now" Text="Geçerli tarih ve saati döndürür"/>  <StrRe'+
's Name="DayOfWeek" Text="Günün hangi haftaya ait olduðunu döndürür"/>  <StrRes N'+
'ame="IsLeapYear" Text="Yýlýn artýk yýl olup olmadýðýný döndürür"/>  <StrRes Name'+
'="DaysInMonth" Text="Ayýn gün sayýsýný döndürür"/>  <StrRes Name="Length" Text="'+
'Metnin uzunluðunu döndürür"/>  <StrRes Name="Copy" Text="Metnin içinden bir alt '+
'metin döndürür"/>  <StrRes Name="Pos" Text="Metnin içinden bir alt metnin baþlan'+
'gýç pozisyonunu verir"/>  <StrRes Name="Delete" Text="Metnin içinden metin siler'+
'"/>  <StrRes Name="Insert" Text="Metnin içine alt metin ekler"/>  <StrRes Name="'+
'Uppercase" Text="Metnin tüm karakterlerini büyük harfe dönüþtürür"/>  <StrRes Na'+
'me="Lowercase" Text="Metnin tüm karakterlerini küçük harfe dönüþtürür"/>  <StrRe'+
's Name="Trim" Text="Metnin baþýndaki ve sonundaki boþluklarý atar"/>  <StrRes Na'+
'me="NameCase" Text="Metnin ilk karakterini büyük harfe dönüþtürür"/>  <StrRes Na'+
'me="CompareText" Text="Ýki metni karþýlaþtýrýr"/>  <StrRes Name="Chr" Text="Raka'+
'msal deðeri karaktere dönüþtürür"/>  <StrRes Name="Ord" Text="Bir karakterin rak'+
'amsal deðerini dönüþtürür"/>  <StrRes Name="SetLength" Text="Metnin uzunluðunu a'+
'yarlar"/>  <StrRes Name="Round" Text="Sayýsal bir deðeri en yakýn deðere yuvarla'+
'r"/>  <StrRes Name="Trunc" Text="Kesirli sayýlarýn tam sayý kýsmýný döndürür"/> '+
' <StrRes Name="Int" Text="Reel bir sayýyý rakamsal sayýya dönüþtürür"/>  <StrRes'+
' Name="Frac" Text="Kesirli sayýlarýn kesir kýsmýný döndürür"/>  <StrRes Name="Sq'+
'rt" Text="Bir sayýnýn karesini döndürür"/>  <StrRes Name="Abs" Text="Tam sayýya '+
'çevirir"/>  <StrRes Name="Sin" Text="Sinüs''e çevirir (radyan''da)"/>  <StrRes Nam'+
'e="Cos" Text="Cosinüs''e çevirir (radyan''da)"/>  <StrRes Name="ArcTan" Text="Arkt'+
'anjanta çevirir"/>  <StrRes Name="Tan" Text="Tanjanta çevirir"/>  <StrRes Name="'+
'Exp" Text="Sayýnýn üstel deðerini döndürür"/>  <StrRes Name="Ln" Text="Reel bir '+
'sayýyý logaritma''ya çevirir"/>  <StrRes Name="Pi" Text="3.1415926... deðerini nu'+
'maraya çevirir"/>  <StrRes Name="Inc" Text="Deðeri arttýrýr"/>  <StrRes Name="De'+
'c" Text="Deðeri azaltýr"/>  <StrRes Name="RaiseException" Text="Ýstisnai durum"/'+
'>  <StrRes Name="ShowMessage" Text="Mesaj kutusu göster"/>  <StrRes Name="Random'+
'ize" Text="Rastgele rakamsal deðer üretir"/>  <StrRes Name="Random" Text="Rastge'+
'le bir rakamsal deðer döndürür"/>  <StrRes Name="ValidInt" Text="Metin geçerli b'+
'ir float deðer içeriyorsa &#38;#34;True&#38;#34; döndürür"/>  <StrRes Name="Vali'+
'dFloat" Text="Metin geçerli bir float deðer içeriyorsa &#38;#34;True&#38;#34; dö'+
'ndürür"/>  <StrRes Name="ValidDate" Text="Metin geçerli bir tarih içeriyorsa &#3'+
'8;#34;True&#38;#34; döndürür"/>  <StrRes Name="IIF" Text="Eðer ifade sonucu doðr'+
'u ise &#38;#34;True&#38;#34; diðer durumlarda &#38;#34;False&#38;#34; döndürür"/'+
'>  <StrRes Name="Get" Text="Sadece iç kullaným için"/>  <StrRes Name="Set" Text='+
'"Sadece iç kullaným için"/>  <StrRes Name="InputBox" Text="Kullanýcýnýn metin gi'+
'rebilmesi için bir bilgi giriþ ekraný gösterir"/>  <StrRes Name="InputQuery" Tex'+
't="Kullanýcýnýn metin girebilmesi için bir bilgi giriþ ekraný gösterir"/>  <StrR'+
'es Name="MessageDlg" Text="Mesaj kutusu göster"/>  <StrRes Name="CreateOleObject'+
'" Text="Bir OLE nesnesi oluþtur"/>  <StrRes Name="VarArrayCreate" Text="Deðiþebi'+
'lir dizi oluþtur"/>  <StrRes Name="VarType" Text="Deðiþebilir deðerin tipini dön'+
'dür"/>  <StrRes Name="DayOf" Text="Verilen tarihten günü (1..31) dönderir"/>  <S'+
'trRes Name="MonthOf" Text="Verilen tarihten ay (1..12) dönderir"/>  <StrRes Name'+
'="YearOf" Text="Verilen tarihten yýlý dönderir"/>  <StrRes Name="ctAggregate" Te'+
'xt="Hesaplamalar"/>  <StrRes Name="Sum" Text="Bandtaki belirtilen alanýn toplamý'+
'ný hesapla"/>  <StrRes Name="Avg" Text="Bandtaki averajlý veriyi hesapla"/>  <St'+
'rRes Name="Min" Text="Bandtaki minimum veriyi hesapla"/>  <StrRes Name="Max" Tex'+
't="Bandtaki maksimum veriyi hesapla"/>  <StrRes Name="Count" Text="Data satýrý k'+
'ayýt sayýsý"/>  <StrRes Name="wzDBConn" Text="Yeni baglanti sihirbazi"/>  <StrRe'+
's Name="wzDBTable" Text="Yeni tablo sihirbazi"/>  <StrRes Name="wzDBQuery" Text='+
'"Yeni sorgu sihirbazi"/>  <StrRes Name="5800" Text="Baglantilar"/>  <StrRes Name'+
'="5801" Text="Yeni"/>  <StrRes Name="5802" Text="Sil"/>  <StrRes Name="cpName" T'+
'ext="Isim"/>  <StrRes Name="cpConnStr" Text="Baglanti bilgisi"/>  <StrRes Name="'+
'startCreateNew" Text="Yeni rapor olustur"/>  <StrRes Name="startCreateBlank" Tex'+
't="Bos rapor olustur"/>  <StrRes Name="startOpenReport" Text="Rapor ac"/>  <StrR'+
'es Name="startOpenLast" Text="Son raporu ac"/>  <StrRes Name="startEditAliases" '+
'Text="Baðlantý takma isimlerini düzenler"/>  <StrRes Name="startHelp" Text="Yard'+
'im"/>  <StrRes Name="5900" Text="Deðer izleme Formu"/>  <StrRes Name="5901" Text'+
'="Deðer ekle"/>  <StrRes Name="5902" Text="Deðeri sil"/>  <StrRes Name="5903" Te'+
'xt="Deðer düzenle"/>  <StrRes Name="6000" Text="Miras hatasý"/>  <StrRes Name="6'+
'001" Text="Ana ve mirasçý raporlarý ayný nesneleri içeriyor, ne yapalým?"/>  <St'+
'rRes Name="6002" Text="Çiftleri sil"/>  <StrRes Name="6003" Text="Ýsimlerini deð'+
'iþtir"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
