//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSPrVwAdvC12.res");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dxcomnC12.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("dxBarExtItemsC12.bpi");
USEPACKAGE("dxBarC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEFORMNS("dxPSPrVwAdv.pas", Dxpsprvwadv, dxfmPreviewWdxBar);
USEPACKAGE("vcl.bpi");
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
