//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxBarEditItemC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxcomnC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxBarC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
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
