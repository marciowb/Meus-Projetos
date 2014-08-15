//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxflowchartC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USERES("dxPSdxFCLnkC11.res");
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
