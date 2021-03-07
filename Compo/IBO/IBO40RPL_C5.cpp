//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40RPL_C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEUNIT("IB_RPL_Sync.pas");
USEUNIT("IB_RPL_Meta.pas");
USEUNIT("IB_RPL_Reg.pas");
USERES("IB_RPL_Reg.dcr");
USEFORMNS("IB_RPL_Scripts.pas", Ib_rpl_scripts, dmRPL_Scripts); /* TDataModule: File Type */
USEUNIT("IB_RPL_Base.pas");
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
