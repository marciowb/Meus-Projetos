//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCorec6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxSpreadSheetVCLC6.bpi");
USERES("dxPScxSSLnkc6.res");
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
