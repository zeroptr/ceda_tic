?
 TSERIESTYPEPOLARGRID 0?  TPF0?TSeriesTypePolarGridSeriesTypePolarGridLeftYTop? PixelsPerInch`
TextHeight ?TMemoMemo1Lines.StringsDisplays an array of values as a circular grid of cells, very similar to a for example hard disk plate with sectors and tracks..The AddCell method is used to fill the series: $    for Sector:=0 to NumSectors-1 do&        for Track:=0 to NumTracks-1 do        begin5          tmp:=0.5*Sqr(Cos(Sector/(NumSectors*0.2)))+3                   Sqr(Cos(Track/(NumTracks*0.2)))-.                   Cos(Track/(NumTracks*0.5)); $          AddCell(Sector,Track,tmp);        end;   ?TChartChart1Gradient.EndColorclWhiteGradient.MidColoraaa Gradient.Visible	Legend.Bevel	bvLoweredLegend.Shadow.VisibleTitle.VisibleBottomAxis.Increment hfffff?@View3D TPolarGridSeries	PolarGridMarks.Arrow.Visible	Marks.Callout.Brush.ColorclBlackMarks.Callout.Arrow.Visible	Marks.VisibleCircled	CellValues.NameValuesCellValues.OrderloNone
NumSectors	NumTracksAngleIncrement hfffff?@AngleValues.NameSectorsAngleValues.OrderloNoneBrush.ColorclWhiteRadiusValues.NameTracksRadiusValues.OrderloNone   ?TPanelPanel1 TButtonButton1Left
Top	WidthGHeightCaption&Edit...TabOrder OnClickButton1Click  
TScrollBar
ScrollBar1Left\TopWidthaHeightMax? MinPageSize PositionTabOrderOnChangeScrollBar1Change  
TScrollBar
ScrollBar2Left? TopWidthbHeightMax? MinPageSize PositionTabOrderOnChangeScrollBar1Change  	TCheckBoxcbClockWiseLeft8TopWidthMHeightCaption
&ClockwiseTabOrderOnClickcbClockWiseClick  	TCheckBox	cbAxisTopLeft?TopWidthQHeightCaption&Axis on topTabOrderOnClickcbAxisTopClick    