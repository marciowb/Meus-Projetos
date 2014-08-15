//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarDBNavC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxBarC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
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
