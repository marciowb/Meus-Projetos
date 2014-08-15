//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxRibbonC10.res");
USERES("dxRibbonReg.dcr");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEPACKAGE("dxBarC10.bpi");
USEPACKAGE("dxRibbonC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("dcldxBarC10.bpi");
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
