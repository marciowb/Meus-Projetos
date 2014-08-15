//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USERES("dxPSLnksc5.res");
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
