�
 TFRMEMPLOYEE 0�  TPF0TfrmEmployeefrmEmployeeLefttTop�WidthWHeight� CaptionEmployee - Cursor
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 	FormStyle
fsMDIChildPositionpoDefaultPosOnlyVisible	PixelsPerInch`
TextHeight TPanelPanel2Left Top WidthOHeightkAlignalClient
BevelInner	bvLoweredBorderWidthCaptionPanel2TabOrder  
TScrollBox	ScrollBoxLeftTopWidthCHeight_HorzScrollBar.MarginHorzScrollBar.RangeVertScrollBar.MarginVertScrollBar.RangeTAlignalClient
AutoScrollBorderStylebsNoneTabOrder  TLabelLabel1LeftTopWidth'HeightCaptionEMPNOFocusControl	EditEMPNO  TLabelLabel2LeftCTopWidth:HeightCaptionLASTNAMEFocusControlEditLASTNAME  TLabelLabel3Left� TopWidth>HeightCaption	FIRSTNAMEFocusControlEditFIRSTNAME  TLabelLabel4LeftTop,Width;HeightCaptionPHONEEXTFocusControlEditPHONEEXT  TLabelLabel5LeftGTop,Width7HeightCaptionHIREDATEFocusControlEditHIREDATE  TLabelLabel6Left� Top,Width*HeightCaptionSALARYFocusControl
EditSALARY  TIB_Edit	EditEMPNOLeftTopWidth7Height	DataFieldEMPNO
DataSourceDataSource1TabOrder   TIB_EditEditLASTNAMELeftCTopWidthsHeight	DataFieldLASTNAME
DataSourceDataSource1TabOrder  TIB_EditEditFIRSTNAMELeft� TopWidthZHeight	DataField	FIRSTNAME
DataSourceDataSource1TabOrder  TIB_EditEditPHONEEXTLeftTop;Width#Height	DataFieldPHONEEXT
DataSourceDataSource1TabOrder  TIB_EditEditHIREDATELeftGTop;WidthxHeight	DataFieldHIREDATE
DataSourceDataSource1TabOrder  TIB_Edit
EditSALARYLeft� Top;WidthAHeight	DataFieldSALARY
DataSourceDataSource1TabOrder    
TIB_CursorCursorSQL.StringsSelect  EMPLOYEE.EMPNO,  EMPLOYEE.LASTNAME,  EMPLOYEE.FIRSTNAME,  EMPLOYEE.PHONEEXT,  EMPLOYEE.HIREDATE,  EMPLOYEE.SALARYFrom EMPLOYEE
FOR UPDATE ColorScheme	KeyLinks.StringsEMPLOYEE.EMPNO MasterSearchFlagsmsfOpenMasterOnOpenmsfSearchAppliesToMasterOnly RequestLive	Left#Top  TIB_DataSourceDataSource1AnnounceFocus	DatasetCursorOnGainFocusDataSource1GainFocusLeft$Top5   