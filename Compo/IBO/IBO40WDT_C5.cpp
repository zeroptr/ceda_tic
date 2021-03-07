//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40WDT_C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("inet50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEUNIT("IB_WebReg.pas");
USERES("IB_WebReg.dcr");
USEPACKAGE("IBO40WRT_C5.bpi");
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
