//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxMasterViewC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USERES("dxPSdxMVLnkC6.res");
USEUNIT("dxPSMD.pas");
USEFORMNS("dxPSdxMVLnk.pas", Dxpsdxmvlnk, dxMVReportLinkDesignWindow);
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
