//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxInsC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dclstd.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxInsC6.bpi");
USERES("dxInsReg.dcr");
USEUNIT("dxInsReg.pas");
USEUNIT("dxRowReg.pas");
USEUNIT("dxDBInEd.pas");
USEUNIT("dxImRwEd.pas");
USEUNIT("dxInRowA.pas");
USEUNIT("dxInspEd.pas");
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
