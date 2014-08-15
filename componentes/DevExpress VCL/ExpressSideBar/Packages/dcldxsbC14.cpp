//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxsbC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxcomnC14.bpi");
USEPACKAGE("dxsbC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
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
