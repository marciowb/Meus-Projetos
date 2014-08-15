//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("fSimplifiedCode.pas", Fsimplifiedcode, fmSimplifiedCode);
USEFORMNS("fSyntaxTree.pas", Fsyntaxtree, fmSyntaxTree);
USEFORMNS("fWatchProperties.pas", Fwatchproperties, fmWatchProperties);
USEFORMNS("fWatchViewer.pas", Fwatchviewer, fmWatchViewer);
USEFORMNS("advmemo\AdvMemoAC.pas", Advmemoac, MemoAC);
USEFORMNS("designer\DesignerAddControls.pas", Designeraddcontrols, frmDesignerAddControls);
USEFORMNS("designer\DesignerAlignDialog.pas", Designeraligndialog, frmAlign);
USEFORMNS("designer\DesignerAlignPalette.pas", Designeralignpalette, frmAlignmentPalette);
USEFORMNS("designer\DesignerControlsEditor.pas", Designercontrolseditor, frmDesignerControlsEditor);
USEFORMNS("designer\designeroptionsdialog.pas", Designeroptionsdialog, frmDesignerOptions);
USEFORMNS("designer\designersizedialog.pas", Designersizedialog, frmSize);
USEFORMNS("designer\DesignerTabOrderDialog.pas", Designertaborderdialog, frmTabOrder);
USEFORMNS("designer\fSelectLanguage.pas", Fselectlanguage, fmSelectLanguage);
USEFORMNS("designer\fSelectUnit.pas", Fselectunit, fmSelectUnit);
USEFORMNS("designer\ImageListEditor.pas", Imagelisteditor, fmImageListEditor);
USEFORMNS("designer\MenuInspIDEEditor.pas", Menuinspideeditor, frmMenuIDEEditor);
USEFORMNS("designer\PictureInspEditor.pas", Pictureinspeditor, frmPicture);
USEFORMNS("designer\StringsInspEditor.pas", Stringsinspeditor, frmStrings);
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
