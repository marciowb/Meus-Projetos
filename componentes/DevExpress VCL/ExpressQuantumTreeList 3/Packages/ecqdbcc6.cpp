//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("ECQDBCC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxComnC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEUNIT("dxDBTLCl.pas");
USEUNIT("dxDBCtrl.pas");
USEUNIT("dxGrFCmn.pas");  
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
