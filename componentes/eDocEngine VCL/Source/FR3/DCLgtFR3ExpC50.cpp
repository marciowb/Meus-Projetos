//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("DCLgtFR3ExpC50.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("VCLJPG50.bpi");
USEUNIT("gtFR3ExpReg.pas");
USERES("gtFR3ExpReg.dcr");
USEPACKAGE("gtFR3ExpC50.bpi");
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
