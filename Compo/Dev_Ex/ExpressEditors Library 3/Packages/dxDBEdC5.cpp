//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxDBEdC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxComnC5.bpi");
USEUNIT("dxDBEdtr.pas");
USEPACKAGE("dxEdtrC5.bpi");
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
