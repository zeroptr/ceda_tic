�
 TDBTREEGROUPFORM 0  TPF0�TDBTreeGroupFormDBTreeGroupFormOnShowFormShowPixelsPerInch`
TextHeight �TMemoMemo1Lines.StringsLWith one or more datasets, it is possible to create a "grouping" Tree level,"specifying the fields to group by.-Every group-by field determines a Tree level.   �TPanelPanel1 TLabelLabel1LeftlTopWidth.HeightCaption
&Group by:  	TCheckBox	CheckBox1Left
TopWidthWHeightCaption&Open OrdersTabOrder OnClickCheckBox1Click  
TComboFlat
ComboFlat1Left� TopWidthYHeightStylecsDropDownList
ItemHeightTabOrderOnChangeComboFlat3ChangeItems.StringsTermsShipVIAPaymentMethod   
TComboFlat
ComboFlat2LeftTopWidthYHeightStylecsDropDownList
ItemHeightTabOrderOnChangeComboFlat3ChangeItems.StringsTermsShipVIAPaymentMethod   
TComboFlat
ComboFlat3LeftaTopWidthYHeightStylecsDropDownList
ItemHeightTabOrderOnChangeComboFlat3ChangeItems.StringsTermsShipVIAPaymentMethod    �TDBTreeDBTree1DataSetTable1ParentFieldTerms;ShipVIA;PaymentMethod
TextFields&OrderNo;SaleDate;AmountPaid;ItemsTotalLayoutDataSetTable1Fields&OrderNo;SaleDate;AmountPaid;ItemsTotalParentFieldTerms;ShipVIA;PaymentMethod    TTableTable1DatabaseNamedbdemos	TableName	orders.dbLeftJTop�    