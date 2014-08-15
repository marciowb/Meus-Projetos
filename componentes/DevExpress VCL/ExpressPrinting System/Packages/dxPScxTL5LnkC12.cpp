//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USERES("dxPScxTL5LnkC12.res");
USEPACKAGE("dxPSLnksC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxTreeListC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxCommonC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
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
