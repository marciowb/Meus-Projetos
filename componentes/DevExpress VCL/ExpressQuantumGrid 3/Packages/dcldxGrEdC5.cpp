//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxGrEdC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("EQGridC5.bpi");
USEPACKAGE("dclEQTLC5.bpi");
USEPACKAGE("dclECQDBCC5.bpi");
USEPACKAGE("dclEQDBTLC5.bpi");
USEPACKAGE("dclEQGridC5.bpi");
USEPACKAGE("dxGrEdC5.bpi");
USEUNIT("dxCExReg.pas");
USEUNIT("dxLExReg.pas");
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
