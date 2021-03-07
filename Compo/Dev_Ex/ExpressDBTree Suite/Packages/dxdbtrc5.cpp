//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxdbtrc5.res");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxcomnc5.bpi");
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
