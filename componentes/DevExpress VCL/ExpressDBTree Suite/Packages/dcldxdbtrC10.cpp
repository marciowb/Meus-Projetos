//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxdbtrC10.res");
USERES("dxdbtreg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("dxGDIPlusC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxdbtrC10.bpi");
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
