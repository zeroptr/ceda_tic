?
 TFRMGENCUSTOMSQL 0?  TPF0TfrmGenCustomSQLfrmGenCustomSQLLeft? ToptWidth7HeightBBorderStylebsSizeToolWinCaption<Create SQL to call a procedure for EditSQL/InsertSQL/EditSQL
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.Style OnCreate
FormCreatePixelsPerInch`
TextHeight TLabelLabel2LeftTopWidth?HeightCaptionXSelect a procedure, then drag a field from the list to the desired position in the cell.  TLabelLabel1LeftTopWidthiHeightCaptionLNormal drag uses current field value, whereas ALT+drag uses old field value.  TLabelLabel3Left Top(Width4HeightCaption
Procedure:  TShape
ShapeValueLeftxTop? Width)Height)Brush.ColorclBlueParentShowHint	Pen.WidthShapestCircleShowHintOnMouseDownShapeValueMouseDown  TLabelLabel4Left?Top? WidthyHeightNAutoSizeCaptionUDrag the circle to the grid to enter a param value manually. Alt+drag to produce NULLWordWrap	  TLabelstProcLeft`Top(WidthHHeightCaption<procedure>
Font.ColorclWindowTextFont.Height?	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TStringGridStringGridProcLeftTop@WidthYHeight? ColCountDefaultColWidth? RowCountOptionsgoFixedVertLinegoFixedHorzLine
goVertLine
goHorzLine TabOrder 
OnDragDropStringGridProcDragDrop
OnDragOverStringGridProcDragOver
RowHeights   	TComboBoxcbTablesLeftxTop@Width? HeightStylecsDropDownListEnabled
ItemHeightTabOrderOnChangecbTablesChange  TListBoxlbFieldsLeftxTophWidth? HeightaEnabled
ItemHeightTabOrderOnMouseDownlbFieldsMouseDown  	TCheckBoxchbEditLeftTop? WidthiHeightCaptionApply to EditSQLEnabledTabOrderOnClickchbAllClick  	TCheckBox	chbInsertLeft? Top? WidthqHeightCaptionApply to InsertSQLEnabledTabOrderOnClickchbAllClick  	TCheckBox	chbDeleteLeft Top? WidthyHeightCaptionApply to DeleteSQLEnabledTabOrderOnClickchbAllClick  TBitBtnBitBtnApplyLeft? Top WidthQHeightCaption&ApplyEnabledTabOrderOnClickBitBtnApplyClick
Glyph.Data
?  ?  BM?      v   (   $            |                      ?  ?   ?? ?   ? ? ??  ??? ???   ?  ?   ?? ?   ? ? ??  ??? 334C33333338?33333  33B$3333333?8?3333  34""C33333833?3333  3B""$33333?338?333  4"*""C3338??33?333  2"??"C3338???3?333  :*"*"$3338?3?38?33  4?""?"C338?33?3?33  B"?"*"$33?3?3?38?3  "*:"$?"C3?88?8?3?3  ??3?"J"$3??3?3?38?  :33:"$?"C8338?8?3?  3333?"J"C3333?3?3?  3333:"$?#33338?8?3  33333?"J333333?3?3  33333:"$3333338?8?  333333?$3333333?8?  333333:"33333338??  3333333?33333333?3  	NumGlyphs  TBitBtnBitBtn2Left? Top WidthQHeightTabOrderKindbkClose  TBitBtn
BitBtnProcLeft(Top WidthQHeightCaption	ProcedureEnabledTabOrderOnClickBitBtnProcClick
Glyph.Data
?  ?  BM?      v   (   $            h                      ?  ?   ?? ?   ? ? ??  ??? ???   ?  ?   ?? ?   ? ? ??  ??? 333DDD33333?????33  2C4"""D338?8333??3  2$B""""C38?????3?3  2""*??"$38?3????8?  2""?33?"C8???33?3?  2""333:"C8?83338??  2""#33:DC8???338??  :???333338???33333  333333333333333???  333333DDD3??333???  :DC33:""$8??338?38  :"C333?"$8??333?38  3?$334B"$3?8????38  3?"DDB""$3?3???3?8  3:"""""?$38?333???  33?"""?3?33?????3?  333???333333???333  333333333333333333  	NumGlyphs  	TCheckBoxchbTryToUseNumberLeft@Top? Width? HeightCaption0Try to put numeric values as numbers not stringsState	cbCheckedTabOrder	   