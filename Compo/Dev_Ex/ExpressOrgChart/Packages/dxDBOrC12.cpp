//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxDBOrC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vclDB.bpi");
USEPACKAGE("dxOrgcC12.bpi");
USEUNIT("dxdborgc.pas");
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
