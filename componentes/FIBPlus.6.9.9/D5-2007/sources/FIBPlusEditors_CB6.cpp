//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USEFORMNS("editors\pFIBDBEdit.pas", Pfibdbedit, DBEditForm);
USEFORMNS("editors\pFIBTrEdit.pas", Pfibtredit, frmTransEdit);
USEFORMNS("editors\fraSQLEdit.pas", Frasqledit, fSQLEdit); /* TFrame: File Type */
USEFORMNS("editors\fraAutoUpdEditor.pas", Fraautoupdeditor, fAutoUpdateOptionForm); /* TFrame: File Type */
USEFORMNS("editors\fraConditionsEdit.pas", Fraconditionsedit, fraEdConditions); /* TFrame: File Type */
USEFORMNS("editors\fraDSSQLEdit.pas", Fradssqledit, fDSSQLEdit); /* TFrame: File Type */
USEFORMNS("editors\FIBDataSQLEditor.pas", Fibdatasqleditor, frmDstSQLedit);
USEFORMNS("editors\FIBSQLEditor.pas", Fibsqleditor, frmSQLEdit);
USEFORMNS("editors\pFIBDataSetOptions.pas", Pfibdatasetoptions, FPDataSetOptionsForm);
USEFORMNS("editors\EdErrorInfo.pas", Ederrorinfo, frmErrors);
USEFORMNS("editors\EdFieldInfo.pas", Edfieldinfo, frmFields);
USEFORMNS("editors\EdParamToFields.pas", Edparamtofields, frmEdParamToFields);
USEFORMNS("editors\pFIBAutoUpdEditor.pas", Pfibautoupdeditor, pFIBAutoUpdateOptionForm);
USEFORMNS("editors\pFIBConditionsEdit.pas", Pfibconditionsedit, frmEditCheckStrings);
USEFORMNS("editors\EdDataSetInfo.pas", Eddatasetinfo, frmEdDataSetInfo);
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
