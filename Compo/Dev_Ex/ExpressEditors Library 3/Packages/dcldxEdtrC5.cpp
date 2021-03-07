//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxEdtrC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("dclstd50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxComnC5.bpi");
USEUNIT("dxEdReg.pas");
USERES("dxEdReg.dcr");
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
