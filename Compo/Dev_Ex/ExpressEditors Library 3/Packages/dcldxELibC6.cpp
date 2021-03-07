//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxELibC6.res");
USERES("dxEdLReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxELibC6.bpi");
USEUNIT("dxEdLReg.pas");
USEFORMNS("dxImgEd.pas", dxImgEd, FImageValuesEdit);
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
