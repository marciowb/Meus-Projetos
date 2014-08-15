//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxDBOrCC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("dxDBOrC12.bpi");
USEPACKAGE("dcldxOrgCC12.bpi");
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
