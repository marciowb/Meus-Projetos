//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("cxSpreadSheetVCLC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USERES("dxPScxSSLnkc5.res");
USEUNIT("dxPScxSSLnkReg.pas");
USEUNIT("dxPSExcelEdgePatterns.pas");
USEUNIT("dxPSExcelFillPatterns.pas");
USEFORMNS("dxPScxSSLnk.pas", Dxpscxsslnk, fmdxSpreadSheetDesignWindow);
USEPACKAGE("vcl50.bpi");
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
