//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxADOAdaptersC5.res");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("Vclado50.bpi");
USEPACKAGE("cxDataC5.bpi");
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
