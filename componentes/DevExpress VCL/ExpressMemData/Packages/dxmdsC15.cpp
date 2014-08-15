//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxmdsC15.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEUNIT("dxmdaset.pas");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
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
