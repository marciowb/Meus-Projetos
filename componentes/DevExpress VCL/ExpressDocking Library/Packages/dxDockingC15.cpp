//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
//---------------------------------------------------------------------------
USERES("dxDockingC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
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
