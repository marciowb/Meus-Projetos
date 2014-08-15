//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxsbC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxcomnC15.bpi");
USEPACKAGE("dxsbC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
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
