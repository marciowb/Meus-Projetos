//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxDataC10.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("Vcldb.bpi");
USEPACKAGE("dbrtl.bpi");
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
