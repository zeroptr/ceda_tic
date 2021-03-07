//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40XDT_C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEPACKAGE("IBO40XRT_C5.bpi");
USEPACKAGE("IBO40TRT_C5.bpi");
USEPACKAGE("IBO40VRT_C5.bpi");
USEPACKAGE("IBO40FRT_C5.bpi");
USEUNIT("IBODatasetReg.pas");
USERES("IBODatasetReg.dcr");
USEUNIT("IBODatasetEditors.pas");
USEPACKAGE("VCLDB50.bpi");
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
