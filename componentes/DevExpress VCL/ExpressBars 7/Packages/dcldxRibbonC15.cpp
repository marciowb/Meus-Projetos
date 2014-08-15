//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxRibbonC15.res");
USERES("dxRibbonReg.dcr");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxComnC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxBarC15.bpi");
USEPACKAGE("dxRibbonC15.bpi");
USEPACKAGE("dcldxCoreC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("dcldxBarC15.bpi");
USEUNIT("dxRibbonBackstageViewReg.pas");
USEUNIT("dxRibbonGalleryFilterEd.pas");
USEUNIT("dxRibbonGalleryReg.pas");
USEUNIT("dxRibbonGalleryDesigner.pas");
USEUNIT("dxRibbonReg.pas");
USEUNIT("dxSkinChooserGalleryReg.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
