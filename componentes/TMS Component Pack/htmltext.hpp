// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmltext.pas' rev: 21.00

#ifndef HtmltextHPP
#define HtmltextHPP

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
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmltext
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef System::UnicodeString TRichText;

typedef void __fastcall (__closure *TOnNewSize)(System::TObject* Sender, int NewWidth, int NewHeight);

typedef void __fastcall (__closure *TAnchorClick)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TAnchorHintEvent)(System::TObject* Sender, System::UnicodeString &Anchor);

#pragma option push -b-
enum TVAlignment { tvaTop, tvaCenter, tvaBottom };
#pragma option pop

#pragma option push -b-
enum TAutoSizeType { asVertical, asHorizontal, asBoth };
#pragma option pop

class DELPHICLASS THTMLStaticText;
class PASCALIMPLEMENTATION THTMLStaticText : public Stdctrls::TCustomStaticText
{
	typedef Stdctrls::TCustomStaticText inherited;
	
private:
	bool FBlinking;
	System::UnicodeString FAnchor;
	Types::TRect FCurrHoverRect;
	bool FAutoSizing;
	Classes::TStrings* FHTMLText;
	bool FAnchorHint;
	TAnchorClick FOnAnchorClick;
	TAnchorClick FOnAnchorEnter;
	TAnchorClick FOnAnchorExit;
	TAnchorClick FOnAnchorKeypress;
	TAnchorHintEvent FOnAnchorHint;
	Controls::TImageList* FImages;
	Picturecontainer::THTMLPictureCache* FImageCache;
	bool FHover;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	Graphics::TColor FShadowColor;
	int FShadowOffset;
	int Fupdatecount;
	int FTimerID;
	Graphics::TColor FURLColor;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	Controls::TBevelWidth FBevelWidth;
	Controls::TBorderWidth FBorderWidth;
	Forms::TFormBorderStyle FBorderStyle;
	int FFocusHyperLink;
	int FHoverHyperLink;
	int FOldHoverHyperlink;
	System::UnicodeString FFocusAnchor;
	int FNumHyperLinks;
	bool FEnableBlink;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	TVAlignment FVAlignment;
	int FTimerCount;
	TAutoSizeType FAutoSizeType;
	bool FEllipsis;
	Picturecontainer::TPictureContainer* FContainer;
	int FVOffset;
	bool FMiniScroll;
	bool FUpScroll;
	bool FDownScroll;
	bool FMouseDown;
	bool FAutoScroll;
	int FHTMLWidth;
	int FHTMLHeight;
	int FLineSpacing;
	TOnNewSize FOnNewSize;
	void __fastcall SetHTMLText(Classes::TStrings* value);
	void __fastcall SetImages(Controls::TImageList* value);
	void __fastcall SetURLColor(Graphics::TColor value);
	void __fastcall SetAutoSizeP(bool value);
	void __fastcall HTMLChanged(System::TObject* sender);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	HIDESBASE void __fastcall SetBevelWidth(Controls::TBevelWidth Value);
	HIDESBASE void __fastcall SetBorderWidth(Controls::TBorderWidth Value);
	HIDESBASE void __fastcall SetBorderStyle(Forms::TBorderStyle Value);
	void __fastcall SetHover(bool Value);
	System::UnicodeString __fastcall IsAnchor(int x, int y, Types::TRect &hoverrect);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	void __fastcall DoPaint(bool bkg);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetEnableBlink(const bool Value);
	HIDESBASE System::UnicodeString __fastcall GetText(void);
	void __fastcall SetVAlignment(const TVAlignment Value);
	void __fastcall SetAutoSizeType(const TAutoSizeType Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetVOffset(const int Value);
	void __fastcall SetMiniScroll(const bool Value);
	void __fastcall SetAutoScroll(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetLineSpacing(const int Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual System::UnicodeString __fastcall GetDisplText(void);
	virtual void __fastcall DoAnchorClick(System::UnicodeString Anchor);
	
public:
	__fastcall virtual THTMLStaticText(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLStaticText(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall Doit(void);
	__property System::UnicodeString Text = {read=GetText};
	__property int VOffset = {read=FVOffset, write=SetVOffset, nodefault};
	void __fastcall HilightText(System::UnicodeString HiText, bool DoCase);
	void __fastcall UnHilightText(void);
	void __fastcall MarkText(System::UnicodeString HiText, bool DoCase);
	void __fastcall UnMarkText(void);
	__property int HTMLWidth = {read=FHTMLWidth, nodefault};
	__property int HTMLHeight = {read=FHTMLHeight, nodefault};
	
__published:
	__property Align = {default=0};
	__property bool AutoScroll = {read=FAutoScroll, write=SetAutoScroll, default=0};
	__property TAutoSizeType AutoSizeType = {read=FAutoSizeType, write=SetAutoSizeType, default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Constraints;
	__property DragKind = {default=0};
	__property ParentBiDiMode = {default=1};
	__property bool AnchorHint = {read=FAnchorHint, write=FAnchorHint, default=0};
	__property bool AutoSizing = {read=FAutoSizing, write=SetAutoSizeP, default=0};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=0};
	__property Controls::TBevelWidth BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property Controls::TBorderWidth BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=0};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property bool EnableBlink = {read=FEnableBlink, write=SetEnableBlink, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property FocusControl;
	__property Font;
	__property bool Hover = {read=FHover, write=SetHover, default=0};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=FHoverColor, default=536870911};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=FHoverFontColor, default=536870911};
	__property Hint;
	__property Classes::TStrings* HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property int LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property bool MiniScroll = {read=FMiniScroll, write=SetMiniScroll, default=0};
	__property ParentShowHint = {default=1};
	__property ParentColor = {default=1};
	__property ParentFont = {default=1};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property PopupMenu;
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=1};
	__property ShowHint;
	__property TabStop = {default=0};
	__property TabOrder = {default=-1};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property TAnchorClick OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property TAnchorClick OnAnchorEnter = {read=FOnAnchorEnter, write=FOnAnchorEnter};
	__property TAnchorClick OnAnchorExit = {read=FOnAnchorExit, write=FOnAnchorExit};
	__property TAnchorClick OnAnchorKeypress = {read=FOnAnchorKeypress, write=FOnAnchorKeypress};
	__property TAnchorHintEvent OnAnchorHint = {read=FOnAnchorHint, write=FOnAnchorHint};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property TOnNewSize OnNewSize = {read=FOnNewSize, write=FOnNewSize};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLStaticText(HWND ParentWindow) : Stdctrls::TCustomStaticText(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Htmltext */
using namespace Htmltext;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmltextHPP
