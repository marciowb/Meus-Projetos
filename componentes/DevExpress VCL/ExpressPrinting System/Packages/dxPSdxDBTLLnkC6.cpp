//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEPACKAGE("EQDBTLC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxDBEdC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxPSdxDBCtrlLnkC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi"); 
USERES("dxPSdxDBTLLnkC6.res");
USEUNIT("dxPSdxDBTLLnkReg.pas");
USEUNIT("dxPSdxDBTLLnk.pas");
USEPACKAGE("designide.bpi");
USEPACKAGE("vcl.bpi");
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
