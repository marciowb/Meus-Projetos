//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPageControlC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
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
