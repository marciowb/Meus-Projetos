//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxExELC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxELibC5.bpi");
USEPACKAGE("EQGridC5.bpi");
USEPACKAGE("dxGrEdC5.bpi");
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
