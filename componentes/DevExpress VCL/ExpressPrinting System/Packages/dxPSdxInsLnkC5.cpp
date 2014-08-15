//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("VCL50.bpi");
USEPACKAGE("VCLX50.bpi");
USEPACKAGE("dxcomnc5.bpi");
USEPACKAGE("dxPSCorec5.bpi");
USEPACKAGE("dxEdtrC5.bpi");
USEPACKAGE("dxInsC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USERES("dxPSdxInsLnkc5.res");
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
