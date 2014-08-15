// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'atScriptDebugForm.pas' rev: 22.00

#ifndef AtscriptdebugformHPP
#define AtscriptdebugformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <AdvMemo.hpp>	// Pascal unit
#include <AdvmPS.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atPascal.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <ToolWin.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <ActnList.hpp>	// Pascal unit
#include <AdvmBS.hpp>	// Pascal unit
#include <atBasic.hpp>	// Pascal unit
#include <FormScript.hpp>	// Pascal unit
#include <fWatchViewer.hpp>	// Pascal unit
#include <fWatchProperties.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Atscriptdebugform
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TDebugAction { daNone, daRun, daTraceInto, daStepOver, daReturn, daRunTo };
#pragma option pop

class DELPHICLASS TDebugForm;
class PASCALIMPLEMENTATION TDebugForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Controls::TImageList* ImageList1;
	Comctrls::TToolBar* ToolBar1;
	Comctrls::TToolButton* btRun;
	Comctrls::TToolButton* btPause;
	Comctrls::TToolButton* ToolButton14;
	Comctrls::TToolButton* btShowExec;
	Comctrls::TToolButton* btReset;
	Comctrls::TToolButton* btStepOver;
	Comctrls::TToolButton* btTraceInto;
	Comctrls::TToolButton* btReturn;
	Comctrls::TToolButton* btRunTo;
	Comctrls::TToolButton* ToolButton15;
	Comctrls::TToolButton* btEvaluate;
	Comctrls::TToolButton* btToggleBreak;
	Comctrls::TToolButton* btViewBreak;
	Comctrls::TToolButton* btAddWatch;
	Comctrls::TToolButton* btViewWatch;
	Extctrls::TPanel* Panel1;
	Advmemo::TAdvMemo* AdvMemo1;
	Actnlist::TActionList* ActionList1;
	Actnlist::TAction* acRun;
	Actnlist::TAction* acStepOver;
	Actnlist::TAction* acTraceInto;
	Actnlist::TAction* acRunTo;
	Actnlist::TAction* acReturn;
	Actnlist::TAction* acShowExec;
	Actnlist::TAction* acPause;
	Actnlist::TAction* acReset;
	Actnlist::TAction* acEvaluate;
	Actnlist::TAction* acAddWatch;
	Actnlist::TAction* acViewWatch;
	Actnlist::TAction* acToggleBreak;
	Actnlist::TAction* acViewBreak;
	Menus::TMainMenu* MainMenu1;
	Menus::TMenuItem* Run1;
	Menus::TMenuItem* Runscript1;
	Menus::TMenuItem* N2;
	Menus::TMenuItem* Stepover1;
	Menus::TMenuItem* Traceinto1;
	Menus::TMenuItem* Runtocursor1;
	Menus::TMenuItem* Rununtilreturn1;
	Menus::TMenuItem* Showexecutionpoint1;
	Menus::TMenuItem* Scriptpause1;
	Menus::TMenuItem* Scriptreser1;
	Menus::TMenuItem* N1;
	Menus::TMenuItem* Customexecute1;
	Menus::TMenuItem* Addwatch1;
	Menus::TMenuItem* Viewwatches1;
	Menus::TMenuItem* Addbreakpoint1;
	Menus::TMenuItem* Viewbreakpoints1;
	Menus::TPopupMenu* PopupMenu1;
	Menus::TMenuItem* Run2;
	Menus::TMenuItem* N3;
	Menus::TMenuItem* Stepover2;
	Menus::TMenuItem* Traceinto2;
	Menus::TMenuItem* Runtocursor2;
	Menus::TMenuItem* Rununtilreturn2;
	Menus::TMenuItem* Showexecutionpoint2;
	Menus::TMenuItem* Pause1;
	Menus::TMenuItem* Scriptreset1;
	Menus::TMenuItem* N4;
	Menus::TMenuItem* Evaluatemodify1;
	Menus::TMenuItem* Addwatch2;
	Menus::TMenuItem* Viewwatches2;
	Menus::TMenuItem* Togglebreakpoint1;
	Menus::TMenuItem* Viewbreakpoints2;
	Advmps::TAdvPascalMemoStyler* AdvPascalMemoStyler1;
	Advmbs::TAdvBasicMemoStyler* AdvBasicMemoStyler1;
	Comctrls::TStatusBar* StatusBar1;
	Extctrls::TTimer* Timer1;
	Menus::TPopupMenu* pmRoutines;
	void __fastcall btRunClick(System::TObject* Sender);
	void __fastcall btPauseClick(System::TObject* Sender);
	void __fastcall btStepOverClick(System::TObject* Sender);
	void __fastcall btTraceIntoClick(System::TObject* Sender);
	void __fastcall btRunToClick(System::TObject* Sender);
	void __fastcall btReturnClick(System::TObject* Sender);
	void __fastcall AdvMemo1GutterClick(System::TObject* Sender, int LineNo);
	void __fastcall btToggleBreakClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ActionList1Update(Classes::TBasicAction* Action, bool &Handled);
	void __fastcall btShowExecClick(System::TObject* Sender);
	void __fastcall btResetClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall AdvMemo1Change(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall acAddWatchExecute(System::TObject* Sender);
	void __fastcall acViewWatchExecute(System::TObject* Sender);
	void __fastcall AdvMemo1HintForToken(System::TObject* Sender, int X, int Y, System::UnicodeString AValue, System::UnicodeString &AHint, bool &Show);
	void __fastcall AdvMemo1CursorChange(System::TObject* Sender);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall AdvMemo1OverwriteToggle(System::TObject* Sender, bool &Allow);
	void __fastcall AdvMemo1GetAutoCompletionList(System::TObject* Sender, System::UnicodeString AToken, Classes::TStringList* AList);
	
private:
	Classes::TNotifyEvent FOldDebugHook;
	Classes::TNotifyEvent FOldRunningChanged;
	Classes::TNotifyEvent FOldPauseChanged;
	Atscript::TScriptErrorEvent FOnCompileError;
	System::UnicodeString FRoutineToRun;
	bool FModified;
	Controls::TModalResult FLastModifiedAnswer;
	Atscript::TatCustomScripter* FScripter;
	Fwatchviewer::TfmWatchViewer* fmWatchViewer;
	bool FShowErrors;
	bool FUpdateWatches;
	TDebugAction FDebugAction;
	Atscript::TatScript* FPreviousScript;
	int FUpdatingMemo;
	void __fastcall CheckRunningMode(void);
	void __fastcall PrepareScriptToRun(void);
	void __fastcall ToggleBreakAt(int line);
	void __fastcall SetBreakPoints(void);
	void __fastcall SetScripter(Atscript::TatCustomScripter* AScripter);
	void __fastcall HookScripterEvents(Atscript::TatCustomScripter* AScripter);
	void __fastcall UnhookScripterEvents(Atscript::TatCustomScripter* AScripter);
	void __fastcall CheckHalted(void);
	MESSAGE void __fastcall WMDebugAction(Messages::TMessage &Message);
	void __fastcall UpdateMenuItems(void);
	void __fastcall RoutinesMenuClick(System::TObject* Sender);
	
public:
	void __fastcall DisplayLineAttr(Atscript::pSimplifiedCode inst);
	void __fastcall ScriptDebug(System::TObject* Sender);
	void __fastcall ScriptError(System::TObject* Sender, System::UnicodeString &msg, int row, int col, bool &ShowException);
	void __fastcall ShowExecutionPoint(void);
	void __fastcall ActionControl(void);
	__property System::UnicodeString RoutineToRun = {read=FRoutineToRun, write=FRoutineToRun};
	
__published:
	__property Atscript::TatCustomScripter* Scripter = {read=FScripter, write=SetScripter};
	__property bool ShowErrors = {read=FShowErrors, write=FShowErrors, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDebugForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDebugForm(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDebugForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDebugForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word WM_DEBUGACTION = 0x401;
extern PACKAGE TDebugForm* DebugForm;

}	/* namespace Atscriptdebugform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Atscriptdebugform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AtscriptdebugformHPP
