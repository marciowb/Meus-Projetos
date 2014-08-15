//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxdbtrC6.bpi");
USEPACKAGE("dxPSLnksC6.bpi");
USERES("dxPSdxDBTVLnkC6.res");
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
