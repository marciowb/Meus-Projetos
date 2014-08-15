//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxBarEditItemC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxBarC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxExtEditorsC10.bpi");
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
