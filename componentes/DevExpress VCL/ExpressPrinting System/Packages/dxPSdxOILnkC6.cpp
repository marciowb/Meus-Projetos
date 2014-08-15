//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxObjInsC6.bpi");
USEPACKAGE("dxPSdxInsLnkC6.bpi");
USERES("dxPSdxOILnkC6.res");
USEUNIT("dxPSdxOILnkReg.pas");
USEUNIT("dxPSdxOILnk.pas");
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
