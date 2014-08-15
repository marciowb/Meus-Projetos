//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxGridC14.bpi");
USEPACKAGE("dclcxGridC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dclcxEditorsC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEFORMNS("cxLayoutViewEditor.pas", Cxlayoutvieweditor, cxLayoutViewEditor);
USEPACKAGE("cxGridLayoutViewC14.bpi");
USEUNIT("cxGridLayoutViewReg.pas");
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
