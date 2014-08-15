//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxmdsC12.res");
USERES("dxmdsreg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dcldxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxmdsC12.bpi");
USEUNIT("dxmdatps.pas");
USEUNIT("dxmdsreg.pas");
USEUNIT("dxmdseda.pas");
USEUNIT("dxmdsedt.pas");
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
