//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxOrgCC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEUNIT("dxorgced.pas");
USEUNIT("dxorgchr.pas");
USEUNIT("dxorgchrstrs.pas");
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
