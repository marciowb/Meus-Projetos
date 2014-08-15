// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advofficebuttons.pas' rev: 21.00

#ifndef AdvofficebuttonsHPP
#define AdvofficebuttonsHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Advgroupbox.hpp>	// Pascal unit
#include <Aobxpvs.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advofficebuttons
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

class DELPHICLASS TAdvOfficeCheckBoxActionLink;
class DELPHICLASS TCustomAdvOfficeCheckBox;
class PASCALIMPLEMENTATION TAdvOfficeCheckBoxActionLink : public Controls::TControlActionLink
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	int FImageIndex;
	TCustomAdvOfficeCheckBox* FClient;
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TAdvOfficeCheckBoxActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TAdvOfficeCheckBoxActionLink(void) { }
	
};


class PASCALIMPLEMENTATION TCustomAdvOfficeCheckBox : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDown;
	Stdctrls::TCheckBoxState FState;
	bool FFocused;
	bool FShowFocus;
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
	Graphics::TBitmap* FBkgBmp;
	bool FBkgCache;
	bool FTransparentCaching;
	bool FDrawBkg;
	bool FGotClick;
	Graphics::TColor FDisabledFontColor;
	bool FInternalClick;
	bool FThemed;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	void __fastcall SetState(Stdctrls::TCheckBoxState Value);
	void __fastcall SetCaption(System::UnicodeString Value);
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
	void __fastcall SetThemed(const bool Value);
	void __fastcall DrawParentImage(Controls::TControl* Control, Graphics::TCanvas* Dest);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall DrawCheck(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall SetChecked(bool Value);
	virtual bool __fastcall GetChecked(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall SetDown(bool Value);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property bool ClicksDisabled = {read=FClicksDisabled, write=FClicksDisabled, nodefault};
	DYNAMIC Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	
public:
	__fastcall virtual TCustomAdvOfficeCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomAdvOfficeCheckBox(void);
	virtual void __fastcall Toggle(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property bool TransparentChaching = {read=FTransparentCaching, write=FTransparentCaching, nodefault};
	__property bool DrawBkg = {read=FDrawBkg, write=FDrawBkg, nodefault};
	__property Classes::TLeftRight Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor DisabledFontColor = {read=FDisabledFontColor, write=FDisabledFontColor, default=8421504};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=FShowFocus, default=1};
	__property Stdctrls::TCheckBoxState State = {read=FState, write=SetState, default=0};
	__property bool Themed = {read=FThemed, write=SetThemed, default=0};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomAdvOfficeCheckBox(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeCheckBox;
class PASCALIMPLEMENTATION TAdvOfficeCheckBox : public TCustomAdvOfficeCheckBox
{
	typedef TCustomAdvOfficeCheckBox inherited;
	
__published:
	__property Action;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property Color = {default=-16777211};
	__property Checked = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentColor = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Alignment;
	__property ButtonVertAlign = {default=0};
	__property Caption;
	__property DisabledFontColor = {default=8421504};
	__property Down = {default=0};
	__property Ellipsis = {default=0};
	__property Images;
	__property PictureContainer;
	__property ReadOnly = {default=0};
	__property ReturnIsTab;
	__property ShadowColor = {default=8421504};
	__property ShadowOffset = {default=1};
	__property ShowFocus = {default=1};
	__property State = {default=0};
	__property Themed = {default=0};
	__property URLColor = {default=16711680};
	__property OnAnchorClick;
	__property OnAnchorEnter;
	__property OnAnchorExit;
	__property Version;
public:
	/* TCustomAdvOfficeCheckBox.Create */ inline __fastcall virtual TAdvOfficeCheckBox(Classes::TComponent* AOwner) : TCustomAdvOfficeCheckBox(AOwner) { }
	/* TCustomAdvOfficeCheckBox.Destroy */ inline __fastcall virtual ~TAdvOfficeCheckBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeCheckBox(HWND ParentWindow) : TCustomAdvOfficeCheckBox(ParentWindow) { }
	
};


class DELPHICLASS TCustomAdvOfficeRadioButton;
class PASCALIMPLEMENTATION TCustomAdvOfficeRadioButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDown;
	bool FChecked;
	bool FFocused;
	bool FShowFocus;
	System::Byte FGroupIndex;
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
	Graphics::TBitmap* FBkgBmp;
	bool FBkgCache;
	bool FTransparentCaching;
	bool FDrawBkg;
	bool FGotClick;
	Graphics::TColor FDisabledFontColor;
	bool FThemed;
	void __fastcall TurnSiblingsOff(void);
	void __fastcall SetDown(bool Value);
	void __fastcall SetChecked(bool Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	System::UnicodeString __fastcall IsAnchor(int x, int y);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
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
	void __fastcall SetThemed(const bool Value);
	int __fastcall GetVersionNr(void);
	void __fastcall DrawParentImage(Controls::TControl* Control, Graphics::TCanvas* Dest);
	
protected:
	void __fastcall DrawRadio(void);
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
	__fastcall virtual TCustomAdvOfficeRadioButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomAdvOfficeRadioButton(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property bool TransparentChaching = {read=FTransparentCaching, write=FTransparentCaching, nodefault};
	__property bool DrawBkg = {read=FDrawBkg, write=FDrawBkg, nodefault};
	__property Classes::TLeftRight Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	__property Graphics::TColor DisabledFontColor = {read=FDisabledFontColor, write=FDisabledFontColor, default=8421504};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property System::Byte GroupIndex = {read=FGroupIndex, write=FGroupIndex, default=0};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=FShowFocus, default=1};
	__property bool Themed = {read=FThemed, write=SetThemed, default=0};
	__property TAnchorClick OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomAdvOfficeRadioButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeRadioButton;
class PASCALIMPLEMENTATION TAdvOfficeRadioButton : public TCustomAdvOfficeRadioButton
{
	typedef TCustomAdvOfficeRadioButton inherited;
	
__published:
	__property Align = {default=0};
	__property Action;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentColor = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Visible = {default=1};
	__property Alignment;
	__property URLColor = {default=16711680};
	__property ButtonVertAlign = {default=0};
	__property Caption;
	__property Checked = {default=0};
	__property DisabledFontColor = {default=8421504};
	__property Down = {default=0};
	__property Ellipsis = {default=0};
	__property GroupIndex = {default=0};
	__property Images;
	__property PictureContainer;
	__property ReturnIsTab;
	__property ShadowColor = {default=8421504};
	__property ShadowOffset = {default=1};
	__property ShowFocus = {default=1};
	__property Themed = {default=0};
	__property OnAnchorClick;
	__property OnAnchorEnter;
	__property OnAnchorExit;
	__property Version;
public:
	/* TCustomAdvOfficeRadioButton.Create */ inline __fastcall virtual TAdvOfficeRadioButton(Classes::TComponent* AOwner) : TCustomAdvOfficeRadioButton(AOwner) { }
	/* TCustomAdvOfficeRadioButton.Destroy */ inline __fastcall virtual ~TAdvOfficeRadioButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeRadioButton(HWND ParentWindow) : TCustomAdvOfficeRadioButton(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TEnabledEvent)(System::TObject* Sender, int ItemIndex, bool &Enabled);

class DELPHICLASS TCustomAdvOfficeRadioGroup;
class PASCALIMPLEMENTATION TCustomAdvOfficeRadioGroup : public Advgroupbox::TAdvGroupBox
{
	typedef Advgroupbox::TAdvGroupBox inherited;
	
private:
	Classes::TList* FButtons;
	Classes::TStrings* FItems;
	int FItemIndex;
	int FColumns;
	bool FReading;
	bool FUpdating;
	Classes::TAlignment FAlignment;
	Stdctrls::TTextLayout FBtnVAlign;
	Controls::TImageList* FImages;
	Picturecontainer::TPictureContainer* FContainer;
	bool FEllipsis;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	bool FShowFocus;
	TEnabledEvent FOnIsEnabled;
	bool FIsReadOnly;
	Graphics::TColor FDisabledFontColor;
	bool FThemed;
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
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetButtonVertAlign(const Stdctrls::TTextLayout Value);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	HIDESBASE void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetThemed(const bool Value);
	HIDESBASE System::UnicodeString __fastcall GetVersion(void);
	HIDESBASE void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetShowFocus(const bool Value);
	
protected:
	HIDESBASE virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual bool __fastcall CanModify(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property bool IsReadOnly = {read=FIsReadOnly, write=FIsReadOnly, nodefault};
	__property bool Themed = {read=FThemed, write=SetThemed, default=0};
	
public:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__fastcall virtual TCustomAdvOfficeRadioGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomAdvOfficeRadioGroup(void);
	void __fastcall PushKey(System::WideChar &Key);
	void __fastcall PushKeyDown(System::Word &Key, Classes::TShiftState Shift);
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property Graphics::TColor DisabledFontColor = {read=FDisabledFontColor, write=FDisabledFontColor, default=8421504};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=12632256};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property TEnabledEvent OnIsEnabled = {read=FOnIsEnabled, write=FOnIsEnabled};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomAdvOfficeRadioGroup(HWND ParentWindow) : Advgroupbox::TAdvGroupBox(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeRadioGroup;
class PASCALIMPLEMENTATION TAdvOfficeRadioGroup : public TCustomAdvOfficeRadioGroup
{
	typedef TCustomAdvOfficeRadioGroup inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property Caption;
	__property Color = {default=-16777211};
	__property Columns = {default=1};
	__property Ctl3D = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ItemIndex = {default=-1};
	__property Items;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Themed = {default=0};
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
	__property Alignment = {default=0};
	__property ButtonVertAlign = {default=0};
	__property DisabledFontColor = {default=8421504};
	__property Ellipsis;
	__property Images;
	__property PictureContainer;
	__property ShadowColor = {default=12632256};
	__property ShadowOffset = {default=1};
	__property ShowFocus = {default=1};
	__property OnIsEnabled;
	__property Version;
public:
	/* TCustomAdvOfficeRadioGroup.Create */ inline __fastcall virtual TAdvOfficeRadioGroup(Classes::TComponent* AOwner) : TCustomAdvOfficeRadioGroup(AOwner) { }
	/* TCustomAdvOfficeRadioGroup.Destroy */ inline __fastcall virtual ~TAdvOfficeRadioGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeRadioGroup(HWND ParentWindow) : TCustomAdvOfficeRadioGroup(ParentWindow) { }
	
};


class DELPHICLASS TCustomAdvOfficeCheckGroup;
class PASCALIMPLEMENTATION TCustomAdvOfficeCheckGroup : public Advgroupbox::TAdvGroupBox
{
	typedef Advgroupbox::TAdvGroupBox inherited;
	
private:
	Classes::TList* FButtons;
	Classes::TStrings* FItems;
	int FColumns;
	bool FReading;
	bool FUpdating;
	Classes::TAlignment FAlignment;
	Stdctrls::TTextLayout FBtnVAlign;
	Controls::TImageList* FImages;
	Picturecontainer::TPictureContainer* FContainer;
	bool FEllipsis;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	bool FShowFocus;
	TEnabledEvent FOnIsEnabled;
	unsigned FValue;
	int FFocusButtonIdx;
	Graphics::TColor FDisabledFontColor;
	bool FThemed;
	void __fastcall ArrangeButtons(void);
	void __fastcall ButtonClick(System::TObject* Sender);
	void __fastcall CheckFocus(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall SetButtonCount(int Value);
	void __fastcall SetColumns(int Value);
	void __fastcall SetItems(Classes::TStrings* Value);
	void __fastcall UpdateButtons(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetButtonVertAlign(const Stdctrls::TTextLayout Value);
	void __fastcall SetContainer(const Picturecontainer::TPictureContainer* Value);
	HIDESBASE void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	bool __fastcall GetReadOnly(int Index);
	void __fastcall SetReadOnly(int Index, const bool Value);
	HIDESBASE System::UnicodeString __fastcall GetVersion(void);
	HIDESBASE void __fastcall SetVersion(const System::UnicodeString Value);
	HIDESBASE int __fastcall GetVersionNr(void);
	void __fastcall SetValue(const unsigned Value);
	unsigned __fastcall GetValue(void);
	void __fastcall SetThemed(const bool Value);
	void __fastcall SetShowFocus(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual bool __fastcall CanModify(void);
	virtual bool __fastcall GetChecked(int Index);
	virtual void __fastcall SetChecked(int Index, const bool Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property Classes::TStrings* Items = {read=FItems, write=SetItems};
	__property unsigned Value = {read=GetValue, write=SetValue, nodefault};
	__property bool Themed = {read=FThemed, write=SetThemed, default=0};
	
public:
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	__fastcall virtual TCustomAdvOfficeCheckGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomAdvOfficeCheckGroup(void);
	void __fastcall UpdateValue(void);
	void __fastcall PushKey(System::WideChar &Key);
	void __fastcall PushKeyDown(System::Word &Key, Classes::TShiftState Shift);
	__property bool Checked[int Index] = {read=GetChecked, write=SetChecked};
	__property bool ReadOnly[int Index] = {read=GetReadOnly, write=SetReadOnly};
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, nodefault};
	__property Graphics::TColor DisabledFontColor = {read=FDisabledFontColor, write=FDisabledFontColor, default=8421504};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=SetContainer};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=12632256};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property TEnabledEvent OnIsEnabled = {read=FOnIsEnabled, write=FOnIsEnabled};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomAdvOfficeCheckGroup(HWND ParentWindow) : Advgroupbox::TAdvGroupBox(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeCheckGroup;
class PASCALIMPLEMENTATION TAdvOfficeCheckGroup : public TCustomAdvOfficeCheckGroup
{
	typedef TCustomAdvOfficeCheckGroup inherited;
	
public:
	__property Value;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property Caption;
	__property Color = {default=-16777211};
	__property Columns = {default=1};
	__property Ctl3D = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property Items;
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Themed = {default=0};
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
	__property Alignment = {default=0};
	__property ButtonVertAlign = {default=0};
	__property Ellipsis;
	__property DisabledFontColor = {default=8421504};
	__property Images;
	__property PictureContainer;
	__property ShadowColor = {default=12632256};
	__property ShadowOffset = {default=1};
	__property ShowFocus = {default=1};
	__property Version;
	__property OnIsEnabled;
public:
	/* TCustomAdvOfficeCheckGroup.Create */ inline __fastcall virtual TAdvOfficeCheckGroup(Classes::TComponent* AOwner) : TCustomAdvOfficeCheckGroup(AOwner) { }
	/* TCustomAdvOfficeCheckGroup.Destroy */ inline __fastcall virtual ~TAdvOfficeCheckGroup(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeCheckGroup(HWND ParentWindow) : TCustomAdvOfficeCheckGroup(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x4;
static const ShortInt BLD_VER = 0x2;
static const int DefDisabledColor = 8421504;
extern PACKAGE bool TMS_NoClickForProgrammaticCheck;

}	/* namespace Advofficebuttons */
using namespace Advofficebuttons;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvofficebuttonsHPP
