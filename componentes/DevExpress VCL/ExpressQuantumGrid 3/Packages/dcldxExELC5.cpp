//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxExELC5.res");
USERES("dxExLReg.dcr");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("EQGridC5.bpi");
USEPACKAGE("dxExELC5.bpi");
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
