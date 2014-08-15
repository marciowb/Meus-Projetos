// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Sysmon.pas' rev: 21.00

#ifndef SysmonHPP
#define SysmonHPP

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

//-- user supplied -----------------------------------------------------------

namespace Sysmon
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMonObject;
class PASCALIMPLEMENTATION TMonObject : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool fDiff;
	int fDiffTime;
	int fDiffValue;
	System::UnicodeString fSysObject;
	System::UnicodeString fCounter;
	bool fMonBusy;
	int __fastcall GetValue(void);
	System::UnicodeString __fastcall GetName(void);
	bool __fastcall GetDiff(void);
	void __fastcall SetSysObject(const System::UnicodeString value);
	void __fastcall SetCounter(const System::UnicodeString value);
	
public:
	__fastcall virtual TMonObject(Classes::TCollection* Collection);
	__fastcall virtual ~TMonObject(void);
	void __fastcall MonStart(void);
	void __fastcall MonStop(void);
	__property int Value = {read=GetValue, nodefault};
	__property System::UnicodeString Name = {read=GetName};
	__property bool Differential = {read=GetDiff, nodefault};
	
__published:
	__property System::UnicodeString SysObject = {read=fSysObject, write=SetSysObject};
	__property System::UnicodeString Counter = {read=fCounter, write=SetCounter};
};


class DELPHICLASS TMonCollection;
class DELPHICLASS TSysMon;
class PASCALIMPLEMENTATION TMonCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TSysMon* fOwner;
	HIDESBASE TMonObject* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TMonObject* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TMonCollection(TSysMon* aOwner);
	HIDESBASE TMonObject* __fastcall Add(void);
	HIDESBASE TMonObject* __fastcall Insert(int index);
	__property TMonObject* Items[int Index] = {read=GetItem, write=SetItem};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TMonCollection(void) { }
	
};


class PASCALIMPLEMENTATION TSysMon : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TMonCollection* fMonitors;
	Classes::TStrings* fResultList;
	System::UnicodeString fMachine;
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TSysMon(Classes::TComponent* aOwner);
	__fastcall virtual ~TSysMon(void);
	Classes::TStrings* __fastcall SysObjects(void);
	Classes::TStrings* __fastcall Counters(System::UnicodeString SysObject);
	
__published:
	__property TMonCollection* Monitors = {read=fMonitors, write=fMonitors};
	__property System::UnicodeString Machine = {read=fMachine, write=fMachine};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Sysmon */
using namespace Sysmon;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SysmonHPP
