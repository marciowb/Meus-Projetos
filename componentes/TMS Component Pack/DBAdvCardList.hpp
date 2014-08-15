// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbadvcardlist.pas' rev: 21.00

#ifndef DbadvcardlistHPP
#define DbadvcardlistHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Advcardlist.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Themes.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbadvcardlist
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBAdvCardTemplateItem;
class DELPHICLASS TDBAdvCardTemplate;
class DELPHICLASS TDBAdvCardList;
class PASCALIMPLEMENTATION TDBAdvCardTemplateItem : public Advcardlist::TAdvCardTemplateItem
{
	typedef Advcardlist::TAdvCardTemplateItem inherited;
	
private:
	Db::TField* FField;
	System::UnicodeString FFieldName;
	Db::TField* __fastcall GetField(void);
	void __fastcall SetField(Db::TField* Value);
	void __fastcall SetFieldName(const System::UnicodeString Value);
	
protected:
	HIDESBASE TDBAdvCardTemplate* __fastcall GetTemplate(void);
	HIDESBASE TDBAdvCardList* __fastcall GetCardList(void);
	
public:
	__property TDBAdvCardList* CardList = {read=GetCardList};
	__property TDBAdvCardTemplate* CardTemplate = {read=GetTemplate};
	__property Db::TField* Field = {read=GetField, write=SetField};
	
__published:
	__property System::UnicodeString FieldName = {read=FFieldName, write=SetFieldName};
public:
	/* TAdvCardTemplateItem.Create */ inline __fastcall virtual TDBAdvCardTemplateItem(Classes::TCollection* Collection) : Advcardlist::TAdvCardTemplateItem(Collection) { }
	/* TAdvCardTemplateItem.Destroy */ inline __fastcall virtual ~TDBAdvCardTemplateItem(void) { }
	
};


class DELPHICLASS TDBAdvCardTemplateItems;
class PASCALIMPLEMENTATION TDBAdvCardTemplateItems : public Advcardlist::TAdvCardTemplateItems
{
	typedef Advcardlist::TAdvCardTemplateItems inherited;
	
public:
	TDBAdvCardTemplateItem* operator[](int Index) { return Items[Index]; }
	
private:
	TDBAdvCardTemplate* __fastcall GetCardTemplate(void);
	HIDESBASE TDBAdvCardTemplateItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TDBAdvCardTemplateItem* Value);
	
public:
	HIDESBASE TDBAdvCardTemplateItem* __fastcall Add(void);
	__property TDBAdvCardTemplate* CardTemplate = {read=GetCardTemplate};
	HIDESBASE TDBAdvCardTemplateItem* __fastcall GetItemByName(System::UnicodeString Name);
	HIDESBASE TDBAdvCardTemplateItem* __fastcall Insert(int Index);
	__property TDBAdvCardTemplateItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TAdvCardTemplateItems.Create */ inline __fastcall virtual TDBAdvCardTemplateItems(Advcardlist::TAdvCardTemplate* CardTemplate, Classes::TCollectionItemClass ItemClass) : Advcardlist::TAdvCardTemplateItems(CardTemplate, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDBAdvCardTemplateItems(void) { }
	
};


class PASCALIMPLEMENTATION TDBAdvCardTemplate : public Advcardlist::TAdvCardTemplate
{
	typedef Advcardlist::TAdvCardTemplate inherited;
	
private:
	Db::TField* FField;
	System::UnicodeString FFieldName;
	Db::TField* __fastcall GetField(void);
	TDBAdvCardTemplateItems* __fastcall GetItems(void);
	void __fastcall SetField(Db::TField* Value);
	void __fastcall SetFieldName(const System::UnicodeString Value);
	HIDESBASE void __fastcall SetItems(TDBAdvCardTemplateItems* Value);
	
protected:
	TDBAdvCardList* __fastcall GetCardList(void);
	
public:
	__fastcall TDBAdvCardTemplate(TDBAdvCardList* CardList);
	__property TDBAdvCardList* CardList = {read=GetCardList};
	__property Db::TField* CaptionField = {read=GetField, write=SetField};
	
__published:
	__property System::UnicodeString CaptionFieldName = {read=FFieldName, write=SetFieldName};
	__property TDBAdvCardTemplateItems* Items = {read=GetItems, write=SetItems};
public:
	/* TAdvCardTemplate.Destroy */ inline __fastcall virtual ~TDBAdvCardTemplate(void) { }
	
};


class DELPHICLASS TCardListDataLink;
class PASCALIMPLEMENTATION TCardListDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBAdvCardList* FCardList;
	bool Adjusting;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetScrolled(int Distance);
	virtual void __fastcall RecordChanged(Db::TField* Field);
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	
public:
	__fastcall TCardListDataLink(TDBAdvCardList* ACardList);
	void __fastcall AdjustBuffer(void);
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TCardListDataLink(void) { }
	
};


class PASCALIMPLEMENTATION TDBAdvCardList : public Advcardlist::TCustomAdvCardList
{
	typedef Advcardlist::TCustomAdvCardList inherited;
	
private:
	TCardListDataLink* FDataLink;
	bool CardsUpdating;
	int LockUpdate;
	bool Scrolling;
	bool LastRecordRead;
	Advcardlist::TAdvCardEvent FOnCardUpdate;
	bool FSelChange;
	bool FEditChange;
	void __fastcall CalcScrollBarPosition(int &Pos);
	TDBAdvCardTemplate* __fastcall GetCardTemplate(void);
	Db::TDataSource* __fastcall GetDataSource(void);
	HIDESBASE void __fastcall SetCardTemplate(TDBAdvCardTemplate* Value);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	int __fastcall GetBufferCount(void);
	void __fastcall SetBufferCount(int Value);
	
protected:
	virtual void __fastcall CreateTemplate(Advcardlist::TAdvCards* Cards);
	virtual void __fastcall DataChanged(Advcardlist::TAdvCard* Card, Advcardlist::TAdvCardItem* Item, Advcardlist::TDataChangedObject DataObject);
	void __fastcall RecordChanged(Db::TField* Field);
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall LinkActive(bool Value);
	virtual void __fastcall LocateByChar(System::WideChar Key);
	virtual void __fastcall SelectedChanged(void);
	virtual void __fastcall ColumnSized(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdateItem(Advcardlist::TAdvCard* Card, int ItemIndex);
	void __fastcall UpdateCard(Advcardlist::TAdvCard* Card);
	void __fastcall UpdateDBCards(void);
	virtual void __fastcall UpdateScrollBar(void);
	virtual void __fastcall OnScroll(int &ScrollPos, Stdctrls::TScrollCode ScrollCode);
	virtual bool __fastcall JumpToCard(int Offset, bool ToBegin, bool ToEnd);
	__property TCardListDataLink* DataLink = {read=FDataLink};
	__property int BufferCount = {read=GetBufferCount, write=SetBufferCount, default=5};
	
public:
	__fastcall virtual TDBAdvCardList(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvCardList(void);
	__property Columns;
	__property Cards;
	virtual Advcardlist::TAdvCard* __fastcall FindCard(System::UnicodeString BeginWith);
	__property LeftCol;
	void __fastcall InitTemplate(void);
	void __fastcall StartDBEdit(void);
	void __fastcall StopDBEdit(void);
	
__published:
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TDBAdvCardTemplate* CardTemplate = {read=GetCardTemplate, write=SetCardTemplate};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Enabled = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property HelpContext = {default=0};
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property BiDiMode;
	__property Constraints;
	__property DockOrientation;
	__property ShowHint;
	__property Visible = {default=1};
	__property Left;
	__property Top;
	__property Width;
	__property Height;
	__property Cursor = {default=0};
	__property Hint;
	__property PopupMenu;
	__property AutoEdit = {default=1};
	__property BorderColor = {default=-16777206};
	__property BorderWidth = {default=1};
	__property CardEditingAppearance;
	__property CardNormalAppearance;
	__property CardSelectedAppearance;
	__property CardHoverAppearance;
	__property CardHorSpacing = {default=20};
	__property CardVertSpacing = {default=20};
	__property Color;
	__property ColumnSizing = {default=1};
	__property ColumnWidth = {default=240};
	__property DelayedCardLoad;
	__property DelayedCardLoadInterval;
	__property FocusColor = {default=8421504};
	__property GotoSelectedAutomatic = {default=1};
	__property GridLineColor = {default=-16777201};
	__property GridLineWidth = {default=3};
	__property Images;
	__property MaxColumnWidth = {default=0};
	__property MinColumnWidth = {default=150};
	__property MultiSelect = {default=0};
	__property PageCount = {default=4};
	__property ReadOnly = {default=0};
	__property ScrollBarType = {default=0};
	__property SelectedCount;
	__property ShowGridLine = {default=1};
	__property ShowFocus = {default=1};
	__property ShowScrollBar = {default=1};
	__property URLColor = {default=16711680};
	__property Version;
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnCardStartEdit;
	__property OnCardEndEdit;
	__property OnCardCaptionGetDisplText;
	__property OnCardItemGetDisplText;
	__property OnCardCaptionClick;
	__property OnCardCaptionDblClick;
	__property OnCardClick;
	__property OnCardDblClick;
	__property OnCardItemClick;
	__property OnCardItemURLClick;
	__property Advcardlist::TAdvCardEvent OnCardUpdate = {read=FOnCardUpdate, write=FOnCardUpdate};
	__property OnColumnResizing;
	__property OnDrawCardItem;
	__property OnDrawCardItemProp;
	__property OnShowCardItem;
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBAdvCardList(HWND ParentWindow) : Advcardlist::TCustomAdvCardList(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Dbadvcardlist */
using namespace Dbadvcardlist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbadvcardlistHPP
