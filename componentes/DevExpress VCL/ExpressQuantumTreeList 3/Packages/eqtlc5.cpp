//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("EQTLC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEUNIT("dxTL.pas");
USEUNIT("dxTLClms.pas");
USEUNIT("dxTLStr.pas");
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
