//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxComnC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("cxDataC12.bpi");
USEUNIT("dxLayoutLookAndFeels.pas");
USEUNIT("dxLayoutControl.pas");
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
