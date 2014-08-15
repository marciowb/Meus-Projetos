//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarC10.res");
USERES("dxBarReg.dcr");
USERES("dxBarConverter.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEPACKAGE("dxBarC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEUNIT("dxBarReg.pas");
USEUNIT("dxBarConverter.pas");
USEUNIT("dxStatusBarReg.pas");
USEUNIT("dxStatusIndicatorEditor.pas");
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
