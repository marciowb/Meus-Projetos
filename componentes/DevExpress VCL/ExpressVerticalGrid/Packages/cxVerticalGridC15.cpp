//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxVerticalGridC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxExportC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
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
