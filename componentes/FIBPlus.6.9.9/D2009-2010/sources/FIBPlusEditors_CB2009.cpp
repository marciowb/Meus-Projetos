//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("Editors\fraSQLEdit.pas", Frasqledit, fSQLEdit); /* TFrame: File Type */
USEFORMNS("Editors\pFIBDBEdit.pas", Pfibdbedit, DBEditForm);
USEFORMNS("Editors\pFIBTrEdit.pas", Pfibtredit, frmTransEdit);
USEFORMNS("Editors\EdDataSetInfo.pas", Eddatasetinfo, frmEdDataSetInfo);
USEFORMNS("Editors\EdErrorInfo.pas", Ederrorinfo, frmErrors);
USEFORMNS("Editors\EdFieldInfo.pas", Edfieldinfo, frmFields);
USEFORMNS("Editors\EdParamToFields.pas", Edparamtofields, frmEdParamToFields);
USEFORMNS("Editors\FIBSQLEditor.pas", Fibsqleditor, frmSQLEdit);
USEFORMNS("Editors\fraAutoUpdEditor.pas", Fraautoupdeditor, fAutoUpdateOptionForm); /* TFrame: File Type */
USEFORMNS("Editors\fraConditionsEdit.pas", Fraconditionsedit, fraEdConditions); /* TFrame: File Type */
USEFORMNS("Editors\fraDSSQLEdit.pas", Fradssqledit, fDSSQLEdit); /* TFrame: File Type */
USEFORMNS("Editors\pFIBAutoUpdEditor.pas", Pfibautoupdeditor, pFIBAutoUpdateOptionForm);
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
