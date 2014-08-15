//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSpellCheckerC15.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC15.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC15.bpi");
USEPACKAGE("cxExtEditorsC15.bpi");
USEPACKAGE("cxLibraryC15.bpi");
USEPACKAGE("cxDataC15.bpi");
USEPACKAGE("dxThemeC15.bpi");
USEPACKAGE("dxGDIPlusC15.bpi");
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
USEUNIT("dxHunspellAffixes.pas");
USEUNIT("dxHunspellDictionary.pas");
USEUNIT("dxHunspellTypes.pas");
USEUNIT("dxHunspellUtils.pas");
USEUNIT("dxHunspellWords.pas");

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
