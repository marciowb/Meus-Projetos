//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxSpreadSheetC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("cxSpreadSheetC12.bpi");
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
