//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxEditorsC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dcldxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
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
