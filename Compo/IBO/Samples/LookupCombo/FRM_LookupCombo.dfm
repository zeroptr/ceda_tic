�
 TFRMLKCMB 0�  TPF0	TfrmLkCmbfrmLkCmbLeftTopnWidthHeight�CaptionfrmLkCmbFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style ShowHint	OnCloseQueryFormCloseQueryOnCreate
FormCreate
OnDblClickFormDblClickPixelsPerInch`
TextHeight TLabelLabel1Left	Top<Width&HeightCaptionEmpNo:  TLabelLabel2Left	Top\Width/HeightCaption	FirstName  TLabelLabel3Left	Top|Width0HeightCaptionLastName  TLabelLabel4Left	Top� Width7HeightCaption
Department  TLabelLabel5Left	Top� Width-HeightCaptionJOBCode  TLabelLabel6Left	Top� Width1HeightCaptionJOBGrade  TLabelLabel7Left	Top� Width8HeightCaption
JOBCountry  TLabelLabel8Left	TopWidthHeightCaptionSalary  TSpeedButtonSpeedButton1Left�TopWidthHeightCaptionMOnClickFormDblClick  TIB_EditIB_Edit1LeftITopXWidth� Height	DataField
FIRST_NAME
DataSourcedsMasterTabOrder  TIB_EditIB_Edit2LeftITopxWidth� Height	DataField	LAST_NAME
DataSourcedsMasterTabOrder  TIB_NavigationBarIB_NavigationBar1Left� TopWidtheHeightCtl3DParentCtl3DTabOrder 
DataSourcedsMasterReceiveFocusCustomGlyphsSupplied   TIB_UpdateBarIB_UpdateBar1Left TopWidth~HeightCtl3DParentCtl3DTabOrder
DataSourcedsMasterReceiveFocusCustomGlyphsSupplied   TIB_EditIB_Edit3LeftITop8Width� Height	DataFieldEMP_NO
DataSourcedsMasterTabOrder  TIB_EditIB_Edit4LeftITop� Width� Height	DataFieldJOB_CODE
DataSourcedsMasterTabOrder  TIB_EditIB_Edit5LeftITop� Width� Height	DataField	JOB_GRADE
DataSourcedsMasterTabOrder  TIB_EditIB_Edit6LeftITop� Width� Height	DataFieldJOB_COUNTRY
DataSourcedsMasterTabOrder  TIB_EditIB_Edit7LeftITopWidth� Height	DataFieldSALARY
DataSourcedsMasterTabOrder	  TIB_LookupComboIB_LookupComboLeftITop� Width� Height
DataSourcedsLookupTabOrderAutoDropDown	CustomPopupIB_LookupListIndicateTitles	OnNotInListIB_LookupComboNotInList
ShowButton	  TIB_SearchBarIB_SearchBar1Left
TopWidth~HeightCtl3DParentCtl3DTabOrder

DataSourcedsMasterReceiveFocusCustomGlyphsSupplied VisibleButtonssbSearchsbSavesbClearsbRecallsbCount   	TCheckBoxcbAllowTimeoutLeftTop@WidthaHeightCaptionAllowTimeoutTabOrderOnClickcbAllowTimeoutClick  	TCheckBoxcbSearchKeyByKeyLeftTopXWidthqHeightCaptionSearchKeyByKeyTabOrderOnClickcbAllowTimeoutClick  	TCheckBoxcbSeekNearestLeftToppWidthaHeightCaptionSeekNearestTabOrderOnClickcbAllowTimeoutClick  	TCheckBoxcbAutoDropDownLeftTop� WidthaHeightCaptionAutoDropDownTabOrderOnClickcbAllowTimeoutClick  TMemoMemo1LeftTop� WidthHeight� 
ScrollBarsssBothTabOrderWordWrap  TButtonbtReadLefthTop� WidthKHeightCaptionRead CriteriaTabOrderOnClickbtReadClick  TButtonbtWriteLeftTop� WidthKHeightCaptionWrite CriteriaTabOrderOnClickbtWriteClick  TIB_LookupListIB_LookupListLeftTop8Width� Height9CustomGlyphsSupplied 
DataSourcedsLookupVisibleTabOrder
FixedColorclLimeListBoxStyleIndicateTitles	Ctl3DShallow	  TIB_ConnectioncnDemo	AliasNameIBLocalPasswordStoragepsNotSecureParams.StringsCPATH=d:\Program Files\Common Files\Borland Shared\Data\employee.gdbUSER NAME=SYSDBA BeforeConnectcnDemoConnectAfterConnectcnDemoConnectLeftTop� SavedPassword.JuMbLe.01.432B0639073E0E4B49  TIB_DataSourcedsMasterDatasetqrEmpLeftHTop   TIB_TransactiontrDemoIB_ConnectioncnDemo	IsolationtiConcurrencyLeftHTop�   	TIB_QueryqrDeptColumnAttributes.StringsDEPARTMENT=NOCASE=DEPARTMENT FieldsDisplayLabel.Strings
DEPT_NO=NO FieldsDisplayWidth.StringsDEPARTMENT.DEPT_NO=35DEPARTMENT.DEPARTMENT=150 SQL.StringsSELECT DEPT_NO     , DEPARTMENT-//     , DEPARTMENT || DEPARTMENT AS my_fieldFROM DEPARTMENTwhere dept_no > :dept_no AutoFetchAll	ColorSchemeKeyLinks.StringsDEPT_NO=DEPT_NO 	KeySourcedsMasterMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItemNoOrderingItems.StringsDEPTNO=DEPT_NO; DEPT_NO DESC$DEPARTMNT=DEPARTMENT;DEPARTMENT DESC OrderingLinks.StringsDEPT_NO=ITEM=1DEPARTMENT=ITEM=2 RequestLive	BufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	IncSearchKeyInt�LeftTop0ParamValuesDEPT_NO=      TIB_DataSourcedsLookup
AutoInsertDatasetqrDeptLeftHTop0  	TIB_QueryqrEmpColumnAttributes.StringsFULL_NAME=COMPUTED IB_TransactiontrDemoSQL.StringsSELECT * FROM EMPLOYEE ColorScheme	DefaultValues.StringsHIRE_DATE=TODAY GeneratorLinks.StringsEmployee.Emp_No=EMP_NO_GEN KeyLinks.StringsEMP_NO MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItemNo�OrderingItems.StringsNo=EMP_NO; EMP_NO DESC;Name=LAST_NAME, FIRST_NAME; LAST_NAME DESC, FIRST_NAME DESCExt=PHONE_EXTDOH=HIRE_DATE; HIRE_DATE DESC OrderingLinks.StringsEMP_NO=1LAST_NAME=2PHONE_EXT=3HIRE_DATE=4 RequestLive	BufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	IncSearchKeyInt�LeftTop   TOpenDialogodGDB
DefaultExtGDBFilter InterBase Database (*.GDB)|*.GDBTitleEmployee Sample Database FileLeft� Top@  TIB_MonitorDialogmdBaseKeySoftware\Apps\LookupComboCaptionLookup Combo SQL Monitor DialogLeftxTopH   