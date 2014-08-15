//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxGridC15.bpi");
USEPACKAGE("dclcxGridC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dclcxEditorsC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxGridLayoutViewC15.bpi");
USEFORMNS("cxLayoutViewEditor.pas", Cxlayoutvieweditor, cxLayoutViewEditor);
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
