�
 TRELEASE501MISC 0�  TPF0TRelease501MiscRelease501MiscLeft� TopkWidth�Height�
ParentFont	PixelsPerInch`
TextHeight TMemoMemo1Left Top Width�Height�AlignalClientLines.StringsTeeChart Pro Release 5.01Miscellaneous New Features========================== Kylix support !8 This release supports Kylix (Borland Delphi for Linux). Memory saving9 Adding points without labels (ie: Series1.Add(123) ) now5 does not allocate memory for empty labels. This is a4 reduction of 4 bytes per point. For example, adding9 100000 points to a fast line series now takes 0.4MB less of memory. Chart AddSeries method9 Now you can call Chart1.AddSeries(TLineSeries), that is,7 passing only the series class as parameter. This helps6 creating dynamic series in C++ Builder. The older wayB is still supported: Chart1.AddSeries( TLineSeries.Create(Self) ') Series Marks) Added Transparency and Bevel properties. Shape Series: Added Gradient property for Rectangle and Ellipse styles. TeeURL error messages9 When using the TeeURL methods (LoadChartFromURL, etc) or: the TChartWebSource component, if there happens a Windows9 error, the exception now appends the text description to: the error code number. (See TeeURLErrorMessage function). Writeable Constants OFF3 Now TeeChart 5.01 sources support compilation with7 Writeable Constants OFF (it was ON by default before).= See: Project->Options->Compiler->Assignable Typed Constants.8 (Corresponds to the {$J} command-line compiler option). $New DateToWeek function ( ISO-8601 )' Returns the Week number given a Date. > The previous algorithm is keeped into DateToWeekOld function. 
ScrollBarsssBothTabOrder WordWrap   