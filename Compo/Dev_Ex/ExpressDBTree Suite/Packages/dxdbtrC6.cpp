//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxdbtrC6.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEUNIT("dxdbtree.pas");
USEUNIT("dxlocate.pas");
USEUNIT("dxtree.pas");
USEUNIT("dxdbtrel.pas");
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
