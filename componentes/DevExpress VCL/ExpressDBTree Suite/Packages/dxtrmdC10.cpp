//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxtrmdC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxdbtrC10.bpi");
USEPACKAGE("dxmdsC10.bpi");
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
