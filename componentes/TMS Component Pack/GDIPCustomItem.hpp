// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipcustomitem.pas' rev: 21.00

#ifndef GdipcustomitemHPP
#define GdipcustomitemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipcustomitem
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWinControlAccess;
class PASCALIMPLEMENTATION TWinControlAccess : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinControlAccess(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinControlAccess(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinControlAccess(void) { }
	
};


class DELPHICLASS TPictureContainerListItem;
class PASCALIMPLEMENTATION TPictureContainerListItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	Advgdip::TAdvGDIPPicture* FPicture;
	
public:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=FPicture};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TPictureContainerListItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TPictureContainerListItem(void) { }
	
};


class DELPHICLASS TPictureContainerList;
class PASCALIMPLEMENTATION TPictureContainerList : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	HIDESBASE TPictureContainerListItem* __fastcall Add(void);
public:
	/* TCollection.Create */ inline __fastcall TPictureContainerList(Classes::TCollectionItemClass ItemClass) : Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TPictureContainerList(void) { }
	
};


__interface IPictureContainerSupport;
typedef System::DelphiInterface<IPictureContainerSupport> _di_IPictureContainerSupport;
__interface  INTERFACE_UUID("{AF45F542-068A-46A9-90C2-BF39003D3A46}") IPictureContainerSupport  : public System::IInterface 
{
	
public:
	virtual void __fastcall FillPictureNames(Classes::TGetStrProc Proc) = 0 ;
	virtual void __fastcall GetPictures(TPictureContainerList* APictureList) = 0 ;
};

__interface IGDIPBase;
typedef System::DelphiInterface<IGDIPBase> _di_IGDIPBase;
class DELPHICLASS TCustomItem;
__interface  INTERFACE_UUID("{02295790-46AF-4227-AEF8-7C22AC0CD8BA}") IGDIPBase  : public System::IInterface 
{
	
public:
	virtual void __fastcall ReadItemState(Classes::TReader* Reader, TCustomItem* Item) = 0 ;
	virtual void __fastcall SetItemParentComponent(Classes::TComponent* AParent, TCustomItem* Item) = 0 ;
};

__interface IGDIPGlobalCheck;
typedef System::DelphiInterface<IGDIPGlobalCheck> _di_IGDIPGlobalCheck;
__interface  INTERFACE_UUID("{BA9B81B1-5DCF-4265-97EA-BF480A4DFF3A}") IGDIPGlobalCheck  : public System::IInterface 
{
	
public:
	virtual void __fastcall GlobalCheck(TCustomItem* Item) = 0 ;
};

__interface IGDIPAnchor;
typedef System::DelphiInterface<IGDIPAnchor> _di_IGDIPAnchor;
__interface  INTERFACE_UUID("{CBFF4B08-283E-4EC3-9E5E-FF013733C8C7}") IGDIPAnchor  : public System::IInterface 
{
	
public:
	virtual void __fastcall Anchor(System::UnicodeString Anchor) = 0 ;
};

__interface IGDIPExpand;
typedef System::DelphiInterface<IGDIPExpand> _di_IGDIPExpand;
__interface  INTERFACE_UUID("{B61DA022-0C88-4D88-9117-E579D0B8FC3A}") IGDIPExpand  : public System::IInterface 
{
	
public:
	virtual void __fastcall Expand(TCustomItem* Item, bool Expand) = 0 ;
};

#pragma option push -b-
enum TItemLocation { tlTopLeft, tlTopCenter, tlTopRight, tlCenterLeft, tlCenterCenter, tlCenterRight, tlBottomLeft, tlBottomCenter, tlBottomRight, tlCustom };
#pragma option pop

#pragma option push -b-
enum TItemLineLocation { llLeft, llTop, llRight, llBottom };
#pragma option pop

typedef Set<TItemLineLocation, llLeft, llBottom>  TItemLineLocations;

#pragma option push -b-
enum TItemState { isNormal, isDown, isHovered, isSelected };
#pragma option pop

typedef Set<TItemState, isNormal, isSelected>  TItemStates;

#pragma option push -b-
enum TStatusState { ssNormal, ssDown, ssHovered };
#pragma option pop

typedef void __fastcall (__closure *TItemIndexEvent)(System::TObject* Sender, TCustomItem* Item, int OldIndex, int NewIndex);

typedef void __fastcall (__closure *TItemEvent)(System::TObject* Sender, TCustomItem* Item);

typedef void __fastcall (__closure *TItemSelectEvent)(System::TObject* Sender, TCustomItem* Item, bool &Allow);

typedef void __fastcall (__closure *TItemCheckEvent)(System::TObject* Sender, TCustomItem* Item, bool Checked);

#pragma option push -b-
enum TItemStatusPosition { spItemRectangle, spItemText };
#pragma option pop

typedef void __fastcall (__closure *TItemDrawEvent)(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, TCustomItem* Item, const Advgdip::TGPRectF &ARect);

typedef void __fastcall (__closure *TItemHintEvent)(System::TObject* Sender, TCustomItem* Item, System::UnicodeString &Hint);

#pragma option push -b-
enum TItemInteractionType { itNone, itDefault, itExpander, itButton, itStatus, itGraphic };
#pragma option pop

#pragma option push -b-
enum TItemLevelStatus { hsWithinMainLevel, hsAll };
#pragma option pop

struct TItemInteraction
{
	
public:
	TCustomItem* InteractionItem;
	TItemInteractionType InteractionType;
};


struct TItemAppearance
{
	
public:
	Gdipfill::TGDIPFill* Disabled;
	Gdipfill::TGDIPFill* Normal;
	Gdipfill::TGDIPFill* Down;
	Gdipfill::TGDIPFill* Hover;
	Gdipfill::TGDIPFill* Selected;
	Gdipfill::TGDIPFill* ButtonDisabled;
	Gdipfill::TGDIPFill* ButtonNormal;
	Gdipfill::TGDIPFill* ButtonDown;
	Gdipfill::TGDIPFill* ButtonHover;
	Gdipfill::TGDIPFill* ButtonSelected;
	Graphics::TFont* DisabledFont;
	Graphics::TFont* NormalFont;
	Graphics::TFont* DownFont;
	Graphics::TFont* HoverFont;
	Graphics::TFont* SelectedFont;
	bool Focus;
	int FocusedItem;
	Gdippicturecontainer::TGDIPPictureContainer* PictureContainer;
	Imglist::TCustomImageList* ImageList;
};


class DELPHICLASS TItemStatus;
class PASCALIMPLEMENTATION TItemStatus : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Advgdip::TGPRectF FStatusRect;
	TCustomItem* FOwner;
	int FOffsetTop;
	int FOffsetLeft;
	bool FVisible;
	System::UnicodeString FCaption;
	Gdipfill::TGDIPStatus* FAppearance;
	Classes::TNotifyEvent FOnChange;
	TItemStatusPosition FPosition;
	System::UnicodeString FHint;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetOffsetLeft(const int Value);
	void __fastcall SetOffsetTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetAppearance(const Gdipfill::TGDIPStatus* Value);
	void __fastcall SetPosition(const TItemStatusPosition Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	
public:
	__fastcall TItemStatus(TCustomItem* AOwner);
	__fastcall virtual ~TItemStatus(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int OffsetLeft = {read=FOffsetLeft, write=SetOffsetLeft, default=0};
	__property int OffsetTop = {read=FOffsetTop, write=SetOffsetTop, default=0};
	__property Gdipfill::TGDIPStatus* Appearance = {read=FAppearance, write=SetAppearance};
	__property TItemStatusPosition Position = {read=FPosition, write=SetPosition, default=0};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef TMetaClass* TCustomItemClass;

#pragma option push -b-
enum TItemShortCutHintPos { ishpLeft, ishpTop, ishpRight, ishpBottom, ishpCenter, ishpAuto, ishpTopLeft, ishpTopRight, ishpAboveTop, ishpAboveTopLeft, ishpAboveTopRight, ishpBottomLeft, ishpBottomRight, ishpBelowBottom, ishpBelowBottomLeft, ishpBelowBottomRight, ishpBelowBottomCenter };
#pragma option pop

typedef void __fastcall (__closure *TOnItemGetShortCutHintPos)(System::TObject* Sender, TItemShortCutHintPos &ShortCutHintPosition);

class DELPHICLASS TShortCutHintWindow;
class PASCALIMPLEMENTATION TShortCutHintWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	
protected:
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=FColorTo, nodefault};
public:
	/* THintWindow.Create */ inline __fastcall virtual TShortCutHintWindow(Classes::TComponent* AOwner) : Controls::THintWindow(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TShortCutHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TShortCutHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCustomItem : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TShortCutHintWindow* FShortCutHint;
	bool FControlFocused;
	int FUpdateCount;
	Classes::TComponent* FOwner;
	bool FEnabled;
	int FWidth;
	bool FVisible;
	int FHeight;
	Classes::TNotifyEvent FOnChange;
	int FX;
	int FY;
	TItemState FState;
	TItemSelectEvent FOnItemSelect;
	System::TObject* FItemObject;
	int FTag;
	int FIndex;
	TItemStatus* FStatus;
	int FLevel;
	Gdipfill::TGlowMode FGlow;
	TStatusState FStatusState;
	TItemDrawEvent FOnItemEndDraw;
	TItemDrawEvent FOnItemStartDraw;
	TItemDrawEvent FOnInternalItemStartDraw;
	TItemDrawEvent FOnInternalItemEndDraw;
	TItemSelectEvent FOnInternalItemSelect;
	System::UnicodeString FHint;
	Controls::TWinControl* FControl;
	Controls::TMargins* FControlMargin;
	bool FControlStretched;
	TItemLocation FControlLocation;
	bool FReadOnly;
	int FRowIndex;
	int FColumnIndex;
	Classes::TNotifyEvent FOnRefresh;
	Classes::TNotifyEvent FOnInternalRefresh;
	TItemIndexEvent FOnInternalIndexChange;
	Graphics::TColor FGlowGradientColor;
	Graphics::TColor FGlowRadialColor;
	TItemHintEvent FOnItemHint;
	TItemHintEvent FOnItemStatusHint;
	TItemHintEvent FOnInternalItemStatusHint;
	TItemHintEvent FOnInternalItemHint;
	TItemCheckEvent FOnGlobalCheckChanged;
	TItemEvent FOnItemClick;
	TItemEvent FOnInternalItemClick;
	TItemEvent FOnItemDblClick;
	TItemEvent FOnInternalItemDblClick;
	bool FSelectable;
	TItemSelectEvent FOnInternalItemDeSelect;
	TItemSelectEvent FOnItemDeSelect;
	bool FItemFocused;
	bool FTabStop;
	TOnItemGetShortCutHintPos FOnGetShortCutHintPos;
	TItemShortCutHintPos FShortCutHintPos;
	System::UnicodeString FShortCutHintText;
	TItemEvent FOnInternalFocus;
	TItemEvent FOnInternalDestroy;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetX(const int Value);
	void __fastcall SetY(const int Value);
	void __fastcall SetState(const TItemState Value);
	void __fastcall SetStatus(const TItemStatus* Value);
	void __fastcall SetStatusState(const TStatusState Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetControlLocation(const TItemLocation Value);
	void __fastcall SetControlMargin(const Controls::TMargins* Value);
	void __fastcall SetControlStretched(const bool Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetIndex(const int Value);
	void __fastcall SetControl(const Controls::TWinControl* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetSelectable(const bool Value);
	void __fastcall SetItemFocused(const bool Value);
	void __fastcall SetTabStop(const bool Value);
	void __fastcall SetShortCutHintPos(const TItemShortCutHintPos Value);
	void __fastcall SetShortCutHintText(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall DrawStatus(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const TItemAppearance &ItemAppearance);
	virtual void __fastcall DrawFocus(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &ARect, const TItemAppearance &ItemAppearance);
	virtual void __fastcall Changed(void);
	void __fastcall RefreshObject(void);
	void __fastcall StatusChanged(System::TObject* Sender);
	void __fastcall ControlMarginChanged(System::TObject* Sender);
	Gdipfill::TGDIPFill* __fastcall GetFill(const TItemAppearance &AItemAppearance);
	Graphics::TFont* __fastcall GetFont(const TItemAppearance &AItemAppearance);
	virtual void __fastcall DoInternalIndexChange(System::TObject* Sender, TCustomItem* Item, int OldIndex, int NewIndex);
	virtual void __fastcall DoRefresh(System::TObject* Sender);
	virtual void __fastcall DoInternalRefresh(System::TObject* Sender);
	virtual void __fastcall DoChange(System::TObject* Sender);
	void __fastcall DoControlExit(System::TObject* Sender);
	virtual void __fastcall DoItemHint(System::TObject* Sender, TCustomItem* Item, System::UnicodeString &Hint);
	virtual void __fastcall DoItemStatusHint(System::TObject* Sender, TCustomItem* Item, System::UnicodeString &StatusHint);
	virtual void __fastcall DoItemSelect(System::TObject* Sender, TCustomItem* Item, bool &Allow);
	virtual void __fastcall DoItemDeSelect(System::TObject* Sender, TCustomItem* Item, bool &Allow);
	virtual void __fastcall DoItemClick(System::TObject* Sender, TCustomItem* Item);
	virtual void __fastcall DoItemDblClick(System::TObject* Sender, TCustomItem* Item);
	virtual void __fastcall DoItemStartDraw(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, TCustomItem* Item, const Advgdip::TGPRectF &ARect);
	virtual void __fastcall DoItemEndDraw(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, TCustomItem* Item, const Advgdip::TGPRectF &ARect);
	virtual void __fastcall DoInternalChange(System::TObject* Sender);
	void __fastcall DoInternalFocus(TCustomItem* Item);
	virtual void __fastcall DoInternalItemSelect(System::TObject* Sender, TCustomItem* Item, bool &Allow);
	virtual void __fastcall DoInternalItemDeSelect(System::TObject* Sender, TCustomItem* Item, bool &Allow);
	virtual void __fastcall DoInternalItemClick(System::TObject* Sender, TCustomItem* Item);
	virtual void __fastcall DoInternalItemDblClick(System::TObject* Sender, TCustomItem* Item);
	virtual void __fastcall DoInternalItemStartDraw(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, TCustomItem* Item, const Advgdip::TGPRectF &ARect);
	virtual void __fastcall DoInternalItemEndDraw(System::TObject* Sender, Advgdip::TGPGraphics* AGraphics, TCustomItem* Item, const Advgdip::TGPRectF &ARect);
	virtual void __fastcall DoInternalItemHint(System::TObject* Sender, TCustomItem* Item, System::UnicodeString &Hint);
	virtual void __fastcall DoInternalItemStatusHint(System::TObject* Sender, TCustomItem* Item, System::UnicodeString &StatusHint);
	void __fastcall DoInternalItemDestroy(System::TObject* Sender, TCustomItem* Item);
	virtual void __fastcall DoGlobalCheckChanged(System::TObject* Sender, TCustomItem* Item, bool Checked);
	virtual int __fastcall GetVersionNr(void);
	
public:
	virtual TCustomItem* __fastcall CreateNewItem(Classes::TComponent* AOwner);
	virtual Classes::TComponentClass __fastcall GetClassType(void);
	__classmethod virtual System::UnicodeString __fastcall CustomClassName();
	__classmethod virtual bool __fastcall Display();
	virtual void __fastcall Draw(Advgdip::TGPGraphics* g, const TItemAppearance &ItemAppearance);
	virtual void __fastcall DrawInRect(Advgdip::TGPGraphics* g, const TItemAppearance &ItemAppearance, const Advgdip::TGPRectF &R);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	virtual bool __fastcall IsSection(void);
	virtual void __fastcall UseCaption(System::UnicodeString ACaption);
	Controls::TWinControl* __fastcall GetCustomControlOwner(Classes::TComponent* AOwner);
	void __fastcall ApplyIndex(int AIndex);
	__fastcall virtual TCustomItem(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomItem(void);
	virtual void __fastcall ClearItemState(void);
	virtual void __fastcall AssignEvents(TCustomItem* Item);
	virtual void __fastcall DoCMMouseLeave(Messages::TMessage &Message);
	virtual void __fastcall DoCMHintShow(Messages::TMessage &Message, const TItemInteraction &Interaction);
	virtual void __fastcall DoMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const TItemInteraction &Interaction, const TItemAppearance &ItemAppearance);
	virtual void __fastcall DoDblClick(System::TObject* Sender, const TItemInteraction &Interaction, const TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int pX, int pY, const TItemInteraction &Interaction, const TItemAppearance &ItemAppearance);
	virtual void __fastcall DoMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int pX, int pY, const TItemInteraction &Interaction, const TItemAppearance &ItemAppearance);
	virtual void __fastcall DoKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall DoKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	virtual bool __fastcall IsItemAtXY(int pX, int pY);
	virtual bool __fastcall IsStatusAtXY(int pX, int pY);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	DYNAMIC void __fastcall SetParentComponent(Classes::TComponent* AParent);
	virtual TItemInteractionType __fastcall GetItemInteraction(int pX, int pY);
	DYNAMIC bool __fastcall HasParent(void);
	DYNAMIC Classes::TComponent* __fastcall GetParentComponent(void);
	__property Classes::TComponent* ItemOwner = {read=FOwner, write=FOwner};
	__property TStatusState StatusState = {read=FStatusState, write=SetStatusState, nodefault};
	__property TItemState State = {read=FState, write=SetState, default=0};
	__property TItemCheckEvent OnGlobalCheckChanged = {read=FOnGlobalCheckChanged, write=FOnGlobalCheckChanged};
	__property TItemEvent OnInternalFocus = {read=FOnInternalFocus, write=FOnInternalFocus};
	__property TItemIndexEvent OnInternalIndexChange = {read=FOnInternalIndexChange, write=FOnInternalIndexChange};
	__property Classes::TNotifyEvent OnInternalRefresh = {read=FOnInternalRefresh, write=FOnInternalRefresh};
	__property Classes::TNotifyEvent OnInternalChange = {read=FOnChange, write=FOnChange};
	__property TItemSelectEvent OnInternalItemSelect = {read=FOnInternalItemSelect, write=FOnInternalItemSelect};
	__property TItemSelectEvent OnInternalItemDeSelect = {read=FOnInternalItemDeSelect, write=FOnInternalItemDeSelect};
	__property TItemEvent OnInternalDestroy = {read=FOnInternalDestroy, write=FOnInternalDestroy};
	__property TItemEvent OnInternalItemClick = {read=FOnInternalItemClick, write=FOnInternalItemClick};
	__property TItemEvent OnInternalItemDblClick = {read=FOnInternalItemDblClick, write=FOnInternalItemDblClick};
	__property TItemDrawEvent OnInternalItemStartDraw = {read=FOnInternalItemStartDraw, write=FOnInternalItemStartDraw};
	__property TItemDrawEvent OnInternalItemEndDraw = {read=FOnInternalItemEndDraw, write=FOnInternalItemEndDraw};
	__property TItemHintEvent OnInternalItemHint = {read=FOnInternalItemHint, write=FOnInternalItemHint};
	__property TItemHintEvent OnInternalItemStatusHint = {read=FOnInternalItemStatusHint, write=FOnInternalItemStatusHint};
	__property TOnItemGetShortCutHintPos OnGetShortCutHintPos = {read=FOnGetShortCutHintPos, write=FOnGetShortCutHintPos};
	__property int RowIndex = {read=FRowIndex, write=FRowIndex, default=-1};
	__property int ColumnIndex = {read=FColumnIndex, write=FColumnIndex, default=-1};
	void __fastcall FillPictureNames(Classes::TGetStrProc Proc);
	TPictureContainerList* __fastcall GetPictures(void);
	virtual void __fastcall InitDesignTime(void);
	virtual void __fastcall CancelTab(void);
	virtual bool __fastcall ProcessTab(bool Backwards);
	virtual void __fastcall ResetTab(void);
	__property bool ItemFocused = {read=FItemFocused, write=SetItemFocused, default=1};
	virtual bool __fastcall IsFocusable(void);
	virtual bool __fastcall FirstTab(bool Backwards);
	void __fastcall ShowShortCutHint(void);
	void __fastcall HideShortCutHint(void);
	
__published:
	__property int X = {read=FX, write=SetX, default=0};
	__property int Y = {read=FY, write=SetY, default=0};
	__property int Height = {read=FHeight, write=SetHeight, default=30};
	__property int Width = {read=FWidth, write=SetWidth, default=75};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property System::TObject* ItemObject = {read=FItemObject, write=FItemObject};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property int Level = {read=FLevel, write=FLevel, nodefault};
	__property int Index = {read=FIndex, write=SetIndex, nodefault};
	__property TItemStatus* Status = {read=FStatus, write=SetStatus};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnRefresh = {read=FOnRefresh, write=FOnRefresh};
	__property TItemHintEvent OnItemHint = {read=FOnItemHint, write=FOnItemHint};
	__property TItemHintEvent OnItemStatusHint = {read=FOnItemStatusHint, write=FOnItemStatusHint};
	__property TItemSelectEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property TItemEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TItemEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property TItemDrawEvent OnItemStartDraw = {read=FOnItemStartDraw, write=FOnItemStartDraw};
	__property TItemDrawEvent OnItemEndDraw = {read=FOnItemEndDraw, write=FOnItemEndDraw};
	__property TItemSelectEvent OnItemDeSelect = {read=FOnItemDeSelect, write=FOnItemDeSelect};
	__property Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property Controls::TMargins* ControlMargin = {read=FControlMargin, write=SetControlMargin};
	__property TItemLocation ControlLocation = {read=FControlLocation, write=SetControlLocation, default=3};
	__property bool ControlStretched = {read=FControlStretched, write=SetControlStretched, default=0};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property bool Selectable = {read=FSelectable, write=SetSelectable, default=1};
	__property bool TabStop = {read=FTabStop, write=SetTabStop, default=1};
	__property System::UnicodeString Version = {read=GetVersion};
	__property System::UnicodeString ShortCutHint = {read=FShortCutHintText, write=SetShortCutHintText};
	__property TItemShortCutHintPos ShortCutHintPos = {read=FShortCutHintPos, write=SetShortCutHintPos, default=1};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall Register(void);
extern PACKAGE void __fastcall RegisterPolyItem(TCustomItemClass AItem);
extern PACKAGE bool __fastcall RectanglesInterSect(const Advgdip::TGPRectF &r1, const Advgdip::TGPRectF &r2);
extern PACKAGE void __fastcall LoadFromRes(System::UnicodeString resname, Advgdip::TAdvGDIPPicture* picture);
extern PACKAGE bool __fastcall PtInGPRect(const Advgdip::TGPRectF &r, const Types::TPoint &pt);
extern PACKAGE void __fastcall GetObjectLocation(double &pX, double &pY, const Advgdip::TGPRectF &rectangle, double objectwidth, double objectheight, TItemLocation location);

}	/* namespace Gdipcustomitem */
using namespace Gdipcustomitem;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipcustomitemHPP
