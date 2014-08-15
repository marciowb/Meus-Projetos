//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxGrEdC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("EQGridC6.bpi");
USEPACKAGE("dclEQTLC6.bpi");
USEPACKAGE("dclECQDBCC6.bpi");
USEPACKAGE("dclEQDBTLC6.bpi");
USEPACKAGE("dclEQGridC6.bpi");
USEPACKAGE("dxGrEdC6.bpi");
USEUNIT("dxCExReg.pas");
USEUNIT("dxLExReg.pas");
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
