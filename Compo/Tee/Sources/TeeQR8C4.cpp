//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeeQR8C4.res");
USEPACKAGE("tee8C4.bpi");
USEPACKAGE("teeDB8C4.bpi");
USEPACKAGE("teeUI8C4.bpi");
USEUNIT("QRTee.pas");
USEPACKAGE("qrpt40.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
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
