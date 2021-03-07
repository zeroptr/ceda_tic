//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("BlobInserts.res");
USEFORMNS("FRM_BlobInserts.pas", Frm_blobinserts, frmBlobInserts);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmBlobInserts), &frmBlobInserts);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
