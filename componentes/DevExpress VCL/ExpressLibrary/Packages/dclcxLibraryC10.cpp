//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxLibraryC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("dcldxCoreC10.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("designide.bpi");
USEPACKAGE("Vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEPACKAGE("dxThemeC10.bpi");
USEPACKAGE("dxGDIPlusC10.bpi");  
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
