//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSPrVwAdvC10.res");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("dxBarExtItemsC10.bpi");
USEPACKAGE("dxBarC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
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
