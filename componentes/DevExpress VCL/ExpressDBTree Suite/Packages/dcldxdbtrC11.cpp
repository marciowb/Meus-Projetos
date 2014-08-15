//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxdbtrC11.res");
USERES("dxdbtreg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxdbtrC11.bpi");
USEUNIT("dxdbtreg.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
