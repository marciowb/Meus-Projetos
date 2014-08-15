//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("VCLDB.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("dxPSCoreC10.bpi");
USEPACKAGE("dxMasterViewC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USERES("dxPSdxMVLnkC10.res");
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
