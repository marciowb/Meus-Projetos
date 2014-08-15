//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxExELC6.res");
USERES("dxExLReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("EQGridC6.bpi");
USEPACKAGE("dxExELC6.bpi");
USEUNIT("dxExLReg.pas");
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
