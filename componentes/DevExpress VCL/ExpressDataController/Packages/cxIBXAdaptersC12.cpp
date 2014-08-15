//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxIBXAdaptersC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("ibxpress.bpi");
USEPACKAGE("cxDataC12.bpi");
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
