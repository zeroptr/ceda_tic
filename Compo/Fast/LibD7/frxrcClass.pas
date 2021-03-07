unit frxrcClass;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1254">  <StrRes Name='+
'"1" Text="Tamam"/>  <StrRes Name="2" Text="Vazgeç"/>  <StrRes Name="3" Text="Tüm'+
'ü"/>  <StrRes Name="4" Text="Geçerli sayfa"/>  <StrRes Name="5" Text="Sayfalar:"'+
'/>  <StrRes Name="6" Text="Sayfa sonu"/>  <StrRes Name="7" Text="Yazdýrma Aralýð'+
'ý"/>  <StrRes Name="8" Text="Verme ayarlarý"/>  <StrRes Name="9" Text="Sayfa num'+
'aralarýný ve/veya sayfa aralýklarýný virgülle ayýrarak girin. Örn. 1,3,5-12"/>  '+
'<StrRes Name="100" Text="Önizleme"/>  <StrRes Name="101" Text="Yazdýr"/>  <StrRe'+
's Name="102" Text="Yazdýr"/>  <StrRes Name="103" Text="Aç"/>  <StrRes Name="104"'+
' Text="Aç"/>  <StrRes Name="105" Text="Kaydet"/>  <StrRes Name="106" Text="Kayde'+
't"/>  <StrRes Name="107" Text="Veri Ver"/>  <StrRes Name="108" Text="Veri Ver"/>'+
'  <StrRes Name="109" Text="Bul"/>  <StrRes Name="110" Text="Bul"/>  <StrRes Name'+
'="111" Text="Tüm Sayfa"/>  <StrRes Name="112" Text="Tüm Sayfa"/>  <StrRes Name="'+
'113" Text="Sayfa Geniþliði"/>  <StrRes Name="114" Text="Sayfa Geniþliði"/>  <Str'+
'Res Name="115" Text="%100"/>  <StrRes Name="116" Text="%100"/>  <StrRes Name="11'+
'7" Text="Ýki Sayfa"/>  <StrRes Name="118" Text="Ýki Sayfa"/>  <StrRes Name="119"'+
' Text="Yakýnlaþtýr"/>  <StrRes Name="120" Text="Kenar Boþluklarý"/>  <StrRes Nam'+
'e="121" Text="Kenar Boþluklarý"/>  <StrRes Name="122" Text="Anahat"/>  <StrRes N'+
'ame="123" Text="Anahat"/>  <StrRes Name="124" Text="Yaklaþ"/>  <StrRes Name="125'+
'" Text="Yakþaþ"/>  <StrRes Name="126" Text="Uzaklaþ"/>  <StrRes Name="127" Text='+
'"Uzaklaþ"/>  <StrRes Name="128" Text="Dýþhat"/>  <StrRes Name="129" Text="Dýþhat'+
' rapor"/>  <StrRes Name="130" Text="Küçük resimler"/>  <StrRes Name="131" Text="'+
'Küçük resimler"/>  <StrRes Name="132" Text="Düzenlet"/>  <StrRes Name="133" Text'+
'="Sayfa Düzenle"/>  <StrRes Name="134" Text="Ýlk"/>  <StrRes Name="135" Text="Ýl'+
'k Sayfa"/>  <StrRes Name="136" Text="Önceki"/>  <StrRes Name="137" Text="Önceki '+
'Sayfa"/>  <StrRes Name="138" Text="Sonraki"/>  <StrRes Name="139" Text="Sonraki '+
'Sayfa"/>  <StrRes Name="140" Text="Son"/>  <StrRes Name="141" Text="Son Sayfa"/>'+
'  <StrRes Name="142" Text="Sayfa Numarasý"/>  <StrRes Name="150" Text="Tam ekran'+
'"/>  <StrRes Name="151" Text="Veri ver PDF formatýnda"/>  <StrRes Name="152" Tex'+
't="E-Posta gönder"/>  <StrRes Name="zmPageWidth" Text="Sayfa geniþliði"/>  <StrR'+
'es Name="zmWholePage" Text="Tüm sayfa"/>  <StrRes Name="200" Text="Yazdýr"/>  <S'+
'trRes Name="201" Text="Yazýcý"/>  <StrRes Name="202" Text="Sayfa Aralýðý"/>  <St'+
'rRes Name="203" Text="Kopya Sayýsý"/>  <StrRes Name="204" Text="Harmanla"/>  <St'+
'rRes Name="205" Text="Kopya sayýsý"/>  <StrRes Name="206" Text="Yazdýr"/>  <StrR'+
'es Name="207" Text="Diðer"/>  <StrRes Name="208" Text="Konum:"/>  <StrRes Name="'+
'209" Text="Özellikler..."/>  <StrRes Name="210" Text="Dosyaya yazdýr"/>  <StrRes'+
' Name="211" Text="Sipariþ"/>  <StrRes Name="212" Text="Adý:"/>  <StrRes Name="21'+
'3" Text="Baský modu"/>  <StrRes Name="214" Text="Sayfaya yazdýr"/>  <StrRes Name'+
'="216" Text="Çifthat"/>  <StrRes Name="ppAll" Text="Tüm sayfalar"/>  <StrRes Nam'+
'e="ppOdd" Text="Tek sayfalar"/>  <StrRes Name="ppEven" Text="Çift sayfalar"/>  <'+
'StrRes Name="pgDefault" Text="Öndeðer"/>  <StrRes Name="pmDefault" Text="Öndeðer'+
'"/>  <StrRes Name="pmSplit" Text="Büyük sayfalarý böl"/>  <StrRes Name="pmJoin" '+
'Text="Küçük sayfalara birleþtir"/>  <StrRes Name="pmScale" Text="Boyut"/>  <StrR'+
'es Name="poDirect" Text="Doðrudan (1-9)"/>  <StrRes Name="poReverse" Text="Ters '+
'(9-1)"/>  <StrRes Name="300" Text="Bul"/>  <StrRes Name="301" Text="Aranacak kel'+
'ime:"/>  <StrRes Name="302" Text="Arama seçenekleri"/>  <StrRes Name="303" Text='+
'"Deðiþtir"/>  <StrRes Name="304" Text="Baþtan ara"/>  <StrRes Name="305" Text="B'+
'üyük/küçük harf duyarlý"/>  <StrRes Name="400" Text="Sayfa Ayarlarý"/>  <StrRes '+
'Name="401" Text="Geniþlik"/>  <StrRes Name="402" Text="Yükseklik"/>  <StrRes Nam'+
'e="403" Text="Kaðýt Boyutu  "/>  <StrRes Name="404" Text="Yönlendirme  "/>  <Str'+
'Res Name="405" Text="Sol"/>  <StrRes Name="406" Text="Üst"/>  <StrRes Name="407"'+
' Text="Sað"/>  <StrRes Name="408" Text="Alt"/>  <StrRes Name="409" Text="Kenar B'+
'oþluklarý "/>  <StrRes Name="410" Text="Dikey"/>  <StrRes Name="411" Text="Yatay'+
'"/>  <StrRes Name="412" Text="Diðer  "/>  <StrRes Name="413" Text="Geçerli sayfa'+
'ya uygula"/>  <StrRes Name="414" Text="Tüm sayfalara uygula"/>  <StrRes Name="50'+
'0" Text="Yazdýr"/>  <StrRes Name="501" Text="Yazýcý"/>  <StrRes Name="502" Text='+
'"Sayfa Aralýðý"/>  <StrRes Name="503" Text="Kopya Sayýsý"/>  <StrRes Name="504" '+
'Text="Kopya Sayýsý"/>  <StrRes Name="505" Text="Seçenekler"/>  <StrRes Name="506'+
'" Text="Çýkýþ þekli"/>  <StrRes Name="507" Text="Dosyaya yazdir"/>  <StrRes Name'+
'="508" Text="OEM kod sayfasý"/>  <StrRes Name="509" Text="Pseudographic"/>  <Str'+
'Res Name="510" Text="Yazýcý dosyasý (*.prn)|*.prn"/>  <StrRes Name="mbConfirm" T'+
'ext="Onayla"/>  <StrRes Name="mbError" Text="Hata"/>  <StrRes Name="mbInfo" Text'+
'="Bilgi"/>  <StrRes Name="xrCantFindClass" Text="Sýnýf bulunamadý"/>  <StrRes Na'+
'me="prVirtual" Text="Sanal"/>  <StrRes Name="prDefault" Text="Varsayýlan"/>  <St'+
'rRes Name="prCustom" Text="Özel"/>  <StrRes Name="enUnconnHeader" Text="Baðlantý'+
'sýz Rapor Baþlýðý/Sonu"/>  <StrRes Name="enUnconnGroup" Text="Grup için veri ban'+
'dý yok"/>  <StrRes Name="enUnconnGFooter" Text="Grup baþlýðý olmayan"/>  <StrRes'+
' Name="enBandPos" Text="Geçersiz band pozisyonu:"/>  <StrRes Name="dbNotConn" Te'+
'xt="%s DataSet''i veriye baðlanmamýþ"/>  <StrRes Name="dbFldNotFound" Text="Saha '+
'bulunamadý:"/>  <StrRes Name="clDSNotIncl" Text="(Rapor.DataSets''e dataset taným'+
'lanmamýþ)"/>  <StrRes Name="clUnknownVar" Text="Bilinmeyen deðiþken veya saha:"/'+
'>  <StrRes Name="clScrError" Text="Script Hatasý %s: %s"/>  <StrRes Name="clDSNo'+
'tExist" Text="&#38;#34;%s&#38;#34; Dataset''i oluþturulmamýþ"/>  <StrRes Name="cl'+
'Errors" Text="Aþaðýdaki hata(lar) oluþtu:"/>  <StrRes Name="clExprError" Text="S'+
'öz dizimi hatasý"/>  <StrRes Name="clFP3files" Text="Rapor Hazýrlandý"/>  <StrRe'+
's Name="clSaving" Text="Dosya Kaydediliyor..."/>  <StrRes Name="clCancel" Text="'+
'Vazgeç"/>  <StrRes Name="clClose" Text="Kapat"/>  <StrRes Name="clPrinting" Text'+
'="Sayfa yazdýrýlýyor"/>  <StrRes Name="clLoading" Text="Dosya yükleniyor..."/>  '+
'<StrRes Name="clPageOf" Text="Sayfa %d / %d"/>  <StrRes Name="clFirstPass" Text='+
'"Ýlk geçiþ: sayfa "/>  <StrRes Name="clNoPrinters" Text="Bilgisayarýnýzda kurulu'+
' hiçbir yazýcý yok"/>  <StrRes Name="clDecompressError" Text="Akýþ açýlma hatasý'+
'"/>  <StrRes Name="prRunningFirst" Text="Ýlk çalýþan : sayfa %d"/>  <StrRes Name'+
'="prRunning" Text="Hazýrlanan sayfa %d"/>  <StrRes Name="prPrinting" Text="Yazýl'+
'an sayfa %d"/>  <StrRes Name="prExporting" Text="Sayfa dýþarý atýlýyor %d"/>  <S'+
'trRes Name="uCm" Text="cm"/>  <StrRes Name="uInch" Text="in"/>  <StrRes Name="uP'+
'ix" Text="px"/>  <StrRes Name="uChar" Text="chr"/>  <StrRes Name="dupDefault" Te'+
'xt="Öndeðer"/>  <StrRes Name="dupVert" Text="Yatay"/>  <StrRes Name="dupHorz" Te'+
'xt="Dikey"/>  <StrRes Name="dupSimpl" Text="Basit"/>  <StrRes Name="crFillMx" Te'+
'xt="Çapraz tablo dolduruluyor..."/>  <StrRes Name="crBuildMx" Text="Çapraz tablo'+
' oluþturuluyor..."/>  <StrRes Name="SLangNotFound" Text="''%s'' dili bulunamadý"/>'+
'  <StrRes Name="SInvalidLanguage" Text="Geçersiz dil tanýmý"/>  <StrRes Name="SI'+
'dRedeclared" Text="Tekrarlanmýþ nitelik: "/>  <StrRes Name="SUnknownType" Text="'+
'Bilinmeyen tip: "/>  <StrRes Name="SIncompatibleTypes" Text="Tip uyuþmazlýðý"/> '+
' <StrRes Name="SIdUndeclared" Text="Tanýmlanmamýþ nitelik: "/>  <StrRes Name="SC'+
'lassRequired" Text="Sýnýf tipi gerekli"/>  <StrRes Name="SIndexRequired" Text="Ý'+
'ndeks gerekli"/>  <StrRes Name="SStringError" Text="Özellikleri veya Metotlarý o'+
'lmayan String''ler"/>  <StrRes Name="SClassError" Text="%s sýnýfýnýn varsayýlan ö'+
'zelliði yok"/>  <StrRes Name="SArrayRequired" Text="Dizi tipi gerekli"/>  <StrRe'+
's Name="SVarRequired" Text="Deðiþken gerekli"/>  <StrRes Name="SNotEnoughParams"'+
' Text="Eksik parametre"/>  <StrRes Name="STooManyParams" Text="Çok fazla paramet'+
're"/>  <StrRes Name="SLeftCantAssigned" Text="Sol tarafa deðer atanamaz"/>  <Str'+
'Res Name="SForError" Text="Döngü deðiþkeni sayýsal olmalýdýr"/>  <StrRes Name="S'+
'EventError" Text="Olay yakalayýcý prosedür olmalýdýr"/>  <StrRes Name="600" Text'+
'="Tümünü aç"/>  <StrRes Name="601" Text="Tümünü kapat"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
