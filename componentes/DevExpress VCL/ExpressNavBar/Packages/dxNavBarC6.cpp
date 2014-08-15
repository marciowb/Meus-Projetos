//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxNavBarC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcljpg.bpi");
USEUNIT("dxNavBarXPViews.pas");
USEUNIT("dxNavBar.pas");
USEUNIT("dxNavBarBase.pas");
USEUNIT("dxNavBarBaseViews.pas");
USEUNIT("dxNavBarCollns.pas");
USEUNIT("dxNavBarConsts.pas");
USEUNIT("dxNavBarExplorerViews.pas");
USEUNIT("dxNavBarGraphics.pas");
USEUNIT("dxNavBarOfficeViews.pas");
USEUNIT("dxNavBarStyles.pas");
USEUNIT("dxNavBarViewsFact.pas");
USEUNIT("dxNavBarVSToolBoxViews.pas");
USEUNIT("dxNavBarOffice11Views.pas");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("dxGDIPlusC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
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
