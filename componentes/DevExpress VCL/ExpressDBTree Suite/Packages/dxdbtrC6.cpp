//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxdbtrC6.res");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("dxGDIPlusC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEUNIT("dxdbtree.pas");
USEUNIT("dxlocate.pas");
USEUNIT("dxtree.pas");
USEUNIT("dxdbtrel.pas");
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
