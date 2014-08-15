//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxRibbonC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("dxGDIPlusC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxBarC10.bpi");
USEUNIT("dxRibbon.pas");
USEUNIT("dxRibbonForm.pas");
USEUNIT("dxRibbonFormCaptionHelper.pas");
USEUNIT("dxRibbonGallery.pas");
USEUNIT("dxRibbonGroupLayoutCalculator.pas");
USEUNIT("dxRibbonSkins.pas");
USEUNIT("dxRibbonStatusBar.pas");
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