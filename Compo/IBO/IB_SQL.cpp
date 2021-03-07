//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IB_SQL.res");
USEFORMNS("IBF_Base.pas", Ibf_base, frmBase);
USEFORMNS("IBD_About.pas", Ibd_about, dlgAbout);
USEFORMNS("IBF_SQL.pas", Ibf_sql, frmSQL);
USEFORMNS("IBF_Browse.pas", Ibf_browse, frmBrowse);
USEFORMNS("IBF_Who.pas", Ibf_who, frmWho);
USEFORMNS("IBF_DSQL.pas", Ibf_dsql, frmDSQL);
USEFORMNS("IBF_Events.pas", Ibf_events, frmEvents);
USEFORMNS("IBF_Monitor.pas", Ibf_monitor, frmMonitor);
USEFORMNS("IBF_Query.pas", Ibf_query, frmQuery);
USEFORMNS("IBF_Script.pas", Ibf_script, frmScript);
USEFORMNS("IBF_Users.pas", Ibf_users, frmUsers);
USEFORMNS("IBF_DataPump.pas", Ibf_datapump, frmDataPump);
USEFORMNS("IBF_Parameters.pas", Ibf_parameters, frmParameters);
USEFORMNS("IBD_Login.pas", Ibd_login, dlgLogin);
USEFORMNS("IBD_Ordering.pas", Ibd_ordering, dlgOrdering);
USEFORMNS("IBF_DataDump.pas", Ibf_datadump, frmDataDump);
USEFORMNS("IBF_Export.pas", Ibf_export, frmExport);
USEFORMNS("IBD_CancelQuery.pas", Ibd_cancelquery, dlgCancelQuery);
USEUNIT("IB_Script.pas");
USEUNIT("IB_ConnectionBar.pas");
USEUNIT("IB_ConnectionSource.pas");
USEUNIT("IB_Constants.pas");
USEUNIT("IB_CursorGrid.pas");
USEUNIT("IB_DatasetBar.pas");
USEUNIT("IB_Events.pas");
USEUNIT("IB_Export.pas");
USEUNIT("IB_FieldDataLink.pas");
USEUNIT("IB_Grid.pas");
USEUNIT("IB_Header.pas");
USEUNIT("IB_Monitor.pas");
USEUNIT("IB_NavigationBar.pas");
USEUNIT("IB_ParamEdit.pas");
USEUNIT("IB_Parse.pas");
USEUNIT("IB_Schema.pas");
USEUNIT("IB_Components.pas");
USEUNIT("IB_Process.pas");
USEUNIT("IB_DataScan.pas");
USEUNIT("IB_DataPump.pas");
USEUNIT("IB_SearchBar.pas");
USEUNIT("IB_SearchEdit.pas");
USEUNIT("IB_SearchPanel.pas");
USEUNIT("IB_Session.pas");
USEUNIT("IB_SessionProps.pas");
USEUNIT("IB_StatementBar.pas");
USEUNIT("IB_StatementGrid.pas");
USEUNIT("IB_StatementSource.pas");
USEUNIT("IB_StoredProc.pas");
USEUNIT("IB_TransactionBar.pas");
USEUNIT("IB_TransactionSource.pas");
USEUNIT("IB_UpdateBar.pas");
USEFORMNS("IBD_CreateOrdering.pas", Ibd_createordering, dlgCLBoxEdit);
USEUNIT("IB_Profiler.pas");
USEUNIT("IB_UtilityBar.pas");
USEUNIT("IB_Utils.pas");
USEUNIT("IB_IncSearch.pas");
USEFORMNS("IBD_Credits.pas", Ibd_credits, dlgCredits);
USEFORMNS("IBD_Error.pas", Ibd_error, dlgError);
USEFORMNS("IBD_IBMemoEdit.pas", Ibd_ibmemoedit, dlgIBMemoEdit);
USEFORMNS("IBD_Loading.pas", Ibd_loading, dlgLoading);
USEFORMNS("IBD_MemoEdit.pas", Ibd_memoedit, dlgMemoEdit);
USEFORMNS("IBD_USearch.pas", Ibd_usearch, frmUSearch);
USEFORMNS("IBF_GenCalcFields.pas", Ibf_gencalcfields, frmGenCalcFields);
USEFORMNS("IBF_GenCustomSQL.pas", Ibf_gencustomsql, frmGenCustomSQL);
USEFORMNS("IBF_Lookup.pas", Ibf_lookup, frmLookup);
USEFORMNS("IBF_Profiler.pas", Ibf_profiler, frmProfiler);
//---------------------------------------------------------------------------
#include "IBF_SQL.hpp"
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
         Application->Initialize();
         Application->Title = "IB_SQL";
         Application->CreateForm(__classid(TfrmSQL), &frmSQL);
         frmSQL->BaseKey = "Software\CPS\IB_WISQL";
         Application->Run();
    }
    catch (Exception &exception)
    {
         Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
