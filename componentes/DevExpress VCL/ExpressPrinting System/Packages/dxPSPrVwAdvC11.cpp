//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSPrVwAdvC11.res");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxBarExtItemsC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
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
