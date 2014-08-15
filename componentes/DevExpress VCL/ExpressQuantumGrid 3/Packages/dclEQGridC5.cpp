//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclEQGridC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dclstd50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("EQTLC5.bpi");
USEPACKAGE("ECQDBCC5.bpi");
USEPACKAGE("dclEQTLC5.bpi");
USEPACKAGE("dclECQDBCC5.bpi");
USEPACKAGE("ECGridC5.bpi");
USEUNIT("dxGrReg.pas");
USEUNIT("dxColReg.pas");
USEUNIT("dxGLayEd.pas");
USEUNIT("dxGrWzrd.pas");
USEUNIT("dxWizard.pas");
USEUNIT("dxWzSmGr.pas");
USEUNIT("dxGrEdtr.pas");
USERES("dxGrReg.dcr");
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
