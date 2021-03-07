//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("Company.res");
USEFORMNS("FRM_Company.pas", Frm_company, frmCompany);
USEFORMNS("FRM_Employee.pas", Frm_employee, frmEmployee);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmCompany), &frmCompany);
        Application->CreateForm(__classid(TfrmEmployee), &frmEmployee);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
