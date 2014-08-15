//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxFlowChartC11.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEUNIT("Dxflchrt.pas");
USEUNIT("dxLines.pas");
USEUNIT("dxFcStrs.pas");
USEFORMNS("dxSelUnion.pas", Dxselunion, FSelectUnion);
USEFORMNS("dxEditCon.pas", Dxeditcon, FEditConnection);
USEFORMNS("dxEditObj.pas", Dxeditobj, FEditObject);
USEFORMNS("dxFcEdit.pas", Dxfcedit, FChartEditor);
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
