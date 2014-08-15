//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxExRwC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxDBEdC5.bpi");
USEPACKAGE("dxInsC5.bpi");
USEPACKAGE("dxGrEdC5.bpi");
USEPACKAGE("EQGridC5.bpi");
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
