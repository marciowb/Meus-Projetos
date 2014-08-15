//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxOrgCC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("dxGDIPlusC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxCoreC10.bpi");
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
