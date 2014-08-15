//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLX50.bpi");
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxObjInsC5.bpi");
USEPACKAGE("dxPSdxInsLnkC5.bpi");
USERES("dxPSdxOILnkc5.res");
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
