//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("EQGridC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USEPACKAGE("ECQDBCC6.bpi");
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
