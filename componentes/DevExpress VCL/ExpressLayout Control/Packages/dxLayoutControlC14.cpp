//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEUNIT("dxLayoutCommon.pas");
USEUNIT("dxLayoutControl.pas");
USEUNIT("dxLayoutControlAdapters.pas");
USEFORMNS("dxLayoutCustomizeForm.pas", dxLayoutCustomizeForm, LayoutCustomizeForm);
USEFORMNS("dxLayoutEditForm.pas", dxLayoutEditForm, LayoutEditForm);
USEUNIT("dxLayoutLookAndFeels.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
