//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSLnksC12.res");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxPSCoreC12.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dxComnC12.bpi");
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
