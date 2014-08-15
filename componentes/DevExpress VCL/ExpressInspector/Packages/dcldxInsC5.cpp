//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxInsC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dclstd50.bpi");
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("dxDBEdC5.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxInsC5.bpi");
USERES("dxInsReg.dcr");
USEUNIT("dxInsReg.pas");
USEUNIT("dxRowReg.pas");
USEUNIT("dxDBInEd.pas");
USEUNIT("dxImRwEd.pas");
USEUNIT("dxInRowA.pas");
USEUNIT("dxInspEd.pas");
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
