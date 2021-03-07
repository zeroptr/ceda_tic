//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxEdtrC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("dxComnC5.bpi");
USEUNIT("dxExEdtr.pas");
USEUNIT("dxCntner.pas");
USEUNIT("dxEditor.pas");
USEUNIT("dxEdStr.pas");
USEUNIT("dxCalc.pas");
USEUNIT("dxGrDate.pas");
USEUNIT("dxUtils.pas");
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
