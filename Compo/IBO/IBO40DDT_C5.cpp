//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40DDT_C5.res");
USEFORMNS("IB_LedgerEditor.pas", Ib_ledgereditor, dlgIB_LedgerSetup);
USEUNIT("IB_Editors.pas");
USEUNIT("IB_Registration.pas");
USERES("IB_Registration.dcr");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEPACKAGE("IBO40TRT_C5.bpi");
USEPACKAGE("IBO40VRT_C5.bpi");
USEPACKAGE("IBO40FRT_C5.bpi");
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
