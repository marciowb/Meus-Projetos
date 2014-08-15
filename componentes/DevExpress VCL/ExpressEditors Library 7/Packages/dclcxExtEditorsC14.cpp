//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxExtEditorsC14.res");
USERES("cxExtEditReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dcldxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("dclcxEditorsC14.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
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
