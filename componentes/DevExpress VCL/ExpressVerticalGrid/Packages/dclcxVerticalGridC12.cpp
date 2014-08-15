//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxVerticalGridC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExportC12.bpi");
USEPACKAGE("cxVerticalGridC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("dclcxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dclcxEditorsC12.bpi");
USEPACKAGE("designide.bpi");
USEUNIT("cxVGridPredefinedStyles.pas");
USEFORMNS("cxVGridLayoutEditor.pas", Cxvgridlayouteditor, fmvgLayoutEditor);
USEUNIT("cxVGridEditor.pas");
USEUNIT("cxVGridReg.pas");
USERES("cxVGridReg.dcr");
USEUNIT("cxVGridConverter.pas");
USEUNIT("cxVGridDXInspConverter.pas");
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
