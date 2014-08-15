//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxDBOrC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("vclDB.bpi");
USEPACKAGE("dxOrgcC11.bpi");
USEUNIT("dxdborgc.pas");
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
