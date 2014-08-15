//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("cxSpreadSheetC10.bpi");
USERES("dxPScxSSLnkC10.res");
USEUNIT("dxPScxSSLnkReg.pas");
USEUNIT("dxPSExcelEdgePatterns.pas");
USEUNIT("dxPSExcelFillPatterns.pas");
USEFORMNS("dxPScxSSLnk.pas", Dxpscxsslnk, fmdxSpreadSheetDesignWindow);
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
