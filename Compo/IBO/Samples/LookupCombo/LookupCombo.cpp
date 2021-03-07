//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("LookupCombo.res");
USEFORMNS("FRM_LookupCombo.pas", Frm_lookupcombo, frmLookupCombo);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmLookupCombo), &frmLookupCombo);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
