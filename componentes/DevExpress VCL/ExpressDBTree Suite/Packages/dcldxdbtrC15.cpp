//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxdbtrC15.res");
USERES("dxdbtreg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxcomnC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxdbtrC15.bpi");
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
