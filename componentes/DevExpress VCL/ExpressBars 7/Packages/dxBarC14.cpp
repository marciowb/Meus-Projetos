//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("dxcomnC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEFORMNS("dxBarCustForm.pas", Dxbarcustform, dxBarCustomizingForm);
USEFORMNS("dxBarItemEd.pas", Dxbaritemed, dxBarItemAddEditor);
USEFORMNS("dxBarNameEd.pas", Dxbarnameed, dxBarNameEd);
USEFORMNS("dxBarPopupMenuEd.pas", Dxbarpopupmenued, dxBarSubMenuEditor);
USEFORMNS("dxBarAddGroupItemsEd.pas", DxBarAddGroupItemsEd, frmAddGroupItems);
USEUNIT("dxBarCustomCustomizationForm.pas");
USEUNIT("dxBarApplicationMenu.pas");
USEUNIT("dxBarBuiltInMenu.pas");
USEUNIT("dxBar.pas");
USEUNIT("dxBarStrs.pas");
USEUNIT("dxStatusBar.pas");
USEUNIT("dxBarSkinConsts.pas");
USEUNIT("dxBarAccessibility.pas");
USEUNIT("dxBarSkin.pas");
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
