
{                                                                              }
{   IB_SQL                                                                     }
{                                                                              }

program
  IB_SQL;

uses
  Forms,
  Registry,
  IBD_About in 'IBD_About.pas' {dlgAbout},
  IBF_Base in 'IBF_Base.pas' {frmBase},
  IBF_SQL in 'IBF_SQL.pas' {frmSQL},
  IBF_Browse in 'IBF_Browse.pas' {frmBrowse},
  IBF_DSQL in 'IBF_DSQL.pas' {frmDSQL},
  IBF_Events in 'IBF_Events.pas' {frmEvents},
  IBF_DataPump in 'IBF_DataPump.pas' {frmDataPump},
  IBF_Monitor in 'IBF_Monitor.pas' {frmMonitor},
  IBF_Query in 'IBF_Query.pas' {frmQuery},
  IBF_Script in 'IBF_Script.pas' {frmScript},
  IBF_Users in 'IBF_Users.pas' {frmUsers},
  IBF_Who in 'IBF_Who.pas' {frmWho},
  IBF_Export in 'IBF_Export.pas' {frmExport},
  IBF_DataDump in 'IBF_DataDump.pas' {frmDataDump},
  IBD_CancelQuery in 'IBD_CancelQuery.pas' {dlgCancelQuery},
  IBD_Login in 'IBD_Login.pas' {dlgLogin},
  IBD_Ordering in 'IBD_Ordering.pas' {dlgOrdering},
  IBF_Parameters in 'IBF_Parameters.pas' {frmParameters},
  IB_Components in 'IB_Components.pas',
  IB_ConnectionBar in 'IB_ConnectionBar.pas',
  IB_ConnectionSource in 'IB_ConnectionSource.pas',
  IB_Constants in 'IB_Constants.pas',
  IB_CursorGrid in 'IB_CursorGrid.pas',
  IB_DatasetBar in 'IB_DatasetBar.pas',
  IB_Events in 'IB_Events.pas',
  IB_Export in 'IB_Export.pas',
  IB_FieldDataLink in 'IB_FieldDataLink.pas',
  IB_Grid in 'IB_Grid.pas',
  IB_Header in 'IB_Header.pas',
  IB_Monitor in 'IB_Monitor.pas',
  IB_NavigationBar in 'IB_NavigationBar.pas',
  IB_ParamEdit in 'IB_ParamEdit.pas',
  IB_Parse in 'IB_Parse.pas',
  IB_Schema in 'IB_Schema.pas',
  IB_Script in 'IB_Script.pas',
  IB_SearchBar in 'IB_SearchBar.pas',
  IB_SearchEdit in 'IB_SearchEdit.pas',
  IB_SearchPanel in 'IB_SearchPanel.pas',
  IB_Session in 'IB_Session.pas',
  IB_SessionProps in 'IB_SessionProps.pas',
  IB_StatementBar in 'IB_StatementBar.pas',
  IB_StatementGrid in 'IB_StatementGrid.pas',
  IB_StatementSource in 'IB_StatementSource.pas',
  IB_StoredProc in 'IB_StoredProc.pas',
  IB_TransactionBar in 'IB_TransactionBar.pas',
  IB_TransactionSource in 'IB_TransactionSource.pas',
  IB_UpdateBar in 'IB_UpdateBar.pas',
  IB_DataScan in 'IB_DataScan.pas',
  IB_DataPump in 'IB_DataPump.pas',
  IB_Process in 'IB_Process.pas',
  IB_UtilityBar in 'IB_UtilityBar.pas',
  IBD_Error in 'IBD_Error.pas' {dlgError},
  IB_Utils in 'IB_Utils.pas',
  IBF_Lookup in 'IBF_Lookup.pas' {frmLookup},
  IBD_Loading in 'IBD_Loading.pas' {dlgLoading},
  IB_IncSearch in 'IB_IncSearch.pas',
  IBD_USearch in 'IBD_USearch.pas' {frmUSearch},
  IBD_MemoEdit in 'IBD_MemoEdit.pas' {dlgMemoEdit},
  IBD_IBMemoEdit in 'IBD_IBMemoEdit.pas' {dlgIBMemoEdit},
  IBD_Credits in 'IBD_Credits.pas' {dlgCredits},
  IB_Profiler in 'IB_Profiler.pas',
  IBF_Profiler in 'IBF_Profiler.pas' {frmProfiler},
  IBF_GenCustomSQL in 'IBF_GenCustomSQL.pas' {frmGenCustomSQL},
  IBF_GenCalcFields in 'IBF_GenCalcFields.pas' {frmGenCalcFields},
  IBD_CreateOrdering in 'IBD_CreateOrdering.pas' {dlgCLBoxEdit},
  IBF_Metadata in 'IBF_Metadata.pas' {frmMetadataExtract};

{$R *.RES}

var
  frmSQL: TfrmSQL;

begin
  CheckForReservedTokens := true;
  Application.Initialize;
  Application.Title := 'IB_SQL';
  Application.CreateForm(TfrmSQL, frmSQL);
  Application.CreateForm(TfrmMetadataExtract, frmMetadataExtract);
  frmSQL.BaseKey := 'Software\CPS\IB_WISQL';
{ $ ELSE}
//  frmSQL.BaseKey := 'Software\CPS\IB_SQL';
{ $ ENDIF}
  Application.Run;
end.


