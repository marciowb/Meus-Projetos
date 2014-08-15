//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxLibraryC15.res");
USEPACKAGE("dxGDIPlusC15.bpi");  
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vclx.bpi");
USEFORMNS("cxStyleSheetEditor.pas", Cxstylesheeteditor, frmcxStyleSheetEditor);
USEUNIT("cxContainer.pas");
USEUNIT("cxControls.pas");
USEUNIT("cxGraphics.pas");
USEUNIT("cxLookAndFeelPainters.pas");
USEUNIT("cxLookAndFeels.pas");
USEUNIT("cxScrollBar.pas");
USEUNIT("cxStorage.pas");
USEUNIT("cxStyles.pas");
USEUNIT("cxClasses.pas");
USEUNIT("cxLibraryStrs.pas");
USEUNIT("cxPropertiesStore.pas");
USEUNIT("cxConverterUtils.pas");
USEUNIT("cxCustomConverter.pas");
USEUNIT("cxGeometry.pas");
USEUNIT("cxDrawTextUtils.pas");
USEUNIT("cxAccessibility.pas");
USEUNIT("cxDWMApi.pas");
USEUNIT("cxDateUtils.pas");
USEUNIT("cxFormats.pas");
USEUNIT("cxLibraryConsts.pas");
USEUNIT("dxSkinInfo.pas");
USEUNIT("dxSkinsCore.pas");
USEUNIT("dxSkinsStrs.pas");
USEUNIT("dxFading.pas");
USEUNIT("cxLocalization.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
