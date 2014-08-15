//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxComnC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("cxDataC15.bpi");
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
