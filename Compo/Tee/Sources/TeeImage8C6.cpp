//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("TeeGIF.pas", Teegif, TeeGIFOptions);
USEFORMNS("TeeJPEG.pas", Teejpeg, TeeJPEGOptions);
USEFORMNS("TeePCX.pas", Teepcx, PCXOptions);
USEFORMNS("TeePNG.pas", Teepng, TeePNGOptions);
USEFORMNS("TeeSVGCanvas.pas", Teesvgcanvas, TSVGOptions);
USEFORMNS("TeeXAMLCanvas.pas", Teexamlcanvas, XAMLOptions);
USEFORMNS("TeeFlexCanvas.pas", Teeflexcanvas, FlexOptions);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
