//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxdborC12.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("dxPSdxOCLnkC12.bpi");
USERES("dxPSdxDBOCLnkC12.res");
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
