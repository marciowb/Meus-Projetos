//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxBarEditItemC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dxBarC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxExtEditorsVCLC6.bpi");
USEUNIT("cxBarEditItemValueEditor.pas");
USEUNIT("cxBarEditItem.pas");
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
