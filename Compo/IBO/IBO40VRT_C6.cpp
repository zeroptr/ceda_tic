//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("IBD_IBMemoEdit.pas", Ibd_ibmemoedit, dlgIBMemoEdit);
USEFORMNS("IBD_Ordering.pas", Ibd_ordering, dlgOrdering);
USEFORMNS("IBD_Restructure.pas", Ibd_restructure, dlgRestructure);
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
