//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinOffice2007Blue.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxSkinsCoreC14.bpi");
USEUNIT("dxSkinOffice2007Blue.pas");
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
