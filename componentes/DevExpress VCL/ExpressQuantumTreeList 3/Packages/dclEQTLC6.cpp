//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclEQTLC6.res");
USERES("dxTLReg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("EQTLC6.bpi");
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
