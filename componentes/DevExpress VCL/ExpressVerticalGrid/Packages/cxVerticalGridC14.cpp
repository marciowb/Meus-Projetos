//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxVerticalGridC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxExportC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
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
