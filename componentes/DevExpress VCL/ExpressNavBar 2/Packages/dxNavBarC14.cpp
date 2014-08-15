//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxNavBarC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vclimg.bpi");
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
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
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
