//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("pFIBPlusTools_CB5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEUNIT("RegFIBPlusUtils.pas");
USEPACKAGE("vclsmp50.bpi");
USEPACKAGE("FIBPlus_CB5.bpi");
USEPACKAGE("FIBPlusEditors_CB5.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("dsnide50.bpi");
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
