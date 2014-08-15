//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxExRwC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dcldxInsC6.bpi");
USEPACKAGE("EQGridC6.bpi");
USEPACKAGE("dxExRwC6.bpi");
USEUNIT("dxRExReg.pas");
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
