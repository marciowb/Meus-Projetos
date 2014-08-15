//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxFlowChartC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxFlowChartC15.bpi");
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
