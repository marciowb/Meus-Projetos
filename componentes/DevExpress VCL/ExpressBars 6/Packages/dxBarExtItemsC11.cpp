//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarExtItemsC11.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEUNIT("dxBarExtItems.pas");
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
