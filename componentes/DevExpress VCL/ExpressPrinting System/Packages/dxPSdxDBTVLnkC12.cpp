//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("dxdbtrC12.bpi");
USEPACKAGE("dxPSLnksC12.bpi");
USERES("dxPSdxDBTVLnkC12.res");
USEUNIT("dxPSdxDBTVLnkReg.pas");
USEUNIT("dxPSdxDBTVLnk.pas");
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
