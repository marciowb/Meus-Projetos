//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxExELC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxELibC6.bpi");
USEPACKAGE("EQGridC6.bpi");
USEPACKAGE("dxGrEdC6.bpi");
USEUNIT("dxExELib.pas");
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
