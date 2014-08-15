//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USERES("dxPScxTL5LnkC14.res");
USEPACKAGE("dxPSLnksC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxTreeListC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxCommonC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEUNIT("dxPScxTL5Lnk.pas");
USEUNIT("dxPScxTL5LnkPredefinedStyleSheets.pas");
USEUNIT("dxPScxTL5LnkReg.pas");
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
