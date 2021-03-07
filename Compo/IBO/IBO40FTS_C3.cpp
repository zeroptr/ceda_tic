//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("IBO40_C3.res");
USEUNIT("IB_FTS_Sync.pas");
USEUNIT("IB_FTS_Meta.pas");
USEUNIT("IB_FTS_Reg.pas");
USERES("IB_FTS_Reg.dcr");
USEFORMNS("IB_FTS_Scripts.pas", Ib_fts_scripts, dmFTS_Scripts); /* TDataModule: File Type */
USEUNIT("IB_FTS_Search.pas");
USEUNIT("IB_FTS_Base.pas");
USEPACKAGE("vcl35.bpi");
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
