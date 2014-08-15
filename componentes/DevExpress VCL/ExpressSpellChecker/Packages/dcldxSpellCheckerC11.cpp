//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxSpellCheckerC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxSpellCheckerC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dclLibraryC11.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
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
