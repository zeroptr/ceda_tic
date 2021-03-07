//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USERES("tee8C6.res");
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
USEFORMNS("TeeAbout.pas", TeeAbout, TeeAboutForm);
USEPACKAGE("vcl60.bpi");
USEPACKAGE("vcljpg60.bpi");
USEUNIT("TeeStore.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
