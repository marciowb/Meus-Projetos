//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxSpellCheckerC15.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dxSpellCheckerC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("dclLibraryC15.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("dclcxEditorsC15.bpi");
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
