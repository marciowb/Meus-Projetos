//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USERES("dxPSdxOCLnkC11.res");
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
