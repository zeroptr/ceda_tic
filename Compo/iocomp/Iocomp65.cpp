//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#pragma resource "iPlotPackReg.dcr"
#pragma resource "iInstrumentPackReg.dcr"
#pragma resource "iProfessionalReg.dcr"
#pragma resource "iOPCCommonReg.dcr"
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
 