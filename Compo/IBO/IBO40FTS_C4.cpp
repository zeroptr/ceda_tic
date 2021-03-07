//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C4.res");
USEUNIT("IB_FTS_Sync.pas");
USEUNIT("IB_FTS_Meta.pas");
USEUNIT("IB_FTS_Reg.pas");
USERES("IB_FTS_Reg.dcr");
USEFORMNS("IB_FTS_Scripts.pas", Ib_fts_scripts, dmFTS_Scripts);
USEUNIT("IB_FTS_Search.pas");
USEUNIT("IB_FTS_Base.pas");
USEPACKAGE("IBO40CRT_C4.bpi");
USEPACKAGE("IBO40TRT_C4.bpi");
USEPACKAGE("IBO40VRT_C4.bpi");
USEPACKAGE("vcl40.bpi");
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
