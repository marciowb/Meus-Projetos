//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("FIBPlusEditors_CB5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("FIBPlus_CB5.bpi");
USEPACKAGE("dsnide50.bpi");
USEFORMNS("Editors\EdErrorInfo.pas", Ederrorinfo, frmErrors);
USEFORMNS("Editors\EdFieldInfo.pas", Edfieldinfo, frmFields);
USEUNIT("Editors\RegFIBPlusEditors.pas");
USEFORMNS("Editors\fraSQLEdit.pas", Frasqledit, fSQLEdit); /* TFrame: File Type */
USEFORMNS("Editors\fraConditionsEdit.pas", Fraconditionsedit, fraEdConditions); /* TFrame: File Type */
USEFORMNS("Editors\fraAutoUpdEditor.pas", Fraautoupdeditor, fAutoUpdateOptionForm); /* TFrame: File Type */
USEFORMNS("Editors\fraDSSQLEdit.pas", Fradssqledit, fDSSQLEdit); /* TFrame: File Type */
USEFORMNS("Editors\EdParamToFields.pas", Edparamtofields, frmEdParamToFields);
USEFORMNS("Editors\FIBSQLEditor.pas", Fibsqleditor, frmSQLEdit);
USEFORMNS("Editors\EdDataSetInfo.pas", Eddatasetinfo, frmEdDataSetInfo);
USEFORMNS("Editors\pFIBAutoUpdEditor.pas", Pfibautoupdeditor, pFIBAutoUpdateOptionForm);
USEFORMNS("Editors\pFIBConditionsEdit.pas", Pfibconditionsedit, frmEditCheckStrings);
USEFORMNS("Editors\pFIBDataSetOptions.pas", Pfibdatasetoptions, FPDataSetOptionsForm);
USEFORMNS("Editors\pFIBDBEdit.pas", Pfibdbedit, DBEditForm);
USEFORMNS("Editors\pFIBTrEdit.pas", Pfibtredit, frmTransEdit);
USEUNIT("Editors\ToCodeEditor.pas");
USEUNIT("Editors\ToCodeEditorIntfs.pas");
USEFORMNS("Editors\FIBDataSQLEditor.pas", Fibdatasqleditor, frmDstSQLedit);
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
