?
 TCOLORLINEFORM 0d  TPF0?TColorLineFormColorLineFormOldCreateOrder	OnCreate
FormCreatePixelsPerInch`
TextHeight ?TMemoMemo1Lines.StringsI"Color Line" tools are small objects that draw a line at a specific axis Fand axis position. They can be used to mark axis values or to separateregions defined by custom axes.%Try to drag the lines with the mouse.   ?TChartChart1
CustomAxes
Horizontal	OtherSideStartPosition       ?@  LeftAxis.AutomaticLeftAxis.AutomaticMinimumLeftAxis.EndPosition       ?@ TPointSeriesSeries1Marks.ArrowLength Marks.VisibleSeriesColorclRedClickableLinePointer.InflateMargins	Pointer.StylepsRectanglePointer.Visible	XValues.NameXXValues.OrderloAscendingYValues.NameYYValues.OrderloNone  TLineSeriesSeries2Marks.ArrowLengthMarks.VisibleSeriesColorclGreenVertAxisaCustomVertAxisPointer.InflateMargins	Pointer.StylepsRectanglePointer.VisibleXValues.NameXXValues.OrderloAscendingYValues.NameYYValues.OrderloNoneCustomVertAxis   TColorLineTool
ChartTool1	Pen.ColorclBlue	Pen.Width
OnDragLineChartTool1DragLineOnEndDragLineChartTool1EndDragLineAxisID  TColorLineTool
ChartTool2	Pen.ColorclLime	Pen.WidthValue       ?@
OnDragLineChartTool1DragLineOnEndDragLineChartTool1EndDragLineAxisID    ?TPanelPanel1 TLabelLabel1LeftcTopWidth-HeightAutoSize  	TCheckBox	CheckBox1LeftTopWidthaHeightCaption&Show LinesChecked	State	cbCheckedTabOrder OnClickCheckBox1Click  	TCheckBox	CheckBox2LeftpTopWidthaHeightCaption&3DChecked	State	cbCheckedTabOrderOnClickCheckBox2Click  	TCheckBox	CheckBox3Left? TopWidthaHeightCaptionAllow &DragChecked	State	cbCheckedTabOrderOnClickCheckBox3Click  
TButtonPen
ButtonPen1LeftTopWidthTabOrder  
TButtonPen
ButtonPen2Left8TopWidthTabOrder    