�
 TTRANSACTIONMAINFORM 0�  TPF0TTransactionMainFormTransactionMainFormLeft� TopuWidth�Height�Caption!Transaction Control DemonstrationColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	ShowHint	OnCreate
FormCreateOnResize
FormResizePixelsPerInch`
TextHeight TPanelToolbarsPnlLeft Top Width�HeightdAlignalTop
BevelOuterbvNoneBorderWidthTabOrder  TLabelConnectionBarLblLeftTop
Width9Height	AlignmenttaRightJustifyCaptionConnection:  TLabelTransactionBarLblLeftTop"WidthQHeightHint#Toolbar for Controlled Query (only)	AlignmenttaRightJustifyCaptionControlled Query Transaction:WordWrap	  TLabelLabel2Left6TopHWidthHeightHint0Toolbars for Query Grid that currently has focus	AlignmenttaRightJustifyCaptionQuery:  TIB_ConnectionBarConnectionBarLeft\TopWidth;HeightCtl3DParentCtl3DTabOrder CustomGlyphsSupplied IB_ConnectionIBConnectionReceiveFocus  TIB_TransactionBarTransactionBarLeft\Top"WidthHeightCtl3DParentCtl3DTabOrderCustomGlyphsSupplied IB_TransactiontrControlledReceiveFocusVisibleButtonstbStart	tbPostAlltbCancelAlltbSavePointtbCommitRetainingtbCommittbRollbackRetaining
tbRollbacktbClose   TIB_UpdateBar	UpdateBarLeft� TopBWidth� HeightCtl3DParentCtl3DTabOrder
DataSourcedsControlledReceiveFocus	CustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshAll   TIB_DatasetBar
DatasetBarLeft\TopBWidth=HeightCtl3DParentCtl3DTabOrder
DataSourcedsControlledReceiveFocus	CustomGlyphsSupplied TogglePrepare	
ToggleOpen	VisibleButtons	dbPreparedbOpen   TIB_NavigationBarNavigationBarLeft0TopBWidthaHeightCtl3DParentCtl3DTabOrder
DataSourcedsControlledReceiveFocus	CustomGlyphsSupplied   TBitBtnHelpBtnLeft�Top"WidthOHeightTabOrderOnClickHelpBtnClickKindbkHelp   TPanelControlledQueryPnlLeft TopdWidth� Height� AlignalLeft
BevelInner	bvLowered
BevelOuterbvNoneBorderWidthTabOrder TIB_GridControlledQueryGridLeftTopWidth� Height� CustomGlyphsSupplied 
DataSourcedsControlledAlignalClientBorderStylebsNoneTabOrder Ctl3DShallow	TabMovesOut	  TPanelControlledQueryTitlePnlLeftTopWidth� HeightAlignalTopCaptionControlled Query GridTabOrder  TPanelControlledQueryOptionsPnlLeftTop� Width� Height$AlignalBottomTabOrder 	TComboBoxControlTransactionIsolationCBLeftTopWidthyHeightHintTransaction Isolation SettingStylecsDropDownList
ItemHeightItems.StringstiCommittedtiConcurrencytiConsistency TabOrder OnChangeTransactionIsolationChange  	TCheckBox ControlTransactionPauseEnabledCBLeft� Top
Width\HeightHint%Pause Processing Enabled when checkedCaptionPause EnabledChecked	State	cbCheckedTabOrderOnClickPauseEnabledChange    TPanelAutoQueryPnlLeft� TopdWidth� Height� AlignalClient
BevelInner	bvLowered
BevelOuterbvNoneBorderWidthTabOrder TPanelAutoQueryTitlePnlLeftTopWidth� HeightAlignalTopCaptionAuto Query GridTabOrder   TIB_GridAutoQueryGridLeftTopWidth� Height� CustomGlyphsSupplied 
DataSourceAutoDataSourceAlignalClientBorderStylebsNoneTabOrderCtl3DShallow	TabMovesOut	   TPanelTransactionStatePnlLeft Top*Width�HeightrAlignalBottom
BevelInner	bvLowered
BevelOuterbvNoneBorderWidthTabOrder TPanelTransactionStateTitlePnlLeftTopWidth�HeightAlignalTopCaption#List of Transactions In ApplicationTabOrder   TStringGridTransactionStateGridLeftTopWidth�HeightPTabStopAlignalClientBorderStylebsNoneColCountDefaultRowHeight	FixedCols RowCountOptionsgoFixedVertLinegoFixedHorzLine
goVertLine
goHorzLinegoRangeSelectgoRowSelect TabOrder	ColWidths@@@@@b    TIB_ConnectionIBConnectionFieldsDisplayLabel.StringsCOUNTRY=CountryCURRENCY=Currency Params.StringsCPATH=C:\Program Files\Common Files\Borland Shared\Data\Employee.gdbUSER NAME=SYSDBAPASSWORD=masterkey LeftrTop�   TIB_TransactiontrControlledIB_ConnectionIBConnection	IsolationtiCommittedTimeoutProps.AllowCheckOATTimeoutProps.Attempt
TimeoutProps.AttemptMaxRows'TimeoutProps.AttemptRetryTimeoutProps.PromptUserTimeoutProps.ForceClosedLeft� Top�   	TIB_QueryqrControlledDatabaseName>C:\Program Files\Common Files\Borland Shared\Data\Employee.gdbIB_ConnectionIBConnectionIB_TransactiontrControlledSQL.StringsSELECT *FROM COUNTRY
FOR UPDATE ColorSchemeKeyLinks.StringsCOUNTRY MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItemNoOrderingItems.StringsCOUNTRY=Country OrderingLinks.Strings	Country=1 RequestLive	BufferSynchroFlags CommitActioncaInvalidateCursorFetchWholeRows	Left0Top�   TIB_DataSourcedsControlledAnnounceFocus	DatasetqrControlledLeft� Top�   TIB_DataSourceAutoDataSourceAnnounceFocus	Dataset	AutoQueryLeftpTop�   	TIB_Query	AutoQueryDatabaseName>C:\Program Files\Common Files\Borland Shared\Data\Employee.gdbIB_ConnectionIBConnectionSQL.StringsSELECT *FROM COUNTRY
FOR UPDATE ColorSchemeKeyLinks.StringsCOUNTRY MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItemNoOrderingItems.StringsCOUNTRY=Country OrderingLinks.Strings	Country=1 RequestLive	BufferSynchroFlags FetchWholeRows	LeftTop�   TTimerTransactionTimerOnTimerTransactionTimerTimerLeft6Topk  TIB_SessionPropsIB_SessionProps1AllowDefaultConnection	AllowDefaultTransaction	
BusyCursor�StoreActive	TimerInterval�	UseCursorYieldCursor�EditingColorclYellowInsertingColorclLimeDeletingColorclRedSearchingColorclAquaReadOnlyColorclSilverSelectedColorclBlueInvalidColorclNonePreparedColor
clGrayTextBrowsingColorclWindowLeft� Topk   