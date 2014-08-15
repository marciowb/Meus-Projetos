//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USERES("dxPSdxOCLnkC12.res");
USEUNIT("dxPSdxOCLnk.pas");
USEUNIT("dxPSdxOCLnkReg.pas");
USEPACKAGE("vcl.bpi");
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
