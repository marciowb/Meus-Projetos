//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxflowchartC10.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("dxPSLnksC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USERES("dxPSdxFCLnkC10.res");
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
