//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxExtEditorsC12.res");
USERES("cxExtEditReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dcldxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("dclcxEditorsC12.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
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
