�
 TCHARTBOOKFORM 0V  TPF0TChartBookFormChartBookFormLeft�Top� Width�Height�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnCreate
FormCreatePixelsPerInch`
TextHeight 	TSplitter	Splitter1Left Top� Width�HeightCursorcrVSplitAlignalTop  TMemoMemo1Left Top Width�Height� AlignalTopLines.Strings[ChartBook is a PageControl derived component that automatically creates a chart when a new #tab is added at design or run-time. myChart := ChartBook1.AddChart; 5Tabs can optionally show a chart "commander" toolbar. ChartBook1.ShowToolBar := True; ReadOnly	
ScrollBarsssBothTabOrder   TPanelPanel1Left Top� Width�Height)AlignalTopTabOrder TLabelLabel1LeftTopWidthBHeightCaption&Tabs position:FocusControl
ComboFlat1  
TComboFlat
ComboFlat1LeftPTopWidthI	ItemIndexTabOrder TextLeftOnChangeComboFlat1ChangeItems.StringsTopBottomLeftRight   	TCheckBox	CheckBox1Left� TopWidthaHeightCaption&Show toolbarChecked	State	cbCheckedTabOrderOnClickCheckBox1Click  TButtonButton1LeftTopWidthKHeightCaption&Add...TabOrderOnClickButton1Click  TButtonButton2LeftpTopWidthKHeightCaption&DeleteTabOrderOnClickButton2Click    