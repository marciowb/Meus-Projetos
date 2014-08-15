//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEUNIT("dxBarReg.pas");
USERES("dxBarReg.dcr");
USEUNIT("dxBarConverter.pas");
USEUNIT("dxStatusBarReg.pas");
USEUNIT("dxStatusIndicatorEditor.pas");
USERES("dxBarConverter.dcr");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxBarC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
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
