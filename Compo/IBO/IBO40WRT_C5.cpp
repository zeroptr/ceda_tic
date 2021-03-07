//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40WRT_C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("inet50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEUNIT("IB_Web.pas");
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
