//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USERES("dxPScxVGridLnkC11.res");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxVerticalGridC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");
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
