//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C4.res");
USEUNIT("IB_Web.pas");
USEPACKAGE("IBO40CRT_C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("inet40.bpi");
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
