//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxSpreadSheetC14.bpi");
USERES("dxPScxSSLnkC14.res");
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
