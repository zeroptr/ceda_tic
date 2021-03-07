//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40WXDT_C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("inetdb50.bpi");
USEPACKAGE("inet50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEPACKAGE("IBO40XRT_C5.bpi");
USEUNIT("IBOWebReg.pas");
USERES("IBOWebReg.dcr");
USEPACKAGE("IBO40WXRT_C5.bpi");
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
