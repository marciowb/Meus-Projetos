//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcc5.bpi");
USEPACKAGE("dxdborc5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxPSdxOCLnkc5.bpi");
USERES("dxPSdxDBOCLnkc5.res");
USEUNIT("dxPSdxDBOCLnk.pas");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
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
