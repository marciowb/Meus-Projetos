//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxNavBarC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxNavBarC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dclLibraryC10.bpi");
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
