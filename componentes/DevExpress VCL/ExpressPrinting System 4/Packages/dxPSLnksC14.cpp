//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSLnksC14.res");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxPageControlC14.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxPSCoreC14.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxComnC14.bpi");
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
