//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxMasterViewC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLX50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxcomnc5.bpi");
USEUNIT("dxMasterView.pas");
USEUNIT("dxMasterViewColumns.pas");
USEUNIT("dxMasterViewStrs.pas");
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
