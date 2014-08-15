//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxEditorsC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dcldxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
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
