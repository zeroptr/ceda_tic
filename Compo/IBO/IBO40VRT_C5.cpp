//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40VRT_C5.res");
USEUNIT("IB_NavigationBar.pas");
USEUNIT("IB_ActionNavigate.pas");
USEUNIT("IB_ActionTransaction.pas");
USEUNIT("IB_ActionUpdate.pas");
USEUNIT("IB_ArrayGrid.pas");
USEUNIT("IB_CGrid.pas");
USEUNIT("IB_ConnectionBar.pas");
USEUNIT("IB_Controls.pas");
USEUNIT("IB_CursorGrid.pas");
USEUNIT("IB_DatasetBar.pas");
USEUNIT("IB_FieldDataLink.pas");
USEUNIT("IB_Grid.pas");
USEUNIT("IB_IncSearch.pas");
USEUNIT("IB_Ledger.pas");
USEUNIT("IB_LocateEdit.pas");
USEUNIT("DatePick.pas");
USEUNIT("IB_SearchPanel.pas");
USEUNIT("XSpin.pas");
USEUNIT("IB_ParamEdit.pas");
USEUNIT("IB_SearchBar.pas");
USEUNIT("IB_SearchEdit.pas");
USEUNIT("IB_StatementBar.pas");
USEUNIT("IB_StatementGrid.pas");
USEUNIT("IB_TransactionBar.pas");
USEUNIT("IB_UpdateBar.pas");
USEUNIT("IBC_CustomLabel.pas");
USEUNIT("IBC_Label.pas");
USEFORMNS("IBD_IBMemoEdit.pas", Ibd_ibmemoedit, dlgIBMemoEdit);
USEFORMNS("IBD_Ordering.pas", Ibd_ordering, dlgOrdering);
USEFORMNS("IBD_Restructure.pas", Ibd_restructure, dlgRestructure);
USEUNIT("IB_ControlInterface.pas");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("IBO40CRT_C5.bpi");
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
