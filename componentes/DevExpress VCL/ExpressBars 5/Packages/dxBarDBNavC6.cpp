//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarDBNavC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxBarC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
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
