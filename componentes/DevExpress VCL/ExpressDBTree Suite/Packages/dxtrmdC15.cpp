//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxtrmdC15.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxdbtrC15.bpi");
USEPACKAGE("dxmdsC15.bpi");
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
