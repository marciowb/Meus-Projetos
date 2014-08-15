// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Asgfinddialog.pas' rev: 21.00

#ifndef AsgfinddialogHPP
#define AsgfinddialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advgrid.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Asgfinddialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAsgFindDlg;
class DELPHICLASS TAdvGridFindDialog;
class PASCALIMPLEMENTATION TAsgFindDlg : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
__published:
	Stdctrls::TGroupBox* Options;
	Stdctrls::TLabel* Label1;
	Stdctrls::TComboBox* TextToFind;
	Stdctrls::TCheckBox* Docase;
	Stdctrls::TCheckBox* Whole;
	Stdctrls::TCheckBox* MatchFirst;
	Stdctrls::TCheckBox* IgnoreHTML;
	Extctrls::TRadioGroup* Scope;
	Stdctrls::TButton* OkBtn;
	Stdctrls::TButton* CancelBtn;
	Stdctrls::TCheckBox* Fixed;
	Stdctrls::TGroupBox* gbDirection;
	Stdctrls::TCheckBox* cbForwardTB;
	Stdctrls::TCheckBox* cbForwardLR;
	Stdctrls::TCheckBox* cbBackwardBT;
	Stdctrls::TCheckBox* cbBackwardRL;
	Stdctrls::TCheckBox* Wildcards;
	void __fastcall OkBtnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelBtnClick(System::TObject* Sender);
	void __fastcall TextToFindChange(System::TObject* Sender);
	void __fastcall ScopeClick(System::TObject* Sender);
	void __fastcall cbForwardTBClick(System::TObject* Sender);
	void __fastcall cbForwardLRClick(System::TObject* Sender);
	void __fastcall cbBackwardBTClick(System::TObject* Sender);
	void __fastcall cbBackwardRLClick(System::TObject* Sender);
	void __fastcall cbForwardTBMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall cbForwardLRMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall cbBackwardBTMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall cbBackwardRLMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
private:
	bool bInhibitcbForwardTB;
	bool bInhibitcbForwardLR;
	bool bInhibitcbBackwardBT;
	bool bInhibitcbBackwardRL;
	
public:
	bool bInhibitToggle;
	Advgrid::TAdvStringGrid* FGrid;
	TAdvGridFindDialog* FFindDialog;
	Types::TPoint FGridCell;
	System::UnicodeString FMsgNoMoreFound;
	System::UnicodeString FMsgNotFound;
	bool FAutoPosition;
	Classes::TNotifyEvent FOnFindDone;
	__property Classes::TNotifyEvent OnFindDone = {read=FOnFindDone, write=FOnFindDone};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAsgFindDlg(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAsgFindDlg(Classes::TComponent* AOwner, int Dummy) : Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAsgFindDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAsgFindDlg(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TCellFoundEvent)(System::TObject* Sender, Advgrid::TAdvStringGrid* Grid, int ACol, int ARow, System::UnicodeString Value);

class PASCALIMPLEMENTATION TAdvGridFindDialog : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Advgrid::TAdvStringGrid* FGrid;
	TAsgFindDlg* FAsgFind;
	System::UnicodeString FTxtCaption;
	System::UnicodeString FTxtOptionsWholeWords;
	System::UnicodeString FTxtScope;
	System::UnicodeString FTxtDirForward1;
	System::UnicodeString FTxtDirForward2;
	System::UnicodeString FTxtBtnOk;
	System::UnicodeString FTxtScopeCurrCol;
	System::UnicodeString FTxtOptionsCase;
	System::UnicodeString FTxtOptionsFixedCells;
	System::UnicodeString FTxtOptionsMatchFirst;
	System::UnicodeString FTxtScopeAllCells;
	System::UnicodeString FTxtScopeSelectedCells;
	System::UnicodeString FTxtTextToFind;
	System::UnicodeString FTxtScopeCurrRow;
	System::UnicodeString FTxtBtnCancel;
	System::UnicodeString FTxtDirBackward1;
	System::UnicodeString FTxtDirBackward2;
	System::UnicodeString FTxtDirection;
	System::UnicodeString FTxtOptionsIgnoreHTML;
	System::UnicodeString FTxtOptions;
	System::UnicodeString FMsgNoMoreFound;
	System::UnicodeString FMsgNotFound;
	System::UnicodeString FSearchText;
	bool FAutoPosition;
	System::UnicodeString FTxtOptionsWildcards;
	Classes::TNotifyEvent FOnFindDone;
	Classes::TNotifyEvent FOnFindClose;
	Controls::TKeyEvent FOnDialogKeyDown;
	TCellFoundEvent FOnCellFound;
	int FDialogWidth;
	void __fastcall SetDialogWidth(const int Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall FindDone(System::TObject* Sender);
	void __fastcall FindClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall DialogKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TAdvGridFindDialog(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridFindDialog(void);
	void __fastcall Execute(void);
	__property TAsgFindDlg* Dialog = {read=FAsgFind};
	
__published:
	__property bool AutoPosition = {read=FAutoPosition, write=FAutoPosition, nodefault};
	__property int DialogWidth = {read=FDialogWidth, write=SetDialogWidth, default=360};
	__property Advgrid::TAdvStringGrid* Grid = {read=FGrid, write=FGrid};
	__property System::UnicodeString MsgNotFound = {read=FMsgNotFound, write=FMsgNotFound};
	__property System::UnicodeString MsgNoMoreFound = {read=FMsgNoMoreFound, write=FMsgNoMoreFound};
	__property System::UnicodeString SearchText = {read=FSearchText, write=FSearchText};
	__property System::UnicodeString TxtCaption = {read=FTxtCaption, write=FTxtCaption};
	__property System::UnicodeString TxtTextToFind = {read=FTxtTextToFind, write=FTxtTextToFind};
	__property System::UnicodeString TxtDirection = {read=FTxtDirection, write=FTxtDirection};
	__property System::UnicodeString TTxtDirForward1 = {read=FTxtDirForward1, write=FTxtDirForward1};
	__property System::UnicodeString TTxtDirForward2 = {read=FTxtDirForward2, write=FTxtDirForward2};
	__property System::UnicodeString TTxtDirBackward1 = {read=FTxtDirBackward1, write=FTxtDirBackward1};
	__property System::UnicodeString TTxtDirBackward2 = {read=FTxtDirBackward2, write=FTxtDirBackward2};
	__property System::UnicodeString TxtScope = {read=FTxtScope, write=FTxtScope};
	__property System::UnicodeString TxtScopeAllCells = {read=FTxtScopeAllCells, write=FTxtScopeAllCells};
	__property System::UnicodeString TxtScopeCurrRow = {read=FTxtScopeCurrRow, write=FTxtScopeCurrRow};
	__property System::UnicodeString TxtScopeCurrCol = {read=FTxtScopeCurrCol, write=FTxtScopeCurrCol};
	__property System::UnicodeString TxtScopeSelectedCells = {read=FTxtScopeSelectedCells, write=FTxtScopeSelectedCells};
	__property System::UnicodeString TxtOptions = {read=FTxtOptions, write=FTxtOptions};
	__property System::UnicodeString TxtOptionsCase = {read=FTxtOptionsCase, write=FTxtOptionsCase};
	__property System::UnicodeString TxtOptionsWholeWords = {read=FTxtOptionsWholeWords, write=FTxtOptionsWholeWords};
	__property System::UnicodeString TxtOptionsMatchFirst = {read=FTxtOptionsMatchFirst, write=FTxtOptionsMatchFirst};
	__property System::UnicodeString TxtOptionsIgnoreHTML = {read=FTxtOptionsIgnoreHTML, write=FTxtOptionsIgnoreHTML};
	__property System::UnicodeString TxtOptionsFixedCells = {read=FTxtOptionsFixedCells, write=FTxtOptionsFixedCells};
	__property System::UnicodeString TxtOptionsWildcards = {read=FTxtOptionsWildcards, write=FTxtOptionsWildcards};
	__property System::UnicodeString TxtBtnOk = {read=FTxtBtnOk, write=FTxtBtnOk};
	__property System::UnicodeString TxtBtnCancel = {read=FTxtBtnCancel, write=FTxtBtnCancel};
	__property TCellFoundEvent OnCellFound = {read=FOnCellFound, write=FOnCellFound};
	__property Classes::TNotifyEvent OnFindDone = {read=FOnFindDone, write=FOnFindDone};
	__property Classes::TNotifyEvent OnFindClose = {read=FOnFindClose, write=FOnFindClose};
	__property Controls::TKeyEvent OnDialogKeyDown = {read=FOnDialogKeyDown, write=FOnDialogKeyDown};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Asgfinddialog */
using namespace Asgfinddialog;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AsgfinddialogHPP
