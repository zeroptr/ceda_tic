//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40FRT_C5.res");
USEFORMNS("IBF_GenCalcFields.pas", Ibf_gencalcfields, frmGenCalcFields);
USEFORMNS("IBD_About.pas", Ibd_about, dlgAbout);
USEFORMNS("IBD_Credits.pas", Ibd_credits, dlgCredits);
USEFORMNS("IBD_Loading.pas", Ibd_loading, dlgLoading);
USEFORMNS("IBD_MemoEdit.pas", Ibd_memoedit, dlgMemoEdit);
USEFORMNS("IBD_USearch.pas", Ibd_usearch, frmUSearch);
USEFORMNS("IBF_Base.pas", Ibf_base, frmBase);
USEFORMNS("IBF_Browse.pas", Ibf_browse, frmBrowse);
USEFORMNS("IBF_DataDump.pas", Ibf_datadump, frmDataDump);
USEFORMNS("IBF_DataPump.pas", Ibf_datapump, frmDataPump);
USEFORMNS("IBF_DSQL.pas", Ibf_dsql, frmDSQL);
USEFORMNS("IBF_Events.pas", Ibf_events, frmEvents);
USEFORMNS("IBF_Export.pas", Ibf_export, frmExport);
USEUNIT("IB_Dialogs.pas");
USEFORMNS("IBF_GenCustomSQL.pas", Ibf_gencustomsql, frmGenCustomSQL);
USEFORMNS("IBF_Lookup.pas", Ibf_lookup, frmLookup);
USEFORMNS("IBF_Monitor.pas", Ibf_monitor, frmMonitor);
USEFORMNS("IBF_Parameters.pas", Ibf_parameters, frmParameters);
USEFORMNS("IBF_Profiler.pas", Ibf_profiler, frmProfiler);
USEFORMNS("IBF_Query.pas", Ibf_query, frmQuery);
USEFORMNS("IBF_Script.pas", Ibf_script, frmScript);
USEFORMNS("IBF_Status.pas", Ibf_status, frmStatus);
USEFORMNS("IBF_Users.pas", Ibf_users, frmUsers);
USEFORMNS("IBF_Who.pas", Ibf_who, frmWho);
USEFORMNS("IBF_SQL.pas", Ibf_sql, frmSQL);
USEFORMNS("IBF_WorkUnit.pas", Ibf_workunit, frmWorkUnit);
USEFORMNS("IBF_DDL_Extract.pas", Ibf_ddl_extract, frmDDLExtract);
USEFORMNS("IBF_Metadata.pas", Ibf_Metadata, frmMetadataExtract);
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("vclsmp50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
USEPACKAGE("IBO40TRT_C5.bpi");
USEPACKAGE("IBO40VRT_C5.bpi");
USEUNIT("IB_UtilityBar.pas");
USEFORMNS("IBD_CreateOrdering.pas", Ibd_createordering, dlgCLBoxEdit);
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
