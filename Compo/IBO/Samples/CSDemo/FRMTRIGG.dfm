�
 TFRMTRIGGERDEMO 0

  TPF0TFrmTriggerDemoFrmTriggerDemoLeft� Top	Width�HeightZHint4Explore the EmployeeTable to see the trigger sourcesActiveControlPanel1CaptionSalary Change Auditing
Font.ColorclBlackFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterShowHint	OnCloseQueryFormCloseQueryOnShowFormShowPixelsPerInch`
TextHeight TPanelPanel1Left Top WidthHeight)AlignalTopTabOrder  TBitBtnBitBtn1Left5TopWidth<HeightHintExit and close this formCaptionE&xitTabOrder KindbkCloseStylebsNew  TIB_NavigationBarIB_NavigationBar1LeftTopWidtheHeightCtl3DParentCtl3DTabOrder
DataSourceDmEmployee.ibEmployeeSourceReceiveFocusCustomGlyphsSupplied   TIB_UpdateBarIB_UpdateBar1LeftxTopWidth� HeightCtl3DParentCtl3DTabOrder
DataSourceDmEmployee.ibEmployeeSourceReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshKeysubRefreshRows    TPanelPanel2Left Top)WidthHeight� AlignalTop
BevelInner	bvLoweredBorderWidthCaptionPanel2TabOrder TIB_GridDBGrid1LeftTopWidthsHeight� Hint%Changing a salary initiates a triggerCustomGlyphsSupplied 
DataSourceDmEmployee.ibEmployeeSourceAlignalClientBorderStylebsNoneTabOrder ListBoxStyle	GridLinks.Strings	FULL_NAMESALARY	JOB_GRADE CurrentRowFont.ColorclWindowTextCurrentRowFont.Height�CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingFont.ColorclWindowTextOrderingFont.Height�OrderingFont.NameMS Sans SerifOrderingFont.Style FixedFont.ColorclWindowTextFixedFont.Height�FixedFont.NameMS Sans SerifFixedFont.Style Ctl3DShallow	StretchColumn	FULL_NAME   TPanelPanel3Left Top� WidthHeight� AlignalClient
BevelInner	bvLoweredBorderWidthCaptionPanel3TabOrder TIB_GridDBGrid2LeftTopWidthsHeight{Hint:Salary history is maintained by a trigger on salary changeCustomGlyphsSupplied 
DataSource DmEmployee.ibSalaryHistorySourceAlignalClientBorderStylebsNoneReadOnly	TabOrder ListBoxStyle	GridLinks.StringsEMPLOYEECHANGE_DATE
OLD_SALARY
NEW_SALARYPERCENT_CHANGE
UPDATER_ID CurrentRowFont.ColorclWindowTextCurrentRowFont.Height�CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingFont.ColorclWindowTextOrderingFont.Height�OrderingFont.NameMS Sans SerifOrderingFont.Style FixedFont.ColorclWindowTextFixedFont.Height�FixedFont.NameMS Sans SerifFixedFont.Style Ctl3DShallow	    