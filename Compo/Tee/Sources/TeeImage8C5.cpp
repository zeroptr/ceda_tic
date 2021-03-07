//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("TeeImage8C5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("GIFImage.pas");
USEFORMNS("TeeGIF.pas", Teegif, TeeGIFOptions);
USEFORMNS("TeeJPEG.pas", Teejpeg, TeeJPEGOptions);
USEFORMNS("TeePng.pas", Teepng, TeePNGOptions);
USEPACKAGE("vcljpg50.bpi");
USEPACKAGE("TeeUI8C5.bpi");
USEPACKAGE("Tee8C5.bpi");
USEUNIT("pcx.pas");
USEUNIT("TeeVMLCanvas.pas");
USEUNIT("TeePDFCanvas.pas");
USEUNIT("TeeSVGCanvas.pas");
USEUNIT("TeePSCanvas.pas");
USEFORMNS("teepcx.pas", Teepcx, PCXOptions);
USEFORMNS("TeeXAMLCanvas.pas", Teexamlcanvas, XAMLOptions);
USEFORMNS("TeeFlexCanvas.pas", Teeflexcanvas, FlexOptions);
USEPACKAGE("Vclx50.bpi");
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
