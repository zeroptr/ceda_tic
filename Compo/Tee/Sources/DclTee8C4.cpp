//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcltee8C4.res");
USEUNIT("TeeChartReg.pas");
USEPACKAGE("dcldb40.bpi");
USEPACKAGE("tee8C4.bpi");
USEPACKAGE("teedb8C4.bpi");
USEPACKAGE("teeUI8C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("vclx40.bpi");
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
