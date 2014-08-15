//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxtrmdC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxdbtrC11.bpi");
USEPACKAGE("dxmdsC11.bpi");
USEUNIT("dxtrprds.pas");
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
