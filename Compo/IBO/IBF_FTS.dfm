?
 TFRMFTS 0?9  TPF0?TfrmFTSfrmFTSLeftTopTCaption%InterBase Full Text Searching UtilityClientHeightNClientWidthPOnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight ?
TStatusBar	StatusBarTop;WidthP  ?TPanelpnCloseTopWidthP ?TPanelpnOKCancelButtonsLeft  ?TPanelpnApplyButtonLeft?  ?TPanelpnHelpButtonLeft Visible	  ?TPanelpnBrowseButtonLeft?    ?TPageControlpcFTSLeft Top WidthPHeight
ActivePagetsSyncEventsAlignalClientTabOrder OnChangepcFTSChange
OnChangingpcFTSChanging 	TTabSheettsLoadFTSBaseCaption	Load Base TPanelPanel2Left Top WidthHHeight)AlignalTop
BevelOuter	bvLoweredTabOrder  TSpeedButton
btLoadBaseLeft?TopWidthnHeightCaptionLoad Base ( Step 1 )Flat	OnClickbtLoadBaseClick  TIB_UtilityBarIB_UtilityBar1LeftUTopWidthUHeightCustomGlyphsSupplied BaseKeySoftware\CPS\Apps\FTSBaseConnectioncFTSVisibleButtonswbBrowsewbPumpwbScript	wbMonitorwbStatus 
ShowGlyphs	Ctl3DParentCtl3DTabOrder  TIB_ConnectionBarIB_ConnectionBar1Left
TopWidth@HeightCtl3DParentCtl3DTabOrder CustomGlyphsSupplied IB_ConnectioncFTSReceiveFocusToggleConnect	VisibleButtons	cbConnect    TPanelPanel1Left Top,WidthHHeight? AlignalClient
BevelOuter	bvLoweredTabOrder TLabelLabel2LeftTopWidth.HeightCaptionDatabase  TLabelLabel3LeftTop#Width0HeightCaptionUsername  TLabelLabel4Left? Top#Width.HeightCaptionPassword  TSpeedButtonSpeedButton1Left?TopWidthHeightCaption...OnClickSpeedButton1Click  TLabel	lbCharSetLeft? Top;Width&HeightCaptionCharSet  TLabel	lbSQLRoleLeft	Top;Width.HeightCaptionSQL Role  TLabellbSQLDialectLeft?Top;Width9HeightCaptionSQL Dialect  TEdit
edUsernameLeftDTop Width? HeightHelpContextnTabOrderTextSYSDBA  TEdit
edPasswordLeftTop Width? HeightHelpContextsPasswordChar*TabOrder  	TComboBox
cbDatabaseLeftDTopWidth?HeightHelpContexti
ItemHeightTabOrder OnChangecbDatabaseChange  	TComboBox	cbCharSetLeftTop8Width? HeightHelpContext}
ItemHeightItems.Strings NONEOCTETSASCIIUNICODE_FSS	SJIS_0208	EUCJ_0208DOS437DOS850DOS865	ISO8859_1DOS852DOS857DOS860DOS861DOS863CYRLWIN1250WIN1251WIN1252WIN1253WIN1254NEXTKSC_5601BIG_5GB_2312 TabOrder  TEdit	edSQLRoleLeftDTop8Width? HeightHelpContextxTabOrder  TButtonbtReplaceGDBLeft? Top`WidthQHeightCaptionReplace GDBTabOrderVisibleOnClickbtReplaceGDBClick  	TCheckBox
cbRememberLeft?Top"WidthQHeightCaption	Remember?TabOrder  
TXSpinEditseSQLDialectLeft?Top7Width(HeightMaxValueMinValueTabOrderValueOnChangecbDatabaseChange   TPanelPanel3Left Top)WidthHHeightAlignalTop
BevelOuterbvNoneTabOrder   	TTabSheettsLoadIndexCaptionLoad Indexes TPanelPanel6Left Top WidthHHeight)AlignalTop
BevelOuter	bvLoweredTabOrder TSpeedButton
btLoadMetaLeft? TopWidth? HeightCaptionLoad  Metadata ( Step 2 )Flat	OnClickbtLoadMetaClick  TSpeedButton
sbPopulateLeft)TopWidth? HeightCaptionPopulate Data ( Step 3 )Flat	OnClicksbPopulateClick  TSpeedButtonsbActiveIndexLeft?TopWidth? HeightCaptionActivate Index ( Step 4 )Flat	OnClicksbActiveIndexClick  TIB_UpdateBarIB_UpdateBar1Left
TopWidth? HeightCtl3DParentCtl3DTabOrder 
DataSourcedINDReceiveFocusCustomGlyphsSupplied    TPanelPanel7Left Top)WidthHHeightAlignalTop
BevelOuterbvNoneTabOrder  TPanelPanel4Left? Top,Width?Height? AlignalClient
BevelOuter	bvLoweredTabOrder TLabellbTblLeft	Top
WidthVHeightCaptionTable.Key Column  TLabellbTxtLeft	Top"WidthHHeightCaptionSearch Column  TLabelLabel8Left	TopjWidthUHeightCaptionMax Word Length  TLabelLabel5Left	TopRWidth]HeightCaptionMax Search Length  TLabel	lbUSR_LENLeft	Top? WidthYHeightCaptionUser Name Length  TLabelLabel6Left	Top? WidthRHeightCaptionMin Word Length  TIB_TextlbSTATUSLeftlTop? WidthAHeight	DataField
FTS$STATUS
DataSourcedIND  TLabelLabel7Left	Top? Width;HeightCaptionIndex Status  TLabellbAuxColLeft	Top:WidthLHeightCaptionAuxillary Column  	TComboBoxcbTblLeftlTopWidth=HeightStylecsDropDownList
ItemHeightTabOrder   TIB_ComboBoxcbTxtLeftlTop WidthHeight	DataFieldFTS$SCH_COL
DataSourcedINDPreventEditing	TabOrderStylecsDropDownList
ItemHeight  TIB_ComboBoxcbAuxLeftlTop8WidthHeight	DataFieldFTS$AUX_COL
DataSourcedINDPreventEditing	TabOrderStylecsDropDownList
ItemHeight  
TXSpinEdit	seWRD_LENLeftlTophWidth@HeightMaxValuedMinValue
TabOrderValueOnExitseTblChange
OnKeyPress
seKeyPress	OnMouseUp	seMouseUp  
TXSpinEdit	seSCH_LENLeftlTopPWidth@HeightMaxValue,MinValue
TabOrderValue? OnExitseTblChange
OnKeyPress
seKeyPress	OnMouseUp	seMouseUp  
TXSpinEdit	seUSR_LENLeftlTop? Width@HeightMaxValue? MinValue
TabOrderValue OnExitseTblChange
OnKeyPress
seKeyPress	OnMouseUp	seMouseUp  
TXSpinEdit	seMIN_LENLeftlTop? Width@HeightMaxValue	MinValueTabOrderValueOnExitseTblChange
OnKeyPress
seKeyPress	OnMouseUp	seMouseUp   TIB_GridIB_Grid1Left Top,Width? Height? CustomGlyphsSupplied 
DataSourcedINDAlignalLeftPreventEditing	TabOrder ListBoxStyle	GridLinks.StringsFTS$ind_nme Ctl3DShallow	StretchColumnFTS$IND_NME   	TTabSheettsMaintainFTSCaptionMaintain Index
TabVisible  	TTabSheettsPopulateFTSCaptionPopulate Index
TabVisible TPanelPanel5Left Top WidthHHeight)AlignalTop
BevelOuter	bvLoweredTabOrder   TPanelPanel8Left Top)WidthHHeightAlignalTop
BevelOuterbvNoneTabOrder  TPanelPanel9Left Top,WidthHHeight? AlignalClient
BevelOuter	bvLoweredCaption//TabOrder   	TTabSheettsSearchFTSCaptionSearch Index TIB_GridgrNameSearchLeft Top)WidthHHeight? TabStopCustomGlyphsSupplied 
DataSourcedsFTSAlignalClientTabOrder FixedDataColsListBoxStyle	DrawCellTextOptionsgdtShowTextBlob Ctl3DShallow	StretchColumnfullname  TPanelpnNameSearchLeft Top WidthHHeight)AlignalTop
BevelOuter	bvLoweredTabOrder TLabelLabel1LeftTopWidthHeightCaption&WordsFocusControledNameSearch  TIB_EditedNameSearchLeft.Top
Width? Height
DataSourcedsFTSOnPrepareSQLedNameSearchPrepareSQLSearchAlways	TabOrder 
OnKeyPressedNameSearchKeyPress  	TCheckBox	cbSoundexLeft$TopWidthAHeightCaptionSoundE&xTabOrderOnClickcbTypeClick  	TCheckBoxcbMetaphoneLeft$TopWidthKHeightCaption
&MetaphoneTabOrderOnClickcbTypeClick  	TCheckBox	cbSynonymLeftuTopWidthDHeightCaption&SynonymTabOrderOnClickcbTypeClick  	TCheckBox	cbPartialLeft?TopWidth6HeightCaption&PartialChecked	State	cbCheckedTabOrderOnClickcbTypeClick  	TCheckBox	cbAntonymLeftuTopWidthDHeightCaption&AntonymTabOrderOnClickcbTypeClick    	TTabSheettsSearchLogCaptionSearch Log && Statistics 
TIB_LedgerlgSearchLogLeft Top WidthHHeight? dpGridInSyncWithScrollBar	dpAlwaysShowScrollBar	TrackWithScrollBar
DataSourcedsLOGCurrentRowColorclInfoBkRowDefsCellDefsWidth? 	FieldName	FTS$WORDSDispNameWORDS 	WidthTypelaFixedWidthA	FieldNameFTS$MATCHESDispNameMATCHES	AlignmenttaRightJustify 	WidthTypelaFixedWidthA	FieldName	FTS$TICKSDispNameTICKS	AlignmenttaRightJustify Widthd	FieldNameFTS$USERNAMEDispNameUSERNAME WidthK	FieldNameFTS$SCH_DATEDispNameDATE  Color???  CellDefsWidthd	FieldNameFTS$BUFFERREADSDispNameBUFFER READS Widthd	FieldNameFTS$PAGEREADSDispName
PAGE READS  Color???  CellDefsWidthK	FieldName
FTS$WRD_01DispNameWORD1 Width	FieldName
FTS$CNT_01DispNameCNT Width	FieldName
FTS$TYP_01DispNameTYP WidthK	FieldName
FTS$WRD_02DispNameWORD2 Width	FieldName
FTS$CNT_02DispNameCNT Width	FieldName
FTS$TYP_02DispNameTYP WidthJ	FieldName
FTS$WRD_03DispNameWORD3 Width	FieldName
FTS$CNT_03DispNameCNT Width	FieldName
FTS$TYP_03DispNameTYP  Color?܋   	RowHeightVerticalLinesAlignalClientParentColor	TabOrder    	TTabSheettsThesaurusCaption	Thesaurus TIB_GridgrTHSLeft? TopPWidth? HeightaCustomGlyphsSupplied 
DataSourcedsTHSTabOrder ListBoxStyle	Ctl3DShallow	  TPanelPanel10Left Top WidthHHeight)AlignalTop
BevelOuter	bvLoweredTabOrder TIB_SearchBarIB_SearchBar1LeftTopWidthyHeightCtl3DParentCtl3DTabOrder 
DataSourcedsTHSReceiveFocusCustomGlyphsSupplied   TIB_NavigationBarIB_NavigationBar1Left? TopWidthyHeightCtl3DParentCtl3DTabOrder
DataSourcedsTHSReceiveFocusCustomGlyphsSupplied   TIB_UpdateBarIB_UpdateBar2LeftTopWidthyHeightCtl3DParentCtl3DTabOrder
DataSourcedsTHSReceiveFocusCustomGlyphsSupplied   TIB_TransactionBarIB_TransactionBar1Left?TopWidthYHeightCtl3DParentCtl3DTabOrderCustomGlyphsSupplied IB_TransactiontrTHSReceiveFocus   TPanelPanel11Left Top)WidthHHeightAlignalTop
BevelOuterbvNoneTabOrder  TIB_SearchPanelspTHSLeftXTopPWidth? HeightaTabOrder
DataSourcedsTHSEditLeft 
DualColumn   	TTabSheettsSyncEventsCaptionSync Events Log TMemomeSyncEvLogLeft Top,WidthHHeight? AlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFont
ScrollBarsssBothTabOrder WordWrapOnClickbtApplyClick  TPanelPanel12Left Top WidthHHeight)AlignalTop
BevelOuter	bvLoweredTabOrder TSpeedButtonsbResyncQueueLeft? TopWidthUHeightCaption&Resync QueueFlat	OnClicksbResyncQueueClick  TSpeedButtonsbResyncIndexLeft? TopWidthUHeightCaptionResync &IndexFlat	OnClicksbResyncIndexClick  TSpeedButtonsbCleanIndexLeft@TopWidthUHeightCaption&Clean IndexFlat	OnClicksbCleanIndexClick  TSpeedButtonsbClearSyncLogLeft?TopWidthUHeightCaption
Clear &LogFlat	OnClicksbCleanIndexClick  	TCheckBoxcbListenLeftTopWidthhHeightCaptionListen for EventsTabOrder OnClickcbListenClick   TPanelPanel13Left Top)WidthHHeightAlignalTop
BevelOuterbvNoneTabOrder    ?TIB_SessionPropsspAllowDefaultConnection	AllowDefaultTransaction	
BusyCursor?StoreActiveTimerInterval?	UseCursorYieldCursor?EditingColorclYellowInsertingColorclLimeDeletingColorclRedSearchingColorclAquaReadOnlyColorclSilverSelectedColorclBlueInvalidColorclNonePreparedColor
clGrayTextBrowsingColorclWindowLeftTop@  ?TIB_TransactionSourcetsBaseIB_TransactiontFTSLeftpTop@  ?TIB_ConnectionSourcecsBaseIB_ConnectioncFTSLeftPTop@  TIB_ConnectioncFTSCacheStatementHandlesFieldEntryTypesfetDomainName ColumnAttributes.StringsFTS$DATE_DM=NOTIME FieldsCharCase.StringsFTS$FMF_KEY_TYP_DM=UFTS$FMF_USR_DM=UFTS$FMF_WDS_TYP_DM=UFTS$FMF_WRD_DM=UFTS$IDENT_DM=UFTS$IND_NME_DM=UFTS$IND_STATUS_DM=UFTS$JOB_TYP_DM=UFTS$Q_TYP_DM=UFTS$SCH_TYP_DM=U DatabaseNameFTSParams.StringsPATH=d:\IBDB\FELONSFTS.GDB BeforeConnectcFTSBeforeConnectAfterConnectcFTSAfterConnectAfterDisconnectcFTSAfterDisconnectLeftTopp  	TIB_QueryqFTSDatabaseNameFTSIB_ConnectioncFTSSQL.StringsSELECT // distinct  <<KEY_COL>>, <<SCH_COL>>FROM <<TBL_NME>> BeforeExecuteqFTSBeforeExecuteAfterExecuteqFTSAfterExecuteColorScheme	KeyLinks.Strings<<TBL_NME>>.<<KEY_COL>> KeyLinksAutoDefineKeyRelation<<TBL_NME>>MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly PreventEditing	PreventInserting	PreventDeleting	
OnCallbackqFTSCallbackBufferSynchroFlags FetchWholeRows	Left0Top?   TIB_DataSourcedsFTSDatasetqFTSLeft0Top?   TIB_TransactiontFTSIB_ConnectioncFTS	IsolationtiConcurrencyLeft0Topp  
TIB_CursorcrTXTDatabaseNameFTSIB_ConnectioncFTSColorSchemeMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly LeftpTopp  TOpenDialogodGDB
DefaultExtGDBFilterInterBase File < *.GDB >|*.GDBTitleInterBase FileLeftPTopp  	TIB_QueryqINDColumnAttributes.StringsFTS$LOG=BOOLEAN DatabaseNameFTSFieldsCharCase.StringsFTS$IND_NME=UPPER FieldsDisplayLabel.StringsFTS$IND_NME=Index Name IB_ConnectioncFTSSQL.Stringsselect *from FTS$_IND
for update AutoFetchAll	ColorSchemeDefaultValues.StringsFTS$SCH_LEN=200FTS$WRD_LEN=30FTS$USR_LEN=32FTS$STATUS=I	FTS$LOG=TFTS$MIN_LEN=2 MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly RefreshActionraKeepDataPosRequestLive	AfterInsertqINDAfterInsert	AfterPostqINDAfterPostAfterScrollqINDAfterScroll
BeforePostqINDBeforePostOnGetCanModifyqINDGetCanModifyBufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	LeftPTop?   TIB_DataSourcedINDDatasetqINDOnDataChangedINDDataChangeOnUpdateDatadINDUpdateDataLeftPTop?   	TIB_QueryqLOGDatabaseNameFTSIB_ConnectioncFTSSQL.StringsSELECT *FROM FTS$F_SCH_LOG//FROM FTS$<<IND_NME>>$SCH_LOG ColorSchemeMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly BufferSynchroFlags FetchWholeRows	LeftpTop?   	TIB_QueryqTHSDatabaseNameFTSFieldsCharCase.StringsFTS$WRD=UPPERFTS$SYN=UPPERFTS$ANT=UPPER FieldsDisplayLabel.StringsFTS$WRD=WordFTS$SYN=SynonymFTS$ANT=Antonym IB_ConnectioncFTSIB_TransactiontrTHSSQL.Stringsselect *from FTS$<<IND_NME>>$thsorder by FTS$wrd ColorScheme	MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly RequestLive	BufferSynchroFlags CachedUpdates	CommitActioncaInvalidateCursorFetchWholeRows	LeftpTop?   TIB_DataSourcedsLOGDatasetqLOGLeftpTop?   TIB_DataSourcedsTHSDatasetqTHSOnStateChangeddsTHSStateChangedLeftpTop?   TIB_FTS_SyncftsSyncIB_ConnectioncFTSInterval Passive	OnModifySearchWordsDoModifySearchWords	OnLogItemLogSyncItemLeftTop?   TIB_FTS_Search	ftsSearchIB_ConnectioncFTSOnModifySearchWordsDoModifySearchWordsLeft?Top?   TIB_FTS_MetaftsMetaIB_ConnectioncFTSLeft?Top?   TIB_TransactiontrTHSIB_ConnectioncFTS	IsolationtiCommittedLeftpTopp   