//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("TeeWorld8C4.res");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("Tee8C4.bpi");
USEPACKAGE("TeePro8C4.bpi");
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
