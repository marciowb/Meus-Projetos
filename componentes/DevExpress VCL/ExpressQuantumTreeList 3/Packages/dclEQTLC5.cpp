//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclEQTLC5.res");
USERES("dxTLReg.dcr");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("dclstd50.bpi");
USEPACKAGE("dxcomnC5.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("EQTLC5.bpi");
USEUNIT("dxTLReg.pas");
USEUNIT("dxTLCReg.pas");
USEUNIT("dxTLEdtr.pas");
USEUNIT("dxGrColA.pas");
USEUNIT("dxTLImEd.pas");
USEUNIT("dxTLEdit.pas");
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
