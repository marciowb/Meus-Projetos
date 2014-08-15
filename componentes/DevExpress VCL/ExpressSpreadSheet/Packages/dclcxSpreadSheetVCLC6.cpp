//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxSpreadSheetVCLC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("cxSpreadSheetVCLC6.bpi");
USEUNIT("cxSSReg.pas");
USERES("cxSSReg.dcr");
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
