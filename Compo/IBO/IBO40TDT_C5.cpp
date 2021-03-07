//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40TDT_C5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("IB_ToolsReg.pas");
USERES("IB_ToolsReg.dcr");
USEPACKAGE("IBO40CRT_C5.bpi");
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
