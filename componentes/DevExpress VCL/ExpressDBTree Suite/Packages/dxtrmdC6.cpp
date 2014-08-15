//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxtrmdC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxdbtrC6.bpi");
USEPACKAGE("dxmdsC6.bpi");
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
