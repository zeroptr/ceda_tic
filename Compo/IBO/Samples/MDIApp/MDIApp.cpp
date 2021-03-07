//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("MDIApp.res");
USEFORMNS("Main.pas", Main, MainForm);
USEFORMNS("Form_Employee.pas", Form_employee, frmEmployee);
USEFORMNS("Form_Order.pas", Form_order, frmOrder);
USEFORMNS("Form_Customer.pas", Form_customer, frmCustomer);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TMainForm), &MainForm);
        Application->CreateForm(__classid(TfrmEmployee), &frmEmployee);
        Application->CreateForm(__classid(TfrmOrder), &frmOrder);
        Application->CreateForm(__classid(TfrmCustomer), &frmCustomer);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
