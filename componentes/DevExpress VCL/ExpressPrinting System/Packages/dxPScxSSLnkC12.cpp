//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("cxSpreadSheetC12.bpi");
USERES("dxPScxSSLnkC12.res");
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
