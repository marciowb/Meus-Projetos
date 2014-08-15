//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxMasterViewC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEUNIT("dxMasterView.pas");
USEUNIT("dxMasterViewColumns.pas");
USEUNIT("dxMasterViewStrs.pas");
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
