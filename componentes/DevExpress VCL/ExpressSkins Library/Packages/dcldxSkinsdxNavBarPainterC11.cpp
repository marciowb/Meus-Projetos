//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinsdxNavBarPainterC11.res");
USEPACKAGE("dxNavBarC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxSkinsdxNavBarPainterC11.bpi");
USEPACKAGE("dcldxSkinsCoreC11.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC11.bpi");
USEPACKAGE("dxNavBarC11.bpi");
USEUNIT("dxSkinsdxNavBarPainterReg.pas");
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
