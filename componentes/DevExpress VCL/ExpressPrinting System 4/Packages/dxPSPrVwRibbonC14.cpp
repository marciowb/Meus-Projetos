//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSPrVwRibbonC14.res");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("dxBarC14.bpi");
USEPACKAGE("dxRibbonC14.bpi");
USEPACKAGE("dxBarExtItemsC14.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxComnC14.bpi");
USEUNIT("dxPSPrVwRibbon.pas");
USEFORMNS("dxPSPrVwRibbon.pas", dxPSPrVwRibbon, dxRibbonPrintPreviewForm);
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
