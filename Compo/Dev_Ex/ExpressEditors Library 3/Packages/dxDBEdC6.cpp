//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxDBEdC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxComnC6.bpi");
USEUNIT("dxDBEdtr.pas");
USEPACKAGE("dxEdtrC6.bpi");
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
