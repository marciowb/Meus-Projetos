//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxOrgCC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxOrgCC15.bpi");
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
