//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USERES("dxDockingC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEUNIT("dxDockPanel.pas");
USEUNIT("dxDockControl.pas");
USEUNIT("dxDockConsts.pas");
USEUNIT("dxDockControlNETView.pas");
USEUNIT("dxDockControlXPView.pas");
USEUNIT("dxDockZones.pas");
USEUNIT("dxDockControlOfficeView.pas");
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
