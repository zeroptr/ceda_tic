//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxFlowChartC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxFlowChartC11.bpi");
USEUNIT("Dxfchreg.pas");
USEUNIT("dxEditCon.pas");
USEUNIT("dxEditObj.pas");
USEUNIT("dxFcEdit.pas");
USEUNIT("dxSelUnion.pas");
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
