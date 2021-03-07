//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("Events.res");
USEFORMNS("FRM_Events.pas", Frm_events, frmEvents);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmEvents), &frmEvents);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
