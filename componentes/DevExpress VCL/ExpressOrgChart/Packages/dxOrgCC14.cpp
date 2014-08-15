//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxOrgCC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
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
