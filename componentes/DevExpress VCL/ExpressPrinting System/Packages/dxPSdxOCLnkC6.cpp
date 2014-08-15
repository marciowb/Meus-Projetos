//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USERES("dxPSdxOCLnkC6.res");
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
