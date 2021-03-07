//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("DCLTree2C4Tee8.res");
USEPACKAGE("vcl40.bpi");
USEUNIT("TreeReg.pas");
USEUNIT("TreeDBReg.pas");
USEPACKAGE("TeeTree2C4Tee8.bpi");
USEPACKAGE("Vcldb40.bpi");
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
