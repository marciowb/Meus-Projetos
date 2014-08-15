//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("ECQDBCC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxComnC5.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxDBEdC5.bpi");
USEPACKAGE("EQTLC5.bpi");
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
