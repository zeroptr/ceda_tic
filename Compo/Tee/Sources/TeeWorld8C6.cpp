//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USERES("TeeWorld8C6.res");
USEPACKAGE("vcl60.bpi");
USEPACKAGE("vcldb60.bpi");
USEPACKAGE("Tee8C6.bpi");
USEPACKAGE("TeePro8C6.bpi");
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
