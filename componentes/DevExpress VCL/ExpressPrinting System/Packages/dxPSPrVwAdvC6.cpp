//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSPrVwAdvC6.res");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxBarExtItemsC6.bpi");
USEPACKAGE("dxBarC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
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
