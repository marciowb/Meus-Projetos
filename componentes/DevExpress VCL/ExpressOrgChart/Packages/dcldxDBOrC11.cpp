//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxDBOrCC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("dxDBOrC11.bpi");
USEPACKAGE("dcldxOrgCC11.bpi");
USEUNIT("dxDBCReg.pas");
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
