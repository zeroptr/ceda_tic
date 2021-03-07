//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("IBD_CancelQuery.pas", Ibd_cancelquery, dlgCancelQuery);
USEFORMNS("IBD_Error.pas", Ibd_error, dlgError);
USEFORMNS("IBD_Login.pas", Ibd_login, dlgLogin);
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
