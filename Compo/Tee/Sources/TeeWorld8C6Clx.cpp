//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USERES("TeeWorld8C6Clx.res");
USEPACKAGE("visualclx60.bpi");
USEPACKAGE("visualdbclx60.bpi");
USEPACKAGE("Tee8C6Clx.bpi");
USEPACKAGE("TeePro8C6Clx.bpi");
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
