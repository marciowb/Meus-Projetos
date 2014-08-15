//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxFlowChartC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxFlowChartC14.bpi");
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
