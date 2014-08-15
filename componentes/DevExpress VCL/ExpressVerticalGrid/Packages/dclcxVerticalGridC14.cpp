//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxVerticalGridC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExportC14.bpi");
USEPACKAGE("cxVerticalGridC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dclcxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dclcxEditorsC14.bpi");
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
