//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxLayoutControlC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxComnC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
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
