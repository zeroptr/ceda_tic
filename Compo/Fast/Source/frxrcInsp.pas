unit frxrcInsp;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1254">  <StrRes Name='+
'"propActive" Text="Dataset''in a��k olup olmad���n� belirler"/>  <StrRes Name="pr'+
'opActive.TfrxHighlight" Text="Y�ksek kar��tl�k a��k"/>  <StrRes Name="propAliasN'+
'ame" Text="BDE''nin g�r�nen ad�"/>  <StrRes Name="propAlign" Text="Bir band veya '+
'sayfaya ba�l� nesnelerin d�zenini belirler"/>  <StrRes Name="propAlignment" Text'+
'="Nesnenin metninin hizas�"/>  <StrRes Name="propAllowAllUp" Text="Grup i�indeki'+
' t�m Speed Button''lar�n�n ayn� anda se�ilmesine olanak sa�lar"/>  <StrRes Name="'+
'propAllowEdit" Text="Kullan�c�n�n haz�rlanm�� rapor sayfalar�n� d�zenlemesine ol'+
'anak sa�lar"/>  <StrRes Name="propAllowExpressions" Text="Metin nesnelerinin anl'+
'at�m ifadeleri i�ermelerine olanak sa�lar"/>  <StrRes Name="propAllowGrayed" Tex'+
't="CheckBox''lar�n durumunun gri olmas�na izin verir"/>  <StrRes Name="propAllowH'+
'TMLTags" Text="Metin nesnelerinin HTML kodu i�ermelerine olanak sa�lar"/>  <StrR'+
'es Name="propAllowSplit" Text="Bir sayfaya s��mayan, bir sayfadan daha uzun meti'+
'nlerin, b�l�nerek birden fazla sayfada g�sterilmesine olanak sa�lar"/>  <StrRes '+
'Name="propAuthor" Text="Raporun yazar�"/>  <StrRes Name="propAutoSize.TfrxPictur'+
'eView" Text="Resimlerin otomatik �l��lendirilmesine olanak sa�lar"/>  <StrRes Na'+
'me="propAutoWidth" Text="Metin nesnelerinin geni�liklerinin otomatik �l��lendiri'+
'lmesine olanak sa�lar"/>  <StrRes Name="propBackPicture" Text="Sayfa arkaplan re'+
'smi"/>  <StrRes Name="propBarType" Text="Barkod tipi"/>  <StrRes Name="propBevel'+
'Inner" Text="Bevel''in i� tipi"/>  <StrRes Name="propBevelOuter" Text="Bevel''in d'+
'�� tipi"/>  <StrRes Name="propBevelWidth" Text="Bevel''in geni�li�i"/>  <StrRes N'+
'ame="propBorder" Text="D�� �er�eve �izgilerinin g�r�nmesine olanak sa�lar"/>  <S'+
'trRes Name="propBorderStyle" Text="Pencerenin stili"/>  <StrRes Name="propBottom'+
'Margin" Text="Sayfa alt bo�lu�unun �l��s�"/>  <StrRes Name="propBrushStyle" Text'+
'="Nesnelerin arkaplan�nda kullan�lan f�r�an�n stili"/>  <StrRes Name="propCalcCh'+
'eckSum" Text="Barkod''un kontrol rakam�n� otomatik olarak hesaplayabilesine olana'+
'k sa�lar"/>  <StrRes Name="propCancel" Text="ESC tu�una bas�ld���nda button''un a'+
'ktif olmas�na olanak sa�lar"/>  <StrRes Name="propCaption" Text="Nesnenin ba�l��'+
'�"/>  <StrRes Name="propCellFields" Text="H�creyi temsil eden sahan�n ad�"/>  <S'+
'trRes Name="propCellLevels" Text="H�cre say�s�"/>  <StrRes Name="propCenter" Tex'+
't="Resmin nesneyi ortalamas�na olanak sa�lar"/>  <StrRes Name="propCharset" Text'+
'="Yaz� tipi seti"/>  <StrRes Name="propCharSpacing" Text="�ki karakter aras�ndak'+
'i Pixel say�s�"/>  <StrRes Name="propCheckColor" Text="Onay i�aretinin rengi"/> '+
' <StrRes Name="propChecked" Text="Nesnenin i�aretli oldu�unu belirtir"/>  <StrRe'+
's Name="propCheckStyle" Text="Onay i�aretinin stili"/>  <StrRes Name="propChild"'+
' Text="�ocuk band bu banda ba�land�"/>  <StrRes Name="propClipped" Text="Nesne e'+
'traf�ndaki text kesilebilir."/>  <StrRes Name="propCollate" Text="Varsay�lan d�z'+
'enleme ayarlar�"/>  <StrRes Name="propColor.TFont" Text="Yaz� rengi"/>  <StrRes '+
'Name="propColor" Text="Nesne rengi"/>  <StrRes Name="propColor.TfrxFrame" Text="'+
'�er�eve rengi"/>  <StrRes Name="propColor.TfrxHighlight" Text="Vurgu rengi aktif'+
' oldu�unda Nesne rengini belirler"/>  <StrRes Name="propColumnFields" Text="Kolo'+
'nlar� temsil eden sahan�n ad�"/>  <StrRes Name="propColumnGap" Text="Band kolonl'+
'ar� aras�ndaki bo�luk"/>  <StrRes Name="propColumnLevels" Text="Kolon seviyeleri'+
'nin say�s�"/>  <StrRes Name="propColumns" Text="Band''�n i�indeki kolonlar�n say�'+
's�"/>  <StrRes Name="propColumnWidth" Text="Band kolonunun geni�li�i"/>  <StrRes'+
' Name="propCondition" Text="Gruplama durumu. E�er bu ifadenin de�eri de�i�irse, '+
'grup iptal olacakt�r"/>  <StrRes Name="propCondition.TfrxHighlight" Text="�fade '+
'metni. E�er bu ifade &#38;#34;True&#38;#34; ise, vurgu aktif olacakt�r"/>  <StrR'+
'es Name="propConnected" Text="Veritaban�n�n a��k olup olmad���n� belirler"/>  <S'+
'trRes Name="propConvertNulls" Text="Veritaban�ndaki bo� sahalar�n 0, &#38;#34;Fa'+
'lse&#38;#34; veya &#38;#60;bo�&#38;#62; ifadelerine d�n��t�rmesine olanak sa�lar'+
'"/>  <StrRes Name="propCopies" Text="Varsay�lan kopya say�s�"/>  <StrRes Name="p'+
'ropCursor" Text="Farenin nesne �st�ndeki �ekli"/>  <StrRes Name="propDatabaseNam'+
'e" Text="Veritaban�n�n ad�"/>  <StrRes Name="propDataField" Text="Nesneye ba�lan'+
'an veritaban� sahas�"/>  <StrRes Name="propDataSet" Text="Nesneye ba�lanan, veri'+
'taban� sahalar�n� i�eren veri tablosu"/>  <StrRes Name="propDate" Text="Nesnenin'+
' tarih de�eri"/>  <StrRes Name="propDateFormat" Text="Tarih format�"/>  <StrRes '+
'Name="propDecimalSeparator" Text="Ondal�k ayrac�"/>  <StrRes Name="propDefault" '+
'Text="ENTER tu�una bas�ld���nda button''un aktif olmas�na olanak sa�lar"/>  <StrR'+
'es Name="propDefHeight" Text="Varsay�lan sat�r y�ksekli�i"/>  <StrRes Name="prop'+
'Description.TfrxReportOptions" Text="Rapor a��klamas�"/>  <StrRes Name="propDesc'+
'ription" Text="Nesne a��klamas�"/>  <StrRes Name="propDiagonal" Text="�izgilerin'+
' �apraz olmas�na olanak sa�lar"/>  <StrRes Name="propDisplayFormat" Text="G�r�ne'+
'n de�erin format�"/>  <StrRes Name="propDoublePass" Text="Rapor motorunun ikinci'+
' ge�i� yap�p yapmamas�n� belirler"/>  <StrRes Name="propDown" Text="Speed Button'+
'''un bas�l� olup olmad���n� belirler"/>  <StrRes Name="propDownThenAcross" Text="'+
'B�y�k tablonun ne �ekilde par�alara ayr�laca��n� belirler"/>  <StrRes Name="prop'+
'DriverName" Text="BDE s�r�c�s�n�n ad�"/>  <StrRes Name="propDropShadow" Text="Ne'+
'snelerin g�lgesinin olup olmad���n� belirler"/>  <StrRes Name="propDuplex" Text='+
'"Sayfan�n �ift y�nl� kullan�lmas�n� sa�lar"/>  <StrRes Name="propEditMask" Text='+
'"Metin nesnesi i�in ge�erli olan format �ekli"/>  <StrRes Name="propEnabled" Tex'+
't="Nesnenin kullan�labilir olup olmad���n� belirler"/>  <StrRes Name="propEngine'+
'Options" Text="Raporun motor se�enekleri"/>  <StrRes Name="propExpression" Text='+
'"Nesnede g�sterilecek ifade"/>  <StrRes Name="propExpressionDelimiters" Text="Ne'+
'snenin i�indeki ifadeyi ay�rmak i�in kullanacak ayra�"/>  <StrRes Name="propFiel'+
'dAliases" Text="Sahan�n g�r�nen ad�"/>  <StrRes Name="propFilter" Text="Dataset'''+
'in filitre ko�ulu"/>  <StrRes Name="propFiltered" Text="Dataset''in filitre �zell'+
'i�indeki ko�ul kullan�larak kay�tlar�n filtrelenmesine olanak sa�lar"/>  <StrRes'+
' Name="propFlowTo" Text="S��mayan metnin �zerinde g�sterilece�i nesne"/>  <StrRe'+
's Name="propFont" Text="Nesnenin yaz� tipi �zellikleri"/>  <StrRes Name="propFoo'+
'terAfterEach" Text="Sayfa alt� band�n�n her bir veri sat�r�ndan sonra g�sterilme'+
'sine olanak sa�lar"/>  <StrRes Name="propFormatStr" Text="Yaz� bi�imi"/>  <StrRe'+
's Name="propFrame" Text="Nesnenin �er�eve �zellikleri"/>  <StrRes Name="propGapX'+
'" Text="Metnin soldan b�rak�lacak bo�lu�u"/>  <StrRes Name="propGapY" Text="Metn'+
'in �stten b�rak�lacak bo�lu�u"/>  <StrRes Name="propGlyph" Text="Nesne resmi"/> '+
' <StrRes Name="propGroupIndex" Text="Speed button''lar�n bir grup olarak �al��abi'+
'lmesine olanak sa�lar"/>  <StrRes Name="propHAlign" Text="Metnin yatay hizalamas'+
'�"/>  <StrRes Name="propHeight" Text="Nesnenin y�ksekli�i"/>  <StrRes Name="prop'+
'HideZeros" Text="Metin nesnelerinde SIFIR de�erinin g�sterilip g�sterilmeyece�in'+
'i belirler"/>  <StrRes Name="propHighlight" Text="Ko�ula ba�l� vurgu �zellikleri'+
'"/>  <StrRes Name="propIndexName" Text="Indeks ad�"/>  <StrRes Name="propInitStr'+
'ing" Text="Nokta-vuru�lu raporlar i�in yaz�c� ba�lang�� metni"/>  <StrRes Name="'+
'propItems" Text="Nesnenin madde listesi"/>  <StrRes Name="propKeepAspectRatio" T'+
'ext="Resmin orjinal g�r�n�m oran�n� korur"/>  <StrRes Name="propKeepChild" Text='+
'"Band''�n �ocuklar� ile birlikte yazd�r�lmas�na olanak sa�lar"/>  <StrRes Name="p'+
'ropKeepFooter" Text="Band''�n alt ba�l�klar� ile birlikte yazd�r�lmas�na olanak s'+
'a�lar"/>  <StrRes Name="propKeepHeader" Text="Determines whether the band will b'+
'e printed together with its header"/>  <StrRes Name="propKeepTogether" Text="Ban'+
'd''�n t�m altband''larla birlikte yazd�r�lmas�na olanak sa�lar"/>  <StrRes Name="p'+
'ropKind.TfrxFormat" Text="Bi�imlendirme �ekli"/>  <StrRes Name="propKind" Text="'+
'Button �ekli"/>  <StrRes Name="propLargeDesignHeight" Text="Dizayn a�amas�nda sa'+
'yfalar�n b�y�k uzunlukta olmas�na olanak sa�lar"/>  <StrRes Name="propLayout" Te'+
'xt="Button resminin alan�"/>  <StrRes Name="propLeft" Text="Nesnenin sol koordin'+
'at�"/>  <StrRes Name="propLeftMargin" Text="Sayfa sol bo�lu�u"/>  <StrRes Name="'+
'propLines" Text="Nesnenin metni"/>  <StrRes Name="propLineSpacing" Text="�ki sat'+
'�r aras�ndaki pixel say�s�"/>  <StrRes Name="propLoginPrompt" Text="Ba�lanma ekr'+
'an�n�n g�r�n�p g�r�nmemesini sa�lar"/>  <StrRes Name="propMargin" Text="Button k'+
'enar �izgisi ile resim kenar �izgisi aras�ndaki pixel say�s�"/>  <StrRes Name="p'+
'ropMaster" Text="As�l dataset"/>  <StrRes Name="propMasterFields" Text="As�l-Det'+
'ay ili�kisinde ba�lanacak sahalar"/>  <StrRes Name="propMaxLength" Text="Metnin '+
'maksimum uzunlu�u"/>  <StrRes Name="propMaxWidth" Text="Kolonun maksimum geni�li'+
'�i"/>  <StrRes Name="propMemo" Text="Nesnenin metni"/>  <StrRes Name="propMinWid'+
'th" Text="Kolonun minimum geni�li�i"/>  <StrRes Name="propMirrorMargins" Text="�'+
'ift sayfalara ayn� sayfa ayarlar�n� yans�t�r"/>  <StrRes Name="propModalResult" '+
'Text="En �stteki pencere button ile kapat�ld���nda d�nd�r�len de�er"/>  <StrRes '+
'Name="propName.TFont" Text="Yaz� tipinin ad�"/>  <StrRes Name="propName.TfrxRepo'+
'rtOptions" Text="Raporun ad�"/>  <StrRes Name="propName" Text="Nesnenin ad�"/>  '+
'<StrRes Name="propNumGlyphs" Text="Glyph �zelli�indeki kendine ait grafi�in i�in'+
'deki resim say�s�n� belirler"/>  <StrRes Name="propOpenDataSource" Text="Datasou'+
'rce''nin otomatik a��l�p a��lmayaca��n� belirler"/>  <StrRes Name="propOrientatio'+
'n" Text="Sayfa y�nlendirmesi"/>  <StrRes Name="propOutlineText" Text="�nizleme p'+
'enceresinde ana hat i�inde g�sterilecek olan metin"/>  <StrRes Name="propOutline'+
'Visible" Text="�nizleme penceresinin ana hatt�n�n g�r�n�rl���"/>  <StrRes Name="'+
'propOutlineWidth" Text="�nizleme penceresinin ana hatt�n�n geni�li�i"/>  <StrRes'+
' Name="propPageNumbers.TfrxPrintOptions" Text="Yazd�r�lacak sayfa say�s�"/>  <St'+
'rRes Name="propPaperHeight" Text="Sayfa y�ksekli�i"/>  <StrRes Name="propPaperWi'+
'dth" Text="Sayfa geni�li�i"/>  <StrRes Name="propParagraphGap" Text="Paragraf ba'+
'�� girintisi"/>  <StrRes Name="propParams.TfrxBDEDatabase" Text="Ba�lant� parame'+
'treleri"/>  <StrRes Name="propParams" Text="Sorgu parametreleri"/>  <StrRes Name'+
'="propParentFont" Text="Nesnenin, �zerinde bulundu�u nesnenin yaz� tipini kullan'+
'�p kulanmayaca��n� belirler"/>  <StrRes Name="propPassword" Text="Rapor �ifresi"'+
'/>  <StrRes Name="propPasswordChar" Text="�ifre karakteri. Girilen karakterlerin'+
' her birinin bu �ekilde g�sterilmesini sa�lar"/>  <StrRes Name="propPicture" Tex'+
't="Resim"/>  <StrRes Name="propPicture.TfrxReportOptions" Text="Raporun a��klama'+
' resmi"/>  <StrRes Name="propPosition" Text="Pencerenin ba�lang�� pozisyonu"/>  '+
'<StrRes Name="propPreviewOptions" Text="Raporun �nizleme �zellikleri"/>  <StrRes'+
' Name="propPrintable" Text="Nesnenin yaz�labilirli�i. E�er &#38;#34;False&#38;#3'+
'4; olarak i�aretlenmi�se nesneler g�r�nt�lenir ama yazd�r�lmaz"/>  <StrRes Name='+
'"propPrintChildIfInvisible" Text="�zerinde bulundu�u band�n g�r�nmez oldu�u duru'+
'mda, �ocuk band�n yazd�r�lmas�na olanak sa�lar"/>  <StrRes Name="propPrinter" Te'+
'xt="Bu rapor a��ld���nda veya �al��t�r�ld���nda se�ili olacak yaz�c�n�n ad�"/>  '+
'<StrRes Name="propPrintIfDetailEmpty" Text="Altband''� bo� olan band''lar�n yazd�r'+
'�lmas�na olanak sa�lar"/>  <StrRes Name="propPrintIfEmpty" Text="T�m Dataset''ler'+
' bo� olsa bile sayfan�n yazd�r�lmas�n� sa�lar"/>  <StrRes Name="propPrintOnFirst'+
'Page" Text="Band''�n ilk sayfada yazd�r�lmas�n� sa�lar"/>  <StrRes Name="propPrin'+
'tOnLastPage" Text="Band''�n son sayfada yazd�r�lmas�n� sa�lar"/>  <StrRes Name="p'+
'ropPrintOnParent" Text="Altraporun, �zerinde bulundu�u band''da yazd�r�lmas�n� sa'+
'�lar"/>  <StrRes Name="propPrintOnPreviousPage" Text="Sayfan�n, daha �nce olu�tu'+
'rulmu� olan sayfalar�n bo�lu�unda olu�turulmas�n� sa�lar"/>  <StrRes Name="propP'+
'rintOptions" Text="Raporun yazd�rma ayarlar�"/>  <StrRes Name="propPrintPages" T'+
'ext="Tek, �ift veya T�m sayfalar�n yazd�r�lmas�n� sa�lar"/>  <StrRes Name="propR'+
'angeBegin" Text="Dataset''teki gezintinin ba�lad��� nokta"/>  <StrRes Name="propR'+
'angeEnd" Text="Dataset''teki gezintinin bitti�i nokta"/>  <StrRes Name="propRange'+
'EndCount" Text="&#38;#34;RangeEnd&#38;#34;, &#38;#34;reCount&#38;#34; oldu�unda;'+
' Dataset''ten okunacak kay�t say�s�"/>  <StrRes Name="propReadOnly" Text="Metin n'+
'esnesinin Salt-Okunur olup olmamas�n� sa�lar"/>  <StrRes Name="propRepeatHeaders'+
'" Text="Sat�r ve Kolon ba�l�klar�n�n her sayfada tekrar yaz�l�p yaz�lmayaca��n� '+
'belirler"/>  <StrRes Name="propReportOptions" Text="Rapor se�enekleri"/>  <StrRe'+
's Name="propReprintOnNewPage" Text="Band''�n her sayfada tekrar yaz�l�p yaz�lmaya'+
'ca��n� belirler"/>  <StrRes Name="propRestrictions" Text="K�s�tlama ayarlar�"/> '+
' <StrRes Name="propRightMargin" Text="Sayfa sa� bo�lu�u"/>  <StrRes Name="propRo'+
'tation.TfrxBarCodeView" Text="Barkod y�nlendirmesi"/>  <StrRes Name="propRotatio'+
'n" Text="Metin d�nd�rme a��s�"/>  <StrRes Name="propRowCount" Text="Band''daki ge'+
'r�ek kay�t say�s�"/>  <StrRes Name="propRowFields" Text="Sat�r� temsil eden saha'+
'n�n ad�"/>  <StrRes Name="propRowLevels" Text="Sat�r seviyelerinin say�s�"/>  <S'+
'trRes Name="propRTLReading" Text="Metin nesnelerinin yaz�lar�n�n sa�dan sola do�'+
'ru g�r�nt�lenmesini sa�lar"/>  <StrRes Name="propSessionName" Text="BDE oturum a'+
'd�"/>  <StrRes Name="propShadowColor" Text="G�lge rengi"/>  <StrRes Name="propSh'+
'adowWidth" Text="G�lge geni�li�i"/>  <StrRes Name="propShape" Text="�ekil nesnes'+
'inin bi�imi"/>  <StrRes Name="propShiftMode" Text="Nesnenin kayd�rma durumu"/>  '+
'<StrRes Name="propShowColumnHeader" Text="Kolon ba�l�klar�n�n g�r�nt�lenip g�r�n'+
't�lenmemesini sa�lar"/>  <StrRes Name="propShowColumnTotal" Text="Kolon genel to'+
'plam�n�n g�r�nt�lenip g�r�nt�lenmemesini sa�lar"/>  <StrRes Name="propShowRowHea'+
'der" Text="Sat�r ba�l�klar�n�n g�r�nt�lenip g�r�nt�lenmemesini sa�lar"/>  <StrRe'+
's Name="propShowRowTotal" Text="Sat�r genel toplam�n�n g�r�nt�lenip g�r�nt�lenme'+
'mesini sa�lar"/>  <StrRes Name="propShowDialog" Text="�nizleme penceresinde yazd'+
'�rma penceresinin g�r�nt�lenip g�r�nt�lenmemesini sa�lar"/>  <StrRes Name="propS'+
'howText" Text="Barkod nesnelerindeki okunabilir yaz�n�n g�r�nt�lenip g�r�nt�lenm'+
'emesini sa�lar"/>  <StrRes Name="propSize" Text="Yaz� tipi boyu"/>  <StrRes Name'+
'="propSorted" Text="Maddelerin s�ralan�p s�ralanmamas�n� sa�lar"/>  <StrRes Name'+
'="propSpacing" Text="Metin ile resim aras�ndaki pixel say�s�"/>  <StrRes Name="p'+
'ropSQL" Text="SQL c�mleci�i"/>  <StrRes Name="propStartNewPage" Text="Band''� yaz'+
'd�rmadan �nce yeni sayfaya ba�lar"/>  <StrRes Name="propStretch" Text="Resmi, ne'+
'snenin boyutlar�na uzat�r"/>  <StrRes Name="propStretched" Text="Nesnenin uzat�l'+
'abilmesine olanak sa�lar"/>  <StrRes Name="propStretchMode" Text="Nesnenin uzat�'+
'labilirlili�i"/>  <StrRes Name="propStyle.TFont" Text="Yaz� tipi bi�imi"/>  <Str'+
'Res Name="propStyle" Text="Nesne bi�imi"/>  <StrRes Name="propStyle.TfrxFrame" T'+
'ext="Nesnenin �er�eve bi�imi"/>  <StrRes Name="propSuppressRepeated" Text="Tekra'+
'rlanan de�erlerin gizlenmesini sa�lar"/>  <StrRes Name="propTableName" Text="Ver'+
'i tablosunun ad�"/>  <StrRes Name="propTag" Text="Nesnenin Tag''�n�n rakamsal de�'+
'eri"/>  <StrRes Name="propTagStr" Text="Nesnenin Tag''�n�n metin de�eri"/>  <StrR'+
'es Name="propText" Text="Nesnenin metni"/>  <StrRes Name="propTitleBeforeHeader"'+
' Text="Sayfa ba�l���ndan �nce rapor ba�l���n�n g�r�nt�lenip g�r�nt�lemece�ini be'+
'lirler"/>  <StrRes Name="propTop" Text="Nesnenin �st koordinat�"/>  <StrRes Name'+
'="propTopMargin" Text="Sayfa �st bo�lu�u"/>  <StrRes Name="propTyp" Text="�er�ev'+
'e �ekli"/>  <StrRes Name="propUnderlines" Text="Metin nesnelerinde her bir sat�r'+
'�n alt�n� �izer"/>  <StrRes Name="propURL" Text="Nesnenin kayna��"/>  <StrRes Na'+
'me="propUserName" Text="Veri nesnesinin kullan�c� ad�. Bu isim veri a�ac�nda g�r'+
'�necektir"/>  <StrRes Name="propVAlign" Text="Metnin dikey hizalamas�"/>  <StrRe'+
's Name="propVersionBuild" Text="Versiyon bilgisi, derleme"/>  <StrRes Name="prop'+
'VersionMajor" Text="Versiyon bilgisi, as�l versiyon"/>  <StrRes Name="propVersio'+
'nMinor" Text="Versiyon bilgisi, alt versiyon"/>  <StrRes Name="propVersionReleas'+
'e" Text="Versiyon bilgisi, sunum"/>  <StrRes Name="propVisible" Text="Nesnenin g'+
'�r�nebilirlili�i"/>  <StrRes Name="propWidth" Text="Nesnenin geni�li�i"/>  <StrR'+
'es Name="propWidth.TfrxFrame" Text="�er�evenin geni�li�i"/>  <StrRes Name="propW'+
'indowState" Text="Pencerenin ba�lang�� durumu"/>  <StrRes Name="propWordBreak" T'+
'ext="Rus�a kelimeleri kes"/>  <StrRes Name="propWordWrap" Text="S��mayan kelimel'+
'eri alt sat�ra kayd�r�r"/>  <StrRes Name="propZoom.TfrxBarCodeView" Text="Barkod'+
'u yak�nla�t�r�r"/>  <StrRes Name="propConnectionName" Text="Name of the connecti'+
'on to the database used in the report"/>  <StrRes Name="propCurve" Text="Curvatu'+
're of the roundrectangle edges"/>  <StrRes Name="propDrillDown" Text="Grup a�a��'+
' a��labilir tan�mlay�c�"/>  <StrRes Name="propFontStyle" Text="Dot-matrix font t'+
'ipi"/>  <StrRes Name="propHideIfSingleDataRecord" Text="Grup tek bir kay�ta sahi'+
'p oldu�unda altbilgi gizle"/>  <StrRes Name="propOutlineExpand" Text="Rapor �er�'+
'evesini geni�letmek i�in tan�mlay�c�"/>  <StrRes Name="propPlainCells" Text="Yan'+
'yana veya �st�ste birka� h�cre yaz"/>  <StrRes Name="propPrintMode" Text="Baskm�'+
' modu: normal, B�y�k sayfalar� tek bir sayfaya, yada bir ka� k���k sayfay� tek s'+
'ayfaya"/>  <StrRes Name="propPrintOnSheet" Text="Rapor yazd�rmak i�in ka��t boyu'+
'. E�er PrintMode &#38;#34;pmDefault&#38;#34; de�ilse kullan�l�r."/>  <StrRes Nam'+
'e="propResetPageNumbers" Text="Grup yazd�r�rken sayfa no/toplam sayfa say�s� s�f'+
'�rla. StartNewPage se�ene�i true iken kullan�lmal�d�r."/>  <StrRes Name="propRev'+
'erse" Text="Sayfalar� Tersten yazd�r"/>  <StrRes Name="propShowFooterIfDrillDown'+
'" Text="E�er grup a��ksa altbilgi g�r�nt�le"/>  <StrRes Name="propSizeMode" Text'+
'="OLE nesnesi g�r�nt� �ekli"/>  <StrRes Name="propVersion" Text="Fast report ver'+
'siyonu"/>  <StrRes Name="propWideBarRatio" Text="Barkodun ger�ek geni�li�i"/>  <'+
'StrRes Name="propWysiwyg" Text="Zengin (Rich) nesneler yaz�c�da yazd�rmak i�in k'+
'ullan�labilir, bunun i�in bir yaz�c� kurulu olmal�.(nas�l g�r�yorsan �yle bas)"/'+
'>  <StrRes Name="propArrowEnd" Text="Bir �izginin sonuna ok tan�mla"/>  <StrRes '+
'Name="propArrowLength" Text="Ok uzunlu�u"/>  <StrRes Name="propArrowSolid" Text='+
'"Oku tam doldur (solid)"/>  <StrRes Name="propArrowStart" Text="Bir �izginin ba�'+
'�na ok tan�mla"/>  <StrRes Name="propArrowWidth" Text="Ok kal�nl���"/>  <StrRes '+
'Name="propCloseDataSource" Text="Rapor bitti�inde verikayna��n�(dataset,tablo vs'+
'.) kapat."/>  <StrRes Name="propDatabase" Text="Veri taban� ba�lant�s�"/>  <StrR'+
'es Name="propIndexFieldNames" Text="�ndeks sahalar� isimleri"/>  <StrRes Name="p'+
'ropCommandTimeOut" Text="Bir sorguyu �al��t�rmak i�in gereken zaman miktar�"/>  '+
'<StrRes Name="propExpandDrillDown" Text="�lk sayfada t�m a��labilir nesneleri a�'+
'"/>  <StrRes Name="propWysiwyg.TfrxMemoView" Text="Metin WYSIWYG (g�r�nd��� �eki'+
'lde) modun"/>  <StrRes Name="propLeftLine" Text="�er�evenin sol �izgisi"/>  <Str'+
'Res Name="propTopLine" Text="�er�evenin �st �izgisi"/>  <StrRes Name="propRightL'+
'ine" Text="�er�evenin sa� �izgisi"/>  <StrRes Name="propBottomLine" Text="�er�ev'+
'enin alt �izgisi"/>  <StrRes Name="propColor.TfrxFrameLine" Text="�er�evenin �iz'+
'gi rengi"/>  <StrRes Name="propStyle.TfrxFrameLine" Text="�er�evenin �izgi stili'+
'"/>  <StrRes Name="propWidth.TfrxFrameLine" Text="�er�evenin �izgi kal�nl���"/> '+
' <StrRes Name="propFileLink" Text="Bir resim i�eren dosya ismi yada ifade"/>  <S'+
'trRes Name="propEndlessWidth" Text="Sonsuz sayfa geni�li�i. E�er true ise sayfa '+
'gerekti�i kadar geni�letilecek."/>  <StrRes Name="propEndlessHeight" Text="Sonsu'+
'z sayfa uzunlu�u. E�er true ise sayfa gerekti�i kadar uzat�lacak."/>  <StrRes Na'+
'me="propAddHeight" Text="H�cre y�ksekli�i kadar ekle"/>  <StrRes Name="propAddWi'+
'dth" Text="H�cre geni�li�i kadar ekle"/>  <StrRes Name="propAllowDuplicates" Tex'+
't="H�crenin string de�erleri �ift almas�na izin ver"/>  <StrRes Name="propJoinEq'+
'ualCells" Text="E�it de�er ile �apraz tablo birle�ebilir"/>  <StrRes Name="propN'+
'extCross" Text="Sonraki �apraz tablo yanyana g�r�nt�lenecek"/>  <StrRes Name="pr'+
'opNextCrossGap" Text="Yanyana �apraz tablo aral���"/>  <StrRes Name="propShowCor'+
'ner" Text="�apraz tablo sol�st eleman� g�r�nt�lensin"/>  <StrRes Name="propSuppr'+
'essNullRecords" Text="�apraz tablodaki t�m kay�tlar� NULL de�erler ile g�r�nt�le'+
'"/>  <StrRes Name="propShowTitle" Text="�apraz tablo ba�l��� g�r�nt�le"/>  <StrR'+
'es Name="propAutoSize" Text="�apraz tablo otomatik boyutland�r"/>  <StrRes Name='+
'"propShowHint" Text="Determines if object should show hint when move cursor on i'+
't"/>  <StrRes Name="propHint" Text="Hint text"/>  <StrRes Name="propPaperSize" T'+
'ext="PaperSize"/>  <StrRes Name="propPageCount" Text="Count of pages"/>  <StrRes'+
' Name="propBackPictureVisible" Text="Determines if the page should display a bac'+
'kground picture"/>  <StrRes Name="propBackPicturePrintable" Text="Determines if '+
'the page should print a background picture"/>  <StrRes Name="propHightQuality" T'+
'ext="Show picture in high quality"/>  <StrRes Name="propLockType" Text="Specifie'+
's the lock type to use when opening a dataset"/>  <StrRes Name="propIgnoreDupPar'+
'ams" Text="Ignore duplicate parameters in ParamEditor"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
