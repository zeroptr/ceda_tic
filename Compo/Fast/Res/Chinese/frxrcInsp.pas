unit frxrcInsp;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="936">  <StrRes Name="'+
'propActive" Text="�����Ƿ�����ݿ�(DataSet)��"/>  <StrRes Name="propActive.TfrxHighlight'+
'" Text="�Ƿ������������ܡ�"/>  <StrRes Name="propAliasName" Text="BDE ����(alias)��"/>  <Str'+
'Res Name="propAlign" Text="����������Band��page���롣"/>  <StrRes Name="propAlignment" Te'+
'xt="�����ı��Ķ��뷽ʽ��"/>  <StrRes Name="propAllowAllUp" Text="ͬȺ��ĵĿ��ٰ�ť�Ƿ��ͬʱȡ��ѡȡ��"/>  <'+
'StrRes Name="propAllowEdit" Text="ʹ�����Ƿ���Ա༭Ԥ���еı���"/>  <StrRes Name="propAllowEx'+
'pressions" Text="�����ı������Ƿ���԰�������ʽ��"/>  <StrRes Name="propAllowGrayed" Text="����ѡ��'+
'���ֻ�ɫ��״̬��"/>  <StrRes Name="propAllowHTMLTags" Text="�����ı�����������Ƿ��ʹ�� HTML ��ǩ��"/>  '+
'<StrRes Name="propAllowSplit" Text="����ҳ��������Ƿ�ɿ�ҳ��ӡ��"/>  <StrRes Name="propAuthor'+
'" Text="�������ߡ�"/>  <StrRes Name="propAutoSize.TfrxPictureView" Text="�����Ƿ��Զ�����ͼ��Ĵ�'+
'С��"/>  <StrRes Name="propAutoWidth" Text="�����Ƿ��Զ������ı��Ŀ�ȡ�"/>  <StrRes Name="propB'+
'ackPicture" Text="����ҳ��ı���ͼ��"/>  <StrRes Name="propBarType" Text="��������͡�"/>  <Str'+
'Res Name="propBevelInner" Text="bevel�ڲ������͡�"/>  <StrRes Name="propBevelOuter" Te'+
'xt="bevel�ⲿ�����͡�"/>  <StrRes Name="propBevelWidth" Text="bevel�Ŀ�ȡ�"/>  <StrRes Na'+
'me="propBorder" Text="�����Ƿ���ʾ���"/>  <StrRes Name="propBorderStyle" Text="�Ӵ�����ʽ��"'+
'/>  <StrRes Name="propBottomMargin" Text="ҳ���·��ı߾ࡣ"/>  <StrRes Name="propBrushSt'+
'yle" Text="���󱳾��Ļ�����ʽ��"/>  <StrRes Name="propCalcCheckSum" Text="�Զ���������ļ���롣"/>  '+
'<StrRes Name="propCancel" Text="����������Esc��ʱ���˰�ť��  ������"/>  <StrRes Name="propCapti'+
'on" Text="������ı��⡣"/>  <StrRes Name="propCellFields" Text="���汨�����ݿ��ֶ����ơ�"/>  <StrR'+
'es Name="propCellLevels" Text="���汨��Ľײ�����"/>  <StrRes Name="propCenter" Text="Ӱ���'+
'�С�"/>  <StrRes Name="propCharset" Text="��Ԫ����"/>  <StrRes Name="propCharSpacing" '+
'Text="������Ԫ��ļ�࣬������(Pixels)��ʾ����"/>  <StrRes Name="propCheckColor" Text="��ѡ��ѡ״̬����'+
'ɫ��"/>  <StrRes Name="propChecked" Text="������Ĺ�ѡ״̬��"/>  <StrRes Name="propCheckSty'+
'le" Text="��ѡ��ѡ����ʽ��"/>  <StrRes Name="propChild" Text="��������band��Child Band���ơ�"/>'+
'  <StrRes Name="propClipped" Text="ȷ���Ƿ�Ӧ��ʡ�Զ���Χ�ڵ��ı�"/>  <StrRes Name="propCollat'+
'e" Text="Ԥ������˳������"/>  <StrRes Name="propColor.TFont" Text="�ı�����ɫ��"/>  <StrRes N'+
'ame="propColor" Text="�������ɫ��"/>  <StrRes Name="propColor.TfrxFrame" Text="���(Fra'+
'me)����ɫ"/>  <StrRes Name="propColor.TfrxHighlight" Text="����������Զ���ʱ������������ʾ����ɫ��"/> '+
' <StrRes Name="propColumnFields" Text="���汨����ֶ����ơ�"/>  <StrRes Name="propColumnGa'+
'p" Text="�����"/>  <StrRes Name="propColumnLevels" Text="���Ľײ�����"/>  <StrRes Name="'+
'propColumns" Text="���ĸ�����"/>  <StrRes Name="propColumnWidth" Text="Band���п�ȡ�"/>  '+
'<StrRes Name="propCondition" Text="Ⱥ�����������������ʽ��ֵ�ı䣬Ⱥ���Զ��ı䡣"/>  <StrRes Name="pro'+
'pCondition.TfrxHighlight" Text="����ʽ�ִ�����������ʽΪ��(True)����Ŀ����ʾ�Ͻ���������"/>  <StrRes Name'+
'="propConnected" Text="�����Ƿ��������ݿ⡣"/>  <StrRes Name="propConvertNulls" Text="�Ƿ��Զ�'+
'��Nullת�� 0, False �� ���ִ���"/>  <StrRes Name="propCopies" Text="Ԥ�豨���ӡ������"/>  <StrRe'+
's Name="propCursor" Text="������αꡣ"/>  <StrRes Name="propDatabaseName" Text="���ݿ�����'+
'��"/>  <StrRes Name="propDataField" Text="ץȡ���ݿ���ֶ����ơ�"/>  <StrRes Name="propDataS'+
'et" Text="���������ݿ⡣"/>  <StrRes Name="propDate" Text="�����������ֵ��"/>  <StrRes Name="p'+
'ropDateFormat" Text="���������ʽ��"/>  <StrRes Name="propDecimalSeparator" Text="С����ķ�'+
'����Ԫ��"/>  <StrRes Name="propDefault" Text="�����˰�ť�Ƿ�ΪԤ�谴ť��"/>  <StrRes Name="propDe'+
'fHeight" Text="Ԥ���иߡ�"/>  <StrRes Name="propDescription.TfrxReportOptions" Text="'+
'������;����"/>  <StrRes Name="propDescription" Text="���������"/>  <StrRes Name="propDiag'+
'onal" Text="������ָ��Ϊб�ߡ�"/>  <StrRes Name="propDisplayFormat" Text="������ʾ��ʽ��"/>  <St'+
'rRes Name="propDoublePass" Text="�������������Ƿ�ִ�ж��δ���"/>  <StrRes Name="propDown" Tex'+
't="������ť�Ƿ��ѱ����¡�"/>  <StrRes Name="propDownThenAcross" Text="ָ������ʽ��������϶��£��������Ҵ�ӡ��"'+
'/>  <StrRes Name="propDriverName" Text="BDE�����������ơ�"/>  <StrRes Name="propDropSha'+
'dow" Text="���������Ƿ�����Ӱ��"/>  <StrRes Name="propDuplex" Text="˫���ӡģʽ��"/>  <StrRes Na'+
'me="propEditMask" Text="����༭���֡�"/>  <StrRes Name="propEnabled" Text="�����������Ƿ�ɶ�����'+
'"/>  <StrRes Name="propEngineOptions" Text="���������ѡ�"/>  <StrRes Name="propExpre'+
'ssion" Text="���������ʽ��"/>  <StrRes Name="propExpressionDelimiters" Text="����ʽ�ķָ���Ԫ��'+
'"/>  <StrRes Name="propFieldAliases" Text="���ݿ��ֶεı�����"/>  <StrRes Name="propFilte'+
'r" Text="���ݿ�Ĺ���������"/>  <StrRes Name="propFiltered" Text="���� Filter ���������Ƿ�������"/> '+
' <StrRes Name="propFlowTo" Text="�ı������޷�����ʱ����ʾ����������"/>  <StrRes Name="propFont" '+
'Text="������������ԡ�"/>  <StrRes Name="propFooterAfterEach" Text="�����Ƿ���ÿ��������֮�󣬸��Ŵ�ӡ��ע '+
'band��"/>  <StrRes Name="propFormatStr" Text="�����ʽ�༭�ִ���"/>  <StrRes Name="propFra'+
'me" Text="����Ŀ�����ԡ�"/>  <StrRes Name="propGapX" Text="�ı�����߶��롣"/>  <StrRes Name="'+
'propGapY" Text="�ı���������롣"/>  <StrRes Name="propGlyph" Text="�������Ӱ��"/>  <StrRes '+
'Name="propGroupIndex" Text="������ٰ�ť��ΪͬһȺ�顣"/>  <StrRes Name="propHAlign" Text="�ı�'+
'ˮƽ���뷽ʽ��"/>  <StrRes Name="propHeight" Text="����ĸ߶ȡ�"/>  <StrRes Name="propHideZer'+
'os" Text="����ǰ��� 0 ����ʾ��"/>  <StrRes Name="propHighlight" Text="�������Ե�������"/>  <StrR'+
'es Name="propIndexName" Text="�������ơ�"/>  <StrRes Name="propInitString" Text="�������'+
'����ʹ�õĴ�ӡ����ʼ�ִ���"/>  <StrRes Name="propItems" Text="������嵥��Ŀ"/>  <StrRes Name="propK'+
'eepAspectRatio" Text="����Ӱ�����ʾ����"/>  <StrRes Name="propKeepChild" Text="����Band�Ƿ���'+
'Child��ӡ��һ��"/>  <StrRes Name="propKeepFooter" Text="�Ƿ����ע��ӡ��һ��"/>  <StrRes Name="'+
'propKeepTogether" Text="����band��subbandһ���ӡ"/>  <StrRes Name="propKind.TfrxFormat'+
'" Text="��ʽ����"/>  <StrRes Name="propKind" Text="��ť����"/>  <StrRes Name="propLargeD'+
'esignHeight" Text="��Ʊ���ҳ������߶�"/>  <StrRes Name="propLayout" Text="��ťͼ�εĸ�ʽ"/>  <'+
'StrRes Name="propLeft" Text="������������"/>  <StrRes Name="propLeftMargin" Text="��߾�'+
'�Ĵ�С"/>  <StrRes Name="propLines" Text="������ı�"/>  <StrRes Name="propLineSpacing" '+
'Text="�о�"/>  <StrRes Name="propLoginPrompt" Text="��ʾ�����Ӵ�"/>  <StrRes Name="propM'+
'argin" Text="��ťͼ����߾�ľ���(����)"/>  <StrRes Name="propMaster" Text="�����ݿ�"/>  <StrRes'+
' Name="propMasterFields" Text="����������ϸ���ݹ������ֶ�"/>  <StrRes Name="propMaxLength" Te'+
'xt="�ı�����󳤶�"/>  <StrRes Name="propMaxWidth" Text="�������"/>  <StrRes Name="propMem'+
'o" Text="������ı�"/>  <StrRes Name="propMinWidth" Text="������С���"/>  <StrRes Name="pr'+
'opMirrorMargins" Text="����ҳ��߾���ż��ҳ"/>  <StrRes Name="propModalResult" Text="Modal'+
'�Ӵ��ر�ʱ���ص�ֵ"/>  <StrRes Name="propName.TFont" Text="��������"/>  <StrRes Name="propNam'+
'e.TfrxReportOptions" Text="��������"/>  <StrRes Name="propName" Text="��������"/>  <StrR'+
'es Name="propNumGlyphs" Text="Glyph������ͼ�ε���Ŀ"/>  <StrRes Name="propOpenDataSource'+
'" Text="�����Ƿ��Զ���������Դ"/>  <StrRes Name="propOrientation" Text="����ҳ��ķ���"/>  <StrRe'+
's Name="propOutlineText" Text="��ʾ�ڱ����ٶ�����ı�"/>  <StrRes Name="propOutlineVisible'+
'" Text="��ʾԤ�����"/>  <StrRes Name="propOutlineWidth" Text="�����ٵĿ��"/>  <StrRes Nam'+
'e="propPageNumbers.TfrxPrintOptions" Text="��ӡ��ҳ��"/>  <StrRes Name="propPaperHeig'+
'ht" Text="ҳ�ĸ߶�"/>  <StrRes Name="propPaperWidth" Text="ҳ�Ŀ��"/>  <StrRes Name="pr'+
'opParagraphGap" Text="������������"/>  <StrRes Name="propParams.TfrxBDEDatabase" Text='+
'"BDE���ݿ����Ӳ���"/>  <StrRes Name="propParams" Text="��ѯ�Ĳ���"/>  <StrRes Name="propPare'+
'ntFont" Text="���������Ƿ���ʾ�ϲ�������������"/>  <StrRes Name="propPassword" Text="��������"/>  <'+
'StrRes Name="propPasswordChar" Text="�����ֶ�����ʱ��ʾ����Ԫ"/>  <StrRes Name="propPicture"'+
' Text="ͼ��"/>  <StrRes Name="propPicture.TfrxReportOptions" Text="����ͼ��"/>  <StrRe'+
's Name="propPosition" Text="�Ӵ��ĳ�ʼλ��"/>  <StrRes Name="propPreviewOptions" Text="'+
'����Ԥ��ѡ��"/>  <StrRes Name="propPrintable" Text="�����Ƿ�ɴ�ӡ"/>  <StrRes Name="propPrin'+
'tChildIfInvisible" Text="����parent band����ӡ������child band�Ƿ��ӡ"/>  <StrRes Name="pro'+
'pPrinter" Text="����Ԥ��Ĵ�ӡ������"/>  <StrRes Name="propPrintIfDetailEmpty" Text="����sub'+
'nband�ǿյģ������Ƿ��ӡ"/>  <StrRes Name="propPrintIfEmpty" Text="���籨�����ݿ��ǿյģ������Ƿ������ӡ"/>'+
'  <StrRes Name="propPrintOnFirstPage" Text="����Band�Ƿ��ӡ����ҳ"/>  <StrRes Name="prop'+
'PrintOnLastPage" Text="����Band�Ƿ��ӡ��ĩҳ"/>  <StrRes Name="propPrintOnParent" Text="'+
'�����ӱ����Ƿ��ӡ���ϲ��  nd"/>  <StrRes Name="propPrintOnPreviousPage" Text="������ҳ�Ƿ�ɴ�ӡ����ҳ��'+
'ʣ��ռ�"/>  <StrRes Name="propPrintOptions" Text="�����ӡѡ�"/>  <StrRes Name="propPri'+
'ntPages" Text="������ӡȫ���ı�������ҳ��ż��ҳ��"/>  <StrRes Name="propRangeBegin" Text="��ӡ���ݿ��'+
'��㡣"/>  <StrRes Name="propRangeEnd" Text="��ӡ���ݿ���յ㡣"/>  <StrRes Name="propRangeE'+
'ndCount" Text="������ӡ������"/>  <StrRes Name="propReadOnly" Text="�����ı������Ƿ�Ψ����"/>  <St'+
'rRes Name="propRepeatHeaders" Text="����ҳ���Ƿ��ӡ��ÿ���µ�ҳ�档"/>  <StrRes Name="propRepor'+
'tOptions" Text="����ѡ�"/>  <StrRes Name="propReprintOnNewPage" Text="�����Ƿ����´�ӡ����һҳ'+
'"/>  <StrRes Name="propRestrictions" Text="����������ꡣ"/>  <StrRes Name="propRightMa'+
'rgin" Text="�ұ߾ࡣ"/>  <StrRes Name="propRotation.TfrxBarCodeView" Text="���뷽��"/>  '+
'<StrRes Name="propRotation" Text="��ת�ı�"/>  <StrRes Name="propRowCount" Text="Dat'+
'aband���������ݱ�����"/>  <StrRes Name="propRowFields" Text="���汨���е����ݿ��ֶ�����"/>  <StrRes N'+
'ame="propRowLevels" Text="�нײ����Ŀ"/>  <StrRes Name="propRTLReading" Text="�����ı�������'+
'������������ʾ"/>  <StrRes Name="propSessionName" Text="BDE �������ơ�"/>  <StrRes Name="pro'+
'pShadowColor" Text="��Ӱ����ɫ��"/>  <StrRes Name="propShadowWidth" Text="��Ӱ�Ŀ�ȡ�"/>  <'+
'StrRes Name="propShape" Text="���͵���ʽ"/>  <StrRes Name="propShiftMode" Text="����䶯��'+
'��Ϊ"/>  <StrRes Name="propShowColumnHeader" Text="�������汨���Ƿ���ʾ�ֶα�ͷ"/>  <StrRes Name'+
'="propShowColumnTotal" Text="�������汨���Ƿ���ʾ�ֶ��ܼ�"/>  <StrRes Name="propShowRowHeader"'+
' Text="�������汨���Ƿ���ʾ�еı�ͷ"/>  <StrRes Name="propShowRowTotal" Text="�������汨���Ƿ���ʾ�е��ܼ�"/'+
'>  <StrRes Name="propShowDialog" Text="������ӡ�Ի����Ƿ������Ԥ���Ӵ�"/>  <StrRes Name="propSh'+
'owText" Text="������������Ƿ���ʾ�ı�˵��"/>  <StrRes Name="propSize" Text="�����С��"/>  <StrRes'+
' Name="propSorted" Text="��Ŀ�Ƿ�Ҫ����"/>  <StrRes Name="propSpacing" Text="�ı���Ӱ��������'+
'(Pixels)��ࡣ"/>  <StrRes Name="propSQL" Text="SQL����"/>  <StrRes Name="propStartNe'+
'wPage" Text="�ڴ�ӡBand֮ǰ����ִ����ҳ������"/>  <StrRes Name="propStretch" Text="����ͼ��������Ĵ�С��'+
'"/>  <StrRes Name="propStretched" Text="�����������������"/>  <StrRes Name="propStretchM'+
'ode" Text="������������Ϊ��"/>  <StrRes Name="propStyle.TFont" Text="������ʽ��"/>  <StrRes N'+
'ame="propStyle" Text="��������ʽ��"/>  <StrRes Name="propStyle.TfrxFrame" Text="����Ŀ����'+
'ʽ��"/>  <StrRes Name="propSuppressRepeated" Text="ɾ���ظ���ֵ(�ظ���ֵ����ӡ)��"/>  <StrRes Na'+
'me="propTableName" Text="���ݱ����ơ�"/>  <StrRes Name="propTag" Text="��������ֱ�ǩ"/>  <St'+
'rRes Name="propTagStr" Text="������ִ���ǩ��"/>  <StrRes Name="propText" Text="������ı���"/'+
'>  <StrRes Name="propTitleBeforeHeader" Text="�����Ƿ���ҳ��ǰ��ʾ����̧ͷ��"/>  <StrRes Name="'+
'propTop" Text="�����Ϸ������ꡣ"/>  <StrRes Name="propTopMargin" Text="ҳ����ֽ����Ե�ı߾ࡣ"/>  <'+
'StrRes Name="propTyp" Text="��ܵ����͡�"/>  <StrRes Name="propUnderlines" Text="�����ı���'+
'����ÿһ��֮����ʾ���ߡ�"/>  <StrRes Name="propURL" Text="��������� URL λַ��"/>  <StrRes Name="pr'+
'opUserName" Text="���ݶ����ʹ�������ƣ������ƽ���ʾ��������״�ṹ��"/>  <StrRes Name="propVAlign" Text="'+
'�ı���ֱ���뷽ʽ��"/>  <StrRes Name="propVersionBuild" Text="�汾���"/>  <StrRes Name="propV'+
'ersionMajor" Text="�汾���, ���汾��š�"/>  <StrRes Name="propVersionMinor" Text="�汾��ţ���'+
'�汾��š�"/>  <StrRes Name="propVersionRelease" Text="�汾������Ϣ��"/>  <StrRes Name="prop'+
'Visible" Text="����ɼ���"/>  <StrRes Name="propWidth" Text="�����ȡ�"/>  <StrRes Name="'+
'propWidth.TfrxFrame" Text="��ܿ�ȡ�"/>  <StrRes Name="propWindowState" Text="�Ӵ���ʼ״̬'+
'��"/>  <StrRes Name="propWordBreak" Text="����"/>  <StrRes Name="propWordWrap" Text'+
'="�ı��Ƿ��Զ����С�"/>  <StrRes Name="propZoom.TfrxBarCodeView" Text="������ʾ����"/>  <StrRes'+
' Name="propKeepHeader" Text="ȷ��band�Ƿ������ͷ����ӡ��һ��"/>  <StrRes Name="propConnection'+
'Name" Text="������ʹ�õ����ݿ���������"/>  <StrRes Name="propCurve" Text="�̻�Բ��ı�"/>  <StrRes '+
'Name="propDrillDown" Text="ȷ�������ܷ���ȡ"/>  <StrRes Name="propFontStyle" Text="����������'+
'ʽ"/>  <StrRes Name="propHideIfSingleDataRecord" Text="�����ֻ��һ����¼�����ؽ�ע"/>  <StrRes'+
' Name="propOutlineExpand" Text="ȷ���Ƿ�չ��������"/>  <StrRes Name="propPlainCells" Tex'+
't="ȷ���Ƿ��ӡ���Ż����һ��ĵ�Ԫ��"/>  <StrRes Name="propPrintMode" Text="��ӡģʽ: ����, �зִ�ҳ��Сҳ, ��'+
'���ڴ�ҳ�ϴ�ӡ����Сҳ"/>  <StrRes Name="propPrintOnSheet" Text="ֽ�Ĵ�С��Ϊ�ʺϱ���Ĵ�ӡ��. ���ʹ�ô�ӡģʽ����'+
'pmDefault,��ʹ�ø÷�ʽ"/>  <StrRes Name="propResetPageNumbers" Text="��ӡ��ʱ, ����ҳ��/ȫ��ҳ��. '+
'Ӧ����StartNewPageѡ����Ϊ���ʱ��ʹ��"/>  <StrRes Name="propReverse" Text="ȷ���Ƿ�ת��ӡҳ"/>  <St'+
'rRes Name="propShowFooterIfDrillDown" Text="ȷ���Ƿ���ʾ��ȡ�����ע"/>  <StrRes Name="propS'+
'izeMode" Text="��ʾOLE�����ģʽ"/>  <StrRes Name="propVersion" Text="FastReport�İ汾"/> '+
' <StrRes Name="propWideBarRatio" Text="���������wide bars�й�"/>  <StrRes Name="propWy'+
'siwyg" Text="ȷ��rich�����Ƿ��ô�ӡ��������ʽ���ı�.Ӧ���Ѿ���װ\׼����һ̨��ӡ��"/>  <StrRes Name="propArrowEn'+
'd" Text="ȷ���Ƿ����ߵ�ĩ�˻���ͷ"/>  <StrRes Name="propArrowLength" Text="��ͷ�ĳ���"/>  <StrRes'+
' Name="propArrowSolid" Text="ȷ���Ƿ��������ļ�ͷ"/>  <StrRes Name="propArrowStart" Text'+
'="ȷ���Ƿ����ߵ���ʼ������ͷ"/>  <StrRes Name="propArrowWidth" Text="��ͷ���"/>  <StrRes Name="p'+
'ropCloseDataSource" Text="ȷ���Ƿ��ڱ�����ɺ�ر����ݼ�"/>  <StrRes Name="propDatabase" Text="'+
'���ݿ�����"/>  <StrRes Name="propIndexFieldNames" Text="�����ֶε�����"/>  <StrRes Name="pro'+
'pCommandTimeOut" Text="ִ�в�ѯ��ʱ����Ҫʱ����"/>  <StrRes Name="propExpandDrillDown" Text='+
'"ȷ���Ƿ��ڱ����״�����ʱչ�����е���ȡԪ�� "/>  <StrRes Name="propWysiwyg.TfrxMemoView" Text="ȷ���Ƿ�����'+
'��������ģʽ��ʾ�ı�"/>  <StrRes Name="propLeftLine" Text="����������"/>  <StrRes Name="propTo'+
'pLine" Text="��Ķ�������"/>  <StrRes Name="propRightLine" Text="����ұ�����"/>  <StrRes Na'+
'me="propBottomLine" Text="��ĵײ�����"/>  <StrRes Name="propColor.TfrxFrameLine" Text'+
'="������ɫ"/>  <StrRes Name="propStyle.TfrxFrameLine" Text="������ʽ"/>  <StrRes Name="p'+
'ropWidth.TfrxFrameLine" Text="���߿��"/>  <StrRes Name="propFileLink" Text="���ʽ���߰���'+
'ͼƬ���ļ���"/>  <StrRes Name="propEndlessWidth" Text="������ҳģʽ. ��Ϊ true, ҳ�����������е����ݼ�¼����'+
'����"/>  <StrRes Name="propEndlessHeight" Text="������ҳģʽ. ��Ϊ true, ҳ�����������е����ݼ�¼��������"'+
'/>  <StrRes Name="propAddHeight" Text="��Ԫ��߶�����ָ���Ŀռ���"/>  <StrRes Name="propAddWi'+
'dth" Text="��Ԫ���ȶ�����ָ���Ŀռ���"/>  <StrRes Name="propAllowDuplicates" Text="ȷ����Ԫ���Ƿ����'+
'�ظ��Ĵ�"/>  <StrRes Name="propJoinEqualCells" Text="ȷ��������Ƿ�Ӧ�ð����ֵ���ӵ�Ԫ��"/>  <StrRes '+
'Name="propNextCross" Text="ָ����һ��������ʾ�Ľ����"/>  <StrRes Name="propNextCrossGap" Tex'+
't="���ŵĽ����ļ�϶"/>  <StrRes Name="propShowCorner" Text="ȷ���Ƿ�Ӧ����ʾ���Ͻ�Ԫ��"/>  <StrRes N'+
'ame="propSuppressNullRecords" Text="!ȷ��������Ƿ����������Ϊ�յļ�¼"/>  <StrRes Name="propSho'+
'wTitle" Text="!ȷ��������Ƿ����ʾ����"/>  <StrRes Name="propAutoSize" Text="!ȷ��������Ƿ���Զ������'+
'С"/>  <StrRes Name="propShowHint" Text="Determines if object should show hint wh'+
'en move cursor on it"/>  <StrRes Name="propHint" Text="Hint text"/>  <StrRes Nam'+
'e="propPaperSize" Text="PaperSize"/>  <StrRes Name="propPageCount" Text="Count o'+
'f pages"/>  <StrRes Name="propBackPictureVisible" Text="Determines if the page s'+
'hould display a background picture"/>  <StrRes Name="propBackPicturePrintable" T'+
'ext="Determines if the page should print a background picture"/>  <StrRes Name="'+
'propHightQuality" Text="Show picture in high quality"/>  <StrRes Name="propLockT'+
'ype" Text="Specifies the lock type to use when opening a dataset"/>  <StrRes Nam'+
'e="propIgnoreDupParams" Text="Ignore duplicate parameters in ParamEditor"/></Res'+
'ources>'+
'';
initialization
  frxResources.AddXML(Utf8Encode(resXML));

end.
