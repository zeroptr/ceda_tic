//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxExtEditorsVCLC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("vcljpg.bpi");
USEPACKAGE("Vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEUNIT("cxCheckComboBox.pas");
USEUNIT("cxCheckListBox.pas");
USEUNIT("cxColorComboBox.pas");
USEUNIT("cxDBCheckComboBox.pas");
USEUNIT("cxDBCheckListBox.pas");
USEUNIT("cxDBColorComboBox.pas");
USEUNIT("cxDBFontNameComboBox.pas");
USEUNIT("cxDBLabel.pas");
USEUNIT("cxDBProgressBar.pas");
USEUNIT("cxDBShellComboBox.pas");
USEUNIT("cxDBTrackBar.pas");
USEUNIT("cxExtEditConsts.pas");
USEUNIT("cxExtEditUtils.pas");
USEUNIT("cxFontNameComboBox.pas");
USEUNIT("cxHeader.pas");
USEUNIT("cxHint.pas");
USEUNIT("cxLabel.pas");
USEUNIT("cxListView.pas");
USEUNIT("cxMCListBox.pas");
USEUNIT("cxProgressBar.pas");
USEUNIT("cxShellComboBox.pas");
USEUNIT("cxShellCommon.pas");
USEUNIT("cxShellControls.pas");
USEUNIT("cxShellListView.pas");
USEUNIT("cxShellTreeView.pas");
USEUNIT("cxSpinButton.pas");
USEUNIT("cxSplitter.pas");
USEUNIT("cxTrackBar.pas");
USEUNIT("cxTreeView.pas");
USEUNIT("cxShellEditRepositoryItems.pas");
USEUNIT("cxExtEditRepositoryItems.pas");
USEUNIT("cxShellDlgs.pas");
USEUNIT("cxRichEdit.pas");
USEUNIT("cxDBRichEdit.pas");
USEUNIT("cxCheckGroup.pas");
USEUNIT("cxDBCheckGroup.pas");
USEFORMNS("cxShellBrowser.pas", Cxshellbrowser, cxShellBrowserDlg);
USEUNIT("cxShellBrowserDialog.pas");

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
