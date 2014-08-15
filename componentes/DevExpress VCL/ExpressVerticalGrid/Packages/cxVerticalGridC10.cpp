//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxVerticalGridC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC10.bpi");
USEPACKAGE("cxExtEditorsC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("cxExportC10.bpi");
USEPACKAGE("cxDataC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEUNIT("cxDBVGrid.pas");
USEUNIT("cxExportVGLink.pas");
USEUNIT("cxOI.pas");
USEFORMNS("cxOICollectionEd.pas", Cxoicollectioned, cxCollectionEditor);
USEFORMNS("cxOIPictureEd.pas", Cxoipictureed, cxfmPictureEditor);
USEFORMNS("cxOIStringsEd.pas", Cxoistringsed, cxfmStringsEditor);
USEUNIT("cxVGrid.pas");
USEUNIT("cxVGridConsts.pas");
USEFORMNS("cxVGridNewCategory.pas", Cxvgridnewcategory, fmCreateCategory);
USEUNIT("cxVGridUtils.pas");
USEUNIT("cxVGridViewInfo.pas");
USEUNIT("cxVGridStyleSheetPreview.pas");
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
