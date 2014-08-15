//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USERES("dxPSdxLCLnkC14.res");
USEPACKAGE("dxPSLnksC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxLayoutControlC14.bpi");
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
