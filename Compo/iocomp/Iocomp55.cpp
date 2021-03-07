//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("Iocomp55.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("bcbsmp50.bpi");
USEPACKAGE("vcljpg50.bpi");
USEUNIT("iProfessionalReg.pas");
USERES("iProfessionalReg.dcr");
USEUNIT("iInstrumentPackPropertyEditorsReg.pas");
USEUNIT("iInstrumentPackReg.pas");
USERES("iInstrumentPackReg.dcr");
USEUNIT("iOPCCommonPropertyEditorsReg.pas");
USEUNIT("iOPCCommonReg.pas");
USERES("iOPCCommonReg.dcr");
USEUNIT("iPlotPackPropertyEditorsReg.pas");
USEUNIT("iPlotPackReg.pas");
USERES("iPlotPackReg.dcr");
USEUNIT("iProfessionalPropertyEditorsReg.pas");
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
