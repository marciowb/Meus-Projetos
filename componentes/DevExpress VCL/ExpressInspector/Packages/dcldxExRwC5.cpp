//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxExRwC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dcldxInsC5.bpi");
USEPACKAGE("EQGridC5.bpi");
USEPACKAGE("dxExRwC5.bpi");
USEUNIT("dxRExReg.pas");
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
