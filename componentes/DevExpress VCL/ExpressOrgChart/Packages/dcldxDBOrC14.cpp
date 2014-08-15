//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxDBOrCC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("dxDBOrC14.bpi");
USEPACKAGE("dcldxOrgCC14.bpi");
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
