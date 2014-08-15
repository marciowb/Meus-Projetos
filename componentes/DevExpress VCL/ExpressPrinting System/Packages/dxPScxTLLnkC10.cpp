//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USERES("dxPScxTLLnkC10.res");
USEPACKAGE("dxPSLnksC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxTreeListC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxCommonC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
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
