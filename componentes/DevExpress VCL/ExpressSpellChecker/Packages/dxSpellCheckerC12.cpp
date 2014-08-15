//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSpellCheckerC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
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
