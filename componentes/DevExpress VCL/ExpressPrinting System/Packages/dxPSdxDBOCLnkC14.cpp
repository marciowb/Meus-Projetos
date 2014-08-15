//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxdborC14.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("dxPSdxOCLnkC14.bpi");
USERES("dxPSdxDBOCLnkC14.res");
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
