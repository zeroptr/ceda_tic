�
 TFRMBROWSE 0W�  TPF0�
TfrmBrowse	frmBrowseLeft� Top� CaptionBrowseClientHeight�ClientWidth�OnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight �
TStatusBar	StatusBarTop�Width�  �TPageControlpcBrowseLeft Top Width�Height�HelpContext�
ActivePagetsRelationsAlignalClient	PopupMenu
pmShowMainTabOrder OnChangepcBrowseChange 	TTabSheettsRelationsHelpContext�Caption	Relations TPanelpnRelInfLeftzTop Width2HeighteAlignalClient
BevelOuterbvNoneTabOrder  TPanelPanel22Left Top Width2Height)AlignalTop	AlignmenttaRightJustify
BevelOuter	bvLoweredTabOrder  TIB_NavigationBarIB_NavigationBar2Left"TopWidthYHeightCtl3DParentCtl3DTabOrder 
DataSourcedsRelationsReceiveFocusCustomGlyphsSupplied   	TCheckBoxcbTablesLeftTopWidth9HeightCaptionTablesChecked	State	cbCheckedTabOrderOnClickRelationsClick  	TCheckBoxcbViewsLeftTopWidth9HeightCaptionViewsChecked	State	cbCheckedTabOrderOnClickRelationsClick  	TCheckBoxcbSystemLeftXTopWidthIHeightCaptionSystem Inf.TabOrderOnClickRelationsClick  	TCheckBoxcbDomainInfoLeftXTopWidthQHeightCaptionDomain Inf.TabOrderOnClickcbDomainInfoClick  TIB_SearchBarIB_SearchBar1Left� TopWidthyHeightAfterActionIB_SearchBar1AfterActionCtl3DParentCtl3DTabOrder
DataSourcedsRelationsReceiveFocusCustomGlyphsSupplied   TIB_UpdateBarIB_UpdateBar1LeftTopWidthsHeightCtl3DParentCtl3DTabOrder
DataSourcedsRelationsReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshAll   TIB_TransactionBartbRelationsLeft�TopWidth!HeightCtl3DParentCtl3DTabOrderCustomGlyphsSupplied ReceiveFocusVisibleButtonstbCommitRetaining    TPanelPanel18Left Top,Width2Height9AlignalClient
BevelOuter	bvLoweredTabOrder TPageControlpcRelExtractLeftTopWidth0Height7
ActivePagetsDataAlignalClientTabOrder OnChangepcRelExtractChange 	TTabSheettsRelFieldsHelpContextLCaptionFields TIB_StatementGridsgExtractFieldsLeft Top Width(HeightHelpContext�AlignalClientColCountDefaultColWidth� DefaultRowHeightDefaultDrawing	FixedColsRowCount	FixedRows TabOrder Ctl3DShallow		FieldInfo		StatementqrRelations
IB_RowTypertField	ColWidths� � P�     	TTabSheettsDataHelpContext�CaptionData TIB_GridgrBrowseLeft Top Width(HeightQCustomGlyphsSupplied 
DataSourcedsRelationsAlignalTopTabOrder EditLinksAuto	IndicateLongTitle	IndicateLongCellText	DrawCellTextOptionsgdtEllipsis DrawTitleTextOptionsgdtEllipsis CurrentRowColorclInfoBkOrderingColorclInfoBkCtl3DShallow	  TIB_SearchPanelspBrowseLeft TopQWidth(Height� AlignalClientTabOrder
DataSourcedsRelationsEditLeft 
DualColumnMaxCols ShowVisibleFieldsOnly	   	TTabSheet	tsIndexesHelpContextCaptionIndexes TIB_LookupList	lbIndicesLeft Top WidthxHeightCustomGlyphsSupplied 
DataSource
dsIndexInfAlignalLeftTabOrder DefaultRowHeight  TPanelPanel1LeftzTop Width�HeightAlignalClient
BevelOuterbvNoneTabOrder TMemomeIndexFieldsLeft Top)Width�Height� HintIndex FieldsAlignalClientReadOnly	TabOrder   TPanelPanel2Left Top Width�Height)AlignalTop
BevelOuter	bvLoweredTabOrder TLabelLabel1LeftTopWidth*HeightCaptionUNIQUE  TLabelLabel2LeftnTopWidthHeightCaptionTYPE  TLabelLabel3Left� TopWidth1HeightCaptionINACTIVE  TIB_EditIB_Edit4Left=Top
Width$Height	DataFieldRDB$UNIQUE_FLAG
DataSource
dsIndexInfTabOrder   TIB_EditIB_Edit5Left� Top
Width!Height	DataFieldRDB$INDEX_TYPE
DataSource
dsIndexInfTabOrder  TIB_EditIB_Edit6Left� Top
WidthHeight	DataFieldRDB$INDEX_INACTIVE
DataSource
dsIndexInfTabOrder    TPanelpnSizerIndexLeftxTop WidthHeightCursorcrSizeWEAlignalLeft
BevelOuterbvNoneTabOrderOnMouseDownpnSizerRelationsMouseDownOnMouseMovepnSizerRelationsMouseMove	OnMouseUppnSizerRelationsMouseUp   	TTabSheettsConstraintsHelpContexttCaptionConstraints TPanelPanel3Left{Top Width�HeightAlignalClient
BevelOuter	bvLoweredTabOrder  TLabelLabel4LeftTopWidthHeightCaptionTYPE  TLabelLabel5LeftTop-WidthGHeightCaption
DEFERRABLE  TLabelLabel6Left� Top-WidthpHeightCaptionINITIALLY DEFERRED  TLabelLabel7LeftTopMWidthCHeightCaption
INDEX NAME  TIB_EditIB_Edit2Left8TopWidthqHeight	DataFieldRDB$CONSTRAINT_TYPE
DataSourcedsConstraintInfTabOrder   TIB_EditIB_Edit7LeftXTop(Width)Height	DataFieldRDB$DEFERRABLE
DataSourcedsConstraintInfTabOrder  TIB_EditIB_Edit8Left(Top(Width)Height	DataFieldRDB$INITIALLY_DEFERRED
DataSourcedsConstraintInfTabOrder  TIB_EditIB_Edit9LeftPTopHWidthHeightHint)Double click to display index information	DataFieldRDB$INDEX_NAME
DataSourcedsConstraintInf
OnDblClickIB_Edit9DblClickTabOrder  	TGroupBoxgbFKInfLeftTopbWidthIHeight� CaptionForeign key informationTabOrderVisible TLabelLabel9LeftTop:Width� HeightCaption Unique constraint in the parent:  TLabelLabel11LeftTopbWidth� HeightCaptionConstraint action on update:  TLabelLabel12LeftTop� Width� HeightCaptionConstraint action on delete:  TLabelLabel8LeftTopWidthGHeightCaptionParent relation:  TIB_EditIB_Edit1LeftTopJWidthHeightHint0Double click to jump to the displayed constraint	DataFieldRDB$CONST_NAME_UQ
DataSourcedsConstraintInf
OnDblClickIB_Edit1DblClickTabOrder  TIB_Edit	IB_Edit10LeftToprWidthHeight	DataFieldRDB$UPDATE_RULE
DataSourcedsConstraintInfTabOrder  TIB_Edit	IB_Edit11LeftTop� WidthHeight	DataFieldRDB$DELETE_RULE
DataSourcedsConstraintInfTabOrder  TIB_Edit	IB_Edit12LeftTop"WidthHeightHint.Double click to jump to the displayed relation	DataFieldPARENT_RELATION
DataSourcedsConstraintInf
OnDblClickIB_Edit12DblClickTabOrder     TPanelpnSizerConstraintsLeftxTop WidthHeightCursorcrSizeWEAlignalLeft
BevelOuterbvNoneTabOrderOnMouseDownpnSizerRelationsMouseDownOnMouseMovepnSizerRelationsMouseMove	OnMouseUppnSizerRelationsMouseUp  TIB_LookupListlbConstraintsLeft Top WidthxHeightCustomGlyphsSupplied 
DataSourcedsConstraintInfAlignalLeftTabOrderDefaultRowHeight   	TTabSheet
tsTriggersHelpContext�CaptionTriggers TIB_LookupList
lbTriggersLeft Top WidthyHeightCustomGlyphsSupplied 
DataSourcedsTriggerInfAlignalLeftTabOrder DefaultRowHeight  TPanelpnSizerTriggersLeftyTop WidthHeightCursorcrSizeWEAlignalLeft
BevelOuterbvNoneTabOrderOnMouseDownpnSizerRelationsMouseDownOnMouseMovepnSizerRelationsMouseMove	OnMouseUppnSizerRelationsMouseUp  TPanelPanel19Left{Top Width�HeightAlignalClient
BevelOuterbvNoneTabOrder TIB_Memo
meTriggersLeft Top)Width�Height� 	DataFieldRDB$TRIGGER_SOURCE
DataSourcedsTriggerInfAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontReadOnly	TabOrder AutoSize
ScrollBarsssBoth  TPanelPanel35Left Top Width�Height)AlignalTop
BevelOuter	bvLoweredTabOrder TLabelLabel10LeftYTopWidthHeightCaptionSEQ  TIB_EditedTriggerSequenceLeftqTop
Width$Height	DataFieldRDB$TRIGGER_SEQUENCE
DataSourcedsTriggerInfTabOrder   TButtonbtEditTriggerLeft0TopWidth!HeightCaptionEditEnabledTabOrderTabStopOnClickbtEditTriggerClick  TIB_CheckBoxIB_Edit3Left0Top
WidthAHeight	DataFieldRDB$TRIGGER_INACTIVE
DataSourcedsTriggerInfParentColorTabOrderCaptionInactive  TButton
btNewTriggLeftTopWidth!HeightCaptionNewTabOrderTabStopOnClickbtEditTriggerClick  TIB_ComboBoxcbTriggerTypeLeft� Top
Width� Height	DataFieldRDB$TRIGGER_TYPE
DataSourcedsTriggerInfTabOrderStylecsDropDownList
ItemHeightItems.Strings???BEFORE INSERTAFTER INSERTBEFORE UPDATEAFTER UPDATEBEFORE DELETEAFTER DELETE ItemValues.Strings0123456      	TTabSheettsSourceHelpContext@CaptionSource TMemomeSourceLeft Top Width(HeightAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontReadOnly	TabOrder WordWrap   	TTabSheet	tsRelDescHelpContext�CaptionDesc TIB_Memo	meRelDescLeft Top Width(Height	DataFieldRDB$DESCRIPTION
DataSourcedsRelInfAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize   	TTabSheettsRelDependHelpContext�CaptionDepend TIB_GridIB_CursorGrid2Left Top Width(HeightCustomGlyphsSupplied 
DataSourcedsRelDependAlignalClientTabOrder Ctl3DShallow	   	TTabSheettsFieldListHelpContext�CaptionField Names List TMemomeFieldListLeft Top!Width(Height� AlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontReadOnly	TabOrder   TRadioGrouprgFieldNamesLayoutLeft Top Width(Height!AlignalTopCaptionSeparate field names withColumns	ItemIndex Items.StringsCRLF	SemicolonComma and space TabOrderOnClickrgFieldNamesLayoutClick     TPanelPanel36Left Top)Width2HeightAlignalTop
BevelOuterbvNoneTabOrder   TIB_LookupListlbRelationsLeft Top WidthxHeighteHelpContext�CustomGlyphsSupplied 
DataSourcedsRelInfAlignalLeftTabOrderDefaultRowHeight  TPanelpnSizerRelationsLeftxTop WidthHeighteCursorcrSizeWEAlignalLeft
BevelOuterbvNoneTabOrderOnMouseDownpnSizerRelationsMouseDownOnMouseMovepnSizerRelationsMouseMove	OnMouseUppnSizerRelationsMouseUp   	TTabSheettsProceduresHelpContext�Caption
Procedures TPanelpnSizerProceduresLeftxTop WidthHeighteCursorcrSizeWEAlignalLeft
BevelOuterbvNoneTabOrder OnMouseDownpnSizerRelationsMouseDownOnMouseMovepnSizerRelationsMouseMove	OnMouseUppnSizerRelationsMouseUp  TPanelPanel24LeftzTop Width2HeighteAlignalClient
BevelOuterbvNoneTabOrder TPanelPanel21Left Top Width2Height)AlignalTop
BevelOuter	bvLoweredTabOrder  TButton
btEditProcLeft8TopWidth!HeightCaptionEditEnabledTabOrderTabStopOnClickbtEditProcClick  TIB_StatementBarsbExecLeftTopWidthKHeightCtl3DParentCtl3DTabOrderCustomGlyphsSupplied ExecuteUnprepared	Statement	spExtractVisibleButtons	sbExecute   TIB_TransactionBartbProcExtractLeftaTopWidth� HeightAfterActiontbProcExtractAfterActionCtl3DParentCtl3DTabOrderCustomGlyphsSupplied ReceiveFocus  TButton	btNewProcLeftTopWidth!HeightCaptionNewTabOrder TabStopOnClickbtEditProcClick  	TCheckBoxcbForSelectLefthTopWidthIHeightCaption
For SelectTabOrderOnClickcbForSelectClick  	TCheckBoxcbHasDMLLeft� Top
WidthIHeightCaptionHas DMLTabOrderOnClickcbForSelectClick   TPanelPanel33Left Top)Width2HeightAlignalTop
BevelOuterbvNoneTabOrder  TPanelPanel34Left Top,Width2Height9AlignalClient
BevelOuter	bvLoweredTabOrder TPageControlpcProcExtractLeftTopWidth0Height7
ActivePagetsProcedureInputsAlignalClientTabOrder OnChangepcProcExtractChange 	TTabSheettsProcSourceHelpContext�CaptionSource TIB_MemomeProcudureSourceLeft Top Width(Height	DataFieldRDB$PROCEDURE_SOURCE
DataSource	dsProcInfIgnoreColorScheme	AlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontReadOnly	TabOrder AutoSize
ScrollBarsssBoth   	TTabSheettsBLRCaptionBLR TIB_RichEditmeBLRLeft Top Width(Height	DataFieldRDB$PROCEDURE_BLR
DataSource	dsProcInfIgnoreColorScheme	AlignalClientColorclInfoBk
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontReadOnly	TabOrder AutoSizeAutoDisplay
ScrollBarsssBoth	PlainText	   	TTabSheettsProcedureInputsHelpContext�CaptionParams TIB_StatementGridIB_StatementGrid5Left Top Width(HeightAlignalClientColCountDefaultColWidth� DefaultRowHeightDefaultDrawing	FixedColsRowCount	FixedRows TabOrder OnKeyUpIB_StatementGrid5KeyUpCtl3DShallow		FieldInfo		Statement	spExtract
IB_RowTypertParam	ColWidths� � P�     	TTabSheettsProcedureOutputsHelpContext�CaptionFields TIB_StatementGridIB_StatementGrid6Left Top Width(HeightAlignalClientColCountDefaultColWidth� DefaultRowHeightDefaultDrawing	FixedColsRowCount	FixedRows TabOrder Ctl3DShallow		FieldInfo		Statement	spExtract
IB_RowTypertField	ColWidths� � P�     	TTabSheettsSPDataHelpContext�CaptionData
TabVisible TIB_CursorGridcgProcExtractLeft Top Width(HeightAlignalClientColCountDefaultRowHeightDefaultDrawing	FixedCols RowCountTabOrder Ctl3DShallow	
DataSource	dsExtractNullText<NULL>   	TTabSheet
tsProcDescHelpContext�CaptionDescription TIB_Memo
meProcDescLeft Top Width(Height	DataFieldRDB$DESCRIPTION
DataSource	dsProcInfAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize   	TTabSheettsProcDependHelpContext�CaptionDepend TIB_GridIB_CursorGrid1Left Top Width(HeightCustomGlyphsSupplied 
DataSourcedsProcDependAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder CurrentRowFont.ColorclWindowTextCurrentRowFont.Height�CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingFont.ColorclWindowTextOrderingFont.Height�OrderingFont.NameMS Sans SerifOrderingFont.Style FixedFont.ColorclWindowTextFixedFont.Height�FixedFont.NameMS Sans SerifFixedFont.Style Ctl3DShallow	      TIB_LookupListlbProceduresLeft Top WidthxHeighteCustomGlyphsSupplied 
DataSource	dsProcInfAlignalLeftTabOrderDefaultRowHeightGridLinks.StringsRDB$PROCEDURE_NAME    	TTabSheet	tsDomainsHelpContextCaptionDomains TPanelpnSizerDomainsLeftxTop WidthHeighteCursorcrSizeWEAlignalLeft
BevelOuterbvNoneTabOrder OnMouseDownpnSizerRelationsMouseDownOnMouseMovepnSizerRelationsMouseMove	OnMouseUppnSizerRelationsMouseUp  TPanelPanel4LeftzTop Width2HeighteAlignalClient
BevelOuter	bvLoweredTabOrder TMemomeDomainSourceLeftTopWidth0HeightcAlignalClient
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder    TIB_LookupList	lbDomainsLeft Top WidthxHeighteCustomGlyphsSupplied 
DataSourcedsDomainInfAlignalLeftTabOrderDefaultRowHeight   	TTabSheettsGeneratorsHelpContextxCaption
Generators TIB_GridlbGeneratorsLeft Top Width�Height CustomGlyphsSupplied 
DataSourcedsGenInfAlignalClientTabOrder ListBoxStyle	Ctl3DShallow	StretchColumnRDB$GENERATOR_NAMEOnGetCellPropslbGeneratorsGetCellProps  TPanelPanel5Left Top Width�HeighteAlignalBottom
BevelOuterbvNoneCaptionPanel5TabOrder TIB_Grid	ibGenProcLeft Top WidthHeighteCustomGlyphsSupplied 
DataSource	dsGenProcAlignalLeftTabOrder ListBoxStyle	IndicateRowCtl3DShallow	  TIB_Grid	ibGenTrigLeftTop Width�HeighteCustomGlyphsSupplied 
DataSource	dsGenTrigAlignalClientTabOrderListBoxStyle	IndicateRowCtl3DShallow	    	TTabSheettsExceptionsCaption
Exceptions TIB_GridibExcpLeft Top Width�HeightCustomGlyphsSupplied 
DataSourcedsExcpAlignalClientTabOrder ListBoxStyle	Ctl3DShallow	StretchColumnRDB$MESSAGE  TIB_MemomeExceptionDescriptionLeft TopWidth�HeightY	DataFieldRDB$DESCRIPTION
DataSourcedsExcpAlignalBottomTabOrderAutoSize   	TTabSheettsUDFsCaptionUDFs TIB_GridibUDFsLeft Top Width�HeighteCustomGlyphsSupplied 
DataSourcedsUDFsAlignalClientTabOrder Ctl3DShallow	    �TPanelpnCloseTop�Width� �TPanelpnOKCancelButtonsLeftt  �TPanelpnApplyButtonLeft  �TPanelpnHelpButtonLeftd  �TPanelpnBrowseButtonLeft$   �TIB_TransactionSourcetsBaseAfterAssignment#IB_TransactionSourceAfterAssignment
AfterStartIB_TransactionSourceAfterCommitAfterCommitRetainingIB_TransactionSourceAfterCommitAfterCommitIB_TransactionSourceAfterCommitTop�   �TIB_ConnectionSourcecsBaseAfterAssignment"IB_ConnectionSourceAfterAssignmentAfterExecDDLIB_ConnectionSourceAfterExecDDLLeft0Top�   	TIB_QueryqrTriggerInfColumnAttributes.StringsRDB$TRIGGER_INACTIVE=BOOLEAN FieldsVisible.StringsRDB$TRIGGER_SOURCE=FALSERDB$TRIGGER_SEQUENCE=FALSERDB$TRIGGER_TYPE=FALSERDB$TRIGGER_INACTIVE=FALSErdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RDB$TRIGGER_SOURCE     , RDB$TRIGGER_NAME     , RDB$TRIGGER_SEQUENCE     , RDB$TRIGGER_TYPE     , RDB$TRIGGER_INACTIVEFROM RDB$TRIGGERS)//WHERE RDB$TRIGGER_NAME = ?TRIGGER_NAME *//  AND RDB$RELATION_NAME = ?RELATION_NAMEORDER BY RDB$TRIGGER_NAME AutoFetchAll	ColorScheme	MasterSourcedsRelInfMasterLinks.Strings>RDB$TRIGGERS.RDB$RELATION_NAME=RDB$RELATIONS.RDB$RELATION_NAME MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly ReadOnly	
OnCallback
crCallbackBufferSynchroFlags FetchWholeRows	Filtered	OnFilterRecordqrRelInfFilterRecordLeft� TopH  	TIB_Query	qrProcInfFieldsVisible.Stringsrdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RDB$PROCEDURE_SOURCE, RDB$DESCRIPTION, RDB$PROCEDURE_NAME, RDB$PROCEDURE_BLRFROM RDB$PROCEDURESORDER BY RDB$PROCEDURE_NAME
FOR UPDATE AutoFetchAll	ColorScheme	MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly ReadOnly	RefreshActionraKeepDataPosRequestLive	AfterScrollqrProcInfAfterScrollBeforeScrollqrProcInfBeforeScroll
OnCallback
crCallbackBufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	Filtered	OnFilterRecordqrRelInfFilterRecordLeft@Top  TIB_DataSource	dsProcInfDataset	qrProcInfOnStateChangeddsProcInfStateChangedLeft�Top  	TIB_QueryqrRelInfFieldsVisible.StringsRDB$DESCRIPTION=FALSERDB$VIEW_SOURCE=FALSErdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RDB$DESCRIPTION     , RDB$VIEW_SOURCE     , RDB$RELATION_NAMEFROM RDB$RELATIONSORDER BY RDB$RELATION_NAMEFOR UPDATE OF RDB$DESCRIPTION OnPrepareSQLqrRelInfPrepareSQLAutoFetchAll	ColorScheme	MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly RequestLive	AfterScrollqrRelInfAfterScroll
OnCallback
crCallbackBufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	Filtered	OnFilterRecordqrRelInfFilterRecordLeft� Top�   TIB_DataSourcedsRelInfDatasetqrRelInfOnDataChangedsRelInfDataChangeLeft� Top�   TIB_DataSourcedsTriggerInfDatasetqrTriggerInfOnStateChangeddsTriggerInfStateChangedLeft� TopH  TIB_DataSourcedsRelationsDatasetqrRelationsOnStateChangeddsRelationsStateChangedLeft�Top�   	TIB_Query
qrIndexInfFieldsVisible.StringsRDB$EXPRESSION_SOURCE=FALSERDB$DESCRIPTION=FALSERDB$INDEX_INACTIVE=FALSERDB$UNIQUE_FLAG=FALSERDB$INDEX_TYPE=FALSErdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RDB$INDEX_NAME,      RDB$EXPRESSION_SOURCE,      RDB$DESCRIPTION,      RDB$INDEX_INACTIVE,      RDB$UNIQUE_FLAG,      RDB$INDEX_TYPEFROM RDB$INDICESORDER BY RDB$INDEX_NAMEFOR UPDATE OF RDB$DESCRIPTION AutoFetchAll	ColorScheme	MasterSourcedsRelInfMasterLinks.Strings=RDB$INDICES.RDB$RELATION_NAME=RDB$RELATIONS.RDB$RELATION_NAME MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly ReadOnly	RequestLive	AfterScrollqrIndexInfAfterScroll
OnCallback
crCallbackBufferSynchroFlags FetchWholeRows	Filtered	OnFilterRecordqrRelInfFilterRecordLeft� Top�   TIB_DataSource
dsIndexInfDataset
qrIndexInfOnStateChangeddsTriggerInfStateChangedLeft� Top�   	TIB_QueryqrProcDependFieldsDisplayLabel.Strings!RDB$DEPENDENT_NAME=DEPENDENT NAMERDB$FIELD_NAME=FIELD NAME!RDB$DEPENDENT_TYPE=DEPENDENT TYPE%RDB$DEPENDED_ON_TYPE=DEPENDED ON TYPE FieldsDisplayWidth.Strings'RDB$DEPENDENCIES.RDB$DEPENDENT_TYPE=117 FieldsVisible.Stringsrdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RDB$DEPENDENT_NAME     , RDB$FIELD_NAME     , RDB$DEPENDENT_TYPE     , RDB$DEPENDED_ON_TYPEFROM RDB$DEPENDENCIES AutoFetchAll	CallbackInc�ColorSchemeKeyLinksAutoDefineMasterSource	dsProcInfMasterLinks.Strings'RDB$DEPENDED_ON_NAME=RDB$PROCEDURE_NAME MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItems.Strings=RDB$DEPENDENT_NAME=RDB$DEPENDENT_NAME;RDB$DEPENDENT_NAME desc1RDB$FIELD_NAME=RDB$FIELD_NAME;RDB$FIELD_NAME desc=RDB$DEPENDENT_TYPE=RDB$DEPENDENT_TYPE;RDB$DEPENDENT_TYPE descCRDB$DEPENDED_ON_TYPE=RDB$DEPENDED_ON_TYPE;RDB$DEPENDED_ON_TYPE desc OrderingLinks.StringsRDB$DEPENDENT_NAME=1RDB$FIELD_NAME=2RDB$DEPENDENT_TYPE=3RDB$DEPENDED_ON_TYPE=4 ReadOnly	
OnCallback
crCallbackBufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	Left�Top�   TIB_DataSourcedsProcDependDatasetqrProcDependLeft�Top  	TIB_QuerycrRelDependFieldsDisplayLabel.Strings!RDB$DEPENDENT_NAME=DEPENDENT NAMERDB$FIELD_NAME=FIELD NAME!RDB$DEPENDENT_TYPE=DEPENDENT TYPE%RDB$DEPENDED_ON_TYPE=DEPENDED ON TYPE FieldsDisplayWidth.Strings#RDB$DEPENDENCIES.RDB$FIELD_NAME=170'RDB$DEPENDENCIES.RDB$DEPENDENT_NAME=162'RDB$DEPENDENCIES.RDB$DEPENDENT_TYPE=117 FieldsVisible.Stringsrdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RDB$DEPENDENT_NAME     , RDB$FIELD_NAME     , RDB$DEPENDENT_TYPE     , RDB$DEPENDED_ON_TYPEFROM RDB$DEPENDENCIES AutoFetchAll	CallbackInc�ColorSchemeKeyLinksAutoDefineMasterSourcedsRelInfMasterLinks.Strings&RDB$DEPENDED_ON_NAME=RDB$RELATION_NAME MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItemNoOrderingItems.Strings=RDB$DEPENDENT_NAME=RDB$DEPENDENT_NAME;RDB$DEPENDENT_NAME desc1RDB$FIELD_NAME=RDB$FIELD_NAME;RDB$FIELD_NAME desc=RDB$DEPENDENT_TYPE=RDB$DEPENDENT_TYPE;RDB$DEPENDENT_TYPE descCRDB$DEPENDED_ON_TYPE=RDB$DEPENDED_ON_TYPE;RDB$DEPENDED_ON_TYPE desc OrderingLinks.StringsRDB$DEPENDENT_NAME=1RDB$FIELD_NAME=2RDB$DEPENDENT_TYPE=3RDB$DEPENDED_ON_TYPE=4 ReadOnly	
OnCallback
crCallbackBufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	Left@Top�   TIB_DataSourcedsRelDependDatasetcrRelDependLeft�Top�   TIB_StoredProc	spExtractIB_ConnectionfrmSQL.cnEditSQL.StringsEXECUTE PROCEDURE te AfterExecutespExtractAfterExecuteStoredProcNameteStoredProcHasDMLLeft�Top�   	TIB_QueryqrRelationsFieldsVisible.StringsDB_KEY=F SQL.StringsSELECT *FROM <table> OnPreparedChangedqrRelationsPreparedChangedColorScheme	ConfirmDeletePrompt.StringsDelete record? MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly RequestLive	AfterInsertqrRelationsAfterInsert	AfterOpenqrRelationsAfterOpenAfterSearchqrRelationsAfterSearch
OnCallback
crCallbackBufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	Left@Top�   TIB_DSQLDialogdsqlEditTriggerBaseKey\Edit TriggerCaptionEdit TriggerParamsLeft0Top�   TIB_DSQLDialogdsqlEditProcBaseKey\Edit ProcedureCaptionEdit ProcedureParamsLeft0Top�   TIB_DataSource	dsExtractDataset	spExtractLeft0Top  	TIB_QueryqrConstraintInfFieldsVisible.StringsRDB$CONSTRAINT_TYPE=FALSERDB$DEFERRABLE=FALSERDB$INITIALLY_DEFERRED=FALSERDB$INDEX_NAME=FALSERDB$CONST_NAME_UQ=FALSERDB$UPDATE_RULE=FALSERDB$DELETE_RULE=FALSErdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RC.RDB$CONSTRAINT_NAME     , RC.RDB$CONSTRAINT_TYPE     , RC.RDB$DEFERRABLE      , RC.RDB$INITIALLY_DEFERRED     , RC.RDB$INDEX_NAME     , FC.RDB$CONST_NAME_UQ     , FC.RDB$UPDATE_RULE     , FC.RDB$DELETE_RULE$     , (SELECT RC2.RDB$RELATION_NAME)        FROM RDB$RELATION_CONSTRAINTS RC2M        WHERE RC2.RDB$CONSTRAINT_NAME = FC.RDB$CONST_NAME_UQ) PARENT_RELATION FROM RDB$RELATION_CONSTRAINTS RCLEFT JOIN RDB$REF_CONSTRAINTS FC4  ON RC.RDB$CONSTRAINT_NAME = FC.RDB$CONSTRAINT_NAMEORDER BY RC.RDB$CONSTRAINT_NAME AutoFetchAll	ColorScheme	KeyLinksAutoDefineMasterSourcedsRelInfMasterLinks.StringsJRDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME=RDB$RELATIONS.RDB$RELATION_NAME MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly ReadOnly	RequestLive	AfterScrollqrConstraintInfAfterScroll
OnCallback
crCallbackBufferSynchroFlags FetchWholeRows	Filtered	OnFilterRecordqrRelInfFilterRecordLeft� Top  TIB_DataSourcedsConstraintInfDatasetqrConstraintInfLeft� Top  	TIB_Query	qrExcpInfFieldsDisplayLabel.StringsRDB$EXCEPTION_NAME=NAMERDB$EXCEPTION_NUMBER=NUMBERRDB$MESSAGE=MESSAGERDB$DESCRIPTION=DESCRIPTIONRDB$SYSTEM_FLAG=SYSTEM FLAG FieldsDisplayWidth.StringsRDB$EXCEPTION_NAME=205RDB$EXCEPTION_NUMBER=52RDB$DESCRIPTION=83RDB$MESSAGE=374RDB$SYSTEM_FLAG=26 FieldsIndex.Strings#RDB$EXCEPTIONS.RDB$EXCEPTION_NUMBER!RDB$EXCEPTIONS.RDB$EXCEPTION_NAMERDB$EXCEPTIONS.RDB$MESSAGERDB$EXCEPTIONS.RDB$DESCRIPTION FieldsReadOnly.StringsRDB$EXCEPTION_NAME=NOEDITRDB$EXCEPTION_NUMBER=TRUERDB$SYSTEM_FLAG=TRUE FieldsVisible.StringsRDB$DESCRIPTION=Frdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RDB$EXCEPTION_NAME     , RDB$EXCEPTION_NUMBER     , RDB$MESSAGE     , RDB$DESCRIPTIONFROM RDB$EXCEPTIONS
FOR UPDATE AutoFetchAll	ColorScheme	KeyLinks.StringsRDB$EXCEPTION_NAME KeyLinksAutoDefineMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly RequestLive	BufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	Filtered	OnCustomDeleteqrExcpCustomEIDOnCustomEditqrExcpCustomEIDOnCustomInsertqrExcpCustomEIDOnFilterRecordqrRelInfFilterRecordLeft@TopH  TIB_DataSourcedsExcpDataset	qrExcpInfLeft�TopH  
TPopupMenu
pmShowMainOnPopuppmShowMainPopupLeft4Topx 	TMenuItemCpNamesClipbCaptionCopy column to clipboardOnClickCpNamesClipbClick  	TMenuItem
CpRowClipbCaptionCopy row to clipboardOnClickCpRowClipbClick  	TMenuItemCpTableClipbCaptionCopy table to clipboardOnClickCopyitemstoclipboard1Click  	TMenuItemmiDeleteselectedrecordsCaptionDelete selected recordsOnClickmiDeleteselectedrecordsClick  	TMenuItemDialogs1CaptionDialogs  	TMenuItemmiShowFTSInfoCaptionShow FTS$ InfoChecked	OnClickmiShowInfoClick  	TMenuItemmiShowRPLInfoCaptionShow RPL$ InfoChecked	  	TMenuItemmiShowTMPInfoCaptionShow TMP$ InfoChecked	OnClickmiShowInfoClick   	TIB_QueryqrDomainInfFieldsVisible.StringsRDB$QUERY_NAME=FALSERDB$VALIDATION_SOURCE=FALSERDB$COMPUTED_SOURCE=FALSERDB$DEFAULT_VALUE=FALSERDB$DEFAULT_SOURCE=FALSERDB$FIELD_LENGTH=FALSERDB$FIELD_SCALE=FALSERDB$FIELD_TYPE=FALSERDB$FIELD_SUB_TYPE=FALSERDB$SYSTEM_FLAG=FALSERDB$QUERY_HEADER=FALSERDB$SEGMENT_LENGTH=FALSERDB$EDIT_STRING=FALSERDB$EXTERNAL_LENGTH=FALSERDB$EXTERNAL_SCALE=FALSERDB$EXTERNAL_TYPE=FALSERDB$DIMENSIONS=FALSERDB$NULL_FLAG=FALSERDB$CHARACTER_LENGTH=FALSERDB$COLLATION_ID=FALSERDB$CHARACTER_SET_ID=FALSECHARACTER_SET_NAME=FALSErdb$db_key=FALSEdb_key=FALSE SQL.Stringsselect  F.RDB$FIELD_NAME,F.RDB$QUERY_NAME,F.RDB$VALIDATION_SOURCE,F.RDB$COMPUTED_SOURCE,F.RDB$DEFAULT_VALUE,F.RDB$DEFAULT_SOURCE,F.RDB$FIELD_LENGTH,F.RDB$FIELD_SCALE,F.RDB$FIELD_TYPE,F.RDB$FIELD_SUB_TYPE,F.RDB$SYSTEM_FLAG,F.RDB$QUERY_HEADER,F.RDB$SEGMENT_LENGTH,F.RDB$EDIT_STRING,F.RDB$EXTERNAL_LENGTH,F.RDB$EXTERNAL_SCALE,F.RDB$EXTERNAL_TYPE,F.RDB$DIMENSIONS,F.RDB$NULL_FLAG,F.RDB$CHARACTER_LENGTH,F.RDB$COLLATION_ID,( SELECT K.RDB$COLLATION_NAME   FROM RDB$COLLATIONS K0   WHERE K.RDB$COLLATION_ID = F.RDB$COLLATION_IDI   AND K.RDB$CHARACTER_SET_ID = F.RDB$CHARACTER_SET_ID) AS COLLATION_NAME,F.RDB$CHARACTER_SET_ID",( SELECT C.RDB$CHARACTER_SET_NAME   FROM RDB$CHARACTER_SETS CP   WHERE C.RDB$CHARACTER_SET_ID = F.RDB$CHARACTER_SET_ID ) AS CHARACTER_SET_NAMEFROM RDB$FIELDS F/WHERE NOT F.RDB$FIELD_NAME STARTING WITH 'RDB$'ORDER BY RDB$FIELD_NAME AutoFetchAll	ColorSchemeMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly ReadOnly	AfterScrollqrDomainInfAfterScrollBeforePrepareqrDomainInfBeforePrepareBufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	Filtered	OnFilterRecordqrRelInfFilterRecordLeft�TopH  TIB_DataSourcedsDomainInfDatasetqrDomainInfLeft.TopH  	TIB_QueryqrGenInfCalculatedFields.Strings&RDB$GENERATORS.GEN_VALUE VARCHAR( 36 ) FieldsAlignment.StringsGEN_VALUE=RIGHT FieldsDisplayLabel.StringsRDB$GENERATOR_ID=IDRDB$GENERATOR_NAME=NAMEGEN_VALUE=VALUE FieldsDisplayWidth.Stringsgen_value=188RDB$GENERATOR_ID=30 FieldsReadOnly.StringsRDB$GENERATOR_NAME=NOEDITRDB$GENERATOR_ID=TRUE FieldsVisible.StringsRDB$GENERATOR_NAME=TRUEGEN_VALUE=TRUErdb$db_key=FALSEdb_key=FALSE SQL.StringsSELECT RDB$GENERATOR_NAMEFROM RDB$GENERATORSWHERE RDB$SYSTEM_FLAG IS NULLORDER BY RDB$GENERATOR_NAME OnCalculateFieldqrGenInfCalculateFieldAutoFetchAll	ColorScheme	KeyLinks.StringsRDB$GENERATOR_NAME KeyLinksAutoDefineMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly AfterScrollqrGenInfAfterScrollBufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	Filtered	OnCustomEditqrGenInfCustomModifyOnCustomInsertqrGenInfCustomModifyOnFilterRecordqrRelInfFilterRecordLeftxTopX  TIB_DataSourcedsGenInfDatasetqrGenInfLeftxTop�   	TIB_Query	qrGenTrigFieldsDisplayLabel.Strings%rdb$trigger_name=TRIGGER DEPENDENCIESrdb$relation_name=RELATION NAME FieldsDisplayWidth.Stringsrdb$trigger_name=200rdb$relation_name=200 FieldsVisible.Stringsrdb$db_key=FALSEdb_key=FALSE SQL.Stringsselect rdb$trigger_name     , rdb$relation_namefrom rdb$triggers&where rdb$trigger_blr containing ?nameorder by rdb$trigger_name ColorSchemeKeyLinksAutoDefineMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly ReadOnly	BufferSynchroFlags FetchWholeRows	LeftTopX  	TIB_Query	qrGenProcFieldsDisplayLabel.Strings)rdb$procedure_name=PROCEDURE DEPENDENCIES FieldsVisible.Stringsrdb$db_key=FALSEdb_key=FALSE SQL.Stringsselect rdb$procedure_namefrom rdb$procedures(where rdb$procedure_blr containing ?nameorder by rdb$procedure_name ColorSchemeKeyLinksAutoDefineMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly ReadOnly	BufferSynchroFlags FetchWholeRows	Left�TopX  TIB_DataSource	dsGenProcDataset	qrGenProcLeft�Top�   TIB_DataSource	dsGenTrigDataset	qrGenTrigLeftTop�   	TIB_QueryqrUDFsCalculatedFields.StringsFUNCTION_NAME CHAR(31)ENTRYPOINT CHAR(31) ColumnAttributes.StringsRET=COMPUTED;BOOLEAN=0,1 FieldsDisplayLabel.Stringsfunction_name=NAME FieldsDisplayWidth.Stringsarg_type=81ret=27bytes=40mechanism=123library_name=100 FieldsIndex.Stringsfunction_name FieldsVisible.Stringsrdb$function_name=Frdb$argument_position=Frdb$entrypoint=Fz=fdb_key=FALSE SQL.Stringsselect f.rdb$function_name, fa.rdb$argument_position,&(select min(fa2.rdb$argument_position)from rdb$function_arguments fa28where fa2.rdb$function_name = f.rdb$function_name) as z,t.rdb$type_name as arg_type,Ecast(fa.rdb$argument_position - f.rdb$return_argument as int) as ret,fa.rdb$field_length as bytes,t2.rdb$type_name as mechanism,"f.rdb$module_name as library_name,f.rdb$entrypoint3from rdb$functions f join rdb$function_arguments fa-on f.rdb$function_name = fa.rdb$function_name7join rdb$types t on t.rdb$field_name = 'RDB$FIELD_TYPE'"and fa.rdb$field_type = t.rdb$type=left join rdb$types t2 on t2.rdb$field_name = 'RDB$MECHANISM'"and fa.rdb$mechanism = t2.rdb$type6order by f.rdb$function_name, fa.rdb$argument_position OnCalculateFieldqrUDFsCalculateFieldAutoFetchAll	ColorSchemeKeyLinks.Stringsrdb$functions.rdb$function_name,rdb$function_arguments.rdb$argument_position KeyLinksAutoDefineMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly BufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	Left@TopX  TIB_DataSourcedsUDFsDatasetqrUDFsLeft@Top�    