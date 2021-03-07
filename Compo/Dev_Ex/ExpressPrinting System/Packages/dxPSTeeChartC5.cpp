//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSTeeChartc5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("dxPSCorec5.bpi");
#ifndef TEEPRO
USEPACKAGE("tee50.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5c5.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6c5.bpi");
#elif defined(TEE7)
USEPACKAGE("tee7c5.bpi");
#elif defined(TEE8)
USEPACKAGE("tee8c5.bpi");
#endif
USEUNIT("dxPSTCLnk.pas");
USEUNIT("dxPSTCLnkReg.pas");
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
