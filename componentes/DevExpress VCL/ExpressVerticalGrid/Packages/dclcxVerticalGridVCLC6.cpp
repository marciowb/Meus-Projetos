//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dclcxVerticalGridVCLC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxExportVCLC6.bpi");
USEPACKAGE("cxVerticalGridVCLC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dclcxLibraryVCLC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("dclcxEditorsVCLC6.bpi");
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
