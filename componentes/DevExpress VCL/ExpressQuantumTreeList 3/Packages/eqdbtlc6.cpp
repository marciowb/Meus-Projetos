//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("EQDBTLC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("ECQDBCC6.bpi");
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
