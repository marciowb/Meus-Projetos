// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Dbinspectorbar.pas' rev: 21.00

#ifndef DbinspectorbarHPP
#define DbinspectorbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Inspectorbar.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Dbctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Jpeg.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Dbinspectorbar
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TDBInspectorItem;
class PASCALIMPLEMENTATION TDBInspectorItem : public Inspectorbar::TInspectorItem
{
	typedef Inspectorbar::TInspectorItem inherited;
	
private:
	Dbctrls::TFieldDataLink* FDataLink;
	bool FPictureField;
	System::UnicodeString __fastcall GetDataField(void);
	void __fastcall SetDataField(const System::UnicodeString Value);
	void __fastcall DataUpdate(System::TObject* Sender);
	void __fastcall DataChange(System::TObject* Sender);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	void __fastcall SetPictureField(const bool Value);
	
protected:
	virtual void __fastcall EditStart(void);
	virtual void __fastcall EditStop(void);
	virtual void __fastcall EditChange(void);
	
public:
	__fastcall virtual TDBInspectorItem(Classes::TCollection* Collection);
	__fastcall virtual ~TDBInspectorItem(void);
	virtual void __fastcall Update(void);
	
__published:
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property bool PictureField = {read=FPictureField, write=SetPictureField, nodefault};
};


class DELPHICLASS TDBInspectorItems;
class PASCALIMPLEMENTATION TDBInspectorItems : public Inspectorbar::TInspectorItems
{
	typedef Inspectorbar::TInspectorItems inherited;
	
public:
	TDBInspectorItem* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TDBInspectorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TDBInspectorItem* Value);
	
public:
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	HIDESBASE TDBInspectorItem* __fastcall Add(void);
	HIDESBASE TDBInspectorItem* __fastcall Insert(int index);
	__property TDBInspectorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TInspectorItems.Create */ inline __fastcall TDBInspectorItems(Inspectorbar::TInspectorPanel* AOwner) : Inspectorbar::TInspectorItems(AOwner) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDBInspectorItems(void) { }
	
};


#pragma option push -b-
enum TNavigateBtn { nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel, nbRefresh };
#pragma option pop

typedef Set<TNavigateBtn, nbFirst, nbRefresh>  TButtonSet;

#pragma option push -b-
enum TButtonStyle { bsDefault, bsGlyphs };
#pragma option pop

class DELPHICLASS TDBInspectorNavigator;
class PASCALIMPLEMENTATION TDBInspectorNavigator : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TButtonSet FVisibleButtons;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FHoverButtonColor;
	Graphics::TColor FHoverButtonDownColor;
	Classes::TStringList* FHints;
	TButtonStyle FButtonStyle;
	int FButtonSize;
	void __fastcall SetVisible(const TButtonSet Value);
	void __fastcall SetHints(const Classes::TStringList* Value);
	void __fastcall SetButtonStyle(const TButtonStyle Value);
	void __fastcall SetButtonSize(const int Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TDBInspectorNavigator(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBInspectorNavigator(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property int ButtonSize = {read=FButtonSize, write=SetButtonSize, nodefault};
	__property TButtonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, nodefault};
	__property Classes::TStringList* Hints = {read=FHints, write=SetHints};
	__property Graphics::TColor HoverButtonColor = {read=FHoverButtonColor, write=FHoverButtonColor, default=536870911};
	__property Graphics::TColor HoverButtonDownColor = {read=FHoverButtonDownColor, write=FHoverButtonDownColor, default=536870911};
	__property TButtonSet VisibleButtons = {read=FVisibleButtons, write=SetVisible, default=1023};
};


class DELPHICLASS TInspectorDataLink;
class DELPHICLASS TDBInspectorPanel;
class PASCALIMPLEMENTATION TInspectorDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	TDBInspectorPanel* FPanel;
	
protected:
	virtual void __fastcall ActiveChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall EditingChanged(void);
	
public:
	__fastcall TInspectorDataLink(TDBInspectorPanel* APanel);
	__fastcall virtual ~TInspectorDataLink(void);
};


class PASCALIMPLEMENTATION TDBInspectorPanel : public Inspectorbar::TInspectorPanel
{
	typedef Inspectorbar::TInspectorPanel inherited;
	
private:
	TInspectorDataLink* FDataLink;
	Db::TDataSource* FDataSource;
	bool FAllFields;
	bool FShowNavigator;
	bool FBtnFrwd;
	bool FBtnPost;
	bool FBtnInsDel;
	bool FBtnBack;
	bool FBtnEdit;
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall SetAllFields(const bool Value);
	void __fastcall SetShowNavigator(const bool Value);
	
protected:
	bool __fastcall BackEnabled(void);
	bool __fastcall FrwdEnabled(void);
	bool __fastcall EditEnabled(void);
	bool __fastcall PostEnabled(void);
	bool __fastcall InsDelEnabled(void);
	__property bool BtnBack = {read=FBtnBack, write=FBtnBack, nodefault};
	__property bool BtnFrwd = {read=FBtnFrwd, write=FBtnFrwd, nodefault};
	__property bool BtnEdit = {read=FBtnEdit, write=FBtnEdit, nodefault};
	__property bool BtnPost = {read=FBtnPost, write=FBtnPost, nodefault};
	__property bool BtnInsDel = {read=FBtnInsDel, write=FBtnInsDel, nodefault};
	
public:
	__fastcall virtual TDBInspectorPanel(Classes::TCollection* Collection);
	__fastcall virtual ~TDBInspectorPanel(void);
	virtual Inspectorbar::TInspectorItems* __fastcall CreateItems(void);
	
__published:
	__property bool AllFields = {read=FAllFields, write=SetAllFields, nodefault};
	__property Db::TDataSource* DataSource = {read=FDataSource, write=SetDataSource};
	__property bool ShowNavigator = {read=FShowNavigator, write=SetShowNavigator, nodefault};
};


class DELPHICLASS TDBInspectorPanels;
class PASCALIMPLEMENTATION TDBInspectorPanels : public Inspectorbar::TInspectorPanels
{
	typedef Inspectorbar::TInspectorPanels inherited;
	
public:
	TDBInspectorPanel* operator[](int Index) { return Items[Index]; }
	
private:
	HIDESBASE TDBInspectorPanel* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TDBInspectorPanel* Value);
	
public:
	virtual Classes::TCollectionItemClass __fastcall CreateItemClass(void);
	HIDESBASE TDBInspectorPanel* __fastcall Add(void);
	HIDESBASE TDBInspectorPanel* __fastcall Insert(int index);
	__property TDBInspectorPanel* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TInspectorPanels.Create */ inline __fastcall TDBInspectorPanels(Inspectorbar::TInspectorBar* AOwner) : Inspectorbar::TInspectorPanels(AOwner) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TDBInspectorPanels(void) { }
	
};


class DELPHICLASS TDBInspectorBar;
class PASCALIMPLEMENTATION TDBInspectorBar : public Inspectorbar::TInspectorBar
{
	typedef Inspectorbar::TInspectorBar inherited;
	
private:
	TDBInspectorNavigator* FNavigator;
	bool FShowMemoFields;
	bool FShowPictureFields;
	Extctrls::TTimer* FRepeatTimer;
	int FInitRepeatPause;
	int FRepeatPause;
	int FRepeatBtn;
	Types::TRect FRepeatBtnRect;
	TDBInspectorPanel* FRepeatDBPanel;
	void __fastcall TimerExpired(System::TObject* Sender);
	TDBInspectorPanels* __fastcall GetPanels(void);
	void __fastcall SetPanels(const TDBInspectorPanels* Value);
	void __fastcall SetShowMemoFields(const bool Value);
	void __fastcall RefreshItemsValue(void);
	void __fastcall SetShowPictureFields(const bool Value);
	
protected:
	int __fastcall NaviWidth(void);
	virtual void __fastcall DrawCaptionOptions(Inspectorbar::TInspectorPanel* Panel, Graphics::TCanvas* Canvas, Types::TRect &R);
	virtual bool __fastcall MouseDownCaptionOptions(Inspectorbar::TInspectorPanel* Panel, int x, int y);
	virtual bool __fastcall MouseMoveCaptionOptions(Inspectorbar::TInspectorPanel* Panel, int x, int y);
	virtual bool __fastcall HintCaptionOptions(Inspectorbar::TInspectorPanel* Panel, int x, int y, System::UnicodeString &Hint);
	void __fastcall NavigatorChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TDBInspectorBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBInspectorBar(void);
	virtual Inspectorbar::TInspectorPanels* __fastcall CreatePanels(void);
	virtual void __fastcall StartEdit(Inspectorbar::TInspectorItem* InspectorItem);
	virtual void __fastcall StopEdit(Inspectorbar::TInspectorItem* InspectorItem);
	virtual void __fastcall GetValueList(Inspectorbar::TInspectorItem* InspectorItem, Classes::TStringList* Values);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
__published:
	__property TDBInspectorNavigator* Navigator = {read=FNavigator, write=FNavigator};
	__property TDBInspectorPanels* Panels = {read=GetPanels, write=SetPanels};
	__property bool ShowMemoFields = {read=FShowMemoFields, write=SetShowMemoFields, nodefault};
	__property bool ShowPictureFields = {read=FShowPictureFields, write=SetShowPictureFields, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDBInspectorBar(HWND ParentWindow) : Inspectorbar::TInspectorBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Dbinspectorbar */
using namespace Dbinspectorbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// DbinspectorbarHPP
