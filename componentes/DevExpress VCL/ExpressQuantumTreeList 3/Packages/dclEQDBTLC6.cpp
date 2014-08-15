//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclEQDBTLC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEPACKAGE("ECQDBCC6.bpi");
USEPACKAGE("dclEQTLC6.bpi");
USEPACKAGE("dclECQDBCC6.bpi");
USEPACKAGE("EQDBTLC6.bpi");
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
