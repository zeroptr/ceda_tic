//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("KeyLinks.res");
USEFORMNS("FRM_KeyLinks.pas", Frm_keylinks, frmKeyLinks);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmKeyLinks), &frmKeyLinks);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
