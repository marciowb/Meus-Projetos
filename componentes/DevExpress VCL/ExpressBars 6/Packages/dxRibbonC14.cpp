//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxRibbonC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxcomnC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxBarC14.bpi");
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
