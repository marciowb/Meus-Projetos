// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmlbtns.pas' rev: 21.00

#ifndef HtmlbtnsHPP
#define HtmlbtnsHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Btnxpvs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmlbtns
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TButtonType { btClassic, btBorland, btFlat, btTMS, btWinXP, btTheme };
#pragma option pop

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

class DELPHICLASS TCustomHTMLCheckBox;
class PASCALIMPLEMENTATION TCustomHTMLCheckBox : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDown;
	Stdctrls::TCheckBoxState FState;
	bool FFocused;
	Graphics::TColor FCheckColor;
	TButtonType FButtonType;
	bool FReturnIsTab;
	Controls::TImageList* FImages;
	System::UnicodeString FAnchor;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	TAnchorClick FAnchorExit;
	Graphics::TColor FURLColor;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Stdctrls::TTextLayout FBtnVAlign;
	Classes::TAlignment FAlignment;
	bool FEllipsis;
	System::UnicodeString FCaption;
	Picturecontainer::TPictureContainer* FContainer;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	bool FIsWinXP;
	bool FHot;
	bool FClicksDisabled;
	Controls::TCursor FOldCursor;
	bool FReadOnly;
	bool FMouseDown;
	Graphics::TBitmap* FBkgBmp;
	bool FBkgCache;
	bool FTransparentCaching;
	bool FTransparent;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	void __fastcall SetCheckColor(Graphics::TColor Value);
	void __fastcall SetState(Stdctrls::TCheckBoxState Value);
	void __fastcall SetChecked(bool Value);
	bool __fastcall GetChecked(void);
	void __fastcall SetCaption(System::UnicodeString Value);
	void __fastcall SetButtonType(const TButtonType Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall IsAnchor(int x, int y);
	void __fastcall SetButtonVertAlign(const Stdctrls::TTextLayout Value);
	void __fastcall SetAlignment(const Classes::TLeftRight Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall DrawParentImage(Controls::TControl* Control, Graphics::TCanvas* Dest);
	void __fastcall SetTransparent(bool value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall SetDown(bool Value);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall Loaded(void);
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property bool ClicksDisabled = {read=FClicksDisabled, write=FClicksDisabled, nodefault};
	
public:
	__fastcall virtual TCustomHTMLCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomHTMLCheckBox(void);
	virtual void __fastcall Toggle(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property bool TransparentChaching = {read=FTransparentCaching, write=FTransparentCaching, nodefault};
	
__published:
	__property Action;
	__property Anchors = {default=3};
	__property Constraints;
	__property Color = {default=-16777211};
	__property Classes::TLeftRight Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property TButtonType ButtonType = {read=FButtonType, write=SetButtonType, nodefault};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor CheckColor = {read=FCheckColor, write=SetCheckColor, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property ParentFont = {default=1};
	__property ParentColor = {default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property PopupMenu;
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property ShowHint;
	__property Stdctrls::TCheckBoxState State = {read=FState, write=SetState, default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomHTMLCheckBox(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS THTMLCheckBox;
class PASCALIMPLEMENTATION THTMLCheckBox : public TCustomHTMLCheckBox
{
	typedef TCustomHTMLCheckBox inherited;
	
__published:
	__property Checked = {default=0};
public:
	/* TCustomHTMLCheckBox.Create */ inline __fastcall virtual THTMLCheckBox(Classes::TComponent* AOwner) : TCustomHTMLCheckBox(AOwner) { }
	/* TCustomHTMLCheckBox.Destroy */ inline __fastcall virtual ~THTMLCheckBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLCheckBox(HWND ParentWindow) : TCustomHTMLCheckBox(ParentWindow) { }
	
};


class DELPHICLASS THTMLRadioButton;
class PASCALIMPLEMENTATION THTMLRadioButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDown;
	bool FChecked;
	bool FFocused;
	Graphics::TColor FCheckColor;
	System::Byte FGroupIndex;
	TButtonType FButtonType;
	bool FReturnIsTab;
	Controls::TImageList* FImages;
	System::UnicodeString FAnchor;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	TAnchorClick FAnchorExit;
	Graphics::TColor FURLColor;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Stdctrls::TTextLayout FBtnVAlign;
	Classes::TAlignment FAlignment;
	bool FEllipsis;
	System::UnicodeString FCaption;
	Picturecontainer::TPictureContainer* FContainer;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	bool FIsWinXP;
	bool FHot;
	bool FClicksDisabled;
	Controls::TCursor FOldCursor;
	bool FMouseDown;
	Graphics::TBitmap* FBkgBmp;
	bool FBkgCache;
	bool FTransparent;
	bool FTransparentCaching;
	void __fastcall TurnSiblingsOff(void);
	void __fastcall SetDown(bool Value);
	void __fastcall SetChecked(bool Value);
	void __fastcall SetCheckColor(Graphics::TColor Value);
	void __fastcall SetButtonType(const TButtonType Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall IsAnchor(int x, int y);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	void __fastcall SetButtonVertAlign(const Stdctrls::TTextLayout Value);
	void __fastcall SetAlignment(const Classes::TLeftRight Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall DrawParentImage(Controls::TControl* Control, Graphics::TCanvas* Dest);
	void __fastcall SetTransparent(bool value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall DoClick(void);
	__property bool ClicksDisabled = {read=FClicksDisabled, write=FClicksDisabled, nodefault};
	
public:
	__fastcall virtual THTMLRadioButton(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLRadioButton(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property bool TransparentChaching = {read=FTransparentCaching, write=FTransparentCaching, nodefault};
	
__published:
	__property Action;
	__property Anchors = {default=3};
	__property Constraints;
	__property Color = {default=-16777211};
	__property Classes::TLeftRight Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property TButtonType ButtonType = {read=FButtonType, write=SetButtonType, nodefault};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor CheckColor = {read=FCheckColor, write=SetCheckColor, default=0};
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property Enabled = {default=1};
	__property Font;
	__property System::Byte GroupIndex = {read=FGroupIndex, write=FGroupIndex, default=0};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property ParentFont = {default=1};
	__property ParentColor = {default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property PopupMenu;
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLRadioButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


#pragma option push -b-
enum TBtnVAlignment { vaCenter, vaTop, vaBottom };
#pragma option pop

#pragma option push -b-
enum TBtnHAlignment { haCenter, haHTML, haLeft, haRight };
#pragma option pop

#pragma option push -b-
enum TBtnBackground { stNormal, stNoise, stDiagShade, stHShade, stVShade, stHBump, stVBump, stSoftBump, stHardBump, stLMetal, stRMetal, stIRadial, stORadial, stHShadeInv, stVShadeInv, stXPTheme };
#pragma option pop

class DELPHICLASS THTMLButton;
class PASCALIMPLEMENTATION THTMLButton : public Stdctrls::TButton
{
	typedef Stdctrls::TButton inherited;
	
private:
	Graphics::TCanvas* FCanvas;
	Buttons::TButtonStyle FStyle;
	Buttons::TBitBtnKind FKind;
	Buttons::TButtonLayout FLayout;
	int FSpacing;
	int FMargin;
	Picturecontainer::THTMLPictureCache* FImageCache;
	bool IsFocused;
	Controls::TImageList* FImages;
	bool FEllipsis;
	System::UnicodeString FCaption;
	Picturecontainer::TPictureContainer* FContainer;
	bool FFlat;
	bool FHasMouse;
	Graphics::TColor FColor;
	Graphics::TColor FDownColor;
	Graphics::TColor FHoverColor;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	Graphics::TColor FBorderColor;
	bool FIsWinXP;
	TBtnVAlignment FVAlignment;
	TBtnHAlignment FAlignment;
	Graphics::TBitmap* FShadedBkg;
	TBtnBackground FBackground;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	void __fastcall DrawItem(const tagDRAWITEMSTRUCT &DrawItemStruct);
	bool __fastcall IsCustom(void);
	HIDESBASE void __fastcall SetStyle(Buttons::TButtonStyle Value);
	void __fastcall SetLayout(Buttons::TButtonLayout Value);
	void __fastcall SetSpacing(int Value);
	void __fastcall SetMargin(int Value);
	MESSAGE void __fastcall CNMeasureItem(Messages::TWMMeasureItem &Message);
	MESSAGE void __fastcall CNDrawItem(Messages::TWMDrawItem &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetFlat(const bool Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetVAlignment(const TBtnVAlignment Value);
	void __fastcall SetAlignment(const TBtnHAlignment Value);
	void __fastcall SetBackground(const TBtnBackground Value);
	void __fastcall ShadeBkg(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall SetButtonStyle(bool ADefault);
	
public:
	__fastcall virtual THTMLButton(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLButton(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Action;
	__property Anchors = {default=3};
	__property Constraints;
	__property BiDiMode;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property TBtnHAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property TBtnBackground Background = {read=FBackground, write=SetBackground, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Cancel = {stored=IsCustom, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Default = {stored=IsCustom, default=0};
	__property Graphics::TColor DownColor = {read=FDownColor, write=FDownColor, default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property Enabled = {default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Font;
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=FHoverColor, default=-16777201};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property ModalResult = {stored=IsCustom, default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property ShowHint;
	__property Buttons::TButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property TBtnVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, nodefault};
	__property Visible = {default=1};
	__property OnEnter;
	__property OnExit;
	__property OnClick;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnEndDock;
	__property OnStartDrag;
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLButton(HWND ParentWindow) : Stdctrls::TButton(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TEnabledEvent)(System::TObject* Sender, int ItemIndex, bool &Enabled);

class DELPHICLASS TCustomHTMLRadioGroup;
class PASCALIMPLEMENTATION TCustomHTMLRadioGroup : public Stdctrls::TCustomGroupBox
{
	typedef Stdctrls::TCustomGroupBox inherited;
	
private:
	Classes::TList* FButtons;
	Classes::TStrings* FItems;
	int FItemIndex;
	int FColumns;
	bool FReading;
	bool FUpdating;
	TButtonType FButtonType;
	Graphics::TColor FCheckColor;
	Classes::TAlignment FAlignment;
	Stdctrls::TTextLayout FBtnVAlign;
	Controls::TImageList* FImages;
	Picturecontainer::TPictureContainer* FContainer;
	bool FEllipsis;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	TEnabledEvent FOnIsEnabled;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	TAnchorClick FAnchorExit;
	void __fastcall SetButtonType(const TButtonType Value);
	void __fastcall ArrangeButtons(void);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall SetButtonCount(int Value);
	void __fastcall SetColumns(int Value);
	void __fastcall SetItemIndex(int Value);
	void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall UpdateButtons(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall SetCheckColor(const Graphics::TColor Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetButtonVertAlign(const Stdctrls::TTextLayout Value);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall OnAnchorClickEvent(System::TObject* Sender, System::UnicodeString Anchor);
	void __fastcall OnAnchorEnterEvent(System::TObject* Sender, System::UnicodeString Anchor);
	void __fastcall OnAnchorExitEvent(System::TObject* Sender, System::UnicodeString Anchor);
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	
public:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__fastcall virtual TCustomHTMLRadioGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomHTMLRadioGroup(void);
	DYNAMIC void __fastcall FlipChildren(bool AllLevels);
	void __fastcall PushKey(System::WideChar &Key);
	void __fastcall PushKeyDown(System::Word &Key, Classes::TShiftState Shift);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property TButtonType ButtonType = {read=FButtonType, write=SetButtonType, default=0};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property Graphics::TColor CheckColor = {read=FCheckColor, write=SetCheckColor, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=12632256};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property TEnabledEvent OnIsEnabled = {read=FOnIsEnabled, write=FOnIsEnabled};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomHTMLRadioGroup(HWND ParentWindow) : Stdctrls::TCustomGroupBox(ParentWindow) { }
	
};


class DELPHICLASS THTMLRadioGroup;
class PASCALIMPLEMENTATION THTMLRadioGroup : public TCustomHTMLRadioGroup
{
	typedef TCustomHTMLRadioGroup inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ButtonType = {default=0};
	__property Caption;
	__property Color = {default=-16777211};
	__property Columns = {default=1};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ItemIndex = {default=-1};
	__property Items;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnEndDock;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TCustomHTMLRadioGroup.Create */ inline __fastcall virtual THTMLRadioGroup(Classes::TComponent* AOwner) : TCustomHTMLRadioGroup(AOwner) { }
	/* TCustomHTMLRadioGroup.Destroy */ inline __fastcall virtual ~THTMLRadioGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLRadioGroup(HWND ParentWindow) : TCustomHTMLRadioGroup(ParentWindow) { }
	
};


class DELPHICLASS TCustomHTMLCheckGroup;
class PASCALIMPLEMENTATION TCustomHTMLCheckGroup : public Stdctrls::TCustomGroupBox
{
	typedef Stdctrls::TCustomGroupBox inherited;
	
private:
	Classes::TList* FButtons;
	Classes::TStrings* FItems;
	int FColumns;
	bool FReading;
	bool FUpdating;
	TButtonType FButtonType;
	Graphics::TColor FCheckColor;
	Classes::TAlignment FAlignment;
	Stdctrls::TTextLayout FBtnVAlign;
	Controls::TImageList* FImages;
	Picturecontainer::TPictureContainer* FContainer;
	bool FEllipsis;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	TEnabledEvent FOnIsEnabled;
	TAnchorClick FAnchorClick;
	TAnchorClick FAnchorEnter;
	TAnchorClick FAnchorExit;
	void __fastcall SetButtonType(const TButtonType Value);
	void __fastcall ArrangeButtons(void);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall SetButtonCount(int Value);
	void __fastcall SetColumns(int Value);
	void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall UpdateButtons(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall SetCheckColor(const Graphics::TColor Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetButtonVertAlign(const Stdctrls::TTextLayout Value);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	bool __fastcall GetChecked(int Index);
	void __fastcall SetChecked(int Index, const bool Value);
	bool __fastcall GetReadOnly(int Index);
	void __fastcall SetReadOnly(int Index, const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall OnAnchorClickEvent(System::TObject* Sender, System::UnicodeString Anchor);
	void __fastcall OnAnchorEnterEvent(System::TObject* Sender, System::UnicodeString Anchor);
	void __fastcall OnAnchorExitEvent(System::TObject* Sender, System::UnicodeString Anchor);
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	
public:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__fastcall virtual TCustomHTMLCheckGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomHTMLCheckGroup(void);
	DYNAMIC void __fastcall FlipChildren(bool AllLevels);
	void __fastcall PushKey(System::WideChar &Key);
	void __fastcall PushKeyDown(System::Word &Key, Classes::TShiftState Shift);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property bool ReadOnly[int Index] = {read=GetReadOnly, write=SetReadOnly};
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property TButtonType ButtonType = {read=FButtonType, write=SetButtonType, default=0};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property Graphics::TColor CheckColor = {read=FCheckColor, write=SetCheckColor, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=12632256};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property TEnabledEvent OnIsEnabled = {read=FOnIsEnabled, write=FOnIsEnabled};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomHTMLCheckGroup(HWND ParentWindow) : Stdctrls::TCustomGroupBox(ParentWindow) { }
	
};


class DELPHICLASS THTMLCheckGroup;
class PASCALIMPLEMENTATION THTMLCheckGroup : public TCustomHTMLCheckGroup
{
	typedef TCustomHTMLCheckGroup inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ButtonType = {default=0};
	__property Caption;
	__property Color = {default=-16777211};
	__property Columns = {default=1};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Items;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnEndDock;
	__property OnStartDock;
	__property OnStartDrag;
public:
	/* TCustomHTMLCheckGroup.Create */ inline __fastcall virtual THTMLCheckGroup(Classes::TComponent* AOwner) : TCustomHTMLCheckGroup(AOwner) { }
	/* TCustomHTMLCheckGroup.Destroy */ inline __fastcall virtual ~THTMLCheckGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLCheckGroup(HWND ParentWindow) : TCustomHTMLCheckGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x4;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Htmlbtns */
using namespace Htmlbtns;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmlbtnsHPP
