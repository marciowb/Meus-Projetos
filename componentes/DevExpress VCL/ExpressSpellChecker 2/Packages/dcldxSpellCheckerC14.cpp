//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxSpellCheckerC14.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxSpellCheckerC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dclLibraryC14.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("dclcxEditorsC14.bpi");
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
