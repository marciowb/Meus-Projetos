//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxNavBarC15.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxNavBarC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dclLibraryC15.bpi");
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
