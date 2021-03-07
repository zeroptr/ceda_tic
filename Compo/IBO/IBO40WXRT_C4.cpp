//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C4.res");
USEUNIT("IBOWeb.pas");
USEPACKAGE("IBO40CRT_C4.bpi");
USEPACKAGE("IBO40XRT_C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("inet40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("inetdb40.bpi");
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
