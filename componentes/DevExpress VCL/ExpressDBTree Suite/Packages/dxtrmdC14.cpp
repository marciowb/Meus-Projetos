//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxtrmdC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxdbtrC14.bpi");
USEPACKAGE("dxmdsC14.bpi");
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
