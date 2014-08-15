//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxRibbonC11.res");
USERES("dxRibbonReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("dxRibbonC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dcldxBarC11.bpi");
USEUNIT("dxRibbonGalleryFilterEd.pas");
USEUNIT("dxRibbonGalleryReg.pas");
USEUNIT("dxRibbonReg.pas");
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
