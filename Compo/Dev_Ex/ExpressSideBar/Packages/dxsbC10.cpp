//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxsbC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEUNIT("dximctrl.pas");
USEUNIT("dxreginf.pas");
USEUNIT("dxsbar.pas");
USEFORMNS("dxsbarcs.pas", dxsbarcs, AForm);
USEUNIT("dxsbstrs.pas");
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
