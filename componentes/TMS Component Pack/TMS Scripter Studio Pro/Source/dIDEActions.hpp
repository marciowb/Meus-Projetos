// CodeGear C++Builder
// Copyright (c) 1995, 2010 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'dIDEActions.pas' rev: 22.00

#ifndef DideactionsHPP
#define DideactionsHPP

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
#include <ActnList.hpp>	// Pascal unit
#include <IDEMain.hpp>	// Pascal unit
#include <ImgList.hpp>	// Pascal unit
#include <atScript.hpp>	// Pascal unit
#include <atScripter.hpp>	// Pascal unit
#include <AdvMemo.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dideactions
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TLastSearchMode { lsNone, lsFind, lsReplace };
#pragma option pop

class DELPHICLASS TdmIDEActions;
class PASCALIMPLEMENTATION TdmIDEActions : public Classes::TDataModule
{
	typedef Classes::TDataModule inherited;
	
__published:
	Actnlist::TActionList* ActionList1;
	Actnlist::TAction* acNewUnit;
	Actnlist::TAction* acNewForm;
	Actnlist::TAction* acOpenFile;
	Actnlist::TAction* acSaveFile;
	Actnlist::TAction* acSaveAsFile;
	Actnlist::TAction* acSaveAll;
	Dialogs::TOpenDialog* OpenDialog1;
	Dialogs::TSaveDialog* SaveDialog1;
	Actnlist::TAction* acCloseFile;
	Actnlist::TAction* acCloseAll;
	Actnlist::TAction* acExit;
	Actnlist::TAction* acToggleFormUnit;
	Controls::TImageList* ImageList1;
	Actnlist::TAction* acRun;
	Actnlist::TAction* acStepOver;
	Actnlist::TAction* acTraceInto;
	Actnlist::TAction* acRunTo;
	Actnlist::TAction* acReturn;
	Actnlist::TAction* acPause;
	Actnlist::TAction* acReset;
	Actnlist::TAction* acEvaluate;
	Actnlist::TAction* acAddWatch;
	Actnlist::TAction* acToggleBreak;
	Actnlist::TAction* acSaveProjectAs;
	Actnlist::TAction* acRemoveFromProject;
	Actnlist::TAction* acNewProject;
	Actnlist::TAction* acOpenProject;
	Actnlist::TAction* acLock;
	Actnlist::TAction* acCopyClipboard;
	Actnlist::TAction* acCutClipboard;
	Actnlist::TAction* acPasteClipboard;
	Actnlist::TAction* acSelectAll;
	Actnlist::TAction* acDeleteControl;
	Actnlist::TAction* acAlignToGrid;
	Actnlist::TAction* acBringToFront;
	Actnlist::TAction* acSendToBack;
	Actnlist::TAction* acAlignDialog;
	Actnlist::TAction* acSizeDialog;
	Actnlist::TAction* acAlignmentPalette;
	Actnlist::TAction* acTabOrderDialog;
	Actnlist::TAction* acDesignerOptionsDlg;
	Actnlist::TAction* acSetMainUnit;
	Actnlist::TAction* acUndo;
	Actnlist::TAction* acFind;
	Actnlist::TAction* acReplace;
	Advmemo::TAdvMemoFindDialog* FindDialog1;
	Actnlist::TAction* acSearchAgain;
	Advmemo::TAdvMemoFindReplaceDialog* ReplaceDialog1;
	Actnlist::TAction* acRedo;
	Actnlist::TAction* acCompile;
	void __fastcall acNewPascalUnitExecue(System::TObject* Sender);
	void __fastcall acNewFormExecute(System::TObject* Sender);
	void __fastcall acOpenFileExecute(System::TObject* Sender);
	void __fastcall acSaveFileExecute(System::TObject* Sender);
	void __fastcall acSaveAsFileExecute(System::TObject* Sender);
	void __fastcall acSaveAllExecute(System::TObject* Sender);
	void __fastcall acCloseFileExecute(System::TObject* Sender);
	void __fastcall acCloseAllExecute(System::TObject* Sender);
	void __fastcall acExitExecute(System::TObject* Sender);
	void __fastcall acToggleFormUnitExecute(System::TObject* Sender);
	void __fastcall acToggleFormUnitUpdate(System::TObject* Sender);
	void __fastcall acRunExecute(System::TObject* Sender);
	void __fastcall acStepOverExecute(System::TObject* Sender);
	void __fastcall acTraceIntoExecute(System::TObject* Sender);
	void __fastcall acRunToExecute(System::TObject* Sender);
	void __fastcall acReturnExecute(System::TObject* Sender);
	void __fastcall acPauseExecute(System::TObject* Sender);
	void __fastcall acResetExecute(System::TObject* Sender);
	void __fastcall acToggleBreakExecute(System::TObject* Sender);
	void __fastcall acSaveProjectAsExecute(System::TObject* Sender);
	void __fastcall acRemoveFromProjectExecute(System::TObject* Sender);
	void __fastcall acNewProjectExecute(System::TObject* Sender);
	void __fastcall acOpenProjectExecute(System::TObject* Sender);
	void __fastcall HasDesignerUpdate(System::TObject* Sender);
	void __fastcall acLockExecute(System::TObject* Sender);
	void __fastcall acLockUpdate(System::TObject* Sender);
	void __fastcall acDesignerOptionsDlgExecute(System::TObject* Sender);
	void __fastcall acTabOrderDialogExecute(System::TObject* Sender);
	void __fastcall acAlignDialogExecute(System::TObject* Sender);
	void __fastcall acSizeDialogExecute(System::TObject* Sender);
	void __fastcall acAlignmentPaletteExecute(System::TObject* Sender);
	void __fastcall acBringToFrontExecute(System::TObject* Sender);
	void __fastcall acSendToBackExecute(System::TObject* Sender);
	void __fastcall acAlignToGridExecute(System::TObject* Sender);
	void __fastcall acSelectAllExecute(System::TObject* Sender);
	void __fastcall acSelectAllUpdate(System::TObject* Sender);
	void __fastcall acCopyClipboardExecute(System::TObject* Sender);
	void __fastcall acCutClipboardUpdate(System::TObject* Sender);
	void __fastcall acCopyClipboardUpdate(System::TObject* Sender);
	void __fastcall acCutClipboardExecute(System::TObject* Sender);
	void __fastcall acPasteClipboardExecute(System::TObject* Sender);
	void __fastcall acPasteClipboardUpdate(System::TObject* Sender);
	void __fastcall ActionList1Update(Classes::TBasicAction* Action, bool &Handled);
	void __fastcall acAddWatchExecute(System::TObject* Sender);
	void __fastcall acDeleteControlUpdate(System::TObject* Sender);
	void __fastcall acDeleteControlExecute(System::TObject* Sender);
	void __fastcall acSetMainUnitExecute(System::TObject* Sender);
	void __fastcall acSetMainUnitUpdate(System::TObject* Sender);
	void __fastcall acAddWatchUpdate(System::TObject* Sender);
	void __fastcall acUndoUpdate(System::TObject* Sender);
	void __fastcall acUndoExecute(System::TObject* Sender);
	void __fastcall acFindUpdate(System::TObject* Sender);
	void __fastcall acReplaceUpdate(System::TObject* Sender);
	void __fastcall acFindExecute(System::TObject* Sender);
	void __fastcall acReplaceExecute(System::TObject* Sender);
	void __fastcall FindDialog1FindText(System::TObject* Sender);
	void __fastcall acSearchAgainExecute(System::TObject* Sender);
	void __fastcall acSearchAgainUpdate(System::TObject* Sender);
	void __fastcall acRedoUpdate(System::TObject* Sender);
	void __fastcall acRedoExecute(System::TObject* Sender);
	void __fastcall acCompileExecute(System::TObject* Sender);
	
private:
	Idemain::TIDEEngine* FEngine;
	TLastSearchMode FLastSearch;
	void __fastcall SetEngine(const Idemain::TIDEEngine* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TdmIDEActions(Classes::TComponent* AOwner);
	__property Idemain::TIDEEngine* Engine = {read=FEngine, write=SetEngine};
public:
	/* TDataModule.CreateNew */ inline __fastcall virtual TdmIDEActions(Classes::TComponent* AOwner, int Dummy) : Classes::TDataModule(AOwner, Dummy) { }
	/* TDataModule.Destroy */ inline __fastcall virtual ~TdmIDEActions(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE TdmIDEActions* dmIDEActions;

}	/* namespace Dideactions */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE)
using namespace Dideactions;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DideactionsHPP
