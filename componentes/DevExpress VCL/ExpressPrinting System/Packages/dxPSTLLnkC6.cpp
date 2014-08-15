//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("EQTLC6.bpi");
USERES("dxPSTLLnkC6.res");
USEUNIT("dxPSdxTLLnkReg.pas");
USEFORMNS("dxPSdxTLLnk.pas", Dxpsdxtllnk, dxTLReportLinkDesignWindow);
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
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
