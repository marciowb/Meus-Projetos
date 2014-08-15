//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxdborC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxPSdxOCLnkC11.bpi");
USERES("dxPSdxDBOCLnkC11.res");
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
