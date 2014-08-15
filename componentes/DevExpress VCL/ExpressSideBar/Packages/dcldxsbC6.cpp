//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxsbC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxsbC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
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
