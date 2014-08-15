//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxOrgCC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
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
