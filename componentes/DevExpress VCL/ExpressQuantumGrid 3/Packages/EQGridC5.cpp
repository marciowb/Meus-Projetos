//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("EQGridC5.res");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("EQTLC5.bpi");
USEPACKAGE("ECQDBCC5.bpi");
USEUNIT("dxDBGrid.pas");
USEUNIT("dxGrClms.pas");
USEUNIT("dxGrExpt.pas");
USEUNIT("dxFilter.pas");
USEUNIT("dxGrFltr.pas");
USEUNIT("dxLayout.pas");
USEUNIT("dxGrFDlg.pas");

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
