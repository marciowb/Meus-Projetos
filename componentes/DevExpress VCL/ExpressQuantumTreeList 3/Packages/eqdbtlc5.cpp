//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("EQDBTLC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("EQTLC5.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("ECQDBCC5.bpi");
USEUNIT("dxDBTL.pas");
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
