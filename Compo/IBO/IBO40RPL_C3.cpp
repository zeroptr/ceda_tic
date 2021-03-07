//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C3.res");
USEUNIT("IB_RPL_Sync.pas");
USEUNIT("IB_RPL_Meta.pas");
USEUNIT("IB_RPL_Reg.pas");
USERES("IB_RPL_Reg.dcr");
USEFORMNS("IB_RPL_Scripts.pas", Ib_rpl_scripts, dmRPL_Scripts); /* TDataModule: File Type */
USEUNIT("IB_RPL_Base.pas");
USEPACKAGE("vcl35.bpi");
USEPACKAGE("vclx35.bpi");
USEPACKAGE("IBO40CRT_C3.bpi");
USEPACKAGE("IBO40TRT_C3.bpi");
USEPACKAGE("IBO40VRT_C3.bpi");
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
