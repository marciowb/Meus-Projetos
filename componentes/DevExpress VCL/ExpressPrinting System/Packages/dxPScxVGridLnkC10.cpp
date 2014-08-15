//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USERES("dxPScxVGridLnkC10.res");
USEPACKAGE("dxPSLnksC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxVerticalGridC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("dxPScxCommonC10.bpi");
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
