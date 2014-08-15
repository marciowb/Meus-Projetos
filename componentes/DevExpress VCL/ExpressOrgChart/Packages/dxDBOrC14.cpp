//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxDBOrC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("vclDB.bpi");
USEPACKAGE("dxOrgcC14.bpi");
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
