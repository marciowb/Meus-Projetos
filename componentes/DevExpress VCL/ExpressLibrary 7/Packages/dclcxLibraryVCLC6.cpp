//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxLibraryVCLC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("dcldxCoreC6.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("Vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dxGDIPlusC6.bpi");  
USEPACKAGE("dxThemeC6.bpi");
USEUNIT("cxClassesReg.pas");
USEFORMNS("cxDesignWindows.pas", Cxdesignwindows, cxDesignFormEditor);
USEUNIT("cxPropEditors.pas");
USEFORMNS("cxStyleRepositoryEditor.pas", Cxstylerepositoryeditor, cxStyleRepositoryEditor);
USEFORMNS("cxStyleSheetsLoad.pas", Cxstylesheetsload, frmcxStyleSheetsLoad);
USEUNIT("cxLibraryReg.pas");
USERES("cxLibraryReg.dcr");
USEUNIT("cxPropertiesStoreEditor.pas");
USEUNIT("cxImportDialog.pas");
USEUNIT("cxConverterFactory.pas");
USEFORMNS("cxComponentCollectionEditor.pas", Cxcomponentcollectioneditor, cxComponentCollectionEditor);
USEUNIT("cxImageListEditor.pas");
USEFORMNS("cxImageListEditorView.pas", Cximagelisteditorview, cxImageListEditorView);
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
