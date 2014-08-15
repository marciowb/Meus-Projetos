//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxExtEditorsC15.res");
USERES("cxExtEditReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dcldxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("dclcxEditorsC15.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEUNIT("cxExtEditReg.pas");
USEUNIT("cxShellEditorsReg.pas");
USEFORMNS("cxHintEditor.pas", Cxhinteditor, cxHintStyleEditor);
USEFORMNS("cxSplitterEditor.pas", Cxsplittereditor, cxSplitEditor);
USEFORMNS("cxCheckGroupStatesEditor.pas", Cxcheckgroupstateseditor, cxCheckGroupStatesEditorDlg);
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
