// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvlst.pas' rev: 21.00

#ifndef DbadvlstHPP
#define DbadvlstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Advlistv.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvlst
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EDBAdvListviewError;
class PASCALIMPLEMENTATION EDBAdvListviewError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EDBAdvListviewError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EDBAdvListviewError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EDBAdvListviewError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EDBAdvListviewError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EDBAdvListviewError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EDBAdvListviewError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDBAdvListviewError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDBAdvListviewError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EDBAdvListviewError(void) { }
	
};


typedef StaticArray<int, 256> TColWidthArray;

class DELPHICLASS TListViewField;
class PASCALIMPLEMENTATION TListViewField : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FFieldName;
	System::UnicodeString FTitle;
	Graphics::TColor FColor;
	Graphics::TColor FHighLight;
	Graphics::TFont* FFont;
	void __fastcall SetTitle(const System::UnicodeString value);
	void __fastcall SetColor(const Graphics::TColor value);
	void __fastcall SetFont(const Graphics::TFont* value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetFieldName(const System::UnicodeString value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TListViewField(Classes::TCollection* Collection);
	__fastcall virtual ~TListViewField(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString FieldName = {read=FFieldName, write=SetFieldName};
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor HighLight = {read=FHighLight, write=FHighLight, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class DELPHICLASS TListViewFields;
class DELPHICLASS TDBAdvListView;
class PASCALIMPLEMENTATION TListViewFields : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
private:
	TDBAdvListView* FOwner;
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	void __fastcall UpdateListView(void);
	void __fastcall UpdateListViewData(void);
	
public:
	__fastcall TListViewFields(TDBAdvListView* AOwner);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	HIDESBASE TListViewField* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TListViewField* Value);
	HIDESBASE TListViewField* __fastcall Add(void);
	HIDESBASE TListViewField* __fastcall Insert(int Index);
	__property TListViewField* Items[int Index] = {read=GetItem, write=SetItem};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TListViewFields(void) { }
	
};


class DELPHICLASS TAdvListViewDataLink;
class PASCALIMPLEMENTATION TAdvListViewDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBAdvListView* FListView;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall DataSetScrolled(int distance);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall UpdateData(void);
	
public:
	__fastcall TAdvListViewDataLink(TDBAdvListView* AListView);
	__fastcall virtual ~TAdvListViewDataLink(void);
};


class PASCALIMPLEMENTATION TDBAdvListView : public Advlistv::TAdvListView
{
	typedef Advlistv::TAdvListView inherited;
	
private:
	TAdvListViewDataLink* FDataLink;
	bool FDataScroll;
	TListViewFields* FListViewFields;
	bool FCloseWhenLoaded;
	TColWidthArray FColWidths;
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDatasource(Db::TDataSource* Value);
	void __fastcall SetCloseWhenLoaded(bool Value);
	void __fastcall SetListViewFields(TListViewFields* value);
	void __fastcall SaveColWidths(void);
	void __fastcall LoadColWidths(void);
	void __fastcall ClearColWidths(void);
	bool __fastcall CheckDataSet(void);
	bool __fastcall CheckDataSetAttached(void);
	
protected:
	void __fastcall UpdateCell(int i);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall QueryDrawProp(int Item, int Subitem, Windows::TOwnerDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont, System::UnicodeString ItemText);
	__property bool CloseWhenLoaded = {read=FCloseWhenLoaded, write=SetCloseWhenLoaded, nodefault};
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SelectionChanged(int iItem);
	
public:
	__fastcall virtual TDBAdvListView(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvListView(void);
	void __fastcall LoadFromDataSource(void);
	
__published:
	__property Db::TDataSource* Datasource = {read=GetDataSource, write=SetDatasource};
	__property bool DataScroll = {read=FDataScroll, write=FDataScroll, nodefault};
	__property TListViewFields* Fields = {read=FListViewFields, write=SetListViewFields};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvListView(HWND ParentWindow) : Advlistv::TAdvListView(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Byte MAX_FIELDS = 0xff;

}	/* namespace Dbadvlst */
using namespace Dbadvlst;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvlstHPP
