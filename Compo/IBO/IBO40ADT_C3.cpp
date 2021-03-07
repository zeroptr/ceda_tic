//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C3.res");
USEUNIT("IB_AccessReg.pas");
USERES("IB_AccessReg.dcr");
USEPACKAGE("vcl35.bpi");
USEPACKAGE("vclx35.bpi");
USEPACKAGE("IBO40CRT_C3.bpi");
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
