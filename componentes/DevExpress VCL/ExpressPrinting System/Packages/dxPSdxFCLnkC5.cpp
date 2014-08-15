//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxflowchartc5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxPSLnksc5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USERES("dxPSdxFCLnkc5.res");
USEUNIT("dxPSdxFCLnk.pas");
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
