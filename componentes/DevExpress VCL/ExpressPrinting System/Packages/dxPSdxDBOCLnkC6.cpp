//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxdborC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxPSdxOCLnkC6.bpi");
USERES("dxPSdxDBOCLnkC6.res");
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
