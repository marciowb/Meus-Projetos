//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxsbC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxsbC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
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
