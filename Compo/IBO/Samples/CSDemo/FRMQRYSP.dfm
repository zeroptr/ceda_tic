?
 TFRMQUERYPROC 0?  TPF0TFrmQueryProcFrmQueryProcLeft? Top? Width?HeightoHintRExplore the Get_Emp_Proj procedure in the IBLOCAL alias to see the query procedureActiveControlPanel1CaptionEmployee Project AssignmentsFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height?	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterShowHint	OnCloseQueryFormCloseQueryOnHideFormHideOnShowFormShowPixelsPerInch`
TextHeight TPanelPanel1Left Top WidthHeight)AlignalTopTabOrder  TBitBtnBitBtn1Left9TopWidth<HeightHintExit and close this formCaptionE&xitTabOrder KindbkCloseStylebsNew  TIB_UpdateBarIB_UpdateBar1Left? TopWidth? HeightCtl3DParentCtl3DTabOrder
DataSourceDmEmployee.ibEmployeeSourceReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshKeysubRefreshRows   TIB_NavigationBarIB_NavigationBar1LeftTopWidthyHeightCtl3DParentCtl3DTabOrder
DataSourceDmEmployee.ibEmployeeSourceReceiveFocusCustomGlyphsSupplied    TPanelPanel2Left Top)WidthHeight? AlignalTop
BevelInner	bvLoweredBorderWidthCaptionPanel2TabOrder TIB_GridDBGrid1LeftTopWidthsHeight}Hint1Select an employee to execute the query procedureCustomGlyphsSupplied 
DataSourceEmployeeSourceAlignalClientFont.CharsetDEFAULT_CHARSET
Font.ColorclBlackFont.Height?	Font.NameMS Sans Serif
Font.Style 
ParentFontBorderStylebsNoneTabOrder CurrentRowFont.CharsetDEFAULT_CHARSETCurrentRowFont.ColorclWindowTextCurrentRowFont.Height?CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingFont.CharsetDEFAULT_CHARSETOrderingFont.ColorclWindowTextOrderingFont.Height?OrderingFont.NameMS Sans SerifOrderingFont.Style FixedFont.CharsetDEFAULT_CHARSETFixedFont.ColorclWindowTextFixedFont.Height?FixedFont.NameMS Sans SerifFixedFont.Style Ctl3DShallow	   TPanelPanel3Left Top? WidthHeight? AlignalClient
BevelInner	bvLoweredBorderWidthTabOrder TIB_CursorGridDBGrid2LeftTopWidthsHeight? Hint?Use SQL Monitor to see the Get_Emp_Proj query procedure executeAlignalClientBorderStylebsNoneColCountDefaultRowHeightDefaultDrawing	FixedCols RowCountTabOrder Ctl3DShallow	
DataSourceEmployeeProjectsSourceNullText<NULL>   
TStatusBar
StatusBar1Left TopAWidthHeightPanels SimplePanel	  
TIB_CursorEmployeeProjectsQueryDatabaseNameEMPLOYEEIB_ConnectionDmEmployee.cnEmployeeSQL.StringsSELECT PROJ_ID FROM Get_Emp_Proj( :EMP_NO )  AutoFetchAll	ColorSchemeMasterSourceEmployeeSourceMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly MasterParamLinks.StringsEmp_No=EMPLOYEE.EMP_NO RefreshOnParamChange	AfterFetchEof"EmployeeProjectsQueryAfterFetchEOFLeft? Top?   TIB_DataSourceEmployeeProjectsSourceDatasetEmployeeProjectsQueryLeft? Top   TIB_DataSourceEmployeeSourceLeft? TopH   