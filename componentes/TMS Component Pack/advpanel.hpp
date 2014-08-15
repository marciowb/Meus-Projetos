// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpanel.pas' rev: 21.00

#ifndef AdvpanelHPP
#define AdvpanelHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advimage.hpp>	// Pascal unit
#include <Apxpvs.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpanel
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TBackGroundPosition { bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight, bpTiled, bpStretched, bpCenter };
#pragma option pop

#pragma option push -b-
enum TTextVAlignment { tvaTop, tvaCenter, tvaBottom };
#pragma option pop

typedef void __fastcall (__closure *TAnchorEvent)(System::TObject* Sender, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TPaintEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect);

typedef void __fastcall (__closure *TAnchorHintEvent)(System::TObject* Sender, System::UnicodeString &Anchor);

#pragma option push -b-
enum TPanelPositionLocation { clRegistry, clInifile };
#pragma option pop

class DELPHICLASS TPanelPosition;
class PASCALIMPLEMENTATION TPanelPosition : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FSave;
	System::UnicodeString FKey;
	System::UnicodeString FSection;
	TPanelPositionLocation FLocation;
	Classes::TComponent* FOwner;
	
public:
	__fastcall TPanelPosition(Classes::TComponent* AOwner);
	__fastcall virtual ~TPanelPosition(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Save = {read=FSave, write=FSave, default=0};
	__property System::UnicodeString Key = {read=FKey, write=FKey};
	__property System::UnicodeString Section = {read=FSection, write=FSection};
	__property TPanelPositionLocation Location = {read=FLocation, write=FLocation, default=0};
};


#pragma option push -b-
enum TShadeType { stNormal, stNoise, stDiagShade, stHShade, stVShade, stHBump, stVBump, stSoftBump, stHardBump, stLMetal, stRMetal, stIRadial, stORadial, stHShadeInv, stVShadeInv, stXPCaption, stBitmap, stBitmapRStretch, stBitmapLStretch };
#pragma option pop

#pragma option push -b-
enum TCaptionShape { csRectangle, csRounded, csSemiRounded };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TCaptionButtonPosition { cbpRight, cbpLeft };
#pragma option pop

#pragma option push -b-
enum TCaptionPosition { cpTop, cpLeft };
#pragma option pop

class DELPHICLASS TPanelCaption;
class PASCALIMPLEMENTATION TPanelCaption : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FHeight;
	System::UnicodeString FText;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	bool FVisible;
	bool FCloseButton;
	bool FMinMaxButton;
	Graphics::TColor FMinMaxButtonColor;
	Graphics::TColor FCloseButtonColor;
	Graphics::TBitmap* FMinGlyph;
	Graphics::TBitmap* FCloseMinGlyph;
	Graphics::TBitmap* FCloseMaxGlyph;
	Graphics::TBitmap* FMaxGlyph;
	Graphics::TColor FCloseColor;
	int FShadeLight;
	System::Byte FShadeGrain;
	TShadeType FShadeType;
	TCaptionShape FShape;
	bool FFlat;
	Graphics::TBitmap* FBackground;
	int FIndent;
	int FTop;
	TCaptionButtonPosition FbuttonPosition;
	Graphics::TColor FColorTo;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnShadeChange;
	Classes::TNotifyEvent FOnStateChange;
	TCaptionPosition FPosition;
	bool FMinMaxCaption;
	Graphics::TColor FCloseButtonHoverColor;
	Graphics::TColor FMinMaxButtonHoverColor;
	Classes::TNotifyEvent FOnPositionChange;
	TGradientDirection FGradientDirection;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetCloseButton(const bool Value);
	void __fastcall SetMinMaxButton(const bool Value);
	void __fastcall SetCloseButtonColor(const Graphics::TColor Value);
	void __fastcall SetMinMaxButtonColor(const Graphics::TColor Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetCloseColor(const Graphics::TColor Value);
	void __fastcall SetMaxGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetMinGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetCloseMaxGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetCloseMinGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetShadeLight(const int Value);
	void __fastcall SetShadeGrain(const System::Byte Value);
	void __fastcall SetShadeType(const TShadeType Value);
	void __fastcall SetCaptionShape(const TCaptionShape Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetBackground(const Graphics::TBitmap* Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetTopIndent(const int Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall Changed(void);
	void __fastcall StateChanged(void);
	void __fastcall ShadeChanged(void);
	void __fastcall SetPosition(const TCaptionPosition Value);
	void __fastcall SetMinMaxCaption(const bool Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	
public:
	__fastcall TPanelCaption(void);
	__fastcall virtual ~TPanelCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property TCaptionButtonPosition ButtonPosition = {read=FbuttonPosition, write=FbuttonPosition, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=-16777203};
	__property Graphics::TColor CloseColor = {read=FCloseColor, write=SetCloseColor, default=-16777201};
	__property bool CloseButton = {read=FCloseButton, write=SetCloseButton, default=0};
	__property Graphics::TColor CloseButtonColor = {read=FCloseButtonColor, write=SetCloseButtonColor, default=16777215};
	__property Graphics::TColor CloseButtonHoverColor = {read=FCloseButtonHoverColor, write=FCloseButtonHoverColor, default=536870911};
	__property Graphics::TBitmap* CloseMinGlyph = {read=FCloseMinGlyph, write=SetCloseMinGlyph};
	__property Graphics::TBitmap* CloseMaxGlyph = {read=FCloseMaxGlyph, write=SetCloseMaxGlyph};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=1};
	__property int Height = {read=FHeight, write=SetHeight, default=20};
	__property int Indent = {read=FIndent, write=SetIndent, default=0};
	__property Graphics::TBitmap* MaxGlyph = {read=FMaxGlyph, write=SetMaxGlyph};
	__property Graphics::TBitmap* MinGlyph = {read=FMinGlyph, write=SetMinGlyph};
	__property bool MinMaxButton = {read=FMinMaxButton, write=SetMinMaxButton, default=0};
	__property Graphics::TColor MinMaxButtonColor = {read=FMinMaxButtonColor, write=SetMinMaxButtonColor, default=16777215};
	__property Graphics::TColor MinMaxButtonHoverColor = {read=FMinMaxButtonHoverColor, write=FMinMaxButtonHoverColor, default=536870911};
	__property bool MinMaxCaption = {read=FMinMaxCaption, write=SetMinMaxCaption, default=0};
	__property TCaptionPosition Position = {read=FPosition, write=SetPosition, default=0};
	__property int ShadeLight = {read=FShadeLight, write=SetShadeLight, default=200};
	__property System::Byte ShadeGrain = {read=FShadeGrain, write=SetShadeGrain, default=32};
	__property TShadeType ShadeType = {read=FShadeType, write=SetShadeType, default=0};
	__property TCaptionShape Shape = {read=FShape, write=SetCaptionShape, default=0};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int TopIndent = {read=FTop, write=SetTopIndent, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnStateChange = {read=FOnStateChange, write=FOnStateChange};
	__property Classes::TNotifyEvent OnShadeChange = {read=FOnShadeChange, write=FOnShadeChange};
	__property Classes::TNotifyEvent OnPositionChange = {read=FOnPositionChange, write=FOnPositionChange};
};


class DELPHICLASS TPanelStatusBar;
class PASCALIMPLEMENTATION TPanelStatusBar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FImageIndex;
	System::UnicodeString FText;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	TGradientDirection FGradientDirection;
	bool FVisible;
	int FHeight;
	Classes::TNotifyEvent FOnChange;
	bool FBevelInner;
	Graphics::TFont* FFont;
	Forms::TFormBorderStyle FBorderStyle;
	Graphics::TColor FBorderColor;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetBevelInner(const bool Value);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TPanelStatusBar(void);
	__fastcall virtual ~TPanelStatusBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property bool BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=1};
	__property int Height = {read=FHeight, write=SetHeight, default=18};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
};


class DELPHICLASS TAutoSize;
class DELPHICLASS TCustomAdvPanel;
class PASCALIMPLEMENTATION TAutoSize : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomAdvPanel* FOwner;
	bool FHeight;
	bool FWidth;
	bool FEnabled;
	void __fastcall SetEnabled(const bool Value);
	
public:
	__fastcall TAutoSize(TCustomAdvPanel* AOwner);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property bool Height = {read=FHeight, write=FHeight, default=1};
	__property bool Width = {read=FWidth, write=FWidth, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAutoSize(void) { }
	
};


class DELPHICLASS TAdvPanelSettings;
class PASCALIMPLEMENTATION TAdvPanelSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FFixedHeight;
	bool FCanMove;
	bool FFixedWidth;
	bool FHover;
	bool FAutoHideChildren;
	bool FAnchorHint;
	bool FFixedLeft;
	bool FCanSize;
	bool FShowHint;
	bool FFixedTop;
	bool FCollaps;
	bool FShowMoveCursor;
	int FCollapsDelay;
	int FBevelWidth;
	int FCollapsSteps;
	int FHeight;
	int FShadowOffset;
	System::UnicodeString FText;
	System::UnicodeString FHint;
	Controls::TBevelCut FBevelOuter;
	Controls::TBevelCut FBevelInner;
	Graphics::TColor FHoverColor;
	Graphics::TColor FCollapsColor;
	Graphics::TColor FBorderColor;
	Graphics::TColor FHoverFontColor;
	Graphics::TColor FShadowColor;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FURLColor;
	Graphics::TFont* FFont;
	TPanelCaption* FCaption;
	TPanelPosition* FPosition;
	TTextVAlignment FTextVAlign;
	Forms::TFormBorderStyle FBorderStyle;
	Controls::TCursor FCursor;
	bool FBorderShadow;
	int FIndent;
	int FTopIndent;
	Classes::TNotifyEvent FOnChange;
	int FWidth;
	int FUpdateCount;
	int FBorderWidth;
	TPanelStatusBar* FStatusBar;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetCaption(const TPanelCaption* Value);
	void __fastcall SetCollaps(const bool Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetBorderShadow(const bool Value);
	void __fastcall CaptionChanged(System::TObject* Sender);
	void __fastcall Changed(void);
	void __fastcall SetAnchorHint(const bool Value);
	void __fastcall SetAutoHideChildren(const bool Value);
	void __fastcall SetBevelInner(const Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(const Controls::TBevelCut Value);
	void __fastcall SetBevelWidth(const int Value);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	void __fastcall SetCanMove(const bool Value);
	void __fastcall SetCanSize(const bool Value);
	void __fastcall SetCollapsColor(const Graphics::TColor Value);
	void __fastcall SetCollapsDelay(const int Value);
	void __fastcall SetCollapsSteps(const int Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetCursor(const Controls::TCursor Value);
	void __fastcall SetHover(const bool Value);
	void __fastcall SetHoverColor(const Graphics::TColor Value);
	void __fastcall SetHoverFontColor(const Graphics::TColor Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetTextVAlign(const TTextVAlignment Value);
	void __fastcall SetTopIndent(const int Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetStatusBar(const TPanelStatusBar* Value);
	
public:
	__fastcall TAdvPanelSettings(void);
	__fastcall virtual ~TAdvPanelSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property bool AnchorHint = {read=FAnchorHint, write=SetAnchorHint, nodefault};
	__property bool AutoHideChildren = {read=FAutoHideChildren, write=SetAutoHideChildren, default=1};
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, nodefault};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, nodefault};
	__property int BevelWidth = {read=FBevelWidth, write=SetBevelWidth, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property bool BorderShadow = {read=FBorderShadow, write=SetBorderShadow, nodefault};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, nodefault};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, nodefault};
	__property bool CanMove = {read=FCanMove, write=SetCanMove, nodefault};
	__property bool CanSize = {read=FCanSize, write=SetCanSize, nodefault};
	__property TPanelCaption* Caption = {read=FCaption, write=SetCaption};
	__property bool Collaps = {read=FCollaps, write=SetCollaps, nodefault};
	__property Graphics::TColor CollapsColor = {read=FCollapsColor, write=SetCollapsColor, nodefault};
	__property int CollapsDelay = {read=FCollapsDelay, write=SetCollapsDelay, nodefault};
	__property int CollapsSteps = {read=FCollapsSteps, write=SetCollapsSteps, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=FColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, nodefault};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, nodefault};
	__property Controls::TCursor Cursor = {read=FCursor, write=SetCursor, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool FixedTop = {read=FFixedTop, write=FFixedTop, nodefault};
	__property bool FixedLeft = {read=FFixedLeft, write=FFixedLeft, nodefault};
	__property bool FixedHeight = {read=FFixedHeight, write=FFixedHeight, nodefault};
	__property bool FixedWidth = {read=FFixedWidth, write=FFixedWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property bool Hover = {read=FHover, write=SetHover, nodefault};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=SetHoverColor, nodefault};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=SetHoverFontColor, nodefault};
	__property int Indent = {read=FIndent, write=SetIndent, nodefault};
	__property TPanelPosition* Position = {read=FPosition, write=FPosition};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=FShadowColor, nodefault};
	__property int ShadowOffset = {read=FShadowOffset, write=FShadowOffset, nodefault};
	__property bool ShowHint = {read=FShowHint, write=FShowHint, nodefault};
	__property bool ShowMoveCursor = {read=FShowMoveCursor, write=FShowMoveCursor, nodefault};
	__property TPanelStatusBar* StatusBar = {read=FStatusBar, write=SetStatusBar};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TTextVAlignment TextVAlign = {read=FTextVAlign, write=SetTextVAlign, nodefault};
	__property int TopIndent = {read=FTopIndent, write=SetTopIndent, nodefault};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvPanelStyler;
class PASCALIMPLEMENTATION TCustomAdvPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	System::UnicodeString FText;
	Advimage::TAdvImage* FImage;
	TBackGroundPosition FBackgroundPosition;
	TPanelCaption* FCaption;
	Imglist::TCustomImageList* FImages;
	Graphics::TColor FURLColor;
	Graphics::TColor FOldColor;
	bool FCollaps;
	int FFullHeight;
	System::UnicodeString FAnchor;
	int FHoverHyperLink;
	int FOldHoverHyperLink;
	int FCaptionHoverHyperLink;
	Types::TRect FCurrHoverRect;
	Types::TRect FCaptionCurrHoverRect;
	bool FAnchorHint;
	TAnchorEvent FAnchorExit;
	TAnchorEvent FAnchorClick;
	TAnchorEvent FAnchorEnter;
	bool FHover;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverFontColor;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	bool FCanSize;
	bool FCanMove;
	bool FShowSizeMoveGrip;
	TTextVAlignment FTextVAlign;
	TAnchorHintEvent FOnAnchorHint;
	Classes::TNotifyEvent FOnClose;
	Classes::TNotifyEvent FOnMinimize;
	Classes::TNotifyEvent FOnMaximize;
	TPanelPosition* FPosition;
	Classes::TNotifyEvent FOnCaptionClick;
	bool FFixedHeight;
	bool FFixedLeft;
	bool FFixedWidth;
	bool FFixedTop;
	Types::TPoint FTopLeft;
	Types::TPoint FWidthHeight;
	Classes::TNotifyEvent FOnEndMoveSize;
	Controls::TCursor FOldCursor;
	bool FInMove;
	Picturecontainer::TPictureContainer* FContainer;
	Picturecontainer::THTMLPictureCache* FImageCache;
	bool FShowMoveCursor;
	Graphics::TBitmap* FShadedHeader;
	bool FIsWinXP;
	bool FFreeOnClose;
	bool FIsCollapsing;
	Classes::TNotifyEvent FOnCaptionDblClick;
	int FCollapsDelay;
	int FCollapsSteps;
	Graphics::TColor FCollapsColor;
	TAutoSize* FAutoSize;
	bool FAutoHideChildren;
	bool FCanUpdate;
	Graphics::TColor FColorTo;
	Graphics::TColor FBorderColor;
	int FIndex;
	bool FBuffered;
	bool FBorderShadow;
	int FIndent;
	int FTopIndent;
	int FLineSpacing;
	bool FEllipsis;
	TAdvPanelStyler* FStyler;
	Classes::TNotifyEvent FOnEndCollapsExpand;
	int FOldWidth;
	int FOldHeight;
	TPaintEvent FOnPaint;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	TGradientDirection FGradientDirection;
	bool FHoverCloseBtn;
	bool FHoverMinMaxBtn;
	TPanelStatusBar* FStatusBar;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	bool FOptimizePaint;
	Classes::TList* FHideList;
	void __fastcall OnStatusBarChange(System::TObject* Sender);
	HIDESBASE void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetBackgroundPosition(const TBackGroundPosition Value);
	void __fastcall SetImage(const Advimage::TAdvImage* Value);
	void __fastcall BackgroundChanged(System::TObject* sender);
	void __fastcall SetCaption(const TPanelCaption* Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetCollaps(const bool Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	int __fastcall GetHeightEx(void);
	void __fastcall SetHeightEx(const int Value);
	System::UnicodeString __fastcall IsAnchor(int x, int y, Types::TRect &hoverrect);
	void __fastcall SetHover(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	MESSAGE void __fastcall WMSizing(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMMoving(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMEnterSizeMove(Messages::TMessage &Msg);
	MESSAGE void __fastcall WMExitSizeMove(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Messages::TWMSetCursor &Msg);
	MESSAGE void __fastcall WMLDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetCanSize(const bool Value);
	void __fastcall SetTextVAlign(const TTextVAlignment Value);
	void __fastcall ShowHideChildren(bool Show);
	void __fastcall SetAutoSizeEx(const TAutoSize* Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetIndex(const int Value);
	void __fastcall CaptionChange(System::TObject* Sender);
	void __fastcall CaptionStateChange(System::TObject* Sender);
	void __fastcall CaptionShadeChange(System::TObject* Sender);
	void __fastcall CaptionPositionChange(System::TObject* Sender);
	void __fastcall SetBorderShadow(const bool Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetTopIndent(const int Value);
	void __fastcall SetLineSpacing(const int Value);
	System::UnicodeString __fastcall GetRawText(void);
	System::UnicodeString __fastcall GetVersionComp(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetStatusBar(TPanelStatusBar* Value);
	int __fastcall GetWidthEx(void);
	void __fastcall SetWidthEx(int Value);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetStyler(const TAdvPanelStyler* Value);
	virtual void __fastcall AssignStyle(TAdvPanelSettings* Settings);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	bool __fastcall DoVisualStyles(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall DrawCaptionBkg(Graphics::TCanvas* Canvas, const Types::TRect &r);
	virtual void __fastcall ShadeHeader(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall StoreFullHeight(Classes::TWriter* Writer);
	void __fastcall LoadFullHeight(Classes::TReader* Reader);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	void __fastcall DoAutoSize(void);
	void __fastcall DoInvalidate(const Types::TRect &R, bool Bkg);
	virtual void __fastcall StateChange(void);
	void __fastcall AssignSettings(TAdvPanelSettings* Settings);
	DYNAMIC void __fastcall ChangeScale(int M, int D);
	
public:
	__fastcall virtual TCustomAdvPanel(Classes::TComponent* AOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__fastcall virtual ~TCustomAdvPanel(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall LoadPosition(void);
	void __fastcall SavePosition(void);
	void __fastcall Synchronize(void);
	HIDESBASE void __fastcall SetCursor(Controls::TCursor ACursor);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property bool OptimizePaint = {read=FOptimizePaint, write=FOptimizePaint, nodefault};
	__property int FullHeight = {read=FFullHeight, write=FFullHeight, nodefault};
	__property int Index = {read=FIndex, write=SetIndex, nodefault};
	__property bool AnchorHint = {read=FAnchorHint, write=FAnchorHint, default=0};
	__property TAutoSize* AutoSize = {read=FAutoSize, write=SetAutoSizeEx};
	__property bool AutoHideChildren = {read=FAutoHideChildren, write=FAutoHideChildren, default=1};
	__property Advimage::TAdvImage* Background = {read=FImage, write=SetImage};
	__property TBackGroundPosition BackgroundPosition = {read=FBackgroundPosition, write=SetBackgroundPosition, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property bool BorderShadow = {read=FBorderShadow, write=SetBorderShadow, default=0};
	__property bool Buffered = {read=FBuffered, write=FBuffered, default=1};
	__property bool CanMove = {read=FCanMove, write=FCanMove, default=0};
	__property bool CanSize = {read=FCanSize, write=SetCanSize, default=0};
	__property bool ShowSizeMoveGrip = {read=FShowSizeMoveGrip, write=FShowSizeMoveGrip, default=1};
	__property TPanelCaption* Caption = {read=FCaption, write=SetCaption};
	__property bool Collaps = {read=FCollaps, write=SetCollaps, default=0};
	__property Graphics::TColor CollapsColor = {read=FCollapsColor, write=FCollapsColor, default=8421504};
	__property int CollapsDelay = {read=FCollapsDelay, write=FCollapsDelay, default=20};
	__property int CollapsSteps = {read=FCollapsSteps, write=FCollapsSteps, default=0};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, default=536870911};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, default=536870911};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property bool FixedTop = {read=FFixedTop, write=FFixedTop, default=0};
	__property bool FixedLeft = {read=FFixedLeft, write=FFixedLeft, default=0};
	__property bool FixedHeight = {read=FFixedHeight, write=FFixedHeight, default=0};
	__property bool FixedWidth = {read=FFixedWidth, write=FFixedWidth, default=0};
	__property bool FreeOnClose = {read=FFreeOnClose, write=FFreeOnClose, default=0};
	__property int Height = {read=GetHeightEx, write=SetHeightEx, nodefault};
	__property bool Hover = {read=FHover, write=SetHover, default=0};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=FHoverColor, default=536870911};
	__property Graphics::TColor HoverFontColor = {read=FHoverFontColor, write=FHoverFontColor, default=536870911};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property int Indent = {read=FIndent, write=SetIndent, default=0};
	__property int LineSpacing = {read=FLineSpacing, write=SetLineSpacing, default=0};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property TPanelPosition* Position = {read=FPosition, write=FPosition};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=2};
	__property bool ShowMoveCursor = {read=FShowMoveCursor, write=FShowMoveCursor, default=0};
	__property TPanelStatusBar* StatusBar = {read=FStatusBar, write=SetStatusBar};
	__property TAdvPanelStyler* Styler = {read=FStyler, write=SetStyler};
	__property int Width = {read=GetWidthEx, write=SetWidthEx, nodefault};
	__property System::UnicodeString RawText = {read=GetRawText};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TTextVAlignment TextVAlign = {read=FTextVAlign, write=SetTextVAlign, default=0};
	__property int TopIndent = {read=FTopIndent, write=SetTopIndent, default=0};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Classes::TNotifyEvent OnCaptionClick = {read=FOnCaptionClick, write=FOnCaptionClick};
	__property Classes::TNotifyEvent OnCaptionDBlClick = {read=FOnCaptionDblClick, write=FOnCaptionDblClick};
	__property TAnchorEvent OnAnchorClick = {read=FAnchorClick, write=FAnchorClick};
	__property TAnchorEvent OnAnchorEnter = {read=FAnchorEnter, write=FAnchorEnter};
	__property TAnchorEvent OnAnchorExit = {read=FAnchorExit, write=FAnchorExit};
	__property TAnchorHintEvent OnAnchorHint = {read=FOnAnchorHint, write=FOnAnchorHint};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property Classes::TNotifyEvent OnEndMoveSize = {read=FOnEndMoveSize, write=FOnEndMoveSize};
	__property Classes::TNotifyEvent OnMinimize = {read=FOnMinimize, write=FOnMinimize};
	__property Classes::TNotifyEvent OnMaximize = {read=FOnMaximize, write=FOnMaximize};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnEndCollapsExpand = {read=FOnEndCollapsExpand, write=FOnEndCollapsExpand};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderStyle = {default=0};
	__property Color = {default=-16777201};
	__property Constraints;
	__property Cursor = {default=0};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property HelpContext = {default=0};
	__property Hint;
	__property Locked = {default=0};
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Tag = {default=0};
	__property UseDockManager = {default=0};
	__property Visible = {default=1};
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnCanResize;
	__property OnClick;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
	__property System::UnicodeString Version = {read=GetVersionComp, write=SetVersion};
	__property TPaintEvent OnPaint = {read=FOnPaint, write=FOnPaint};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomAdvPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


class DELPHICLASS TAdvPanel;
class PASCALIMPLEMENTATION TAdvPanel : public TCustomAdvPanel
{
	typedef TCustomAdvPanel inherited;
	
__published:
	__property AnchorHint = {default=0};
	__property AutoSize;
	__property AutoHideChildren = {default=1};
	__property Background;
	__property BackgroundPosition = {default=0};
	__property BorderColor = {default=0};
	__property BorderShadow = {default=0};
	__property BorderWidth = {default=0};
	__property Buffered = {default=1};
	__property CanMove = {default=0};
	__property CanSize = {default=0};
	__property Caption;
	__property Collaps = {default=0};
	__property CollapsColor = {default=8421504};
	__property CollapsDelay = {default=20};
	__property CollapsSteps = {default=0};
	__property ColorTo = {default=536870911};
	__property ColorMirror = {default=536870911};
	__property ColorMirrorTo = {default=536870911};
	__property Ellipsis = {default=0};
	__property FixedTop = {default=0};
	__property FixedLeft = {default=0};
	__property FixedHeight = {default=0};
	__property FixedWidth = {default=0};
	__property FreeOnClose = {default=0};
	__property GradientDirection = {default=0};
	__property Height;
	__property Hover = {default=0};
	__property HoverColor = {default=536870911};
	__property HoverFontColor = {default=536870911};
	__property Images;
	__property Indent = {default=0};
	__property LineSpacing = {default=0};
	__property ParentShowHint = {default=1};
	__property PictureContainer;
	__property Position;
	__property ShadowColor = {default=8421504};
	__property ShadowOffset = {default=2};
	__property ShowMoveCursor = {default=0};
	__property StatusBar;
	__property Styler;
	__property Text;
	__property TextVAlign = {default=0};
	__property TopIndent = {default=0};
	__property URLColor = {default=16711680};
	__property Width;
	__property OnCaptionClick;
	__property OnCaptionDBlClick;
	__property OnAnchorClick;
	__property OnAnchorEnter;
	__property OnAnchorExit;
	__property OnAnchorHint;
	__property OnClose;
	__property OnEndMoveSize;
	__property OnMinimize;
	__property OnMaximize;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnEndCollapsExpand;
	__property OnPaint;
public:
	/* TCustomAdvPanel.Create */ inline __fastcall virtual TAdvPanel(Classes::TComponent* AOwner) : TCustomAdvPanel(AOwner) { }
	/* TCustomAdvPanel.Destroy */ inline __fastcall virtual ~TAdvPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPanel(HWND ParentWindow) : TCustomAdvPanel(ParentWindow) { }
	
};


#pragma option push -b-
enum TGroupStyle { gsVertical, gsHorizontal };
#pragma option pop

class DELPHICLASS TAdvPanelGroup;
class PASCALIMPLEMENTATION TAdvPanelGroup : public TAdvPanel
{
	typedef TAdvPanel inherited;
	
private:
	int FUpdateCount;
	int FHorzPadding;
	int FVertPadding;
	TGroupStyle FGroupStyle;
	bool FIsArranging;
	Stdctrls::TScrollBar* FScrollBar;
	Classes::TList* FPanels;
	TAdvPanelSettings* FDefaultPanel;
	int FColumns;
	bool FCode;
	bool FScrollSmooth;
	int FOldWidth;
	int FOldHeight;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TMessage &Msg);
	void __fastcall SetHorzPadding(const int Value);
	void __fastcall SetVertPadding(const int Value);
	void __fastcall SetGroupStyle(const TGroupStyle Value);
	TCustomAdvPanel* __fastcall GetPanel(int Index);
	void __fastcall SetPanel(int Index, const TCustomAdvPanel* Value);
	void __fastcall SetDefaultPanel(const TAdvPanelSettings* Value);
	void __fastcall SetColumns(const int Value);
	int __fastcall GetPanelCount(void);
	int __fastcall GetScrollPosition(void);
	void __fastcall SetScrollPosition(const int Value);
	
protected:
	void __fastcall ArrangeControlsVert(void);
	void __fastcall ArrangeControlsHorz(void);
	void __fastcall ArrangeControls(void);
	void __fastcall Scroll(System::TObject* Sender, Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
	int __fastcall PanelHeights(void);
	int __fastcall PanelWidths(void);
	void __fastcall UpdateScrollbar(void);
	virtual void __fastcall StateChange(void);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	
public:
	__fastcall virtual TAdvPanelGroup(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPanelGroup(void);
	virtual void __fastcall Loaded(void);
	void __fastcall ChildPanelChanged(TCustomAdvPanel* APanel);
	__property bool IsArranging = {read=FIsArranging, nodefault};
	void __fastcall ArrangePanels(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall OpenAllPanels(void);
	void __fastcall CloseAllPanels(void);
	void __fastcall SavePanelPositions(void);
	void __fastcall LoadPanelPositions(void);
	void __fastcall UpdateGroup(void);
	void __fastcall Clear(void);
	HIDESBASE void __fastcall BeginUpdate(void);
	HIDESBASE void __fastcall EndUpdate(void);
	void __fastcall InitPanels(void);
	TCustomAdvPanel* __fastcall AddPanel(void);
	TCustomAdvPanel* __fastcall AppendPanel(void);
	TCustomAdvPanel* __fastcall InsertPanel(int Index);
	void __fastcall RemovePanel(int Index);
	void __fastcall MovePanel(int FromIndex, int ToIndex);
	__property TCustomAdvPanel* Panels[int Index] = {read=GetPanel, write=SetPanel};
	__property int PanelCount = {read=GetPanelCount, nodefault};
	__property int ScrollPosition = {read=GetScrollPosition, write=SetScrollPosition, nodefault};
	
__published:
	__property int Columns = {read=FColumns, write=SetColumns, nodefault};
	__property TAdvPanelSettings* DefaultPanel = {read=FDefaultPanel, write=SetDefaultPanel};
	__property TGroupStyle GroupStyle = {read=FGroupStyle, write=SetGroupStyle, nodefault};
	__property bool ScrollSmooth = {read=FScrollSmooth, write=FScrollSmooth, default=0};
	__property int HorzPadding = {read=FHorzPadding, write=SetHorzPadding, nodefault};
	__property int VertPadding = {read=FVertPadding, write=SetVertPadding, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPanelGroup(HWND ParentWindow) : TAdvPanel(ParentWindow) { }
	
};


#pragma option push -b-
enum TAdvPanelStyle { psXP, psFlat, psTMS, psClassic, psOffice2003Blue, psOffice2003Olive, psOffice2003Silver, psOffice2003Classic, psOffice2007Luna, psOffice2007Obsidian, psWhidbey, psWindowsXP, psCustom, psOffice2007Silver, psWindowsVista, psWindows7, psTerminal, psOffice2010Blue, psOffice2010Silver, psOffice2010Black };
#pragma option pop

class DELPHICLASS TThemeNotifierWindow;
class PASCALIMPLEMENTATION TThemeNotifierWindow : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	Classes::TNotifyEvent FOnThemeChange;
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	
__published:
	__property Classes::TNotifyEvent OnThemeChange = {read=FOnThemeChange, write=FOnThemeChange};
public:
	/* TWinControl.Create */ inline __fastcall virtual TThemeNotifierWindow(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TThemeNotifierWindow(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TThemeNotifierWindow(void) { }
	
};


class PASCALIMPLEMENTATION TAdvPanelStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TAdvPanelSettings* FSettings;
	System::UnicodeString FComments;
	int FTag;
	TThemeNotifierWindow* FNotifierWnd;
	TAdvPanelStyle FStyle;
	bool FAutoThemeAdapt;
	void __fastcall SetSettings(const TAdvPanelSettings* Value);
	void __fastcall SetStyle(const TAdvPanelStyle Value);
	
protected:
	void __fastcall ThemeChanged(System::TObject* Sender);
	void __fastcall Changed(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvPanelStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPanelStyler(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Loaded(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property TAdvPanelSettings* Settings = {read=FSettings, write=SetSettings};
	__property System::UnicodeString Comments = {read=FComments, write=FComments};
	__property TAdvPanelStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property int Tag = {read=FTag, write=FTag, nodefault};
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
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advpanel */
using namespace Advpanel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpanelHPP
