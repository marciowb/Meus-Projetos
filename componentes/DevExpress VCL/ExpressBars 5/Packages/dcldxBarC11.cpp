//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEUNIT("dxBarReg.pas");
USERES("dxBarReg.dcr");
USEUNIT("dxBarConverter.pas");
USEUNIT("dxStatusBarReg.pas");
USEUNIT("dxStatusIndicatorEditor.pas");
USERES("dxBarConverter.dcr");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
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
