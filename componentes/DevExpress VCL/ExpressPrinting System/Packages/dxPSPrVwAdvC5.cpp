//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSPrVwAdvc5.res");
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxBarExtItemsC5.bpi");
USEPACKAGE("dxBarC5.bpi");
USEPACKAGE("dxThemeC5.bpi");
USEFORMNS("dxPSPrVwAdv.pas", Dxpsprvwadv, dxfmPreviewWdxBar);
USEPACKAGE("vcl50.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
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
