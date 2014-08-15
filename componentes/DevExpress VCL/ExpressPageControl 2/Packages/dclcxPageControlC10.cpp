//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPageControlC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxPageControlC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
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
