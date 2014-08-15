//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dcldxBarExtItemsC5.res");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("VCL50.bpi");
USEPACKAGE("dcldxBarC5.bpi");
USEPACKAGE("dxComnC5.bpi");
USEPACKAGE("dxBarExtItemsC5.bpi");
USEPACKAGE("dxThemeC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
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
