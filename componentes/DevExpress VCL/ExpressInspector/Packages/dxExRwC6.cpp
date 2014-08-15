//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxExRwC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("dxInsC6.bpi");
USEPACKAGE("dxGrEdC6.bpi");
USEPACKAGE("EQGridC6.bpi");
USEUNIT("dxInRwEx.pas");
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
