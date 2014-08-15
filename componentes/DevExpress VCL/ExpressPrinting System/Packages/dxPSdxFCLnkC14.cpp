//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxflowchartC14.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("dxPSLnksC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USERES("dxPSdxFCLnkC14.res");
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
