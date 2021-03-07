unit frxrcClass;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1254">  <StrRes Name='+
'"1" Text="Tamam"/>  <StrRes Name="2" Text="Vazge�"/>  <StrRes Name="3" Text="T�m'+
'�"/>  <StrRes Name="4" Text="Ge�erli sayfa"/>  <StrRes Name="5" Text="Sayfalar:"'+
'/>  <StrRes Name="6" Text="Sayfa sonu"/>  <StrRes Name="7" Text="Yazd�rma Aral��'+
'�"/>  <StrRes Name="8" Text="Verme ayarlar�"/>  <StrRes Name="9" Text="Sayfa num'+
'aralar�n� ve/veya sayfa aral�klar�n� virg�lle ay�rarak girin. �rn. 1,3,5-12"/>  '+
'<StrRes Name="100" Text="�nizleme"/>  <StrRes Name="101" Text="Yazd�r"/>  <StrRe'+
's Name="102" Text="Yazd�r"/>  <StrRes Name="103" Text="A�"/>  <StrRes Name="104"'+
' Text="A�"/>  <StrRes Name="105" Text="Kaydet"/>  <StrRes Name="106" Text="Kayde'+
't"/>  <StrRes Name="107" Text="Veri Ver"/>  <StrRes Name="108" Text="Veri Ver"/>'+
'  <StrRes Name="109" Text="Bul"/>  <StrRes Name="110" Text="Bul"/>  <StrRes Name'+
'="111" Text="T�m Sayfa"/>  <StrRes Name="112" Text="T�m Sayfa"/>  <StrRes Name="'+
'113" Text="Sayfa Geni�li�i"/>  <StrRes Name="114" Text="Sayfa Geni�li�i"/>  <Str'+
'Res Name="115" Text="%100"/>  <StrRes Name="116" Text="%100"/>  <StrRes Name="11'+
'7" Text="�ki Sayfa"/>  <StrRes Name="118" Text="�ki Sayfa"/>  <StrRes Name="119"'+
' Text="Yak�nla�t�r"/>  <StrRes Name="120" Text="Kenar Bo�luklar�"/>  <StrRes Nam'+
'e="121" Text="Kenar Bo�luklar�"/>  <StrRes Name="122" Text="Anahat"/>  <StrRes N'+
'ame="123" Text="Anahat"/>  <StrRes Name="124" Text="Yakla�"/>  <StrRes Name="125'+
'" Text="Yak�a�"/>  <StrRes Name="126" Text="Uzakla�"/>  <StrRes Name="127" Text='+
'"Uzakla�"/>  <StrRes Name="128" Text="D��hat"/>  <StrRes Name="129" Text="D��hat'+
' rapor"/>  <StrRes Name="130" Text="K���k resimler"/>  <StrRes Name="131" Text="'+
'K���k resimler"/>  <StrRes Name="132" Text="D�zenlet"/>  <StrRes Name="133" Text'+
'="Sayfa D�zenle"/>  <StrRes Name="134" Text="�lk"/>  <StrRes Name="135" Text="�l'+
'k Sayfa"/>  <StrRes Name="136" Text="�nceki"/>  <StrRes Name="137" Text="�nceki '+
'Sayfa"/>  <StrRes Name="138" Text="Sonraki"/>  <StrRes Name="139" Text="Sonraki '+
'Sayfa"/>  <StrRes Name="140" Text="Son"/>  <StrRes Name="141" Text="Son Sayfa"/>'+
'  <StrRes Name="142" Text="Sayfa Numaras�"/>  <StrRes Name="150" Text="Tam ekran'+
'"/>  <StrRes Name="151" Text="Veri ver PDF format�nda"/>  <StrRes Name="152" Tex'+
't="E-Posta g�nder"/>  <StrRes Name="zmPageWidth" Text="Sayfa geni�li�i"/>  <StrR'+
'es Name="zmWholePage" Text="T�m sayfa"/>  <StrRes Name="200" Text="Yazd�r"/>  <S'+
'trRes Name="201" Text="Yaz�c�"/>  <StrRes Name="202" Text="Sayfa Aral���"/>  <St'+
'rRes Name="203" Text="Kopya Say�s�"/>  <StrRes Name="204" Text="Harmanla"/>  <St'+
'rRes Name="205" Text="Kopya say�s�"/>  <StrRes Name="206" Text="Yazd�r"/>  <StrR'+
'es Name="207" Text="Di�er"/>  <StrRes Name="208" Text="Konum:"/>  <StrRes Name="'+
'209" Text="�zellikler..."/>  <StrRes Name="210" Text="Dosyaya yazd�r"/>  <StrRes'+
' Name="211" Text="Sipari�"/>  <StrRes Name="212" Text="Ad�:"/>  <StrRes Name="21'+
'3" Text="Bask� modu"/>  <StrRes Name="214" Text="Sayfaya yazd�r"/>  <StrRes Name'+
'="216" Text="�ifthat"/>  <StrRes Name="ppAll" Text="T�m sayfalar"/>  <StrRes Nam'+
'e="ppOdd" Text="Tek sayfalar"/>  <StrRes Name="ppEven" Text="�ift sayfalar"/>  <'+
'StrRes Name="pgDefault" Text="�nde�er"/>  <StrRes Name="pmDefault" Text="�nde�er'+
'"/>  <StrRes Name="pmSplit" Text="B�y�k sayfalar� b�l"/>  <StrRes Name="pmJoin" '+
'Text="K���k sayfalara birle�tir"/>  <StrRes Name="pmScale" Text="Boyut"/>  <StrR'+
'es Name="poDirect" Text="Do�rudan (1-9)"/>  <StrRes Name="poReverse" Text="Ters '+
'(9-1)"/>  <StrRes Name="300" Text="Bul"/>  <StrRes Name="301" Text="Aranacak kel'+
'ime:"/>  <StrRes Name="302" Text="Arama se�enekleri"/>  <StrRes Name="303" Text='+
'"De�i�tir"/>  <StrRes Name="304" Text="Ba�tan ara"/>  <StrRes Name="305" Text="B'+
'�y�k/k���k harf duyarl�"/>  <StrRes Name="400" Text="Sayfa Ayarlar�"/>  <StrRes '+
'Name="401" Text="Geni�lik"/>  <StrRes Name="402" Text="Y�kseklik"/>  <StrRes Nam'+
'e="403" Text="Ka��t Boyutu  "/>  <StrRes Name="404" Text="Y�nlendirme  "/>  <Str'+
'Res Name="405" Text="Sol"/>  <StrRes Name="406" Text="�st"/>  <StrRes Name="407"'+
' Text="Sa�"/>  <StrRes Name="408" Text="Alt"/>  <StrRes Name="409" Text="Kenar B'+
'o�luklar� "/>  <StrRes Name="410" Text="Dikey"/>  <StrRes Name="411" Text="Yatay'+
'"/>  <StrRes Name="412" Text="Di�er  "/>  <StrRes Name="413" Text="Ge�erli sayfa'+
'ya uygula"/>  <StrRes Name="414" Text="T�m sayfalara uygula"/>  <StrRes Name="50'+
'0" Text="Yazd�r"/>  <StrRes Name="501" Text="Yaz�c�"/>  <StrRes Name="502" Text='+
'"Sayfa Aral���"/>  <StrRes Name="503" Text="Kopya Say�s�"/>  <StrRes Name="504" '+
'Text="Kopya Say�s�"/>  <StrRes Name="505" Text="Se�enekler"/>  <StrRes Name="506'+
'" Text="��k�� �ekli"/>  <StrRes Name="507" Text="Dosyaya yazdir"/>  <StrRes Name'+
'="508" Text="OEM kod sayfas�"/>  <StrRes Name="509" Text="Pseudographic"/>  <Str'+
'Res Name="510" Text="Yaz�c� dosyas� (*.prn)|*.prn"/>  <StrRes Name="mbConfirm" T'+
'ext="Onayla"/>  <StrRes Name="mbError" Text="Hata"/>  <StrRes Name="mbInfo" Text'+
'="Bilgi"/>  <StrRes Name="xrCantFindClass" Text="S�n�f bulunamad�"/>  <StrRes Na'+
'me="prVirtual" Text="Sanal"/>  <StrRes Name="prDefault" Text="Varsay�lan"/>  <St'+
'rRes Name="prCustom" Text="�zel"/>  <StrRes Name="enUnconnHeader" Text="Ba�lant�'+
's�z Rapor Ba�l���/Sonu"/>  <StrRes Name="enUnconnGroup" Text="Grup i�in veri ban'+
'd� yok"/>  <StrRes Name="enUnconnGFooter" Text="Grup ba�l��� olmayan"/>  <StrRes'+
' Name="enBandPos" Text="Ge�ersiz band pozisyonu:"/>  <StrRes Name="dbNotConn" Te'+
'xt="%s DataSet''i veriye ba�lanmam��"/>  <StrRes Name="dbFldNotFound" Text="Saha '+
'bulunamad�:"/>  <StrRes Name="clDSNotIncl" Text="(Rapor.DataSets''e dataset tan�m'+
'lanmam��)"/>  <StrRes Name="clUnknownVar" Text="Bilinmeyen de�i�ken veya saha:"/'+
'>  <StrRes Name="clScrError" Text="Script Hatas� %s: %s"/>  <StrRes Name="clDSNo'+
'tExist" Text="&#38;#34;%s&#38;#34; Dataset''i olu�turulmam��"/>  <StrRes Name="cl'+
'Errors" Text="A�a��daki hata(lar) olu�tu:"/>  <StrRes Name="clExprError" Text="S'+
'�z dizimi hatas�"/>  <StrRes Name="clFP3files" Text="Rapor Haz�rland�"/>  <StrRe'+
's Name="clSaving" Text="Dosya Kaydediliyor..."/>  <StrRes Name="clCancel" Text="'+
'Vazge�"/>  <StrRes Name="clClose" Text="Kapat"/>  <StrRes Name="clPrinting" Text'+
'="Sayfa yazd�r�l�yor"/>  <StrRes Name="clLoading" Text="Dosya y�kleniyor..."/>  '+
'<StrRes Name="clPageOf" Text="Sayfa %d / %d"/>  <StrRes Name="clFirstPass" Text='+
'"�lk ge�i�: sayfa "/>  <StrRes Name="clNoPrinters" Text="Bilgisayar�n�zda kurulu'+
' hi�bir yaz�c� yok"/>  <StrRes Name="clDecompressError" Text="Ak�� a��lma hatas�'+
'"/>  <StrRes Name="prRunningFirst" Text="�lk �al��an : sayfa %d"/>  <StrRes Name'+
'="prRunning" Text="Haz�rlanan sayfa %d"/>  <StrRes Name="prPrinting" Text="Yaz�l'+
'an sayfa %d"/>  <StrRes Name="prExporting" Text="Sayfa d��ar� at�l�yor %d"/>  <S'+
'trRes Name="uCm" Text="cm"/>  <StrRes Name="uInch" Text="in"/>  <StrRes Name="uP'+
'ix" Text="px"/>  <StrRes Name="uChar" Text="chr"/>  <StrRes Name="dupDefault" Te'+
'xt="�nde�er"/>  <StrRes Name="dupVert" Text="Yatay"/>  <StrRes Name="dupHorz" Te'+
'xt="Dikey"/>  <StrRes Name="dupSimpl" Text="Basit"/>  <StrRes Name="crFillMx" Te'+
'xt="�apraz tablo dolduruluyor..."/>  <StrRes Name="crBuildMx" Text="�apraz tablo'+
' olu�turuluyor..."/>  <StrRes Name="SLangNotFound" Text="''%s'' dili bulunamad�"/>'+
'  <StrRes Name="SInvalidLanguage" Text="Ge�ersiz dil tan�m�"/>  <StrRes Name="SI'+
'dRedeclared" Text="Tekrarlanm�� nitelik: "/>  <StrRes Name="SUnknownType" Text="'+
'Bilinmeyen tip: "/>  <StrRes Name="SIncompatibleTypes" Text="Tip uyu�mazl���"/> '+
' <StrRes Name="SIdUndeclared" Text="Tan�mlanmam�� nitelik: "/>  <StrRes Name="SC'+
'lassRequired" Text="S�n�f tipi gerekli"/>  <StrRes Name="SIndexRequired" Text="�'+
'ndeks gerekli"/>  <StrRes Name="SStringError" Text="�zellikleri veya Metotlar� o'+
'lmayan String''ler"/>  <StrRes Name="SClassError" Text="%s s�n�f�n�n varsay�lan �'+
'zelli�i yok"/>  <StrRes Name="SArrayRequired" Text="Dizi tipi gerekli"/>  <StrRe'+
's Name="SVarRequired" Text="De�i�ken gerekli"/>  <StrRes Name="SNotEnoughParams"'+
' Text="Eksik parametre"/>  <StrRes Name="STooManyParams" Text="�ok fazla paramet'+
're"/>  <StrRes Name="SLeftCantAssigned" Text="Sol tarafa de�er atanamaz"/>  <Str'+
'Res Name="SForError" Text="D�ng� de�i�keni say�sal olmal�d�r"/>  <StrRes Name="S'+
'EventError" Text="Olay yakalay�c� prosed�r olmal�d�r"/>  <StrRes Name="600" Text'+
'="T�m�n� a�"/>  <StrRes Name="601" Text="T�m�n� kapat"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
