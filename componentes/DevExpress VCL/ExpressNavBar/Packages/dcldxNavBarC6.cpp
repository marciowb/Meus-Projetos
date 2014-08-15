//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxNavBarC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxNavBarC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEUNIT("dxNavBarReg.pas");
USERES("dxNavBarReg.dcr");
USEUNIT("dxfmNavBarDsgnEditor.pas");
USEUNIT("dxNavBarDsgnConsts.pas");
USEUNIT("dxNavBarDsgnUtils.pas");
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
