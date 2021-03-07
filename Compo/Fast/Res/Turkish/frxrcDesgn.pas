unit frxrcDesgn;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1254">  <StrRes Name='+
'"2000" Text="Nesne Y�neticisi"/>  <StrRes Name="oiProp" Text="�zellikler"/>  <St'+
'rRes Name="oiEvent" Text="Olaylar"/>  <StrRes Name="2100" Text="Veri A�ac�"/>  <'+
'StrRes Name="2101" Text="Veri"/>  <StrRes Name="2102" Text="De�i�kenler"/>  <Str'+
'Res Name="2103" Text="Fonksiyonlar"/>  <StrRes Name="2104" Text="Saha olu�tur"/>'+
'  <StrRes Name="2105" Text="Etiket olu�tur"/>  <StrRes Name="2106" Text="Classes'+
'"/>  <StrRes Name="dtNoData" Text="Kullan�labilir veri yok"/>  <StrRes Name="dtN'+
'oData1" Text="Raporunuz i�in mevcut dataset''i eklemek i�in men�den &#38;#34;Rapo'+
'r|Veri...&#38;#34; k�sm�na gidin &#38;#34;Veri&#38;#34; sekmesini a��p  ve yeni '+
'dataset olu�turun."/>  <StrRes Name="dtData" Text="Veri"/>  <StrRes Name="dtSysV'+
'ar" Text="Sistem de�i�kenleri"/>  <StrRes Name="dtVar" Text="De�i�kenler"/>  <St'+
'rRes Name="dtFunc" Text="Fonksiyonlar"/>  <StrRes Name="2200" Text="Rapor A�ac�"'+
'/>  <StrRes Name="2300" Text="Programc�k Dosyas� A�"/>  <StrRes Name="2301" Text'+
'="Programc�k Dosyas�n� Kaydet"/>  <StrRes Name="2302" Text="Programc�k �al��t�r"'+
'/>  <StrRes Name="2303" Text="��e gir"/>  <StrRes Name="2304" Text="Programc�k s'+
'onland�r"/>  <StrRes Name="2305" Text="De�erlendirme"/>  <StrRes Name="2306" Tex'+
't="Dil:"/>  <StrRes Name="2307" Text="Hizalama"/>  <StrRes Name="2308" Text="Sol'+
'a Hizala"/>  <StrRes Name="2309" Text="Ortala"/>  <StrRes Name="2310" Text="Sa�a'+
' Hizala"/>  <StrRes Name="2311" Text="�ste Hizala"/>  <StrRes Name="2312" Text="'+
'Ortala"/>  <StrRes Name="2313" Text="Alta Hizala"/>  <StrRes Name="2314" Text="Y'+
'atay Bo�luk"/>  <StrRes Name="2315" Text="Dikey Bo�luk"/>  <StrRes Name="2316" T'+
'ext="Band�n ��inde Yatay Ortala"/>  <StrRes Name="2317" Text="Band�n ��inde Dike'+
'y Ortala"/>  <StrRes Name="2318" Text="Ayn� Geni�lik"/>  <StrRes Name="2319" Tex'+
't="Ayn� Y�kseklik"/>  <StrRes Name="2320" Text="Metin"/>  <StrRes Name="2321" Te'+
'xt="Bi�im"/>  <StrRes Name="2322" Text="Yaz� Tipi Ad�"/>  <StrRes Name="2323" Te'+
'xt="Yaz� Tipi B�y�kl���"/>  <StrRes Name="2324" Text="Kal�n"/>  <StrRes Name="23'+
'25" Text="�talik"/>  <StrRes Name="2326" Text="Alt� �izgili"/>  <StrRes Name="23'+
'27" Text="Yaz� Rengi"/>  <StrRes Name="2328" Text="Vurgu"/>  <StrRes Name="2329"'+
' Text="Metin D�nd�rme A��s�"/>  <StrRes Name="2330" Text="Sola Hizala"/>  <StrRe'+
's Name="2331" Text="Ortala"/>  <StrRes Name="2332" Text="Sa�a Hizala"/>  <StrRes'+
' Name="2333" Text="�ki Yana Hizala"/>  <StrRes Name="2334" Text="�ste Hizala"/> '+
' <StrRes Name="2335" Text="Ortala"/>  <StrRes Name="2336" Text="Alta Hizala"/>  '+
'<StrRes Name="2337" Text="�er�eve"/>  <StrRes Name="2338" Text="�st �izgi"/>  <S'+
'trRes Name="2339" Text="Alt �izgi"/>  <StrRes Name="2340" Text="Sol �izgi"/>  <S'+
'trRes Name="2341" Text="Sa� �izgi"/>  <StrRes Name="2342" Text="T�m �er�eve �izg'+
'ileri"/>  <StrRes Name="2343" Text="�er�eve Yok"/>  <StrRes Name="2344" Text="G�'+
'lge"/>  <StrRes Name="2345" Text="Arkaplan Rengi"/>  <StrRes Name="2346" Text="�'+
'er�eve Rengi"/>  <StrRes Name="2347" Text="�er�eve Bi�imi"/>  <StrRes Name="2348'+
'" Text="�er�eve Geni�li�i"/>  <StrRes Name="2349" Text="Standart"/>  <StrRes Nam'+
'e="2350" Text="Yeni Rapor"/>  <StrRes Name="2351" Text="Rapor A�"/>  <StrRes Nam'+
'e="2352" Text="Rapor Kaydet"/>  <StrRes Name="2353" Text="�nizleme"/>  <StrRes N'+
'ame="2354" Text="Yeni Rapor Sayfas�"/>  <StrRes Name="2355" Text="Yeni Diyalog S'+
'ayfas�"/>  <StrRes Name="2356" Text="Sayfa Sil"/>  <StrRes Name="2357" Text="Say'+
'fa Ayarlar�"/>  <StrRes Name="2358" Text="De�i�kenler"/>  <StrRes Name="2359" Te'+
'xt="Kes"/>  <StrRes Name="2360" Text="Kopyala"/>  <StrRes Name="2361" Text="Yap�'+
'�t�r"/>  <StrRes Name="2362" Text="Bi�im Kopyalama"/>  <StrRes Name="2363" Text='+
'"Geri Al"/>  <StrRes Name="2364" Text="Yenile"/>  <StrRes Name="2365" Text="Grup'+
'la"/>  <StrRes Name="2366" Text="Grup ��z"/>  <StrRes Name="2367" Text="�izgiler'+
'i G�ster"/>  <StrRes Name="2368" Text="�izgilere Hizala"/>  <StrRes Name="2369" '+
'Text="�izgilere S��d�r"/>  <StrRes Name="2370" Text="Yakla�"/>  <StrRes Name="23'+
'71" Text="Ekstra Ara�lar"/>  <StrRes Name="2372" Text="Se�im Arac�"/>  <StrRes N'+
'ame="2373" Text="El Arac�"/>  <StrRes Name="2374" Text="Yak�nla�t�rma Arac�"/>  '+
'<StrRes Name="2375" Text="Metin D�zenleme Arac�"/>  <StrRes Name="2376" Text="Bi'+
'�im Kopyalama Arac�"/>  <StrRes Name="2377" Text="Band Arac�"/>  <StrRes Name="2'+
'378" Text="&amp;Dosya"/>  <StrRes Name="2379" Text="D�&amp;zen"/>  <StrRes Name='+
'"2380" Text="Bul..."/>  <StrRes Name="2381" Text="Sonrakini Bul"/>  <StrRes Name'+
'="2382" Text="De�i�tir..."/>  <StrRes Name="2383" Text="&amp;Rapor"/>  <StrRes N'+
'ame="2384" Text="Veri..."/>  <StrRes Name="2385" Text="Se�enekler..."/>  <StrRes'+
' Name="2386" Text="Bi�imler..."/>  <StrRes Name="2387" Text="&amp;G�r�n�m"/>  <S'+
'trRes Name="2388" Text="Ara� Kutusu"/>  <StrRes Name="2389" Text="Standart"/>  <'+
'StrRes Name="2390" Text="Metin"/>  <StrRes Name="2391" Text="�er�eve"/>  <StrRes'+
' Name="2392" Text="Hizalama Paleti"/>  <StrRes Name="2393" Text="Ekstra Ara�lar"'+
'/>  <StrRes Name="2394" Text="Nesne Y�neticisi"/>  <StrRes Name="2395" Text="Ver'+
'i A�ac�"/>  <StrRes Name="2396" Text="Rapor A�ac�"/>  <StrRes Name="2397" Text="'+
'Kurallar"/>  <StrRes Name="2398" Text="Rehberler"/>  <StrRes Name="2399" Text="R'+
'ehber Sil"/>  <StrRes Name="2400" Text="Se�enekler..."/>  <StrRes Name="2401" Te'+
'xt="&amp;Yard�m"/>  <StrRes Name="2402" Text="��indekiler..."/>  <StrRes Name="2'+
'403" Text="FastReport Hakk�nda..."/>  <StrRes Name="2404" Text="Tab S�ras�..."/>'+
'  <StrRes Name="2405" Text="Geri Al"/>  <StrRes Name="2406" Text="Yenile"/>  <St'+
'rRes Name="2407" Text="Kes"/>  <StrRes Name="2408" Text="Kopyala"/>  <StrRes Nam'+
'e="2409" Text="Yap��t�r"/>  <StrRes Name="2410" Text="Grupla"/>  <StrRes Name="2'+
'411" Text="Grup ��z"/>  <StrRes Name="2412" Text="Sil"/>  <StrRes Name="2413" Te'+
'xt="Sayfa Sil"/>  <StrRes Name="2414" Text="T�m�n� Se�"/>  <StrRes Name="2415" T'+
'ext="D�zenle..."/>  <StrRes Name="2416" Text="�ne Getir"/>  <StrRes Name="2417" '+
'Text="Alta G�nder"/>  <StrRes Name="2418" Text="Yeni..."/>  <StrRes Name="2419" '+
'Text="Yeni Rapor"/>  <StrRes Name="2420" Text="Yeni Sayfa"/>  <StrRes Name="2421'+
'" Text="Yeni Diyalog"/>  <StrRes Name="2422" Text="A�..."/>  <StrRes Name="2423"'+
' Text="Kaydet"/>  <StrRes Name="2424" Text="Farkl� Kaydet..."/>  <StrRes Name="2'+
'425" Text="De�i�kenler..."/>  <StrRes Name="2426" Text="Sayfa Ayarlar�..."/>  <S'+
'trRes Name="2427" Text="�nizleme"/>  <StrRes Name="2428" Text="��k��"/>  <StrRes'+
' Name="2429" Text="Rapor Ba�l���"/>  <StrRes Name="2430" Text="Rapor �zeti"/>  <'+
'StrRes Name="2431" Text="Sayfa Ba�l���"/>  <StrRes Name="2432" Text="Sayfa Sonu"'+
'/>  <StrRes Name="2433" Text="�st Ba�l�k"/>  <StrRes Name="2434" Text="Alt Ba�l�'+
'k"/>  <StrRes Name="2435" Text="As�l Veri"/>  <StrRes Name="2436" Text="Detay Ve'+
'ri"/>  <StrRes Name="2437" Text="Altdetay Veri"/>  <StrRes Name="2438" Text="4. '+
'Seviye Veri"/>  <StrRes Name="2439" Text="5. Seviye Veri"/>  <StrRes Name="2440"'+
' Text="6. Seviye Veri"/>  <StrRes Name="2441" Text="Grup Ba�l���"/>  <StrRes Nam'+
'e="2442" Text="Grup Sonu"/>  <StrRes Name="2443" Text="�ocuk"/>  <StrRes Name="2'+
'444" Text="Kolon Ba�l���"/>  <StrRes Name="2445" Text="Kolon Sonu"/>  <StrRes Na'+
'me="2446" Text="Yard�mc�"/>  <StrRes Name="2447" Text="Dikey Bandlar"/>  <StrRes'+
' Name="2448" Text="�st Ba�l�k"/>  <StrRes Name="2449" Text="Alt Ba�l�k"/>  <StrR'+
'es Name="2450" Text="As�l Veri"/>  <StrRes Name="2451" Text="Detay Veri"/>  <Str'+
'Res Name="2452" Text="Altdetay Veri"/>  <StrRes Name="2453" Text="Grup Ba�l���"/'+
'>  <StrRes Name="2454" Text="Grup Sonu"/>  <StrRes Name="2455" Text="�ocuk"/>  <'+
'StrRes Name="2456" Text="0�"/>  <StrRes Name="2457" Text="45�"/>  <StrRes Name="'+
'2458" Text="90�"/>  <StrRes Name="2459" Text="180�"/>  <StrRes Name="2460" Text='+
'"270�"/>  <StrRes Name="2461" Text="Yaz� Tipi Ayarlar�"/>  <StrRes Name="2462" T'+
'ext="Kal�n"/>  <StrRes Name="2463" Text="�talik"/>  <StrRes Name="2464" Text="Al'+
't� �izgili"/>  <StrRes Name="2465" Text="�st Simge"/>  <StrRes Name="2466" Text='+
'"Alt Simge"/>  <StrRes Name="2467" Text="S�k��t�r�lm��"/>  <StrRes Name="2468" T'+
'ext="Geni�"/>  <StrRes Name="2469" Text="12 cpi"/>  <StrRes Name="2470" Text="15'+
' cpi"/>  <StrRes Name="2471" Text="Rapor (*.fr3)|*.fr3"/>  <StrRes Name="2472" T'+
'ext="Pascal dosyalar� (*.pas)|*.pas|C++ dosyalar� (*.cpp)|*.cpp|Java Programc�k '+
'dosyalar� (*.js)|*.js|Basic dosyalar� (*.vb)|*.vb|T�m dosyalar|*.*"/>  <StrRes N'+
'ame="2473" Text="Pascal dosyalar� (*.pas)|*.pas|C++ dosyalar� (*.cpp)|*.cpp|Java'+
' Programc�k dosyalar� (*.js)|*.js|Basic dosyalar� (*.vb)|*.vb|T�m dosyalar|*.*"/'+
'>  <StrRes Name="2474" Text="Baglant�lar..."/>  <StrRes Name="2475" Text="Lisan"'+
'/>  <StrRes Name="2476" Text="Toggle breakpoint"/>  <StrRes Name="2477" Text="Ru'+
'n to cursor"/>  <StrRes Name="2478" Text="�ocuk band ekle"/>  <StrRes Name="dsCm'+
'" Text="Santimetre"/>  <StrRes Name="dsInch" Text="�n�"/>  <StrRes Name="dsPix" '+
'Text="Piksel"/>  <StrRes Name="dsChars" Text="Karakter"/>  <StrRes Name="dsCode"'+
' Text="Kod"/>  <StrRes Name="dsData" Text="Data"/>  <StrRes Name="dsPage" Text="'+
'Sayfa"/>  <StrRes Name="dsRepFilter" Text="Rapor (*.fr3)|*.fr3"/>  <StrRes Name='+
'"dsComprRepFilter" Text="S�k��t�r��m�� Rapor (*.fr3)|*.fr3"/>  <StrRes Name="dsS'+
'avePreviewChanges" Text="�nizleme sayfas�ndaki de�i�iklikler kaydedilsin mi?"/> '+
' <StrRes Name="dsSaveChangesTo" Text="De�i�ikleri Kaydet "/>  <StrRes Name="dsCa'+
'ntLoad" Text="Dosya A��lamad�"/>  <StrRes Name="dsStyleFile" Text="Bi�im Dosyas�'+
'"/>  <StrRes Name="dsCantFindProc" Text="Ana prosed�r bulunamad�"/>  <StrRes Nam'+
'e="dsClearScript" Text="T�m kod silinecek. Devam etmek istiyor musunuz?"/>  <Str'+
'Res Name="dsNoStyle" Text="Bi�im yok"/>  <StrRes Name="dsStyleSample" Text="�rne'+
'k bi�im"/>  <StrRes Name="dsTextNotFound" Text="''%s'' metni bulunamad�"/>  <StrRe'+
's Name="dsReplace" Text="''%s'' metnini de�i�tirmek istiyor musunuz?"/>  <StrRes N'+
'ame="2600" Text="FastReport Hakk�nda"/>  <StrRes Name="2601" Text="Daha fazla bi'+
'lgi i�in Web sayfam�z� ziyaret edin:"/>  <StrRes Name="2602" Text="Sat��:"/>  <S'+
'trRes Name="2603" Text="Destek:"/>  <StrRes Name="2700" Text="Sayfa Se�enekleri"'+
'/>  <StrRes Name="2701" Text="Ka��t"/>  <StrRes Name="2702" Text="Geni�lik"/>  <'+
'StrRes Name="2703" Text="Y�kseklik"/>  <StrRes Name="2704" Text="�l��"/>  <StrRe'+
's Name="2705" Text="Y�nlendirme"/>  <StrRes Name="2706" Text="Sol"/>  <StrRes Na'+
'me="2707" Text="�st"/>  <StrRes Name="2708" Text="Sa�"/>  <StrRes Name="2709" Te'+
'xt="Alt"/>  <StrRes Name="2710" Text="Bo�luklar"/>  <StrRes Name="2711" Text="Ka'+
'��t Kayna��"/>  <StrRes Name="2712" Text="�lk sayfa"/>  <StrRes Name="2713" Text'+
'="Di�er sayfalar"/>  <StrRes Name="2714" Text="Dikey"/>  <StrRes Name="2715" Tex'+
't="Yatay"/>  <StrRes Name="2716" Text="Di�er Se�enekler"/>  <StrRes Name="2717" '+
'Text="Kolonlar"/>  <StrRes Name="2718" Text="Say�"/>  <StrRes Name="2719" Text="'+
'Geni�lik"/>  <StrRes Name="2720" Text="Konumlar"/>  <StrRes Name="2721" Text="Di'+
'�er"/>  <StrRes Name="2722" Text="�ift Y�nl�"/>  <StrRes Name="2723" Text="�ncek'+
'i sayfay� yazd�r"/>  <StrRes Name="2724" Text="Bo�luklar� yans�t"/>  <StrRes Nam'+
'e="2725" Text="Dizayn a�amas�nda sayfalar b�y�k uzunlukta"/>  <StrRes Name="2726'+
'" Text="Kesintisiz sayfa geni�li�i"/>  <StrRes Name="2727" Text="Kesintisiz sayf'+
'a uzunlu�u"/>  <StrRes Name="2800" Text="Rapor Dataset''ini Se�"/>  <StrRes Name='+
'"2900" Text="De�i�kenleri D�zenle"/>  <StrRes Name="2901" Text="Kategori"/>  <St'+
'rRes Name="2902" Text="De�i�ken"/>  <StrRes Name="2903" Text="D�zenle"/>  <StrRe'+
's Name="2904" Text="Sil"/>  <StrRes Name="2905" Text="Liste"/>  <StrRes Name="29'+
'06" Text="Y�kle"/>  <StrRes Name="2907" Text="Kaydet"/>  <StrRes Name="2908" Tex'+
't=" �fade:"/>  <StrRes Name="2909" Text="S�zl�k (*.fd3)|*.fd3"/>  <StrRes Name="'+
'2910" Text="S�zl�k (*.fd3)|*.fd3"/>  <StrRes Name="vaNoVar" Text="(de�i�lem tan�'+
'mlanmam��)"/>  <StrRes Name="vaVar" Text="De�i�lenler"/>  <StrRes Name="vaDupNam'+
'e" Text="Ayn� isim"/>  <StrRes Name="3000" Text="Dizayn Se�enekleri"/>  <StrRes '+
'Name="3001" Text="Tablo"/>  <StrRes Name="3002" Text="T�r"/>  <StrRes Name="3003'+
'" Text="�l��"/>  <StrRes Name="3004" Text="Diyalog pencersi:"/>  <StrRes Name="3'+
'005" Text="Di�er"/>  <StrRes Name="3006" Text="Yaz� Tipileri"/>  <StrRes Name="3'+
'007" Text="Kode penceresi"/>  <StrRes Name="3008" Text="Text d�zenleyici"/>  <St'+
'rRes Name="3009" Text="�l��"/>  <StrRes Name="3010" Text="�l��"/>  <StrRes Name='+
'"3011" Text="Renkler"/>  <StrRes Name="3012" Text="Bandlar aras�ndaki bo�luk:"/>'+
'  <StrRes Name="3013" Text="cm"/>  <StrRes Name="3014" Text="in"/>  <StrRes Name'+
'="3015" Text="pt"/>  <StrRes Name="3016" Text="pt"/>  <StrRes Name="3017" Text="'+
'pt"/>  <StrRes Name="3018" Text="Santimetre:"/>  <StrRes Name="3019" Text="�n�:"'+
'/>  <StrRes Name="3020" Text="Pixel:"/>  <StrRes Name="3021" Text="Tabloyu g�ste'+
'r"/>  <StrRes Name="3022" Text="Tabloya Hizala"/>  <StrRes Name="3023" Text="Ekl'+
'edikten sonra d�zenle"/>  <StrRes Name="3024" Text="Nesnenin yaz� tipi ayarlar�n'+
'� kullan"/>  <StrRes Name="3025" Text="�al��ma Alan�"/>  <StrRes Name="3026" Tex'+
't="Ara� Penceresi"/>  <StrRes Name="3027" Text="LCD tablo rengi"/>  <StrRes Name'+
'="3028" Text="Bo� band alan�"/>  <StrRes Name="3029" Text="A��l�r sahalar� g�r�n'+
't�le"/>  <StrRes Name="3030" Text="A��l�� ekran� g�r�nt�le"/>  <StrRes Name="303'+
'1" Text="Varsay�lan ayarlara d�n"/>  <StrRes Name="3032" Text="Band etiketlerini'+
' g�ster"/>  <StrRes Name="3100" Text="DataSet se�"/>  <StrRes Name="3101" Text="'+
'Kay�t say�s�:"/>  <StrRes Name="dbNotAssigned" Text="[atanmam��]"/>  <StrRes Nam'+
'e="3200" Text="Grup"/>  <StrRes Name="3201" Text="Kes"/>  <StrRes Name="3202" Te'+
'xt="Se�enekler"/>  <StrRes Name="3203" Text="Veri Sahas�"/>  <StrRes Name="3204"'+
' Text="�fade"/>  <StrRes Name="3205" Text="Grubu birlikte tut"/>  <StrRes Name="'+
'3206" Text="Yeni sayfaya ba�la"/>  <StrRes Name="3207" Text="Ana hatlar i�inde g'+
'�ster"/>  <StrRes Name="3300" Text="Sistem Metni"/>  <StrRes Name="3301" Text="V'+
'eri Band�"/>  <StrRes Name="3302" Text="DataSet"/>  <StrRes Name="3303" Text="Ve'+
'riSahas�"/>  <StrRes Name="3304" Text="Fonksiyon"/>  <StrRes Name="3305" Text="�'+
'fade"/>  <StrRes Name="3306" Text="Toplam De�er"/>  <StrRes Name="3307" Text="Si'+
'stem De�i�keni"/>  <StrRes Name="3308" Text="G�r�nmez bandlar�n say�s�"/>  <StrR'+
'es Name="3309" Text="Metin"/>  <StrRes Name="3310" Text="Toplam �al��t�r�lan"/> '+
' <StrRes Name="agAggregate" Text="Toplam Ekle"/>  <StrRes Name="vt1" Text="[DATE'+
']"/>  <StrRes Name="vt2" Text="[TIME]"/>  <StrRes Name="vt3" Text="[PAGE#]"/>  <'+
'StrRes Name="vt4" Text="[TOTALPAGES#]"/>  <StrRes Name="vt5" Text="[PAGE#] / [TO'+
'TALPAGES#]"/>  <StrRes Name="vt6" Text="[LINE#]"/>  <StrRes Name="3400" Text="OL'+
'E Nesnesi"/>  <StrRes Name="3401" Text="Ekle..."/>  <StrRes Name="3402" Text="D�'+
'zenle..."/>  <StrRes Name="3403" Text="��k��"/>  <StrRes Name="olStretched" Text'+
'="Uzat�lm��"/>  <StrRes Name="3500" Text="Barkod D�zenleyici"/>  <StrRes Name="3'+
'501" Text="Kod"/>  <StrRes Name="3502" Text="Bar''�n T�r�"/>  <StrRes Name="3503"'+
' Text="Yakla�t�r:"/>  <StrRes Name="3504" Text="Se�enekler"/>  <StrRes Name="350'+
'5" Text="D�nd�rme A��s�"/>  <StrRes Name="3506" Text="Sa�lamas�n� Yap "/>  <StrR'+
'es Name="3507" Text="Rakamlar� G�ster"/>  <StrRes Name="3508" Text="0�"/>  <StrR'+
'es Name="3509" Text="90�"/>  <StrRes Name="3510" Text="180�"/>  <StrRes Name="35'+
'11" Text="270�"/>  <StrRes Name="bcCalcChecksum" Text="Sa�lamas�n� Yap"/>  <StrR'+
'es Name="bcShowText" Text="Metni G�ster"/>  <StrRes Name="3600" Text="G�r�nen ad'+
'� d�zenle"/>  <StrRes Name="3601" Text="Maddeyi d�zenlemek i�in ENTER tu�una bas'+
'�n"/>  <StrRes Name="3602" Text="Dataset g�r�nen ad�"/>  <StrRes Name="3603" Tex'+
't="Sahalar�n g�r�nen ad�"/>  <StrRes Name="3604" Text="S�f�rla"/>  <StrRes Name='+
'"3605" Text="G�ncelle"/>  <StrRes Name="alUserName" Text="Kullan�c� Ad�"/>  <Str'+
'Res Name="alOriginal" Text="Orjinal Ad�"/>  <StrRes Name="3700" Text="Parametre '+
'D�zenleyici"/>  <StrRes Name="qpName" Text="Ad�"/>  <StrRes Name="qpDataType" Te'+
'xt="Veri T�r�"/>  <StrRes Name="qpValue" Text="De�eri"/>  <StrRes Name="3800" Te'+
'xt="As�l-Detay ba�lant�s�"/>  <StrRes Name="3801" Text="Detay sahalar�"/>  <StrR'+
'es Name="3802" Text="As�l sahalar"/>  <StrRes Name="3803" Text="Ba�lant� sahalar'+
'�"/>  <StrRes Name="3804" Text="Ekle"/>  <StrRes Name="3805" Text="Temizle"/>  <'+
'StrRes Name="3900" Text="Metin"/>  <StrRes Name="3901" Text="�fade Ekle"/>  <Str'+
'Res Name="3902" Text="Toplam Ekle"/>  <StrRes Name="3903" Text="Bi�imleme Ekle"/'+
'>  <StrRes Name="3904" Text="S�zc�k Kayd�r"/>  <StrRes Name="3905" Text="Text"/>'+
'  <StrRes Name="3906" Text="Format"/>  <StrRes Name="3907" Text="Highlight"/>  <'+
'StrRes Name="4000" Text="Resim"/>  <StrRes Name="4001" Text="Y�kle"/>  <StrRes N'+
'ame="4002" Text="Kopyala"/>  <StrRes Name="4003" Text="Yap��t�r"/>  <StrRes Name'+
'="4004" Text="Temizle"/>  <StrRes Name="piEmpty" Text="Bo�"/>  <StrRes Name="410'+
'0" Text="Grafik D�zenleyici"/>  <StrRes Name="4101" Text="Seri Ekle"/>  <StrRes '+
'Name="4102" Text="Seri Sil"/>  <StrRes Name="4103" Text="Grafik d�zenle"/>  <Str'+
'Res Name="4104" Text="Band kayna��"/>  <StrRes Name="4105" Text="Sabit Veri"/>  '+
'<StrRes Name="4106" Text="Dataset"/>  <StrRes Name="4107" Text="Veri kayna��"/> '+
' <StrRes Name="4108" Text="De�erler"/>  <StrRes Name="4109" Text="Grafik serisi '+
'se�in yada yeni bir tane ekleyin."/>  <StrRes Name="4114" Text="Di�er se�enekler'+
'"/>  <StrRes Name="4115" Text="En�st N de�eri"/>  <StrRes Name="4116" Text="En�s'+
't N etiketi"/>  <StrRes Name="4117" Text="S�ralama"/>  <StrRes Name="4126" Text='+
'"X Ekseni"/>  <StrRes Name="ch3D" Text="3D G�r�nt�"/>  <StrRes Name="chAxis" Tex'+
't="Ekseni g�ster"/>  <StrRes Name="chsoNone" Text="Yok"/>  <StrRes Name="chsoAsc'+
'ending" Text="Artan"/>  <StrRes Name="chsoDescending" Text="Azalan"/>  <StrRes N'+
'ame="chxtText" Text="Metin"/>  <StrRes Name="chxtNumber" Text="Say�sal"/>  <StrR'+
'es Name="chxtDate" Text="Tarih"/>  <StrRes Name="4200" Text="Zengin Metin D�zenl'+
'eyici"/>  <StrRes Name="4201" Text="Dosya A�"/>  <StrRes Name="4202" Text="Dosya'+
' Kaydet"/>  <StrRes Name="4203" Text="Geri"/>  <StrRes Name="4204" Text="Yaz� Ti'+
'pi"/>  <StrRes Name="4205" Text="�fade Ekle"/>  <StrRes Name="4206" Text="Kal�n"'+
'/>  <StrRes Name="4207" Text="�talik"/>  <StrRes Name="4208" Text="Alt� �izgili"'+
'/>  <StrRes Name="4209" Text="Sola Hizal�"/>  <StrRes Name="4210" Text="Ortal�"/'+
'>  <StrRes Name="4211" Text="Sa�a Hizal�"/>  <StrRes Name="4212" Text="�ki Yana '+
'Hizal�"/>  <StrRes Name="4213" Text="Madde �mi"/>  <StrRes Name="4300" Text="Tab'+
'lo D�zenleyici"/>  <StrRes Name="4301" Text="Kaynak Veri"/>  <StrRes Name="4302"'+
' Text="Boyutlar"/>  <StrRes Name="4303" Text="Sat�rlar"/>  <StrRes Name="4304" T'+
'ext="Kolonlar"/>  <StrRes Name="4305" Text="H�creler"/>  <StrRes Name="4306" Tex'+
't="Tablo Yap�s�"/>  <StrRes Name="4307" Text="Sat�r ba�l���"/>  <StrRes Name="43'+
'08" Text="Kolon ba�l���"/>  <StrRes Name="4309" Text="Sat�r genel toplam�"/>  <S'+
'trRes Name="4310" Text="Kolon genel toplam�"/>  <StrRes Name="4311" Text="Sat�rl'+
'ar�/Kolonlar� de�i�tir"/>  <StrRes Name="4312" Text="Stil se�"/>  <StrRes Name="'+
'4313" Text="Mevcut stili kaydet..."/>  <StrRes Name="4314" Text="Ba�l�k g�ster"/'+
'>  <StrRes Name="4315" Text="K��e g�ster"/>  <StrRes Name="4316" Text="Ba�l�klar'+
'� yeni sayfada yazd�r"/>  <StrRes Name="4317" Text="Otomatik boyutland�r"/>  <St'+
'rRes Name="4318" Text="H�cre etraf� �er�eveler"/>  <StrRes Name="4319" Text="�ap'+
'raz bast�r"/>  <StrRes Name="4320" Text="Taraf tarafa h�creler"/>  <StrRes Name='+
'"4321" Text="E�it h�creleri birle�tir"/>  <StrRes Name="4322" Text="Yok"/>  <Str'+
'Res Name="4323" Text="Toplam"/>  <StrRes Name="4324" Text="Mininum"/>  <StrRes N'+
'ame="4325" Text="Maksimum"/>  <StrRes Name="4326" Text="Ortalama"/>  <StrRes Nam'+
'e="4327" Text="Say�"/>  <StrRes Name="4328" Text="Artan S�ralama (A-Z)"/>  <StrR'+
'es Name="4329" Text="Azalan S�ralama (Z-A)"/>  <StrRes Name="4330" Text="S�ralam'+
'a Yok"/>  <StrRes Name="crStName" Text="Stil ad� girin:"/>  <StrRes Name="crResi'+
'ze" Text="�apraz tabloyu yeniden boyutland�r, Bunun i�in Autosize''� false yap�n.'+
'"/>  <StrRes Name="crSubtotal" Text="Alttoplam"/>  <StrRes Name="crNone" Text="Y'+
'ok"/>  <StrRes Name="crSum" Text="Top"/>  <StrRes Name="crMin" Text="Min"/>  <St'+
'rRes Name="crMax" Text="Max"/>  <StrRes Name="crAvg" Text="Ort"/>  <StrRes Name='+
'"crCount" Text="Say�"/>  <StrRes Name="crAsc" Text="A-Z"/>  <StrRes Name="crDesc'+
'" Text="Z-A"/>  <StrRes Name="crFillMx" Text="Tablo dolduruluyor..."/>  <StrRes '+
'Name="crBuildMx" Text="Tablo yap�land�r�l�yor..."/>  <StrRes Name="4400" Text="�'+
'fade D�zenleyici"/>  <StrRes Name="4401" Text="�fade:"/>  <StrRes Name="4500" Te'+
'xt="G�r�nt� Bi�imi"/>  <StrRes Name="4501" Text="Kategori"/>  <StrRes Name="4502'+
'" Text="Bi�im"/>  <StrRes Name="4503" Text="Bi�im metni:"/>  <StrRes Name="4504"'+
' Text="Ondal�k ayrac�:"/>  <StrRes Name="fkText" Text="Metin (bi�imlendirilmemi�'+
')"/>  <StrRes Name="fkNumber" Text="Say�"/>  <StrRes Name="fkDateTime" Text="Tar'+
'ih/Saat"/>  <StrRes Name="fkBoolean" Text="Do�ru/Yanl��"/>  <StrRes Name="fkNumb'+
'er1" Text="1234.5;%g"/>  <StrRes Name="fkNumber2" Text="1234.50;%2.2f"/>  <StrRe'+
's Name="fkNumber3" Text="1,234.50;%2.2n"/>  <StrRes Name="fkNumber4" Text="$1,23'+
'4.50;%2.2m"/>  <StrRes Name="fkDateTime1" Text="11.28.2002;mm.dd.yyyy"/>  <StrRe'+
's Name="fkDateTime2" Text="28 ksm 2002;dd mmm yyyy"/>  <StrRes Name="fkDateTime3'+
'" Text="Kas�m 28, 2002;mmmm dd, yyyy"/>  <StrRes Name="fkDateTime4" Text="02:14;'+
'hh:mm"/>  <StrRes Name="fkDateTime5" Text="02:14am;hh:mm am/pm"/>  <StrRes Name='+
'"fkDateTime6" Text="02:14:00;hh:mm:ss"/>  <StrRes Name="fkDateTime7" Text="02:14'+
'am, Kas�m 28, 2002;hh:mm am/pm, mmmm dd, yyyy"/>  <StrRes Name="fkBoolean1" Text'+
'="0,1;0,1"/>  <StrRes Name="fkBoolean2" Text="Hay�r,Evet;Hay�r,Evet"/>  <StrRes '+
'Name="fkBoolean3" Text="_,x;_,x"/>  <StrRes Name="fkBoolean4" Text="Yanl��,Do�ru'+
';Yanl��,Do�ru"/>  <StrRes Name="4600" Text="Vurgu"/>  <StrRes Name="4601" Text="'+
'Renk..."/>  <StrRes Name="4602" Text="Renk..."/>  <StrRes Name="4603" Text="Ko�u'+
'l"/>  <StrRes Name="4604" Text="Yaz� Tipi"/>  <StrRes Name="4605" Text="Arkaplan'+
'"/>  <StrRes Name="4606" Text="Kal�n"/>  <StrRes Name="4607" Text="�talik"/>  <S'+
'trRes Name="4608" Text="Alt� �izgili"/>  <StrRes Name="4609" Text="Saydam"/>  <S'+
'trRes Name="4610" Text="Di�er"/>  <StrRes Name="4700" Text="Rapor Ayarlar�"/>  <'+
'StrRes Name="4701" Text="Genel"/>  <StrRes Name="4702" Text="Yaz�c� Ayarlar�"/> '+
' <StrRes Name="4703" Text="Kopya"/>  <StrRes Name="4704" Text="Genel"/>  <StrRes'+
' Name="4705" Text="�ifre"/>  <StrRes Name="4706" Text="Harmanl� kopya"/>  <StrRe'+
's Name="4707" Text="�kinci Ge�i�"/>  <StrRes Name="4708" Text="Bo�sa Yaz"/>  <St'+
'rRes Name="4709" Text="Tan�mlama"/>  <StrRes Name="4710" Text="Ad�"/>  <StrRes N'+
'ame="4711" Text="Tan�mlama"/>  <StrRes Name="4712" Text="Resim"/>  <StrRes Name='+
'"4713" Text="Yazar"/>  <StrRes Name="4714" Text="Maj�r"/>  <StrRes Name="4715" T'+
'ext="Min�r"/>  <StrRes Name="4716" Text="Sunum"/>  <StrRes Name="4717" Text="Yap'+
'�"/>  <StrRes Name="4718" Text="Olu�turuldu"/>  <StrRes Name="4719" Text="De�i�t'+
'iriildi"/>  <StrRes Name="4720" Text="Tan�mlama"/>  <StrRes Name="4721" Text="Ve'+
'rsiyon"/>  <StrRes Name="4722" Text="G�z At..."/>  <StrRes Name="4723" Text="Mir'+
'as ayarlar�"/>  <StrRes Name="4724" Text="Se�enekleri se�in:"/>  <StrRes Name="4'+
'725" Text="De�i�tirme"/>  <StrRes Name="4726" Text="Ana rapordan ay�r"/>  <StrRe'+
's Name="4727" Text="Ana rapordan miras al:"/>  <StrRes Name="4728" Text="Miras"/'+
'>  <StrRes Name="rePrnOnPort" Text="�zerinde"/>  <StrRes Name="riNotInherited" T'+
'ext="Bu rapor miras almam��."/>  <StrRes Name="riInherited" Text="Bu rapor �u an'+
'a rapordan miras alm��: %s"/>  <StrRes Name="4800" Text="Sat�r"/>  <StrRes Name='+
'"4900" Text="SQL"/>  <StrRes Name="4901" Text="Query Builder"/>  <StrRes Name="5'+
'000" Text="�ifre"/>  <StrRes Name="5001" Text="�ifreyi girin:"/>  <StrRes Name="'+
'5100" Text="Bi�im D�zenleyici"/>  <StrRes Name="5101" Text="Renk..."/>  <StrRes '+
'Name="5102" Text="Yaz� Tipi..."/>  <StrRes Name="5103" Text="�er�eve..."/>  <Str'+
'Res Name="5104" Text="Ekle"/>  <StrRes Name="5105" Text="Sil"/>  <StrRes Name="5'+
'106" Text="D�zenle"/>  <StrRes Name="5107" Text="Y�kle"/>  <StrRes Name="5108" T'+
'ext="Kaydet"/>  <StrRes Name="5200" Text="�er�eve D�zenleyici"/>  <StrRes Name="'+
'5201" Text="�er�eve"/>  <StrRes Name="5202" Text="�er�eve �izgisi"/>  <StrRes Na'+
'me="5203" Text="G�lge"/>  <StrRes Name="5204" Text="�st �izgi"/>  <StrRes Name="'+
'5205" Text="Alt �izgi"/>  <StrRes Name="5206" Text="Sol �izgi"/>  <StrRes Name="'+
'5207" Text="Sa� �izgi"/>  <StrRes Name="5208" Text="T�m �er�eve �izgileri"/>  <S'+
'trRes Name="5209" Text="�er�eve Yok"/>  <StrRes Name="5210" Text="�er�eve Rengi"'+
'/>  <StrRes Name="5211" Text="�er�eve Bi�imi"/>  <StrRes Name="5212" Text="�er�e'+
've Geni�li�i"/>  <StrRes Name="5213" Text="G�lge"/>  <StrRes Name="5214" Text="G'+
'�lge Rengi"/>  <StrRes Name="5215" Text="G�lge Geni�li�i"/>  <StrRes Name="5300"'+
' Text="Yeni Madde"/>  <StrRes Name="5301" Text="Maddeler"/>  <StrRes Name="5302"'+
' Text="�ablonlar"/>  <StrRes Name="5303" Text="Rapor miras"/>  <StrRes Name="540'+
'0" Text="Tab S�ras�"/>  <StrRes Name="5401" Text="Tab s�ras�na g�re nesne listes'+
'i:"/>  <StrRes Name="5402" Text="Yukar� Ta��"/>  <StrRes Name="5403" Text="A�a��'+
' Ta��"/>  <StrRes Name="5500" Text="De�erlendirme"/>  <StrRes Name="5501" Text="'+
'�fade"/>  <StrRes Name="5502" Text="Sonu�"/>  <StrRes Name="5600" Text="Rapor Si'+
'hirbaz�"/>  <StrRes Name="5601" Text="Veri"/>  <StrRes Name="5602" Text="Sahalar'+
'"/>  <StrRes Name="5603" Text="Gruplar"/>  <StrRes Name="5604" Text="Alan"/>  <S'+
'trRes Name="5605" Text="Bi�im"/>  <StrRes Name="5606" Text="Ad�m 1. dataset se�.'+
'"/>  <StrRes Name="5607" Text="Ad�m 2. G�r�nt�lenecek sahalar� se�."/>  <StrRes '+
'Name="5608" Text="Ad�m 3. Gruplar� olu�tur (se�ime ba�l�)."/>  <StrRes Name="560'+
'9" Text="Ad�m 4. Sayfa y�n�n� ve veri �eklini tan�mla."/>  <StrRes Name="5610" T'+
'ext="Ad�m 5. Rapor stilini se�."/>  <StrRes Name="5611" Text="Ekle &#62;"/>  <St'+
'rRes Name="5612" Text="Hepsini ekle &#62;&#62;"/>  <StrRes Name="5613" Text="&#6'+
'0; Kald�r"/>  <StrRes Name="5614" Text="&#60;&#60; Hepsini kald�r"/>  <StrRes Na'+
'me="5615" Text="Ekle &#62;"/>  <StrRes Name="5616" Text="&#60; Kald�r"/>  <StrRe'+
's Name="5617" Text="Se�ili sahalar:"/>  <StrRes Name="5618" Text="Kullan�labilir'+
' sahalar:"/>  <StrRes Name="5619" Text="Gruplar:"/>  <StrRes Name="5620" Text="Y'+
'�nlendirme"/>  <StrRes Name="5621" Text="Yerle�tirme "/>  <StrRes Name="5622" Te'+
'xt="Dikey"/>  <StrRes Name="5623" Text="Yatay"/>  <StrRes Name="5624" Text="List'+
'e �ekli"/>  <StrRes Name="5625" Text="Kart �ekli"/>  <StrRes Name="5626" Text="S'+
'ahalar� sayfa geni�li�ine s��d�r"/>  <StrRes Name="5627" Text="&#60;&#60; Geri"/'+
'>  <StrRes Name="5628" Text="�leri &#62;&#62;"/>  <StrRes Name="5629" Text="Son"'+
'/>  <StrRes Name="5630" Text="Yeni tablo..."/>  <StrRes Name="5631" Text="Yeni s'+
'orgu..."/>  <StrRes Name="5632" Text="Veri taban� ba�lant�s� se�:"/>  <StrRes Na'+
'me="5633" Text="Tablo se�:"/>  <StrRes Name="5634" Text="veya"/>  <StrRes Name="'+
'5635" Text="Sorgu yarat..."/>  <StrRes Name="5636" Text="Ba�lant�lar� d�zenle"/>'+
'  <StrRes Name="wzStd" Text="Standart Rapor Sihirbaz�"/>  <StrRes Name="wzDMP" T'+
'ext="Nokta-Vuru�lu Rapor Sihirbaz�"/>  <StrRes Name="wzStdEmpty" Text="Standart '+
'Rapor"/>  <StrRes Name="wzDMPEmpty" Text="Nokta-Vuru�lu Rapor"/>  <StrRes Name="'+
'5700" Text="Baglant� sihirbaz�"/>  <StrRes Name="5701" Text="Baglant�"/>  <StrRe'+
's Name="5702" Text="Baglant� tipini se�iniz:"/>  <StrRes Name="5703" Text="Verit'+
'aban� se�iniz:"/>  <StrRes Name="5704" Text="Kullan�c�"/>  <StrRes Name="5705" T'+
'ext="Sifre"/>  <StrRes Name="5706" Text="Giri� ekran� sor"/>  <StrRes Name="5707'+
'" Text="Kullan�c� ad�/�ifre kullan:"/>  <StrRes Name="5708" Text="Tablo"/>  <Str'+
'Res Name="5709" Text="Tablo ismi seciniz:"/>  <StrRes Name="5710" Text="Kay�tlar'+
'� sorgula:"/>  <StrRes Name="5711" Text="Sorgu"/>  <StrRes Name="5712" Text="SQL'+
' ifadesi:"/>  <StrRes Name="5713" Text="Query Builder"/>  <StrRes Name="5714" Te'+
'xt="Query Parametreleri d�zenle"/>  <StrRes Name="ftAllFiles" Text="T�m Dosyalar'+
'"/>  <StrRes Name="ftPictures" Text="Resimler"/>  <StrRes Name="ftDB" Text="Veri'+
' Dosyalar�"/>  <StrRes Name="ftRichFile" Text="Zengin Metin Dosyas�"/>  <StrRes '+
'Name="ftTextFile" Text="Metin Dosyas�"/>  <StrRes Name="prNotAssigned" Text="(at'+
'anmam��)"/>  <StrRes Name="prInvProp" Text="�zellik de�eri ge�ersiz"/>  <StrRes '+
'Name="prDupl" Text="Tekrarlanan ad"/>  <StrRes Name="prPict" Text="(Resim)"/>  <'+
'StrRes Name="mvExpr" Text="�fadelere �zin Ver"/>  <StrRes Name="mvStretch" Text='+
'"S��d�r"/>  <StrRes Name="mvStretchToMax" Text="Maksimum Y�ksekli�e S��d�r"/>  <'+
'StrRes Name="mvShift" Text="Kayd�r"/>  <StrRes Name="mvShiftOver" Text="�zerine '+
'Bindi�inde Kayd�r"/>  <StrRes Name="mvVisible" Text="G�r�n�r"/>  <StrRes Name="m'+
'vPrintable" Text="Yazd�r�labilir"/>  <StrRes Name="mvFont" Text="Yaz� Tipi..."/>'+
'  <StrRes Name="mvFormat" Text="G�r�nt� Bi�imi..."/>  <StrRes Name="mvClear" Tex'+
't="��indekileri Temizle"/>  <StrRes Name="mvAutoWidth" Text="Otomatik Geni�lik"/'+
'>  <StrRes Name="mvWWrap" Text="S�zc�k Kayd�r"/>  <StrRes Name="mvSuppress" Text'+
'="Tekrarlanan De�erleri Gizle"/>  <StrRes Name="mvHideZ" Text="S�f�rlar� Gizle"/'+
'>  <StrRes Name="mvHTML" Text="HTML Koduna �zin ver"/>  <StrRes Name="lvDiagonal'+
'" Text="�apraz"/>  <StrRes Name="pvAutoSize" Text="Otomatik Boyutland�r"/>  <Str'+
'Res Name="pvCenter" Text="Ortala"/>  <StrRes Name="pvAspect" Text="Y�n Oran�n� T'+
'ut"/>  <StrRes Name="bvSplit" Text="B�l�nmeye �zin Ver"/>  <StrRes Name="bvKeepC'+
'hild" Text="�ocuklar� Birlikte Tut"/>  <StrRes Name="bvPrintChild" Text="G�r�nme'+
'zse �ocu�u Yazd�r"/>  <StrRes Name="bvStartPage" Text="Yeni Sayfada Ba�la"/>  <S'+
'trRes Name="bvPrintIfEmpty" Text="Detay� Bo�sa Yazd�r"/>  <StrRes Name="bvKeepDe'+
'tail" Text="Detay� Birlikte Tut"/>  <StrRes Name="bvKeepFooter" Text="Sayfa Sonu'+
'nu Birlikte Tut"/>  <StrRes Name="bvReprint" Text="Yeni Sayfada Tekrar Yazd�r"/>'+
'  <StrRes Name="bvOnFirst" Text="�lk Sayfada Yazd�r"/>  <StrRes Name="bvOnLast" '+
'Text="Son Sayfada Yazd�r"/>  <StrRes Name="bvKeepGroup" Text="Birlikte Tut"/>  <'+
'StrRes Name="bvFooterAfterEach" Text="Her Sat�rdan Sonra Alt Sayfa Sonu"/>  <Str'+
'Res Name="bvDrillDown" Text="Drill-Down"/>  <StrRes Name="bvResetPageNo" Text="S'+
'ayfa numaralar�n� s�f�rla"/>  <StrRes Name="srParent" Text="�zerinde Bulundu�u N'+
'esnede Yazd�r"/>  <StrRes Name="bvKeepHeader" Text="Ba�l��� birlikte tut"/>  <St'+
'rRes Name="obCatDraw" Text="�izim"/>  <StrRes Name="obCatOther" Text="Di�er nesn'+
'eler"/>  <StrRes Name="obCatOtherControls" Text="Di�er kontroller"/>  <StrRes Na'+
'me="obDiagLine" Text="�apraz �izgi"/>  <StrRes Name="obRect" Text="Dikd�rtgen"/>'+
'  <StrRes Name="obRoundRect" Text="yuvarlanm�� dikd�rtgen"/>  <StrRes Name="obEl'+
'lipse" Text="Elips"/>  <StrRes Name="obTrian" Text="��gen"/>  <StrRes Name="obDi'+
'amond" Text="Karo"/>  <StrRes Name="obLabel" Text="Etiket kontrol�"/>  <StrRes N'+
'ame="obEdit" Text="Metin kontrol�"/>  <StrRes Name="obMemoC" Text="Yaz� kontrol�'+
'"/>  <StrRes Name="obButton" Text="D��me kontrol�"/>  <StrRes Name="obChBoxC" Te'+
'xt="Onay Kutusu kontrol�"/>  <StrRes Name="obRButton" Text="Radyo D��me kontrol�'+
'"/>  <StrRes Name="obLBox" Text="Liste Kutusu kontrol�"/>  <StrRes Name="obCBox"'+
' Text="A��lan Liste Kutusu kontrol�"/>  <StrRes Name="obDateEdit" Text="Tarih ko'+
'ntrol�"/>  <StrRes Name="obImageC" Text="Resim kontrol�"/>  <StrRes Name="obPane'+
'l" Text="Panel kontrol�"/>  <StrRes Name="obGrBox" Text="Grup Kutusu kontrol�"/>'+
'  <StrRes Name="obBBtn" Text="Resimli D��me kontrol�"/>  <StrRes Name="obSBtn" T'+
'ext="H�zl� D��me kontrol�"/>  <StrRes Name="obMEdit" Text="Bi�imli Metin kontrol'+
'�"/>  <StrRes Name="obChLB" Text="OnayListesiKutusu kontrol�"/>  <StrRes Name="o'+
'bDBLookup" Text="DBSorguluA��lanListeKutusu kontrol�"/>  <StrRes Name="obBevel" '+
'Text="Bevel kontrol�"/>  <StrRes Name="obShape" Text="�ekil nesnesi"/>  <StrRes '+
'Name="obText" Text="Metin nesnesi"/>  <StrRes Name="obSysText" Text="Sistem metn'+
'i"/>  <StrRes Name="obLine" Text="�izgi nesnesi"/>  <StrRes Name="obPicture" Tex'+
't="Resim nesnesi"/>  <StrRes Name="obBand" Text="Band object"/>  <StrRes Name="o'+
'bDataBand" Text="Veri band�"/>  <StrRes Name="obSubRep" Text="Alt rapor nesnesi"'+
'/>  <StrRes Name="obDlgPage" Text="Diyalog formu"/>  <StrRes Name="obRepPage" Te'+
'xt="Rapor sayfas�"/>  <StrRes Name="obReport" Text="Rapor nesnesi"/>  <StrRes Na'+
'me="obRich" Text="Zengin metin nesnesi"/>  <StrRes Name="obOLE" Text="OLE nesnes'+
'i"/>  <StrRes Name="obChBox" Text="Onay kutusu nesnesi"/>  <StrRes Name="obChart'+
'" Text="Grafik nesnesi"/>  <StrRes Name="obBarC" Text="Barkod nesnesi"/>  <StrRe'+
's Name="obCross" Text="�apraz tablo nesnesi"/>  <StrRes Name="obDBCross" Text="D'+
'B �apraz tablo nesnesi"/>  <StrRes Name="obGrad" Text="Dereceli renk nesnesi"/> '+
' <StrRes Name="obDMPText" Text="Nokta-vuru�lu metin nesnesi"/>  <StrRes Name="ob'+
'DMPLine" Text="Nokta-vuru�lu sat�r nesnesi"/>  <StrRes Name="obDMPCmd" Text="Dot'+
'-matrix komut nesnesi"/>  <StrRes Name="obBDEDB" Text="BDE Veritaban�"/>  <StrRe'+
's Name="obBDETb" Text="BDE Tablosu"/>  <StrRes Name="obBDEQ" Text="BDE Sorgusu"/'+
'>  <StrRes Name="obBDEComps" Text="BDE Komponentleri"/>  <StrRes Name="obIBXDB" '+
'Text="IBX Veritaban�"/>  <StrRes Name="obIBXTb" Text="IBX Tablo"/>  <StrRes Name'+
'="obIBXQ" Text="IBX Sorgusu"/>  <StrRes Name="obIBXComps" Text="IBX Komponentler'+
'i"/>  <StrRes Name="obADODB" Text="ADO Veritaban�"/>  <StrRes Name="obADOTb" Tex'+
't="ADO Tablosu"/>  <StrRes Name="obADOQ" Text="ADO Sorgusu"/>  <StrRes Name="obA'+
'DOComps" Text="ADO Komponentleri"/>  <StrRes Name="obDBXDB" Text="DBX Veritaban�'+
'"/>  <StrRes Name="obDBXTb" Text="DBX Tablosu"/>  <StrRes Name="obDBXQ" Text="DB'+
'X Sorgusu"/>  <StrRes Name="obDBXComps" Text="DBX Komponentleri"/>  <StrRes Name'+
'="obFIBDB" Text="FIB veritabani"/>  <StrRes Name="obFIBTb" Text="FIB tablo"/>  <'+
'StrRes Name="obFIBQ" Text="FIB sorgu"/>  <StrRes Name="obFIBComps" Text="FIB Kom'+
'ponentleri"/>  <StrRes Name="ctString" Text="Metin"/>  <StrRes Name="ctDate" Tex'+
't="Tarih ve Saat"/>  <StrRes Name="ctConv" Text="De�i�im"/>  <StrRes Name="ctFor'+
'mat" Text="Bi�im"/>  <StrRes Name="ctMath" Text="Matematiksel"/>  <StrRes Name="'+
'ctOther" Text="Di�er"/>  <StrRes Name="IntToStr" Text="Rakamsal de�eri metin bi�'+
'imine d�n��t�r�r"/>  <StrRes Name="FloatToStr" Text="Ondal�kl� de�eri metin bi�i'+
'mine d�n��t�r�r"/>  <StrRes Name="DateToStr" Text="Tarih de�eri metin bi�imine d'+
'�n��t�r�r"/>  <StrRes Name="TimeToStr" Text="Saat de�eri metin bi�imine d�n��t�r'+
'�r"/>  <StrRes Name="DateTimeToStr" Text="Tarih-saat de�eri metin bi�imine d�n��'+
't�r�r"/>  <StrRes Name="VarToStr" Text="De�i�ebilir de�eri metin bi�imine d�n��t'+
'�r�r"/>  <StrRes Name="StrToInt" Text="Metni rakamsal bi�ime d�n��t�r�r"/>  <Str'+
'Res Name="StrToInt64" Text="Converts a string to an Int64 value"/>  <StrRes Name'+
'="StrToFloat" Text="Metni ondal�kl� bi�ime d�n��t�r�r"/>  <StrRes Name="StrToDat'+
'e" Text="Metni tarih bi�imine d�n��t�r�r"/>  <StrRes Name="StrToTime" Text="Metn'+
'i saat bi�imine d�n��t�r�r"/>  <StrRes Name="StrToDateTime" Text="Metni tarih-sa'+
'at bi�imine d�n��t�r�r"/>  <StrRes Name="Format" Text="Verilen bir dizi ve metni'+
' bi�imlendirerek yeni bir metin d�nd�r�r"/>  <StrRes Name="FormatFloat" Text="On'+
'dal�kl� de�eri belirli bir formata �evirir"/>  <StrRes Name="FormatDateTime" Tex'+
't="Tarih-saat de�erini belirli bir formata �evirir"/>  <StrRes Name="FormatMaskT'+
'ext" Text="Metni belirli bir formata �evirir"/>  <StrRes Name="EncodeDate" Text='+
'"Y�l, Ay ve G�n olarak gelen bir de�eri Tarih-Saat tipine �evirir"/>  <StrRes Na'+
'me="DecodeDate" Text="Tarih-Saat de�erini Y�l, Ay ve G�n olarak d�nd�r�r"/>  <St'+
'rRes Name="EncodeTime" Text="Saat, Dakika, Saniye ve Milisaniye olarak gelen bir'+
' de�eri Tarih-Saat tipine �evirir"/>  <StrRes Name="DecodeTime" Text="Tarih-Saat'+
' de�erini, Saat, Dakika, Saniye ve Milisaniye olarak d�nd�r�r"/>  <StrRes Name="'+
'Date" Text="Ge�erli tarihi d�nd�r�r"/>  <StrRes Name="Time" Text="Ge�erli saati '+
'd�nd�r�r"/>  <StrRes Name="Now" Text="Ge�erli tarih ve saati d�nd�r�r"/>  <StrRe'+
's Name="DayOfWeek" Text="G�n�n hangi haftaya ait oldu�unu d�nd�r�r"/>  <StrRes N'+
'ame="IsLeapYear" Text="Y�l�n art�k y�l olup olmad���n� d�nd�r�r"/>  <StrRes Name'+
'="DaysInMonth" Text="Ay�n g�n say�s�n� d�nd�r�r"/>  <StrRes Name="Length" Text="'+
'Metnin uzunlu�unu d�nd�r�r"/>  <StrRes Name="Copy" Text="Metnin i�inden bir alt '+
'metin d�nd�r�r"/>  <StrRes Name="Pos" Text="Metnin i�inden bir alt metnin ba�lan'+
'g�� pozisyonunu verir"/>  <StrRes Name="Delete" Text="Metnin i�inden metin siler'+
'"/>  <StrRes Name="Insert" Text="Metnin i�ine alt metin ekler"/>  <StrRes Name="'+
'Uppercase" Text="Metnin t�m karakterlerini b�y�k harfe d�n��t�r�r"/>  <StrRes Na'+
'me="Lowercase" Text="Metnin t�m karakterlerini k���k harfe d�n��t�r�r"/>  <StrRe'+
's Name="Trim" Text="Metnin ba��ndaki ve sonundaki bo�luklar� atar"/>  <StrRes Na'+
'me="NameCase" Text="Metnin ilk karakterini b�y�k harfe d�n��t�r�r"/>  <StrRes Na'+
'me="CompareText" Text="�ki metni kar��la�t�r�r"/>  <StrRes Name="Chr" Text="Raka'+
'msal de�eri karaktere d�n��t�r�r"/>  <StrRes Name="Ord" Text="Bir karakterin rak'+
'amsal de�erini d�n��t�r�r"/>  <StrRes Name="SetLength" Text="Metnin uzunlu�unu a'+
'yarlar"/>  <StrRes Name="Round" Text="Say�sal bir de�eri en yak�n de�ere yuvarla'+
'r"/>  <StrRes Name="Trunc" Text="Kesirli say�lar�n tam say� k�sm�n� d�nd�r�r"/> '+
' <StrRes Name="Int" Text="Reel bir say�y� rakamsal say�ya d�n��t�r�r"/>  <StrRes'+
' Name="Frac" Text="Kesirli say�lar�n kesir k�sm�n� d�nd�r�r"/>  <StrRes Name="Sq'+
'rt" Text="Bir say�n�n karesini d�nd�r�r"/>  <StrRes Name="Abs" Text="Tam say�ya '+
'�evirir"/>  <StrRes Name="Sin" Text="Sin�s''e �evirir (radyan''da)"/>  <StrRes Nam'+
'e="Cos" Text="Cosin�s''e �evirir (radyan''da)"/>  <StrRes Name="ArcTan" Text="Arkt'+
'anjanta �evirir"/>  <StrRes Name="Tan" Text="Tanjanta �evirir"/>  <StrRes Name="'+
'Exp" Text="Say�n�n �stel de�erini d�nd�r�r"/>  <StrRes Name="Ln" Text="Reel bir '+
'say�y� logaritma''ya �evirir"/>  <StrRes Name="Pi" Text="3.1415926... de�erini nu'+
'maraya �evirir"/>  <StrRes Name="Inc" Text="De�eri artt�r�r"/>  <StrRes Name="De'+
'c" Text="De�eri azalt�r"/>  <StrRes Name="RaiseException" Text="�stisnai durum"/'+
'>  <StrRes Name="ShowMessage" Text="Mesaj kutusu g�ster"/>  <StrRes Name="Random'+
'ize" Text="Rastgele rakamsal de�er �retir"/>  <StrRes Name="Random" Text="Rastge'+
'le bir rakamsal de�er d�nd�r�r"/>  <StrRes Name="ValidInt" Text="Metin ge�erli b'+
'ir float de�er i�eriyorsa &#38;#34;True&#38;#34; d�nd�r�r"/>  <StrRes Name="Vali'+
'dFloat" Text="Metin ge�erli bir float de�er i�eriyorsa &#38;#34;True&#38;#34; d�'+
'nd�r�r"/>  <StrRes Name="ValidDate" Text="Metin ge�erli bir tarih i�eriyorsa &#3'+
'8;#34;True&#38;#34; d�nd�r�r"/>  <StrRes Name="IIF" Text="E�er ifade sonucu do�r'+
'u ise &#38;#34;True&#38;#34; di�er durumlarda &#38;#34;False&#38;#34; d�nd�r�r"/'+
'>  <StrRes Name="Get" Text="Sadece i� kullan�m i�in"/>  <StrRes Name="Set" Text='+
'"Sadece i� kullan�m i�in"/>  <StrRes Name="InputBox" Text="Kullan�c�n�n metin gi'+
'rebilmesi i�in bir bilgi giri� ekran� g�sterir"/>  <StrRes Name="InputQuery" Tex'+
't="Kullan�c�n�n metin girebilmesi i�in bir bilgi giri� ekran� g�sterir"/>  <StrR'+
'es Name="MessageDlg" Text="Mesaj kutusu g�ster"/>  <StrRes Name="CreateOleObject'+
'" Text="Bir OLE nesnesi olu�tur"/>  <StrRes Name="VarArrayCreate" Text="De�i�ebi'+
'lir dizi olu�tur"/>  <StrRes Name="VarType" Text="De�i�ebilir de�erin tipini d�n'+
'd�r"/>  <StrRes Name="DayOf" Text="Verilen tarihten g�n� (1..31) d�nderir"/>  <S'+
'trRes Name="MonthOf" Text="Verilen tarihten ay (1..12) d�nderir"/>  <StrRes Name'+
'="YearOf" Text="Verilen tarihten y�l� d�nderir"/>  <StrRes Name="ctAggregate" Te'+
'xt="Hesaplamalar"/>  <StrRes Name="Sum" Text="Bandtaki belirtilen alan�n toplam�'+
'n� hesapla"/>  <StrRes Name="Avg" Text="Bandtaki averajl� veriyi hesapla"/>  <St'+
'rRes Name="Min" Text="Bandtaki minimum veriyi hesapla"/>  <StrRes Name="Max" Tex'+
't="Bandtaki maksimum veriyi hesapla"/>  <StrRes Name="Count" Text="Data sat�r� k'+
'ay�t say�s�"/>  <StrRes Name="wzDBConn" Text="Yeni baglanti sihirbazi"/>  <StrRe'+
's Name="wzDBTable" Text="Yeni tablo sihirbazi"/>  <StrRes Name="wzDBQuery" Text='+
'"Yeni sorgu sihirbazi"/>  <StrRes Name="5800" Text="Baglantilar"/>  <StrRes Name'+
'="5801" Text="Yeni"/>  <StrRes Name="5802" Text="Sil"/>  <StrRes Name="cpName" T'+
'ext="Isim"/>  <StrRes Name="cpConnStr" Text="Baglanti bilgisi"/>  <StrRes Name="'+
'startCreateNew" Text="Yeni rapor olustur"/>  <StrRes Name="startCreateBlank" Tex'+
't="Bos rapor olustur"/>  <StrRes Name="startOpenReport" Text="Rapor ac"/>  <StrR'+
'es Name="startOpenLast" Text="Son raporu ac"/>  <StrRes Name="startEditAliases" '+
'Text="Ba�lant� takma isimlerini d�zenler"/>  <StrRes Name="startHelp" Text="Yard'+
'im"/>  <StrRes Name="5900" Text="De�er izleme Formu"/>  <StrRes Name="5901" Text'+
'="De�er ekle"/>  <StrRes Name="5902" Text="De�eri sil"/>  <StrRes Name="5903" Te'+
'xt="De�er d�zenle"/>  <StrRes Name="6000" Text="Miras hatas�"/>  <StrRes Name="6'+
'001" Text="Ana ve miras�� raporlar� ayn� nesneleri i�eriyor, ne yapal�m?"/>  <St'+
'rRes Name="6002" Text="�iftleri sil"/>  <StrRes Name="6003" Text="�simlerini de�'+
'i�tir"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
