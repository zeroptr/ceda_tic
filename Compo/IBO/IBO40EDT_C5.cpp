//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40EDT_C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEPACKAGE("IBO40TRT_C5.bpi");
USEPACKAGE("IBO40VRT_C5.bpi");
USEPACKAGE("IBO40FRT_C5.bpi");
USEUNIT("IB_Editors.pas");
USEFORMNS("IB_LedgerEditor.pas", Ib_ledgereditor, dlgIB_LedgerSetup);
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
