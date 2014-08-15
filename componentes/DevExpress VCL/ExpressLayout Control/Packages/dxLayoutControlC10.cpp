//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxComnC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
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
