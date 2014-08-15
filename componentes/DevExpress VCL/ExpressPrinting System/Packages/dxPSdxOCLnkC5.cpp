//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxorgcc5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USERES("dxPSdxOCLnkc5.res");
USEUNIT("dxPSdxOCLnk.pas");
USEUNIT("dxPSdxOCLnkReg.pas");
USEPACKAGE("vcl50.bpi");
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
