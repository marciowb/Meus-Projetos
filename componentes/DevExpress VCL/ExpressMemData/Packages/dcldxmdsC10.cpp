//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxmdsC10.res");
USERES("dxmdsreg.dcr");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dcldxCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxmdsC10.bpi");
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
