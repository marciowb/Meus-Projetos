// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advlued.pas' rev: 21.00

#ifndef AdvluedHPP
#define AdvluedHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Advedit.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advlued
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAutoCompleteEvent)(System::TObject* Sender, const System::UnicodeString UsrStr, System::UnicodeString &AutoAdd, int idx);

typedef void __fastcall (__closure *TEnterAcceptEvent)(System::TObject* Sender, const System::UnicodeString Str, int idx, bool &accept);

typedef void __fastcall (__closure *TAddToHistoryEvent)(System::TObject* Sender, const System::UnicodeString Str);

class DELPHICLASS TLUPersist;
class PASCALIMPLEMENTATION TLUPersist : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnable;
	Advedit::TPersistenceLocation FLocation;
	System::UnicodeString FKey;
	System::UnicodeString FSection;
	int FCount;
	bool FMaxCount;
	
__published:
	__property bool Enable = {read=FEnable, write=FEnable, nodefault};
	__property Advedit::TPersistenceLocation Location = {read=FLocation, write=FLocation, nodefault};
	__property System::UnicodeString Key = {read=FKey, write=FKey};
	__property System::UnicodeString Section = {read=FSection, write=FSection};
	__property int Count = {read=FCount, write=FCount, nodefault};
	__property bool MaxCount = {read=FMaxCount, write=FMaxCount, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLUPersist(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TLUPersist(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TAdvLUEdit;
class PASCALIMPLEMENTATION TAdvLUEdit : public Advedit::TAdvEdit
{
	typedef Advedit::TAdvEdit inherited;
	
private:
	bool workmode;
	Classes::TStringList* FLookupItems;
	TAutoCompleteEvent FAutoComplete;
	TAddToHistoryEvent FOnAddToHistory;
	bool FAutoHistory;
	bool FAutoSynchronize;
	TEnterAcceptEvent FEnterAccept;
	bool FFileLookup;
	TLUPersist* FLUPersist;
	bool FMatchCase;
	bool FChanged;
	void __fastcall SetLookupItems(Classes::TStringList* value);
	void __fastcall SetLUPersist(TLUPersist* value);
	HIDESBASE MESSAGE void __fastcall WMDestroy(Messages::TMessage &Msg);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall LookupText(void);
	
public:
	DYNAMIC void __fastcall Change(void);
	__fastcall virtual TAdvLUEdit(Classes::TComponent* aOwner);
	__fastcall virtual ~TAdvLUEdit(void);
	virtual void __fastcall SavePersist(void);
	virtual void __fastcall LoadPersist(void);
	virtual void __fastcall Loaded(void);
	
__published:
	__property Classes::TStringList* LookupItems = {read=FLookupItems, write=SetLookupItems};
	__property TAutoCompleteEvent AutoComplete = {read=FAutoComplete, write=FAutoComplete};
	__property TAddToHistoryEvent OnAddToHistory = {read=FOnAddToHistory, write=FOnAddToHistory};
	__property TEnterAcceptEvent Accept = {read=FEnterAccept, write=FEnterAccept};
	__property bool AutoHistory = {read=FAutoHistory, write=FAutoHistory, nodefault};
	__property bool AutoSynchronize = {read=FAutoSynchronize, write=FAutoSynchronize, nodefault};
	__property bool FileLookup = {read=FFileLookup, write=FFileLookup, nodefault};
	__property TLUPersist* LookupPersist = {read=FLUPersist, write=SetLUPersist};
	__property bool MatchCase = {read=FMatchCase, write=FMatchCase, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvLUEdit(HWND ParentWindow) : Advedit::TAdvEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x4;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advlued */
using namespace Advlued;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvluedHPP
