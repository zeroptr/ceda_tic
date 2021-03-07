//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("CSDemo.res");
USEFORMNS("Frmviews.pas", Frmviews, FrmViewDemo);
USEFORMNS("Frmexesp.pas", Frmexesp, FrmExecProc);
USEFORMNS("Frmmain.pas", Frmmain, FrmLauncher);
USEFORMNS("Frmqrysp.pas", Frmqrysp, FrmQueryProc);
USEFORMNS("Frmtrans.pas", Frmtrans, FrmTransDemo);
USEFORMNS("Frmtrigg.pas", Frmtrigg, FrmTriggerDemo);
USEFORMNS("DmCSDemo.pas", Dmcsdemo, DmEmployee); /* TDataModule: DesignClass */
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->Title = "CS Demos Sample Application";
        Application->CreateForm(__classid(TDmEmployee), &DmEmployee);
        Application->CreateForm(__classid(TFrmLauncher), &FrmLauncher);
        Application->CreateForm(__classid(TFrmViewDemo), &FrmViewDemo);
        Application->CreateForm(__classid(TFrmExecProc), &FrmExecProc);
        Application->CreateForm(__classid(TFrmQueryProc), &FrmQueryProc);
        Application->CreateForm(__classid(TFrmTransDemo), &FrmTransDemo);
        Application->CreateForm(__classid(TFrmTriggerDemo), &FrmTriggerDemo);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
