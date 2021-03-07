//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl40.bpi");
USEUNIT("iProfessionalReg.pas");
USERES("iProfessionalReg.dcr");
USEUNIT("iInstrumentPackReg.pas");
USERES("iInstrumentPackReg.dcr");
USEUNIT("iPlotPackPropertyEditorsReg.pas");
USEUNIT("iPlotPackReg.pas");
USERES("iPlotPackReg.dcr");
USEUNIT("iProfessionalPropertyEditorsReg.pas");
USEUNIT("iInstrumentPackPropertyEditorsReg.pas");
USEUNIT("iOPCCommonPropertyEditorsReg.pas");
USEUNIT("iOPCCommonReg.pas");
USERES("iOPCCommonReg.dcr");
USEPACKAGE("vcljpg40.bpi");
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
