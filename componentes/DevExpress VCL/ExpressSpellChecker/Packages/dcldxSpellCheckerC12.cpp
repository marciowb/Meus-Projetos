//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxSpellCheckerC12.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxSpellCheckerC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dclLibraryC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("dclcxEditorsC12.bpi");
USEUNIT("dxSpellCheckerReg.pas");
USERES("dxSpellCheckerReg.dcr");
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
