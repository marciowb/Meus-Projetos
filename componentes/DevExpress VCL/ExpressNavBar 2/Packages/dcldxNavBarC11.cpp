//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxNavBarC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxNavBarC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dclLibraryC11.bpi");
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
