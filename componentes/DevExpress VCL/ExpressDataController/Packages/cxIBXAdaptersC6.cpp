//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxIBXAdaptersC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("ibxpress.bpi");
USEPACKAGE("cxDataC6.bpi");
USEUNIT("cxIBXAdapters.pas");
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
