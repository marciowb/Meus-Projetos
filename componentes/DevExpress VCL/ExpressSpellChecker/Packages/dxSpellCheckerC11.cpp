//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSpellCheckerC11.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC11.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC11.bpi");
USEPACKAGE("cxExtEditorsC11.bpi");
USEPACKAGE("cxLibraryC11.bpi");
USEPACKAGE("cxDataC11.bpi");
USEPACKAGE("dxThemeC11.bpi");
USEPACKAGE("dxGDIPlusC11.bpi");
USEUNIT("dxSpellChecker.pas");
USEUNIT("dxISpellDecompressor.pas");
USEUNIT("dxSpellCheckerAlgorithms.pas");
USEUNIT("dxSpellCheckerRules.pas");
USEUNIT("dxSpellCheckerStrs.pas");
USEUNIT("dxSpellCheckerUtils.pas");
USEUNIT("dxSpellCheckerCheckAsYouType.pas");
USEUNIT("dxSpellCheckerDialogs.pas");
USEUNIT("dxSpellCheckerBaseForm.pas");
USEUNIT("dxSpellCheckerOutlookDialog.pas");
USEUNIT("dxCustomDictionaryDialog.pas");
USEUNIT("dxSpellCheckerAutoCorrect.pas");
USEUNIT("dxSpellCheckerWordDialog.pas");
USEUNIT("dxSpellCheckerSpellingOptionsDialog.pas");
USEUNIT("dxSpellCheckerAutoCorrectExceptionDialog.pas");
USEUNIT("dxSpellCheckerAutoCorrectOptionsDialog.pas");
USEUNIT("dxSpellCheckerExceptionsFrame.pas");

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
