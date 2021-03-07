//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C3.res");
USEUNIT("IB_VisualReg.pas");
USERES("IB_VisualReg.dcr");
USEPACKAGE("vcl35.bpi");
USEPACKAGE("IBO40CRT_C3.bpi");
USEPACKAGE("IBO40TRT_C3.bpi");
USEPACKAGE("IBO40VRT_C3.bpi");
USEPACKAGE("IBO40FRT_C3.bpi");
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
