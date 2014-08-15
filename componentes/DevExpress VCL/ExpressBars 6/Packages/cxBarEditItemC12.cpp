//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxBarEditItemC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxcomnC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxBarC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
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
