//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSpellCheckerC14.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC14.bpi");
USEPACKAGE("cxExtEditorsC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("cxDataC14.bpi");
USEPACKAGE("dxThemeC14.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
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
