//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USERES("dxPSdxLCLnkC11.res");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxLayoutControlC11.bpi");
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
