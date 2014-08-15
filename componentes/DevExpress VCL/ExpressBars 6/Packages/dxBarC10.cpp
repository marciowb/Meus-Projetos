//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxBarC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dxcomnC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("dxGDIPlusC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEFORMNS("dxBarCustForm.pas", Dxbarcustform, dxBarCustomizingForm);
USEFORMNS("dxBarItemEd.pas", Dxbaritemed, dxBarItemAddEditor);
USEFORMNS("dxBarNameEd.pas", Dxbarnameed, dxBarNameEd);
USEFORMNS("dxBarPopupMenuEd.pas", Dxbarpopupmenued, dxBarSubMenuEditor);
USEFORMNS("dxBarAddGroupItemsEd.pas", DxBarAddGroupItemsEd, frmAddGroupItems);
USEUNIT("dxBarCustomCustomizationForm.pas");
USEUNIT("dxBarCommon.pas");
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
