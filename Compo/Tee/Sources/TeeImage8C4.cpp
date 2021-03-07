//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeeImage8C4.res");
USEPACKAGE("vcl40.bpi");
USEFORMNS("TeePng.pas", Teepng, TeePNGOptions);
USEFORMNS("TeeGIF.pas", Teegif, TeeGIFOptions);
USEFORMNS("TeeJPEG.pas", Teejpeg, TeeJPEGOptions);
USEUNIT("GIFImage.pas");
USEPACKAGE("vcljpg40.bpi");
USEPACKAGE("TeeUI8C4.bpi");
USEPACKAGE("TeePro8C4.bpi");
USEPACKAGE("Tee8C4.bpi");
USEUNIT("TeePDFCanvas.pas");
USEUNIT("TeeVMLCanvas.pas");
USEUNIT("TeeSVGCanvas.pas");
USEUNIT("pcx.pas");
USEFORMNS("teepcx.pas", Teepcx, PCXOptions);
USEFORMNS("TeeXAMLCanvas.pas", Teexamlcanvas, XAMLOptions);
USEFORMNS("TeeFlexCanvas.pas", Teeflexcanvas, FlexOptions);
USEPACKAGE("Vclx40.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
