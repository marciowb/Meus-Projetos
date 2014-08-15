//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxIBXAdaptersC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("vclib50.bpi");
USEPACKAGE("cxDataC5.bpi");
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
