//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxDBOrC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("dxGDIPlusC10.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("vclDB.bpi");
USEPACKAGE("dxOrgcC10.bpi");
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
