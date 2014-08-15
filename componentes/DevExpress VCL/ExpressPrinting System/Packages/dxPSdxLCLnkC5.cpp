//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl50.bpi");
USEPACKAGE("dxPSCoreC5.bpi");
USERES("dxPSdxLCLnkC5.res");
USEPACKAGE("dxPSLnksC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEPACKAGE("cxDataC5.bpi");
USEPACKAGE("cxEditorsC5.bpi");
USEPACKAGE("dxLayoutControlC5.bpi");
USEUNIT("dxPSdxLCLnk.pas");
USEUNIT("dxPSdxLCLnkReg.pas"); 
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
