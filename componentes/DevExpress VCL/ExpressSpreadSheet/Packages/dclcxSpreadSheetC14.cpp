//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxSpreadSheetC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("cxSpreadSheetC14.bpi");
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
