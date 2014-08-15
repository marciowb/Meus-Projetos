//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxBarEditItemC11.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("VCLX.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxBarC11.bpi");
USEPACKAGE("cxBarEditItemC11.bpi");
USEPACKAGE("dclcxLibraryC11.bpi");
USEPACKAGE("dclcxEditorsC11.bpi");
USEPACKAGE("dclcxExtEditorsC11.bpi");
USEUNIT("cxBarEditItemReg.pas");
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
