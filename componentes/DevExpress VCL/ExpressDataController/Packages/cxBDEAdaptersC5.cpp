//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxBDEAdaptersC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("VCLBDE50.bpi");
USEPACKAGE("vclib50");
USEPACKAGE("cxDataC5.bpi");
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
