//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxTabbedMDIC14.res");
USERES("dxTabbedMDIReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxBarC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("dcldxBarC14.bpi");
USEPACKAGE("dxTabbedMDIC14.bpi");
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
