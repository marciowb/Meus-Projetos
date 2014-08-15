//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxOrgCC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxOrgCC14.bpi");
USEUNIT("dxotcreg.pas");
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
