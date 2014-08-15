//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxDataC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEUNIT("cxVariants.pas");
USEUNIT("cxCustomData.pas");
USEUNIT("cxData.pas");
USEUNIT("cxDataConsts.pas");
USEUNIT("cxDataStorage.pas");
USEUNIT("cxDataUtils.pas");
USEUNIT("cxDB.pas");
USEUNIT("cxDBData.pas");
USEUNIT("cxFilter.pas");
USEUNIT("cxDBFilter.pas");
USEUNIT("cxFilterConsts.pas");
USEUNIT("cxLike.pas");
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
