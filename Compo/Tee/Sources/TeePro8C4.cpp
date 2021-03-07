//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeePro8C4.res");
USEPACKAGE("tee8C4.bpi");
USEPACKAGE("teeUI8C4.bpi");
USEUNIT("BigCandl.pas");
USEUNIT("CandleCh.pas");
USEUNIT("CurvFitt.pas");
USEUNIT("Errorbar.pas");
USEUNIT("ImageBar.pas");
USEUNIT("ImaPoint.pas");
USEUNIT("MyPoint.pas");
USEUNIT("OHLChart.pas");
USEUNIT("StatChar.pas");
USEUNIT("TeeBezie.pas");
USEUNIT("TeeComma.pas");
USEUNIT("TeeCount.pas");
USEUNIT("TeeCumu.pas");
USEUNIT("TeeEdit.pas");
USEUNIT("TeePoin3.pas");
USEUNIT("TeePolar.pas");
USEUNIT("TeePoly.pas");
USEUNIT("TeeProCo.pas");
USEUNIT("TeeSurfa.pas");
USEUNIT("Bar3d.pas");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcljpg40.bpi");
USEUNIT("teetools.pas");
USEFORMNS("TeeDragPoint.pas", TeeDragPoint, DragPointToolEdit);
USEFORMNS("TeeSurfEdit.pas", Teesurfedit, SurfaceSeriesEditor);
USEFORMNS("TeeAxisToolEdit.pas", Teeaxistooledit, AxisToolEditor);
USEFORMNS("TeeBarJoinEditor.pas", Teebarjoineditor, BarJoinEditor);
USEUNIT("TeeBoxPlot.pas");
USEFORMNS("TeeBoxPlotEditor.pas", Teeboxploteditor, BoxSeriesEditor);
USEFORMNS("TeeCandlEdi.pas", Teecandledi, CandleEditor);
USEUNIT("TeeChartActions.pas");
USEUNIT("TeeClockEditor.pas");
USEFORMNS("TeeColorBandEdit.pas", Teecolorbandedit, ColorBandToolEditor);
USEUNIT("TeeColorGridEditor.pas");
USEFORMNS("TeeColorLineEditor.pas", Teecolorlineeditor, ColorLineToolEditor);
USEFORMNS("TeeContourEdit.pas", Teecontouredit, ContourSeriesEditor);
USEUNIT("TeeCursorEdit.pas");
USEUNIT("TeeDrawLineEditor.pas");
USEUNIT("TeeEditPro.pas");
USEFORMNS("TeeErrBarEd.pas", Teeerrbared, ErrorSeriesEditor);
USEFORMNS("TeeGriEd.pas", Teegried, Grid3DSeriesEditor);
USEFORMNS("TeeHighLowEdit.pas", Teehighlowedit, HighLowEditor);
USEFORMNS("TeeHistoEdit.pas", Teehistoedit, HistogramSeriesEditor);
USEFORMNS("TeeImaEd.pas", Teeimaed, ImageBarSeriesEditor);
USEUNIT("TeeImageToolEdit.pas");
USEFORMNS("TeeLinePointEditor.pas", Teelinepointeditor, LinePointEditor);
USEFORMNS("TeePo3DEdit.pas", Teepo3dedit, Point3DSeriesEditor);
USEUNIT("TeePyramid.pas");
USEFORMNS("TeePyramidEdit.pas", Teepyramidedit, PyramidSeriesEditor);
USEFORMNS("TeeSeriesTextEd.pas", Teeseriestexted, SeriesTextEditor);
USEUNIT("TeeSmith.pas");
USEFORMNS("TeeSmithEdit.pas", Teesmithedit, SmithSeriesEdit);
USEFORMNS("TeeAxisArrowEdit.pas", Teeaxisarrowedit, AxisArrowToolEditor);
USEUNIT("TeeWindRoseEditor.pas");
USEUNIT("TeeTriSurface.pas");
USEFORMNS("TeeTriSurfEdit.pas", Teetrisurfedit, TriSurfaceSeriesEditor);
USEFORMNS("TeeVolEd.pas", Teevoled, VolumeSeriesEditor);
USEFORMNS("TeeWaterFallEdit.pas", Teewaterfalledit, WaterFallEditor);
USEFORMNS("TeeToolSeriesEdit.pas", Teetoolseriesedit, SeriesToolEditor);
USEFORMNS("TeeNearestToolEditor.pas", Teenearesttooleditor, NearestToolEdit);
USEFORMNS("TeeDragMarksEdit.pas", Teedragmarksedit, DragMarksToolEditor);
USEUNIT("TeeCalendar.pas");
USEFORMNS("TeeCalendarEditor.pas", Teecalendareditor, CalendarSeriesEditor);
USEFORMNS("TeeSurfaceTool.pas", TeeSurfaceTool, SurfaceNearest);
USEFORMNS("TeeSelectorTool.pas", TeeSelectorTool, SelectorToolEditor);
USEFORMNS("TeeSeriesBandTool.pas", TeeSeriesBandTool, SeriesBandToolEditor);
USEUNIT("TeeDownSampling.pas");
USEUNIT("TeeThemes.pas");
USEFORMNS("TeeThemeEditor.pas", TeeThemeEditor, ChartThemeSelector);
USEFORMNS("TeeXml.pas", TeeXml, XMLSourceEditor);
USEFORMNS("TeePreviewPanelEditor.pas", TeePreviewPanelEditor, FormPreviewPanelEditor);
USEFORMNS("TeeOrgSeries.pas", TeeOrgSeries, OrgSeriesEditor);

//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
