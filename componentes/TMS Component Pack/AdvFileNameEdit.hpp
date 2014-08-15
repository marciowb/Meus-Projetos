// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advfilenameedit.pas' rev: 21.00

#ifndef AdvfilenameeditHPP
#define AdvfilenameeditHPP

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
#include <Advedit.hpp>	// Pascal unit
#include <Advedbtn.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advfilenameedit
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TFileDialogKind { fdOpen, fdSave, fdOpenPicture, fdSavePicture };
#pragma option pop

typedef void __fastcall (__closure *TDialogExitEvent)(System::TObject* Sender, bool ExitOK);

class DELPHICLASS TAdvFileNameEdit;
class PASCALIMPLEMENTATION TAdvFileNameEdit : public Advedbtn::TAdvEditBtn
{
	typedef Advedbtn::TAdvEditBtn inherited;
	
private:
	System::Byte FDummy;
	System::UnicodeString FDefaultExt;
	System::UnicodeString FFilter;
	int FFilterIndex;
	System::UnicodeString FInitialDir;
	Dialogs::TOpenOptions FDialogOptions;
	System::UnicodeString FDialogTitle;
	TFileDialogKind FDialogKind;
	TDialogExitEvent FOnDialogExit;
	Sysutils::TFileName __fastcall GetFileName(void);
	void __fastcall SetFileName(const Sysutils::TFileName Value);
	
protected:
	virtual void __fastcall BtnClick(System::TObject* Sender);
	virtual void __fastcall ValidateEvent(System::UnicodeString Value, bool &IsValid);
	void __fastcall DialogExit(bool ExitOk);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual bool __fastcall TestURL(void);
	
public:
	void __fastcall ClickButton(void);
	__fastcall virtual TAdvFileNameEdit(Classes::TComponent* AOwner);
	
__published:
	__property System::Byte AutoThousandSeparator = {read=FDummy, nodefault};
	__property System::Byte EditAlign = {read=FDummy, nodefault};
	__property System::Byte EditType = {read=FDummy, nodefault};
	__property System::Byte ExcelStyleDecimalSeparator = {read=FDummy, nodefault};
	__property System::Byte PasswordChar = {read=FDummy, nodefault};
	__property System::Byte Precision = {read=FDummy, nodefault};
	__property System::Byte Signed = {read=FDummy, nodefault};
	__property System::UnicodeString DefaultExt = {read=FDefaultExt, write=FDefaultExt};
	__property Sysutils::TFileName FileName = {read=GetFileName, write=SetFileName, stored=false};
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
	__property int FilterIndex = {read=FFilterIndex, write=FFilterIndex, default=1};
	__property System::UnicodeString InitialDir = {read=FInitialDir, write=FInitialDir};
	__property Dialogs::TOpenOptions DialogOptions = {read=FDialogOptions, write=FDialogOptions, default=524292};
	__property System::UnicodeString DialogTitle = {read=FDialogTitle, write=FDialogTitle};
	__property TFileDialogKind DialogKind = {read=FDialogKind, write=FDialogKind, nodefault};
	__property TDialogExitEvent OnDialogExit = {read=FOnDialogExit, write=FOnDialogExit};
public:
	/* TAdvEditBtn.Destroy */ inline __fastcall virtual ~TAdvFileNameEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvFileNameEdit(HWND ParentWindow) : Advedbtn::TAdvEditBtn(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advfilenameedit */
using namespace Advfilenameedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvfilenameeditHPP
