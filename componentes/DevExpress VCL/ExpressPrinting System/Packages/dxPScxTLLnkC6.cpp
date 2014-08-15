//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USERES("dxPScxTLLnkC6.res");
USEPACKAGE("dxPSLnksC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxTreeListVCLC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxPScxCommonC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
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
