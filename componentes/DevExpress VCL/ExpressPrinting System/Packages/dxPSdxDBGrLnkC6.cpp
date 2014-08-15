//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("EQGridC6.bpi");
USEPACKAGE("dxPSdxDBCtrlLnkC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi"); 
USERES("dxPSdxDBGrLnkC6.res");
USEUNIT("dxPSdxDBGrLnkReg.pas");
USEUNIT("dxPSdxDBGrLnk.pas");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("designide.bpi");
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
