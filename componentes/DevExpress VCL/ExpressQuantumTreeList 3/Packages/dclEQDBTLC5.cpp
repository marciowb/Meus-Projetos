//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclEQDBTLC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("dclstd50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("EQTLC5.bpi");
USEPACKAGE("ECQDBCC5.bpi");
USEPACKAGE("dclEQTLC5.bpi");
USEPACKAGE("dclECQDBCC5.bpi");
USEPACKAGE("EQDBTLC5.bpi");
USEUNIT("dxDTLReg.pas");
USEUNIT("dxDBTLEd.pas");
USEUNIT("dxTLFlds.pas");
USERES("dxDTLReg.dcr");
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
