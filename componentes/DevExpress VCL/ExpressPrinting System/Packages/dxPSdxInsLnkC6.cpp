//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxcomnC6.bpi");
USEPACKAGE("dxPSCoreC6.bpi");
USEPACKAGE("dxEdtrC6.bpi");
USEPACKAGE("dxInsC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USERES("dxPSdxInsLnkC6.res");
USEUNIT("dxPSdxInsLnkReg.pas");
USEUNIT("dxPSdxDBInsLnk.pas");
USEFORMNS("dxPSdxInsLnk.pas", Dxpsdxinslnk, dxInspectorDesignWindow);
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
