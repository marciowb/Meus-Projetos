//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLDB50.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxdbtrC5.bpi");
USEPACKAGE("dxPSLnksC5.bpi");
USERES("dxPSdxDBTVLnkc5.res");
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
