//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxSchedulerGridC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxExportC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExtEditorsC11.bpi");
USEPACKAGE("cxPageControlC11.bpi");
USEPACKAGE("cxGridC11.bpi");
USEPACKAGE("cxSchedulerC11.bpi");
USEUNIT("cxSchedulercxGridConnection.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
