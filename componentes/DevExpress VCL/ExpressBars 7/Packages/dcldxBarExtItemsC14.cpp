//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarExtItemsC14.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dcldxBarC14.bpi");
USEPACKAGE("dxComnC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("dxBarExtItemsC14.bpi");
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
