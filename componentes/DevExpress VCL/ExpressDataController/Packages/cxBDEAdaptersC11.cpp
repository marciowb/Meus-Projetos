//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxBDEAdaptersC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("BDErtl.bpi");
USEPACKAGE("cxDataC11.bpi");
USEUNIT("cxBDEAdapters.pas");
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
