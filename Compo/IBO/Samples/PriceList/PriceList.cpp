//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("PriceList.res");
USEFORMNS("FRM_PriceList.pas", Frm_pricelist, frmPriceList);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->CreateForm(__classid(TfrmPriceList), &frmPriceList);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}
//---------------------------------------------------------------------------
