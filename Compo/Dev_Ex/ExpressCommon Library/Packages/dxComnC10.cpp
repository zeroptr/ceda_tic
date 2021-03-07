//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxComnC10.res");
USEPACKAGE("vcl.bpi");
USEFORMNS("dxrgkeya.pas", Dxrgkeya, frmdxAddNewRegKey);
USEFORMNS("dxreged.pas", Dxreged, frmdxLibREgPathEditor);
USEUNIT("dxCommon.pas");
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
