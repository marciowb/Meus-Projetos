//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxInsC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxComnC5.bpi");
USEPACKAGE("dxDBEdC5.bpi");
USEPACKAGE("dxEdtrC5.bpi");
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
