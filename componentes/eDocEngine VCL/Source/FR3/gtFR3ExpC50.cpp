//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("gtFR3ExpC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("gtDocEngC50.bpi");
USEPACKAGE("VCLJPG50.bpi");
USEUNIT("gtFR3XportIntf.pas");
USEPACKAGE("gtDocEngC50Pro.bpi");
USEPACKAGE("frx5.bpi");
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
