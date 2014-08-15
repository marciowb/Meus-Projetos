//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("atImportSQLForm.pas", Atimportsqlform, fmImportSQL);
USEFORMNS("atMetaSQLAbstractEditor.pas", Atmetasqlabstracteditor, fmMetaSQLAbstractEditor); /* TFrame: File Type */
USEFORMNS("atMetaSQLConditionForm.pas", Atmetasqlconditionform, fmMetaSQLConditionForm);
USEFORMNS("atMetaSQLDataResult.pas", Atmetasqldataresult, fmMetaSQLDataResult); /* TFrame: File Type */
USEFORMNS("atMetaSQLForm.pas", Atmetasqlform, fmMetaSQLEditor);
USEFORMNS("atMetaSQLMemo.pas", Atmetasqlmemo, fmMetaSQLMemo); /* TFrame: File Type */
USEFORMNS("fCompareConditionEditor.pas", Fcompareconditioneditor, fmCompareConditionEditor);
USEFORMNS("fCustomConditionEditor.pas", Fcustomconditioneditor, fmCustomConditionEditor);
USEFORMNS("fcustomeditor.pas", Fcustomeditor, fmCustomEditor);
USEFORMNS("fCustomFieldEditor.pas", Fcustomfieldeditor, fmCustomFieldEditor);
USEFORMNS("fCustomGroupEditor.pas", Fcustomgroupeditor, fmCustomGroupEditor);
USEFORMNS("fCustomListParamEditor.pas", Fcustomlistparameditor, fmCustomListParamEditor);
USEFORMNS("fCustomOrderEditor.pas", Fcustomordereditor, fmCustomOrderEditor);
USEFORMNS("fCustomParamEditor.pas", Fcustomparameditor, fmCustomParamEditor);
USEFORMNS("fCustomTableEditor.pas", Fcustomtableeditor, fmCustomTableEditor);
USEFORMNS("fDistinctListParamEditor.pas", Fdistinctlistparameditor, fmDistinctListParamEditor);
USEFORMNS("fExpressionConditionEditor.pas", Fexpressionconditioneditor, fmExpressionConditionEditor);
USEFORMNS("fExpressionFieldEditor.pas", Fexpressionfieldeditor, fmExpressionFieldEditor);
USEFORMNS("fFreeEditParamEditor.pas", Ffreeeditparameditor, fmFreeEditParamEditor);
USEFORMNS("fQueryListParamEditor.pas", Fquerylistparameditor, fmQueryListParamEditor);
USEFORMNS("fSingleFieldEditor.pas", Fsinglefieldeditor, fmSingleFieldEditor);
USEFORMNS("fSubconditionsEditor.pas", Fsubconditionseditor, fmSubconditionsEditor);
USEFORMNS("ListForm.pas", Listform, fmListForm);
USEFORMNS("ShowSQLForm.pas", Showsqlform, fmShowSQL);
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
 