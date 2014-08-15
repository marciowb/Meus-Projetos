//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxTabbedMDIC15.res");
USERES("dxTabbedMDIReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxBarC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("dcldxBarC15.bpi");
USEPACKAGE("dxTabbedMDIC15.bpi");
USEUNIT("dxTabbedMDIReg.pas");
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
