//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxRibbonC14.res");
USERES("dxRibbonReg.dcr");
USEPACKAGE("designide.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxBarC14.bpi");
USEPACKAGE("dxRibbonC14.bpi");
USEPACKAGE("dcldxCoreC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("dcldxBarC14.bpi");
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
