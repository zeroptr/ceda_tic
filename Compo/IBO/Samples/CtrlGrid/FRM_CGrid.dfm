�
 TFRMCGRID 0�  TPF0	TfrmCGridfrmCGridLeft� Top� WidthHeight�CaptionfrmCGridFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OnCreate
FormCreatePixelsPerInch`
TextHeight TPanelPanel1Left Top Width�Height)AlignalTopTabOrder  TIB_DatasetBarIB_DataSetBar1Left� TopWidth!HeightCtl3DParentCtl3DTabOrder 
DataSourcedsCGridReceiveFocusCustomGlyphsSupplied TogglePrepare	
ToggleOpen	VisibleButtonsdbOpen   TIB_SearchBarIB_SearchBar1LeftTopWidth� HeightCtl3DParentCtl3DTabOrder
DataSourcedsCGridReceiveFocusCustomGlyphsSupplied   TIB_NavigationBarIB_NavigationBar1Left� TopWidthyHeightCtl3DParentCtl3DTabOrder
DataSourcedsCGridReceiveFocusCustomGlyphsSupplied   TIB_UpdateBarIB_UpdateBar1LeftHTopWidth� HeightCtl3DParentCtl3DTabOrder
DataSourcedsCGridReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshAll    TIB_CtrlGridIB_CtrlGrid1Left Top)Width�HeightfAlignalClientTabOrderTabStopAllowDeleteAllowInsert
DataSourcedsCGridPanelHeightFixed	PanelHeightTPanelWidthFixed	
PanelWidth�SelectedColor���  TLabelLabel1Left
Top$Width5HeightCaptionCOMPANY  TLabelLabel2Left
TopWidth-HeightCaptionCUSTNO  TLabellbLastInvoiceLeft
Top;WidthiHeightCaptionLAST INVOICE DATE  TIB_MemoIB_Memo1Left� TopWidth� HeightE	DataFieldADDR1
DataSourcedsCGridTabOrderAutoSize  TIB_EditIB_Edit1LeftDTopWidth� Height	DataFieldCUSTNO
DataSourcedsCGridTabOrder   TIB_EditIB_Edit2LeftDTop Width� Height	DataFieldCOMPANY
DataSourcedsCGridTabOrder  TIB_DateIB_Date1LeftwTop8WidthsHeight	DataFieldLASTINVOICEDATE
DataSourcedsCGridTabOrderIncCellHeightIncCellWidthDrawYearArrow   TIB_ConnectioncnCGridLoginPrompt	Params.StringsBPATH=C:\Program Files\Common Files\Borland Shared\Data\mastsql.gdbPASSWORD=masterkeyUSER NAME=SYSDBA BeforeConnectcnOnConnectAfterConnectcnOnConnectLeftTop�   	TIB_QueryqrCGridDatabaseName=C:\Program Files\Common Files\Borland Shared\Data\mastsql.gdbFieldsDisplayWidth.StringsCUSTOMER.CUSTNO=54CUSTOMER.COMPANY=161CUSTOMER.ADDR1=126CUSTOMER.ADDR2=65CUSTOMER.CITY=81CUSTOMER.STATE=58CUSTOMER.ZIP=67CUSTOMER.COUNTRY=104CUSTOMER.PHONE=77CUSTOMER.FAX=76CUSTOMER.TAXRATE=55CUSTOMER.CONTACT=98 FieldsIndex.StringsCUSTOMER.CUSTNOCUSTOMER.COMPANYCUSTOMER.ADDR1CUSTOMER.ADDR2CUSTOMER.CITYCUSTOMER.STATECUSTOMER.ZIPCUSTOMER.COUNTRYCUSTOMER.PHONECUSTOMER.FAXCUSTOMER.TAXRATECUSTOMER.CONTACTCUSTOMER.LASTINVOICEDATE IB_ConnectioncnCGridSQL.Stringsselect *from customer
for update ColorScheme	KeyLinks.StringsCUSTNO MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly RequestLive	BufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	LeftPTop�   TIB_DataSourcedsCGridDatasetqrCGridLeft� Top�   TOpenDialogodGDB
DefaultExtGDBFilter InterBase Database (*.GDB)|*.GDBTitleEmployee Database FileLeft� Top�    