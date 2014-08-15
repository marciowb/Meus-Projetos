//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("FIBDBMidas_CB5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("pFIBClientDataSet.pas");
USEPACKAGE("Vclmid50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("FIBPlus_CB5.bpi");
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
