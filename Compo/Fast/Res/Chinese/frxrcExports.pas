unit frxrcExports;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="936">  <StrRes Name="'+
'8000" Text="������ Excel"/>  <StrRes Name="8001" Text="��ʽ"/>  <StrRes Name="8002" T'+
'ext="ͼ��"/>  <StrRes Name="8003" Text="�ϲ���Ԫ��"/>  <StrRes Name="8004" Text="���ٵ���"/'+
'>  <StrRes Name="8005" Text="����������"/>  <StrRes Name="8006" Text="��Ϊ�ı�"/>  <StrRe'+
's Name="8007" Text="����"/>  <StrRes Name="8008" Text="�ڵ������ Excel"/>  <StrRes Na'+
'me="8009" Text="Excel �ļ� (*.xls)|*.xls"/>  <StrRes Name="8010" Text=".xls"/>  <S'+
'trRes Name="8100" Text="������ Excel"/>  <StrRes Name="8101" Text="��ʽ"/>  <StrRes N'+
'ame="8102" Text="����������"/>  <StrRes Name="8103" Text="����"/>  <StrRes Name="8104" '+
'Text="�ڵ������ Excel"/>  <StrRes Name="8105" Text="XML Excel �ļ� (*.xls)|*.xls"/>  '+
'<StrRes Name="8106" Text=".xls"/>  <StrRes Name="8200" Text="������ HTML table"/>  '+
'<StrRes Name="8201" Text="�ڵ������"/>  <StrRes Name="8202" Text="��ʽ"/>  <StrRes Na'+
'me="8203" Text="ͼ��"/>  <StrRes Name="8204" Text="ȫ����һ���ݼ�"/>  <StrRes Name="8205"'+
' Text="�̶����"/>  <StrRes Name="8206" Text="ҳ�浼��"/>  <StrRes Name="8207" Text="��ҳ"'+
'/>  <StrRes Name="8208" Text="Mozilla �����"/>  <StrRes Name="8209" Text="����"/>  <'+
'StrRes Name="8210" Text="HTML �ļ� (*.html)|*.html"/>  <StrRes Name="8211" Text=".'+
'html"/>  <StrRes Name="8300" Text="���������ı� (����ʽ��ӡ��)"/>  <StrRes Name="8301" Text='+
'"Ԥ�� ����/ͣ��"/>  <StrRes Name="8302" Text=" ��������  "/>  <StrRes Name="8303" Text="��ҳ'+
'"/>  <StrRes Name="8304" Text="OEM ҳ��"/>  <StrRes Name="8305" Text="�հ���"/>  <Str'+
'Res Name="8306" Text="ǰ�ÿհ�"/>  <StrRes Name="8307" Text="ҳ��"/>  <StrRes Name="83'+
'08" Text="����ҳ��/�ļ���Χ�����Զ��ŷָ�(����:1,3,5-12)"/>  <StrRes Name="8309" Text=" ���� "/>  <'+
'StrRes Name="8310" Text="X ����"/>  <StrRes Name="8311" Text="Y ����"/>  <StrRes Nam'+
'e="8312" Text=" ��� "/>  <StrRes Name="8313" Text="��"/>  <StrRes Name="8314" Text'+
'="��"/>  <StrRes Name="8315" Text="ͼ��"/>  <StrRes Name="8316" Text="����OEM����ҳ"/> '+
' <StrRes Name="8317" Text="�ڵ������"/>  <StrRes Name="8318" Text="��������"/>  <StrRes'+
' Name="8319" Text=" Ԥ�� "/>  <StrRes Name="8320" Text="���:"/>  <StrRes Name="8321'+
'" Text="�߶�:"/>  <StrRes Name="8322" Text="ҳ"/>  <StrRes Name="8323" Text="�Ŵ�"/> '+
' <StrRes Name="8324" Text="��С"/>  <StrRes Name="8325" Text="�ı��ļ� (����ʽ��ӡ��)(*.prn)'+
'|*.prn"/>  <StrRes Name="8326" Text=".prn"/>  <StrRes Name="8400" Text="��ӡ"/>  <'+
'StrRes Name="8401" Text="��ӡ��"/>  <StrRes Name="8402" Text="����"/>  <StrRes Name="'+
'8403" Text="����..."/>  <StrRes Name="8404" Text="����"/>  <StrRes Name="8405" Text='+
'"����"/>  <StrRes Name="8406" Text=" ��ӡ����ʼ������ "/>  <StrRes Name="8407" Text="��ӡ������'+
'"/>  <StrRes Name="8408" Text=".fpi"/>  <StrRes Name="8409" Text="��ӡ����ʼ������ (*.fp'+
'i)|*.fpi"/>  <StrRes Name="8410" Text=".fpi"/>  <StrRes Name="8411" Text="��ӡ����ʼ��'+
'���� (*.fpi)|*.fpi"/>  <StrRes Name="8500" Text="������ RTF"/>  <StrRes Name="8501" T'+
'ext="ͼ��"/>  <StrRes Name="8502" Text="����������"/>  <StrRes Name="8503" Text="�ڵ������'+
'"/>  <StrRes Name="8504" Text="RTF �ļ� (*.rtf)|*.rtf"/>  <StrRes Name="8505" Text'+
'=".rtf"/>  <StrRes Name="8600" Text="��������"/>  <StrRes Name="8601" Text=" ͼ������ "/'+
'>  <StrRes Name="8602" Text="JPEG Ʒ��"/>  <StrRes Name="8603" Text="�ֱ��� (dpi)"/> '+
' <StrRes Name="8604" Text="�ָ��ļ�"/>  <StrRes Name="8605" Text="��ȥҳ��հײ���"/>  <StrR'+
'es Name="8606" Text="�ڰ�"/>  <StrRes Name="8700" Text="������ PDF"/>  <StrRes Name="'+
'8701" Text="ѹ��"/>  <StrRes Name="8702" Text="Ƕ������"/>  <StrRes Name="8703" Text="'+
'��ӡ�Ż�"/>  <StrRes Name="8704" Text="���"/>  <StrRes Name="8705" Text="����"/>  <StrR'+
'es Name="8706" Text="�ڵ������"/>  <StrRes Name="8707" Text="Adobe PDF �ļ� (*.pdf)|*'+
'.pdf"/>  <StrRes Name="8708" Text=".pdf"/>  <StrRes Name="RTFexport" Text="RTF ��'+
'��"/>  <StrRes Name="BMPexport" Text="BMP ͼ"/>  <StrRes Name="JPEGexport" Text="J'+
'PEG ͼ"/>  <StrRes Name="TIFFexport" Text="TIFF ͼ"/>  <StrRes Name="TextExport" T'+
'ext="���ı� (�����ӡ��)"/>  <StrRes Name="XlsOLEexport" Text="Excel ��� (OLE)"/>  <StrRe'+
's Name="HTMLexport" Text="HTML �ļ�"/>  <StrRes Name="XlsXMLexport" Text="Excel ���'+
' (XML)"/>  <StrRes Name="PDFexport" Text="PDF �ļ�"/>  <StrRes Name="ProgressWait"'+
' Text="���Ժ�"/>  <StrRes Name="ProgressRows" Text="���ڽ�����"/>  <StrRes Name="Progres'+
'sColumns" Text="���ڽ�����"/>  <StrRes Name="ProgressStyles" Text="���ڽ�����ʽ"/>  <StrRes'+
' Name="ProgressObjects" Text="���ڵ���������"/>  <StrRes Name="TIFFexportFilter" Text="'+
'Tiff ͼ (*.tif)|*.tif"/>  <StrRes Name="BMPexportFilter" Text="BMP ͼ (*.bmp)|*.bm'+
'p"/>  <StrRes Name="JPEGexportFilter" Text="Jpeg ͼ (*.jpg)|*.jpg"/>  <StrRes Nam'+
'e="HTMLNavFirst" Text="��ҳ"/>  <StrRes Name="HTMLNavPrev" Text="ǰһҳ"/>  <StrRes N'+
'ame="HTMLNavNext" Text="��һҳ"/>  <StrRes Name="HTMLNavLast" Text="ĩҳ"/>  <StrRes '+
'Name="HTMLNavRefresh" Text="ˢ��"/>  <StrRes Name="HTMLNavPrint" Text="��ӡ"/>  <Str'+
'Res Name="HTMLNavTotal" Text="ȫ��ҳ"/>  <StrRes Name="8800" Text="�������ı�"/>  <StrRe'+
's Name="8801" Text="Text file (*.txt)|*.txt"/>  <StrRes Name="8802" Text=".txt"/'+
'>  <StrRes Name="SimpleTextExport" Text="�ı��ļ�"/>  <StrRes Name="8850" Text="����ΪC'+
'SV"/>  <StrRes Name="8851" Text="CSV file (*.csv)|*.csv"/>  <StrRes Name="8852" '+
'Text=".csv"/>  <StrRes Name="8853" Text="�з�"/>  <StrRes Name="CSVExport" Text="C'+
'SV �ļ�"/>  <StrRes Name="8900" Text="ͨ��E-mail����"/>  <StrRes Name="8901" Text="E-m'+
'ail"/>  <StrRes Name="8902" Text="�ʻ�"/>  <StrRes Name="8903" Text="����"/>  <StrRe'+
's Name="8904" Text="��ַ"/>  <StrRes Name="8905" Text="����"/>  <StrRes Name="8906" '+
'Text="��ʽ"/>  <StrRes Name="8907" Text="���͵�ַ"/>  <StrRes Name="8908" Text="������"/>'+
'  <StrRes Name="8909" Text="����"/>  <StrRes Name="8910" Text="��¼"/>  <StrRes Name'+
'="8911" Text="�ʼ�"/>  <StrRes Name="8912" Text="ͨѶ"/>  <StrRes Name="8913" Text="'+
'�ı�"/>  <StrRes Name="8914" Text="��֯"/>  <StrRes Name="8915" Text="����"/>  <StrRes'+
' Name="8916" Text="�˿�"/>  <StrRes Name="8917" Text="��¼����"/>  <StrRes Name="8918"'+
' Text="����δ���fields"/>  <StrRes Name="8919" Text="�߼���������"/>  <StrRes Name="8920" '+
'Text="ǩ��"/>  <StrRes Name="8921" Text="����"/>  <StrRes Name="8922" Text="����"/>  <'+
'StrRes Name="8923" Text="Best regards"/>  <StrRes Name="8924" Text="�����ʼ���"/>  <S'+
'trRes Name="EmailExport" Text="E-mail"/>  <StrRes Name="FastReportFile" Text="Fa'+
'stReport file"/>  <StrRes Name="GifexportFilter" Text="Gif file (*.gif)|*.gif"/>'+
'  <StrRes Name="GIFexport" Text="Gif ͼ��"/>  <StrRes Name="8950" Text="����"/>  <St'+
'rRes Name="8951" Text="ҳͷ/β"/>  <StrRes Name="8952" Text="�ı�"/>  <StrRes Name="8'+
'953" Text="ͷ/β"/>  <StrRes Name="8954" Text="��"/>  <StrRes Name="ODSExportFilter'+
'" Text="�򿪵��ӱ���ĵ��ļ� (*.ods)|*.ods"/>  <StrRes Name="ODSExport" Text="�򿪵��ӱ���ĵ�"/> '+
' <StrRes Name="ODTExportFilter" Text="���ı��ļ��ĵ� (*.odt)|*.odt"/>  <StrRes Name="O'+
'DTExport" Text="���ı��ĵ�"/>  <StrRes Name="8960" Text=".ods"/>  <StrRes Name="8961'+
'" Text=".odt"/>  <StrRes Name="8962" Text="��ȫ"/>  <StrRes Name="8963" Text="��ȫ����'+
'"/>  <StrRes Name="8964" Text="����������"/>  <StrRes Name="8965" Text="�û�����"/>  <Str'+
'Res Name="8966" Text="��ӡ�ĵ�"/>  <StrRes Name="8967" Text="�޸��ĵ�"/>  <StrRes Name="'+
'8968" Text="�ı���ͼ�ο���"/>  <StrRes Name="8969" Text="��ӻ��޸��ı�ע��"/>  <StrRes Name="89'+
'70" Text="PDF ��ȫ"/>  <StrRes Name="8971" Text="Document information"/>  <StrRes '+
'Name="8972" Text="Information"/>  <StrRes Name="8973" Text="Title"/>  <StrRes Na'+
'me="8974" Text="Author"/>  <StrRes Name="8975" Text="Subject"/>  <StrRes Name="8'+
'976" Text="Keywords"/>  <StrRes Name="8977" Text="Creator"/>  <StrRes Name="8978'+
'" Text="Producer"/>  <StrRes Name="8979" Text="Authentification"/>  <StrRes Name'+
'="8980" Text="Permissions"/>  <StrRes Name="8981" Text="Viewer"/>  <StrRes Name='+
'"8982" Text="Viewer preferences"/>  <StrRes Name="8983" Text="Hide toolbar"/>  <'+
'StrRes Name="8984" Text="Hide menubar"/>  <StrRes Name="8985" Text="Hide window '+
'user interface"/>  <StrRes Name="8986" Text="Fit window"/>  <StrRes Name="8987" '+
'Text="Center window"/>  <StrRes Name="8988" Text="Print scaling"/>  <StrRes Name'+
'="8989" Text="Confirmation Reading"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
