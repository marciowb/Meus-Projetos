//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxBDEAdaptersC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("BDErtl.bpi");
USEPACKAGE("cxDataC6.bpi");
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
