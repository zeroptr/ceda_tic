?
 TFRMEXECPROC 0?  TPF0TFrmExecProcFrmExecProcLeftTop? Width?Height@HintYExplore the ShipOrderProc in the DmEmployee data model to see what shipping an order doesActiveControlPanel1CaptionSales Review
Font.ColorclBlackFont.Height?	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterShowHint	OnCloseQueryFormCloseQueryOnHideFormHideOnShowFormShowPixelsPerInch`
TextHeight TPanelPanel1Left Top Width?Height)AlignalTopTabOrder  TSpeedButtonBtnShipOrderLeft'TopWidth@HeightHintMark current order as shippedCaption&Ship OrderEnabledOnClickBtnShipOrderClick  TBitBtnBitBtn1LeftlTopWidth<HeightHintExit and close this formCaptionE&xitTabOrder KindbkCloseStylebsNew  TIB_NavigationBarIB_NavigationBar1LeftTopWidtheHeightCtl3DParentCtl3DTabOrder
DataSourceDmEmployee.ibSalesSourceReceiveFocusCustomGlyphsSupplied   TIB_UpdateBarIB_UpdateBar1LeftrTopWidth? HeightCtl3DParentCtl3DTabOrder
DataSourceDmEmployee.ibSalesSourceReceiveFocusCustomGlyphsSupplied VisibleButtonsubEditubInsertubDeleteubPostubCancelubRefreshKeysubRefreshRows    TPanelPanel2Left Top)Width?Height? AlignalClient
BevelInner	bvLoweredBorderWidthCaptionPanel2TabOrder TIB_GridDBGrid1LeftTopWidth?Height? Hint&Select an open order to ship the orderCustomGlyphsSupplied 
DataSourceDmEmployee.ibSalesSourceAlignalClientBorderStylebsNoneTabOrder CurrentRowFont.ColorclWindowTextCurrentRowFont.Height?CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingFont.ColorclWindowTextOrderingFont.Height?OrderingFont.NameMS Sans SerifOrderingFont.Style FixedFont.ColorclWindowTextFixedFont.Height?FixedFont.NameMS Sans SerifFixedFont.Style Ctl3DShallow	   TPanelPanel3Left Top? Width?HeightnHint/Customers are linked to sales in the data modelAlignalBottom
BevelInner	bvLoweredBorderWidthCaptionPanel3TabOrder 
TScrollBox	ScrollBoxLeftTopWidth?HeightbHorzScrollBar.MarginVertScrollBar.MarginAlignalClientBorderStylebsNoneTabOrder  TLabelLabel1Left? TopWidth@Height	AlignmenttaRightJustifyCaptionCustomer No:FocusControlEditCUST_NO  TLabelLabel2LeftTopWidth/Height	AlignmenttaRightJustifyCaptionCompany:FocusControlEditCUSTOMER  TLabelLabel3LeftTopWidth(Height	AlignmenttaRightJustifyCaptionContact:FocusControlEditCONTACT_FIRST  TLabelLabel6LeftTop2Width)Height	AlignmenttaRightJustifyCaptionAddress:FocusControlEditADDRESS_LINE  TLabelLabel4Left? TopWidth"Height	AlignmenttaRightJustifyCaptionPhone:  TIB_EditEditCUST_NOLeftTopWidth1Height	DataFieldCUST_NO
DataSourceDmEmployee.ibCustomerSourceTabOrder   TIB_EditEditCUSTOMERLeft3TopWidth}Height	DataFieldCUSTOMER
DataSourceDmEmployee.ibCustomerSourceTabOrder  TIB_EditEditCONTACT_FIRSTLeft3TopWidthKHeight	DataFieldCONTACT_FIRST
DataSourceDmEmployee.ibCustomerSourceTabOrder  TIB_EditEditCONTACT_LASTLeft? TopWidthdHeight	DataFieldCONTACT_LAST
DataSourceDmEmployee.ibCustomerSourceTabOrder  TIB_EditEditPHONE_NOLeftTopWidthxHeight	DataFieldPHONE_NO
DataSourceDmEmployee.ibCustomerSourceTabOrder  TIB_EditEditADDRESS_LINELeft3Top0Width? Height	DataFieldADDRESS_LINE1
DataSourceDmEmployee.ibCustomerSourceTabOrder  TIB_EditEditADDRESS_LINE2Left? Top0Width? Height	DataFieldADDRESS_LINE2
DataSourceDmEmployee.ibCustomerSourceTabOrder  TIB_EditEditCITYLeft3TopFWidth}Height	DataFieldCITY
DataSourceDmEmployee.ibCustomerSourceTabOrder  TIB_EditEditSTATE_PROVINCELeft? TopFWidthKHeight	DataFieldSTATE_PROVINCE
DataSourceDmEmployee.ibCustomerSourceTabOrder  TIB_EditEditCOUNTRYLeftTopFWidthKHeight	DataFieldCOUNTRY
DataSourceDmEmployee.ibCustomerSourceTabOrder	  TIB_EditEditPOSTAL_CODELeftPTopFWidth<Height	DataFieldPOSTAL_CODE
DataSourceDmEmployee.ibCustomerSourceTabOrder
  TIB_CheckBoxDBCheckBox1LeftITopWidthCHeight	DataFieldON_HOLD
DataSourceDmEmployee.ibCustomerSource
Font.ColorclBlackFont.Height?	Font.NameMS Sans Serif
Font.Style ParentColor
ParentFontTabOrderCaptionOn Hold    TIB_DataSourceSalesSourceOnDataChangeSalesSourceDataChangeLeft0Top8   