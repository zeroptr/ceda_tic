�
 TFRMDATAPUMP 0S  TPF0�TfrmDataPumpfrmDataPumpLeft� Top� Caption	Data PumpClientHeight ClientWidth�OnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight �
TStatusBar	StatusBarTop�Width�Visible  �TPanelPanel30Left Top Width�HeightAlignalTop
BevelOuterbvNoneTabOrder  �TPanelpnCloseTop�Width�TabOrder  �TPanelpnOKCancelButtonsLeft�   �TPanelpnApplyButtonLeftD  �TPanelpnHelpButtonLeft�  �TPanelpnBrowseButtonLeftT   �TPageControl
pcDataPumpLeft TopWidth�Height�
ActivePagetsItemActionsAlignalClient	MultiLine	TabOrderOnChangemeItemInfoChange 	TTabSheettsSourceCaptionSrcDataSet.SQL TMemomeSrcSQLLeft Top,Width�HeightxAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont
ScrollBarsssBothTabOrder WordWrapOnChangemeSrcSQLChange  TPanelpnSrcSQLLeft Top Width�Height)AlignalTop
BevelOuter	bvLoweredTabOrder 	TCheckBoxrbSeparateSrcDatabaseLeftTopWidthqHeightCaptionSeparate DatabaseTabOrder OnClickrbSeparateSrcDatabaseClick  TButtonbtSrcDatabaseLeft� TopWidthyHeightCaptionSelect Database...EnabledTabOrderOnClickbtDatabaseClick  TIB_StatementBarIB_StatementBar1LeftTopWidth'HeightCtl3DParentCtl3DTabOrderCustomGlyphsSupplied 	StatementcrSrcVisibleButtons	sbPrepare    TPanelpnSrcSpacerLeft Top)Width�HeightAlignalTop
BevelOuterbvNoneTabOrder   	TTabSheettsDestinationCaptionDstStatement.SQL TMemomeDstSQLLeft Top,Width�HeightxAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont
ScrollBarsssBothTabOrder WordWrapOnChangemeDstSQLChange  TPanelpnDstSQLLeft Top Width�Height)AlignalTop
BevelOuter	bvLoweredTabOrder 	TCheckBoxrbSeparateDstDatabaseLeftTopWidthqHeightCaptionSeparate DatabaseTabOrder OnClickrbSeparateSrcDatabaseClick  TButtonbtDstDatabaseLeft� TopWidthyHeightCaptionSelect Database...EnabledTabOrderOnClickbtDatabaseClick  TIB_StatementBarsbDstLeftTopWidth'HeightCtl3DParentCtl3DTabOrderCustomGlyphsSupplied 	StatementcrDstVisibleButtons	sbPrepare    TPanelpnDstSpacerLeft Top)Width�HeightAlignalTop
BevelOuterbvNoneTabOrder   	TTabSheet
tsDstLinksCaptionDstLinks TMemo
meDstLinksLeft Top Width�Height�AlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont
ScrollBarsssBothTabOrder WordWrapOnChangemeItemInfoChange   	TTabSheettsItemAttributesCaptionItemAttributes TMemomeItemAttributesLeft Top,Width�HeightxAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont
ScrollBarsssBothTabOrder WordWrapOnChangemeItemInfoChange  TPanelPanel5Left Top Width�Height)AlignalTop
BevelOuter	bvLoweredTabOrder TButton	btClassesLeftTopWidthAHeightCaptionClassesTabOrder OnClickbtClassesClick   TPanelPanel6Left Top)Width�HeightAlignalTop
BevelOuterbvNoneTabOrder   	TTabSheettsItemActionsCaptionItemActions TPanelPanel1Left Top Width�Height)AlignalTop
BevelOuter	bvLoweredTabOrder  TButton	btPrepareLeftTopWidthAHeightCaptionPrepareTabOrder OnClickbtPrepareClick   TPanelPanel2Left Top)Width�HeightAlignalTop
BevelOuterbvNoneTabOrder  TMemomeItemActionsLeft Top,Width�HeightxAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont
ScrollBarsssBothTabOrderWordWrap   	TTabSheet	tsExecuteCaptionExecute 
TScrollBox
ScrollBox1Left Top,Width�HeightxAlignalClientTabOrder  TLabelLabel1LeftTop0Width8HeightCaptionDestination:  TLabelLabel2LeftTopWidth%HeightCaptionSource:  TLabelLabel3LeftTopIWidthSHeightCaptionRows Processed:  TLabel
lbRowCountLeft� TopIWidth9Height	AlignmenttaRightJustifyAutoSizeCaption0  TLabelLabel4LeftTop]WidthYHeightCaptionRows Per Second:  TLabellbRowPerSecLeft� Top]Width9Height	AlignmenttaRightJustifyAutoSizeCaption0  TLabellb0LeftTop� WidthHeightCaption0  TLabel
lbRecCountLeftSTop� Width� Height	AlignmenttaRightJustifyAutoSizeCaption?  TLabelLabel6LeftTop� WidthHeightCaptionErrors:  TLabellbErrorsLeft� Top� Width9Height	AlignmenttaRightJustifyAutoSizeCaption?  TLabelLabel7LeftTopqWidthIHeightCaptionRows Affected:  TLabellbRowsAffectedLeft� TopqWidthJHeight	AlignmenttaRightJustifyAutoSizeCaption?  TIB_TransactionBartbSrcLeftXTop
WidthyHeightCtl3DParentCtl3DTabOrder CustomGlyphsSupplied ReceiveFocus  TIB_TransactionBartbDstLeftXTop*WidthyHeightCtl3DParentCtl3DTabOrderCustomGlyphsSupplied ReceiveFocus  TProgressBar
pbDataPumpLeftTop� Width� HeightMin MaxdTabOrder  	TCheckBoxcbIgnoreErrorsLeft� Top� Width2HeightCaptionIgnoreTabOrder  	TCheckBoxcbIgnoreCountLeft� Top� Width2HeightCaptionIgnoreTabOrderOnClickcbIgnoreCountClick  	TCheckBoxcbIgnoreRowsAffectedLeft� ToppWidth2HeightCaptionIgnoreChecked	State	cbCheckedTabOrderOnClickcbIgnoreRowsAffectedClick   TPanelPanel3Left Top Width�Height)AlignalTop
BevelOuter	bvLoweredTabOrder TButton	btExecuteLeftTopWidthAHeightCaptionExecuteTabOrder OnClickbtExecuteClick   TPanelPanel4Left Top)Width�HeightAlignalTop
BevelOuterbvNoneTabOrder    �TIB_TransactionSourcetsBaseAfterAssignment#IB_TransactionSourceAfterAssignmentLeft� TopX  �TIB_ConnectionSourcecsBaseAfterAssignment"IB_ConnectionSourceAfterAssignmentLeft� Top(  
TIB_CursorcrSrcSQL.StringsTest CallbackIncColorScheme
KeySeekingMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly LeftTop�  
TIB_CursorcrDstOnErrordpBaseErrorColorSchemeMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly Left� Top�  TIB_StatementSourcessDst	StatementcrDstAfterAssignmentssDstAfterAssignmentBeforePreparessDstBeforePrepareAfterPreparessDstAfterPrepareLeftTop�  TIB_ConnectioncnSrcLeftTop(  TIB_ConnectionSourcecsSrcAfterAssignmentcsSrcAfterAssignmentLeftHTop(  TIB_TransactionSourcetsSrcReceiveFocusAfterAssignmenttsSrcAfterAssignmentLeftHTopX  TIB_TransactiontrSrcIB_ConnectioncnSrc	IsolationtiConcurrencyLeftTopX  TIB_ConnectioncnDstLeft� Top(  TIB_TransactiontrDstIB_ConnectioncnDstConfirmClosePrompt.StringsSave Data Pump changes? 	IsolationtiConcurrencyLeft� TopX  TIB_ConnectionSourcecsDstAfterAssignmentcsDstAfterAssignmentLeft Top(  TIB_TransactionSourcetsDstReceiveFocusAfterAssignmenttsDstAfterAssignmentLeft TopX  TIB_DataPumpdpBaseBeforePreparedpBaseBeforePrepareOnErrordpBaseErrorOnAdjustCursordpBaseAdjustCursorDstStatementcrDst
SrcDatasetcrSrcAfterExecuteItemsdpBaseAfterExecuteItemsLeft� Top�  TIB_StatementSourcessSrc	StatementcrSrcBeforePreparessSrcBeforePrepareAfterPreparessDstAfterPrepareLeftHTop�  TIB_StoredProcspDstOnErrordpBaseErrorLeft� Top�   