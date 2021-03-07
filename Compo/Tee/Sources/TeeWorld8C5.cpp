//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("TeeWorld8C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("Tee8C5.bpi");
USEPACKAGE("TeePro8C5.bpi");
USEUNIT("TeeSHP.pas");
USEUNIT("TeeWorldSeries.pas");
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
