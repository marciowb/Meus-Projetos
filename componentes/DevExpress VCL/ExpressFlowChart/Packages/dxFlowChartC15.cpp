//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxFlowChartC15.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
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
