//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl50.bpi");
USEPACKAGE("dxPSCoreC5.bpi");
USERES("dxPScxTLLnkC5.res");
USEPACKAGE("dxPSLnksC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEPACKAGE("cxDataC5.bpi");
USEPACKAGE("cxEditorsC5.bpi");
USEPACKAGE("cxTreeListC5.bpi");
USEPACKAGE("dclcxLibraryVCLC5.bpi");
USEPACKAGE("dxPScxCommonC5.bpi");
USEPACKAGE("dxThemeC5.bpi");
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
