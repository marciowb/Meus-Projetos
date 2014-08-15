//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarExtItemsC10.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxBarC10.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
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
