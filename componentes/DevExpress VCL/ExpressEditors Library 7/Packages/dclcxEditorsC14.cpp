//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxEditorsC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dcldxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
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
