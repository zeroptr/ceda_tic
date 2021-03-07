unit frxrcDesgn;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="936">  <StrRes Name="'+
'2000" Text="����鿴��"/>  <StrRes Name="oiProp" Text="����"/>  <StrRes Name="oiEvent" '+
'Text="�¼�"/>  <StrRes Name="2100" Text="������"/>  <StrRes Name="2101" Text="����"/>  '+
'<StrRes Name="2102" Text="����"/>  <StrRes Name="2103" Text="����"/>  <StrRes Name="'+
'2104" Text="�����ֶ�"/>  <StrRes Name="2105" Text="��������"/>  <StrRes Name="2106" Text'+
'="��"/>  <StrRes Name="dtNoData" Text="û�����ݿ����ʹ��"/>  <StrRes Name="dtNoData1" Tex'+
't="���� ��&#38;#34;����|����...&#38;#34; �˵����һ���Ѵ��ڵ����ݼ���������,����ת���� &#38;#34;Data&#38;#34;'+
' ҳǩ,Ȼ�󴴽�һ���µ����ݼ�."/>  <StrRes Name="dtData" Text="����"/>  <StrRes Name="dtSysVar" '+
'Text="ϵͳ����"/>  <StrRes Name="dtVar" Text="����"/>  <StrRes Name="dtFunc" Text="����"'+
'/>  <StrRes Name="2200" Text="������"/>  <StrRes Name="2300" Text="�򿪽ű�"/>  <StrRes'+
' Name="2301" Text="����ű�"/>  <StrRes Name="2302" Text="ִ�нű�"/>  <StrRes Name="230'+
'3" Text="׷����"/>  <StrRes Name="2304" Text="�����ű�"/>  <StrRes Name="2305" Text="��ֵ'+
'"/>  <StrRes Name="2306" Text="����:"/>  <StrRes Name="2307" Text="����"/>  <StrRes '+
'Name="2308" Text="����"/>  <StrRes Name="2309" Text="ˮƽ����"/>  <StrRes Name="2310" '+
'Text="����"/>  <StrRes Name="2311" Text="����"/>  <StrRes Name="2312" Text="��ֱ����"/> '+
' <StrRes Name="2313" Text="���"/>  <StrRes Name="2314" Text="ˮƽ�ռ�"/>  <StrRes Nam'+
'e="2315" Text="��ֱ�ռ�"/>  <StrRes Name="2316" Text="ˮƽ����"/>  <StrRes Name="2317" T'+
'ext="��ֱ����"/>  <StrRes Name="2318" Text="��ͬ���"/>  <StrRes Name="2319" Text="��ͬ�߶�"'+
'/>  <StrRes Name="2320" Text="�ı�"/>  <StrRes Name="2321" Text="��ʽ"/>  <StrRes Na'+
'me="2322" Text="��������"/>  <StrRes Name="2323" Text="�����С"/>  <StrRes Name="2324" '+
'Text="����"/>  <StrRes Name="2325" Text="б��"/>  <StrRes Name="2326" Text="����"/>  <'+
'StrRes Name="2327" Text="������ɫ"/>  <StrRes Name="2328" Text="ǿ��"/>  <StrRes Name='+
'"2329" Text="�ı�����"/>  <StrRes Name="2330" Text="�����"/>  <StrRes Name="2331" Text'+
'="����"/>  <StrRes Name="2332" Text="�Ҷ���"/>  <StrRes Name="2333" Text="�����"/>  <St'+
'rRes Name="2334" Text="�϶���"/>  <StrRes Name="2335" Text="��ֱ����"/>  <StrRes Name="'+
'2336" Text="�ײ�����"/>  <StrRes Name="2337" Text="���"/>  <StrRes Name="2338" Text="'+
'�Ϸ���"/>  <StrRes Name="2339" Text="�·���"/>  <StrRes Name="2340" Text="�����"/>  <Str'+
'Res Name="2341" Text="�ұ���"/>  <StrRes Name="2342" Text="����"/>  <StrRes Name="234'+
'3" Text="û�б߿�"/>  <StrRes Name="2344" Text="��Ӱ"/>  <StrRes Name="2345" Text="������'+
'ɫ"/>  <StrRes Name="2346" Text="�����ɫ"/>  <StrRes Name="2347" Text="�����ʽ"/>  <Str'+
'Res Name="2348" Text="�����"/>  <StrRes Name="2349" Text="��׼"/>  <StrRes Name="23'+
'50" Text="�±���"/>  <StrRes Name="2351" Text="�򿪱���"/>  <StrRes Name="2352" Text="��'+
'�汨��"/>  <StrRes Name="2353" Text="Ԥ��"/>  <StrRes Name="2354" Text="�±���ҳ��"/>  <St'+
'rRes Name="2355" Text="�¶Ի���"/>  <StrRes Name="2356" Text="ɾ��ҳ"/>  <StrRes Name="'+
'2357" Text="ҳ������"/>  <StrRes Name="2358" Text="����"/>  <StrRes Name="2359" Text="'+
'����"/>  <StrRes Name="2360" Text="����"/>  <StrRes Name="2361" Text="ճ��"/>  <StrRes'+
' Name="2362" Text="���Ƹ�ʽ"/>  <StrRes Name="2363" Text="����"/>  <StrRes Name="2364"'+
' Text="�ظ�"/>  <StrRes Name="2365" Text="Ⱥ��"/>  <StrRes Name="2366" Text="ȡ��Ⱥ��"/>'+
'  <StrRes Name="2367" Text="��ʾɺ��"/>  <StrRes Name="2368" Text="ɺ�����"/>  <StrRes '+
'Name="2369" Text="Fit to Grid"/>  <StrRes Name="2370" Text="��ʾ����"/>  <StrRes Nam'+
'e="2371" Text="���⹤��"/>  <StrRes Name="2372" Text="ѡȡ����"/>  <StrRes Name="2373" T'+
'ext="ͽ�ֹ���"/>  <StrRes Name="2374" Text="��ʾ���ʹ���"/>  <StrRes Name="2375" Text="�༭��'+
'������"/>  <StrRes Name="2376" Text="���Ƹ�ʽ����"/>  <StrRes Name="2377" Text="����Band"/>'+
'  <StrRes Name="2378" Text="�ļ�(&amp;F)"/>  <StrRes Name="2379" Text="�༭(&amp;E)"'+
'/>  <StrRes Name="2380" Text="����..."/>  <StrRes Name="2381" Text="����һ��"/>  <StrR'+
'es Name="2382" Text="�滻..."/>  <StrRes Name="2383" Text="����(&amp;R)"/>  <StrRes '+
'Name="2384" Text="����..."/>  <StrRes Name="2385" Text="ѡ��..."/>  <StrRes Name="23'+
'86" Text="��ʽ..."/>  <StrRes Name="2387" Text="��ͼ(&amp;V)"/>  <StrRes Name="2388"'+
' Text="������"/>  <StrRes Name="2389" Text="��׼"/>  <StrRes Name="2390" Text="�ı�"/> '+
' <StrRes Name="2391" Text="����"/>  <StrRes Name="2392" Text="����"/>  <StrRes Name='+
'"2393" Text="����"/>  <StrRes Name="2394" Text="����鿴��"/>  <StrRes Name="2395" Text'+
'="������"/>  <StrRes Name="2396" Text="������"/>  <StrRes Name="2397" Text="���"/>  <St'+
'rRes Name="2398" Text="��"/>  <StrRes Name="2399" Text="ɾ����"/>  <StrRes Name="2'+
'400" Text="ѡ��..."/>  <StrRes Name="2401" Text="����(&amp;H)"/>  <StrRes Name="2402'+
'" Text="����..."/>  <StrRes Name="2403" Text="���� FastReport..."/>  <StrRes Name="2'+
'404" Text="Tab ����..."/>  <StrRes Name="2405" Text="����"/>  <StrRes Name="2406" Te'+
'xt="�ظ�"/>  <StrRes Name="2407" Text="����"/>  <StrRes Name="2408" Text="����"/>  <St'+
'rRes Name="2409" Text="ճ��"/>  <StrRes Name="2410" Text="Ⱥ��"/>  <StrRes Name="241'+
'1" Text="ȡ��Ⱥ��"/>  <StrRes Name="2412" Text="ɾ��"/>  <StrRes Name="2413" Text="ɾ��ҳ'+
'"/>  <StrRes Name="2414" Text="ȫѡ"/>  <StrRes Name="2415" Text="�༭..."/>  <StrRe'+
's Name="2416" Text="���ڶ���"/>  <StrRes Name="2417" Text="���ڵײ�"/>  <StrRes Name="24'+
'18" Text="�½�..."/>  <StrRes Name="2419" Text="�±���"/>  <StrRes Name="2420" Text="'+
'��ҳ��"/>  <StrRes Name="2421" Text="�¶Ի���"/>  <StrRes Name="2422" Text="��..."/>  <'+
'StrRes Name="2423" Text="����"/>  <StrRes Name="2424" Text="���Ϊ..."/>  <StrRes Nam'+
'e="2425" Text="����..."/>  <StrRes Name="2426" Text="ҳ������..."/>  <StrRes Name="242'+
'7" Text="Ԥ��"/>  <StrRes Name="2428" Text="�˳�"/>  <StrRes Name="2429" Text="����̧ͷ"'+
'/>  <StrRes Name="2430" Text="����ϼ�"/>  <StrRes Name="2431" Text="ҳ��"/>  <StrRes '+
'Name="2432" Text="ҳβ"/>  <StrRes Name="2433" Text="ͷ"/>  <StrRes Name="2434" Tex'+
't="β"/>  <StrRes Name="2435" Text="������"/>  <StrRes Name="2436" Text="��ϸ����"/>  <S'+
'trRes Name="2437" Text="����������"/>  <StrRes Name="2438" Text="��4������"/>  <StrRes Na'+
'me="2439" Text="��5������"/>  <StrRes Name="2440" Text="��6������"/>  <StrRes Name="2441'+
'" Text="Ⱥ����"/>  <StrRes Name="2442" Text="Ⱥ��β"/>  <StrRes Name="2443" Text="��"/>'+
'  <StrRes Name="2444" Text="����"/>  <StrRes Name="2445" Text="��β"/>  <StrRes Name'+
'="2446" Text="�ص�"/>  <StrRes Name="2447" Text="��ֱBand"/>  <StrRes Name="2448" Te'+
'xt="ͷ"/>  <StrRes Name="2449" Text="β"/>  <StrRes Name="2450" Text="������"/>  <Str'+
'Res Name="2451" Text="��ϸ����"/>  <StrRes Name="2452" Text="����ϸ����"/>  <StrRes Name='+
'"2453" Text="Ⱥ����"/>  <StrRes Name="2454" Text="Ⱥ��β"/>  <StrRes Name="2455" Text='+
'"��"/>  <StrRes Name="2456" Text="0��"/>  <StrRes Name="2457" Text="45��"/>  <StrRe'+
's Name="2458" Text="90��"/>  <StrRes Name="2459" Text="180��"/>  <StrRes Name="246'+
'0" Text="270��"/>  <StrRes Name="2461" Text="��������"/>  <StrRes Name="2462" Text="��'+
'��"/>  <StrRes Name="2463" Text="б��"/>  <StrRes Name="2464" Text="����"/>  <StrRes '+
'Name="2465" Text="SuperScript"/>  <StrRes Name="2466" Text="SubScript"/>  <StrRe'+
's Name="2467" Text="ѹ��"/>  <StrRes Name="2468" Text="��"/>  <StrRes Name="2469" T'+
'ext="12 cpi"/>  <StrRes Name="2470" Text="15 cpi"/>  <StrRes Name="2471" Text="R'+
'eport (*.fr3)|*.fr3"/>  <StrRes Name="2472" Text="Pascal files (*.pas)|*.pas|C++'+
' files (*.cpp)|*.cpp|JavaScript files (*.js)|*.js|Basic files (*.vb)|*.vb|All fi'+
'les|*.*"/>  <StrRes Name="2473" Text="Pascal files (*.pas)|*.pas|C++ files (*.cp'+
'p)|*.cpp|JavaScript files (*.js)|*.js|Basic files (*.vb)|*.vb|All files|*.*"/>  '+
'<StrRes Name="2474" Text="����..."/>  <StrRes Name="2475" Text="����"/>  <StrRes Nam'+
'e="2476" Text="���öϵ�"/>  <StrRes Name="2477" Text="���е���괦"/>  <StrRes Name="2478"'+
' Text="!�����band"/>  <StrRes Name="dsCm" Text="����"/>  <StrRes Name="dsInch" Text='+
'"Ӣ��"/>  <StrRes Name="dsPix" Text="����"/>  <StrRes Name="dsChars" Text="�ַ�"/>  <S'+
'trRes Name="dsCode" Text="����"/>  <StrRes Name="dsData" Text="����"/>  <StrRes Name'+
'="dsPage" Text="ҳ"/>  <StrRes Name="dsRepFilter" Text="Report (*.fr3)|*.fr3"/>  '+
'<StrRes Name="dsComprRepFilter" Text="Compressed report (*.fr3)|*.fr3"/>  <StrRe'+
's Name="dsSavePreviewChanges" Text="��������Ԥ��ҳ��?"/>  <StrRes Name="dsSaveChangesTo'+
'" Text="�����޸��� "/>  <StrRes Name="dsCantLoad" Text="�޷������ļ�"/>  <StrRes Name="dsSt'+
'yleFile" Text="��ʽ"/>  <StrRes Name="dsCantFindProc" Text="�Ҳ���������"/>  <StrRes Nam'+
'e="dsClearScript" Text="������еĽű�����Ҫ������?"/>  <StrRes Name="dsNoStyle" Text="û����ʽ"/'+
'>  <StrRes Name="dsStyleSample" Text="��ʽ����"/>  <StrRes Name="dsTextNotFound" Tex'+
't="�ı� ''%s'' �Ҳ���"/>  <StrRes Name="dsReplace" Text="�滻�ı� ''%s''?"/>  <StrRes Name="2'+
'600" Text="���� FastReport"/>  <StrRes Name="2601" Text="�������ǵ���վ��ȡ�ø������Ϣ:"/>  <Str'+
'Res Name="2602" Text="����:"/>  <StrRes Name="2603" Text="֧Ԯ:"/>  <StrRes Name="27'+
'00" Text="ҳ������"/>  <StrRes Name="2701" Text="ֽ��"/>  <StrRes Name="2702" Text="���'+
'"/>  <StrRes Name="2703" Text="�߶�"/>  <StrRes Name="2704" Text="��С"/>  <StrRes N'+
'ame="2705" Text="����"/>  <StrRes Name="2706" Text="��߾�"/>  <StrRes Name="2707" Te'+
'xt="�ϱ߾�"/>  <StrRes Name="2708" Text="�ұ߾�"/>  <StrRes Name="2709" Text="�±߾�"/>  '+
'<StrRes Name="2710" Text="�߾�"/>  <StrRes Name="2711" Text="ֽ����Դ"/>  <StrRes Name'+
'="2712" Text="��һҳ"/>  <StrRes Name="2713" Text="����ҳ"/>  <StrRes Name="2714" Text'+
'="����"/>  <StrRes Name="2715" Text="����"/>  <StrRes Name="2716" Text="����ѡ��"/>  <St'+
'rRes Name="2717" Text="����"/>  <StrRes Name="2718" Text="����"/>  <StrRes Name="271'+
'9" Text="�����"/>  <StrRes Name="2720" Text="λ��"/>  <StrRes Name="2721" Text="����"/'+
'>  <StrRes Name="2722" Text="˫���ӡ"/>  <StrRes Name="2723" Text="��ӡ��ǰһҳ"/>  <StrR'+
'es Name="2724" Text="��չ����ӡ��"/>  <StrRes Name="2725" Text="�����ģʽʹ�ô��ֽ�Ÿ߶�"/>  <Str'+
'Res Name="2726" Text="����ҳ��"/>  <StrRes Name="2727" Text="����ҳ��"/>  <StrRes Name="'+
'2800" Text="ѡȡ�������ݿ�"/>  <StrRes Name="2900" Text="�༭����"/>  <StrRes Name="2901" T'+
'ext="���"/>  <StrRes Name="2902" Text="����"/>  <StrRes Name="2903" Text="�༭"/>  <S'+
'trRes Name="2904" Text="ɾ��"/>  <StrRes Name="2905" Text="�嵥"/>  <StrRes Name="29'+
'06" Text="����"/>  <StrRes Name="2907" Text="����"/>  <StrRes Name="2908" Text=" ����ʽ'+
':"/>  <StrRes Name="2909" Text="Dictionary (*.fd3)|*.fd3"/>  <StrRes Name="2910"'+
' Text="Dictionary (*.fd3)|*.fd3"/>  <StrRes Name="vaNoVar" Text="(δ�������)"/>  <St'+
'rRes Name="vaVar" Text="����"/>  <StrRes Name="vaDupName" Text="�����ظ�"/>  <StrRes N'+
'ame="3000" Text="���ѡ��"/>  <StrRes Name="3001" Text="ɺ��"/>  <StrRes Name="3002" T'+
'ext="����"/>  <StrRes Name="3003" Text="��С"/>  <StrRes Name="3004" Text="�Ի���:"/>  '+
'<StrRes Name="3005" Text="����"/>  <StrRes Name="3006" Text="����"/>  <StrRes Name="'+
'3007" Text="����༭��"/>  <StrRes Name="3008" Text="�ı��༭��"/>  <StrRes Name="3009" Te'+
'xt="��С"/>  <StrRes Name="3010" Text="��С"/>  <StrRes Name="3011" Text="��ɫ"/>  <St'+
'rRes Name="3012" Text="���:"/>  <StrRes Name="3013" Text="cm"/>  <StrRes Name="30'+
'14" Text="in"/>  <StrRes Name="3015" Text="pt"/>  <StrRes Name="3016" Text="pt"/'+
'>  <StrRes Name="3017" Text="pt"/>  <StrRes Name="3018" Text="����:"/>  <StrRes Na'+
'me="3019" Text="Ӣ��:"/>  <StrRes Name="3020" Text="����:"/>  <StrRes Name="3021" Te'+
'xt="��ʾɺ��"/>  <StrRes Name="3022" Text="ɺ�����"/>  <StrRes Name="3023" Text="�������ʾ��'+
'����"/>  <StrRes Name="3024" Text="ʹ�ö������������"/>  <StrRes Name="3025" Text="�����ռ�"/>'+
'  <StrRes Name="3026" Text="�����Ӵ�"/>  <StrRes Name="3027" Text="LCD ɺ����ɫ"/>  <Str'+
'Res Name="3028" Text="���ɰ���Band��λ��"/>  <StrRes Name="3029" Text="��ʾ����field�б�"/>  '+
'<StrRes Name="3030" Text="��ʾ��ʼ��Ļ"/>  <StrRes Name="3031" Text="��ԭĬ������"/>  <StrRe'+
's Name="3032" Text="��ʾBand�ı���"/>  <StrRes Name="3100" Text="ѡȡ���ݿ�"/>  <StrRes Na'+
'me="3101" Text="��¼����:"/>  <StrRes Name="dbNotAssigned" Text="[δָ��]"/>  <StrRes N'+
'ame="3200" Text="Ⱥ��"/>  <StrRes Name="3201" Text="Ⱥ��ָ���"/>  <StrRes Name="3202" '+
'Text="ѡ��"/>  <StrRes Name="3203" Text="�����ֶ�"/>  <StrRes Name="3204" Text="����ʽ"/>'+
'  <StrRes Name="3205" Text="������Ⱥ����һ��"/>  <StrRes Name="3206" Text="��ҳ"/>  <StrRe'+
's Name="3207" Text="��ʾ�ڴ��"/>  <StrRes Name="3300" Text="ϵͳ����"/>  <StrRes Name="3'+
'301" Text="����band"/>  <StrRes Name="3302" Text="���ݿ�"/>  <StrRes Name="3303" Text'+
'="�����ֶ�"/>  <StrRes Name="3304" Text="����"/>  <StrRes Name="3305" Text="��ʾʽ"/>  <S'+
'trRes Name="3306" Text="�ۺ�ֵ"/>  <StrRes Name="3307" Text="ϵͳ����"/>  <StrRes Name='+
'"3308" Text="���㲻�ɼ�band����Ŀ"/>  <StrRes Name="3309" Text="�ı�"/>  <StrRes Name="331'+
'0" Text="ִ������"/>  <StrRes Name="agAggregate" Text="����ϼ�"/>  <StrRes Name="vt1" T'+
'ext="[DATE]"/>  <StrRes Name="vt2" Text="[TIME]"/>  <StrRes Name="vt3" Text="[PA'+
'GE#]"/>  <StrRes Name="vt4" Text="[TOTALPAGES#]"/>  <StrRes Name="vt5" Text="[PA'+
'GE#] of [TOTALPAGES#]"/>  <StrRes Name="vt6" Text="[LINE#]"/>  <StrRes Name="340'+
'0" Text="OLE ����"/>  <StrRes Name="3401" Text="����..."/>  <StrRes Name="3402" Text'+
'="�༭..."/>  <StrRes Name="3403" Text="�ر�"/>  <StrRes Name="olStretched" Text="St'+
'retched"/>  <StrRes Name="3500" Text="����༭��"/>  <StrRes Name="3501" Text="��"/>  '+
'<StrRes Name="3502" Text="��������"/>  <StrRes Name="3503" Text="����:"/>  <StrRes Nam'+
'e="3504" Text="ѡ��"/>  <StrRes Name="3505" Text="��ת"/>  <StrRes Name="3506" Text='+
'"�������� "/>  <StrRes Name="3507" Text="�ı�"/>  <StrRes Name="3508" Text="0��"/>  <S'+
'trRes Name="3509" Text="90��"/>  <StrRes Name="3510" Text="180��"/>  <StrRes Name='+
'"3511" Text="270��"/>  <StrRes Name="bcCalcChecksum" Text="��������"/>  <StrRes Name'+
'="bcShowText" Text="��ʾ�ı�"/>  <StrRes Name="3600" Text="�༭����"/>  <StrRes Name="36'+
'01" Text="�� Enter �༭��Ŀ"/>  <StrRes Name="3602" Text="���ݿ����"/>  <StrRes Name="360'+
'3" Text="�ֶα���"/>  <StrRes Name="3604" Text="����"/>  <StrRes Name="3605" Text="����"'+
'/>  <StrRes Name="alUserName" Text="ʹ��������"/>  <StrRes Name="alOriginal" Text="ԭ��'+
'������"/>  <StrRes Name="3700" Text="�����༭��"/>  <StrRes Name="qpName" Text="����"/>  <'+
'StrRes Name="qpDataType" Text="��������"/>  <StrRes Name="qpValue" Text="ֵ"/>  <StrR'+
'es Name="3800" Text="��-�� ����"/>  <StrRes Name="3801" Text="Detail �ֶ�"/>  <StrRes '+
'Name="3802" Text="Master �ֶ�"/>  <StrRes Name="3803" Text="Linked �ֶ�"/>  <StrRes '+
'Name="3804" Text="����"/>  <StrRes Name="3805" Text="���"/>  <StrRes Name="3900" Te'+
'xt="����"/>  <StrRes Name="3901" Text="��������ʽ"/>  <StrRes Name="3902" Text="����ϼ�"/>'+
'  <StrRes Name="3903" Text="���������ʽ"/>  <StrRes Name="3904" Text="�ı��Զ�����"/>  <Str'+
'Res Name="3905" Text="�ı�"/>  <StrRes Name="3906" Text="��ʽ"/>  <StrRes Name="3907'+
'" Text="ͻ��"/>  <StrRes Name="4000" Text="ͼ��"/>  <StrRes Name="4001" Text="����"/> '+
' <StrRes Name="4002" Text="����"/>  <StrRes Name="4003" Text="ճ��"/>  <StrRes Name='+
'"4004" Text="���"/>  <StrRes Name="piEmpty" Text="���"/>  <StrRes Name="4100" Text'+
'="ͳ��ͼ�༭��"/>  <StrRes Name="4101" Text="����ϵ��"/>  <StrRes Name="4102" Text="ɾ��ϵ��"/'+
'>  <StrRes Name="4103" Text="�༭ͼ��"/>  <StrRes Name="4104" Text="Band ����Դ"/>  <St'+
'rRes Name="4105" Text="�̶�����"/>  <StrRes Name="4106" Text="���ݿ�"/>  <StrRes Name="'+
'4107" Text="Data ����Դ"/>  <StrRes Name="4108" Text="ֵ"/>  <StrRes Name="4109" Tex'+
't="ѡ��ͼ��ϵ�л�����һ��ϵ��."/>  <StrRes Name="4114" Text="����ѡ��"/>  <StrRes Name="4115" Tex'+
't="ǰN����ֵ"/>  <StrRes Name="4116" Text="ǰN���ı���"/>  <StrRes Name="4117" Text="����˳��'+
'"/>  <StrRes Name="4126" Text="X ��"/>  <StrRes Name="ch3D" Text="3D �鿴"/>  <StrR'+
'es Name="chAxis" Text="��ʾ��"/>  <StrRes Name="chsoNone" Text="��"/>  <StrRes Name='+
'"chsoAscending" Text="����"/>  <StrRes Name="chsoDescending" Text="�ݼ�"/>  <StrRes '+
'Name="chxtText" Text="�ı�"/>  <StrRes Name="chxtNumber" Text="��ֵ"/>  <StrRes Name'+
'="chxtDate" Text="����"/>  <StrRes Name="4200" Text="RTF �ļ��༭��"/>  <StrRes Name="4'+
'201" Text="���ļ�"/>  <StrRes Name="4202" Text="�����ļ�"/>  <StrRes Name="4203" Text='+
'"  ԭ"/>  <StrRes Name="4204" Text="����"/>  <StrRes Name="4205" Text="��������ʽ"/>  <S'+
'trRes Name="4206" Text="����"/>  <StrRes Name="4207" Text="б��"/>  <StrRes Name="42'+
'08" Text="����"/>  <StrRes Name="4209" Text="�����"/>  <StrRes Name="4210" Text="����"'+
'/>  <StrRes Name="4211" Text="�Ҷ���"/>  <StrRes Name="4212" Text="�������"/>  <StrRes'+
' Name="4213" Text="���غ�"/>  <StrRes Name="4300" Text="���汨��༭��"/>  <StrRes Name="4'+
'301" Text="��Դ����"/>  <StrRes Name="4302" Text="�ռ�"/>  <StrRes Name="4303" Text="��'+
'"/>  <StrRes Name="4304" Text="��"/>  <StrRes Name="4305" Text="С����"/>  <StrRes N'+
'ame="4306" Text="���汨��ṹ"/>  <StrRes Name="4307" Text="����"/>  <StrRes Name="4308"'+
' Text="����"/>  <StrRes Name="4309" Text="���ܼ�"/>  <StrRes Name="4310" Text="���ܼ�"/>'+
'  <StrRes Name="4311" Text="��/������"/>  <StrRes Name="4312" Text="!ѡ����ʽ"/>  <StrRe'+
's Name="4313" Text="!���浱ǰ��ʽ..."/>  <StrRes Name="4314" Text="!��ʾ����"/>  <StrRes N'+
'ame="4315" Text="!��ʾת��"/>  <StrRes Name="4316" Text="!����ҳ���ϴ�ӡҳͷ"/>  <StrRes Name'+
'="4317" Text="!�Զ���С"/>  <StrRes Name="4318" Text="!Χ�Ƶ�Ԫ��ı߿�"/>  <StrRes Name="43'+
'19" Text="!���´�ӡȻ�󽻲�"/>  <StrRes Name="4320" Text="!���ŵ�Ԫ��"/>  <StrRes Name="4321"'+
' Text="!������ȵ�Ԫ��"/>  <StrRes Name="4322" Text="��"/>  <StrRes Name="4323" Text="�ϼ�'+
'"/>  <StrRes Name="4324" Text="��Сֵ"/>  <StrRes Name="4325" Text="���ֵ"/>  <StrRes'+
' Name="4326" Text="ƽ��ֵ"/>  <StrRes Name="4327" Text="����"/>  <StrRes Name="4328" '+
'Text="���� (A-Z)"/>  <StrRes Name="4329" Text="�ݼ� (Z-A)"/>  <StrRes Name="4330" Te'+
'xt="������"/>  <StrRes Name="crStName" Text="!������ʽ��:"/>  <StrRes Name="crResize" Te'+
'xt="!���ý�����С,������&#38;#34;AutoSize&#38;#34;����Ϊ&#38;#34;False&#38;#34; ."/>  <StrR'+
'es Name="crSubtotal" Text="С��"/>  <StrRes Name="crNone" Text="��"/>  <StrRes Name'+
'="crSum" Text="�ϼ�"/>  <StrRes Name="crMin" Text="��Сֵ"/>  <StrRes Name="crMax" Te'+
'xt="���ֵ"/>  <StrRes Name="crAvg" Text="ƽ��ֵ"/>  <StrRes Name="crCount" Text="����"/'+
'>  <StrRes Name="crAsc" Text="A-Z"/>  <StrRes Name="crDesc" Text="Z-A"/>  <StrRe'+
's Name="crFillMx" Text="���뽻�汨����..."/>  <StrRes Name="crBuildMx" Text="�������汨����...'+
'"/>  <StrRes Name="4400" Text="����ʽ�༭��"/>  <StrRes Name="4401" Text="����ʽ:"/>  <St'+
'rRes Name="4500" Text="��ʾ��ʽ"/>  <StrRes Name="4501" Text="���"/>  <StrRes Name="4'+
'502" Text="��ʽ"/>  <StrRes Name="4503" Text="��ʽ�ִ�:"/>  <StrRes Name="4504" Text="'+
'С����ָ���Ԫ:"/>  <StrRes Name="fkText" Text="�ı� (δ��ʽ��)"/>  <StrRes Name="fkNumber" T'+
'ext="����"/>  <StrRes Name="fkDateTime" Text="����/ʱ��"/>  <StrRes Name="fkBoolean" T'+
'ext="����"/>  <StrRes Name="fkNumber1" Text="1234.5;%g"/>  <StrRes Name="fkNumber2'+
'" Text="1234.50;%2.2f"/>  <StrRes Name="fkNumber3" Text="1,234.50;%2.2n"/>  <Str'+
'Res Name="fkNumber4" Text="$1,234.50;%2.2m"/>  <StrRes Name="fkDateTime1" Text="'+
'11.28.2002;mm.dd.yyyy"/>  <StrRes Name="fkDateTime2" Text="28 nov 2002;dd mmm yy'+
'yy"/>  <StrRes Name="fkDateTime3" Text="November 28, 2002;mmmm dd, yyyy"/>  <Str'+
'Res Name="fkDateTime4" Text="02:14;hh:mm"/>  <StrRes Name="fkDateTime5" Text="02'+
':14am;hh:mm am/pm"/>  <StrRes Name="fkDateTime6" Text="02:14:00;hh:mm:ss"/>  <St'+
'rRes Name="fkDateTime7" Text="02:14am, November 28, 2002;hh:mm am/pm, mmmm dd, y'+
'yyy"/>  <StrRes Name="fkBoolean1" Text="0,1;0,1"/>  <StrRes Name="fkBoolean2" Te'+
'xt="No,Yes;No,Yes"/>  <StrRes Name="fkBoolean3" Text="_,x;_,x"/>  <StrRes Name="'+
'fkBoolean4" Text="False,True;False,True"/>  <StrRes Name="4600" Text="ͻ��"/>  <St'+
'rRes Name="4601" Text="��ɫ..."/>  <StrRes Name="4602" Text="��ɫ..."/>  <StrRes Nam'+
'e="4603" Text="����"/>  <StrRes Name="4604" Text="����"/>  <StrRes Name="4605" Text='+
'"����"/>  <StrRes Name="4606" Text="����"/>  <StrRes Name="4607" Text="б��"/>  <StrRe'+
's Name="4608" Text="����"/>  <StrRes Name="4609" Text="͸��"/>  <StrRes Name="4610" '+
'Text="����"/>  <StrRes Name="4700" Text="��������"/>  <StrRes Name="4701" Text="����"/> '+
' <StrRes Name="4702" Text="��ӡ������"/>  <StrRes Name="4703" Text="��ӡ����"/>  <StrRes '+
'Name="4704" Text="����"/>  <StrRes Name="4705" Text="����"/>  <StrRes Name="4706" Te'+
'xt="�Զ���ҳ"/>  <StrRes Name="4707" Text="�������"/>  <StrRes Name="4708" Text="�մ�ӡ"/>'+
'  <StrRes Name="4709" Text="����"/>  <StrRes Name="4710" Text="����"/>  <StrRes Name'+
'="4711" Text="����"/>  <StrRes Name="4712" Text="ͼ��"/>  <StrRes Name="4713" Text="'+
'����"/>  <StrRes Name="4714" Text="Major"/>  <StrRes Name="4715" Text="Minor"/>  <'+
'StrRes Name="4716" Text="Release"/>  <StrRes Name="4717" Text="Build"/>  <StrRes'+
' Name="4718" Text="����"/>  <StrRes Name="4719" Text="�޸�"/>  <StrRes Name="4720" T'+
'ext="����"/>  <StrRes Name="4721" Text="�汾"/>  <StrRes Name="4722" Text="���..."/> '+
' <StrRes Name="4723" Text="�̳�����"/>  <StrRes Name="4724" Text="ѡ��:"/>  <StrRes Na'+
'me="4725" Text="���ı�"/>  <StrRes Name="4726" Text="�����������"/>  <StrRes Name="4727"'+
' Text="�̳л�������:"/>  <StrRes Name="4728" Text="�̳�"/>  <StrRes Name="rePrnOnPort" T'+
'ext="��"/>  <StrRes Name="riNotInherited" Text="�����Ǽ̳е�."/>  <StrRes Name="riInhe'+
'rited" Text="�����Ǵӻ�������̳е�: %s"/>  <StrRes Name="4800" Text="�ִ��嵥"/>  <StrRes Name'+
'="4900" Text="SQL"/>  <StrRes Name="4901" Text="Query ����"/>  <StrRes Name="5000"'+
' Text="����"/>  <StrRes Name="5001" Text="��������:"/>  <StrRes Name="5100" Text="��ʽ�༭'+
'��"/>  <StrRes Name="5101" Text="��ɫ..."/>  <StrRes Name="5102" Text="����..."/>  <S'+
'trRes Name="5103" Text="���..."/>  <StrRes Name="5104" Text="����"/>  <StrRes Name='+
'"5105" Text="ɾ��"/>  <StrRes Name="5106" Text="�༭"/>  <StrRes Name="5107" Text="��'+
'��"/>  <StrRes Name="5108" Text="����"/>  <StrRes Name="5200" Text="���༭��"/>  <StrR'+
'es Name="5201" Text="���"/>  <StrRes Name="5202" Text="����"/>  <StrRes Name="5203"'+
' Text="��Ӱ"/>  <StrRes Name="5204" Text="����"/>  <StrRes Name="5205" Text="����"/>  '+
'<StrRes Name="5206" Text="����"/>  <StrRes Name="5207" Text="����"/>  <StrRes Name="'+
'5208" Text="�����"/>  <StrRes Name="5209" Text="�޿���"/>  <StrRes Name="5210" Text="'+
'�����ɫ"/>  <StrRes Name="5211" Text="�����ʽ"/>  <StrRes Name="5212" Text="�����"/>  <'+
'StrRes Name="5213" Text="��Ӱ"/>  <StrRes Name="5214" Text="��Ӱ��ɫ"/>  <StrRes Name='+
'"5215" Text="��Ӱ���"/>  <StrRes Name="5300" Text="����Ŀ"/>  <StrRes Name="5301" Text'+
'="��Ŀ"/>  <StrRes Name="5302" Text="ģ��"/>  <StrRes Name="5303" Text="�̳б���"/>  <St'+
'rRes Name="5400" Text="Tab������"/>  <StrRes Name="5401" Text="�������Tab������:"/>  <Str'+
'Res Name="5402" Text="����"/>  <StrRes Name="5403" Text="����"/>  <StrRes Name="5500'+
'" Text="��ֵ"/>  <StrRes Name="5501" Text="����ʽ"/>  <StrRes Name="5502" Text="���"/>'+
'  <StrRes Name="5600" Text="������"/>  <StrRes Name="5601" Text="����"/>  <StrRes Na'+
'me="5602" Text="Fields"/>  <StrRes Name="5603" Text="Ⱥ��"/>  <StrRes Name="5604" '+
'Text="��ʽ"/>  <StrRes Name="5605" Text="��ʽ"/>  <StrRes Name="5606" Text="��һ��:ѡ������'+
'��."/>  <StrRes Name="5607" Text="�ڶ���:ѡ����ʾ�ֶ�. "/>  <StrRes Name="5608" Text="������:'+
'��������(��ѡ). "/>  <StrRes Name="5609" Text="���Ĳ�:����ҳ��������ݲ���. "/>  <StrRes Name="5610'+
'" Text="���岽:ѡ�񱨱���ʽ."/>  <StrRes Name="5611" Text="���� &#62;"/>  <StrRes Name="561'+
'2" Text="ȫ������ &#62;&#62;"/>  <StrRes Name="5613" Text="&#60; �Ƴ�"/>  <StrRes Name'+
'="5614" Text="&#60;&#60; ȫ���Ƴ�"/>  <StrRes Name="5615" Text="���� &#62;"/>  <StrRes'+
' Name="5616" Text="&#60; �Ƴ�"/>  <StrRes Name="5617" Text="ѡȡ���ֶ�:"/>  <StrRes Nam'+
'e="5618" Text="���õ��ֶ�:"/>  <StrRes Name="5619" Text="Ⱥ��:"/>  <StrRes Name="5620" '+
'Text="����"/>  <StrRes Name="5621" Text="��ʽ"/>  <StrRes Name="5622" Text="����"/>  <'+
'StrRes Name="5623" Text="����"/>  <StrRes Name="5624" Text="���ʽ"/>  <StrRes Name="'+
'5625" Text="����ʽ"/>  <StrRes Name="5626" Text="�����ֶ���ҳ����"/>  <StrRes Name="5627" '+
'Text="&#60;&#60; ��һ��"/>  <StrRes Name="5628" Text="��һ�� &#62;&#62;"/>  <StrRes Na'+
'me="5629" Text="���"/>  <StrRes Name="5630" Text="�½���..."/>  <StrRes Name="5631" '+
'Text="�½���ѯ..."/>  <StrRes Name="5632" Text="ѡ�����ݿ�����:"/>  <StrRes Name="5633" Tex'+
't="ѡ���:"/>  <StrRes Name="5634" Text="��"/>  <StrRes Name="5635" Text="����һ����ѯ..."'+
'/>  <StrRes Name="5636" Text="��������"/>  <StrRes Name="wzStd" Text="��׼������"/>  <St'+
'rRes Name="wzDMP" Text="����󱨱���"/>  <StrRes Name="wzStdEmpty" Text="��׼����"/>  <St'+
'rRes Name="wzDMPEmpty" Text="����󱨱�"/>  <StrRes Name="5700" Text="������"/>  <StrRe'+
's Name="5701" Text="����"/>  <StrRes Name="5702" Text="ѡ����������:"/>  <StrRes Name="5'+
'703" Text="ѡ�����ݿ�:"/>  <StrRes Name="5704" Text="��¼"/>  <StrRes Name="5705" Text='+
'"����"/>  <StrRes Name="5706" Text="��¼��ʾ"/>  <StrRes Name="5707" Text="�û���¼��/����:"/'+
'>  <StrRes Name="5708" Text="��"/>  <StrRes Name="5709" Text="ѡ�����:"/>  <StrRes N'+
'ame="5710" Text="���˼�¼:"/>  <StrRes Name="5711" Text="��ѯ"/>  <StrRes Name="5712" '+
'Text="SQL���:"/>  <StrRes Name="5713" Text="��ѯ����"/>  <StrRes Name="5714" Text="�༭'+
'��ѯ����"/>  <StrRes Name="ftAllFiles" Text="�����ļ�"/>  <StrRes Name="ftPictures" Text'+
'="ͼƬ"/>  <StrRes Name="ftDB" Text="���ݿ�"/>  <StrRes Name="ftRichFile" Text="RichT'+
'ext �ļ�"/>  <StrRes Name="ftTextFile" Text="Text �ļ�"/>  <StrRes Name="prNotAssign'+
'ed" Text="(δ����)"/>  <StrRes Name="prInvProp" Text="��Ч����ֵ"/>  <StrRes Name="prDup'+
'l" Text="�ظ�������"/>  <StrRes Name="prPict" Text="(ͼƬ)"/>  <StrRes Name="mvExpr" Te'+
'xt="������ʽ"/>  <StrRes Name="mvStretch" Text="����"/>  <StrRes Name="mvStretchToMax'+
'" Text="���������߶�"/>  <StrRes Name="mvShift" Text="�л�"/>  <StrRes Name="mvShiftOve'+
'r" Text="�ص�ʱ�л�"/>  <StrRes Name="mvVisible" Text="�ɼ���"/>  <StrRes Name="mvPrinta'+
'ble" Text="�ɴ�ӡ��"/>  <StrRes Name="mvFont" Text="����..."/>  <StrRes Name="mvFormat'+
'" Text="��ʾ��ʽ..."/>  <StrRes Name="mvClear" Text="�������"/>  <StrRes Name="mvAutoWi'+
'dth" Text="�Զ����"/>  <StrRes Name="mvWWrap" Text="�Զ�����"/>  <StrRes Name="mvSuppre'+
'ss" Text="�����ظ�ֵ"/>  <StrRes Name="mvHideZ" Text="����0"/>  <StrRes Name="mvHTML" T'+
'ext="����HTML���"/>  <StrRes Name="lvDiagonal" Text="б�Ƶ�"/>  <StrRes Name="pvAutoSi'+
'ze" Text="�Զ���С"/>  <StrRes Name="pvCenter" Text="�м�"/>  <StrRes Name="pvAspect" '+
'Text="�����ݺ����"/>  <StrRes Name="bvSplit" Text="�����з�"/>  <StrRes Name="bvKeepChild'+
'" Text="Keep Child Together"/>  <StrRes Name="bvPrintChild" Text=" ���������ӡ Child"'+
'/>  <StrRes Name="bvStartPage" Text="��ʼ��ҳ��"/>  <StrRes Name="bvPrintIfEmpty" Tex'+
't="����ϸΪ��,��ӡ "/>  <StrRes Name="bvKeepDetail" Text="������ϸ����һ��"/>  <StrRes Name="bv'+
'KeepFooter" Text="���ֽ�ע����һ��"/>  <StrRes Name="bvReprint" Text="���µ�ҳ�����ش�ӡ"/>  <Str'+
'Res Name="bvOnFirst" Text="�ڵ�һҳ�ϴ�ӡ"/>  <StrRes Name="bvOnLast" Text="�����һҳ�ϴ�ӡ"/>'+
'  <StrRes Name="bvKeepGroup" Text="���־ۼ�"/>  <StrRes Name="bvFooterAfterEach" Tex'+
't="ÿ�к��ע"/>  <StrRes Name="bvDrillDown" Text="��ȡ"/>  <StrRes Name="bvResetPageNo'+
'" Text="����ҳ��"/>  <StrRes Name="srParent" Text="��Parent�ϴ�ӡ"/>  <StrRes Name="obCa'+
'tDraw" Text="����"/>  <StrRes Name="obCatOther" Text="��������"/>  <StrRes Name="obCat'+
'OtherControls" Text="�����ؼ�"/>  <StrRes Name="obDiagLine" Text="б��"/>  <StrRes Nam'+
'e="obRect" Text="����"/>  <StrRes Name="obRoundRect" Text="Բ��"/>  <StrRes Name="ob'+
'Ellipse" Text="��Բ"/>  <StrRes Name="obTrian" Text="����"/>  <StrRes Name="obDiamon'+
'd" Text="����"/>  <StrRes Name="obLabel" Text="�ı��ؼ�"/>  <StrRes Name="obEdit" Text'+
'="�༭�ؼ�"/>  <StrRes Name="obMemoC" Text="Memo�ؼ�"/>  <StrRes Name="obButton" Text='+
'"��ť�ؼ�"/>  <StrRes Name="obChBoxC" Text="��ѡ��ؼ�"/>  <StrRes Name="obRButton" Text='+
'"��ѡ��ؼ�"/>  <StrRes Name="obLBox" Text="�б��ؼ�"/>  <StrRes Name="obCBox" Text="Com'+
'bo��ؼ�"/>  <StrRes Name="obDateEdit" Text="���ڿؼ�"/>  <StrRes Name="obImageC" Text='+
'"ͼ��ؼ�"/>  <StrRes Name="obPanel" Text="���ؼ�"/>  <StrRes Name="obGrBox" Text="����'+
'��"/>  <StrRes Name="obBBtn" Text="BitBtn�ؼ�"/>  <StrRes Name="obSBtn" Text="Speed'+
'Button�ؼ�"/>  <StrRes Name="obMEdit" Text="����༭��ؼ�"/>  <StrRes Name="obChLB" Text'+
'="��ѡ�б��ؼ�"/>  <StrRes Name="obDBLookup" Text="���ݲ�ѯCombo�ؼ�"/>  <StrRes Name="obBe'+
'vel" Text="Bevel����"/>  <StrRes Name="obShape" Text="��״����"/>  <StrRes Name="obTex'+
't" Text="�ı�����"/>  <StrRes Name="obSysText" Text="ϵͳ�ı�"/>  <StrRes Name="obLine" '+
'Text="���Ͷ���"/>  <StrRes Name="obPicture" Text="ͼƬ����"/>  <StrRes Name="obBand" Tex'+
't="Band����"/>  <StrRes Name="obDataBand" Text="���ݶ���"/>  <StrRes Name="obSubRep" T'+
'ext="�ӱ������"/>  <StrRes Name="obDlgPage" Text="�Ի����"/>  <StrRes Name="obRepPage"'+
' Text="����ҳ��"/>  <StrRes Name="obReport" Text="�������"/>  <StrRes Name="obRich" Tex'+
't="rich�ı�����"/>  <StrRes Name="obOLE" Text="OLE����"/>  <StrRes Name="obChBox" Text'+
'="��ѡ�����"/>  <StrRes Name="obChart" Text="ͼ�����"/>  <StrRes Name="obBarC" Text="����'+
'�����"/>  <StrRes Name="obCross" Text="��������"/>  <StrRes Name="obDBCross" Text="DB'+
' ��������"/>  <StrRes Name="obGrad" Text="����ɫ����"/>  <StrRes Name="obDMPText" Text="'+
'�����ı�����"/>  <StrRes Name="obDMPLine" Text="�������Ͷ���"/>  <StrRes Name="obDMPCmd" Tex'+
't="�����������"/>  <StrRes Name="obBDEDB" Text="BDE���ݿ�"/>  <StrRes Name="obBDETb" Tex'+
't="BDE��"/>  <StrRes Name="obBDEQ" Text="BDE��ѯ"/>  <StrRes Name="obBDEComps" Text'+
'="BDE���"/>  <StrRes Name="obIBXDB" Text="IBX���ݿ�"/>  <StrRes Name="obIBXTb" Text='+
'"IBX��"/>  <StrRes Name="obIBXQ" Text="IBX��ѯ"/>  <StrRes Name="obIBXComps" Text="'+
'IBX���"/>  <StrRes Name="obADODB" Text="ADO���ݿ�"/>  <StrRes Name="obADOTb" Text="A'+
'DO��"/>  <StrRes Name="obADOQ" Text="ADO��ѯ"/>  <StrRes Name="obADOComps" Text="AD'+
'O���"/>  <StrRes Name="obDBXDB" Text="DBX���ݿ�"/>  <StrRes Name="obDBXTb" Text="DBX'+
'��"/>  <StrRes Name="obDBXQ" Text="DBX��ѯ"/>  <StrRes Name="obDBXComps" Text="DBX��'+
'��"/>  <StrRes Name="obFIBDB" Text="FIB���ݿ�"/>  <StrRes Name="obFIBTb" Text="FIB��"'+
'/>  <StrRes Name="obFIBQ" Text="FIB��ѯ"/>  <StrRes Name="obFIBComps" Text="FIB���"'+
'/>  <StrRes Name="ctString" Text="��"/>  <StrRes Name="ctDate" Text="���ں�ʱ��"/>  <S'+
'trRes Name="ctConv" Text="ת��"/>  <StrRes Name="ctFormat" Text="��ʽ��"/>  <StrRes N'+
'ame="ctMath" Text="��ѧ"/>  <StrRes Name="ctOther" Text="����"/>  <StrRes Name="IntT'+
'oStr" Text="����ֵת��Ϊ��"/>  <StrRes Name="FloatToStr" Text="������ֵת��Ϊ��"/>  <StrRes Nam'+
'e="DateToStr" Text="������ֵת��Ϊ��"/>  <StrRes Name="TimeToStr" Text="ʱ����ֵת��Ϊ��"/>  <St'+
'rRes Name="DateTimeToStr" Text="������ֵת��Ϊ��"/>  <StrRes Name="VarToStr" Text="varia'+
'ntת��Ϊ��"/>  <StrRes Name="StrToInt" Text="��ת��Ϊ����ֵ"/>  <StrRes Name="StrToInt64" T'+
'ext="��ת��ΪInt64ֵ"/>  <StrRes Name="StrToFloat" Text="��ת��Ϊ����ֵ"/>  <StrRes Name="St'+
'rToDate" Text="��ת��Ϊ���ڸ�ʽ"/>  <StrRes Name="StrToTime" Text="��ת��Ϊʱ���ʽ"/>  <StrRes '+
'Name="StrToDateTime" Text="��ת��Ϊ����-ʱ���ʽ"/>  <StrRes Name="Format" Text="��һϵ�����������'+
'�ظ�ʽ������"/>  <StrRes Name="FormatFloat" Text="��ʽ������ֵ"/>  <StrRes Name="FormatDateT'+
'ime" Text="��ʽ������-ʱ��ֵ"/>  <StrRes Name="FormatMaskText" Text="������༭����һ����ʽ����"/>  <'+
'StrRes Name="EncodeDate" Text="��ָ�����ꡢ�¡��շ�����������"/>  <StrRes Name="DecodeDate" Tex'+
't="�ֽ���������ֵΪ�ꡢ�¡���ֵ"/>  <StrRes Name="EncodeTime" Text="��ָ����ʱ���֡��뷵��ʱ������"/>  <StrRe'+
's Name="DecodeTime" Text="�ֽ�ʱ������ֵΪʱ���֡���ֵ"/>  <StrRes Name="Date" Text="���ص�ǰ����"/>'+
'  <StrRes Name="Time" Text="���ص�ǰʱ��"/>  <StrRes Name="Now" Text="���ص�ǰ���ں�ʱ��"/>  <S'+
'trRes Name="DayOfWeek" Text="����ָ�����ڵ�����"/>  <StrRes Name="IsLeapYear" Text="ָʾָ����'+
'���Ƿ�����"/>  <StrRes Name="DaysInMonth" Text="����ָ���µ�����"/>  <StrRes Name="Length" Te'+
'xt="���ش�����"/>  <StrRes Name="Copy" Text="����һ�������Ӵ�"/>  <StrRes Name="Pos" Text="����'+
'һ�������Ӵ�����ʼλ��"/>  <StrRes Name="Delete" Text="�Ӵ����Ƴ��Ӵ�"/>  <StrRes Name="Insert" Te'+
'xt="�ڴ��в����Ӵ�"/>  <StrRes Name="Uppercase" Text="ת�����е������ַ�Ϊ��д"/>  <StrRes Name="Lo'+
'wercase" Text="ת�����е������ַ�ΪСд"/>  <StrRes Name="Trim" Text="ȥ�������ײ���β���ո�"/>  <StrRe'+
's Name="NameCase" Text="ת��һ�����ʵ����ַ�Ϊ��д"/>  <StrRes Name="CompareText" Text="�Ƚ�������'+
'"/>  <StrRes Name="Chr" Text="����ֵת��Ϊ�ַ���"/>  <StrRes Name="Ord" Text="�ַ�ֵת��Ϊ����"/>'+
'  <StrRes Name="SetLength" Text="���ô�����"/>  <StrRes Name="Round" Text="���������뵽��ӽ���'+
'����ֵ"/>  <StrRes Name="Trunc" Text="��������βΪһ������"/>  <StrRes Name="Int" Text="����ʵ�͵�'+
'��������"/>  <StrRes Name="Frac" Text="����ʵ�͵�С������"/>  <StrRes Name="Sqrt" Text="����ָ����'+
'ֵ��ƽ����"/>  <StrRes Name="Abs" Text="���ؾ���ֵ"/>  <StrRes Name="Sin" Text="���ؽǶ�(���ȸ�ʽ)'+
'������ֵ"/>  <StrRes Name="Cos" Text="���ؽǶ�(���ȸ�ʽ)������ֵ"/>  <StrRes Name="ArcTan" Text='+
'"�õ�������ֵ"/>  <StrRes Name="Tan" Text="��������ֵ"/>  <StrRes Name="Exp" Text="����ָ��ֵ"/>'+
'  <StrRes Name="Ln" Text="����ʵ�ͱ��ʽ����Ȼ����ֵ"/>  <StrRes Name="Pi" Text="����Բ����3.14159'+
'26...��ֵ"/>  <StrRes Name="Inc" Text="����ֵ"/>  <StrRes Name="Dec" Text="����ֵ"/>  <S'+
'trRes Name="RaiseException" Text="�����쳣"/>  <StrRes Name="ShowMessage" Text="��ʾ��Ϣ'+
'��"/>  <StrRes Name="Randomize" Text="��ʼ�����������"/>  <StrRes Name="Random" Text="����'+
'�����"/>  <StrRes Name="ValidInt" Text="���ָ���Ĵ�����һ����Ч������������ True "/>  <StrRes Name='+
'"ValidFloat" Text="���ָ���Ĵ�����һ����Ч�ĸ����������� True "/>  <StrRes Name="ValidDate" Text="'+
'���ָ���Ĵ�����һ����Ч������ֵ������ True "/>  <StrRes Name="IIF" Text="������ʽΪ�棬���� True, ���򷵻� Fal'+
'se "/>  <StrRes Name="Get" Text="���ڲ�ʹ��"/>  <StrRes Name="Set" Text="���ڲ�ʹ��"/>  <S'+
'trRes Name="InputBox" Text="��ʾ����Ի����Ա��û����봮"/>  <StrRes Name="InputQuery" Text="'+
'��ʾ����Ի����Ա��û����봮"/>  <StrRes Name="MessageDlg" Text="��ʾ��Ϣ��"/>  <StrRes Name="Crea'+
'teOleObject" Text="����һ��OLE ����"/>  <StrRes Name="VarArrayCreate" Text="����һ�� varia'+
'nt ����"/>  <StrRes Name="VarType" Text="����һ��variantֵ������"/>  <StrRes Name="DayOf" '+
'Text="���ظ������ڵ�����(1..31) "/>  <StrRes Name="MonthOf" Text="���ظ������ڵ��·�(1..12)"/>  <S'+
'trRes Name="YearOf" Text="���ظ������ڵ����"/>  <StrRes Name="wzDBConn" Text="�½�������"/> '+
' <StrRes Name="wzDBTable" Text="�½�����"/>  <StrRes Name="wzDBQuery" Text="�½���ѯ��"'+
'/>  <StrRes Name="5800" Text="����"/>  <StrRes Name="5801" Text="�½�"/>  <StrRes Na'+
'me="5802" Text="ɾ��"/>  <StrRes Name="cpName" Text="����"/>  <StrRes Name="cpConnSt'+
'r" Text="���Ӵ�"/>  <StrRes Name="ctAggregate" Text="�ۺ�"/>  <StrRes Name="Sum" Text'+
'="����band�����е���ͱ��ʽ"/>  <StrRes Name="Avg" Text="����band�����е���ƽ��ֵ��ʽ"/>  <StrRes Name'+
'="Min" Text="����band�����е�����Сֵ���ʽ"/>  <StrRes Name="Max" Text="����band�����е������ֵ���ʽ"/>'+
'  <StrRes Name="Count" Text="����band�����е�����"/>  <StrRes Name="bvKeepHeader" Text="'+
'����ͷ���ۺ�"/>  <StrRes Name="startCreateNew" Text="�����±���"/>  <StrRes Name="startCrea'+
'teBlank" Text="�����ձ���"/>  <StrRes Name="startOpenReport" Text="�򿪱���"/>  <StrRes N'+
'ame="startOpenLast" Text="������ı���"/>  <StrRes Name="startEditAliases" Text="�༭����'+
'����"/>  <StrRes Name="startHelp" Text="����"/>  <StrRes Name="5900" Text="����"/>  <S'+
'trRes Name="5901" Text="��Ӽ���"/>  <StrRes Name="5902" Text="ɾ������"/>  <StrRes Name'+
'="5903" Text="�༭����"/>  <StrRes Name="6000" Text="�̳д���"/>  <StrRes Name="6001" Te'+
'xt="�����ͼ̳еı������ظ��Ķ��󡣸���ô��?"/>  <StrRes Name="6002" Text="ɾ���ظ�����"/>  <StrRes Name="'+
'6003" Text="�������ظ�����"/></Resources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
