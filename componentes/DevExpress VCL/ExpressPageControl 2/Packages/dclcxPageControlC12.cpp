//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPageControlC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEUNIT("cxPCReg.pas");
USERES("cxPCReg.dcr");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
