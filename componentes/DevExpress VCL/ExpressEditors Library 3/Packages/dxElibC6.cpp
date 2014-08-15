//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxELibC6.res");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxComnC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEUNIT("dxEdLib.pas");
USEUNIT("dxDBELib.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
