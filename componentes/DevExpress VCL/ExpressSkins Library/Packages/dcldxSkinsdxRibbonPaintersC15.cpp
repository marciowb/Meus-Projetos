//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsdxRibbonPainterC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxDockingC15.bpi");
USEPACKAGE("dxSkinsCoreC15.bpi");
USEPACKAGE("dxBarC15.bpi");
USEPACKAGE("dxRibbonC15.bpi");
USEPACKAGE("dxSkinsdxRibbonPainterC15.bpi");
USEPACKAGE("dcldxSkinsCoreC15.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC15.bpi");
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
