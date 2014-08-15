//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarExtItemsC10.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dcldxBarC10.bpi");
USEPACKAGE("dxComnC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dclcxLibraryC10.bpi");
USEPACKAGE("dxBarExtItemsC10.bpi");
USEUNIT("dxBarExtItemsReg.pas");
USEFORMNS("dxBarImageComboEditor.pas", Dxbarimagecomboeditor, dxBarImageComboEditorForm);
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
