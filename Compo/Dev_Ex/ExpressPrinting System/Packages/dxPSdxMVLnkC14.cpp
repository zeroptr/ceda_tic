//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("dxMasterViewC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USERES("dxPSdxMVLnkC14.res");
USEUNIT("dxPSMD.pas");
USEFORMNS("dxPSdxMVLnk.pas", Dxpsdxmvlnk, dxMVReportLinkDesignWindow);
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
