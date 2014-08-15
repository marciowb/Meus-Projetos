// CodeGear C++Builder
// Copyright (c) 1995, 2008 by CodeGear
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Templatestore.pas' rev: 20.00

#ifndef TemplatestoreHPP
#define TemplatestoreHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Xlsmessages.hpp>	// Pascal unit
#include <Uflxmessages.hpp>	// Pascal unit
#include <Xlsbasetemplatestore.hpp>	// Pascal unit
#include <Contnrs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Templatestore
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TXlsTemplate;
class PASCALIMPLEMENTATION TXlsTemplate : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Sysutils::TFileName FFileName;
	Uflxmessages::ByteArray FStoredFile;
	System::TDateTime FModifiedDate;
	void __fastcall SetFileName(const Sysutils::TFileName Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName();
	virtual void __fastcall SetDisplayName(const System::UnicodeString Value);
	void __fastcall WriteData(Classes::TStream* Stream);
	void __fastcall ReadData(Classes::TStream* Stream);
	void __fastcall WriteModifiedDate(Classes::TWriter* Writer);
	void __fastcall ReadModifiedDate(Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	bool __fastcall Equal(TXlsTemplate* aTemplate);
	
public:
	__property Uflxmessages::ByteArray StoredFile = {read=FStoredFile};
	__fastcall virtual TXlsTemplate(Classes::TCollection* Collection);
	__fastcall virtual ~TXlsTemplate(void);
	void __fastcall SaveAs(const Sysutils::TFileName aFileName);
	void __fastcall LoadFrom(const Sysutils::TFileName aFileName)/* overload */;
	void __fastcall LoadFrom(const Classes::TStream* aStream)/* overload */;
	__property System::TDateTime ModifiedDate = {read=FModifiedDate};
	
__published:
	__property Sysutils::TFileName FileName = {read=FFileName, write=SetFileName, stored=false};
};


class DELPHICLASS TXlsTemplateList;
class PASCALIMPLEMENTATION TXlsTemplateList : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TXlsTemplate* operator[](int Index) { return Items[Index]; }
	
private:
	TXlsTemplate* __fastcall GetItems(int Index);
	
public:
	__property TXlsTemplate* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TXlsTemplateList(Classes::TPersistent* AOwner, Classes::TCollectionItemClass ItemClass) : Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TXlsTemplateList(void) { }
	
};


class DELPHICLASS TXlsTemplateStore;
class PASCALIMPLEMENTATION TXlsTemplateStore : public Xlsbasetemplatestore::TXlsBaseTemplateStore
{
	typedef Xlsbasetemplatestore::TXlsBaseTemplateStore inherited;
	
private:
	bool FCompress;
	bool FCaseInsensitive;
	System::UnicodeString FRefreshPath;
	void __fastcall SetCompress(const bool Value);
	System::UnicodeString __fastcall DoUp(System::UnicodeString s);
	
protected:
	TXlsTemplateList* FTemplates;
	virtual Uflxmessages::ByteArray __fastcall GetStoredFile(System::UnicodeString Name);
	
public:
	__fastcall virtual TXlsTemplateStore(Classes::TComponent* AOwner);
	__fastcall virtual ~TXlsTemplateStore(void);
	virtual bool __fastcall IsUpToDate(void);
	virtual void __fastcall Refresh(void);
	void __fastcall LoadTemplateFromStream(const Classes::TStream* aStream, const System::UnicodeString aTemplateName);
	
__published:
	__property TXlsTemplateList* Templates = {read=FTemplates, write=FTemplates};
	__property bool Compress = {read=FCompress, write=SetCompress, nodefault};
	__property bool CaseInsensitive = {read=FCaseInsensitive, write=FCaseInsensitive, default=0};
	__property System::UnicodeString RefreshPath = {read=FRefreshPath, write=FRefreshPath};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Templatestore */
using namespace Templatestore;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TemplatestoreHPP
