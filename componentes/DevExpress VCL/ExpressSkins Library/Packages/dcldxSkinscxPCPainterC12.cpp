//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinscxPCPainterC12.res");
USEPACKAGE("dxSkinscxPCPainterC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dcldxSkinsCoreC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("dcldxSkinsDesignHelperC12.bpi");
USEUNIT("dxSkinscxPCPainterReg.pas");
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
