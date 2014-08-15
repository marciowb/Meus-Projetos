//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxEditorsVCLC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dcldxCoreC6.bpi");
USEPACKAGE("dcldb.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEUNIT("cxEditPropEditors.pas");
USEUNIT("cxEditReg.pas");
USERES("cxEditReg.dcr");
USEFORMNS("cxMaskEditTextEditor.pas", Cxmaskedittexteditor, cxMaskEditTextEditorDlg);
USEFORMNS("cxSelectEditRepositoryItem.pas", Cxselecteditrepositoryitem, cxSelectRepositoryItem);
USEUNIT("cxEditRepositoryEditor.pas");
USEUNIT("cxFilterControlReg.pas");
USEUNIT("cxInplaceContainerReg.pas");
USERES("cxFilterControlReg.dcr");
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
