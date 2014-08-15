//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USERES("dxPSLnksC6.res");
USEUNIT("dxPSLnkReg.pas");
USEUNIT("dxPSImgLnk.pas");
USEFORMNS("dxPSChlbxLnk.pas", Dxpschlbxlnk, dxChlbxReportLinkDesignWindow);
USEFORMNS("dxPSLbxLnk.pas", Dxpslbxlnk, dxLBxReportLinkDesignWindow);
USEFORMNS("dxPSStdGrLnk.pas", Dxpsstdgrlnk, dxGridReportLinkDesignWindow);
USEFORMNS("dxPSTVLnk.pas", Dxpstvlnk, dxTVReportLinkDesignWindow);
USEUNIT("dxPSDBCtrlLnkReg.pas");
USEUNIT("dxPSDBCtrlLnks.pas");
USEUNIT("dxPSDBCtrlProducers.pas");
USEUNIT("dxPSLVLnk.pas");
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
