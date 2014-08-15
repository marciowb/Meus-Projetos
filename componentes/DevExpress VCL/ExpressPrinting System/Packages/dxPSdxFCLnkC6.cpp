//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxflowchartC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxPSLnksC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USERES("dxPSdxFCLnkC6.res");
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
