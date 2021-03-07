//---------------------------------------------------------------------------
#include <vcl.h>
#define CPPBUILDER3
#pragma hdrstop
USERES("Contact.res");
USEFORMNS("DM_Contact.pas", Dm_contact, dmContact); /* TDataModule: DesignClass */
USEFORMNS("FRM_Contact.pas", Frm_contact, frmContact);
USEFORMNS("..\..\IBF_Base.pas", Ibf_base, frmBase);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TdmContact), &dmContact);
        Application->CreateForm(__classid(TfrmContact), &frmContact);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
