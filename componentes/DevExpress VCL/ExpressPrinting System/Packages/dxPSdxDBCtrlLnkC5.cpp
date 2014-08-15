//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxDBEdc5.bpi");
USEPACKAGE("EQTLc5.bpi");
USEPACKAGE("dxEdtrc5.bpi");
USEPACKAGE("ECQDBCC5.bpi");
USEPACKAGE("dxPSTLLnkc5.bpi");
USERES("dxPSdxDBCtrlLnkc5.res");
USEUNIT("dxPSdxDBCtrlLnk.pas");
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
