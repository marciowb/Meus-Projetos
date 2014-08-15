// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Webpost.pas' rev: 21.00

#ifndef WebpostHPP
#define WebpostHPP

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
#include <Wininet.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Webpost
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TWebPostError)(System::TObject* Sender, System::UnicodeString ErrorStr, int ErrorCode);

class DELPHICLASS TWebPostItem;
class PASCALIMPLEMENTATION TWebPostItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::AnsiString FValue;
	System::AnsiString FName;
	
public:
	__fastcall virtual TWebPostItem(Classes::TCollection* Collection);
	
__published:
	__property System::AnsiString Name = {read=FName, write=FName};
	__property System::AnsiString Value = {read=FValue, write=FValue};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TWebPostItem(void) { }
	
};


class DELPHICLASS TWebPostItems;
class PASCALIMPLEMENTATION TWebPostItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	Classes::TComponent* fOwner;
	HIDESBASE TWebPostItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TWebPostItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TWebPostItems(Classes::TComponent* aOwner);
	HIDESBASE TWebPostItem* __fastcall Add(void);
	HIDESBASE TWebPostItem* __fastcall Insert(int index);
	__property TWebPostItem* Items[int Index] = {read=GetItem, write=SetItem};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TWebPostItems(void) { }
	
};


class DELPHICLASS TWebPost;
class PASCALIMPLEMENTATION TWebPost : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FServer;
	System::UnicodeString FAction;
	TWebPostItems* FItems;
	System::UnicodeString FPostResult;
	TWebPostError FOnError;
	int FPort;
	System::AnsiString FAgent;
	int FTimeOut;
	bool FWaitResponse;
	void __fastcall SetItems(const TWebPostItems* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TWebPost(Classes::TComponent* AOwner);
	__fastcall virtual ~TWebPost(void);
	bool __fastcall Execute(void);
	void __fastcall Error(void);
	void __fastcall SaveToFile(System::UnicodeString fn);
	__property System::UnicodeString PostResult = {read=FPostResult};
	
__published:
	__property System::AnsiString Agent = {read=FAgent, write=FAgent};
	__property int Port = {read=FPort, write=FPort, nodefault};
	__property System::UnicodeString Server = {read=FServer, write=FServer};
	__property System::UnicodeString Action = {read=FAction, write=FAction};
	__property TWebPostItems* Items = {read=FItems, write=SetItems};
	__property int TimeOut = {read=FTimeOut, write=FTimeOut, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool WaitResponse = {read=FWaitResponse, write=FWaitResponse, default=1};
	__property TWebPostError OnError = {read=FOnError, write=FOnError};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x4;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Webpost */
using namespace Webpost;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WebpostHPP
