// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Flctrlex.pas' rev: 21.00

#ifndef FlctrlexHPP
#define FlctrlexHPP

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
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Filectrl.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Flctrlex
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFileListBoxEx;
class PASCALIMPLEMENTATION TFileListBoxEx : public Filectrl::TFileListBox
{
	typedef Filectrl::TFileListBox inherited;
	
private:
	Controls::TImageList* FImages;
	bool FWinNT;
	HIDESBASE MESSAGE void __fastcall CNMeasureItem(Messages::TWMMeasureItem &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall ReadFileNames(void);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	
public:
	__fastcall virtual TFileListBoxEx(Classes::TComponent* AOwner);
	__fastcall virtual ~TFileListBoxEx(void);
	
__published:
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TFileListBoxEx(HWND ParentWindow) : Filectrl::TFileListBox(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TListNotifyEvent)(System::TObject* Sender, int Item);

class DELPHICLASS TBoolList;
class PASCALIMPLEMENTATION TBoolList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	bool operator[](int Index) { return Items[Index]; }
	
private:
	TListNotifyEvent FOnChange;
	bool __fastcall GetBoolean(int index);
	void __fastcall SetBoolean(int index, const bool Value);
	
public:
	__property bool Items[int Index] = {read=GetBoolean, write=SetBoolean/*, default*/};
	HIDESBASE void __fastcall Add(bool Value);
	HIDESBASE void __fastcall Insert(int Index, bool Value);
	HIDESBASE void __fastcall Delete(int Index);
	__property TListNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TBoolList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TBoolList(void) : Classes::TList() { }
	
};


typedef void __fastcall (__closure *TCheckClickEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TCheckFileListBoxEx;
class PASCALIMPLEMENTATION TCheckFileListBoxEx : public TFileListBoxEx
{
	typedef TFileListBoxEx inherited;
	
private:
	TBoolList* FBoolList;
	bool FFlat;
	TCheckClickEvent FOnClickCheck;
	bool __fastcall GetChecked(int Index);
	void __fastcall SetChecked(int Index, const bool Value);
	void __fastcall SyncLists(void);
	void __fastcall SetFlat(const bool Value);
	
protected:
	void __fastcall DrawCheck(const Types::TRect &R, Stdctrls::TCheckBoxState AState, bool AEnabled);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &ch);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TCheckFileListBoxEx(Classes::TComponent* AOwner);
	__fastcall virtual ~TCheckFileListBoxEx(void);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	
__published:
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property TCheckClickEvent OnClickCheck = {read=FOnClickCheck, write=FOnClickCheck};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCheckFileListBoxEx(HWND ParentWindow) : TFileListBoxEx(ParentWindow) { }
	
};


class DELPHICLASS TDirectoryListBoxEx;
class PASCALIMPLEMENTATION TDirectoryListBoxEx : public Filectrl::TDirectoryListBox
{
	typedef Filectrl::TDirectoryListBox inherited;
	
private:
	Controls::TImageList* FImages;
	int FDirOpen;
	int FDirClosed;
	bool FWinNT;
	bool FDirectOpen;
	int FIndent;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	__property int Indent = {read=FIndent, write=FIndent, nodefault};
	
public:
	__fastcall virtual TDirectoryListBoxEx(Classes::TComponent* AOwner);
	__fastcall virtual ~TDirectoryListBoxEx(void);
	
__published:
	__property BorderStyle = {default=1};
	__property bool DirectOpen = {read=FDirectOpen, write=FDirectOpen, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDirectoryListBoxEx(HWND ParentWindow) : Filectrl::TDirectoryListBox(ParentWindow) { }
	
};


class DELPHICLASS TCheckDirectoryListBoxEx;
class PASCALIMPLEMENTATION TCheckDirectoryListBoxEx : public TDirectoryListBoxEx
{
	typedef TDirectoryListBoxEx inherited;
	
private:
	TBoolList* FBoolList;
	bool FFlat;
	TCheckClickEvent FOnClickCheck;
	bool __fastcall GetChecked(int Index);
	void __fastcall SetChecked(int Index, const bool Value);
	void __fastcall SyncLists(void);
	void __fastcall SetFlat(const bool Value);
	
protected:
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	void __fastcall DrawCheck(const Types::TRect &R, Stdctrls::TCheckBoxState AState, bool AEnabled);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &ch);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	
public:
	__fastcall virtual TCheckDirectoryListBoxEx(Classes::TComponent* AOwner);
	__fastcall virtual ~TCheckDirectoryListBoxEx(void);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	
__published:
	__property BorderStyle = {default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property TCheckClickEvent OnClickCheck = {read=FOnClickCheck, write=FOnClickCheck};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCheckDirectoryListBoxEx(HWND ParentWindow) : TDirectoryListBoxEx(ParentWindow) { }
	
};


class DELPHICLASS TDriveComboBoxEx;
class PASCALIMPLEMENTATION TDriveComboBoxEx : public Filectrl::TDriveComboBox
{
	typedef Filectrl::TDriveComboBox inherited;
	
private:
	Controls::TImageList* FImages;
	bool FWinNT;
	HIDESBASE MESSAGE void __fastcall CNMeasureItem(Messages::TWMMeasureItem &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	virtual void __fastcall BuildList(void);
	DYNAMIC void __fastcall Click(void);
	
public:
	__fastcall virtual TDriveComboBoxEx(Classes::TComponent* AOwner);
	__fastcall virtual ~TDriveComboBoxEx(void);
	
__published:
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDriveComboBoxEx(HWND ParentWindow) : Filectrl::TDriveComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Flctrlex */
using namespace Flctrlex;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// FlctrlexHPP
