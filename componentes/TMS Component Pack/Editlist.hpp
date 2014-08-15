// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Editlist.pas' rev: 21.00

#ifndef EditlistHPP
#define EditlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Editlist
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TScrollStyle { ssNormal, ssFlat, ssEncarta };
#pragma option pop

typedef void __fastcall (__closure *TEditDoneEvent)(System::TObject* Sender, System::UnicodeString &newstr, bool &allow);

typedef void __fastcall (__closure *TEditStartEvent)(System::TObject* Sender, int itemindex, bool &allow);

typedef void __fastcall (__closure *TAutoInsertEvent)(System::TObject* Sender, System::UnicodeString &avalue);

typedef void __fastcall (__closure *TAutoDeleteEvent)(System::TObject* Sender, System::UnicodeString &avalue, bool &allowdelete);

typedef void __fastcall (__closure *TSelChangeEvent)(System::TObject* Sender, int ListIndex);

#pragma option push -b-
enum TTabType { tableft, tabright };
#pragma option pop

class DELPHICLASS TTabPositionItem;
class PASCALIMPLEMENTATION TTabPositionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int fTabPosition;
	TTabType fTabType;
	void __fastcall SetTabPosition(int value);
	void __fastcall SetTabType(TTabType value);
	
__published:
	__property int TabPosition = {read=fTabPosition, write=SetTabPosition, nodefault};
	__property TTabType TabType = {read=fTabType, write=SetTabType, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TTabPositionItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TTabPositionItem(void) { }
	
};


class DELPHICLASS TTabPositionCollection;
class DELPHICLASS TEditListBox;
class PASCALIMPLEMENTATION TTabPositionCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TEditListBox* fOwner;
	
public:
	__fastcall TTabPositionCollection(TEditListBox* aOwner);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TTabPositionCollection(void) { }
	
};


class DELPHICLASS TSizeEdit;
class PASCALIMPLEMENTATION TSizeEdit : public Stdctrls::TEdit
{
	typedef Stdctrls::TEdit inherited;
	
private:
	TEditListBox* parentlist;
	int parentlistindex;
	int parentlistcount;
	System::UnicodeString parentlistcache;
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall UpdateEdit(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
public:
	/* TCustomEdit.Create */ inline __fastcall virtual TSizeEdit(Classes::TComponent* AOwner) : Stdctrls::TEdit(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSizeEdit(HWND ParentWindow) : Stdctrls::TEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TSizeEdit(void) { }
	
};


#pragma option push -b-
enum TELStorage { stInifile, stRegistry };
#pragma option pop

class DELPHICLASS TELPersist;
class PASCALIMPLEMENTATION TELPersist : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnable;
	TELStorage FStorage;
	System::UnicodeString FKey;
	System::UnicodeString FSection;
	int FCount;
	bool FMaxCount;
	
__published:
	__property bool Enable = {read=FEnable, write=FEnable, nodefault};
	__property TELStorage Storage = {read=FStorage, write=FStorage, nodefault};
	__property System::UnicodeString Key = {read=FKey, write=FKey};
	__property System::UnicodeString Section = {read=FSection, write=FSection};
	__property int Count = {read=FCount, write=FCount, nodefault};
	__property bool MaxCount = {read=FMaxCount, write=FMaxCount, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TELPersist(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TELPersist(void) : Classes::TPersistent() { }
	
};


class PASCALIMPLEMENTATION TEditListBox : public Stdctrls::TListBox
{
	typedef Stdctrls::TListBox inherited;
	
private:
	TSizeEdit* editctrl;
	Graphics::TColor FHintColor;
	Types::TPoint FLastHintPos;
	int FListTimerID;
	int FUpdateCount;
	System::UnicodeString FLookupString;
	bool FReturnIsTab;
	bool FReturnIsClick;
	bool FReturnIsDblClick;
	TEditDoneEvent FOnEditDone;
	TEditStartEvent FOnEditStart;
	TAutoInsertEvent FOnAutoInsert;
	TAutoDeleteEvent FOnAutoDelete;
	TSelChangeEvent FOnSelChange;
	bool FEditMode;
	bool FAutoInsert;
	bool FAutoDelete;
	bool FAllowEdit;
	bool FLookupIncr;
	bool FLookupFull;
	TScrollStyle FScrollStyle;
	Graphics::TColor FScrollColor;
	int FScrollWidth;
	bool FScrollHorizontal;
	int FCacheExtent;
	bool FEditDisable;
	Graphics::TColor FFocusColor;
	Graphics::TColor FNormalColor;
	bool FHovering;
	bool FStopHover;
	TELPersist* FELPersist;
	TTabPositionCollection* FTabPositions;
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	void __fastcall SetEditMode(const bool value);
	void __fastcall SetAllowEdit(const bool value);
	void __fastcall SetHovering(const bool value);
	void __fastcall UpdateHover(void);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE void __fastcall ShowHint(System::UnicodeString &HintStr, bool &CanShow, Controls::THintInfo &HintInfo);
	void __fastcall SetIndexAndScroll(int value);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &WMScroll);
	void __fastcall FlatSetScrollPos(int code, int pos, BOOL fRedraw);
	void __fastcall FlatSetScrollProp(int index, int newValue, BOOL fRedraw);
	void __fastcall FlatSetScrollInfo(int code, tagSCROLLINFO &scrollinfo, BOOL fRedraw);
	void __fastcall FlatShowScrollBar(int code, BOOL show);
	void __fastcall SetScrollStyle(const TScrollStyle Value);
	void __fastcall SetScrollColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetScrollWidth(const int Value);
	void __fastcall SetScrollHorizontal(const bool Value);
	void __fastcall SetTabPositions(TTabPositionCollection* value);
	void __fastcall SetTabStops(void);
	int __fastcall VisibleItems(void);
	int __fastcall GetStringExtent(System::UnicodeString s);
	int __fastcall GetMaxStringExtent(void);
	void __fastcall UpdateHScrollExtent(void);
	void __fastcall UpdateVScrollBar(void);
	void __fastcall UpdateHScrollBar(void);
	void __fastcall UpdateStyle(void);
	void __fastcall UpdateColor(void);
	void __fastcall UpdateWidth(void);
	void __fastcall Lookup(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DestroyWnd(void);
	
public:
	__fastcall virtual TEditListBox(Classes::TComponent* aOwner);
	__fastcall virtual ~TEditListBox(void);
	__property bool EditMode = {read=FEditMode, write=SetEditMode, nodefault};
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall ShowEdit(void);
	void __fastcall HideEdit(void);
	void __fastcall SavePersist(void);
	void __fastcall LoadPersist(void);
	void __fastcall OptimizeTabs(int padding);
	
__published:
	__property TEditDoneEvent OnEditDone = {read=FOnEditDone, write=FOnEditDone};
	__property TEditStartEvent OnEditStart = {read=FOnEditStart, write=FOnEditStart};
	__property bool AutoInsert = {read=FAutoInsert, write=FAutoInsert, nodefault};
	__property bool AutoDelete = {read=FAutoDelete, write=FAutoDelete, nodefault};
	__property bool AllowEdit = {read=FAllowEdit, write=SetAllowEdit, nodefault};
	__property TAutoInsertEvent OnAutoInsert = {read=FOnAutoInsert, write=FOnAutoInsert};
	__property TAutoDeleteEvent OnAutoDelete = {read=FOnAutoDelete, write=FOnAutoDelete};
	__property TSelChangeEvent OnSelChange = {read=FOnSelChange, write=FOnSelChange};
	__property ItemIndex = {write=SetIndexAndScroll};
	__property TScrollStyle ScrollStyle = {read=FScrollStyle, write=SetScrollStyle, nodefault};
	__property Graphics::TColor ScrollColor = {read=FScrollColor, write=SetScrollColor, nodefault};
	__property int ScrollWidth = {read=FScrollWidth, write=SetScrollWidth, nodefault};
	__property bool ScrollHorizontal = {read=FScrollHorizontal, write=SetScrollHorizontal, nodefault};
	__property bool LookupIncr = {read=FLookupIncr, write=FLookupIncr, nodefault};
	__property bool LookupFull = {read=FLookupFull, write=FLookupFull, nodefault};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property bool ReturnIsClick = {read=FReturnIsClick, write=FReturnIsClick, nodefault};
	__property bool ReturnIsDblClick = {read=FReturnIsDblClick, write=FReturnIsDblClick, nodefault};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=FFocusColor, nodefault};
	__property bool Hovering = {read=FHovering, write=SetHovering, nodefault};
	__property TELPersist* Persist = {read=FELPersist, write=FELPersist};
	__property Graphics::TColor HintColor = {read=FHintColor, write=FHintColor, nodefault};
	__property TTabPositionCollection* TabPositions = {read=FTabPositions, write=SetTabPositions};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TEditListBox(HWND ParentWindow) : Stdctrls::TListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Editlist */
using namespace Editlist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EditlistHPP
