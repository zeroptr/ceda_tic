//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEUNIT("IB_DataPump.pas");
USEUNIT("IB_DataScan.pas");
USEUNIT("IB_Events.pas");
USEUNIT("IB_Export.pas");
USEUNIT("IB_Import.pas");
USEUNIT("IB_Monitor.pas");
USEUNIT("IB_Process.pas");
USEUNIT("IB_Profiler.pas");
USEUNIT("IB_Script.pas");
USEUNIT("IB_SyncCursor.pas");
USEUNIT("IB_DDL_Utility.pas");
USEUNIT("IB_DDL_Entity.pas");
USEUNIT("IB_DDL_EntityList.pas");
USEUNIT("IB_DDL_EntWithParams.pas");
USEUNIT("IB_DDL_Formatter.pas");
USEUNIT("IB_DDL_ParamList.pas");
USEUNIT("IB_DDL_Controller.pas");
USEUNIT("IB_Metadata.pas");
USEUNIT("IB_CodeFormatter.pas");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vclx40.bpi");
USEPACKAGE("IBO40CRT_C4.bpi");
USERES("IBO40_C4.res");
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