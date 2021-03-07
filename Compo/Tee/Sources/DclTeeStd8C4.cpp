//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclteestd8C4.res");
USEUNIT("TeeChartReg.pas");
USEPACKAGE("tee8C4.bpi");
USEPACKAGE("teeUI8C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("dclstd40.bpi");
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
