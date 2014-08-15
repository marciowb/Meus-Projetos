//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxExtEditorsC11.res");
USERES("cxExtEditReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dcldxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExtEditorsC11.bpi");
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
