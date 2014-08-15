// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Lucombo.pas' rev: 21.00

#ifndef LucomboHPP
#define LucomboHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Advcombo.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Lucombo
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAutoCompleteEvent)(System::TObject* Sender, const System::UnicodeString UsrStr, System::UnicodeString &AutoAdd, int idx);

typedef void __fastcall (__closure *TEnterAcceptEvent)(System::TObject* Sender, const System::UnicodeString Str, int idx, bool &accept);

typedef void __fastcall (__closure *TAddToHistoryEvent)(System::TObject* Sender, const System::UnicodeString Str);

#pragma option push -b-
enum TAutoHistoryDirection { ahdFirst, ahdLast };
#pragma option pop

#pragma option push -b-
enum TLUStorage { stInifile, stRegistry };
#pragma option pop

class DELPHICLASS TLUPersist;
class PASCALIMPLEMENTATION TLUPersist : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnable;
	TLUStorage FStorage;
	System::UnicodeString FKey;
	System::UnicodeString FSection;
	int FCount;
	bool FMaxCount;
	
__published:
	__property bool Enable = {read=FEnable, write=FEnable, nodefault};
	__property TLUStorage Storage = {read=FStorage, write=FStorage, nodefault};
	__property System::UnicodeString Key = {read=FKey, write=FKey};
	__property System::UnicodeString Section = {read=FSection, write=FSection};
	__property int Count = {read=FCount, write=FCount, nodefault};
	__property bool MaxCount = {read=FMaxCount, write=FMaxCount, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLUPersist(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLUPersist(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TLUCombo;
class PASCALIMPLEMENTATION TLUCombo : public Advcombo::TAdvComboBox
{
	typedef Advcombo::TAdvComboBox inherited;
	
private:
	bool workmode;
	int ItemIdx;
	int ItemSel;
	bool ItemChange;
	System::UnicodeString FLookupStr;
	bool FReturnIsTab;
	TAutoCompleteEvent FAutoComplete;
	TEnterAcceptEvent FEnterAccept;
	TAddToHistoryEvent FOnAddToHistory;
	bool FAutoHistory;
	bool FAutoSynchronize;
	bool FFileLookup;
	TLUPersist* FLUPersist;
	bool FMatchCase;
	bool FMatchStart;
	System::UnicodeString FFileLookupDir;
	int FAutoHistoryLimit;
	TAutoHistoryDirection FAutoHistoryDirection;
	bool FModified;
	Graphics::TColor FModifiedColor;
	Graphics::TColor FDefaultColor;
	System::UnicodeString FOldValue;
	bool FShowModified;
	int FItemIndex;
	void __fastcall SetLUPersist(TLUPersist* value);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	void __fastcall SetModifiedColor(const Graphics::TColor Value);
	void __fastcall SetModified(const bool Value);
	int __fastcall GetItemIndexP(void);
	void __fastcall SetItemIndexP(const int Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
public:
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall Change(void);
	__fastcall virtual TLUCombo(Classes::TComponent* aOwner);
	__fastcall virtual ~TLUCombo(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SavePersist(void);
	void __fastcall LoadPersist(void);
	__property System::UnicodeString FileLookupDir = {read=FFileLookupDir, write=FFileLookupDir};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	
__published:
	__property TAutoCompleteEvent AutoComplete = {read=FAutoComplete, write=FAutoComplete};
	__property TAddToHistoryEvent OnAddToHistory = {read=FOnAddToHistory, write=FOnAddToHistory};
	__property bool AutoHistory = {read=FAutoHistory, write=FAutoHistory, nodefault};
	__property int AutoHistoryLimit = {read=FAutoHistoryLimit, write=FAutoHistoryLimit, nodefault};
	__property TAutoHistoryDirection AutoHistoryDirection = {read=FAutoHistoryDirection, write=FAutoHistoryDirection, nodefault};
	__property bool AutoSynchronize = {read=FAutoSynchronize, write=FAutoSynchronize, nodefault};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property TEnterAcceptEvent Accept = {read=FEnterAccept, write=FEnterAccept};
	__property bool FileLookup = {read=FFileLookup, write=FFileLookup, nodefault};
	__property TLUPersist* Persist = {read=FLUPersist, write=SetLUPersist};
	__property bool MatchCase = {read=FMatchCase, write=FMatchCase, default=0};
	__property bool MatchStart = {read=FMatchStart, write=FMatchStart, default=1};
	__property Graphics::TColor ModifiedColor = {read=FModifiedColor, write=SetModifiedColor, nodefault};
	__property bool ShowModified = {read=FShowModified, write=FShowModified, nodefault};
	__property int ItemIndex = {read=GetItemIndexP, write=SetItemIndexP, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLUCombo(HWND ParentWindow) : Advcombo::TAdvComboBox(ParentWindow) { }
	
};


class DELPHICLASS TLUEdit;
class PASCALIMPLEMENTATION TLUEdit : public Stdctrls::TEdit
{
	typedef Stdctrls::TEdit inherited;
	
private:
	bool workmode;
	Classes::TStringList* FLookupItems;
	TAutoCompleteEvent FAutoComplete;
	TAddToHistoryEvent FOnAddToHistory;
	bool FAutoHistory;
	bool FAutoSynchronize;
	bool FReturnIsTab;
	TEnterAcceptEvent FEnterAccept;
	bool FFileLookup;
	TLUPersist* FLUPersist;
	bool FMatchCase;
	System::UnicodeString FFileLookupDir;
	bool FModified;
	Graphics::TColor FModifiedColor;
	Graphics::TColor FDefaultColor;
	System::UnicodeString FOldValue;
	int FAutoHistoryLimit;
	TAutoHistoryDirection FAutoHistoryDirection;
	bool FShowModified;
	void __fastcall SetLookupItems(Classes::TStringList* value);
	void __fastcall SetLUPersist(TLUPersist* value);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Msg);
	void __fastcall SetModifiedColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetModified(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall DoExit(void);
	
public:
	DYNAMIC void __fastcall Change(void);
	__fastcall virtual TLUEdit(Classes::TComponent* aOwner);
	__fastcall virtual ~TLUEdit(void);
	void __fastcall SavePersist(void);
	void __fastcall LoadPersist(void);
	virtual void __fastcall Loaded(void);
	__property System::UnicodeString FileLookupDir = {read=FFileLookupDir, write=FFileLookupDir};
	__property bool Modified = {read=FModified, write=SetModified, nodefault};
	
__published:
	__property Classes::TStringList* LookupItems = {read=FLookupItems, write=SetLookupItems};
	__property TAutoCompleteEvent AutoComplete = {read=FAutoComplete, write=FAutoComplete};
	__property TAddToHistoryEvent OnAddToHistory = {read=FOnAddToHistory, write=FOnAddToHistory};
	__property TEnterAcceptEvent Accept = {read=FEnterAccept, write=FEnterAccept};
	__property bool AutoHistory = {read=FAutoHistory, write=FAutoHistory, nodefault};
	__property int AutoHistoryLimit = {read=FAutoHistoryLimit, write=FAutoHistoryLimit, nodefault};
	__property TAutoHistoryDirection AutoHistoryDirection = {read=FAutoHistoryDirection, write=FAutoHistoryDirection, nodefault};
	__property bool AutoSynchronize = {read=FAutoSynchronize, write=FAutoSynchronize, nodefault};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property bool FileLookup = {read=FFileLookup, write=FFileLookup, nodefault};
	__property TLUPersist* Persist = {read=FLUPersist, write=SetLUPersist};
	__property bool MatchCase = {read=FMatchCase, write=FMatchCase, nodefault};
	__property Graphics::TColor ModifiedColor = {read=FModifiedColor, write=SetModifiedColor, nodefault};
	__property bool ShowModified = {read=FShowModified, write=FShowModified, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLUEdit(HWND ParentWindow) : Stdctrls::TEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Lucombo */
using namespace Lucombo;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LucomboHPP
