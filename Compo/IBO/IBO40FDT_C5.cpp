//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40FDT_C5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("IB_FormsReg.pas");
USERES("IB_FormsReg.dcr");
USEPACKAGE("IBO40FRT_C5.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEPACKAGE("IBO40VRT_C5.bpi");
USEPACKAGE("IBO40TRT_C5.bpi");
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
