//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxVerticalGridC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxExportC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
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
