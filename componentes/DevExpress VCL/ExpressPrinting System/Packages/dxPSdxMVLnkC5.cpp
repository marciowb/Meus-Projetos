//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLDB50.bpi");
USEPACKAGE("VCLX50.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxMasterViewC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USERES("dxPSdxMVLnkc5.res");
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
