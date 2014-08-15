//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxInsC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxComnC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEUNIT("dxInspRw.pas");
USEUNIT("dxInspct.pas");
USEUNIT("dxDBInsp.pas");
USEUNIT("dxDBInRw.pas");
USEUNIT("dxInsCus.pas");
USEUNIT("dxInCNew.pas");
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
