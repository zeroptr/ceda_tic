?
 TFRMCUSTOMER 0?  TPF0TfrmCustomerfrmCustomerLeft?Top? Width?Height&CaptionCustomer - QueryColor	clBtnFace
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style 	FormStyle
fsMDIChildPositionpoDefaultPosOnlyVisible	PixelsPerInch`
TextHeight TPageControlPageControl1Left Top Width?Height
ActivePage	TabSheet2AlignalClientTabOrder TabStop 	TTabSheet	TabSheet1Caption&Edit 
TScrollBox	ScrollBoxLeft Top Width?Height? HorzScrollBar.MarginHorzScrollBar.Range\VertScrollBar.MarginVertScrollBar.Range? AlignalClient
AutoScrollTabOrder  TLabelLabel1LeftTopWidth-HeightCaptionCUSTNOFocusControl
EditCUSTNO  TLabelLabel2LeftMTopWidth5HeightCaptionCOMPANYFocusControlEditCOMPANY  TLabelLabel3LeftTop,Width%HeightCaptionADDR1FocusControlEditADDR  TLabelLabel4Left? Top,Width%HeightCaptionADDR2FocusControl	EditADDR2  TLabelLabel5LeftTopRWidthHeightCaptionCITYFocusControlEditCITY  TLabelLabel6LeftfTopRWidth#HeightCaptionSTATEFocusControl	EditSTATE  TLabelLabel7Left? TopRWidthHeightCaptionZIPFocusControlEditZIP  TLabelLabel8LeftTopxWidth5HeightCaptionCOUNTRYFocusControlEditCOUNTRY  TLabelLabel9LeftTopxWidth&HeightCaptionPHONEFocusControl	EditPHONE  TLabelLabel10Left? TopxWidthHeightCaptionFAXFocusControlEditFAX  TLabelLabel11LeftTop? Width2HeightCaptionTAXRATEFocusControlEditTAXRATE  TLabelLabel12LeftMTop? Width3HeightCaptionCONTACTFocusControlEditCONTACT  TLabelLabel13Left? Top? WidthcHeightCaptionLASTINVOICEDATEFocusControlEditLASTINVOICEDATE  TIB_Edit
EditCUSTNOLeftTopWidthAHeight	DataFieldCUSTNO
DataSourcedsCustTabOrder   TIB_EditEditCOMPANYLeftMTopWidth? Height	DataFieldCOMPANY
DataSourcedsCustTabOrder  TIB_EditEditADDRLeftTop;Width? Height	DataFieldADDR1
DataSourcedsCustTabOrder  TIB_Edit	EditADDR2Left? Top;Width? Height	DataFieldADDR2
DataSourcedsCustTabOrder  TIB_EditEditCITYLeftTopaWidthZHeight	DataFieldCITY
DataSourcedsCustTabOrder  TIB_Edit	EditSTATELeftfTopaWidthsHeight	DataFieldSTATE
DataSourcedsCustTabOrder  TIB_EditEditZIPLeft? TopaWidthAHeight	DataFieldZIP
DataSourcedsCustTabOrder  TIB_EditEditCOUNTRYLeftTop? WidthsHeight	DataFieldCOUNTRY
DataSourcedsCustTabOrder  TIB_Edit	EditPHONELeftTop? WidthZHeight	DataFieldPHONE
DataSourcedsCustTabOrder  TIB_EditEditFAXLeft? Top? WidthZHeight	DataFieldFAX
DataSourcedsCustTabOrder	  TIB_EditEditTAXRATELeftTop? WidthAHeight	DataFieldTAXRATE
DataSourcedsCustTabOrder
  TIB_EditEditCONTACTLeftMTop? WidthsHeight	DataFieldCONTACT
DataSourcedsCustTabOrder  TIB_EditEditLASTINVOICEDATELeft? Top? WidthxHeight	DataFieldLASTINVOICEDATE
DataSourcedsCustTabOrder  TIB_IncSearchIB_IncSearch1LeftTop? WidthyHeight
DataSourcedsCustReceiveFocusSearchKeyByKey	ColorclSilverTabOrder    	TTabSheet	TabSheet2Caption&Browse TIB_GridIB_CursorGrid1Left Top Width?Height? CustomGlyphsSupplied 
DataSourcedsCustAlignalClient
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrderDefaultRowHeight	RowSelect	CurrentRowFont.ColorclWindowTextCurrentRowFont.Height?CurrentRowFont.NameMS Sans SerifCurrentRowFont.Style OrderingColorclInfoBkOrderingFont.Color
clInfoTextOrderingFont.Height?OrderingFont.NameMS Sans SerifOrderingFont.StylefsBold FixedFont.ColorclWindowTextFixedFont.Height?FixedFont.NameMS Sans SerifFixedFont.Style   TPanelPanel1Left Top? Width?HeightTAlignalBottom
BevelOuter	bvLoweredTabOrder  TLabellbLookupComboLeft? TopWidthEHeightCaptionLookupCombo  TLabellbIncSearchLeft? Top#Width? HeightCaption.IncSearch ( Press ENTER for non-text columns )  TLabellbSearchEditLeft? Top;Width? HeightCaptionSearchEdit ( COMPANY only )  TIB_SearchEditIB_SearchEdit1Left Top8WidthyHeight
DataSourcedsCustTabOrder  TIB_LookupComboIB_LookupCombo2Left TopWidthyHeight
DataSourcedsCustTabOrder DropDownWidth? IndicateTitles	  TIB_IncSearchIB_IncSearchLeft Top WidthyHeight
DataSourcedsCustReceiveFocusSearchKeyByKey	ColorclSilverTabOrder     	TIB_QueryqrCustColumnAttributes.StringsCUSTOMER.COMPANY=NOCASE DatabaseName=C:\Program Files\Common Files\Borland Shared\Data\mastsql.gdbFieldsIndex.StringsCUSTOMER.CUSTNOCUSTOMER.COMPANYCUSTOMER.ADDR1CUSTOMER.ADDR2CUSTOMER.CITYCUSTOMER.STATECUSTOMER.ZIPCUSTOMER.COUNTRYCUSTOMER.PHONECUSTOMER.FAXCUSTOMER.TAXRATECUSTOMER.CONTACTCUSTOMER.LASTINVOICEDATE SQL.StringsSelect  CUSTOMER.CUSTNO,  CUSTOMER.COMPANY,  CUSTOMER.ADDR1,  CUSTOMER.ADDR2,  CUSTOMER.CITY,  CUSTOMER.STATE,  CUSTOMER.ZIP,  CUSTOMER.COUNTRY,  CUSTOMER.PHONE,  CUSTOMER.FAX,  CUSTOMER.TAXRATE,  CUSTOMER.CONTACT,  CUSTOMER.LASTINVOICEDATEFROM CUSTOMER=WHERE UPPER( CUSTOMER.COMPANY ) LIKE UPPER( :COMPANY || '%' )1// This parameter usage is only for small tables.<// This is because it is not possible for IB to use an index9// when the UPPER() is applied and a parameter is in the // LIKE expression.
FOR UPDATE ColorScheme	KeyLinks.StringsCUSTOMER.CUSTNO 
KeySeekingMasterSearchFlagsmsfOpenMasterOnOpenmsfSearchMasterOnSearchmsfSearchAppliesToMasterOnly OrderingItemNoOrderingItems.Strings(No=CUSTOMER.CUSTNO; CUSTOMER.CUSTNO DESC/Company=CUSTOMER.COMPANY; CUSTOMER.COMPANY DESC+Address=CUSTOMER.ADDR1; CUSTOMER.ADDR1 DESC&City=CUSTOMER.CITY; CUSTOMER.CITY DESC)State=CUSTOMER.STATE; CUSTOMER.STATE DESC#ZIP=CUSTOMER.ZIP; CUSTOMER.ZIP DESC/Country=CUSTOMER.COUNTRY; CUSTOMER.COUNTRY DESC)Phone=CUSTOMER.PHONE; CUSTOMER.PHONE DESC#Fax=CUSTOMER.FAX; CUSTOMER.FAX DESC0Tax Rate=CUSTOMER.TAXRATE; CUSTOMER.TAXRATE DESC/Contact=CUSTOMER.CONTACT; CUSTOMER.CONTACT DESCDLast Invoice=CUSTOMER.LASTINVOICEDATE; CUSTOMER.LASTINVOICEDATE DESC OrderingLinks.StringsCUSTOMER.CUSTNO=1CUSTOMER.COMPANY=2CUSTOMER.ADDR1=3CUSTOMER.CITY=4CUSTOMER.STATE=5CUSTOMER.ZIP=6CUSTOMER.COUNTRY=7CUSTOMER.PHONE=8CUSTOMER.FAX=9CUSTOMER.TAXRATE=10CUSTOMER.CONTACT=11CUSTOMER.LASTINVOICEDATE=12 RequestLive	SearchingLinks.StringsCUSTOMER.COMPANY=COMPANY 	AfterOpenqrCustOrderingChangeAfterUnprepareqrCustAfterUnprepareOnOrderingChangedqrCustOrderingChangeBufferSynchroFlagsbsAfterEditbsAfterInsert FetchWholeRows	LeftTop%  TIB_DataSourcedsCustAnnounceFocus	DatasetqrCustOnGainFocusdsCustGainFocusLeft?Top%   