//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USERES("dxPScxVGridLnkC12.res");
USEPACKAGE("dxPSLnksC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxVerticalGridC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("dxPScxCommonC12.bpi");
USEUNIT("dxPScxVGridLnk.pas");
USEUNIT("dxPScxVGridLnkPredefinedStyleSheets.pas");
USEUNIT("dxPScxVGridLnkReg.pas");
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
