//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("EQTLC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USERES("dxPSTLLnkc5.res");
USEUNIT("dxPSdxTLLnkReg.pas");
USEFORMNS("dxPSdxTLLnk.pas", Dxpsdxtllnk, dxTLReportLinkDesignWindow);
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
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
