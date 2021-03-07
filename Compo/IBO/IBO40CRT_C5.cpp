//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("IBO40CRT_C5.res");
USEUNIT("IB_Header.pas");
USEUNIT("IB_Schema.pas");
USEUNIT("IB_Constants.pas");
USEUNIT("IB_Parse.pas");
USEUNIT("IB_Components.pas");
USEUNIT("IB_Session.pas");
USEUNIT("IB_Utils.pas");
USEUNIT("Unixpass.pas");
USEUNIT("uRounding.pas");
USEUNIT("IB_MaskInterface.pas");
USEUNIT("IB_ConnectionSource.pas");
USEUNIT("IB_NodeList.pas");
USEUNIT("IB_SessionProps.pas");
USEUNIT("IB_StatementSource.pas");
USEUNIT("IB_StoredProc.pas");
USEUNIT("IB_TransactionSource.pas");
USEFORMNS("IBD_CancelQuery.pas", Ibd_cancelquery, dlgCancelQuery);
USEFORMNS("IBD_Error.pas", Ibd_error, dlgError);
USEFORMNS("IBD_Login.pas", Ibd_login, dlgLogin);
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
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
