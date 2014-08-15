//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxdbtrC11.bpi");
USEPACKAGE("dxPSLnksC11.bpi");
USERES("dxPSdxDBTVLnkC11.res");
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
