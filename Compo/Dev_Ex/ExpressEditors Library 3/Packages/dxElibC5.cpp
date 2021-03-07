//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxELibC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxDBEdC5.bpi");
USEUNIT("dxEdLib.pas");
USEUNIT("dxDBELib.pas");
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
