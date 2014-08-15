//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarExtItemsC6.res");
USEPACKAGE("vclx.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("dcldxBarC6.bpi");
USEPACKAGE("dxComnC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("dxBarExtItemsC6.bpi");
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
