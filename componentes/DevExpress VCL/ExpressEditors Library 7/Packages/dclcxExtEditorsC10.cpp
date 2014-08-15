//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxExtEditorsC10.res");
USERES("cxExtEditReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dcldxCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("dclcxEditorsC10.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxExtEditorsC10.bpi");
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
