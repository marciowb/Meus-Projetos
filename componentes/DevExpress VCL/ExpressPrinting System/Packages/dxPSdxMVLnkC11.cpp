//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("dxPSCoreC11.bpi");
USEPACKAGE("dxMasterViewC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USERES("dxPSdxMVLnkC11.res");
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
