//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxSpreadSheetC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC10.bpi");
USEPACKAGE("cxLibraryC10.bpi");
USEUNIT("cxExcelAccess.pas");
USEUNIT("cxExcelConst.pas");
USEUNIT("cxExcelFormulas.pas");
USEUNIT("cxSSheet.pas");
USEUNIT("cxSSColorBox.pas");
USEUNIT("cxSSCtrls.pas");
USEUNIT("cxSSData.pas");
USEFORMNS("cxSSDesigner.pas", Cxssdesigner, cxSSStyleDesigner);
USEUNIT("cxSSEditors.pas");
USEUNIT("cxSSFormulas.pas");
USEUNIT("cxSSHeaders.pas");
USEUNIT("cxSSIntf.pas");
USEUNIT("cxSSPainters.pas");
USEUNIT("cxSSPainterWrapper.pas");
USEUNIT("cxSSRes.pas");
USEUNIT("cxSSStyles.pas");
USEUNIT("cxSSTypes.pas");
USEUNIT("cxSSUtils.pas");
USEUNIT("cxSSViewInfo.pas");
USEUNIT("cxSSHistory.pas");
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
