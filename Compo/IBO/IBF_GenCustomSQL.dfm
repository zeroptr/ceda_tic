’
 TFRMGENCUSTOMSQL 0©  TPF0TfrmGenCustomSQLfrmGenCustomSQLLeftČ ToptWidth7HeightBBorderStylebsSizeToolWinCaption<Create SQL to call a procedure for EditSQL/InsertSQL/EditSQL
Font.ColorclWindowTextFont.Heightõ	Font.NameMS Sans Serif
Font.Style OnCreate
FormCreatePixelsPerInch`
TextHeight TLabelLabel2LeftTopWidthHeightCaptionXSelect a procedure, then drag a field from the list to the desired position in the cell.  TLabelLabel1LeftTopWidthiHeightCaptionLNormal drag uses current field value, whereas ALT+drag uses old field value.  TLabelLabel3Left Top(Width4HeightCaption
Procedure:  TShape
ShapeValueLeftxTopŠ Width)Height)Brush.ColorclBlueParentShowHint	Pen.WidthShapestCircleShowHintOnMouseDownShapeValueMouseDown  TLabelLabel4LeftØTopŠ WidthyHeightNAutoSizeCaptionUDrag the circle to the grid to enter a param value manually. Alt+drag to produce NULLWordWrap	  TLabelstProcLeft`Top(WidthHHeightCaption<procedure>
Font.ColorclWindowTextFont.Heightõ	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TStringGridStringGridProcLeftTop@WidthYHeight ColCountDefaultColWidth RowCountOptionsgoFixedVertLinegoFixedHorzLine
goVertLine
goHorzLine TabOrder 
OnDragDropStringGridProcDragDrop
OnDragOverStringGridProcDragOver
RowHeights   	TComboBoxcbTablesLeftxTop@Width© HeightStylecsDropDownListEnabled
ItemHeightTabOrderOnChangecbTablesChange  TListBoxlbFieldsLeftxTophWidth© HeightaEnabled
ItemHeightTabOrderOnMouseDownlbFieldsMouseDown  	TCheckBoxchbEditLeftTopč WidthiHeightCaptionApply to EditSQLEnabledTabOrderOnClickchbAllClick  	TCheckBox	chbInsertLeft Topč WidthqHeightCaptionApply to InsertSQLEnabledTabOrderOnClickchbAllClick  	TCheckBox	chbDeleteLeft Topč WidthyHeightCaptionApply to DeleteSQLEnabledTabOrderOnClickchbAllClick  TBitBtnBitBtnApplyLeft Top WidthQHeightCaption&ApplyEnabledTabOrderOnClickBitBtnApplyClick
Glyph.Data
ö  ņ  BMņ      v   (   $            |                                   ĄĄĄ    ’  ’   ’’ ’   ’ ’ ’’  ’’’ 334C3333333833333  33B$33333338ó3333  34""C333338333333  3B""$33333338ó333  4"*""C3338ó?33333  2"¢¢"C3338óó3333  :*"*"$3338ų3?38ó33  4¢""¢"C33833ó333  B"¢"*"$3333?38ó3  "*:"$¢"C388ó8ó33  ¢£3¢"J"$33338ó  :33:"$¢"C8338ó8ó3  3333¢"J"C333333  3333:"$¢#33338ó8ų3  33333¢"J33333333  33333:"$3333338ó8ó  333333¢$33333338ó  333333:"33333338ųó  3333333£333333333  	NumGlyphs  TBitBtnBitBtn2Leftų Top WidthQHeightTabOrderKindbkClose  TBitBtn
BitBtnProcLeft(Top WidthQHeightCaption	ProcedureEnabledTabOrderOnClickBitBtnProcClick
Glyph.Data
ā  Ž  BMŽ      v   (   $            h                                   ĄĄĄ    ’  ’   ’’ ’   ’ ’ ’’  ’’’ 333DDD33333??33  2C4"""D3388333ó3  2$B""""C38ų?’’33  2""*ŖŖ"$38ó3ųó8ó  2""£33¢"C8ó?333  2""333:"C8ó83338ó  2""#33:DC8’’338  :ŖŖŖ33333833333  333333333333333’’’  333333DDD3’’333  :DC33:""$8338ó38  :"C333¢"$8ó33338  3¢$334B"$38’’ų38  3¢"DDB""$333’8  3:"""""Ŗ$38’333’ų  33Ŗ"""Ŗ3£33’’’3  333ŖŖŖ333333333  333333333333333333  	NumGlyphs  	TCheckBoxchbTryToUseNumberLeft@TopŠ Widthł HeightCaption0Try to put numeric values as numbers not stringsState	cbCheckedTabOrder	   