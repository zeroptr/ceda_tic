//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C3.res");
USEUNIT("IBOWebReg.pas");
USERES("IBOWebReg.dcr");
USEPACKAGE("vcl35.bpi");
USEPACKAGE("vcldb35.bpi");
USEPACKAGE("inetdb35.bpi");
USEPACKAGE("inet35.bpi");
USEPACKAGE("IBO40CRT_C3.bpi");
USEPACKAGE("IBO40XRT_C3.bpi");
USEPACKAGE("IBO40WXRT_C3.bpi");
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
