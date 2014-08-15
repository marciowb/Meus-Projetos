//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxADOAdaptersC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("adortl.bpi");
USEPACKAGE("cxDataC10.bpi");
USEUNIT("cxADOAdapters.pas");
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
