//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarDBNavC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxBarC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
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
