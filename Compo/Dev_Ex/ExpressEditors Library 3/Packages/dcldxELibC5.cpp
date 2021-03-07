//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxELibC5.res");
USERES("dxEdLReg.dcr");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dclstd50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxELibC5.bpi");
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
