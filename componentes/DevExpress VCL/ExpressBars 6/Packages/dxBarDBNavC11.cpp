//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarDBNavC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEUNIT("dxBarDBNavStrs.pas");
USEUNIT("dxBarDBNav.pas");
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
