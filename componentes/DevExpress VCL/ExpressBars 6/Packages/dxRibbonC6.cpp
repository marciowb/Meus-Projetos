//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxRibbonC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("dxGDIPlusC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dxBarC6.bpi");
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

