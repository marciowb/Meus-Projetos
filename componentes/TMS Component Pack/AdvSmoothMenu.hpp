// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothmenu.pas' rev: 21.00

#ifndef AdvsmoothmenuHPP
#define AdvsmoothmenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothmenu
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvSmoothMenuLocation { plTopLeft, plTopCenter, plTopRight, plCenterLeft, plCenterCenter, plCenterRight, plBottomLeft, plBottomCenter, plBottomRight, plCustom };
#pragma option pop

class DELPHICLASS TWinCtrl;
class PASCALIMPLEMENTATION TWinCtrl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	void __fastcall PaintCtrls(HDC DC, Controls::TControl* First);
public:
	/* TWinControl.Create */ inline __fastcall virtual TWinCtrl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TWinCtrl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinCtrl(void) { }
	
};


class DELPHICLASS TAdvSmoothMenuItem;
class PASCALIMPLEMENTATION TAdvSmoothMenuItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Advgdip::TGPRectF FItemRect;
	Advgdip::TGPRectF FCaptionRect;
	System::UnicodeString FCaption;
	int FNotesTop;
	int FNotesLeft;
	System::UnicodeString FNotes;
	TAdvSmoothMenuLocation FNotesLocation;
	Gdipfill::TFillPicturePosition FPicturePosition;
	Advgdip::TAdvGDIPPicture* FPicture;
	int FpictureWidth;
	Gdipfill::TFillPictureSize FpictureSize;
	int FPictureTop;
	int FpictureHeight;
	int FPictureLeft;
	System::TObject* FObject;
	int FTag;
	bool FEnabled;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetNotes(const System::UnicodeString Value);
	void __fastcall SetNotesLeft(const int Value);
	void __fastcall SetNotesLocation(const TAdvSmoothMenuLocation Value);
	void __fastcall SetNotesTop(const int Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetPictureHeight(const int Value);
	void __fastcall SetPictureLeft(const int Value);
	void __fastcall SetPicturePosition(const Gdipfill::TFillPicturePosition Value);
	void __fastcall SetPictureSize(const Gdipfill::TFillPictureSize Value);
	void __fastcall SetPictureTop(const int Value);
	void __fastcall SetPictureWidth(const int Value);
	void __fastcall SetEnabled(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall Draw(void);
	
public:
	__fastcall virtual TAdvSmoothMenuItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothMenuItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::TObject* ItemObject = {read=FObject, write=FObject};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString Notes = {read=FNotes, write=SetNotes};
	__property TAdvSmoothMenuLocation NotesLocation = {read=FNotesLocation, write=SetNotesLocation, default=0};
	__property int NotesLeft = {read=FNotesLeft, write=SetNotesLeft, default=0};
	__property int NotesTop = {read=FNotesTop, write=SetNotesTop, default=0};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property Gdipfill::TFillPicturePosition PicturePosition = {read=FPicturePosition, write=SetPicturePosition, default=0};
	__property int PictureLeft = {read=FPictureLeft, write=SetPictureLeft, default=0};
	__property int PictureTop = {read=FPictureTop, write=SetPictureTop, default=0};
	__property Gdipfill::TFillPictureSize PictureSize = {read=FpictureSize, write=SetPictureSize, default=0};
	__property int PictureWidth = {read=FpictureWidth, write=SetPictureWidth, default=50};
	__property int PictureHeight = {read=FpictureHeight, write=SetPictureHeight, default=50};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
};


class DELPHICLASS TAdvSmoothMenuItems;
class DELPHICLASS TAdvSmoothMenu;
class PASCALIMPLEMENTATION TAdvSmoothMenuItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothMenuItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothMenu* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothMenuItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothMenuItem* Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothMenuItems(TAdvSmoothMenu* AOwner);
	__property TAdvSmoothMenuItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TAdvSmoothMenuItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothMenuItem* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothMenuItems(void) { }
	
};


class DELPHICLASS TAdvSmoothMenuSplitter;
class PASCALIMPLEMENTATION TAdvSmoothMenuSplitter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothMenu* FOwner;
	Classes::TNotifyEvent FOnChange;
	System::Byte FOpacity;
	System::Byte FOpacityTo;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	bool FVisible;
	int FHeight;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetOpacityTo(const System::Byte Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetHeight(const int Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TAdvSmoothMenuSplitter(TAdvSmoothMenu* AOwner);
	__fastcall virtual ~TAdvSmoothMenuSplitter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16777215};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=16777215};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=20};
	__property System::Byte OpacityTo = {read=FOpacityTo, write=SetOpacityTo, default=255};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Height = {read=FHeight, write=SetHeight, default=28};
};


#pragma option push -b-
enum TAdvSmoothMenuGlowShape { gsEllipse, gsSquare, gsDiamond };
#pragma option pop

class DELPHICLASS TAdvSmoothMenuItemAppearance;
class PASCALIMPLEMENTATION TAdvSmoothMenuItemAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothMenu* FOwner;
	Classes::TNotifyEvent FOnChange;
	Graphics::TFont* FFont;
	TAdvSmoothMenuSplitter* Fsplitter;
	Graphics::TFont* FSelectedFont;
	Graphics::TFont* FHoverFont;
	Graphics::TColor FGlowColorHover;
	System::Byte FGlowOpacitySelected;
	System::Byte FGlowOpacity;
	System::Byte FGlowOpacityHover;
	Graphics::TColor FGlowColorSelected;
	Graphics::TColor FGlowColor;
	Graphics::TFont* FNotesFont;
	Graphics::TColor FGlowColorDisabled;
	System::Byte FGlowOpacityDisabled;
	TAdvSmoothMenuGlowShape FGlowShape;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetSplitter(const TAdvSmoothMenuSplitter* Value);
	void __fastcall SetHoverFont(const Graphics::TFont* Value);
	void __fastcall SetSelectedFont(const Graphics::TFont* Value);
	void __fastcall SetGlowColor(const Graphics::TColor Value);
	void __fastcall SetGlowColorHover(const Graphics::TColor Value);
	void __fastcall SetGlowColorSelected(const Graphics::TColor Value);
	void __fastcall SetGlowOpacity(const System::Byte Value);
	void __fastcall SetGlowOpacityHover(const System::Byte Value);
	void __fastcall SetGlowOpacitySelected(const System::Byte Value);
	void __fastcall SetNotesFont(const Graphics::TFont* Value);
	void __fastcall SetGlowColorDisabled(const Graphics::TColor Value);
	void __fastcall SetGlowOpacityDisabled(const System::Byte Value);
	void __fastcall SetGlowShape(const TAdvSmoothMenuGlowShape Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SplitterChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothMenuItemAppearance(TAdvSmoothMenu* AOwner);
	__fastcall virtual ~TAdvSmoothMenuItemAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TFont* HoverFont = {read=FHoverFont, write=SetHoverFont};
	__property Graphics::TFont* SelectedFont = {read=FSelectedFont, write=SetSelectedFont};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* NotesFont = {read=FNotesFont, write=SetNotesFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TAdvSmoothMenuSplitter* Splitter = {read=Fsplitter, write=SetSplitter};
	__property TAdvSmoothMenuGlowShape GlowShape = {read=FGlowShape, write=SetGlowShape, default=0};
	__property Graphics::TColor GlowColor = {read=FGlowColor, write=SetGlowColor, default=16777215};
	__property System::Byte GlowOpacity = {read=FGlowOpacity, write=SetGlowOpacity, default=100};
	__property Graphics::TColor GlowColorSelected = {read=FGlowColorSelected, write=SetGlowColorSelected, default=16777215};
	__property Graphics::TColor GlowColorDisabled = {read=FGlowColorDisabled, write=SetGlowColorDisabled, default=536870911};
	__property System::Byte GlowOpacityDisabled = {read=FGlowOpacityDisabled, write=SetGlowOpacityDisabled, default=100};
	__property System::Byte GlowOpacitySelected = {read=FGlowOpacitySelected, write=SetGlowOpacitySelected, default=100};
	__property Graphics::TColor GlowColorHover = {read=FGlowColorHover, write=SetGlowColorHover, default=16777215};
	__property System::Byte GlowOpacityHover = {read=FGlowOpacityHover, write=SetGlowOpacityHover, default=100};
};


class DELPHICLASS TAdvSmoothMenuAppearance;
class PASCALIMPLEMENTATION TAdvSmoothMenuAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothMenu* FOwner;
	Classes::TNotifyEvent FOnChange;
	Gdipfill::TGDIPFill* FFill;
	Graphics::TColor FLineColor;
	System::Byte FLineOpacity;
	bool FLineVisible;
	Graphics::TColor FIndicatorColor;
	bool FIndicatorVisible;
	System::Byte FIndicatorOpacity;
	int FIndicatorSize;
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetLineOpacity(const System::Byte Value);
	void __fastcall SetLineVisible(const bool Value);
	void __fastcall SetIndicatorColor(const Graphics::TColor Value);
	void __fastcall SetIndicatorOpacity(const System::Byte Value);
	void __fastcall SetIndicatorVisible(const bool Value);
	void __fastcall SetIndicatorSize(const int Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall BackGroundChanged(System::TObject* Sender);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TAdvSmoothMenuAppearance(TAdvSmoothMenu* AOwner);
	__fastcall virtual ~TAdvSmoothMenuAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, default=16777215};
	__property System::Byte LineOpacity = {read=FLineOpacity, write=SetLineOpacity, default=255};
	__property bool LineVisible = {read=FLineVisible, write=SetLineVisible, default=1};
	__property Graphics::TColor IndicatorColor = {read=FIndicatorColor, write=SetIndicatorColor, default=16777215};
	__property System::Byte IndicatorOpacity = {read=FIndicatorOpacity, write=SetIndicatorOpacity, default=255};
	__property bool IndicatorVisible = {read=FIndicatorVisible, write=SetIndicatorVisible, default=1};
	__property int IndicatorSize = {read=FIndicatorSize, write=SetIndicatorSize, default=6};
};


typedef void __fastcall (__closure *TAdvSmoothMenuItemClickEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMenuItemEnterEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMenuItemLeaveEvent)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothMenuItemChangeEvent)(System::TObject* Sender, int OldItemIndex, int NewItemIndex);

#pragma option push -b-
enum TAdvSmoothMenuAnimationType { atNone, atNoOpacity, atFull };
#pragma option pop

class PASCALIMPLEMENTATION TAdvSmoothMenu : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FFocused;
	bool FConstructed;
	bool FDesignTime;
	bool FMouseInControl;
	bool MouseLeave;
	bool MouseEnter;
	int FHoveredItem;
	int FSelectedItem;
	bool FAnimating;
	float FCurrentPos;
	float FPosTo;
	float FCurrentTextPos;
	System::Byte FCurrentTextOpc;
	Extctrls::TTimer* FSmoothTimer;
	Extctrls::TTimer* FRotationTimer;
	TAdvSmoothMenuItems* FItems;
	TAdvSmoothMenuItemAppearance* FItemAppearance;
	bool FTransparent;
	TAdvSmoothMenuAppearance* FAppearance;
	Gdippicturecontainer::TGDIPPictureContainer* FContainer;
	TAdvSmoothMenuItemLeaveEvent FOnItemLeave;
	TAdvSmoothMenuItemEnterEvent FOnItemEnter;
	TAdvSmoothMenuItemClickEvent FOnItemClick;
	bool FRotation;
	int FRotationInterval;
	TAdvSmoothMenuAnimationType FAnimationType;
	TAdvSmoothMenuItemChangeEvent FOnItemChange;
	bool FAllowSelectedIndication;
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall SetItems(const TAdvSmoothMenuItems* Value);
	void __fastcall SetItemAppearance(const TAdvSmoothMenuItemAppearance* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetAppearance(const TAdvSmoothMenuAppearance* Value);
	void __fastcall SetRotation(const bool Value);
	void __fastcall SetRotationInterval(const int Value);
	void __fastcall SetAnimationType(const TAdvSmoothMenuAnimationType Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetSelectedItemIndex(const int Value);
	void __fastcall SetAllowSelectedIndication(const bool Value);
	
protected:
	void __fastcall ItemAppearanceChanged(System::TObject* Sender);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall ItemsChanged(System::TObject* Sender);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall DrawLine(void);
	void __fastcall DrawBackGround(void);
	void __fastcall DrawItems(void);
	void __fastcall DrawIndicator(void);
	void __fastcall InitItemRects(void);
	void __fastcall AnimateMenu(System::TObject* Sender);
	void __fastcall RotateMenu(System::TObject* Sender);
	void __fastcall DoItemClick(System::TObject* Sender, int ItemIndex);
	void __fastcall DoItemEnter(System::TObject* Sender, int ItemIndex);
	void __fastcall DoItemLeave(System::TObject* Sender, int ItemIndex);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall DrawPicture(Advgdip::TGPGraphics* g, System::Byte opacity, Advgdip::TAdvGDIPPicture* picture, Gdipfill::TFillPicturePosition location, int w, int h, const Types::TRect &r, int x, int y);
	void __fastcall InitPreview(void);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall ChangeSelectedItem(void);
	void __fastcall DoRotate(void);
	int __fastcall GetVersionNr(void);
	int __fastcall GetShadowOffset(void);
	
public:
	__fastcall virtual TAdvSmoothMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothMenu(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	void __fastcall GetTextPosition(int &x, int &y, const Advgdip::TGPRectF &rectangle, int objectwidth, int objectheight, TAdvSmoothMenuLocation location);
	int __fastcall XYToItem(int X, int Y);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property TAdvSmoothMenuAnimationType AnimationType = {read=FAnimationType, write=SetAnimationType, default=2};
	__property Anchors = {default=3};
	__property Constraints;
	__property bool Rotation = {read=FRotation, write=SetRotation, default=1};
	__property int RotationInterval = {read=FRotationInterval, write=SetRotationInterval, default=5000};
	__property TAdvSmoothMenuAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property TAdvSmoothMenuItems* Items = {read=FItems, write=SetItems};
	__property TAdvSmoothMenuItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Gdippicturecontainer::TGDIPPictureContainer* Container = {read=FContainer, write=FContainer};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property int SelectedItemIndex = {read=FSelectedItem, write=SetSelectedItemIndex, nodefault};
	__property bool AllowSelectedIndication = {read=FAllowSelectedIndication, write=SetAllowSelectedIndication, default=0};
	__property TAdvSmoothMenuItemClickEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TAdvSmoothMenuItemEnterEvent OnItemEnter = {read=FOnItemEnter, write=FOnItemEnter};
	__property TAdvSmoothMenuItemLeaveEvent OnItemLeave = {read=FOnItemLeave, write=FOnItemLeave};
	__property TAdvSmoothMenuItemChangeEvent OnItemChange = {read=FOnItemChange, write=FOnItemChange};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property Align = {default=0};
	__property ShowHint;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseDown;
	__property OnStartDock;
	__property OnStartDrag;
	__property PopupMenu;
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothMenu(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
private:
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advstyleif::_di_ITMSStyle()
	{
		Advstyleif::_di_ITMSStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator ITMSStyle*(void) { return (ITMSStyle*)&__ITMSStyle; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x5;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothmenu */
using namespace Advsmoothmenu;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothmenuHPP
