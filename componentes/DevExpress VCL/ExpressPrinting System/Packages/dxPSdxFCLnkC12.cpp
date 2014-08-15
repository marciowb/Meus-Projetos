//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxflowchartC12.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("dxPSLnksC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USERES("dxPSdxFCLnkC12.res");
USEUNIT("dxPSdxFCLnk.pas");
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
