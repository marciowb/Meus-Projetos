//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSLnksC15.res");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxPageControlC15.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxPSCoreC15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dxComnC15.bpi");
USEUNIT("dxPSGrLnks.pas");
USEUNIT("dxPSImgLnk.pas");
USEUNIT("dxPSLbxLnk.pas");
USEUNIT("dxPSChLbxLnk.pas");
USEUNIT("dxPSRELnk.pas");
USEUNIT("dxPSStdGrLnk.pas");
USEUNIT("dxPSTVLnk.pas");
USEUNIT("dxPSDBCtrlLnks.pas");
USEUNIT("dxPSDBCtrlProducers.pas");
USEUNIT("dxPSLVLnk.pas");
USEFORMNS("dxPSLbxLnk.pas", dxPSLbxLnk, dxLBxReportLinkDesignWindow);
USEFORMNS("dxPSChLbxLnk.pas", dxPSChLbxLnk, dxChlbxReportLinkDesignWindow);
USEFORMNS("dxPSStdGrLnk.pas", dxPSStdGrLnk, dxGridReportLinkDesignWindow);
USEFORMNS("dxPSTVLnk.pas", dxPSTVLnk, dxfmTVReportLinkDesignWindow);
USEFORMNS("dxPSLVLnk.pas", dxPSLVLnk, dxfmLVReportLinkDesignWindow);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
