//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("dxdbtrC10.bpi");
USEPACKAGE("dxPSLnksC10.bpi");
USERES("dxPSdxDBTVLnkC10.res");
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
