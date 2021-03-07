//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TestScan.res");
USEFORMNS("FRM_TestScan.pas", Frm_testscan, frmTestScan);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmTestScan), &frmTestScan);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
