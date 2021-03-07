//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("DclTQR8C4.res");
USEUNIT("TeeQRTeeReg.pas");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("Tee8C4.bpi");
USEPACKAGE("TeeQR8C4.bpi");
USEPACKAGE("TeeDB8C4.bpi");
USEPACKAGE("TeeUI8C4.bpi");
USEPACKAGE("DclTee8C4.bpi");
USEPACKAGE("Vclx40.bpi");
USEPACKAGE("Vcljpg40.bpi");
USEPACKAGE("bcbsmp40.bpi");
USEPACKAGE("Qrpt40.bpi");
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
