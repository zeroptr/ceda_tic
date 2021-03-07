//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("DclTQR8C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("Tee8C5.bpi");
USEPACKAGE("TeeQR8C5.bpi");
USEUNIT("TeeQrTeeReg.pas");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("TeeDB8C5.bpi");
USEPACKAGE("vclbde50.bpi");
USEPACKAGE("TEEUI8C5.bpi");
USEPACKAGE("DclTee8C5.bpi");
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
