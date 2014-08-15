//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxsbC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxcomnC12.bpi");
USEPACKAGE("dxsbC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEUNIT("dxsbreg.pas");
USERES("dxsbreg.dcr");
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
