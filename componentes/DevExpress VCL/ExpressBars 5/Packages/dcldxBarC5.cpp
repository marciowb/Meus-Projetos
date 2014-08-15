//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLX50.bpi");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEUNIT("dxBarReg.pas");
USERES("dxBarReg.dcr");
USEUNIT("dxBarConverter.pas");
USERES("dxBarConverter.dcr");
USEUNIT("dxStatusBarReg.pas");
USEUNIT("dxStatusIndicatorEditor.pas");
USEPACKAGE("dxcomnC5.bpi");
USEPACKAGE("dxBarC5.bpi");
USEPACKAGE("dclcxLibraryVCLC5.bpi");
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
