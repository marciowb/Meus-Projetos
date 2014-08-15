//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("cxDataC14.bpi");
USEUNIT("dxLayoutLookAndFeels.pas");
USEUNIT("dxLayoutControl.pas");
USEUNIT("dxLayoutContainer.pas");
USEUNIT("dxLayoutControlAdapters.pas");
USEUNIT("dxLayoutCustomizeForm.pas");
USEUNIT("dxLayoutEditForm.pas");
USEUNIT("dxLayoutDragAndDrop.pas");
USEUNIT("dxLayoutSelection.pas");
USEUNIT("dxLayoutCommon.pas");
USEUNIT("dxLayoutcxEditAdapters.pas");
USEFORMNS("dxLayoutCustomizeForm.pas", dxLayoutCustomizeForm, dxLayoutControlCustomizeForm);
USEFORMNS("dxLayoutEditForm.pas", dxLayoutEditForm, LayoutEditForm);
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
