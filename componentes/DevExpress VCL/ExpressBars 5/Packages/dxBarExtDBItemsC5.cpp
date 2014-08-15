//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarExtDBItemsC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxBarC5.bpi");
USEPACKAGE("dxcomnC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEUNIT("dxBarExtDBItems.pas");
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
