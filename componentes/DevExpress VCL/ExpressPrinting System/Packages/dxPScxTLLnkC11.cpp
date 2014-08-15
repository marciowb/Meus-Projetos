//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USERES("dxPScxTLLnkC11.res");
USEPACKAGE("dxPSLnksC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxTreeListC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxCommonC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEUNIT("dxPScxTLLnk.pas");
USEUNIT("dxPScxTLLnkPredefinedStyleSheets.pas");
USEUNIT("dxPScxTLLnkReg.pas");
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
