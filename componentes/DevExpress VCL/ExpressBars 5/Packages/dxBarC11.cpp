//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEUNIT("dxBarCommon.pas");
USEUNIT("dxBar.pas");
USEFORMNS("dxBarCustForm.pas", Dxbarcustform, dxBarCustomizingForm);
USEFORMNS("dxBarItemEd.pas", Dxbaritemed, dxBarItemAddEditor);
USEFORMNS("dxBarNameEd.pas", Dxbarnameed, dxBarNameEd);
USEFORMNS("dxBarPopupMenuEd.pas", Dxbarpopupmenued, dxBarSubMenuEditor);
USEFORMNS("dxBarAddGroupItemsEd.pas", DxBarAddGroupItemsEd, frmAddGroupItems);
USEUNIT("dxBarStrs.pas");
USEUNIT("dxStatusBar.pas");
USEPACKAGE("dxcomnC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
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
