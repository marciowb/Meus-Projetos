//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxRibbonC15.res");
USERES("dxRibbonReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxcomnC15.bpi");
USEPACKAGE("dxBarC15.bpi");
USEPACKAGE("dxRibbonC15.bpi");
USEPACKAGE("dclcxLibraryC15.bpi");
USEPACKAGE("dcldxBarC15.bpi");
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
