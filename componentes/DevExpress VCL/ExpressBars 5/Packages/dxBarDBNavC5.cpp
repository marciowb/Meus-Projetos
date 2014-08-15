//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarDBNavC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxBarC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
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
