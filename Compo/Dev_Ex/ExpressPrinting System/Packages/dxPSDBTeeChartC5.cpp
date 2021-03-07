//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSDBTeeChartc5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxPSTeeChartc5.bpi");
#ifndef TEEPRO
USEPACKAGE("tee50.bpi");
USEPACKAGE("teedb50.bpi");
#elif defined(TEE5)
USEPACKAGE("tee5c5.bpi");
USEPACKAGE("teedb5c5.bpi");
#elif defined(TEE6)
USEPACKAGE("tee6c5.bpi");
USEPACKAGE("teedb6c5.bpi");
#elif defined(TEE7)
USEPACKAGE("tee7c5.bpi");
USEPACKAGE("teedb7c5.bpi");
#elif defined(TEE8)
USEPACKAGE("tee8c5.bpi");
USEPACKAGE("teedb8c5.bpi");
#endif
USEUNIT("dxPSDBTCLnk.pas");
USEUNIT("dxPSDBTCLnkReg.pas");
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
