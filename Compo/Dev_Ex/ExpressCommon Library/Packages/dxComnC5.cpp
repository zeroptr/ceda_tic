//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxComnC5.res");
USEPACKAGE("vcl50.bpi");
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
