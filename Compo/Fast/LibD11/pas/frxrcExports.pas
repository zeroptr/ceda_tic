unit frxrcExports;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1254">  <StrRes Name='+
'"8000" Text="Excel dosyasýna ver"/>  <StrRes Name="8001" Text="Stiller"/>  <StrR'+
'es Name="8002" Text="Resimler"/>  <StrRes Name="8003" Text="Hücreleri birleþtir"'+
'/>  <StrRes Name="8004" Text="Fast export"/>  <StrRes Name="8005" Text="WYSIWYG"'+
'/>  <StrRes Name="8006" Text="As text"/>  <StrRes Name="8007" Text="Background"/'+
'>  <StrRes Name="8008" Text="Kaydettikten sonra Excel''i aç"/>  <StrRes Name="800'+
'9" Text="Excel dosyasý (*.xls)|*.xls"/>  <StrRes Name="8010" Text=".xls"/>  <Str'+
'Res Name="8100" Text="Excel dosyasýna ver"/>  <StrRes Name="8101" Text="Stiller"'+
'/>  <StrRes Name="8102" Text="WYSIWYG"/>  <StrRes Name="8103" Text="Kaydettikten'+
' sonra Excel''i aç"/>  <StrRes Name="8104" Text="Background"/>  <StrRes Name="810'+
'5" Text="XML Excel dosyasý (*.xls)|*.xls"/>  <StrRes Name="8106" Text=".xls"/>  '+
'<StrRes Name="8200" Text="HTML dosyasýna ver"/>  <StrRes Name="8201" Text="Kayde'+
'ttikten sonra aç"/>  <StrRes Name="8202" Text="Stiller"/>  <StrRes Name="8203" T'+
'ext="Resimler"/>  <StrRes Name="8204" Text="Hepsi bir klasöre"/>  <StrRes Name="'+
'8205" Text="Sabit geniþlik"/>  <StrRes Name="8206" Text="Sayfa gezgini"/>  <StrR'+
'es Name="8207" Text="Çoklu sayfa"/>  <StrRes Name="8208" Text="Mozilla tarayýcýs'+
'ý"/>  <StrRes Name="8209" Text="Zemin"/>  <StrRes Name="8210" Text="HTML dosyasý'+
' (*.html)|*.html"/>  <StrRes Name="8211" Text=".html"/>  <StrRes Name="8300" Tex'+
't="Text dosyasýna ver (nokta-vuruþlu yazýcý)"/>  <StrRes Name="8301" Text="Önizl'+
'eme açýk/kapalý"/>  <StrRes Name="8302" Text=" Verme ayarlarý  "/>  <StrRes Name'+
'="8303" Text="Sayfa sonu"/>  <StrRes Name="8304" Text="OEM kod sayfasý"/>  <StrR'+
'es Name="8305" Text="Boþ satýrlar"/>  <StrRes Name="8306" Text="Baþlýk boþluðu"/'+
'>  <StrRes Name="8307" Text="Sayfalar:"/>  <StrRes Name="8308" Text="Sayfa numar'+
'alarýný ve/veya sayfa aralýklarýný virgülle ayýrarak girin. Örn. 1,3,5-12"/>  <S'+
'trRes Name="8309" Text=" Ölçeklendirme "/>  <StrRes Name="8310" Text="Yatay"/>  '+
'<StrRes Name="8311" Text="Dikey"/>  <StrRes Name="8312" Text=" Çerçeveler "/>  <'+
'StrRes Name="8313" Text="Yok"/>  <StrRes Name="8314" Text="Basit"/>  <StrRes Nam'+
'e="8315" Text="Grafik"/>  <StrRes Name="8316" Text="Sadece OEM kod sayfasý"/>  <'+
'StrRes Name="8317" Text="Kaydettikten sonra yazdýr"/>  <StrRes Name="8318" Text='+
'"Ayarlarý kaydet"/>  <StrRes Name="8319" Text=" Önizleme "/>  <StrRes Name="8320'+
'" Text="En:"/>  <StrRes Name="8321" Text="Boy:"/>  <StrRes Name="8322" Text="Say'+
'fa"/>  <StrRes Name="8323" Text="Yakýnlaþtýr"/>  <StrRes Name="8324" Text="Uzakl'+
'aþtýr"/>  <StrRes Name="8325" Text="Text dosyasý (nokta-vuruþlu yazýcý)(*.prn)|*'+
'.prn"/>  <StrRes Name="8326" Text=".prn"/>  <StrRes Name="8400" Text="Yazdýr"/> '+
' <StrRes Name="8401" Text="Yazýcý"/>  <StrRes Name="8402" Text="Adý"/>  <StrRes '+
'Name="8403" Text="Ayarlar..."/>  <StrRes Name="8404" Text="Kopya Sayýsý"/>  <Str'+
'Res Name="8405" Text="Kopya sayýsý"/>  <StrRes Name="8406" Text=" Yazýcý ayarlar'+
'ý "/>  <StrRes Name="8407" Text="Yazýcý türü"/>  <StrRes Name="8408" Text=".fpi"'+
'/>  <StrRes Name="8409" Text="Yazýcý þablonu(*.fpi)|*.fpi"/>  <StrRes Name="8410'+
'" Text=".fpi"/>  <StrRes Name="8411" Text="Yazýcý þablonu (*.fpi)|*.fpi"/>  <Str'+
'Res Name="8500" Text="RTF dosyasýna ver"/>  <StrRes Name="8501" Text="Resimler"/'+
'>  <StrRes Name="8502" Text="WYSIWYG"/>  <StrRes Name="8503" Text="Kaydettikten '+
'sonra aç"/>  <StrRes Name="8504" Text="RTF dosyasý (*.rtf)|*.rtf"/>  <StrRes Nam'+
'e="8505" Text=".rtf"/>  <StrRes Name="8600" Text="Verme ayarlarý"/>  <StrRes Nam'+
'e="8601" Text=" Resim Ayarlarý "/>  <StrRes Name="8602" Text="JPEG kalitesi"/>  '+
'<StrRes Name="8603" Text="Çözünürlük (dpi)"/>  <StrRes Name="8604" Text="Dosyala'+
'rý böl"/>  <StrRes Name="8605" Text="Sayfalarý Kýrp"/>  <StrRes Name="8606" Text'+
'="Siyah/Beyaz"/>  <StrRes Name="8700" Text="PDF dosyasýna ver"/>  <StrRes Name="'+
'8701" Text="Sýkýþtýrýlmýþ"/>  <StrRes Name="8702" Text="Yazý karakterlerini için'+
'e göm"/>  <StrRes Name="8703" Text="Print optimized"/>  <StrRes Name="8704" Text'+
'="Zemin"/>  <StrRes Name="8705" Text="Kaydettikten sonra aç"/>  <StrRes Name="87'+
'06" Text="Dýþ çizgi"/>  <StrRes Name="8707" Text="Adobe PDF dosyasý (*.pdf)|*.pd'+
'f"/>  <StrRes Name="8708" Text=".pdf"/>  <StrRes Name="RTFexport" Text="RTF dosy'+
'asý"/>  <StrRes Name="BMPexport" Text="BMP resmi"/>  <StrRes Name="JPEGexport" T'+
'ext="JPEG resmi"/>  <StrRes Name="TIFFexport" Text="TIFF resmi"/>  <StrRes Name='+
'"TextExport" Text="Text (nokta-vuruþlu yazýcý)"/>  <StrRes Name="XlsOLEexport" T'+
'ext="Excel tablosu (OLE)"/>  <StrRes Name="HTMLexport" Text="HTML dosyasý"/>  <S'+
'trRes Name="XlsXMLexport" Text="Excel tablosu (XML)"/>  <StrRes Name="PDFexport"'+
' Text="PDF dosyasý"/>  <StrRes Name="ProgressWait" Text="Lütfen bekleyin"/>  <St'+
'rRes Name="ProgressRows" Text="Satýrlar düzenleniyor"/>  <StrRes Name="ProgressC'+
'olumns" Text="Kolonlar düzenleniyor"/>  <StrRes Name="ProgressStyles" Text="Stil'+
'ler düzenleniyor"/>  <StrRes Name="ProgressObjects" Text="Nesneler veriliyor"/> '+
' <StrRes Name="TIFFexportFilter" Text="TIFF resmi (*.tif)|*.tif"/>  <StrRes Name'+
'="BMPexportFilter" Text="BMP resmi (*.bmp)|*.bmp"/>  <StrRes Name="JPEGexportFil'+
'ter" Text="JPEG resmi (*.jpg)|*.jpg"/>  <StrRes Name="HTMLNavFirst" Text="Ilk"/>'+
'  <StrRes Name="HTMLNavPrev" Text="Onceki"/>  <StrRes Name="HTMLNavNext" Text="S'+
'onraki"/>  <StrRes Name="HTMLNavLast" Text="Son"/>  <StrRes Name="HTMLNavRefresh'+
'" Text="Guncelle"/>  <StrRes Name="HTMLNavPrint" Text="Yaz"/>  <StrRes Name="HTM'+
'LNavTotal" Text="Toplam sayfa"/>  <StrRes Name="8800" Text="Veri ver Text format'+
'inda"/>  <StrRes Name="8801" Text="Text dosyasi (*.txt)|*.txt"/>  <StrRes Name="'+
'8802" Text=".txt"/>  <StrRes Name="SimpleTextExport" Text="Text dosya"/>  <StrRe'+
's Name="8850" Text="Veri ver CSV formatinda"/>  <StrRes Name="8851" Text="CSV do'+
'syasi (*.csv)|*.csv"/>  <StrRes Name="8852" Text=".csv"/>  <StrRes Name="8853" T'+
'ext="Ayrac"/>  <StrRes Name="CSVExport" Text="CSV dosya"/>  <StrRes Name="8900" '+
'Text="Send by E-mail"/>  <StrRes Name="8901" Text="E-Posta"/>  <StrRes Name="890'+
'2" Text="Hesap"/>  <StrRes Name="8903" Text="Baglanti"/>  <StrRes Name="8904" Te'+
'xt="Adres"/>  <StrRes Name="8905" Text="Eklenen dosya"/>  <StrRes Name="8906" Te'+
'xt="Dosya formati"/>  <StrRes Name="8907" Text="Gonderen adresi"/>  <StrRes Name'+
'="8908" Text="Gonderen isim"/>  <StrRes Name="8909" Text="Host"/>  <StrRes Name='+
'"8910" Text="Giriþ"/>  <StrRes Name="8911" Text="Posta"/>  <StrRes Name="8912" T'+
'ext="Mesaj"/>  <StrRes Name="8913" Text="Text"/>  <StrRes Name="8914" Text="Firm'+
'a"/>  <StrRes Name="8915" Text="Sifre"/>  <StrRes Name="8916" Text="Port"/>  <St'+
'rRes Name="8917" Text="Ozellikleri hatirla"/>  <StrRes Name="8918" Text="Zorunlu'+
' sahalar girilmemiþ"/>  <StrRes Name="8919" Text="Geliþmiþ veri verme ayarlarý"/'+
'>  <StrRes Name="8920" Text="Ýmza"/>  <StrRes Name="8921" Text="Build"/>  <StrRe'+
's Name="8922" Text="Konu"/>  <StrRes Name="8923" Text="En iyi dileklerimle"/>  <'+
'StrRes Name="8924" Text="mail at :"/>  <StrRes Name="EmailExport" Text="E-mail"/'+
'>  <StrRes Name="FastReportFile" Text="FastReport dosyasý"/>  <StrRes Name="Gife'+
'xportFilter" Text="Gif file (*.gif)|*.gif"/>  <StrRes Name="GIFexport" Text="Gif'+
' image"/>  <StrRes Name="8950" Text="Sürekli"/>  <StrRes Name="8951" Text="Sayfa'+
' Üstbilgi/Altbilgi "/>  <StrRes Name="8952" Text="Text"/>  <StrRes Name="8953" T'+
'ext="Üstbilgi/Altbilgi"/>  <StrRes Name="8954" Text="Yok"/>  <StrRes Name="ODSEx'+
'portFilter" Text="Tablo döküman dosyasý aç (*.ods)|*.ods"/>  <StrRes Name="ODSEx'+
'port" Text="Tablo döküman dosyasý aç"/>  <StrRes Name="ODTExportFilter" Text="Me'+
'tin dosyasý aç (*.odt)|*.odt"/>  <StrRes Name="ODTExport" Text="Metin dosyasý aç'+
'"/>  <StrRes Name="8960" Text=".ods"/>  <StrRes Name="8961" Text=".odt"/>  <StrR'+
'es Name="8962" Text="Security"/>  <StrRes Name="8963" Text="Security settings"/>'+
'  <StrRes Name="8964" Text="Owner password"/>  <StrRes Name="8965" Text="User pa'+
'ssword"/>  <StrRes Name="8966" Text="Print the document"/>  <StrRes Name="8967" '+
'Text="Modify the document"/>  <StrRes Name="8968" Text="Copy of text and graphic'+
's"/>  <StrRes Name="8969" Text="Add or modify text annotations"/>  <StrRes Name='+
'"8970" Text="PDF Security"/>  <StrRes Name="8971" Text="Document information"/> '+
' <StrRes Name="8972" Text="Information"/>  <StrRes Name="8973" Text="Title"/>  <'+
'StrRes Name="8974" Text="Author"/>  <StrRes Name="8975" Text="Subject"/>  <StrRe'+
's Name="8976" Text="Keywords"/>  <StrRes Name="8977" Text="Creator"/>  <StrRes N'+
'ame="8978" Text="Producer"/>  <StrRes Name="8979" Text="Authentification"/>  <St'+
'rRes Name="8980" Text="Permissions"/>  <StrRes Name="8981" Text="Viewer"/>  <Str'+
'Res Name="8982" Text="Viewer preferences"/>  <StrRes Name="8983" Text="Hide tool'+
'bar"/>  <StrRes Name="8984" Text="Hide menubar"/>  <StrRes Name="8985" Text="Hid'+
'e window user interface"/>  <StrRes Name="8986" Text="Fit window"/>  <StrRes Nam'+
'e="8987" Text="Center window"/>  <StrRes Name="8988" Text="Print scaling"/>  <St'+
'rRes Name="8989" Text="Confirmation Reading"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
