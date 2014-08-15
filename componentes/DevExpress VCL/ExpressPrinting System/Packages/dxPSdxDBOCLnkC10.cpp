//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC10.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxdborC10.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("dxPSdxOCLnkC10.bpi");
USERES("dxPSdxDBOCLnkC10.res");
USEUNIT("dxPSdxDBOCLnk.pas");
USEPACKAGE("vcl.bpi");
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
