?
 TFRMRPL 0P  TPF0?TfrmRPLfrmRPLLeft? ToprHelpContext@Caption*InterBase Simple Replication Setup UtilityClientHeight%ClientWidthvConstraints.MinHeight?Constraints.MinWidthlOldCreateOrderOnCreate
FormCreate	OnDestroyFormDestroyOnResize
FormResizePixelsPerInch`
TextHeight ?
TStatusBar	StatusBarTopWidthv  ?TPanelpnCloseTop?Widthv ?TPanelpnOKCancelButtonsLeft6  ?TPanelpnApplyButtonLeft?  ?TPanelpnHelpButtonLeft&Visible	  ?TPanelpnBrowseButtonLeft?    ?TPageControlpcRPLLeft Top WidthvHeight?
ActivePagetsSyncEventsAlignalClientTabOrder 
OnChangingpcRPLChanging 	TTabSheettsLoadRPLBaseCaption-Connect and Load Replication Index Base Table TPanelPanel2Left Top WidthnHeight)AlignalTop
BevelOuter	bvLoweredTabOrder  TSpeedButton
btLoadBaseLeft?TopWidthqHeightCaptionLoad Base ( Step 1 )Flat	OnClickbtLoadBaseClick  TIB_UtilityBarubRPLLeftSTopWidthsHeightCustomGlyphsSupplied BaseKeySoftware\CPS\Apps\RPLBaseConnectioncRPLVisibleButtonswbBrowsewbDSQLwbPumpwbScript	wbExtract 
ShowGlyphs	Ctl3DParentCtl3DTabOrder  TIB_ConnectionBarIB_ConnectionBar1Left
TopWidthGHeightCtl3DParentCtl3DTabOrder CustomGlyphsSupplied IB_ConnectioncRPLReceiveFocusToggleConnect	VisibleButtonscbCreate	cbConnect    TPanelPanel3Left Top)WidthnHeightAlignalTop
BevelOuterbvNoneTabOrder  TPanelPanel11Left Top? WidthnHeightUAlignalTop
BevelOuter	bvLoweredTabOrder TLabelLabel9LeftTop#Width0HeightCaptionUsername  TLabelLabel10Left? Top#Width.HeightCaptionPassword  TSpeedButton
sbSourceDBLeft?TopWidthHeightCaption...OnClicksbTargetDBClick  TLabelLabel11Left? Top;Width&HeightCaptionCharSet  TLabelLabel12Left	Top;Width.HeightCaptionSQL Role  TLabelLabel13Left?Top;Width9HeightCaptionSQL Dialect  TLabelLabel8LeftTopWidth4HeightCaption	Source DB  TButtonButton1Left?Top WidthQHeightCaptionReplace GDBTabOrder Visible  TEditedSrcUsernameLeftDTop Width? HeightHelpContextnTabOrderTextSYSDBA  TEditedSrcPasswordLeftTop Width? HeightHelpContextsPasswordChar*TabOrder  	TComboBoxcbSrcDatabaseLeftDTopWidth?HeightHelpContexti
ItemHeightTabOrderOnChangecbSrcDatabaseChange  	TComboBoxcbSrcCharSetLeftTop8Width? HeightHelpContext}
ItemHeightTabOrderItems.StringsNONEOCTETSASCIIUNICODE_FSS	SJIS_0208	EUCJ_0208DOS437DOS850DOS865	ISO8859_1DOS852DOS857DOS860DOS861DOS863CYRLWIN1250WIN1251WIN1252WIN1253WIN1254NEXTKSC_5601BIG_5GB_2312   TEditedSrcSQLRoleLeftDTop8Width? HeightHelpContextxTabOrder  	TCheckBoxcbSrcRememberLeft?Top"WidthQHeightCaption	Remember?TabOrder  
TXSpinEditseSrcSQLDialectLeft?Top7Width(HeightMaxValueMinValueTabOrderValueOnChangecbSrcDatabaseChange   TPanel	pnColAttrLeft TopWidthnHeight? AlignalClient
BevelOuter	bvLoweredTabOrder TPanelPanel21LeftTopWidthTHeight^AlignalClientTabOrder  TMemomeSrcColAttrLeftTopWidthRHeightDAlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFont
ScrollBars
ssVerticalTabOrder WordWrapOnChangemeColAttrChange  TPanelPanel24LeftTopWidthRHeightAlignalTop
BevelOuterbvNoneCaptionSource Column AttributesTabOrder   TPanelpnTargetColAttrLeftTopWidthHeight^AlignalLeftTabOrder TMemo	meColAttrLeftTopWidthHeightDAlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFont
ScrollBars
ssVerticalTabOrder WordWrapOnChangemeColAttrChange  TPanelPanel23LeftTopWidthHeightAlignalTop
BevelOuterbvNoneCaptionTarget Column AttributesTabOrder    TPanelPanel15Left Top? WidthnHeightAlignalTop
BevelOuterbvNoneTabOrder  TPanelPanel1Left Top,WidthnHeightUAlignalTop
BevelOuter	bvLoweredTabOrder TLabelLabel14LeftTop#Width0HeightCaptionUsername  TLabelLabel15Left? Top#Width.HeightCaptionPassword  TSpeedButton
sbTargetDBLeft?TopWidthHeightCaption...OnClicksbTargetDBClick  TLabelLabel16Left? Top;Width&HeightCaptionCharSet  TLabelLabel17Left	Top;Width.HeightCaptionSQL Role  TLabelLabel18Left?Top;Width9HeightCaptionSQL Dialect  TLabelLabel1LeftTopWidth1HeightCaption	Target DB  TButtonButton2Left?Top WidthQHeightCaptionReplace GDBTabOrder Visible  TEdit
edUsernameLeftDTop Width? HeightHelpContextnTabOrderTextSYSDBA  TEdit
edPasswordLeftTop Width? HeightHelpContextsPasswordChar*TabOrder  	TComboBox
cbDatabaseLeftDTopWidth?HeightHelpContexti
ItemHeightTabOrderOnChangecbDatabaseChange  	TComboBox	cbCharSetLeftTop8Width? HeightHelpContext}
ItemHeightTabOrderItems.StringsNONEOCTETSASCIIUNICODE_FSS	SJIS_0208	EUCJ_0208DOS437DOS850DOS865	ISO8859_1DOS852DOS857DOS860DOS861DOS863CYRLWIN1250WIN1251WIN1252WIN1253WIN1254NEXTKSC_5601BIG_5GB_2312   TEdit	edSQLRoleLeftDTop8Width? HeightHelpContextxTabOrder  	TCheckBox
cbRememberLeft?Top"WidthQHeightCaption	Remember?TabOrder  
TXSpinEditseSQLDialectLeft?Top7Width(HeightMaxValueMinValueTabOrderValueOnChangecbSrcDatabaseChange   TPanelPanel10Left Top? WidthnHeightAlignalTop
BevelOuterbvNoneTabOrder  TPanelPanel16Left Top? WidthnHeight)AlignalTop
BevelOuter	bvLoweredTabOrder TIB_UtilityBarubSRCLeftSTopWidth?HeightCustomGlyphsSupplied BaseKeySoftware\CPS\Apps\RPLBaseConnectioncSrcBaseTransactiontINDVisibleButtonswbBrowsewbDSQLwbPumpwbScript	wbExtract	wbMonitorwbStatus 
ShowGlyphs	Ctl3DParentCtl3DTabOrder  TIB_ConnectionBarIB_ConnectionBar2Left
TopWidthGHeightCtl3DParentCtl3DTabOrder CustomGlyphsSupplied IB_ConnectioncSrcReceiveFocusToggleConnect	VisibleButtons	cbConnect    TPanelPanel17Left TopWidthnHeightAlignalTop
BevelOuterbvNoneTabOrder   	TTabSheettsLoadIndexHelpContextDCaption&Configure and Load Replication Indexes
ImageIndex TPanelPanel6Left Top WidthnHeight)AlignalTop
BevelOuter	bvLoweredTabOrder  TSpeedButton
btLoadMetaLeft(TopWidth? HeightCaptionLoad  Metadata ( Step 2 )Flat	OnClickbtLoadMetaClick  TSpeedButton
sbActivateLeft?TopWidth? HeightCaptionActivate Index ( Step 3 )Flat	OnClicksbActivateClick  TSpeedButtonsbExportLeft? TopWidth? HeightCaptionExport Index DefinitionsFlat	OnClicksbExportClick  TIB_UpdateBarIB_UpdateBar1Left
TopWidth? HeightCtl3DParentCtl3DTabOrder 
DataSourcedINDReceiveFocusCustomGlyphsSupplied    TPanelPanel7Left Top)WidthnHeightAlignalTop
BevelOuterbvNoneTabOrder  TIB_GridgrINDLeft Top,Width? Height?CustomGlyphsSupplied 
DataSourcedINDAlignalLeftPreventEditing	TabOrderListBoxStyle	GridLinks.StringsRPL$ind_nme Ctl3DShallow	StretchColumnRPL$IND_NMETabMovesOut	  TPageControl
pcMetadataLeft? Top,Width?Height?
ActivePagetsColumnMappingsAlignalClientTabOrder 	TTabSheettsColumnMappingsCaptionColumn Mappings 	TSplitter	Splitter1Left Top7Width?HeightCursorcrVSplitAlignalTop  	TSplitter	Splitter2Left TopWidth?HeightCursorcrVSplitAlignalTop  TPanelpnSourceLeft Top Width?HeightoAlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder  TLabellbTblLeftTop#Width_HeightCaptionSource Table NameFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style 
ParentFont  TLabelLabel6LeftTop;WidthbHeightCaptionSource Key Columns  TLabelLabel7LeftTopWidth>HeightCaptionIndex Status:  TIB_TextlbStatusLeftxTopWidth(Height	DataField
RPL$STATUS
DataSourcedIND  TLabellbSrcDataColumnsLeftTopSWidthgHeightCaptionSource Data Columns  TIB_EditedSrcTableNameLeftxTop Width1Height	DataFieldRPL$SRC_TBL_NME
DataSourcedINDTabOrder   TIB_EditedSrcKeyColumnsLeftxTop8Width1Height	DataFieldRPL$SRC_KEY_CLS
DataSourcedINDTabOrder  TIB_EditedSrcDataColumnsLeftxTopPWidth1Height	DataFieldRPL$SRC_CLS
DataSourcedINDTabOrder   TPanelPanel4Left TopoWidth?Height? AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredConstraints.MinHeight? TabOrder TLabellbDstTblNmeLeftTopWidth\HeightCaptionTarget Table Name  TLabellbDstKeyColumnsLeftTop*Width_HeightCaptionTarget Key Columns  TLabellbTargetDataColumnsLeftTopBWidthdHeightCaptionTarget Data Columns  TLabellbDst2SrcMapLeftTopZWidthlHeightCaptionTarget To Source Map  TIB_EditedDstTblNmeLeftxTopWidth1Height	DataFieldRPL$DST_TBL_NME
DataSourcedINDTabOrder   TIB_EditedDstKeyColumnsLeftxTop(Width1Height	DataFieldRPL$DST_KEY_CLS
DataSourcedINDTabOrder  TIB_EditedTargetDataColumnsLeftxTop@Width1Height	DataFieldRPL$DST_CLS
DataSourcedINDTabOrder  TIB_MemomeDst2SrcMapLeftxTopXWidth1Heightb	DataFieldRPL$DST_SRC_CLS_MAP
DataSourcedINDAnchorsakLeftakTopakBottom TabOrderAutoSize
ScrollBars
ssVerticalWordWrap   TPanelPanel14Left Top:Width?Height? AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredConstraints.MinHeight? TabOrder TLabelLabel5LeftTop.WidthbHeightCaptionTarget Table Source  TIB_CheckBoxIB_CheckBox1LeftxTopWidth? Height	DataFieldRPL$DST_TBL_CREATE
DataSourcedINDParentColorTabOrder CaptionAuto Create Table?  TIB_MemomeDstTblSrcLeftxTop,Width1Height? HelpContextJ	DataFieldRPL$DST_TBL_SRC
DataSourcedINDAnchorsakLeftakTopakBottom Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrderAutoSize
ScrollBars
ssVerticalWordWrap  TIB_CheckBoxcbUseSourceDomainsLeftTopWidth? Height	DataFieldRPL$DST_TBL_CREATE
DataSourcedINDParentColorVisibleTabOrderCaptionUse Source Domains?    	TTabSheettsRowColExprCaptionRow and Column Expressions
ImageIndex TPanelPanel20Left Top Width?Height	AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder  TLabelLabel2LeftTopWidthgHeightCaptionSource Inclusion Expr  TLabelLabel3LeftTop_WidthfHeightCaptionSource Updated Expr  TLabelLabel22LeftTop? WidthgHeightCaptionTarget Exclusion Expr  TIB_MemoedSrcAddExpLeftxTopWidthCHeightPHelpContextJ	DataFieldRPL$SRC_ADD_EXP
DataSourcedINDAnchorsakLeftakTopakRight Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize
ScrollBars
ssVerticalWordWrap  TIB_MemoedSrcUpdExpLeftxTop\WidthCHeightPHelpContextJ	DataFieldRPL$SRC_UPD_EXP
DataSourcedINDAnchorsakLeftakTopakRight Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrderAutoSize
ScrollBars
ssVerticalWordWrap  TIB_MemoedDstDelExpLeftxTop? WidthCHeightPHelpContextL	DataFieldRPL$DST_DEL_EXP
DataSourcedINDAnchorsakLeftakTopakRight Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrderAutoSize
ScrollBars
ssVerticalWordWrap    	TTabSheettsCustTriggerCaptionCustom Triggers
ImageIndex 	TSplitter	Splitter5Left Top? Width?HeightCursorcrVSplitAlignalTop  	TSplitter	Splitter6Left Top1Width?HeightCursorcrVSplitAlignalTop  	TSplitter	Splitter7Left Top?Width?HeightCursorcrVSplitAlignalTop  TPanelpnCustTrigDecVarLeft Top Width?HeightiAlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder  TLabelLabel24LeftTopWidthcHeightCaptionCustom Declare Vars  TIB_MemomeCustTrigDecVarLeftxTopWidthCHeightZHelpContextL	DataFieldRPL$SRC_TRG_DEC_VAR
DataSourcedINDAnchorsakLeftakTopakRight Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize
ScrollBars
ssVerticalWordWrap   TPanelpnCustTrigInsQLeft TopiWidth?Height? AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredConstraints.MinHeight? TabOrder TLabelLabel26LeftTopWidth? HeightCaption*Custom Trigger to put an Insert into the Q  TIB_MemomeCustTrigInsQLeftTopWidth?HeightnHelpContextL	DataFieldRPL$SRC_TRG_INS_Q
DataSourcedINDAnchorsakLeftakTopakRightakBottom Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize
ScrollBars
ssVerticalWordWrap   TPanelpnCustTrigDelQLeft Top?Width?Height? AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredConstraints.MinHeight? TabOrder TLabelLabel27LeftTopWidth? HeightCaption)Custom Trigger to put a Delete into the Q  TIB_MemomeCustTrigDelQLeftTopWidth?HeightnHelpContextL	DataFieldRPL$SRC_TRG_DEL_Q
DataSourcedINDAnchorsakLeftakTopakRightakBottom Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize
ScrollBars
ssVerticalWordWrap   TPanelpnCustTrigUpdQLeft TopWidth?Height? AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredConstraints.MinHeight? TabOrder TLabelLabel28LeftTopWidth? HeightCaption*Custom Trigger to put an Update into the Q  TIB_MemomeCustTrigUpdQLeftTopWidth?HeightnHelpContextL	DataFieldRPL$SRC_TRG_UPD_Q
DataSourcedINDAnchorsakLeftakTopakRightakBottom Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize
ScrollBars
ssVerticalWordWrap    	TTabSheettsCustomProcsCaptionCustom Procedures
ImageIndex 	TSplitter	Splitter3Left Top^Width?HeightCursorcrVSplitAlignalTop  	TSplitter	Splitter4Left Top?Width?HeightCursorcrVSplitAlignalTop  TPanelpnCustSendProcDecVarsLeft Top Width?Height? AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredTabOrder  TLabelLabel19LeftTopWidthcHeightCaptionCustom Declare Vars  TLabelLabel20LeftTopiWidthLHeightCaptionCustom Init Vars  TIB_MemomeSrcProcVarsLeftxTopWidthCHeightZHelpContextL	DataFieldRPL$SRC_PRC_DEC_VAR
DataSourcedINDAnchorsakLeftakTopakRight Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize
ScrollBars
ssVerticalWordWrap  TIB_MemomeSrcPrcVarInitLeftxTopfWidthCHeightZHelpContextL	DataFieldRPL$SRC_PRC_VAR_INIT
DataSourcedINDAnchorsakLeftakTopakRight Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrderAutoSize
ScrollBars
ssVerticalWordWrap   TPanelpnCustSendQProcLeft Top? Width?Height? AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredConstraints.MinHeight? TabOrder TLabelLabel4LeftTopWidth~HeightCaptionCustom Send Q Procedure  TIB_MemomeSrcPrcSrcQLeftTopWidth?HeightnHelpContextL	DataFieldRPL$SRC_PRC_SRC_Q
DataSourcedINDAnchorsakLeftakTopakRightakBottom Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize
ScrollBars
ssVerticalWordWrap   TPanelpnCustSendFullProcLeft TopaWidth?Height? AlignalTop
BevelInnerbvRaised
BevelOuter	bvLoweredConstraints.MinHeight? TabOrder TLabelLabel21LeftTopWidth? HeightCaptionCustom Send Full Procedure  TIB_MemomeSrcPrcSrcFullLeftTopWidth?HeightnHelpContextL	DataFieldRPL$SRC_PRC_SRC_FULL
DataSourcedINDAnchorsakLeftakTopakRightakBottom Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFontTabOrder AutoSize
ScrollBars
ssVerticalWordWrap      	TTabSheettsMaintainRPLCaptionMaintain Index
ImageIndex
TabVisible  	TTabSheettsActivateRPLCaptionActivate Index
ImageIndex
TabVisible TPanelPanel5Left Top WidthHHeight)AlignalTop
BevelOuter	bvLoweredTabOrder   TPanelPanel8Left Top)WidthHHeightAlignalTop
BevelOuterbvNoneTabOrder  TPanelPanel9Left Top,WidthHHeight? AlignalClient
BevelOuter	bvLoweredCaption//TabOrder   	TTabSheettsSyncEventsCaptionSyncronization Events Log
ImageIndex TMemomeSyncEvLogLeft Top,WidthnHeight?AlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height?	Font.NameCourier New
Font.Style 
ParentFont
ScrollBarsssBothTabOrder WordWrapOnClickbtApplyClick  TPanelPanel12Left Top WidthnHeight)AlignalTop
BevelOuter	bvLoweredTabOrder TSpeedButtonsbResyncQueueLeft? TopWidthqHeightCaption&Resync QueueFlat	OnClicksbResyncQueueClick  TSpeedButtonsbResyncIndexLeft TopWidthqHeightCaptionResync &IndexFlat	OnClicksbResyncIndexClick  TSpeedButtonsbClearSyncLogLeft?TopWidthqHeightCaption
Clear &LogFlat	OnClicksbClearSyncLogClick  	TCheckBoxcbListenLeftTopWidthhHeightCaptionListen for EventsTabOrder OnClickcbListenClick   TPanelPanel13Left Top)WidthnHeightAlignalTop
BevelOuterbvNoneTabOrder    ?TIB_SessionPropsspAllowDefaultConnectionAllowDefaultTransaction
BusyCursor?StoreActiveTimerInterval?	UseCursor	YieldCursor?EditingColorclYellowInsertingColorclLimeDeletingColorclRedSearchingColorclAquaReadOnlyColorclSilverSelectedColorclBlueInvalidColorclNonePreparedColor
clGrayTextBrowsingColorclWindowLeftHTop@  ?TIB_TransactionSourcetsBaseIB_TransactiontINDLeftTop?  ?TIB_ConnectionSourcecsBaseIB_ConnectioncRPLLeftTop?   TIB_ConnectioncRPLCacheStatementHandlesFieldEntryTypesfetDomainName DefaultValues.StringsRPL$DST_TBL_CREATE=T DatabaseNameRPLParams.StringsPATH=d:\ibdb\rpl_test.gdb BeforeConnectcRPLBeforeConnectAfterConnectcRPLAfterConnectAfterDisconnectcAfterDisconnectLeftToph  TOpenDialogodGDB
DefaultExtGDBFilterInterBase File < *.GDB >|*.GDBTitleInterBase FileLeftTop@  	TIB_QueryqINDColumnAttributes.StringsRPL$LOG=BOOLEANRPL$DST_TBL_CREATE=BOOLEAN DatabaseNameRPLFieldsCharCase.StringsRPL$IND_NME=UPPER FieldsDisplayLabel.StringsRPL$IND_NME=Index Name IB_ConnectioncRPLIB_TransactiontINDSQL.Stringsselect *from RPL$_IND
for update AutoFetchAll	ColorScheme	DefaultValues.StringsRPL$STATUS=I	RPL$LOG=T MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly RefreshActionraKeepDataPosRequestLive		AfterPostqINDAfterPostAfterScrollqINDAfterScroll
BeforePostqINDBeforePostOnGetCanModifyqINDGetCanModifyBufferSynchroFlags CommitAction
caFetchAllFetchWholeRows	LeftHTopp  TIB_DataSourcedINDDatasetqINDOnDataChangedINDDataChangeLeftHTop?  TIB_ConnectioncSrcCacheStatementHandlesParams.StringsPATH=D:\ibdb\employee.gdb BeforeConnectcSrcBeforeConnectAfterConnectcSrcAfterConnectLeftTop?   TIB_RPL_MetarplMetaIB_ConnectioncRPLPassive	IB_ConnectionSrccSrcInterval UseDefaultWakeup	OnLogItemLogSyncItemLeftpTopp  TIB_TransactiontINDIB_ConnectioncRPLIB_Connection1cSrc
AutoCommit		IsolationtiCommittedTimeoutProps.AllowCheckOAT TimeoutProps.Attempt TimeoutProps.AttemptMaxRows LeftTopp   