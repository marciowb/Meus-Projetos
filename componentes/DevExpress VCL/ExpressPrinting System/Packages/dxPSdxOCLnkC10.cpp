//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC10.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USERES("dxPSdxOCLnkC10.res");
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
