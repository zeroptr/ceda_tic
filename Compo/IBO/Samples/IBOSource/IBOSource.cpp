//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEFORMNS("..\..\IBF_Base.pas", Ibf_base, frmBase);
USEFORMNS("FRM_Source.pas", Frm_source, frmSource);
#include "frm_source.hpp"
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
	try
	{
		Application->Initialize();
		Application->CreateForm(__classid(TfrmSource), &frmSource);
		frmSource->BaseKey = "Software\\Apps\\IBO\\Source";
		Application->Run();
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	return 0;
}
//---------------------------------------------------------------------------
