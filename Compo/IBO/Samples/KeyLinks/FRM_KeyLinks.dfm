�
 TFRMKEYLINKS 0  TPF0TfrmKeyLinksfrmKeyLinksLeft Top� Width�Height�ActiveControlgrParentCaptionfrmKeyLinksFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OnCreate
FormCreatePixelsPerInch`
TextHeight TPanelPanel1Left Top Width�Height)AlignalTopTabOrder  TIB_NavigationBarIB_NavigationBar1Left� TopWidthyHeightCtl3DParentCtl3DTabOrder 
DataSourcedsOrdersReceiveFocusCustomGlyphsSupplied   TIB_UpdateBarIB_UpdateBar1LeftTopWidth� HeightCtl3DParentCtl3DTabOrder
DataSourcedsOrdersReceiveFocusCustomGlyphsSupplied   TIB_DatasetBarIB_DataSetBar1LeftTopWidthyHeightCtl3DParentCtl3DTabOrder
DataSourcedsOrdersReceiveFocusCustomGlyphsSupplied    TIB_GridgrLookupLeft Top� Width�Height� CustomGlyphsSupplied 
DataSource
dsCustomerAlignalClientTabOrderDrawFocusSelected	TrackGridRow	IndicateHighlightCurrentRowColorclAquaOrderingColorclInfoBkCtl3DShallow	OnGetCellPropsgrLookupGetCellProps  TPanelPanel3Left Top�Width�Height)AlignalBottom
BevelOuterbvNoneCaptionBCLRL + UP, DOWN, PGUP, PGDOWN, HOME, END && VERT SCROLLBAR TO SCANTabOrderVisible  TIB_GridgrParentLeft Top)Width�Height� CustomGlyphsSupplied 
DataSourcedsOrdersAlignalTopTabOrderCurrentRowColorclAquaOrderingColorclInfoBkCtl3DShallow	OnGetCellPropsgrLookupGetCellProps  TIB_Connection
cnKeyLinksLoginPrompt	Params.StringsBPATH=C:\Program Files\Common Files\Borland Shared\Data\Mastsql.GDBPROTOCOL=LOCALPASSWORD=masterkeyUSER NAME=SYSDBA BeforeConnectcnKeyLinksConnectAfterConnectcnKeyLinksConnectLeftxTopH  	TIB_Query
qrCustomerDatabaseName=C:\Program Files\Common Files\Borland Shared\Data\Mastsql.GDBIB_Connection
cnKeyLinksIB_Transaction
trKeyLinksSQL.Stringsselect *from customer ColorScheme	KeyLinks.StringsCUSTOMER.CUSTNO=ORDERS.CUSTNO 	KeySourcedsOrdersMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItemNoOrderingItems.StringsN0=CUSTNO; CUSTNO DESCCompany=COMPANY; COMPANY DESC OrderingLinks.StringsCUSTNO=1	COMPANY=2 RefreshActionraKeepDataPosRequestLive	BufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	LeftTopH  TIB_DataSourcedsOrders
AutoInsertDatasetqrOrdersLeft� Topx  TIB_DataSource
dsCustomer
AutoInsertDataset
qrCustomerLeftTopx  	TIB_QueryqrOrdersDatabaseName=C:\Program Files\Common Files\Borland Shared\Data\Mastsql.GDBFieldsDisplayLabel.StringsORDERNO=OrderNoCUSTNOSALEDATESHIPDATEEMPNOSHIPTOCONTACTSHIPTOADDR1SHIPTOADDR2
SHIPTOCITYSHIPTOSTATE	SHIPTOZIPSHIPTOCOUNTRYSHIPTOPHONESHIPVIAPOTERMSPAYMENTMETHOD
ITEMSTOTALTAXRATEFREIGHT
AMOUNTPAID IB_Connection
cnKeyLinksIB_Transaction
trKeyLinksSQL.StringsSELECT *FROM ORDERS
FOR UPDATE OnActiveChangeqrOrdersActiveChangeColorScheme	KeyLinks.StringsORDERS.ORDERNO MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItems.StringsORDERNO=ORDERNO; ORDERNO DESCCUSTNO=CUSTNO; CUSTNO DESC OrderingLinks.Strings	ORDERNO=1CUSTNO=2 RequestLive	
AfterCloseqrOrdersAfterCloseBufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	Left� TopH  TOpenDialogodGDB
DefaultExtGDBFilter InterBase Database (*.GDB)|*.GDBTitleMASTApp Database FileLeftTopy  TIB_Transaction
trKeyLinksIB_Connection
cnKeyLinks	IsolationtiConcurrencyLeftxTopx   