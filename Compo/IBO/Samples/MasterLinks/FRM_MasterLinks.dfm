�
 TFRMMASTERLINKS 0n  TPF0TfrmMasterLinksfrmMasterLinksLeft� TopnWidth�HeightCaptionMasterLinks DemoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ShowHint	OnCreate
FormCreatePixelsPerInch`
TextHeight TIB_GridgrCustLeft Top)Width�Height� CustomGlyphsSupplied 
DataSourcedsCustAlignalTopFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder IndicateHighlightCurrentRowFont.CharsetDEFAULT_CHARSETCurrentRowFont.ColorclWindowTextCurrentRowFont.Height�CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingFont.CharsetDEFAULT_CHARSETOrderingFont.ColorclWindowTextOrderingFont.Height�OrderingFont.NameMS Sans SerifOrderingFont.Style FixedFont.CharsetDEFAULT_CHARSETFixedFont.ColorclWindowTextFixedFont.Height�FixedFont.NameMS Sans SerifFixedFont.Style Ctl3DShallow	OnGetCellPropsgrCustGetCellProps  TIB_GridgrItemsLeft Top}Width�Height� CustomGlyphsSupplied 
DataSourcedsItemsAlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderIndicateHighlightCurrentRowFont.CharsetDEFAULT_CHARSETCurrentRowFont.ColorclWindowTextCurrentRowFont.Height�CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingFont.CharsetDEFAULT_CHARSETOrderingFont.ColorclWindowTextOrderingFont.Height�OrderingFont.NameMS Sans SerifOrderingFont.Style FixedFont.CharsetDEFAULT_CHARSETFixedFont.ColorclWindowTextFixedFont.Height�FixedFont.NameMS Sans SerifFixedFont.Style Ctl3DShallow	OnGetCellPropsgrItemsGetCellProps  TPanelpnCustLeft Top Width�Height)AlignalTopTabOrder TIB_DatasetBardbCustLeftTopWidthQHeightCtl3DParentCtl3DParentShowHintShowHint	TabOrder 
DataSourcedsCustReceiveFocusCustomGlyphsSupplied 
ToggleOpen	VisibleButtonsdbOpen   TIB_UpdateBarnbCustLeftcTopWidth� HeightCtl3DParentCtl3DTabOrder
DataSourcedsCustReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshAll   TIB_UtilityBarIB_UtilityBar1Left� TopWidthOHeightCustomGlyphsSupplied VisibleButtons	wbMonitor 
ShowGlyphs	Ctl3DParentCtl3DTabOrder   TPanelpnOrdersLeft TopTWidth�Height)AlignalTopTabOrder TIB_UpdateBarnbOrdersLeftcTopWidthtHeightCtl3DParentCtl3DTabOrder 
DataSourcedsItemsReceiveFocusCustomGlyphsSupplied    TPanelPanel1Left Top� Width�Height)AlignalTopTabOrder TIB_UpdateBarIB_UpdateBar1LeftcTopWidthtHeightCtl3DParentCtl3DTabOrder 
DataSourcedsOrdersReceiveFocusCustomGlyphsSupplied    TIB_GridgrOrdersLeft Top� Width�Height� CustomGlyphsSupplied 
DataSourcedsOrdersAlignalTopFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderIndicateHighlightCurrentRowFont.CharsetDEFAULT_CHARSETCurrentRowFont.ColorclWindowTextCurrentRowFont.Height�CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingFont.CharsetDEFAULT_CHARSETOrderingFont.ColorclWindowTextOrderingFont.Height�OrderingFont.NameMS Sans SerifOrderingFont.Style FixedFont.CharsetDEFAULT_CHARSETFixedFont.ColorclWindowTextFixedFont.Height�FixedFont.NameMS Sans SerifFixedFont.Style Ctl3DShallow	OnGetCellPropsgrOrdersGetCellProps  	TIB_QueryqrCustDatabaseName=C:\Program Files\Common Files\Borland Shared\Data\mastsql.gdbFieldsDisplayWidth.StringsCUSTOMER.COMPANY=151CUSTOMER.LASTINVOICEDATE=102 FieldsIndex.StringsCUSTOMER.CUSTNOCUSTOMER.COMPANYCUSTOMER.LASTINVOICEDATECUSTOMER.ADDR1CUSTOMER.ADDR2CUSTOMER.CITYCUSTOMER.STATECUSTOMER.ZIPCUSTOMER.COUNTRYCUSTOMER.PHONECUSTOMER.FAXCUSTOMER.TAXRATECUSTOMER.CONTACT IB_TransactiontrMasterLinkSQL.StringsSELECT 	   CUSTNO,  COMPANY || '' AS COMPANY,  LASTINVOICEDATE,  ADDR1,  ADDR2,  CITY,  STATE,  ZIP
,  COUNTRY,  PHONE,  FAX
,  TAXRATE
,  CONTACTFROM CUSTOMER
FOR UPDATE OnActiveChangeqrCustActiveChangeAutoFetchAll	ColorScheme	EditSQL.StringsUPDATE CUSTOMER  SET CUSTNO = :CUSTNO    , COMPANY = :COMPANY(    , LASTINVOICEDATE = :LASTINVOICEDATE  WHERE CUSTNO = :OLD_CUSTNO KeyLinks.StringsCUSTOMER.CUSTNO 
KeySeekingMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly RefreshActionraKeepDataPosRequestLive	
AfterCloseqrCustAfterCloseBufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	Left� Top`  TIB_DataSourcedsCustDatasetqrCustLeft� Top`  	TIB_QueryqrOrdersDatabaseName=C:\Program Files\Common Files\Borland Shared\Data\mastsql.gdbIB_TransactiontrMasterLinkSQL.StringsSELECT *FROM ORDERS
FOR UPDATE AutoFetchAll	ColorScheme	KeyLinks.StringsORDERS.ORDERNO 
KeySeekingMasterSourcedsCustMasterLinks.StringsORDERS.CUSTNO=CUSTOMER.CUSTNO MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly RequestLive	BufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	Left� Top�   TIB_DataSourcedsOrdersDatasetqrOrdersLeft� Top�   TIB_ConnectioncnMasterLinkLoginPrompt	ColumnAttributes.StringsLASTINVOICEDATE=NOTIME Params.StringsBPATH=C:\Program Files\Common Files\Borland Shared\Data\mastsql.gdbUSER NAME=SYSDBAPASSWORD=masterkeyPROTOCOL=LOCAL BeforeConnectcnMasterLinkConnectAfterConnectcnMasterLinkConnectLeftTop`  TIB_TransactiontrMasterLinkIB_ConnectioncnMasterLink	IsolationtiCommittedLeftXTop`  TOpenDialogodGDB
DefaultExtGDBFilter InterBase Database (*.GDB)|*.GDBTitleMASTApp Database FileLeftXTop0  TIB_DataSourcedsItemsDatasetqrItemsLeft� Top�  	TIB_QueryqrItemsDatabaseName=C:\Program Files\Common Files\Borland Shared\Data\mastsql.gdbFieldsDisplayWidth.StringsITEMS.QTY=47 IB_TransactiontrMasterLinkSQL.StringsSELECT *
FROM ITEMS
FOR UPDATE AutoFetchAll	ColorScheme	KeyLinks.StringsITEMS.ORDERNOITEMS.ITEMNO 
KeySeekingMasterSourcedsOrdersMasterLinks.StringsITEMS.ORDERNO=ORDERS.ORDERNO MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly RequestLive	BufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	Left� Top�   