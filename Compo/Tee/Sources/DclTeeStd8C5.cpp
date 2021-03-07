//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DclTeeStd8C5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("dclstd50.bpi");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("Tee8C5.bpi");
USEPACKAGE("TeeUI8C5.bpi");
USEUNIT("TeeChartExp.pas");
USEFORMNS("TeeExpForm.pas", Teeexpform, TeeDlgWizard);
USEUNIT("TeeChartReg.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
  return 1;
}
//---------------------------------------------------------------------------
