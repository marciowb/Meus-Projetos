//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxdbtrC6.res");
USERES("dxdbtreg.dcr");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("dxGDIPlusC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dxdbtrC6.bpi");
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
