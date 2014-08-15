//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclEQGridC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEPACKAGE("ECQDBCC6.bpi");
USEPACKAGE("dclEQTLC6.bpi");
USEPACKAGE("dclECQDBCC6.bpi");
USEPACKAGE("ECGridC6.bpi");
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
