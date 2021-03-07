//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("TeeTree2C4Tee8.res");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("TeeUI8C4.bpi");
USEPACKAGE("Tee8C4.bpi");
USEUNIT("TreeUML.pas");
USEUNIT("TeeDBTre.pas");
USEUNIT("TeeOfficeConstants.pas");
USEUNIT("TeeRecentFiles.pas");
USEUNIT("TeeTree.pas");
USEUNIT("TreeAnimate.pas");
USEFORMNS("TreeAnimateEditor.pas", Treeanimateeditor, TreeAnimateEditor);
USEFORMNS("TreeAnimationGallery.pas", Treeanimationgallery, AnimationGallery);
USEUNIT("TreeChildManagers.pas");
USEFORMNS("TreeCoEd.pas", Treecoed, ConnectionEditor);
USEUNIT("TreeConst.pas");
USEFORMNS("TreeDBEd.pas", Treedbed, FormDBTree);
USEFORMNS("TreeEd.pas", Treeed, TreeEditor);
USEUNIT("TreeElectric.pas");
USEUNIT("TreeExport.pas");
USEUNIT("TreeFlow.pas");
USEUNIT("TreeNavigator.pas");
USEFORMNS("TreeShEd.pas", Treeshed, NodeTreeEditor);
USEFORMNS("TreeTeEd.pas", Treeteed, FormTeeText);
USEUNIT("TreeTransit.pas");
USEPACKAGE("TeeLanguage8C4.bpi");
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
