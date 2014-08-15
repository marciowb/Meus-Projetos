// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advdirectoryedit.pas' rev: 21.00

#ifndef AdvdirectoryeditHPP
#define AdvdirectoryeditHPP

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
#include <Advedbtn.hpp>	// Pascal unit
#include <Advedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advdirectoryedit
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TDirectoryShowEvent)(System::TObject* Sender, System::UnicodeString &InitialPath);

typedef void __fastcall (__closure *TDialogCloseEvent)(System::TObject* Sender, System::UnicodeString NewDirectory, bool OK);

class DELPHICLASS TAdvDirectoryEdit;
class PASCALIMPLEMENTATION TAdvDirectoryEdit : public Advedbtn::TAdvEditBtn
{
	typedef Advedbtn::TAdvEditBtn inherited;
	
private:
	System::Byte FDummy;
	Classes::TNotifyEvent FOnClickBtn;
	Advedit::TValueValidateEvent FOnValueValidate;
	System::UnicodeString FBrowseDialogText;
	bool FAllowNewFolder;
	TDirectoryShowEvent FOnShowDirectory;
	TDialogCloseEvent FOnDialogClose;
	
protected:
	virtual void __fastcall BtnClick(System::TObject* Sender);
	virtual void __fastcall ValueValidate(System::TObject* Sender, System::UnicodeString Value, bool &IsValid);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TAdvDirectoryEdit(Classes::TComponent* AOwner);
	bool __fastcall IsValidDirectory(void);
	void __fastcall ClickButton(void);
	
__published:
	__property System::Byte AutoThousandSeparator = {read=FDummy, nodefault};
	__property bool AllowNewFolder = {read=FAllowNewFolder, write=FAllowNewFolder, default=1};
	__property System::UnicodeString BrowseDialogText = {read=FBrowseDialogText, write=FBrowseDialogText};
	__property System::Byte EditAlign = {read=FDummy, nodefault};
	__property System::Byte EditType = {read=FDummy, nodefault};
	__property System::Byte ExcelStyleDecimalSeparator = {read=FDummy, nodefault};
	__property System::Byte PasswordChar = {read=FDummy, nodefault};
	__property System::Byte Precision = {read=FDummy, nodefault};
	__property System::Byte Signed = {read=FDummy, nodefault};
	__property System::Byte ShowURL = {read=FDummy, nodefault};
	__property System::Byte URLColor = {read=FDummy, nodefault};
	__property Classes::TNotifyEvent OnClickBtn = {read=FOnClickBtn};
	__property TDialogCloseEvent OnDialogClose = {read=FOnDialogClose, write=FOnDialogClose};
	__property Advedit::TValueValidateEvent OnValueValidate = {read=FOnValueValidate};
	__property TDirectoryShowEvent OnShowDirectoryDialog = {read=FOnShowDirectory, write=FOnShowDirectory};
public:
	/* TAdvEditBtn.Destroy */ inline __fastcall virtual ~TAdvDirectoryEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvDirectoryEdit(HWND ParentWindow) : Advedbtn::TAdvEditBtn(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advdirectoryedit */
using namespace Advdirectoryedit;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvdirectoryeditHPP
