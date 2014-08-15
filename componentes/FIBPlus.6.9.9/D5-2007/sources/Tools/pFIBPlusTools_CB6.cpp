//---------------------------------------------------------------------------

#include <basepch.h>
#pragma hdrstop
USEFORMNS("pFIBPreferences.pas", Pfibpreferences, frmFIBPreferences);
USEFORMNS("pFIBDsgnViewSQLs.pas", Pfibdsgnviewsqls, frmSaveSQLs);
USEFORMNS("uFrmSearchResult.pas", Ufrmsearchresult, frmCompSearchResult);
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
