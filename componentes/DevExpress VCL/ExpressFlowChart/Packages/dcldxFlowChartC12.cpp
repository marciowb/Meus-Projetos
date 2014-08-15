//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxFlowChartC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxFlowChartC12.bpi");
USEUNIT("Dxfchreg.pas");
USEUNIT("dxEditCon.pas");
USEUNIT("dxEditObj.pas");
USEUNIT("dxFcEdit.pas");
USEUNIT("dxFcStrs.pas");
USEUNIT("dxSelUnion.pas");
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
