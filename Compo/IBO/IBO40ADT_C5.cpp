//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40ADT_C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEPACKAGE("vclx50.bpi");
USEUNIT("IB_AccessReg.pas");
USERES("IB_AccessReg.dcr");
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
