//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("ECQDBCC6.bpi");
USEPACKAGE("dxPSTLLnkC6.bpi");
USERES("dxPSdxDBCtrlLnkC6.res");
USEUNIT("dxPSdxDBCtrlLnk.pas");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclx.bpi");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
    return 1;
}
//---------------------------------------------------------------------------
