// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advdropdown.pas' rev: 21.00

#ifndef AdvdropdownHPP
#define AdvdropdownHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Asghtmle.hpp>	// Pascal unit
#include <Advutil.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Atxpvs.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advdropdown
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TDropPosition { dpAuto, dpDown, dpUp };
#pragma option pop

typedef Buttons::TNumGlyphs TNumGlyphs;

#pragma option push -b-
enum TButtonStyle { bsButton, bsDropDown };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TAdvButtonStyle { tasButton, tasCheck };
#pragma option pop

#pragma option push -b-
enum TAdvButtonState { absUp, absDisabled, absDown, absDropDown, absExclusive };
#pragma option pop

#pragma option push -b-
enum TSelectionColorStyle { scCustom, scOffice2007, scWindowsVista, scWindows7 };
#pragma option pop

#pragma option push -b-
enum TSelectorType { stImage, stColor };
#pragma option pop

#pragma option push -b-
enum TItemLayout { ilCaptionLeft, ilCaptionRight, ilCaptionTop, ilCaptionBottom };
#pragma option pop

#pragma option push -b-
enum TDropDownEditType { etString, etNumeric, etFloat, etUppercase, etMixedCase, etLowerCase, etPassword, etMoney, etRange, etHex, etAlphaNumeric, etValidChars };
#pragma option pop

#pragma option push -b-
enum TAutoType { atNumeric, atFloat, atString, atDate, atTime, atHex };
#pragma option pop

typedef void __fastcall (__closure *TDrawBackGroundEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect);

typedef void __fastcall (__closure *TGetTextEvent)(System::TObject* Sender, System::UnicodeString &Text);

typedef void __fastcall (__closure *TDropDown)(System::TObject* Sender, bool &acceptdrop);

typedef void __fastcall (__closure *TDropUp)(System::TObject* Sender, bool Cancelled);

typedef void __fastcall (__closure *TClipboardEvent)(System::TObject* Sender, System::UnicodeString value, bool &allow);

typedef void __fastcall (__closure *TDropDownButtonItemClick)(System::TObject* Sender, int ButtonIndex);

typedef void __fastcall (__closure *TOnDrawSelectedItem)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &R);

typedef void __fastcall (__closure *TDrawItemEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &R, int Index);

typedef void __fastcall (__closure *TItemSizeEvent)(System::TObject* Sender, tagSIZE &ASize);

class DELPHICLASS TDbgList;
class PASCALIMPLEMENTATION TDbgList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	void * operator[](int Index) { return Items[Index]; }
	
private:
	void * __fastcall GetItemsEx(int Index);
	void __fastcall SetItemsEx(int Index, const void * Value);
	
public:
	void __fastcall AssignList(Classes::TList* ListA);
	__property void * Items[int Index] = {read=GetItemsEx, write=SetItemsEx/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TDbgList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TDbgList(void) : Classes::TList() { }
	
};


class DELPHICLASS TAdvButtonAppearance;
class PASCALIMPLEMENTATION TAdvButtonAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderColorHot;
	Graphics::TColor FBorderColorDown;
	Graphics::TColor FBorderColorDisabled;
	Graphics::TColor FBorderColorChecked;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorCheckedTo;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FColorDisabledTo;
	Graphics::TColor FColorChecked;
	TGradientDirection FGradient;
	Graphics::TFont* FFont;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorChecked(const Graphics::TColor Value);
	void __fastcall SetBorderColorDisabled(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorChecked(const Graphics::TColor Value);
	void __fastcall SetColorCheckedTo(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradient(const TGradientDirection Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	
protected:
	void __fastcall Changed(void);
	__property Graphics::TColor BorderColorChecked = {read=FBorderColorChecked, write=SetBorderColorChecked, default=16711680};
	__property Graphics::TColor ColorChecked = {read=FColorChecked, write=SetColorChecked, nodefault};
	__property Graphics::TColor ColorCheckedTo = {read=FColorCheckedTo, write=SetColorCheckedTo, nodefault};
	
public:
	__fastcall TAdvButtonAppearance(void);
	__fastcall virtual ~TAdvButtonAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, default=8421504};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=SetBorderColorDown, default=8388608};
	__property Graphics::TColor BorderColorDisabled = {read=FBorderColorDisabled, write=SetBorderColorDisabled, default=8421504};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, default=15921906};
	__property Graphics::TColor ColorDisabledTo = {read=FColorDisabledTo, write=SetColorDisabledTo, default=536870911};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, default=16111818};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, default=16367008};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, default=16117985};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, default=16372402};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TGradientDirection Gradient = {read=FGradient, write=SetGradient, default=1};
};


class DELPHICLASS TAdvButton;
class DELPHICLASS TAdvCustomDropDown;
class PASCALIMPLEMENTATION TAdvButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FGroupIndex;
	bool FDown;
	bool FAllowAllUp;
	int FOffSet;
	bool FMouseInControl;
	bool FHot;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	TAdvButtonStyle FStyle;
	TAdvButtonState FState;
	bool FMouseDownInControl;
	bool FGrouped;
	bool FDragging;
	bool FPropHot;
	Extctrls::TTimer* FUnHotTimer;
	bool FInitialDown;
	bool FInternalClick;
	TAdvButtonAppearance* FAppearance;
	Imglist::TCustomImageList* FImages;
	int FImageIndex;
	Controls::TModalResult FModalResult;
	TAdvCustomDropDown* FAdvDropDown;
	void __fastcall UnHotTimerOnTime(System::TObject* Sender);
	void __fastcall UpdateExclusive(void);
	void __fastcall UpdateTracking(void);
	void __fastcall ButtonDown(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Message);
	void __fastcall SetDown(bool Value);
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetStyle(const TAdvButtonStyle Value);
	void __fastcall SetState(const TAdvButtonState Value);
	void __fastcall SetGrouped(const bool Value);
	bool __fastcall GetHot(void);
	void __fastcall SetHot(const bool Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetAdvDropDown(const TAdvCustomDropDown* Value);
	
protected:
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DrawButton(Graphics::TCanvas* ACanvas);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall SetAutoSizeEx(void);
	void __fastcall InvalidateMe(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	__property TAdvButtonState State = {read=FState, write=SetState, nodefault};
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property TAdvButtonAppearance* Appearance = {read=FAppearance, write=FAppearance};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property bool Grouped = {read=FGrouped, write=SetGrouped, default=0};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property Enabled = {default=1};
	__property Font;
	__property bool Hot = {read=GetHot, write=SetHot, default=0};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property Controls::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property TAdvCustomDropDown* AdvDropDown = {read=FAdvDropDown, write=SetAdvDropDown};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TAdvButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	
public:
	__fastcall virtual TAdvButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvButton(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS THeaderButton;
class PASCALIMPLEMENTATION THeaderButton : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	int FImageIndex;
	bool FEnabled;
	int FHeight;
	int FWidth;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SerHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetEnabled(const bool Value);
	
protected:
	void __fastcall PropChanged(void);
	
public:
	__fastcall virtual THeaderButton(Classes::TCollection* Collection);
	__fastcall virtual ~THeaderButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property int Width = {read=FWidth, write=SetWidth, default=0};
	__property int Height = {read=FHeight, write=SerHeight, default=0};
};


class DELPHICLASS THeaderButtons;
class PASCALIMPLEMENTATION THeaderButtons : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	THeaderButton* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE THeaderButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const THeaderButton* Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall THeaderButtons(Classes::TPersistent* AOwner);
	__property THeaderButton* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE THeaderButton* __fastcall Add(void);
	HIDESBASE THeaderButton* __fastcall Insert(int Index);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~THeaderButtons(void) { }
	
};


#pragma option push -b-
enum TButtonAlignment { baLeft, baRight };
#pragma option pop

class DELPHICLASS THeaderAppearance;
class PASCALIMPLEMENTATION THeaderAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TPersistent* FOwner;
	bool FVisible;
	int FHeight;
	int FBorderWidth;
	int FImageIndex;
	System::UnicodeString FCaption;
	Graphics::TColor FColorTo;
	Graphics::TColor FColor;
	Graphics::TColor FBorderColor;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	THeaderButtons* FButtons;
	TGradientDirection FGradientDirection;
	TButtonAlignment FButtonAlignment;
	Classes::TNotifyEvent FOnButtonsChanged;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetButtons(const THeaderButtons* Value);
	void __fastcall OnButtonChanged(System::TObject* Sender);
	void __fastcall SetVisible(const bool Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnButtonsChanged = {read=FOnButtonsChanged, write=FOnButtonsChanged};
	
public:
	__fastcall THeaderAppearance(Classes::TPersistent* AOwner);
	__fastcall virtual ~THeaderAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignColors(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=12632256};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=FColorTo, default=16777215};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=FGradientDirection, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property int Height = {read=FHeight, write=FHeight, default=22};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, default=0};
	__property int BorderWidth = {read=FBorderWidth, write=FBorderWidth, default=1};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property THeaderButtons* Buttons = {read=FButtons, write=SetButtons};
	__property TButtonAlignment ButtonAlignment = {read=FButtonAlignment, write=FButtonAlignment, default=1};
};


class DELPHICLASS TAdvHeader;
class PASCALIMPLEMENTATION TAdvHeader : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	THeaderAppearance* FAppearance;
	Imglist::TCustomImageList* FImages;
	TAdvCustomDropDown* FAdvDropDown;
	TDbgList* FButtonList;
	TDrawBackGroundEvent FOnDrawBackGround;
	TGetTextEvent FOnGetText;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetAppearance(const THeaderAppearance* Value);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall OnButtonsChanged(System::TObject* Sender);
	void __fastcall OnButtonClick(System::TObject* Sender);
	THeaderButtons* __fastcall GetButtons(void);
	void __fastcall SetAdvDropDown(const TAdvCustomDropDown* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateButtons(void);
	virtual void __fastcall DestroyButtons(void);
	virtual void __fastcall ArrangeButtons(void);
	virtual void __fastcall UpdateButtons(void);
	Types::TRect __fastcall GetButtonsRect(void);
	int __fastcall GetMaxButtonHeight(void);
	void __fastcall Initialize(void);
	Types::TRect __fastcall GetButtonsCoveredRect(void);
	__property TAdvCustomDropDown* AdvDropDown = {read=FAdvDropDown, write=SetAdvDropDown};
	
public:
	__fastcall virtual TAdvHeader(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvHeader(void);
	virtual void __fastcall Update(void);
	
__published:
	__property THeaderAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property THeaderButtons* Buttons = {read=GetButtons};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property Constraints;
	__property Ctl3D;
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ParentBiDiMode = {default=1};
	__property ParentBackground;
	__property ParentCtl3D = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property TDrawBackGroundEvent OnDrawBackGround = {read=FOnDrawBackGround, write=FOnDrawBackGround};
	__property TGetTextEvent OnGetText = {read=FOnGetText, write=FOnGetText};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvHeader(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TFooterButton;
class PASCALIMPLEMENTATION TFooterButton : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	int FImageIndex;
	Controls::TModalResult FModalResult;
	bool FEnabled;
	int FHeight;
	int FWidth;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SerHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetEnabled(const bool Value);
	
protected:
	void __fastcall PropChanged(void);
	
public:
	__fastcall virtual TFooterButton(Classes::TCollection* Collection);
	__fastcall virtual ~TFooterButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property Controls::TModalResult ModalResult = {read=FModalResult, write=FModalResult, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=0};
	__property int Height = {read=FHeight, write=SerHeight, default=0};
};


class DELPHICLASS TFooterButtons;
class PASCALIMPLEMENTATION TFooterButtons : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TFooterButton* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TFooterButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TFooterButton* Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TFooterButtons(Classes::TPersistent* AOwner);
	__property TFooterButton* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TFooterButton* __fastcall Add(void);
	HIDESBASE TFooterButton* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TFooterButtons(void) { }
	
};


class DELPHICLASS TFooterAppearance;
class PASCALIMPLEMENTATION TFooterAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TPersistent* FOwner;
	bool FVisible;
	int FHeight;
	int FBorderWidth;
	bool FSizeGrip;
	System::UnicodeString FCaption;
	Graphics::TColor FColorTo;
	Graphics::TColor FColor;
	Graphics::TColor FBorderColor;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	int FImageIndex;
	TFooterButtons* FButtons;
	TGradientDirection FGradientDirection;
	TButtonAlignment FButtonAlignment;
	Classes::TNotifyEvent FOnButtonsChanged;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetButtons(const TFooterButtons* Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall OnButtonsChange(System::TObject* Sender);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnButtonsChanged = {read=FOnButtonsChanged, write=FOnButtonsChanged};
	
public:
	__fastcall TFooterAppearance(Classes::TPersistent* AOwner);
	__fastcall virtual ~TFooterAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignColors(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=12632256};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=FColorTo, default=16777215};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=FGradientDirection, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property int Height = {read=FHeight, write=FHeight, default=22};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, default=0};
	__property int BorderWidth = {read=FBorderWidth, write=FBorderWidth, default=1};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property bool SizeGrip = {read=FSizeGrip, write=FSizeGrip, default=1};
	__property TFooterButtons* Buttons = {read=FButtons, write=SetButtons};
	__property TButtonAlignment ButtonAlignment = {read=FButtonAlignment, write=FButtonAlignment, default=1};
};


class DELPHICLASS TAdvFooter;
class PASCALIMPLEMENTATION TAdvFooter : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TFooterAppearance* FAppearance;
	Imglist::TCustomImageList* FImages;
	TAdvCustomDropDown* FAdvDropDown;
	TDbgList* FButtonList;
	TDrawBackGroundEvent FOnDrawBackGround;
	TGetTextEvent FOnGetText;
	Controls::TCursor FOldCursor;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetAppearance(const TFooterAppearance* Value);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall OnButtonClick(System::TObject* Sender);
	TFooterButtons* __fastcall GetButtons(void);
	void __fastcall SetAdvDropDown(const TAdvCustomDropDown* Value);
	bool __fastcall HasSizeGrip(void);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	void __fastcall DrawSizeGrip(const Types::TRect &R);
	virtual void __fastcall CreateButtons(void);
	virtual void __fastcall DestroyButtons(void);
	virtual void __fastcall ArrangeButtons(void);
	virtual void __fastcall UpdateButtons(void);
	Types::TRect __fastcall GetButtonsRect(void);
	int __fastcall GetMaxButtonHeight(void);
	void __fastcall Initialize(void);
	Types::TRect __fastcall GetButtonsCoveredRect(void);
	__property TAdvCustomDropDown* AdvDropDown = {read=FAdvDropDown, write=SetAdvDropDown};
	
public:
	__fastcall virtual TAdvFooter(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvFooter(void);
	
__published:
	__property TFooterAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TFooterButtons* Buttons = {read=GetButtons};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelInner = {index=0, default=2};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderWidth = {default=0};
	__property Constraints;
	__property Ctl3D;
	__property UseDockManager = {default=1};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ParentBiDiMode = {default=1};
	__property ParentBackground;
	__property ParentCtl3D = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property TDrawBackGroundEvent OnDrawBackGround = {read=FOnDrawBackGround, write=FOnDrawBackGround};
	__property TGetTextEvent OnGetText = {read=FOnGetText, write=FOnGetText};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvFooter(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TDropDownForm;
class PASCALIMPLEMENTATION TDropDownForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	unsigned FDeActivate;
	bool FShadow;
	TAdvFooter* FFooter;
	TAdvHeader* FHeader;
	TAdvCustomDropDown* FAdvDropDown;
	Forms::TScrollBox* FScrollBox;
	bool FSizeable;
	bool FCancelOnDeActivate;
	Classes::TNotifyEvent FOnSizing;
	bool FBlockActivate;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	MESSAGE void __fastcall WMSizing(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMClose(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	HWND __fastcall GetParentWnd(void);
	void __fastcall SetAdvDropDown(const TAdvCustomDropDown* Value);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall Paint(void);
	void __fastcall DrawBackGround(Graphics::TCanvas* aCanvas);
	virtual Types::TRect __fastcall GetClientRect(void);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	
public:
	__fastcall virtual TDropDownForm(Classes::TComponent* AOwner);
	__fastcall virtual TDropDownForm(Classes::TComponent* AOwner, int Dummy);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall UpdateSize(void);
	void __fastcall InitializeAndUpdate(void);
	__property bool BlockActivate = {read=FBlockActivate, write=FBlockActivate, nodefault};
	__property unsigned DeActivateTime = {read=FDeActivate, nodefault};
	__property Forms::TScrollBox* ScrollBox = {read=FScrollBox};
	__property bool Sizeable = {read=FSizeable, write=FSizeable, nodefault};
	__property bool Shadow = {read=FShadow, write=FShadow, nodefault};
	__property TAdvHeader* Header = {read=FHeader};
	__property TAdvFooter* Footer = {read=FFooter};
	__property bool CancelOnDeActivate = {read=FCancelOnDeActivate, write=FCancelOnDeActivate, default=1};
	__property TAdvCustomDropDown* AdvDropDown = {read=FAdvDropDown, write=SetAdvDropDown};
	__property Classes::TNotifyEvent OnSizing = {read=FOnSizing, write=FOnSizing};
public:
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDropDownForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropDownForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvDropDownSpeedButton;
class PASCALIMPLEMENTATION TAdvDropDownSpeedButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	bool FEtched;
	bool FFocused;
	bool FHot;
	bool FUp;
	bool FIsWinXP;
	TButtonStyle FButtonStyle;
	void __fastcall SetEtched(const bool Value);
	void __fastcall SetFocused(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	void __fastcall PaintDropDown(void);
	void __fastcall PaintButton(void);
	void __fastcall SetButtonStyle(const TButtonStyle Value);
	
protected:
	virtual void __fastcall Paint(void);
	bool __fastcall DoVisualStyles(void);
	
public:
	void __fastcall SetUp(void);
	__fastcall virtual TAdvDropDownSpeedButton(Classes::TComponent* AOwner);
	
__published:
	__property TButtonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, nodefault};
	__property bool Etched = {read=FEtched, write=SetEtched, nodefault};
	__property bool Focused = {read=FFocused, write=SetFocused, nodefault};
public:
	/* TSpeedButton.Destroy */ inline __fastcall virtual ~TAdvDropDownSpeedButton(void) { }
	
};


class DELPHICLASS TDropDownEditButton;
class PASCALIMPLEMENTATION TDropDownEditButton : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	TAdvDropDownSpeedButton* FButton;
	Controls::TWinControl* FFocusControl;
	Classes::TNotifyEvent FOnClick;
	int FBWidth;
	TAdvDropDownSpeedButton* __fastcall CreateButton(void);
	Graphics::TBitmap* __fastcall GetGlyph(void);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	Buttons::TNumGlyphs __fastcall GetNumGlyphs(void);
	void __fastcall SetNumGlyphs(Buttons::TNumGlyphs Value);
	void __fastcall SetCaption(System::UnicodeString value);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall BtnClick(System::TObject* Sender);
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall AdjustWinSize(int &W, int &H);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	__property int BWidth = {read=FBWidth, write=FBWidth, nodefault};
	void __fastcall Setup(void);
	
public:
	__fastcall virtual TDropDownEditButton(Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Align = {default=0};
	__property Ctl3D;
	__property Graphics::TBitmap* Glyph = {read=GetGlyph, write=SetGlyph};
	__property System::UnicodeString ButtonCaption = {read=GetCaption, write=SetCaption};
	__property Buttons::TNumGlyphs NumGlyphs = {read=GetNumGlyphs, write=SetNumGlyphs, default=1};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnStartDrag;
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDropDownEditButton(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TDropDownEditButton(void) { }
	
};


class DELPHICLASS TItemAppearance;
class PASCALIMPLEMENTATION TAdvCustomDropDown : public Mask::TCustomMaskEdit
{
	typedef Mask::TCustomMaskEdit inherited;
	
private:
	int FDropDownWidth;
	int FDropDownHeight;
	int FUserDropDownWidth;
	int FUserDropDownHeight;
	bool FEditorEnabled;
	TDropPosition FDropPosition;
	TDropDown FOnDropDown;
	TDropUp FOnDropUP;
	bool FFlat;
	Imglist::TCustomImageList* FImages;
	bool FDropDownShadow;
	int FDropDownBorderWidth;
	System::UnicodeString FButtonHint;
	Graphics::TColor FDropDownColorTo;
	Graphics::TColor FDropDownColor;
	Graphics::TColor FDropDownBorderColor;
	int FButtonWidth;
	bool FMouseInControl;
	bool FEtched;
	Controls::TWinControl* FFocusControl;
	THeaderAppearance* FDropDownHeader;
	TAdvButtonAppearance* FButtonAppearance;
	TFooterAppearance* FDropDownFooter;
	Controls::TControl* FControl;
	TGradientDirection FDropDownGradient;
	bool FDropDownSizeable;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionColorTo;
	TSelectionColorStyle FSelectionColorStyle;
	TDropDownEditType FEditType;
	short FLengthLimit;
	short FPrecision;
	System::UnicodeString FPrefix;
	System::UnicodeString FSuffix;
	System::UnicodeString FOldString;
	bool FSigned;
	bool FReturnIsTab;
	bool FIsWinXP;
	bool FIsThemed;
	bool FBlockChange;
	bool FAllowNumericNullValue;
	bool FDefaultHandling;
	bool FCanUndo;
	bool FExcelStyleDecimalSeparator;
	System::UnicodeString FValidChars;
	bool FBlockCopy;
	TClipboardEvent FOnClipboardCopy;
	TClipboardEvent FOnClipboardPaste;
	TClipboardEvent FOnClipboardCut;
	bool FButtonDown;
	bool FAutoThousandSeparator;
	bool FIsModified;
	Types::TRect FEditRect;
	bool FDropDownEnabled;
	TDropDownButtonItemClick FOnDropDownFooterButtonClick;
	TDropDownButtonItemClick FOnDropDownHeaderButtonClick;
	TDrawBackGroundEvent FOnDrawHeader;
	TDrawBackGroundEvent FOnDrawFooter;
	TGetTextEvent FOnGetFooterText;
	TGetTextEvent FOnGetHeaderText;
	bool FDroppedDown;
	Graphics::TBitmap* FButtonGlyph;
	bool FFocusDraw;
	bool FForceShadow;
	Advstyleif::TTMSStyle FTMSStyle;
	Classes::TNotifyEvent FOnBeforeDropDown;
	Classes::TNotifyEvent FOnBeforeDropUp;
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaste(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMCut(Messages::TWMNoParams &Message);
	MESSAGE void __fastcall WMCopy(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	void __fastcall OnFooterAppearanceChanged(System::TObject* Sender);
	void __fastcall OnHeaderAppearanceChanged(System::TObject* Sender);
	void __fastcall OnButtonGlyphChanged(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall OnFormHide(System::TObject* Sender);
	void __fastcall OnFormDestroy(System::TObject* Sender);
	void __fastcall OnFormKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall OnFormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnFormKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnFormMouseWheelDown(System::TObject* Sender, Classes::TShiftState Shift, const Types::TPoint &MousePos, bool &Handled);
	void __fastcall OnFormMouseWheelUp(System::TObject* Sender, Classes::TShiftState Shift, const Types::TPoint &MousePos, bool &Handled);
	void __fastcall OnControlKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnControlKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnControlKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall SetEditorEnabled(const bool Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetVersion(const System::UnicodeString Value);
	Graphics::TBitmap* __fastcall GetButtonGlyph(void);
	int __fastcall GetButtonWidth(void);
	void __fastcall SetButtonGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetButtonHint(const System::UnicodeString Value);
	void __fastcall SetButtonWidth(const int Value);
	System::UnicodeString __fastcall GetButtonCaption(void);
	void __fastcall SetButtonCaption(const System::UnicodeString Value);
	void __fastcall SetEtched(const bool Value);
	void __fastcall DrawControlBorder(HDC DC);
	void __fastcall DrawButtonBorder(void);
	void __fastcall DrawBorders(void);
	bool __fastcall Is3DBorderControl(void);
	bool __fastcall Is3DBorderButton(void);
	void __fastcall SetDropDownHeader(const THeaderAppearance* Value);
	void __fastcall SetButtonAppearance(const TAdvButtonAppearance* Value);
	void __fastcall SetDropDownFooter(const TFooterAppearance* Value);
	void __fastcall SetControl(const Controls::TControl* Value);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	void __fastcall SetSelectionColorTo(const Graphics::TColor Value);
	void __fastcall SetEditType(const TDropDownEditType Value);
	HIDESBASE System::UnicodeString __fastcall GetText(void);
	void __fastcall SetPrefix(const System::UnicodeString Value);
	void __fastcall SetSuffix(const System::UnicodeString Value);
	void __fastcall SetPrecision(const short Value);
	int __fastcall FixedLength(System::UnicodeString s);
	bool __fastcall AllowMin(System::WideChar ch);
	int __fastcall DecimalPos(void);
	void __fastcall SetFloat(const double Value);
	void __fastcall SetInt(const int Value);
	void __fastcall AutoSeparators(void);
	HIDESBASE bool __fastcall GetModified(void);
	HIDESBASE void __fastcall SetModified(const bool Value);
	void __fastcall SetCanUndo(const bool Value);
	double __fastcall GetFloat(void);
	int __fastcall GetInt(void);
	System::Extended __fastcall EStrToFloat(System::UnicodeString s);
	int __fastcall CharFromPos(const Types::TPoint &pt);
	void __fastcall UpdateLookup(void);
	void __fastcall SetAutoThousandSeparator(const bool Value);
	void __fastcall SetDropDownEnabled(const bool Value);
	void __fastcall SetDropDownColor(const Graphics::TColor Value);
	void __fastcall DropDownSizing(System::TObject* Sender);
	void __fastcall SetDropDownHeight(const int Value);
	void __fastcall SetDropDownWidth(const int Value);
	
protected:
	TDropDownForm* FDropDownForm;
	TDropDownEditButton* FButton;
	System::UnicodeString FOldText;
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall DoEnter(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	Types::TPoint __fastcall PosFromChar(System::Word uChar);
	System::UnicodeString __fastcall GetVersionEx(void);
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall CreateDropDownButton(void);
	virtual void __fastcall UpdateDropDownButton(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall AfterDropDown(void);
	virtual void __fastcall DoShowDropDown(void);
	virtual void __fastcall SetCenterControl(void);
	virtual void __fastcall UpdateDropDownSize(void);
	virtual void __fastcall DoHideDropDown(bool Cancelled);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall OnDestroyDropDownForm(void);
	virtual void __fastcall OnDropDownFormMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos, bool &Handled);
	virtual void __fastcall OnDropDownFormMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos, bool &Handled);
	virtual void __fastcall OnDropDownFormKeyPress(System::WideChar &Key);
	virtual void __fastcall OnDropDownFormKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownFormKeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall OnDropDownControlKeyPress(System::WideChar &Key);
	virtual void __fastcall OnDropDownSizing(void);
	virtual void __fastcall HandleMouseWheelDown(void);
	virtual void __fastcall HandleMouseWheelUp(void);
	virtual void __fastcall DrawBackGround(void);
	int __fastcall GetMinHeight(void);
	Types::TRect __fastcall GetEditRect(void);
	virtual void __fastcall SetEditRect(void);
	virtual void __fastcall ResizeControl(void);
	void __fastcall SetTextDirect(System::UnicodeString s);
	HIDESBASE virtual void __fastcall SetText(System::UnicodeString Value);
	virtual void __fastcall SetSelectionColorStyle(const TSelectionColorStyle Value);
	void __fastcall ReadSelectionColorStyle(Classes::TReader* Reader);
	void __fastcall WriteSelectionColorStyle(Classes::TWriter* Writer);
	void __fastcall ReadTMSStyle(Classes::TReader* Reader);
	void __fastcall WriteTMSStyle(Classes::TWriter* Writer);
	void __fastcall MouseButtonDown(System::TObject* Sender);
	void __fastcall DropDownButtonClick(System::TObject* Sender);
	virtual void __fastcall DrawSelectionBackground(Graphics::TCanvas* Canvas, const Types::TRect &R, Graphics::TColor bkgcolor, Advutil::TGradientPart part);
	virtual void __fastcall DrawGradientBackground(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &R, TGradientDirection GradientDirection);
	__property Controls::TWinControl* FocusControl = {read=FFocusControl, write=FFocusControl};
	__property bool FocusDraw = {read=FFocusDraw, write=FFocusDraw, default=1};
	__property bool ForceShadow = {read=FForceShadow, write=FForceShadow, default=0};
	__property bool DropDownEnabled = {read=FDropDownEnabled, write=SetDropDownEnabled, default=0};
	__property Graphics::TColor DropDownColor = {read=FDropDownColor, write=SetDropDownColor, default=16777215};
	__property Graphics::TColor DropDownColorTo = {read=FDropDownColorTo, write=FDropDownColorTo, default=536870911};
	__property TGradientDirection DropDownGradient = {read=FDropDownGradient, write=FDropDownGradient, default=0};
	__property Graphics::TColor DropDownBorderColor = {read=FDropDownBorderColor, write=FDropDownBorderColor, default=0};
	__property int DropDownBorderWidth = {read=FDropDownBorderWidth, write=FDropDownBorderWidth, default=1};
	__property bool DropDownShadow = {read=FDropDownShadow, write=FDropDownShadow, default=1};
	__property int DropDownWidth = {read=FDropDownWidth, write=SetDropDownWidth, default=0};
	__property int DropDownHeight = {read=FDropDownHeight, write=SetDropDownHeight, default=0};
	__property bool DropDownSizeable = {read=FDropDownSizeable, write=FDropDownSizeable, default=1};
	__property TDropDownEditType EditType = {read=FEditType, write=SetEditType, default=0};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, default=0};
	__property short LengthLimit = {read=FLengthLimit, write=FLengthLimit, default=0};
	__property short Precision = {read=FPrecision, write=SetPrecision, nodefault};
	__property System::UnicodeString Prefix = {read=FPrefix, write=SetPrefix};
	__property System::UnicodeString Suffix = {read=FSuffix, write=SetSuffix};
	__property bool DefaultHandling = {read=FDefaultHandling, write=FDefaultHandling, nodefault};
	__property bool CanUndo = {read=FCanUndo, write=SetCanUndo, default=1};
	__property bool ExcelStyleDecimalSeparator = {read=FExcelStyleDecimalSeparator, write=FExcelStyleDecimalSeparator, default=0};
	__property System::UnicodeString ValidChars = {read=FValidChars, write=FValidChars};
	__property double FloatValue = {read=GetFloat, write=SetFloat};
	__property int IntValue = {read=GetInt, write=SetInt, nodefault};
	__property bool Modified = {read=GetModified, write=SetModified, nodefault};
	__property bool Signed = {read=FSigned, write=FSigned, default=0};
	__property bool AutoThousandSeparator = {read=FAutoThousandSeparator, write=SetAutoThousandSeparator, default=1};
	__property Controls::TControl* Control = {read=FControl, write=SetControl};
	__property TAdvButtonAppearance* ButtonAppearance = {read=FButtonAppearance, write=SetButtonAppearance};
	__property THeaderAppearance* DropDownHeader = {read=FDropDownHeader, write=SetDropDownHeader};
	__property TFooterAppearance* DropDownFooter = {read=FDropDownFooter, write=SetDropDownFooter};
	__property TDropPosition DropPosition = {read=FDropPosition, write=FDropPosition, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property int DropDownButtonWidth = {read=GetButtonWidth, write=SetButtonWidth, default=17};
	__property System::UnicodeString DropDownButtonHint = {read=FButtonHint, write=SetButtonHint};
	__property bool EditorEnabled = {read=FEditorEnabled, write=SetEditorEnabled, default=1};
	__property Graphics::TBitmap* DropDownButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph};
	__property System::UnicodeString DropDownButtonCaption = {read=GetButtonCaption, write=SetButtonCaption};
	__property bool Etched = {read=FEtched, write=SetEtched, nodefault};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property System::UnicodeString Version = {read=GetVersionEx, write=SetVersion};
	__property TSelectionColorStyle SelectionColorStyle = {read=FSelectionColorStyle, write=SetSelectionColorStyle, nodefault};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, nodefault};
	__property Graphics::TColor SelectionColorTo = {read=FSelectionColorTo, write=SetSelectionColorTo, nodefault};
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	__property System::UnicodeString Text = {read=GetText, write=SetText};
	__property TDropDownButtonItemClick OnDropDownHeaderButtonClick = {read=FOnDropDownHeaderButtonClick, write=FOnDropDownHeaderButtonClick};
	__property TDropDownButtonItemClick OnDropDownFooterButtonClick = {read=FOnDropDownFooterButtonClick, write=FOnDropDownFooterButtonClick};
	__property TDrawBackGroundEvent OnDrawHeader = {read=FOnDrawHeader, write=FOnDrawHeader};
	__property TDrawBackGroundEvent OnDrawFooter = {read=FOnDrawFooter, write=FOnDrawFooter};
	__property TGetTextEvent OnGetHeaderText = {read=FOnGetHeaderText, write=FOnGetHeaderText};
	__property TGetTextEvent OnGetFooterText = {read=FOnGetFooterText, write=FOnGetFooterText};
	__property Classes::TNotifyEvent OnBeforeDropDown = {read=FOnBeforeDropDown, write=FOnBeforeDropDown};
	__property TDropDown OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Classes::TNotifyEvent OnBeforeDropUp = {read=FOnBeforeDropUp, write=FOnBeforeDropUp};
	__property TDropUp OnDropUp = {read=FOnDropUP, write=FOnDropUP};
	__property TClipboardEvent OnClipboardCopy = {read=FOnClipboardCopy, write=FOnClipboardCopy};
	__property TClipboardEvent OnClipboardCut = {read=FOnClipboardCut, write=FOnClipboardCut};
	__property TClipboardEvent OnClipboardPaste = {read=FOnClipboardPaste, write=FOnClipboardPaste};
	void __fastcall SetAppearanceStyle(TItemAppearance* ItemAppearance, Advstyleif::TTMSStyle AStyle);
	
public:
	__fastcall virtual TAdvCustomDropDown(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomDropDown(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	Advstyleif::TTMSStyle __fastcall GetComponentStyle(void);
	HIDESBASE void __fastcall SelectAll(void);
	void __fastcall SelectBeforeDecimal(void);
	void __fastcall SelectAfterDecimal(void);
	void __fastcall ShowDropDown(void);
	void __fastcall HideDropDown(bool CancelChanges = false);
	__property bool DroppedDown = {read=FDroppedDown, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomDropDown(HWND ParentWindow) : Mask::TCustomMaskEdit(ParentWindow) { }
	
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


class DELPHICLASS TAdvDropDown;
class PASCALIMPLEMENTATION TAdvDropDown : public TAdvCustomDropDown
{
	typedef TAdvCustomDropDown inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property ImeMode = {default=3};
	__property ImeName;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property DropDownColor = {default=16777215};
	__property DropDownColorTo = {default=536870911};
	__property DropDownBorderColor = {default=0};
	__property DropDownBorderWidth = {default=1};
	__property DropDownShadow = {default=1};
	__property DropDownWidth = {default=0};
	__property DropDownHeight = {default=0};
	__property DropPosition = {default=0};
	__property DropDownButtonWidth = {default=17};
	__property DropDownButtonHint;
	__property DropDownSizeable = {default=1};
	__property Enabled = {default=1};
	__property EditorEnabled = {default=1};
	__property Font;
	__property DropDownButtonGlyph;
	__property Images;
	__property Version;
	__property ReadOnly = {default=0};
	__property Text;
	__property ButtonAppearance;
	__property DropDownHeader;
	__property DropDownFooter;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property OnEnter;
	__property OnExit;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnBeforeDropDown;
	__property OnDropDown;
	__property OnBeforeDropUp;
	__property OnDropUp;
	__property OnDropDownHeaderButtonClick;
	__property OnDropDownFooterButtonClick;
	__property OnDrawHeader;
	__property OnDrawFooter;
	__property OnGetHeaderText;
	__property OnGetFooterText;
public:
	/* TAdvCustomDropDown.Create */ inline __fastcall virtual TAdvDropDown(Classes::TComponent* AOwner) : TAdvCustomDropDown(AOwner) { }
	/* TAdvCustomDropDown.Destroy */ inline __fastcall virtual ~TAdvDropDown(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvDropDown(HWND ParentWindow) : TAdvCustomDropDown(ParentWindow) { }
	
};


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


class DELPHICLASS TSelectorItem;
class PASCALIMPLEMENTATION TSelectorItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	int FImageIndex;
	bool FEnabled;
	Graphics::TColor FColor;
	Graphics::TPicture* FImage;
	Types::TRect FRect;
	System::UnicodeString FHint;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetImage(const Graphics::TPicture* Value);
	void __fastcall SetImageIndex(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	__property Types::TRect Rect = {read=FRect, write=FRect};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	
public:
	__fastcall virtual TSelectorItem(Classes::TCollection* Collection);
	__fastcall virtual ~TSelectorItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Graphics::TPicture* Image = {read=FImage, write=SetImage};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
};


class DELPHICLASS TSelectorItems;
class PASCALIMPLEMENTATION TSelectorItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TSelectorItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TSelectorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TSelectorItem* Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TSelectorItems(Classes::TPersistent* AOwner);
	__property TSelectorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TSelectorItem* __fastcall Add(void);
	HIDESBASE TSelectorItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TSelectorItems(void) { }
	
};


class PASCALIMPLEMENTATION TItemAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TPersistent* FOwner;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColorMirrorHotTo;
	Graphics::TColor FBorderColor;
	Graphics::TColor FColorMirrorHot;
	Graphics::TColor FColorSelectedTo;
	Graphics::TColor FColorSelected;
	Graphics::TColor FEdgeColor;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FBorderColorBottom;
	Graphics::TColor FColorHot;
	Graphics::TColor FBorderColorTop;
	Graphics::TColor FColorMirrorSelectedTo;
	Graphics::TColor FColorMirrorSelected;
	Graphics::TColor FColorSelectedText;
	Graphics::TColor FColorHotText;
	TSelectionColorStyle FColorStyle;
	Graphics::TFont* FFont;
	void __fastcall SetColorStyle(const TSelectionColorStyle Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TSelectionColorStyle ColorStyle = {read=FColorStyle, write=SetColorStyle, nodefault};
	
public:
	__fastcall TItemAppearance(Classes::TComponent* AOwner);
	__fastcall virtual ~TItemAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
	__property Graphics::TColor BorderColorTop = {read=FBorderColorTop, write=FBorderColorTop, nodefault};
	__property Graphics::TColor BorderColorBottom = {read=FBorderColorBottom, write=FBorderColorBottom, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=FColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=FColorHotTo, nodefault};
	__property Graphics::TColor ColorHotText = {read=FColorHotText, write=FColorHotText, nodefault};
	__property Graphics::TColor ColorMirrorHot = {read=FColorMirrorHot, write=FColorMirrorHot, nodefault};
	__property Graphics::TColor ColorMirrorHotTo = {read=FColorMirrorHotTo, write=FColorMirrorHotTo, nodefault};
	__property Graphics::TColor ColorSelected = {read=FColorSelected, write=FColorSelected, nodefault};
	__property Graphics::TColor ColorSelectedTo = {read=FColorSelectedTo, write=FColorSelectedTo, nodefault};
	__property Graphics::TColor ColorMirrorSelected = {read=FColorMirrorSelected, write=FColorMirrorSelected, nodefault};
	__property Graphics::TColor ColorMirrorSelectedTo = {read=FColorMirrorSelectedTo, write=FColorMirrorSelectedTo, nodefault};
	__property Graphics::TColor ColorSelectedText = {read=FColorSelectedText, write=FColorSelectedText, nodefault};
	__property Graphics::TColor EdgeColor = {read=FEdgeColor, write=FEdgeColor, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
};


class DELPHICLASS TCustomItemSelector;
class DELPHICLASS TAdvCustomItemSelector;
class PASCALIMPLEMENTATION TCustomItemSelector : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FItemIndex;
	int FItemHot;
	int FOffSetX;
	int FOffSetY;
	int FItemOffSetX;
	int FItemOffSetY;
	int FCaptionGap;
	TAdvCustomItemSelector* FAdvItemSelector;
	Classes::TNotifyEvent FOnItemSelect;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetItemOffSetX(const int Value);
	void __fastcall SetItemOffSetY(const int Value);
	void __fastcall SetCaptionGap(const int Value);
	void __fastcall SetItemHot(const int Value);
	int __fastcall GetColumns(void);
	TSelectorItems* __fastcall GetItems(void);
	TSelectorType __fastcall GetSelectorType(void);
	TItemLayout __fastcall GetItemLayout(void);
	Imglist::TCustomImageList* __fastcall GetImages(void);
	TSelectionColorStyle __fastcall GetItemColorStyle(void);
	Graphics::TColor __fastcall GetItemColorHot(void);
	Graphics::TColor __fastcall GetItemColorHotTo(void);
	Graphics::TColor __fastcall GetItemColorSelected(void);
	Graphics::TColor __fastcall GetItemColorSelectedTo(void);
	int __fastcall GetColorBoxHeight(void);
	int __fastcall GetColorBoxWidth(void);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	void __fastcall DrawItems(Graphics::TCanvas* ACanvas);
	virtual void __fastcall DrawItem(int Index, Graphics::TCanvas* ACanvas);
	virtual Types::TRect __fastcall GetInnerRect(void);
	virtual tagSIZE __fastcall GetItemSize(void);
	virtual void __fastcall InvalidateItem(int Index);
	int __fastcall ItemAtPos(int X, int Y);
	Types::TRect __fastcall GetItemRect(int Index);
	virtual void __fastcall UpdateRectAndSize(void);
	__property int ItemOffSetX = {read=FItemOffSetX, write=SetItemOffSetX, default=4};
	__property int ItemOffSetY = {read=FItemOffSetY, write=SetItemOffSetY, default=4};
	__property int CaptionGap = {read=FCaptionGap, write=SetCaptionGap, default=4};
	__property int ItemHot = {read=FItemHot, write=SetItemHot, default=-1};
	
public:
	__fastcall virtual TCustomItemSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomItemSelector(void);
	HIDESBASE void __fastcall SelectFirst(void);
	void __fastcall SelectLast(void);
	HIDESBASE void __fastcall SelectNext(void);
	void __fastcall SelectPrevious(void);
	bool __fastcall LookupItem(System::UnicodeString s);
	void __fastcall HotNext(void);
	void __fastcall HotPrevious(void);
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property int Columns = {read=GetColumns, nodefault};
	__property TSelectorItems* Items = {read=GetItems};
	__property TSelectorType SelectorType = {read=GetSelectorType, nodefault};
	__property TItemLayout ItemLayout = {read=GetItemLayout, nodefault};
	__property Imglist::TCustomImageList* Images = {read=GetImages};
	__property TSelectionColorStyle ItemColorStyle = {read=GetItemColorStyle, nodefault};
	__property Graphics::TColor ItemColorHot = {read=GetItemColorHot, nodefault};
	__property Graphics::TColor ItemColorHotTo = {read=GetItemColorHotTo, nodefault};
	__property Graphics::TColor ItemColorSelected = {read=GetItemColorSelected, nodefault};
	__property Graphics::TColor ItemColorSelectedTo = {read=GetItemColorSelectedTo, nodefault};
	__property int ColorBoxHeight = {read=GetColorBoxHeight, nodefault};
	__property int ColorBoxWidth = {read=GetColorBoxWidth, nodefault};
	__property TAdvCustomItemSelector* AdvItemSelector = {read=FAdvItemSelector};
	__property Classes::TNotifyEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomItemSelector(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvCustomItemSelector : public Forms::TScrollingWinControl
{
	typedef Forms::TScrollingWinControl inherited;
	
private:
	TSelectorItems* FItems;
	TSelectorType FSelectorType;
	TItemLayout FItemLayout;
	int FColumns;
	int FColorBoxWidth;
	int FColorBoxHeight;
	Imglist::TCustomImageList* FImages;
	TCustomItemSelector* FItemSelectorPanel;
	Classes::TNotifyEvent FOnItemSelect;
	TItemAppearance* FItemAppearance;
	TDrawItemEvent FOnDrawItem;
	TItemSizeEvent FOnItemSize;
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	void __fastcall OnItemChanged(System::TObject* Sender);
	void __fastcall OnPanelItemSelect(System::TObject* SEnder);
	void __fastcall SetItems(const TSelectorItems* Value);
	void __fastcall SetSelectorType(const TSelectorType Value);
	void __fastcall SetItemLayout(const TItemLayout Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetColorBoxHeight(const int Value);
	void __fastcall SetColorBoxWidth(const int Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall OnItemAppearanceChanged(System::TObject* Sender);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetItemAppearance(const TItemAppearance* Value);
	int __fastcall GetItemHot(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	void __fastcall CreateSelectorPanel(void);
	tagSIZE __fastcall GetItemPanelSize(void);
	
public:
	__fastcall virtual TAdvCustomItemSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomItemSelector(void);
	HIDESBASE void __fastcall SelectFirst(void);
	void __fastcall SelectLast(void);
	HIDESBASE void __fastcall SelectNext(void);
	void __fastcall SelectPrevious(void);
	void __fastcall HotNext(void);
	void __fastcall HotPrevious(void);
	void __fastcall ScrollItemInView(int Index);
	int __fastcall GetVisibleItemCount(void);
	bool __fastcall LookupItem(System::UnicodeString s);
	void __fastcall UpdateSelectorPanel(void);
	__property int ItemHot = {read=GetItemHot, nodefault};
	
__published:
	__property Color = {default=-16777211};
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property TSelectorItems* Items = {read=FItems, write=SetItems};
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property TSelectorType SelectorType = {read=FSelectorType, write=SetSelectorType, default=0};
	__property TItemLayout ItemLayout = {read=FItemLayout, write=SetItemLayout, default=1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property TItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
	__property int ColorBoxHeight = {read=FColorBoxHeight, write=SetColorBoxHeight, nodefault};
	__property int ColorBoxWidth = {read=FColorBoxWidth, write=SetColorBoxWidth, nodefault};
	__property Classes::TNotifyEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
	__property TItemSizeEvent OnItemSize = {read=FOnItemSize, write=FOnItemSize};
	__property OnResize;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomItemSelector(HWND ParentWindow) : Forms::TScrollingWinControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;
static const ShortInt DD_HEADERHEIGHT = 0x16;
static const ShortInt DD_FOOTERHEIGHT = 0x16;
static const ShortInt DD_DROPDOWNBUTTONWIDTH = 0x11;
static const ShortInt DD_DROPDOWNBUTTONHEIGHT = 0x11;
static const ShortInt DD_IMAGEXOFFSET = 0x4;
static const ShortInt DD_IMAGEGAP = 0x4;
static const ShortInt GRIP_SIZE = 0xf;
static const ShortInt DD_COLORBOXHEIGHT = 0xe;
static const ShortInt DD_COLORBOXWIDTH = 0xe;
static const ShortInt DD_BUTTONOFFSET_X = 0x4;
static const ShortInt DD_BUTTONOFFSET_Y = 0x2;
static const ShortInt DD_MINHEIGHT = 0x32;
static const ShortInt DD_MINWIDTH = 0x50;
#define ErrText L"Error"
extern PACKAGE void __fastcall DrawGradient(Graphics::TCanvas* Canvas, Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, const Types::TRect &R, bool Direction);
extern PACKAGE Graphics::TColor __fastcall BrightnessColor(Graphics::TColor Col, int Brightness)/* overload */;
extern PACKAGE Graphics::TColor __fastcall BrightnessColor(Graphics::TColor Col, int BR, int BG, int BB)/* overload */;
extern PACKAGE void __fastcall DrawButtonContent(Graphics::TCanvas* Canvas, const Types::TRect &R, System::UnicodeString Caption, Imglist::TCustomImageList* Images, int ImageIndex);
extern PACKAGE tagSIZE __fastcall GetTextSize(Graphics::TCanvas* Canvas, System::UnicodeString Text);
extern PACKAGE System::UnicodeString __fastcall GetTextOfSize(Graphics::TCanvas* Canvas, System::UnicodeString Text, int cx, bool AddEllipsis = true);
extern PACKAGE tagSIZE __fastcall DrawHTMLEX(Graphics::TCanvas* Canvas, System::UnicodeString s, const Types::TRect &R, Imglist::TCustomImageList* Images, bool RealDraw, unsigned WinHandle);

}	/* namespace Advdropdown */
using namespace Advdropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvdropdownHPP
