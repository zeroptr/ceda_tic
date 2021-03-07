//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C4.res");
USEUNIT("IB_FormsReg.pas");
USERES("IB_FormsReg.dcr");
USEPACKAGE("IBO40CRT_C4.bpi");
USEPACKAGE("IBO40TRT_C4.bpi");
USEPACKAGE("IBO40VRT_C4.bpi");
USEPACKAGE("IBO40FRT_C4.bpi");
USEPACKAGE("vcl40.bpi");
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
