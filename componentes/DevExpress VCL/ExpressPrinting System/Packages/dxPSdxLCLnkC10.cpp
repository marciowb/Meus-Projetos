//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USERES("dxPSdxLCLnkC10.res");
USEPACKAGE("dxPSLnksC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxLayoutControlC10.bpi");
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
