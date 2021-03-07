unit frxrcInsp;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1254">  <StrRes Name='+
'"propActive" Text="Dataset''in açýk olup olmadýðýný belirler"/>  <StrRes Name="pr'+
'opActive.TfrxHighlight" Text="Yüksek karþýtlýk açýk"/>  <StrRes Name="propAliasN'+
'ame" Text="BDE''nin görünen adý"/>  <StrRes Name="propAlign" Text="Bir band veya '+
'sayfaya baðlý nesnelerin düzenini belirler"/>  <StrRes Name="propAlignment" Text'+
'="Nesnenin metninin hizasý"/>  <StrRes Name="propAllowAllUp" Text="Grup içindeki'+
' tüm Speed Button''larýnýn ayný anda seçilmesine olanak saðlar"/>  <StrRes Name="'+
'propAllowEdit" Text="Kullanýcýnýn hazýrlanmýþ rapor sayfalarýný düzenlemesine ol'+
'anak saðlar"/>  <StrRes Name="propAllowExpressions" Text="Metin nesnelerinin anl'+
'atým ifadeleri içermelerine olanak saðlar"/>  <StrRes Name="propAllowGrayed" Tex'+
't="CheckBox''larýn durumunun gri olmasýna izin verir"/>  <StrRes Name="propAllowH'+
'TMLTags" Text="Metin nesnelerinin HTML kodu içermelerine olanak saðlar"/>  <StrR'+
'es Name="propAllowSplit" Text="Bir sayfaya sýðmayan, bir sayfadan daha uzun meti'+
'nlerin, bölünerek birden fazla sayfada gösterilmesine olanak saðlar"/>  <StrRes '+
'Name="propAuthor" Text="Raporun yazarý"/>  <StrRes Name="propAutoSize.TfrxPictur'+
'eView" Text="Resimlerin otomatik ölçülendirilmesine olanak saðlar"/>  <StrRes Na'+
'me="propAutoWidth" Text="Metin nesnelerinin geniþliklerinin otomatik ölçülendiri'+
'lmesine olanak saðlar"/>  <StrRes Name="propBackPicture" Text="Sayfa arkaplan re'+
'smi"/>  <StrRes Name="propBarType" Text="Barkod tipi"/>  <StrRes Name="propBevel'+
'Inner" Text="Bevel''in iç tipi"/>  <StrRes Name="propBevelOuter" Text="Bevel''in d'+
'ýþ tipi"/>  <StrRes Name="propBevelWidth" Text="Bevel''in geniþliði"/>  <StrRes N'+
'ame="propBorder" Text="Dýþ çerçeve çizgilerinin görünmesine olanak saðlar"/>  <S'+
'trRes Name="propBorderStyle" Text="Pencerenin stili"/>  <StrRes Name="propBottom'+
'Margin" Text="Sayfa alt boþluðunun ölçüsü"/>  <StrRes Name="propBrushStyle" Text'+
'="Nesnelerin arkaplanýnda kullanýlan fýrçanýn stili"/>  <StrRes Name="propCalcCh'+
'eckSum" Text="Barkod''un kontrol rakamýný otomatik olarak hesaplayabilesine olana'+
'k saðlar"/>  <StrRes Name="propCancel" Text="ESC tuþuna basýldýðýnda button''un a'+
'ktif olmasýna olanak saðlar"/>  <StrRes Name="propCaption" Text="Nesnenin baþlýð'+
'ý"/>  <StrRes Name="propCellFields" Text="Hücreyi temsil eden sahanýn adý"/>  <S'+
'trRes Name="propCellLevels" Text="Hücre sayýsý"/>  <StrRes Name="propCenter" Tex'+
't="Resmin nesneyi ortalamasýna olanak saðlar"/>  <StrRes Name="propCharset" Text'+
'="Yazý tipi seti"/>  <StrRes Name="propCharSpacing" Text="Ýki karakter arasýndak'+
'i Pixel sayýsý"/>  <StrRes Name="propCheckColor" Text="Onay iþaretinin rengi"/> '+
' <StrRes Name="propChecked" Text="Nesnenin iþaretli olduðunu belirtir"/>  <StrRe'+
's Name="propCheckStyle" Text="Onay iþaretinin stili"/>  <StrRes Name="propChild"'+
' Text="Çocuk band bu banda baðlandý"/>  <StrRes Name="propClipped" Text="Nesne e'+
'trafýndaki text kesilebilir."/>  <StrRes Name="propCollate" Text="Varsayýlan düz'+
'enleme ayarlarý"/>  <StrRes Name="propColor.TFont" Text="Yazý rengi"/>  <StrRes '+
'Name="propColor" Text="Nesne rengi"/>  <StrRes Name="propColor.TfrxFrame" Text="'+
'Çerçeve rengi"/>  <StrRes Name="propColor.TfrxHighlight" Text="Vurgu rengi aktif'+
' olduðunda Nesne rengini belirler"/>  <StrRes Name="propColumnFields" Text="Kolo'+
'nlarý temsil eden sahanýn adý"/>  <StrRes Name="propColumnGap" Text="Band kolonl'+
'arý arasýndaki boþluk"/>  <StrRes Name="propColumnLevels" Text="Kolon seviyeleri'+
'nin sayýsý"/>  <StrRes Name="propColumns" Text="Band''ýn içindeki kolonlarýn sayý'+
'sý"/>  <StrRes Name="propColumnWidth" Text="Band kolonunun geniþliði"/>  <StrRes'+
' Name="propCondition" Text="Gruplama durumu. Eðer bu ifadenin deðeri deðiþirse, '+
'grup iptal olacaktýr"/>  <StrRes Name="propCondition.TfrxHighlight" Text="Ýfade '+
'metni. Eðer bu ifade &#38;#34;True&#38;#34; ise, vurgu aktif olacaktýr"/>  <StrR'+
'es Name="propConnected" Text="Veritabanýnýn açýk olup olmadýðýný belirler"/>  <S'+
'trRes Name="propConvertNulls" Text="Veritabanýndaki boþ sahalarýn 0, &#38;#34;Fa'+
'lse&#38;#34; veya &#38;#60;boþ&#38;#62; ifadelerine dönüþtürmesine olanak saðlar'+
'"/>  <StrRes Name="propCopies" Text="Varsayýlan kopya sayýsý"/>  <StrRes Name="p'+
'ropCursor" Text="Farenin nesne üstündeki þekli"/>  <StrRes Name="propDatabaseNam'+
'e" Text="Veritabanýnýn adý"/>  <StrRes Name="propDataField" Text="Nesneye baðlan'+
'an veritabaný sahasý"/>  <StrRes Name="propDataSet" Text="Nesneye baðlanan, veri'+
'tabaný sahalarýný içeren veri tablosu"/>  <StrRes Name="propDate" Text="Nesnenin'+
' tarih deðeri"/>  <StrRes Name="propDateFormat" Text="Tarih formatý"/>  <StrRes '+
'Name="propDecimalSeparator" Text="Ondalýk ayracý"/>  <StrRes Name="propDefault" '+
'Text="ENTER tuþuna basýldýðýnda button''un aktif olmasýna olanak saðlar"/>  <StrR'+
'es Name="propDefHeight" Text="Varsayýlan satýr yüksekliði"/>  <StrRes Name="prop'+
'Description.TfrxReportOptions" Text="Rapor açýklamasý"/>  <StrRes Name="propDesc'+
'ription" Text="Nesne açýklamasý"/>  <StrRes Name="propDiagonal" Text="Çizgilerin'+
' çapraz olmasýna olanak saðlar"/>  <StrRes Name="propDisplayFormat" Text="Görüne'+
'n deðerin formatý"/>  <StrRes Name="propDoublePass" Text="Rapor motorunun ikinci'+
' geçiþ yapýp yapmamasýný belirler"/>  <StrRes Name="propDown" Text="Speed Button'+
'''un basýlý olup olmadýðýný belirler"/>  <StrRes Name="propDownThenAcross" Text="'+
'Büyük tablonun ne þekilde parçalara ayrýlacaðýný belirler"/>  <StrRes Name="prop'+
'DriverName" Text="BDE sürücüsünün adý"/>  <StrRes Name="propDropShadow" Text="Ne'+
'snelerin gölgesinin olup olmadýðýný belirler"/>  <StrRes Name="propDuplex" Text='+
'"Sayfanýn çift yönlü kullanýlmasýný saðlar"/>  <StrRes Name="propEditMask" Text='+
'"Metin nesnesi için geçerli olan format þekli"/>  <StrRes Name="propEnabled" Tex'+
't="Nesnenin kullanýlabilir olup olmadýðýný belirler"/>  <StrRes Name="propEngine'+
'Options" Text="Raporun motor seçenekleri"/>  <StrRes Name="propExpression" Text='+
'"Nesnede gösterilecek ifade"/>  <StrRes Name="propExpressionDelimiters" Text="Ne'+
'snenin içindeki ifadeyi ayýrmak için kullanacak ayraç"/>  <StrRes Name="propFiel'+
'dAliases" Text="Sahanýn görünen adý"/>  <StrRes Name="propFilter" Text="Dataset'''+
'in filitre koþulu"/>  <StrRes Name="propFiltered" Text="Dataset''in filitre özell'+
'iðindeki koþul kullanýlarak kayýtlarýn filtrelenmesine olanak saðlar"/>  <StrRes'+
' Name="propFlowTo" Text="Sýðmayan metnin üzerinde gösterileceði nesne"/>  <StrRe'+
's Name="propFont" Text="Nesnenin yazý tipi özellikleri"/>  <StrRes Name="propFoo'+
'terAfterEach" Text="Sayfa altý bandýnýn her bir veri satýrýndan sonra gösterilme'+
'sine olanak saðlar"/>  <StrRes Name="propFormatStr" Text="Yazý biçimi"/>  <StrRe'+
's Name="propFrame" Text="Nesnenin çerçeve özellikleri"/>  <StrRes Name="propGapX'+
'" Text="Metnin soldan býrakýlacak boþluðu"/>  <StrRes Name="propGapY" Text="Metn'+
'in üstten býrakýlacak boþluðu"/>  <StrRes Name="propGlyph" Text="Nesne resmi"/> '+
' <StrRes Name="propGroupIndex" Text="Speed button''larýn bir grup olarak çalýþabi'+
'lmesine olanak saðlar"/>  <StrRes Name="propHAlign" Text="Metnin yatay hizalamas'+
'ý"/>  <StrRes Name="propHeight" Text="Nesnenin yüksekliði"/>  <StrRes Name="prop'+
'HideZeros" Text="Metin nesnelerinde SIFIR deðerinin gösterilip gösterilmeyeceðin'+
'i belirler"/>  <StrRes Name="propHighlight" Text="Koþula baðlý vurgu özellikleri'+
'"/>  <StrRes Name="propIndexName" Text="Indeks adý"/>  <StrRes Name="propInitStr'+
'ing" Text="Nokta-vuruþlu raporlar için yazýcý baþlangýç metni"/>  <StrRes Name="'+
'propItems" Text="Nesnenin madde listesi"/>  <StrRes Name="propKeepAspectRatio" T'+
'ext="Resmin orjinal görünüm oranýný korur"/>  <StrRes Name="propKeepChild" Text='+
'"Band''ýn çocuklarý ile birlikte yazdýrýlmasýna olanak saðlar"/>  <StrRes Name="p'+
'ropKeepFooter" Text="Band''ýn alt baþlýklarý ile birlikte yazdýrýlmasýna olanak s'+
'aðlar"/>  <StrRes Name="propKeepHeader" Text="Determines whether the band will b'+
'e printed together with its header"/>  <StrRes Name="propKeepTogether" Text="Ban'+
'd''ýn tüm altband''larla birlikte yazdýrýlmasýna olanak saðlar"/>  <StrRes Name="p'+
'ropKind.TfrxFormat" Text="Biçimlendirme þekli"/>  <StrRes Name="propKind" Text="'+
'Button þekli"/>  <StrRes Name="propLargeDesignHeight" Text="Dizayn aþamasýnda sa'+
'yfalarýn büyük uzunlukta olmasýna olanak saðlar"/>  <StrRes Name="propLayout" Te'+
'xt="Button resminin alaný"/>  <StrRes Name="propLeft" Text="Nesnenin sol koordin'+
'atý"/>  <StrRes Name="propLeftMargin" Text="Sayfa sol boþluðu"/>  <StrRes Name="'+
'propLines" Text="Nesnenin metni"/>  <StrRes Name="propLineSpacing" Text="Ýki sat'+
'ýr arasýndaki pixel sayýsý"/>  <StrRes Name="propLoginPrompt" Text="Baðlanma ekr'+
'anýnýn görünüp görünmemesini saðlar"/>  <StrRes Name="propMargin" Text="Button k'+
'enar çizgisi ile resim kenar çizgisi arasýndaki pixel sayýsý"/>  <StrRes Name="p'+
'ropMaster" Text="Asýl dataset"/>  <StrRes Name="propMasterFields" Text="Asýl-Det'+
'ay iliþkisinde baðlanacak sahalar"/>  <StrRes Name="propMaxLength" Text="Metnin '+
'maksimum uzunluðu"/>  <StrRes Name="propMaxWidth" Text="Kolonun maksimum geniþli'+
'ði"/>  <StrRes Name="propMemo" Text="Nesnenin metni"/>  <StrRes Name="propMinWid'+
'th" Text="Kolonun minimum geniþliði"/>  <StrRes Name="propMirrorMargins" Text="Ç'+
'ift sayfalara ayný sayfa ayarlarýný yansýtýr"/>  <StrRes Name="propModalResult" '+
'Text="En üstteki pencere button ile kapatýldýðýnda döndürülen deðer"/>  <StrRes '+
'Name="propName.TFont" Text="Yazý tipinin adý"/>  <StrRes Name="propName.TfrxRepo'+
'rtOptions" Text="Raporun adý"/>  <StrRes Name="propName" Text="Nesnenin adý"/>  '+
'<StrRes Name="propNumGlyphs" Text="Glyph özelliðindeki kendine ait grafiðin için'+
'deki resim sayýsýný belirler"/>  <StrRes Name="propOpenDataSource" Text="Datasou'+
'rce''nin otomatik açýlýp açýlmayacaðýný belirler"/>  <StrRes Name="propOrientatio'+
'n" Text="Sayfa yönlendirmesi"/>  <StrRes Name="propOutlineText" Text="Önizleme p'+
'enceresinde ana hat içinde gösterilecek olan metin"/>  <StrRes Name="propOutline'+
'Visible" Text="Önizleme penceresinin ana hattýnýn görünürlüðü"/>  <StrRes Name="'+
'propOutlineWidth" Text="Önizleme penceresinin ana hattýnýn geniþliði"/>  <StrRes'+
' Name="propPageNumbers.TfrxPrintOptions" Text="Yazdýrýlacak sayfa sayýsý"/>  <St'+
'rRes Name="propPaperHeight" Text="Sayfa yüksekliði"/>  <StrRes Name="propPaperWi'+
'dth" Text="Sayfa geniþliði"/>  <StrRes Name="propParagraphGap" Text="Paragraf ba'+
'þý girintisi"/>  <StrRes Name="propParams.TfrxBDEDatabase" Text="Baðlantý parame'+
'treleri"/>  <StrRes Name="propParams" Text="Sorgu parametreleri"/>  <StrRes Name'+
'="propParentFont" Text="Nesnenin, üzerinde bulunduðu nesnenin yazý tipini kullan'+
'ýp kulanmayacaðýný belirler"/>  <StrRes Name="propPassword" Text="Rapor þifresi"'+
'/>  <StrRes Name="propPasswordChar" Text="Þifre karakteri. Girilen karakterlerin'+
' her birinin bu þekilde gösterilmesini saðlar"/>  <StrRes Name="propPicture" Tex'+
't="Resim"/>  <StrRes Name="propPicture.TfrxReportOptions" Text="Raporun açýklama'+
' resmi"/>  <StrRes Name="propPosition" Text="Pencerenin baþlangýç pozisyonu"/>  '+
'<StrRes Name="propPreviewOptions" Text="Raporun önizleme özellikleri"/>  <StrRes'+
' Name="propPrintable" Text="Nesnenin yazýlabilirliði. Eðer &#38;#34;False&#38;#3'+
'4; olarak iþaretlenmiþse nesneler görüntülenir ama yazdýrýlmaz"/>  <StrRes Name='+
'"propPrintChildIfInvisible" Text="Üzerinde bulunduðu bandýn görünmez olduðu duru'+
'mda, çocuk bandýn yazdýrýlmasýna olanak saðlar"/>  <StrRes Name="propPrinter" Te'+
'xt="Bu rapor açýldýðýnda veya çalýþtýrýldýðýnda seçili olacak yazýcýnýn adý"/>  '+
'<StrRes Name="propPrintIfDetailEmpty" Text="Altband''ý boþ olan band''larýn yazdýr'+
'ýlmasýna olanak saðlar"/>  <StrRes Name="propPrintIfEmpty" Text="Tüm Dataset''ler'+
' boþ olsa bile sayfanýn yazdýrýlmasýný saðlar"/>  <StrRes Name="propPrintOnFirst'+
'Page" Text="Band''ýn ilk sayfada yazdýrýlmasýný saðlar"/>  <StrRes Name="propPrin'+
'tOnLastPage" Text="Band''ýn son sayfada yazdýrýlmasýný saðlar"/>  <StrRes Name="p'+
'ropPrintOnParent" Text="Altraporun, üzerinde bulunduðu band''da yazdýrýlmasýný sa'+
'ðlar"/>  <StrRes Name="propPrintOnPreviousPage" Text="Sayfanýn, daha önce oluþtu'+
'rulmuþ olan sayfalarýn boþluðunda oluþturulmasýný saðlar"/>  <StrRes Name="propP'+
'rintOptions" Text="Raporun yazdýrma ayarlarý"/>  <StrRes Name="propPrintPages" T'+
'ext="Tek, Çift veya Tüm sayfalarýn yazdýrýlmasýný saðlar"/>  <StrRes Name="propR'+
'angeBegin" Text="Dataset''teki gezintinin baþladýðý nokta"/>  <StrRes Name="propR'+
'angeEnd" Text="Dataset''teki gezintinin bittiði nokta"/>  <StrRes Name="propRange'+
'EndCount" Text="&#38;#34;RangeEnd&#38;#34;, &#38;#34;reCount&#38;#34; olduðunda;'+
' Dataset''ten okunacak kayýt sayýsý"/>  <StrRes Name="propReadOnly" Text="Metin n'+
'esnesinin Salt-Okunur olup olmamasýný saðlar"/>  <StrRes Name="propRepeatHeaders'+
'" Text="Satýr ve Kolon baþlýklarýnýn her sayfada tekrar yazýlýp yazýlmayacaðýný '+
'belirler"/>  <StrRes Name="propReportOptions" Text="Rapor seçenekleri"/>  <StrRe'+
's Name="propReprintOnNewPage" Text="Band''ýn her sayfada tekrar yazýlýp yazýlmaya'+
'caðýný belirler"/>  <StrRes Name="propRestrictions" Text="Kýsýtlama ayarlarý"/> '+
' <StrRes Name="propRightMargin" Text="Sayfa sað boþluðu"/>  <StrRes Name="propRo'+
'tation.TfrxBarCodeView" Text="Barkod yönlendirmesi"/>  <StrRes Name="propRotatio'+
'n" Text="Metin döndürme açýsý"/>  <StrRes Name="propRowCount" Text="Band''daki ge'+
'rçek kayýt sayýsý"/>  <StrRes Name="propRowFields" Text="Satýrý temsil eden saha'+
'nýn adý"/>  <StrRes Name="propRowLevels" Text="Satýr seviyelerinin sayýsý"/>  <S'+
'trRes Name="propRTLReading" Text="Metin nesnelerinin yazýlarýnýn saðdan sola doð'+
'ru görüntülenmesini saðlar"/>  <StrRes Name="propSessionName" Text="BDE oturum a'+
'dý"/>  <StrRes Name="propShadowColor" Text="Gölge rengi"/>  <StrRes Name="propSh'+
'adowWidth" Text="Gölge geniþliði"/>  <StrRes Name="propShape" Text="Þekil nesnes'+
'inin biçimi"/>  <StrRes Name="propShiftMode" Text="Nesnenin kaydýrma durumu"/>  '+
'<StrRes Name="propShowColumnHeader" Text="Kolon baþlýklarýnýn görüntülenip görün'+
'tülenmemesini saðlar"/>  <StrRes Name="propShowColumnTotal" Text="Kolon genel to'+
'plamýnýn görüntülenip görüntülenmemesini saðlar"/>  <StrRes Name="propShowRowHea'+
'der" Text="Satýr baþlýklarýnýn görüntülenip görüntülenmemesini saðlar"/>  <StrRe'+
's Name="propShowRowTotal" Text="Satýr genel toplamýnýn görüntülenip görüntülenme'+
'mesini saðlar"/>  <StrRes Name="propShowDialog" Text="Önizleme penceresinde yazd'+
'ýrma penceresinin görüntülenip görüntülenmemesini saðlar"/>  <StrRes Name="propS'+
'howText" Text="Barkod nesnelerindeki okunabilir yazýnýn görüntülenip görüntülenm'+
'emesini saðlar"/>  <StrRes Name="propSize" Text="Yazý tipi boyu"/>  <StrRes Name'+
'="propSorted" Text="Maddelerin sýralanýp sýralanmamasýný saðlar"/>  <StrRes Name'+
'="propSpacing" Text="Metin ile resim arasýndaki pixel sayýsý"/>  <StrRes Name="p'+
'ropSQL" Text="SQL cümleciði"/>  <StrRes Name="propStartNewPage" Text="Band''ý yaz'+
'dýrmadan önce yeni sayfaya baþlar"/>  <StrRes Name="propStretch" Text="Resmi, ne'+
'snenin boyutlarýna uzatýr"/>  <StrRes Name="propStretched" Text="Nesnenin uzatýl'+
'abilmesine olanak saðlar"/>  <StrRes Name="propStretchMode" Text="Nesnenin uzatý'+
'labilirliliði"/>  <StrRes Name="propStyle.TFont" Text="Yazý tipi biçimi"/>  <Str'+
'Res Name="propStyle" Text="Nesne biçimi"/>  <StrRes Name="propStyle.TfrxFrame" T'+
'ext="Nesnenin çerçeve biçimi"/>  <StrRes Name="propSuppressRepeated" Text="Tekra'+
'rlanan deðerlerin gizlenmesini saðlar"/>  <StrRes Name="propTableName" Text="Ver'+
'i tablosunun adý"/>  <StrRes Name="propTag" Text="Nesnenin Tag''ýnýn rakamsal deð'+
'eri"/>  <StrRes Name="propTagStr" Text="Nesnenin Tag''ýnýn metin deðeri"/>  <StrR'+
'es Name="propText" Text="Nesnenin metni"/>  <StrRes Name="propTitleBeforeHeader"'+
' Text="Sayfa baþlýðýndan önce rapor baþlýðýnýn görüntülenip görüntülemeceðini be'+
'lirler"/>  <StrRes Name="propTop" Text="Nesnenin üst koordinatý"/>  <StrRes Name'+
'="propTopMargin" Text="Sayfa üst boþluðu"/>  <StrRes Name="propTyp" Text="Çerçev'+
'e þekli"/>  <StrRes Name="propUnderlines" Text="Metin nesnelerinde her bir satýr'+
'ýn altýný çizer"/>  <StrRes Name="propURL" Text="Nesnenin kaynaðý"/>  <StrRes Na'+
'me="propUserName" Text="Veri nesnesinin kullanýcý adý. Bu isim veri aðacýnda gör'+
'ünecektir"/>  <StrRes Name="propVAlign" Text="Metnin dikey hizalamasý"/>  <StrRe'+
's Name="propVersionBuild" Text="Versiyon bilgisi, derleme"/>  <StrRes Name="prop'+
'VersionMajor" Text="Versiyon bilgisi, asýl versiyon"/>  <StrRes Name="propVersio'+
'nMinor" Text="Versiyon bilgisi, alt versiyon"/>  <StrRes Name="propVersionReleas'+
'e" Text="Versiyon bilgisi, sunum"/>  <StrRes Name="propVisible" Text="Nesnenin g'+
'örünebilirliliði"/>  <StrRes Name="propWidth" Text="Nesnenin geniþliði"/>  <StrR'+
'es Name="propWidth.TfrxFrame" Text="Çerçevenin geniþliði"/>  <StrRes Name="propW'+
'indowState" Text="Pencerenin baþlangýç durumu"/>  <StrRes Name="propWordBreak" T'+
'ext="Rusça kelimeleri kes"/>  <StrRes Name="propWordWrap" Text="Sýðmayan kelimel'+
'eri alt satýra kaydýrýr"/>  <StrRes Name="propZoom.TfrxBarCodeView" Text="Barkod'+
'u yakýnlaþtýrýr"/>  <StrRes Name="propConnectionName" Text="Name of the connecti'+
'on to the database used in the report"/>  <StrRes Name="propCurve" Text="Curvatu'+
're of the roundrectangle edges"/>  <StrRes Name="propDrillDown" Text="Grup aþaðý'+
' açýlabilir tanýmlayýcý"/>  <StrRes Name="propFontStyle" Text="Dot-matrix font t'+
'ipi"/>  <StrRes Name="propHideIfSingleDataRecord" Text="Grup tek bir kayýta sahi'+
'p olduðunda altbilgi gizle"/>  <StrRes Name="propOutlineExpand" Text="Rapor çerç'+
'evesini geniþletmek için tanýmlayýcý"/>  <StrRes Name="propPlainCells" Text="Yan'+
'yana veya üstüste birkaç hücre yaz"/>  <StrRes Name="propPrintMode" Text="Baskmý'+
' modu: normal, Büyük sayfalarý tek bir sayfaya, yada bir kaç küçük sayfayý tek s'+
'ayfaya"/>  <StrRes Name="propPrintOnSheet" Text="Rapor yazdýrmak için kaðýt boyu'+
'. Eðer PrintMode &#38;#34;pmDefault&#38;#34; deðilse kullanýlýr."/>  <StrRes Nam'+
'e="propResetPageNumbers" Text="Grup yazdýrýrken sayfa no/toplam sayfa sayýsý sýf'+
'ýrla. StartNewPage seçeneði true iken kullanýlmalýdýr."/>  <StrRes Name="propRev'+
'erse" Text="Sayfalarý Tersten yazdýr"/>  <StrRes Name="propShowFooterIfDrillDown'+
'" Text="Eðer grup açýksa altbilgi görüntüle"/>  <StrRes Name="propSizeMode" Text'+
'="OLE nesnesi görüntü þekli"/>  <StrRes Name="propVersion" Text="Fast report ver'+
'siyonu"/>  <StrRes Name="propWideBarRatio" Text="Barkodun gerçek geniþliði"/>  <'+
'StrRes Name="propWysiwyg" Text="Zengin (Rich) nesneler yazýcýda yazdýrmak için k'+
'ullanýlabilir, bunun için bir yazýcý kurulu olmalý.(nasýl görüyorsan öyle bas)"/'+
'>  <StrRes Name="propArrowEnd" Text="Bir çizginin sonuna ok tanýmla"/>  <StrRes '+
'Name="propArrowLength" Text="Ok uzunluðu"/>  <StrRes Name="propArrowSolid" Text='+
'"Oku tam doldur (solid)"/>  <StrRes Name="propArrowStart" Text="Bir çizginin baþ'+
'ýna ok tanýmla"/>  <StrRes Name="propArrowWidth" Text="Ok kalýnlýðý"/>  <StrRes '+
'Name="propCloseDataSource" Text="Rapor bittiðinde verikaynaðýný(dataset,tablo vs'+
'.) kapat."/>  <StrRes Name="propDatabase" Text="Veri tabaný baðlantýsý"/>  <StrR'+
'es Name="propIndexFieldNames" Text="Ýndeks sahalarý isimleri"/>  <StrRes Name="p'+
'ropCommandTimeOut" Text="Bir sorguyu çalýþtýrmak için gereken zaman miktarý"/>  '+
'<StrRes Name="propExpandDrillDown" Text="Ýlk sayfada tüm açýlabilir nesneleri aç'+
'"/>  <StrRes Name="propWysiwyg.TfrxMemoView" Text="Metin WYSIWYG (göründüðü þeki'+
'lde) modun"/>  <StrRes Name="propLeftLine" Text="Çerçevenin sol çizgisi"/>  <Str'+
'Res Name="propTopLine" Text="Çerçevenin üst çizgisi"/>  <StrRes Name="propRightL'+
'ine" Text="Çerçevenin sað çizgisi"/>  <StrRes Name="propBottomLine" Text="Çerçev'+
'enin alt çizgisi"/>  <StrRes Name="propColor.TfrxFrameLine" Text="Çerçevenin çiz'+
'gi rengi"/>  <StrRes Name="propStyle.TfrxFrameLine" Text="Çerçevenin çizgi stili'+
'"/>  <StrRes Name="propWidth.TfrxFrameLine" Text="Çerçevenin çizgi kalýnlýðý"/> '+
' <StrRes Name="propFileLink" Text="Bir resim içeren dosya ismi yada ifade"/>  <S'+
'trRes Name="propEndlessWidth" Text="Sonsuz sayfa geniþliði. Eðer true ise sayfa '+
'gerektiði kadar geniþletilecek."/>  <StrRes Name="propEndlessHeight" Text="Sonsu'+
'z sayfa uzunluðu. Eðer true ise sayfa gerektiði kadar uzatýlacak."/>  <StrRes Na'+
'me="propAddHeight" Text="Hücre yüksekliði kadar ekle"/>  <StrRes Name="propAddWi'+
'dth" Text="Hücre geniþliði kadar ekle"/>  <StrRes Name="propAllowDuplicates" Tex'+
't="Hücrenin string deðerleri çift almasýna izin ver"/>  <StrRes Name="propJoinEq'+
'ualCells" Text="Eþit deðer ile çapraz tablo birleþebilir"/>  <StrRes Name="propN'+
'extCross" Text="Sonraki çapraz tablo yanyana görüntülenecek"/>  <StrRes Name="pr'+
'opNextCrossGap" Text="Yanyana çapraz tablo aralýðý"/>  <StrRes Name="propShowCor'+
'ner" Text="Çapraz tablo solüst elemaný görüntülensin"/>  <StrRes Name="propSuppr'+
'essNullRecords" Text="Çapraz tablodaki tüm kayýtlarý NULL deðerler ile görüntüle'+
'"/>  <StrRes Name="propShowTitle" Text="Çapraz tablo baþlýðý görüntüle"/>  <StrR'+
'es Name="propAutoSize" Text="Çapraz tablo otomatik boyutlandýr"/>  <StrRes Name='+
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
