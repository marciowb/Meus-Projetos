// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Webdata.pas' rev: 21.00

#ifndef WebdataHPP
#define WebdataHPP

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
#include <Shellapi.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Wininet.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

#pragma link "wininet.lib"


namespace Webdata
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TWebDataProgressEvent)(System::TObject* Sender, int iItem);

typedef void __fastcall (__closure *TWebDataDataEvent)(System::TObject* Sender, int iItem, System::UnicodeString data);

typedef void __fastcall (__closure *TThreadCollectDoneEvent)(System::TObject* Sender);

typedef void __fastcall (__closure *TCollectErrorEvent)(System::TObject* Sender, int iItem, int errcode);

class DELPHICLASS TWDInetThread;
class DELPHICLASS TWebData;
class PASCALIMPLEMENTATION TWDInetThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TWebData* Webdata;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TWDInetThread(TWebData* awebdata);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TWDInetThread(void) { }
	
};


class DELPHICLASS TWebDataItem;
class PASCALIMPLEMENTATION TWebDataItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FURL;
	System::UnicodeString FScanFirst;
	System::UnicodeString FScanFrom;
	System::UnicodeString FScanTo;
	System::UnicodeString FData;
	bool FSuccess;
	System::UnicodeString FFileName;
	bool FAutoDelete;
	bool FEnable;
	int FTag;
	System::UnicodeString FFullPageCode;
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TWebDataItem(Classes::TCollection* Collection);
	__fastcall virtual ~TWebDataItem(void);
	__property System::UnicodeString Data = {read=FData, write=FData};
	__property System::UnicodeString FullPageCode = {read=FFullPageCode};
	__property bool Success = {read=FSuccess, nodefault};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	
__published:
	__property bool AutoDelete = {read=FAutoDelete, write=FAutoDelete, default=1};
	__property bool Enable = {read=FEnable, write=FEnable, default=1};
	__property System::UnicodeString URL = {read=FURL, write=FURL};
	__property System::UnicodeString ScanFirst = {read=FScanFirst, write=FScanFirst};
	__property System::UnicodeString ScanFrom = {read=FScanFrom, write=FScanFrom};
	__property System::UnicodeString ScanTo = {read=FScanTo, write=FScanTo};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TWebDataCollection;
class PASCALIMPLEMENTATION TWebDataCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TWebDataItem* operator[](int Index) { return Items[Index]; }
	
private:
	TWebData* FOwner;
	HIDESBASE TWebDataItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TWebDataItem* Value);
	
public:
	__fastcall TWebDataCollection(TWebData* aOwner);
	HIDESBASE TWebDataItem* __fastcall Add(void);
	__property TWebDataItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TWebDataCollection(void) { }
	
};


#pragma option push -b-
enum TImageType { itAll, itGIF, itJPG, itPNG };
#pragma option pop

class PASCALIMPLEMENTATION TWebData : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	System::UnicodeString FAgent;
	TImageType FImageType;
	Classes::TStrings* FImageRefs;
	Classes::TStrings* FHyperLinks;
	System::UnicodeString FHyperLinkType;
	System::UnicodeString FProxy;
	System::UnicodeString FProxyUserID;
	System::UnicodeString FProxyPassword;
	bool FSaveToFile;
	TWebDataCollection* FWebDataCollection;
	TWebDataDataEvent FOnData;
	TWebDataProgressEvent FOnProgress;
	TThreadCollectDoneEvent FOnCollectDone;
	TCollectErrorEvent FOnCollectError;
	void __fastcall SetWebDataCollection(const TWebDataCollection* Value);
	System::UnicodeString __fastcall MakeProxyUrl(System::UnicodeString url, System::UnicodeString proxyuser, System::UnicodeString proxypwd);
	bool __fastcall URLGetFile(void * hfile, System::UnicodeString url, System::UnicodeString tgt, int idx);
	bool __fastcall URLGetStream(void * hfile, System::UnicodeString url, int idx, Classes::TMemoryStream* ms);
	void __fastcall ThreadDone(System::TObject* Sender);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TWebData(Classes::TComponent* AOwner);
	__fastcall virtual ~TWebData(void);
	void __fastcall CollectData(void);
	bool __fastcall Execute(void);
	void __fastcall ThreadCollectData(void);
	Classes::TStrings* __fastcall ImageRefs(void);
	Classes::TStrings* __fastcall Hyperlinks(void);
	__property bool SaveToFile = {read=FSaveToFile, write=FSaveToFile, nodefault};
	
__published:
	__property System::UnicodeString Agent = {read=FAgent, write=FAgent};
	__property System::UnicodeString Proxy = {read=FProxy, write=FProxy};
	__property System::UnicodeString ProxyUserID = {read=FProxyUserID, write=FProxyUserID};
	__property System::UnicodeString ProxyPassword = {read=FProxyPassword, write=FProxyPassword};
	__property TWebDataCollection* Data = {read=FWebDataCollection, write=SetWebDataCollection};
	__property TImageType ImageType = {read=FImageType, write=FImageType, nodefault};
	__property System::UnicodeString HyperLinkType = {read=FHyperLinkType, write=FHyperLinkType};
	__property TWebDataProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TWebDataDataEvent OnData = {read=FOnData, write=FOnData};
	__property TThreadCollectDoneEvent OnCollectDone = {read=FOnCollectDone, write=FOnCollectDone};
	__property TCollectErrorEvent OnCollectError = {read=FOnCollectError, write=FOnCollectError};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Webdata */
using namespace Webdata;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WebdataHPP
