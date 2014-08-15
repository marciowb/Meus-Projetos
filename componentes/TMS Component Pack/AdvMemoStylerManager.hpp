// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmemostylermanager.pas' rev: 21.00

#ifndef AdvmemostylermanagerHPP
#define AdvmemostylermanagerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advmemo.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmemostylermanager
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvMemoStylersCollectionItem;
class PASCALIMPLEMENTATION TAdvMemoStylersCollectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::UnicodeString FFileName;
	Advmemo::TAdvCustomMemoStyler* FStyler;
	int FStylerIndex;
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetStyler(const Advmemo::TAdvCustomMemoStyler* Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property int StylerIndex = {read=FStylerIndex, write=FStylerIndex, nodefault};
	__property System::UnicodeString FileName = {read=FFileName, write=FFileName};
	__property Advmemo::TAdvCustomMemoStyler* Styler = {read=FStyler, write=SetStyler};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TAdvMemoStylersCollectionItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TAdvMemoStylersCollectionItem(void) { }
	
};


class DELPHICLASS TAdvMemoStylersCollection;
class DELPHICLASS TAdvMemoStylerManager;
class PASCALIMPLEMENTATION TAdvMemoStylersCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvMemoStylersCollectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvMemoStylerManager* FAdvMemoStylers;
	HIDESBASE TAdvMemoStylersCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TAdvMemoStylersCollectionItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvMemoStylersCollection(TAdvMemoStylerManager* Styler);
	__fastcall virtual ~TAdvMemoStylersCollection(void);
	HIDESBASE TAdvMemoStylersCollectionItem* __fastcall Add(void);
	HIDESBASE TAdvMemoStylersCollectionItem* __fastcall Insert(int Index);
	__property TAdvMemoStylersCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


class PASCALIMPLEMENTATION TAdvMemoStylerManager : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TAdvMemoStylersCollection* FItems;
	int FItemsCount;
	bool FIncludeAllFiles;
	bool FIncludeTextFiles;
	void __fastcall SetItems(TAdvMemoStylersCollection* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* comp, Classes::TOperation Operation);
	
public:
	__fastcall virtual TAdvMemoStylerManager(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMemoStylerManager(void);
	Advmemo::TAdvCustomMemoStyler* __fastcall GetStylerByFileName(System::UnicodeString FileName);
	Advmemo::TAdvCustomMemoStyler* __fastcall GetStylerByName(System::UnicodeString strName);
	Advmemo::TAdvCustomMemoStyler* __fastcall GetStyler(int Idx);
	System::UnicodeString __fastcall GetFilter(int Idx);
	int __fastcall GetStylerNames(Classes::TStrings* &List);
	Classes::TCollectionItem* __fastcall GetStylerItem(int Idx);
	Classes::TCollectionItem* __fastcall GetStylerItemByFileName(System::UnicodeString FileName);
	Classes::TCollectionItem* __fastcall GetStylerItemByName(System::UnicodeString strName);
	int __fastcall GetStylerStyleIndexByInfo(Advmemo::TAdvCustomMemoStyler* styler, System::UnicodeString Info);
	void __fastcall SaveAllStylersToFile(System::UnicodeString FileName);
	void __fastcall LoadAllStylersFromFile(System::UnicodeString FileName);
	void __fastcall SaveStylerToFile(Advmemo::TAdvCustomMemoStyler* Styler, System::UnicodeString FileName);
	void __fastcall LoadStylerFromFile(Advmemo::TAdvCustomMemoStyler* Styler, System::UnicodeString FileName);
	__property int ItemsCount = {read=FItemsCount, write=FItemsCount, nodefault};
	
__published:
	__property TAdvMemoStylersCollection* Items = {read=FItems, write=SetItems};
	__property bool IncludeAllFiles = {read=FIncludeAllFiles, write=FIncludeAllFiles, default=1};
	__property bool IncludeTextFiles = {read=FIncludeTextFiles, write=FIncludeTextFiles, default=1};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advmemostylermanager */
using namespace Advmemostylermanager;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmemostylermanagerHPP
