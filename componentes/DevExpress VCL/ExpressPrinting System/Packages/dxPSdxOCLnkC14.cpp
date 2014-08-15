//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USERES("dxPSdxOCLnkC14.res");
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
