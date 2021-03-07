//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("tee8C4.res");
USEUNIT("TeeProcs.pas");
USEUNIT("TeeConst.pas");
USEUNIT("TeCanvas.pas");
USEUNIT("TeEngine.pas");
USEUNIT("Chart.pas");
USEUNIT("TeeFunci.pas");
USEUNIT("Series.pas");
USEUNIT("TeeShape.pas");
USEUNIT("GanttCh.pas");
USEUNIT("BubbleCh.pas");
USEUNIT("ArrowCha.pas");
USEUNIT("TeeDraw3D.pas");
USEFORMNS("TeeAbout.pas", Teeabout, TeeAboutForm);
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcljpg40.bpi");
USEUNIT("TeeStore.pas");
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
