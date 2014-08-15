//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxBDEAdaptersC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("BDErtl.bpi");
USEPACKAGE("cxDataC12.bpi");
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
