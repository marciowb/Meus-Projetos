//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarC15.res");
USERES("dxBarReg.dcr");
USERES("dxBarConverter.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxcomnC15.bpi");
USEPACKAGE("dxBarC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
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
