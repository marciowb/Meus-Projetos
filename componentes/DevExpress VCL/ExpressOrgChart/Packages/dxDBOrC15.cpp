//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxDBOrC15.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("vclDB.bpi");
USEPACKAGE("dxOrgcC15.bpi");
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
