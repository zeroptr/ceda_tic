�
 TFRMSOURCE 0�  TPF0�
TfrmSource	frmSourceLeftTopmHelpContext'CaptionSource AccessClientHeight� ClientWidthROnCreate
FormCreatePixelsPerInch`
TextHeight �
TStatusBar	StatusBarTop� WidthR  �TPanelpnCloseTop� WidthR �TPanelpnOKCancelButtonsLeft  �TPanelpnApplyButtonLeft�  �TPanelpnHelpButtonLeft  �TPanelpnBrowseButtonLeft�    �TIB_GridgrSourceLeft Top Width� Height� HelpContext'CustomGlyphsSupplied 
DataSourcedsSourceAlignalLeftReadOnly	TabOrderAllowDropFiles		RowSelect	ListBoxStyle		ColMovingColLinesRowLinesIndicateSelectedOrderingColorclInfoBkCtl3DShallow	StretchColumn
SC_VERSIONTabMovesOut	TabStopLinks.Strings
SC_VERSION OnGetCellPropsgrSourceGetCellProps  �TPanelPanel1Left� Top Width\Height� AlignalClient
BevelOuterbvNoneTabOrder TIB_RichEditreNotesLeft Top Width\HeighteHelpContext'	DataFieldSC_NOTES
DataSourcedsSourceAlignalClientTabOrder AutoSize
ScrollBars
ssVertical  TPanelPanel2Left TopeWidth\Height)HelpContext'AlignalBottom
BevelOuterbvNoneTabOrder TLabellb0Left`TopWidthHeightAutoSize  TIB_TextlbSizeLeftTopWidth>Height	DataFieldSC_SIZE
DataSourcedsSource  TLabellbBytesLeft� TopWidthkHeight	AlignmenttaCenterAutoSize  TButton
btDownloadLeft
TopWidthFHeightHelpContext'CaptionDownloadTabOrder OnClickbtDownloadClick  TProgressBarpbBlobLeftaTopWidth� HeightMin MaxdTabOrder    �TIB_TransactionSourcetsBaseLeft� Top   �TIB_ConnectionSourcecsBaseLefthTop   TIB_DataSourcedsSourceAnnounceFocus	
AutoInsertDatasetqrSourceLeftxTopX  	TIB_QueryqrSourceCalculatedFields.StringsSC_SIZEKB INTEGER NOT NULL!SC_VERSION VARCHAR( 20 ) NOT NULL SC_DOWNLOADED CHAR( 1 ) NOT NULL ColumnAttributes.StringsSC_TYPE=BOOLEAN=FUL,SUBSC_DOWNLOADED=BOOLEAN DatabaseName
WishList_1FieldsDisplayFormat.StringsSC_DATE=mm/dd/yy hh:nnSC_SIZE=###,###,###SC_SIZEKB=###,###,### FieldsDisplayLabel.StringsSC_ID=IDSC_DATE=DateSC_FILENAME=FilenameSC_DATA=DataSC_TYPE=FullSC_BASE_FILENAME=Base FilenameSC_NOTES=NotesSC_SIZE=SizeSC_SIZEKB=Size (KB)SC_VERSION=Version FieldsDisplayWidth.StringsSOURCECODE.SC_FILENAME=92SOURCECODE.SC_TYPE=21SOURCECODE.SC_BASE_FILENAME=95SOURCECODE.SC_NOTES=44ICON=18SOURCECODE.SC_SIZE=52SOURCECODE.SC_DATE=83SC_SIZEKB=48SC_VERSION=46SOURCEACCESS.SC_TYPE=20SOURCEACCESS.SC_DATE=82 FieldsIndex.StringsSOURCEACCESS.SC_TYPE
SC_VERSIONSOURCEACCESS.SC_DATE	SC_SIZEKBSOURCEACCESS.SC_IDSOURCEACCESS.SC_FILENAMESOURCEACCESS.SC_NOTESSOURCEACCESS.SC_SIZE FieldsVisible.StringsSC_ID=f	SC_DATA=f
SC_NOTES=f	SC_SIZE=fSC_FILENAME=fSC_DOWNLOADED=f IB_TransactiontrSQL.Strings	SELECT * FROM SOURCEACCESS OnCalculateFieldqrSourceCalculateFieldColorSchemeGeneratorLinks.Stringssc_id=gen_sc_id KeyLinks.StringsSC_ID KeyLinksAutoDefineMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly OrderingItemNo�OrderingItems.StringsID=SC_ID;SC_ID DESC%FILENAME=SC_FILENAME;SC_FILENAME DESCTYPE=SC_TYPE;SC_TYPE DESCDATE=SC_DATE;SC_DATE DESC4BASE_FILENAME=SC_BASE_FILENAME;SC_BASE_FILENAME DESC OrderingLinks.StringsSC_ID=1SC_VERSION=2SC_FILENAME=2	SC_TYPE=3	SC_DATE=4SC_BASE_FILENAME=5 ReadOnly	RequestLive	AfterScrollqrSourceAfterScrollBufferSynchroFlags FetchWholeRows	Left@TopX  TIB_ConnectioncnLoginCaptionIBO Source LoginLoginHelpContext'LoginSQLRoleListREGISTERED_USERLoginSQLRolePrefixIBO_LoginUsernamePrefixIBO_REG_LoginPrompt	LoginRegKey	%DEFAULT%DatabaseName
WishList_1Params.StringsSERVER=www.ibobjects.comPATH=d:\ibdb\IBO.GDBUSER NAME=SYSDBAROLE NAME=IBO_REGISTERED_USER OnLoginFailurecnLoginFailureLeftTop   TIB_StoredProcspSourceDatabaseName
WishList_1IB_ConnectioncnIB_TransactiontrSQL.StringsEXECUTE PROCEDURE GETSOURCE  ?SC_ID OnBlobCallbackspSourceBlobCallbackParamNames.StringsSC_ID StoredProcName	GETSOURCEStoredProcHasDMLLeft� TopX  TIB_Transactiontr	IsolationtiCommittedTimeoutProps.AllowCheckOAT
TimeoutProps.AttemptTimeoutProps.AttemptTicks� LeftTopZ   