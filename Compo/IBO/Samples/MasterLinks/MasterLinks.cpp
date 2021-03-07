//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("MasterLinks.res");
USEFORMNS("FRM_MasterLinks.pas", Frm_masterlinks, frmMasterLinks);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmMasterLinks), &frmMasterLinks);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
