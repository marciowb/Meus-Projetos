//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxGrEdC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxComnC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEPACKAGE("ECQDBCC6.bpi");
USEPACKAGE("EQGridC6.bpi");
USEUNIT("dxExGrEd.pas");
USEUNIT("dxGrClEx.pas");
USEUNIT("dxTLClEx.pas");
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
