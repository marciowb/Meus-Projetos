//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USERES("dxPScxVGridLnkC14.res");
USEPACKAGE("dxPSLnksC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxVerticalGridC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("dxPScxCommonC14.bpi");
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
