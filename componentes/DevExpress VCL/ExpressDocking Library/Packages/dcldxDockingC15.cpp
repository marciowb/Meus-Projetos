//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxDockingC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxDockingC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dclLibraryC15.bpi");
USEUNIT("dxDockReg.pas");
USERES("dxDockReg.dcr");
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
