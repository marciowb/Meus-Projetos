//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxNavBarC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
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
USEUNIT("dxNavBarOffice12Views.pas");
USEUNIT("dxNavBarVistaViews.pas");
USEUNIT("dxNavBarCustomPainters.pas");
USEUNIT("dxNavBarSkinBasedViews.pas");
USEUNIT("dxNavBarGroupItems.pas");
USEUNIT("dxNavBarAccessibility.pas");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
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
