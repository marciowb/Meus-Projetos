//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("cxSchedulerVCLC6.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxCoreC6.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("cxEditorsVCLC6.bpi");
USEPACKAGE("cxExtEditorsVCLC6.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("cxExportVCLC6.bpi");
USEPACKAGE("cxDataC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEUNIT("cxScheduler.pas");
USEUNIT("cxSchedulerCustomControls.pas");
USEUNIT("cxSchedulerCustomResourceView.pas");
USEUNIT("cxSchedulerDateNavigator.pas");
USEUNIT("cxSchedulerDayView.pas");
USEUNIT("cxSchedulerDBStorage.pas");
USEUNIT("cxSchedulerDialogs.pas");
USEUNIT("cxSchedulerEventEditor.pas");
USEUNIT("cxSchedulerGoToDateDialog.pas");
USEUNIT("cxSchedulerRecurrenceEditor.pas");
USEUNIT("cxSchedulerRecurrenceSelectionDialog.pas");
USEUNIT("cxSchedulerResourcesLayoutEditor.pas");
USEUNIT("cxSchedulerStorage.pas");
USEUNIT("cxSchedulerStrs.pas");
USEUNIT("cxSchedulerUtils.pas");
USEUNIT("cxExportSchedulerLink.pas");
USEUNIT("cxSchedulerWeekView.pas");
USEUNIT("cxSchedulerOutlookExchange.pas");
USEUNIT("cxDateNavigator.pas");

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
