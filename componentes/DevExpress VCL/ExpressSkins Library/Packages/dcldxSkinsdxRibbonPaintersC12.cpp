//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsdxRibbonPainterC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxDockingC12.bpi");
USEPACKAGE("dxSkinsCoreC12.bpi");
USEPACKAGE("dxSkinsdxRibbonPainterC12.bpi");
USEPACKAGE("dxBarC12.bpi");
USEPACKAGE("dxRibbonC12.bpi");
USEPACKAGE("dcldxSkinsCoreC12.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC12.bpi");
USEUNIT("dxSkinsdxRibbonPaintersReg.pas");
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