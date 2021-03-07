//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C4.res");
USEUNIT("IB_RPL_Sync.pas");
USEUNIT("IB_RPL_Meta.pas");
USEUNIT("IB_RPL_Reg.pas");
USERES("IB_RPL_Reg.dcr");
USEFORMNS("IB_RPL_Scripts.pas", Ib_rpl_scripts, dmRPL_Scripts);
USEUNIT("IB_RPL_Base.pas");
USEPACKAGE("IBO40CRT_C4.bpi");
USEPACKAGE("IBO40TRT_C4.bpi");
USEPACKAGE("IBO40VRT_C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vclx40.bpi");
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
