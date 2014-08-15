//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxNavBarC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxNavBarC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dclLibraryC14.bpi");
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
