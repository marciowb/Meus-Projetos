//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxRibbonC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxcomnC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxBarC15.bpi");
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
