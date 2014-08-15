// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Htmlpopup.pas' rev: 21.00

#ifndef HtmlpopupHPP
#define HtmlpopupHPP

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
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Htmlpopup
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAnchorClickEvent)(System::TObject* Sender, System::UnicodeString Anchor);

#pragma option push -b-
enum TShadeDirection { sdHorizontal, sdVertical };
#pragma option pop

#pragma option push -b-
enum TAutoSizeType { asdHeight, asdWidth, asdBoth };
#pragma option pop

#pragma option push -b-
enum THideType { htMouseLeave, htTimeOut };
#pragma option pop

class DELPHICLASS THTMLPopupWindow;
class PASCALIMPLEMENTATION THTMLPopupWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	Picturecontainer::THTMLPictureCache* FImageCache;
	Picturecontainer::TPictureContainer* FContainer;
	int FHoverLink;
	bool FHover;
	Types::TRect FHoverRect;
	TAnchorClickEvent FOnAnchorClick;
	Classes::TNotifyEvent FOnClick;
	bool FShadeEnable;
	int FShadeSteps;
	Graphics::TColor FShadeStartColor;
	Graphics::TColor FShadeEndColor;
	Graphics::TColor FColor;
	TShadeDirection FShadeDirection;
	int FBorderSize;
	Controls::TImageList* FImages;
	bool FAutoHide;
	bool FAutoSize;
	TAutoSizeType FAutoSizeType;
	bool FAlwaysOnTop;
	int FMarginY;
	int FMarginX;
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetHover(const bool Value);
	void __fastcall SetAutoSizeEx(const bool Value);
	void __fastcall SetAlwaysOnTop(const bool Value);
	
protected:
	void __fastcall PaintShading(Graphics::TColor FromColor, Graphics::TColor ToColor, int Steps, bool Direction);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual THTMLPopupWindow(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLPopupWindow(void);
	
__published:
	__property bool AlwaysOnTop = {read=FAlwaysOnTop, write=SetAlwaysOnTop, default=0};
	__property bool AutoHide = {read=FAutoHide, write=FAutoHide, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeEx, default=0};
	__property TAutoSizeType AutoSizeType = {read=FAutoSizeType, write=FAutoSizeType, default=0};
	__property int BorderSize = {read=FBorderSize, write=FBorderSize, default=0};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=-16777192};
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property int MarginX = {read=FMarginX, write=FMarginX, default=4};
	__property int MarginY = {read=FMarginY, write=FMarginY, default=4};
	__property bool ShadeEnable = {read=FShadeEnable, write=FShadeEnable, default=0};
	__property Graphics::TColor ShadeStartColor = {read=FShadeStartColor, write=FShadeStartColor, default=12632256};
	__property Graphics::TColor ShadeEndColor = {read=FShadeEndColor, write=FShadeEndColor, default=8421504};
	__property int ShadeSteps = {read=FShadeSteps, write=FShadeSteps, default=40};
	__property TShadeDirection ShadeDirection = {read=FShadeDirection, write=FShadeDirection, default=0};
	__property bool Hover = {read=FHover, write=SetHover, default=0};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property TAnchorClickEvent OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall THTMLPopupWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


class DELPHICLASS THTMLPopup;
class PASCALIMPLEMENTATION THTMLPopup : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Controls::TWinControl* FOwner;
	THTMLPopupWindow* FHTMLPopupWindow;
	int FHeight;
	int FWidth;
	Picturecontainer::TPictureContainer* FContainer;
	Classes::TStringList* FText;
	int FLeft;
	int FTop;
	bool FHover;
	TAnchorClickEvent FOnAnchorClick;
	Classes::TNotifyEvent FOnClick;
	bool FShadeEnable;
	int FShadeSteps;
	Graphics::TColor FShadeStartColor;
	Graphics::TColor FShadeEndColor;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	TShadeDirection FShadeDirection;
	int FBorderSize;
	Controls::TImageList* FImages;
	bool FAutoHide;
	bool FAutoSize;
	TAutoSizeType FAutoSizeType;
	bool FAlwaysOnTop;
	int FMarginY;
	int FMarginX;
	int FRollUpSpace;
	Extctrls::TTimer* FTimer;
	int FTimeOut;
	THideType FHideType;
	void __fastcall SetText(const Classes::TStringList* Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	void __fastcall WindowAnchorClick(System::TObject* Sender, System::UnicodeString Anchor);
	void __fastcall WindowClick(System::TObject* Sender);
	void __fastcall WindowTimer(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall CreatePopup(void);
	void __fastcall TextChanged(System::TObject* Sender);
	
public:
	__fastcall virtual THTMLPopup(Classes::TComponent* AOwner);
	__fastcall virtual ~THTMLPopup(void);
	void __fastcall Show(void);
	void __fastcall RollUp(void);
	void __fastcall RollDown(void);
	void __fastcall Hide(void);
	__property THTMLPopupWindow* PopupWindow = {read=FHTMLPopupWindow};
	
__published:
	__property bool AlwaysOnTop = {read=FAlwaysOnTop, write=FAlwaysOnTop, default=0};
	__property bool AutoHide = {read=FAutoHide, write=FAutoHide, default=0};
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, default=0};
	__property TAutoSizeType AutoSizeType = {read=FAutoSizeType, write=FAutoSizeType, default=0};
	__property int BorderSize = {read=FBorderSize, write=FBorderSize, default=0};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=-16777192};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool Hover = {read=FHover, write=FHover, default=0};
	__property THideType HideType = {read=FHideType, write=FHideType, default=0};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property int MarginX = {read=FMarginX, write=FMarginX, default=4};
	__property int MarginY = {read=FMarginY, write=FMarginY, default=4};
	__property int PopupLeft = {read=FLeft, write=FLeft, default=0};
	__property int PopupTop = {read=FTop, write=FTop, default=0};
	__property int RollUpSpace = {read=FRollUpSpace, write=FRollUpSpace, default=0};
	__property bool ShadeEnable = {read=FShadeEnable, write=FShadeEnable, default=0};
	__property Graphics::TColor ShadeStartColor = {read=FShadeStartColor, write=FShadeStartColor, default=12632256};
	__property Graphics::TColor ShadeEndColor = {read=FShadeEndColor, write=FShadeEndColor, default=8421504};
	__property int ShadeSteps = {read=FShadeSteps, write=FShadeSteps, default=40};
	__property TShadeDirection ShadeDirection = {read=FShadeDirection, write=FShadeDirection, default=0};
	__property Classes::TStringList* Text = {read=FText, write=SetText};
	__property int TimeOut = {read=FTimeOut, write=FTimeOut, default=2000};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property int PopupWidth = {read=FWidth, write=FWidth, default=200};
	__property int PopupHeight = {read=FHeight, write=FHeight, default=200};
	__property TAnchorClickEvent OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Htmlpopup */
using namespace Htmlpopup;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HtmlpopupHPP
