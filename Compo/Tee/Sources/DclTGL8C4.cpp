//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcltgl8C4.res");
USEUNIT("TeeOpenGLReg.pas");
USEPACKAGE("teegl8C4.bpi");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vclx40.bpi");
USEPACKAGE("vcljpg40.bpi");
USEPACKAGE("TeeUI8C4.bpi");
USEPACKAGE("Tee8C4.bpi");
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
