//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxOrgCC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxGDIPlusC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
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
