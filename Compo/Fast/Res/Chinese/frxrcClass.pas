unit frxrcClass;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="936">  <StrRes Name="'+
'1" Text="ȷ��"/>  <StrRes Name="2" Text="ȡ��"/>  <StrRes Name="3" Text="ȫ��"/>  <Str'+
'Res Name="4" Text="��ҳ"/>  <StrRes Name="5" Text="ҳ:"/>  <StrRes Name="6" Text="��'+
'ҳ"/>  <StrRes Name="7" Text="ҳ����Χ"/>  <StrRes Name="8" Text="��������"/>  <StrRes Na'+
'me="9" Text="����ҳ��/�ļ���Χ�����Զ��ŷָ�(����:1,3,5-12)"/>  <StrRes Name="100" Text="Ԥ��"/>  <'+
'StrRes Name="101" Text="��ӡ"/>  <StrRes Name="102" Text="��ӡ"/>  <StrRes Name="103'+
'" Text="��"/>  <StrRes Name="104" Text="��"/>  <StrRes Name="105" Text="����"/>  <'+
'StrRes Name="106" Text="����"/>  <StrRes Name="107" Text="����"/>  <StrRes Name="108'+
'" Text="����"/>  <StrRes Name="109" Text="Ѱ��"/>  <StrRes Name="110" Text="Ѱ��"/>  <'+
'StrRes Name="111" Text="��ҳ"/>  <StrRes Name="112" Text="��ҳ"/>  <StrRes Name="113'+
'" Text="ҳ��"/>  <StrRes Name="114" Text="ҳ��"/>  <StrRes Name="115" Text="100%"/> '+
' <StrRes Name="116" Text="100%"/>  <StrRes Name="117" Text="��ҳ"/>  <StrRes Name='+
'"118" Text="��ҳ"/>  <StrRes Name="119" Text="��ʾ����"/>  <StrRes Name="120" Text="ҳ��'+
'����"/>  <StrRes Name="121" Text="ҳ������"/>  <StrRes Name="122" Text="��Ҫ"/>  <StrRes'+
' Name="123" Text="��Ҫ"/>  <StrRes Name="124" Text="�Ŵ�"/>  <StrRes Name="125" Text'+
'="�Ŵ�"/>  <StrRes Name="126" Text="��С"/>  <StrRes Name="127" Text="��С"/>  <StrRes'+
' Name="128" Text="���"/>  <StrRes Name="129" Text="������"/>  <StrRes Name="130" Te'+
'xt="����ͼ"/>  <StrRes Name="131" Text="����ͼ"/>  <StrRes Name="132" Text="�༭ҳ"/>  <S'+
'trRes Name="133" Text="�༭ҳ"/>  <StrRes Name="134" Text="��ҳ"/>  <StrRes Name="135'+
'" Text="��ҳ"/>  <StrRes Name="136" Text="ǰҳ"/>  <StrRes Name="137" Text="ǰҳ"/>  <'+
'StrRes Name="138" Text="��ҳ"/>  <StrRes Name="139" Text="��ҳ"/>  <StrRes Name="140'+
'" Text="ĩҳ"/>  <StrRes Name="141" Text="ĩҳ"/>  <StrRes Name="142" Text="ҳ��"/>  <'+
'StrRes Name="150" Text="ȫ��"/>  <StrRes Name="151" Text="����PDF��ʽ"/>  <StrRes Name'+
'="152" Text="����E-mail"/>  <StrRes Name="zmPageWidth" Text="ҳ��"/>  <StrRes Name="'+
'zmWholePage" Text="��ҳ"/>  <StrRes Name="200" Text="��ӡ"/>  <StrRes Name="201" Tex'+
't="��ӡ��"/>  <StrRes Name="202" Text="ҳ "/>  <StrRes Name="203" Text="����"/>  <StrR'+
'es Name="204" Text="�Զ���ҳ(&amp;T)"/>  <StrRes Name="205" Text="����(&amp;C)"/>  <St'+
'rRes Name="206" Text="��ӡ"/>  <StrRes Name="207" Text="!����"/>  <StrRes Name="208"'+
' Text="λ��:"/>  <StrRes Name="209" Text="����(&amp;P)"/>  <StrRes Name="210" Text="'+
'������ļ�(&amp;L)"/>  <StrRes Name="211" Text="!˳��"/>  <StrRes Name="212" Text="����:"'+
'/>  <StrRes Name="213" Text="��ӡģʽ"/>  <StrRes Name="214" Text="ֽ�ϴ�ӡ"/>  <StrRes '+
'Name="216" Text="˫��"/>  <StrRes Name="ppAll" Text="��Χ������ҳ��"/>  <StrRes Name="ppO'+
'dd" Text="����ҳ"/>  <StrRes Name="ppEven" Text="ż��ҳ"/>  <StrRes Name="pgDefault" T'+
'ext="Ĭ��"/>  <StrRes Name="pmDefault" Text="Ĭ��"/>  <StrRes Name="pmSplit" Text="��'+
'�ִ�ҳ"/>  <StrRes Name="pmJoin" Text="����Сҳ"/>  <StrRes Name="pmScale" Text="����"/> '+
' <StrRes Name="poDirect" Text="!ֱ�� (1-9)"/>  <StrRes Name="poReverse" Text="!��ת '+
'(9-1)"/>  <StrRes Name="300" Text="Ѱ���ı�"/>  <StrRes Name="301" Text="Ѱ��Ŀ��:"/>  <'+
'StrRes Name="302" Text="ѡ��"/>  <StrRes Name="303" Text="�滻"/>  <StrRes Name="304'+
'" Text="���"/>  <StrRes Name="305" Text="���ִ�Сд"/>  <StrRes Name="400" Text="ҳ������"'+
'/>  <StrRes Name="401" Text="���"/>  <StrRes Name="402" Text="�߶�"/>  <StrRes Name'+
'="403" Text="ֽ�Ŵ�С"/>  <StrRes Name="404" Text="��ӡ����"/>  <StrRes Name="405" Text='+
'"��"/>  <StrRes Name="406" Text="��"/>  <StrRes Name="407" Text="��"/>  <StrRes Nam'+
'e="408" Text="��"/>  <StrRes Name="409" Text="�߾�"/>  <StrRes Name="410" Text="����"'+
'/>  <StrRes Name="411" Text="����"/>  <StrRes Name="412" Text="����"/>  <StrRes Name'+
'="413" Text="���ñ�ҳ"/>  <StrRes Name="414" Text="����ȫ��ҳ��"/>  <StrRes Name="500" Tex'+
't="��ӡt"/>  <StrRes Name="501" Text="��ӡ��"/>  <StrRes Name="502" Text="ҳ"/>  <StrR'+
'es Name="503" Text="����"/>  <StrRes Name="504" Text="����"/>  <StrRes Name="505" Te'+
'xt="ѡ��"/>  <StrRes Name="506" Text="Escape ָ��"/>  <StrRes Name="507" Text="��ӡ���ļ�'+
'"/>  <StrRes Name="508" Text="OEM ҳ��"/>  <StrRes Name="509" Text="�����ͼ����Ԫ"/>  <S'+
'trRes Name="510" Text="��ӡ���ļ� (*.prn)|*.prn"/>  <StrRes Name="mbConfirm" Text="ȷ��'+
'"/>  <StrRes Name="mbError" Text="����"/>  <StrRes Name="mbInfo" Text="��Ѷ"/>  <Str'+
'Res Name="xrCantFindClass" Text="���������"/>  <StrRes Name="prVirtual" Text="����"/> '+
' <StrRes Name="prDefault" Text="Ԥ��"/>  <StrRes Name="prCustom" Text="�Զ�"/>  <Str'+
'Res Name="enUnconnHeader" Text="δ����������"/>  <StrRes Name="enUnconnGroup" Text="Ⱥ��'+
'δ���������ݿ�"/>  <StrRes Name="enUnconnGFooter" Text="û��Ⱥ���βer for"/>  <StrRes Name="'+
'enBandPos" Text="Band��λ�ô���:"/>  <StrRes Name="dbNotConn" Text="���ݿ� %s δ���������ݿ�"/>'+
'  <StrRes Name="dbFldNotFound" Text="�ֶβ�����:"/>  <StrRes Name="clDSNotIncl" Text='+
'"(���ݿ�δ������ Report.DataSets)"/>  <StrRes Name="clUnknownVar" Text="δ֪�ı��������ݿ��ֶ�:"/>'+
'  <StrRes Name="clScrError" Text="Script ������ %s: %s"/>  <StrRes Name="clDSNotExi'+
'st" Text="���ݿ� &#38;#34;%s&#38;#34; ������"/>  <StrRes Name="clErrors" Text="�������еĴ���'+
':"/>  <StrRes Name="clExprError" Text="����ʽ����"/>  <StrRes Name="clFP3files" Text='+
'"�����ļ�"/>  <StrRes Name="clSaving" Text="�����ļ�..."/>  <StrRes Name="clCancel" Text'+
'="ȡ��"/>  <StrRes Name="clClose" Text="�ر�(&amp;X)"/>  <StrRes Name="clPrinting" T'+
'ext="��ӡҳ"/>  <StrRes Name="clLoading" Text="�����ļ�..."/>  <StrRes Name="clPageOf" '+
'Text="ҳ %d / %d"/>  <StrRes Name="clFirstPass" Text="��һ�δ������: ҳ "/>  <StrRes Nam'+
'e="clNoPrinters" Text="�����ϵͳû�а�װ��ӡ��"/>  <StrRes Name="clDecompressError" Text="S'+
'tream ��ѹ����������"/>  <StrRes Name="prRunningFirst" Text="��һ�ι���: ҳ %d"/>  <StrRes Na'+
'me="prRunning" Text="׼��ҳ %d"/>  <StrRes Name="prPrinting" Text="��ӡҳ %d"/>  <StrR'+
'es Name="prExporting" Text="����ҳ %d"/>  <StrRes Name="uCm" Text="cm"/>  <StrRes N'+
'ame="uInch" Text="in"/>  <StrRes Name="uPix" Text="px"/>  <StrRes Name="uChar" T'+
'ext="chr"/>  <StrRes Name="dupDefault" Text="Ĭ��"/>  <StrRes Name="dupVert" Text='+
'"��ֱ"/>  <StrRes Name="dupHorz" Text="ˮƽ"/>  <StrRes Name="dupSimpl" Text="Simple'+
'x"/>  <StrRes Name="crFillMx" Text="��佻���..."/>  <StrRes Name="crBuildMx" Text="'+
'���������..."/>  <StrRes Name="SLangNotFound" Text="�Ҳ��� ''%s'' ����"/>  <StrRes Name="SI'+
'nvalidLanguage" Text="���Ϸ������Զ���"/>  <StrRes Name="SIdRedeclared" Text="��ʶ���ظ�����: "'+
'/>  <StrRes Name="SUnknownType" Text="δ֪������: "/>  <StrRes Name="SIncompatibleTyp'+
'es" Text="�����ݵ�����"/>  <StrRes Name="SIdUndeclared" Text="��ʶ��δ����: "/>  <StrRes Nam'+
'e="SClassRequired" Text="�˴���Ҫ��(Class)����"/>  <StrRes Name="SIndexRequired" Text="'+
'�˴���Ҫ����(Index)"/>  <StrRes Name="SStringError" Text="Stringsû������(properties)�򷽷�(m'+
'ethods)"/>  <StrRes Name="SClassError" Text="��(Class) %s û��Ԥ�������"/>  <StrRes Nam'+
'e="SArrayRequired" Text="�˴���Ҫ��������"/>  <StrRes Name="SVarRequired" Text="�˴���Ҫ����"/'+
'>  <StrRes Name="SNotEnoughParams" Text="ʵ�ʵĲ�����������"/>  <StrRes Name="STooManyPar'+
'ams" Text="��������̫��"/>  <StrRes Name="SLeftCantAssigned" Text="��ߵı�������ָ���µ�ֵ"/>  <S'+
'trRes Name="SForError" Text="for..loop������������ֵ����"/>  <StrRes Name="SEventError" T'+
'ext="�¼���������ǹ���(procedure)"/>  <StrRes Name="600" Text="ȫ��չ��"/>  <StrRes Name="60'+
'1" Text="ȫ���պ�"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
