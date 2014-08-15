//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxDBEdc5.bpi");
USEPACKAGE("EQTLc5.bpi");
USEPACKAGE("dxEdtrc5.bpi");
USEPACKAGE("EQGridc5.bpi");
USEPACKAGE("dxPSdxDBCtrlLnkc5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi"); 
USERES("dxPSdxDBGrLnkc5.res");
USEUNIT("dxPSdxDBGrLnkReg.pas");
USEUNIT("dxPSdxDBGrLnk.pas");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclx50.bpi");
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
