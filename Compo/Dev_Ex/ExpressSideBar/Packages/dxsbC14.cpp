//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxsbC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxcomnC14.bpi");
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
