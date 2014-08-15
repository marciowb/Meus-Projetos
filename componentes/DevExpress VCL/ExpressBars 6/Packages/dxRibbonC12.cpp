//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxRibbonC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxcomnC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxBarC12.bpi");
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
