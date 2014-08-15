// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advofficetabset.pas' rev: 21.00

#ifndef AdvofficetabsetHPP
#define AdvofficetabsetHPP

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
#include <Math.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Acxpvs.hpp>	// Pascal unit
#include <Advdwm.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advofficetabset
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TGlowState { gsHover, gsPush, gsNone };
#pragma option pop

#pragma option push -b-
enum TButtonLayout { blGlyphLeft, blGlyphTop, blGlyphRight, blGlyphBottom };
#pragma option pop

#pragma option push -b-
enum TDropDownPosition { dpRight, dpBottom };
#pragma option pop

#pragma option push -b-
enum TImagePosition { ipLeft, ipTop, ipRight, ipBottom };
#pragma option pop

#pragma option push -b-
enum TCloseOnTabPos { cpRight, cpLeft };
#pragma option pop

#pragma option push -b-
enum TAdvTabShape { tsRectangle, tsLeftRamp, tsRightRamp, tsLeftRightRamp };
#pragma option pop

typedef ShortInt TTabRounding;

typedef void __fastcall (__closure *TTabMovedEvent)(System::TObject* Sender, int FromIndex, int ToIndex);

class DELPHICLASS TTabSetTabSettings;
class PASCALIMPLEMENTATION TTabSetTabSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FLeftMargin;
	int FRightMargin;
	Classes::TNotifyEvent FOnChange;
	int FHeight;
	int FStartMargin;
	int FEndMargin;
	int FSpacing;
	TImagePosition FImagePosition;
	bool FWordWrap;
	int FWidth;
	TAdvTabShape FShape;
	TTabRounding FRounding;
	Classes::TAlignment FAlignment;
	bool FGlass;
	void __fastcall SetLeftMargin(const int Value);
	void __fastcall SetRightMargin(const int Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetStartMargin(const int Value);
	void __fastcall SetEndMargin(const int Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetImagePosition(const TImagePosition Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetRounding(const TTabRounding Value);
	void __fastcall SetShape(const TAdvTabShape Value);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetGlass(const bool Value);
	
protected:
	void __fastcall Changed(void);
	__property int EndMargin = {read=FEndMargin, write=SetEndMargin, nodefault};
	
public:
	__fastcall TTabSetTabSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property int LeftMargin = {read=FLeftMargin, write=SetLeftMargin, default=4};
	__property int RightMargin = {read=FRightMargin, write=SetRightMargin, default=4};
	__property int StartMargin = {read=FStartMargin, write=SetStartMargin, default=60};
	__property int Height = {read=FHeight, write=SetHeight, default=26};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property int Width = {read=FWidth, write=SetWidth, default=0};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property TImagePosition ImagePosition = {read=FImagePosition, write=SetImagePosition, default=0};
	__property TAdvTabShape Shape = {read=FShape, write=SetShape, default=0};
	__property TTabRounding Rounding = {read=FRounding, write=SetRounding, default=1};
	__property bool Glass = {read=FGlass, write=SetGlass, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TTabSetTabSettings(void) { }
	
};


class DELPHICLASS TGradientBackground;
class PASCALIMPLEMENTATION TGradientBackground : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSteps;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	TGradientDirection FDirection;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDirection(const TGradientDirection Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	
public:
	__fastcall TGradientBackground(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property TGradientDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGradientBackground(void) { }
	
};


class DELPHICLASS TVistaBackground;
class PASCALIMPLEMENTATION TVistaBackground : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSteps;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FBorderColor;
	Advglowbutton::TGDIPGradient FGradientMirror;
	Advglowbutton::TGDIPGradient FGradient;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetGradient(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientMirror(const Advglowbutton::TGDIPGradient Value);
	
public:
	__fastcall TVistaBackground(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, nodefault};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, nodefault};
	__property Advglowbutton::TGDIPGradient Gradient = {read=FGradient, write=SetGradient, nodefault};
	__property Advglowbutton::TGDIPGradient GradientMirror = {read=FGradientMirror, write=SetGradientMirror, nodefault};
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TVistaBackground(void) { }
	
};


class DELPHICLASS TCustomTabAppearance;
class PASCALIMPLEMENTATION TCustomTabAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderColorHot;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorSelectedTo;
	Graphics::TColor FBorderColorDisabled;
	Graphics::TColor FBorderColorSelected;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FColorDisabledTo;
	Graphics::TColor FColorSelected;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FColorMirrorHot;
	Graphics::TColor FColorMirrorHotTo;
	Advglowbutton::TGDIPGradient FGradientMirror;
	Advglowbutton::TGDIPGradient FGradientMirrorHot;
	Advglowbutton::TGDIPGradient FGradient;
	Advglowbutton::TGDIPGradient FGradientHot;
	Graphics::TColor FColorMirrorDisabledTo;
	Graphics::TColor FColorMirrorDisabled;
	Graphics::TColor FColorMirrorSelectedTo;
	Graphics::TColor FColorMirrorSelected;
	Advglowbutton::TGDIPGradient FGradientSelected;
	Advglowbutton::TGDIPGradient FGradientDisabled;
	Advglowbutton::TGDIPGradient FGradientMirrorSelected;
	Advglowbutton::TGDIPGradient FGradientMirrorDisabled;
	Graphics::TColor FTextColorDisabled;
	Graphics::TColor FTextColorSelected;
	Graphics::TColor FTextColor;
	Graphics::TColor FTextColorHot;
	TGradientBackground* FBackGround;
	Graphics::TColor FBorderColorSelectedHot;
	Graphics::TColor FBorderColorDown;
	Graphics::TFont* FFont;
	Graphics::TColor FHighLightColorHot;
	Graphics::TColor FShadowColor;
	Graphics::TColor FHighLightColorDown;
	Graphics::TColor FHighLightColorSelectedHot;
	Graphics::TColor FHighLightColorSelected;
	void __fastcall OnBackGroundChanged(System::TObject* Sender);
	void __fastcall SetBackGround(const TGradientBackground* Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorDisabled(const Graphics::TColor Value);
	void __fastcall SetBorderColorSelected(const Graphics::TColor Value);
	void __fastcall SetBorderColorSelectedHot(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorHot(const Graphics::TColor Value);
	void __fastcall SetColorMirrorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorSelected(const Graphics::TColor Value);
	void __fastcall SetColorMirrorSelectedTo(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetColorSelected(const Graphics::TColor Value);
	void __fastcall SetColorSelectedTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradient(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientDisabled(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientHot(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientMirror(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientMirrorDisabled(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientMirrorHot(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientMirrorSelected(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientSelected(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetTextColorDisabled(const Graphics::TColor Value);
	void __fastcall SetTextColorHot(const Graphics::TColor Value);
	void __fastcall SetTextColorSelected(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	
protected:
	void __fastcall Changed(void);
	__property TGradientBackground* BackGround = {read=FBackGround, write=SetBackGround};
	
public:
	__fastcall TCustomTabAppearance(void);
	__fastcall virtual ~TCustomTabAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=FBorderColorHot, nodefault};
	__property Graphics::TColor BorderColorSelected = {read=FBorderColorSelected, write=SetBorderColorSelected, nodefault};
	__property Graphics::TColor BorderColorSelectedHot = {read=FBorderColorSelectedHot, write=SetBorderColorSelectedHot, nodefault};
	__property Graphics::TColor BorderColorDisabled = {read=FBorderColorDisabled, write=SetBorderColorDisabled, nodefault};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=SetBorderColorDown, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorSelected = {read=FColorSelected, write=SetColorSelected, nodefault};
	__property Graphics::TColor ColorSelectedTo = {read=FColorSelectedTo, write=SetColorSelectedTo, nodefault};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, nodefault};
	__property Graphics::TColor ColorDisabledTo = {read=FColorDisabledTo, write=SetColorDisabledTo, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, nodefault};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, nodefault};
	__property Graphics::TColor ColorMirrorHot = {read=FColorMirrorHot, write=SetColorMirrorHot, nodefault};
	__property Graphics::TColor ColorMirrorHotTo = {read=FColorMirrorHotTo, write=SetColorMirrorHotTo, nodefault};
	__property Graphics::TColor ColorMirrorSelected = {read=FColorMirrorSelected, write=SetColorMirrorSelected, nodefault};
	__property Graphics::TColor ColorMirrorSelectedTo = {read=FColorMirrorSelectedTo, write=SetColorMirrorSelectedTo, nodefault};
	__property Graphics::TColor ColorMirrorDisabled = {read=FColorMirrorDisabled, write=SetColorMirrorDisabled, nodefault};
	__property Graphics::TColor ColorMirrorDisabledTo = {read=FColorMirrorDisabledTo, write=SetColorMirrorDisabledTo, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Advglowbutton::TGDIPGradient Gradient = {read=FGradient, write=SetGradient, nodefault};
	__property Advglowbutton::TGDIPGradient GradientMirror = {read=FGradientMirror, write=SetGradientMirror, nodefault};
	__property Advglowbutton::TGDIPGradient GradientHot = {read=FGradientHot, write=SetGradientHot, nodefault};
	__property Advglowbutton::TGDIPGradient GradientMirrorHot = {read=FGradientMirrorHot, write=SetGradientMirrorHot, nodefault};
	__property Advglowbutton::TGDIPGradient GradientSelected = {read=FGradientSelected, write=SetGradientSelected, nodefault};
	__property Advglowbutton::TGDIPGradient GradientMirrorSelected = {read=FGradientMirrorSelected, write=SetGradientMirrorSelected, nodefault};
	__property Advglowbutton::TGDIPGradient GradientDisabled = {read=FGradientDisabled, write=SetGradientDisabled, nodefault};
	__property Advglowbutton::TGDIPGradient GradientMirrorDisabled = {read=FGradientMirrorDisabled, write=SetGradientMirrorDisabled, nodefault};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property Graphics::TColor TextColorHot = {read=FTextColorHot, write=SetTextColorHot, nodefault};
	__property Graphics::TColor TextColorSelected = {read=FTextColorSelected, write=SetTextColorSelected, nodefault};
	__property Graphics::TColor TextColorDisabled = {read=FTextColorDisabled, write=SetTextColorDisabled, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=FShadowColor, nodefault};
	__property Graphics::TColor HighLightColorSelected = {read=FHighLightColorSelected, write=FHighLightColorSelected, nodefault};
	__property Graphics::TColor HighLightColorHot = {read=FHighLightColorHot, write=FHighLightColorHot, nodefault};
	__property Graphics::TColor HighLightColorSelectedHot = {read=FHighLightColorSelectedHot, write=FHighLightColorSelectedHot, nodefault};
	__property Graphics::TColor HighLightColorDown = {read=FHighLightColorDown, write=FHighLightColorDown, nodefault};
};


class DELPHICLASS TTabAppearance;
class PASCALIMPLEMENTATION TTabAppearance : public TCustomTabAppearance
{
	typedef TCustomTabAppearance inherited;
	
__published:
	__property BackGround;
public:
	/* TCustomTabAppearance.Create */ inline __fastcall TTabAppearance(void) : TCustomTabAppearance() { }
	/* TCustomTabAppearance.Destroy */ inline __fastcall virtual ~TTabAppearance(void) { }
	
};


class DELPHICLASS TTabSetTabScroller;
class PASCALIMPLEMENTATION TTabSetTabScroller : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FMin;
	int FMax;
	int FPosition;
	bool FVisible;
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TTabSetTabScroller(void);
	bool __fastcall CanGoForward(void);
	bool __fastcall CanGoBack(void);
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTabSetTabScroller(void) { }
	
};


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
	__property void * Items[int Index] = {read=GetItemsEx, write=SetItemsEx/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TDbgList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TDbgList(void) : Classes::TList() { }
	
};


class DELPHICLASS TTabSetButtonSettings;
class PASCALIMPLEMENTATION TTabSetButtonSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	bool FTabListButton;
	bool FCloseButton;
	Gdipicture::TGDIPPicture* FScrollButtonNextPicture;
	Gdipicture::TGDIPPicture* FScrollButtonPrevPicture;
	Gdipicture::TGDIPPicture* FTabListButtonPicture;
	Gdipicture::TGDIPPicture* FCloseButtonPicture;
	System::UnicodeString FScrollButtonPrevHint;
	System::UnicodeString FScrollButtonNextHint;
	System::UnicodeString FCloseButtonHint;
	System::UnicodeString FTabListButtonHint;
	bool FScrollButtonsAlways;
	Gdipicture::TGDIPPicture* FScrollButtonFirstPicture;
	Gdipicture::TGDIPPicture* FScrollButtonLastPicture;
	System::UnicodeString FScrollButtonFirstHint;
	System::UnicodeString FScrollButtonLastHint;
	bool FLastButton;
	bool FFirstButton;
	void __fastcall Changed(void);
	void __fastcall OnPictureChanged(System::TObject* Sender);
	void __fastcall SetCloseButton(const bool Value);
	void __fastcall SetCloseButtonPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetTabListButton(const bool Value);
	void __fastcall SetTabListButtonPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetScrollButtonNextPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetScrollButtonPrevPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetScrollButtonsAlways(const bool Value);
	void __fastcall SetScrollButtonFirstPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetScrollButtonLastPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetFirstButton(const bool Value);
	void __fastcall SetLastButton(const bool Value);
	
protected:
	Gdipicture::TGDIPPicture* FScrollButtonDownPicture;
	Gdipicture::TGDIPPicture* FScrollButtonDownLastPicture;
	Gdipicture::TGDIPPicture* FScrollButtonUpPicture;
	Gdipicture::TGDIPPicture* FScrollButtonUpFirstPicture;
	bool FPrevPictureChanged;
	bool FNextPictureChanged;
	bool FFirstPictureChanged;
	bool FLastPictureChanged;
	
public:
	__fastcall TTabSetButtonSettings(void);
	__fastcall virtual ~TTabSetButtonSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool CloseButton = {read=FCloseButton, write=SetCloseButton, default=0};
	__property bool TabListButton = {read=FTabListButton, write=SetTabListButton, default=0};
	__property Gdipicture::TGDIPPicture* CloseButtonPicture = {read=FCloseButtonPicture, write=SetCloseButtonPicture};
	__property Gdipicture::TGDIPPicture* TabListButtonPicture = {read=FTabListButtonPicture, write=SetTabListButtonPicture};
	__property Gdipicture::TGDIPPicture* ScrollButtonPrevPicture = {read=FScrollButtonPrevPicture, write=SetScrollButtonPrevPicture};
	__property Gdipicture::TGDIPPicture* ScrollButtonNextPicture = {read=FScrollButtonNextPicture, write=SetScrollButtonNextPicture};
	__property Gdipicture::TGDIPPicture* ScrollButtonFirstPicture = {read=FScrollButtonFirstPicture, write=SetScrollButtonFirstPicture};
	__property Gdipicture::TGDIPPicture* ScrollButtonLastPicture = {read=FScrollButtonLastPicture, write=SetScrollButtonLastPicture};
	__property System::UnicodeString CloseButtonHint = {read=FCloseButtonHint, write=FCloseButtonHint};
	__property System::UnicodeString TabListButtonHint = {read=FTabListButtonHint, write=FTabListButtonHint};
	__property bool ScrollButtonsAlways = {read=FScrollButtonsAlways, write=SetScrollButtonsAlways, default=0};
	__property System::UnicodeString ScrollButtonNextHint = {read=FScrollButtonNextHint, write=FScrollButtonNextHint};
	__property System::UnicodeString ScrollButtonPrevHint = {read=FScrollButtonPrevHint, write=FScrollButtonPrevHint};
	__property System::UnicodeString ScrollButtonFirstHint = {read=FScrollButtonFirstHint, write=FScrollButtonFirstHint};
	__property System::UnicodeString ScrollButtonLastHint = {read=FScrollButtonLastHint, write=FScrollButtonLastHint};
	__property bool FirstButton = {read=FFirstButton, write=SetFirstButton, default=0};
	__property bool LastButton = {read=FLastButton, write=SetLastButton, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TCustomAdvOfficeTabSetStyler;
class PASCALIMPLEMENTATION TCustomAdvOfficeTabSetStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	TDbgList* FControlList;
	TTabAppearance* FTabAppearance;
	bool FRoundEdges;
	bool FAutoThemeAdapt;
	Advglowbutton::TGlowButtonAppearance* FGlowButtonAppearance;
	int FBlendFactor;
	Graphics::TColor FButtonBorderColor;
	void __fastcall OnTabAppearanceChanged(System::TObject* Sender);
	void __fastcall OnGlowButtonAppearanceChanged(System::TObject* Sender);
	void __fastcall SetRoundEdges(const bool Value);
	void __fastcall SetTabAppearance(const TTabAppearance* Value);
	void __fastcall SetGlowButtonAppearance(const Advglowbutton::TGlowButtonAppearance* Value);
	void __fastcall SetButtonBorderColor(const Graphics::TColor Value);
	
protected:
	void __fastcall AddControl(Controls::TCustomControl* AControl);
	void __fastcall RemoveControl(Controls::TCustomControl* AControl);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall Change(int PropID);
	__property int BlendFactor = {read=FBlendFactor, write=FBlendFactor, nodefault};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property TTabAppearance* TabAppearance = {read=FTabAppearance, write=SetTabAppearance};
	__property bool RoundEdges = {read=FRoundEdges, write=SetRoundEdges, default=1};
	__property Graphics::TColor ButtonBorderColor = {read=FButtonBorderColor, write=SetButtonBorderColor, nodefault};
	__property Advglowbutton::TGlowButtonAppearance* GlowButtonAppearance = {read=FGlowButtonAppearance, write=SetGlowButtonAppearance};
	
public:
	__fastcall virtual TCustomAdvOfficeTabSetStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomAdvOfficeTabSetStyler(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
};


class DELPHICLASS TDummyHintControl;
class PASCALIMPLEMENTATION TDummyHintControl : public Controls::TControl
{
	typedef Controls::TControl inherited;
	
private:
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	
public:
	__fastcall virtual TDummyHintControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TDummyHintControl(void);
	
__published:
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
};


class DELPHICLASS TOfficeTabCollectionItem;
class PASCALIMPLEMENTATION TOfficeTabCollectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Advglowbutton::TAdvGlowButton* FCloseButton;
	System::UnicodeString FCaption;
	bool FVisible;
	int FTag;
	int FImageIndex;
	bool FEnabled;
	Extctrls::TTimer* FTimer;
	int FTimeInc;
	int FStepHover;
	int FStepPush;
	TGlowState FGlowState;
	Gdipicture::TGDIPPicture* FIPicture;
	Gdipicture::TGDIPPicture* FIDisabledPicture;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	bool FShowClose;
	bool FUseTabAppearance;
	TTabAppearance* FTabAppearance;
	bool FShowCheckBox;
	bool FChecked;
	void __fastcall TimerProc(System::TObject* Sender);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall OnTabAppearanceChanged(System::TObject* Sender);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetDisabledPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetShowClose(const bool Value);
	void __fastcall SetTabAppearance(const TTabAppearance* Value);
	void __fastcall SetUseTabAppearance(const bool Value);
	void __fastcall SetChecked(const bool Value);
	void __fastcall SetShowCheckBox(const bool Value);
	
protected:
	Forms::TForm* FChildForm;
	Classes::TNotifyEvent FOnActivateForm;
	Classes::TNotifyEvent FOnDestroyForm;
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall SetIndex(int Value);
	void __fastcall Refresh(void);
	
public:
	__fastcall virtual TOfficeTabCollectionItem(Classes::TCollection* Collection);
	__fastcall virtual ~TOfficeTabCollectionItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Gdipicture::TGDIPPicture* DisabledPicture = {read=FIDisabledPicture, write=SetDisabledPicture};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property bool ShowClose = {read=FShowClose, write=SetShowClose, default=1};
	__property TTabAppearance* TabAppearance = {read=FTabAppearance, write=SetTabAppearance};
	__property bool UseTabAppearance = {read=FUseTabAppearance, write=SetUseTabAppearance, default=0};
	__property bool ShowCheckBox = {read=FShowCheckBox, write=SetShowCheckBox, default=0};
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
};


class DELPHICLASS TOfficeTabCollection;
class DELPHICLASS TAdvCustomOfficeTabSet;
class PASCALIMPLEMENTATION TOfficeTabCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TOfficeTabCollectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvCustomOfficeTabSet* FOwner;
	HIDESBASE TOfficeTabCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TOfficeTabCollectionItem* Value);
	
public:
	__fastcall TOfficeTabCollection(TAdvCustomOfficeTabSet* AOwner);
	__property TOfficeTabCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TAdvCustomOfficeTabSet* AdvOfficeTabSet = {read=FOwner};
	HIDESBASE TOfficeTabCollectionItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE TOfficeTabCollectionItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall Move(int CurIndex, int NewIndex);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TOfficeTabCollection(void) { }
	
};


typedef void __fastcall (__closure *TTabChangingEvent)(System::TObject* Sender, int FromTab, int ToTab, bool &AllowChange);

typedef void __fastcall (__closure *TOnTabClose)(System::TObject* Sender, int TabIndex, bool &Allow);

typedef void __fastcall (__closure *TOnTabListClick)(System::TObject* Sender, int X, int Y);

typedef void __fastcall (__closure *TDrawTabEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int TabIndex, const Types::TRect &TabRect);

typedef void __fastcall (__closure *TTabClickEvent)(System::TObject* Sender, int PageIndex);

class PASCALIMPLEMENTATION TAdvCustomOfficeTabSet : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Advglowbutton::TAdvGlowButton* FCloseButtonGlobal;
	bool FIsWinXP;
	TCustomAdvOfficeTabSetStyler* FInternalOfficeTabSetStyler;
	TCustomAdvOfficeTabSetStyler* FOfficeTabSetStyler;
	TCustomAdvOfficeTabSetStyler* FCurrentOfficeTabSetStyler;
	int FOffSetY;
	int FOffSetX;
	TOfficeTabCollection* FAdvOfficeTabs;
	bool FPropertiesLoaded;
	bool FShowNonSelectedTabs;
	TTabSetTabSettings* FTabSettings;
	TTabSetTabScroller* FTabScroller;
	int FActiveTabIndex;
	int FHotTabIndex;
	int FDownTabIndex;
	int FOldHotTabIndex;
	int FHintTabIndex;
	Imglist::TCustomImageList* FImages;
	Imglist::TCustomImageList* FDisabledImages;
	bool FShowTabHint;
	Classes::TNotifyEvent FOnChange;
	TTabChangingEvent FOnChanging;
	int FOldCapRightIndent;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	Comctrls::TTabPosition FTabPosition;
	Advgdip::TAntiAlias FAntiAlias;
	TTabSetButtonSettings* FButtonSettings;
	Menus::TPopupMenu* FTabListMenu;
	TOnTabClose FOnTabClose;
	TOnTabListClick FOnTabListClick;
	bool FRotateTabLeftRight;
	bool FCloseOnTab;
	Advglowbutton::TAdvGlowButton* FTabListButton;
	Advglowbutton::TAdvGlowButton* FScrollPrevButton;
	Advglowbutton::TAdvGlowButton* FScrollNextButton;
	Advglowbutton::TAdvGlowButton* FScrollFirstButton;
	Advglowbutton::TAdvGlowButton* FScrollLastButton;
	int FTabOffSet;
	bool FUseMaxSpace;
	bool FFreeOnClose;
	TDummyHintControl* FDummyHintControl;
	bool FTabRearrange;
	TTabMovedEvent FOnTabMoved;
	TDrawTabEvent FOnDrawTab;
	TCloseOnTabPos FCloseOnTabPosition;
	bool FDesignTime;
	TTabClickEvent FOnTabRightClick;
	TTabClickEvent FOnTabClick;
	TTabClickEvent FOnTabDblClick;
	int FUpdateCount;
	bool FGlow;
	bool FTransparent;
	bool FShowCloseOnNonSelectedTabs;
	TTabClickEvent FOnTabCheckBoxClick;
	Classes::TNotifyEvent FOnLastClick;
	Classes::TNotifyEvent FOnFirstClick;
	Classes::TNotifyEvent FOnPrevClick;
	Classes::TNotifyEvent FOnNextClick;
	bool FIsAeroVista;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Controls::TCMControlListChange &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Messages::TWMMouse &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall OnTabSettingsChanged(System::TObject* Sender);
	void __fastcall OnButtonSettingChanged(System::TObject* Sender);
	void __fastcall OnCloseButtonClick(System::TObject* Sender);
	void __fastcall OnTabListButtonClick(System::TObject* Sender);
	void __fastcall OnTabListMenuClick(System::TObject* Sender);
	void __fastcall OnScrollPrevButtonClick(System::TObject* Sender);
	void __fastcall OnScrollNextButtonClick(System::TObject* Sender);
	void __fastcall OnScrollFirstButtonClick(System::TObject* Sender);
	void __fastcall OnScrollLastButtonClick(System::TObject* Sender);
	void __fastcall OnEnterTab(int TabIndex);
	void __fastcall OnExitTab(int TabIndex);
	void __fastcall SetOfficeTabSetStyler(const TCustomAdvOfficeTabSetStyler* Value);
	Menus::TPopupMenu* __fastcall GetPopupMenuEx(void);
	void __fastcall SetPopupMenuEx(const Menus::TPopupMenu* Value);
	void __fastcall SetShowNonSelectedTabs(const bool Value);
	int __fastcall GetActiveTabIndex(void);
	void __fastcall SetActiveTabIndex(const int Value);
	void __fastcall SetTabSettings(const TTabSetTabSettings* Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetDisabledImages(const Imglist::TCustomImageList* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetTabPosition(const Comctrls::TTabPosition Value);
	void __fastcall SetAntiAlias(const Advgdip::TAntiAlias Value);
	void __fastcall SetButtonSettings(const TTabSetButtonSettings* Value);
	void __fastcall SetTabListMenu(const Menus::TPopupMenu* Value);
	void __fastcall SetCloseOnTab(const bool Value);
	void __fastcall SetRotateTabLeftRight(const bool Value);
	void __fastcall SetAdvOfficeTabs(TOfficeTabCollection* Value);
	void __fastcall SetCloseOnTabPosition(const TCloseOnTabPos Value);
	void __fastcall SetShowCloseOnNonSelectedTabs(const bool Value);
	void __fastcall SetTransparent(const bool Value);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	bool __fastcall DrawTab(int TabIndex);
	void __fastcall DrawAllTabs(void);
	void __fastcall DrawTabScrollButtons(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	DYNAMIC void __fastcall SetChildOrder(Classes::TComponent* Child, int Order);
	void __fastcall UpdateMe(int PropID);
	virtual void __fastcall ChangeActiveTab(int TabIndex);
	void __fastcall UpdateTabScroller(void);
	void __fastcall ScrollLeftBtnClick(void);
	void __fastcall ScrollRightBtnClick(void);
	void __fastcall ScrollLastBtnClick(void);
	void __fastcall ScrollFirstBtnClick(void);
	void __fastcall InitializeAndUpdateButtons(void);
	bool __fastcall AnyButtonVisible(void);
	bool __fastcall CanShowTab(int TabIndex);
	int __fastcall GetVisibleTabCount(void);
	virtual void __fastcall BeforeCloseTab(TOfficeTabCollectionItem* Tab, Forms::TCloseAction &CloseAction);
	virtual bool __fastcall CanCloseTab(int TabIndex, Forms::TCloseAction &CloseAction);
	virtual void __fastcall DoChanging(int FromTab, int ToTab, bool &AllowChange);
	virtual void __fastcall DoChange(void);
	tagSIZE __fastcall GetTextSize(int TabIndex);
	tagSIZE __fastcall GetTabImageSize(int TabIndex);
	void __fastcall GetCloseBtnImageAndTextRect(int TabIndex, Types::TRect &CloseBtnR, Types::TRect &TextR, Types::TPoint &ImgP);
	void __fastcall InvalidateTab(int TabIndex);
	Types::TRect __fastcall GetButtonsRect(void);
	Types::TRect __fastcall GetTabsArea(void);
	Types::TRect __fastcall GetTabsRect(void);
	Types::TRect __fastcall GetTabRect(int StartIndex, int TabIndex, bool ConsiderTabScroller)/* overload */;
	Types::TRect __fastcall GetTabRect(int TabIndex)/* overload */;
	Types::TRect __fastcall GetCheckBoxRect(int TabIndex);
	Types::TRect __fastcall GetCloseButtonRect(int TabIndex);
	Types::TRect __fastcall GetTabListRect(void);
	Types::TRect __fastcall GetTabScrollerRect(void);
	Types::TRect __fastcall GetTabScrollerFirstRect(void);
	Types::TRect __fastcall GetTabScrollerLastRect(void);
	Types::TRect __fastcall GetTabScrollerLeftRect(void);
	Types::TRect __fastcall GetTabScrollerRightRect(void);
	bool __fastcall PtOnTabScrollLeftBtn(int X, int Y);
	bool __fastcall PtOnTabScrollRightBtn(int X, int Y);
	void __fastcall SelectNextSequentialTab(void);
	bool __fastcall IsGlass(void);
	bool __fastcall CanShowCloseButton(void);
	int __fastcall IsActiveTabNeighbour(int TabIndex);
	int __fastcall GetLeftRoundingOffset(void);
	int __fastcall GetRightRoundingOffset(void);
	bool __fastcall UseOldDrawing(void);
	void __fastcall UpdateTabAppearanceOfTabs(void);
	__property TOfficeTabCollection* AdvOfficeTabs = {read=FAdvOfficeTabs, write=SetAdvOfficeTabs};
	__property TCustomAdvOfficeTabSetStyler* AdvOfficeTabSetStyler = {read=FOfficeTabSetStyler, write=SetOfficeTabSetStyler};
	__property int ActiveTabIndex = {read=GetActiveTabIndex, write=SetActiveTabIndex, nodefault};
	__property Advgdip::TAntiAlias AntiAlias = {read=FAntiAlias, write=SetAntiAlias, default=1};
	__property TTabSetButtonSettings* ButtonSettings = {read=FButtonSettings, write=SetButtonSettings};
	__property bool CloseOnTab = {read=FCloseOnTab, write=SetCloseOnTab, default=0};
	__property TCloseOnTabPos CloseOnTabPosition = {read=FCloseOnTabPosition, write=SetCloseOnTabPosition, default=0};
	__property Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property bool FreeOnClose = {read=FFreeOnClose, write=FFreeOnClose, default=0};
	__property bool Glow = {read=FGlow, write=FGlow, default=1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property Menus::TPopupMenu* TabListMenu = {read=FTabListMenu, write=SetTabListMenu};
	__property Menus::TPopupMenu* PopupMenu = {read=GetPopupMenuEx, write=SetPopupMenuEx};
	__property bool RotateTabLeftRight = {read=FRotateTabLeftRight, write=SetRotateTabLeftRight, default=1};
	__property bool ShowCloseOnNonSelectedTabs = {read=FShowCloseOnNonSelectedTabs, write=SetShowCloseOnNonSelectedTabs, default=0};
	__property bool ShowNonSelectedTabs = {read=FShowNonSelectedTabs, write=SetShowNonSelectedTabs, default=0};
	__property bool ShowTabHint = {read=FShowTabHint, write=FShowTabHint, default=0};
	__property Comctrls::TTabPosition TabPosition = {read=FTabPosition, write=SetTabPosition, default=0};
	__property bool TabRearrange = {read=FTabRearrange, write=FTabRearrange, default=0};
	__property TTabSetTabSettings* TabSettings = {read=FTabSettings, write=SetTabSettings};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TTabChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TOnTabClose OnTabClose = {read=FOnTabClose, write=FOnTabClose};
	__property TTabMovedEvent OnTabMoved = {read=FOnTabMoved, write=FOnTabMoved};
	__property TOnTabListClick OnTabListClick = {read=FOnTabListClick, write=FOnTabListClick};
	__property TDrawTabEvent OnDrawTab = {read=FOnDrawTab, write=FOnDrawTab};
	__property TTabClickEvent OnTabClick = {read=FOnTabClick, write=FOnTabClick};
	__property TTabClickEvent OnTabDblClick = {read=FOnTabDblClick, write=FOnTabDblClick};
	__property TTabClickEvent OnTabRightClick = {read=FOnTabRightClick, write=FOnTabRightClick};
	__property TTabClickEvent OnTabCheckBoxClick = {read=FOnTabCheckBoxClick, write=FOnTabCheckBoxClick};
	__property Classes::TNotifyEvent OnPrevClick = {read=FOnPrevClick, write=FOnPrevClick};
	__property Classes::TNotifyEvent OnNextClick = {read=FOnNextClick, write=FOnNextClick};
	__property Classes::TNotifyEvent OnFirstClick = {read=FOnFirstClick, write=FOnFirstClick};
	__property Classes::TNotifyEvent OnLastClick = {read=FOnLastClick, write=FOnLastClick};
	
public:
	__fastcall virtual TAdvCustomOfficeTabSet(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TAdvCustomOfficeTabSet(void);
	void __fastcall Init(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	int __fastcall PTOnTab(int X, int Y);
	bool __fastcall PTOnCheckBox(int PageIndex, int X, int Y);
	int __fastcall GetVersionNr(void);
	int __fastcall FindNextTab(int TabIndex, bool GoForward, bool CheckTabVisible);
	void __fastcall SelectNextTab(bool GoForward);
	virtual void __fastcall CloseAllTabs(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomOfficeTabSet(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeTabSet;
class PASCALIMPLEMENTATION TAdvOfficeTabSet : public TAdvCustomOfficeTabSet
{
	typedef TAdvCustomOfficeTabSet inherited;
	
__published:
	__property AdvOfficeTabs;
	__property AdvOfficeTabSetStyler;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property ActiveTabIndex;
	__property AntiAlias = {default=1};
	__property ButtonSettings;
	__property Constraints;
	__property CloseOnTab = {default=0};
	__property CloseOnTabPosition = {default=0};
	__property DisabledImages;
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property FreeOnClose = {default=0};
	__property Glow = {default=1};
	__property Images;
	__property OfficeHint;
	__property TabListMenu;
	__property PopupMenu;
	__property RotateTabLeftRight = {default=1};
	__property ShowNonSelectedTabs = {default=0};
	__property ShowCloseOnNonSelectedTabs = {default=0};
	__property ShowTabHint = {default=0};
	__property ShowHint;
	__property TabPosition = {default=0};
	__property TabRearrange = {default=0};
	__property TabSettings;
	__property Transparent = {default=0};
	__property Version;
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnDragOver;
	__property OnDragDrop;
	__property OnDrawTab;
	__property OnEndDrag;
	__property OnTabClose;
	__property OnTabMoved;
	__property OnTabClick;
	__property OnTabCheckBoxClick;
	__property OnTabDblClick;
	__property OnTabRightClick;
	__property OnTabListClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property OnPrevClick;
	__property OnNextClick;
	__property OnFirstClick;
	__property OnLastClick;
public:
	/* TAdvCustomOfficeTabSet.Create */ inline __fastcall virtual TAdvOfficeTabSet(Classes::TComponent* AOwner) : TAdvCustomOfficeTabSet(AOwner) { }
	/* TAdvCustomOfficeTabSet.Destroy */ inline __fastcall virtual ~TAdvOfficeTabSet(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeTabSet(HWND ParentWindow) : TAdvCustomOfficeTabSet(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeMDITabSet;
class PASCALIMPLEMENTATION TAdvOfficeMDITabSet : public TAdvCustomOfficeTabSet
{
	typedef TAdvCustomOfficeTabSet inherited;
	
private:
	bool FInternalDelete;
	int __fastcall GetAdvOfficeTabCount(void);
	TOfficeTabCollectionItem* __fastcall GetAdvOfficeTabs(int index);
	void __fastcall OnChildFormActivate(System::TObject* Sender);
	void __fastcall OnChildFormDestroy(System::TObject* Sender);
	
protected:
	virtual void __fastcall ChangeActiveTab(int TabIndex);
	virtual void __fastcall BeforeCloseTab(TOfficeTabCollectionItem* Tab, Forms::TCloseAction &CloseAction);
	virtual bool __fastcall CanCloseTab(int TabIndex, Forms::TCloseAction &CloseAction);
	void __fastcall Change(void);
	
public:
	__fastcall virtual TAdvOfficeMDITabSet(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeMDITabSet(void);
	TOfficeTabCollectionItem* __fastcall AddTab(Forms::TForm* ChildForm);
	Forms::TForm* __fastcall GetChildForm(TOfficeTabCollectionItem* Tab);
	virtual void __fastcall CloseAllTabs(void);
	__property int AdvOfficeTabCount = {read=GetAdvOfficeTabCount, nodefault};
	__property TOfficeTabCollectionItem* AdvOfficeTabs[int index] = {read=GetAdvOfficeTabs};
	TOfficeTabCollectionItem* __fastcall GetTab(Forms::TForm* AChild);
	__property ActiveTabIndex;
	
__published:
	__property AdvOfficeTabSetStyler;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AntiAlias = {default=1};
	__property ButtonSettings;
	__property Constraints;
	__property CloseOnTab = {default=0};
	__property CloseOnTabPosition = {default=0};
	__property DisabledImages;
	__property Glow = {default=1};
	__property Images;
	__property OfficeHint;
	__property TabListMenu;
	__property PopupMenu;
	__property RotateTabLeftRight = {default=1};
	__property ShowNonSelectedTabs = {default=0};
	__property ShowCloseOnNonSelectedTabs = {default=0};
	__property ShowTabHint = {default=0};
	__property ShowHint;
	__property TabPosition = {default=0};
	__property TabRearrange = {default=0};
	__property TabSettings;
	__property Version;
	__property Visible = {default=1};
	__property OnChange;
	__property OnChanging;
	__property OnDrawTab;
	__property OnTabClose;
	__property OnTabMoved;
	__property OnTabClick;
	__property OnTabDblClick;
	__property OnTabRightClick;
	__property OnTabListClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeMDITabSet(HWND ParentWindow) : TAdvCustomOfficeTabSet(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt GLOWSPEED = 0x32;
static const ShortInt IMG_SPACE = 0x2;
static const ShortInt DEFAULT_TABHEIGHT = 0x1a;
static const ShortInt ADVPAGE_OFFSET = 0x1;
static const ShortInt SCROLLER_SIZE = 0x20;
static const ShortInt TabBUTTON_SIZE = 0x12;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x6;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
static const ShortInt MAX_ROUNDING = 0x8;
extern PACKAGE System::Word WM_OTSDESTROYCLOSEBTN;

}	/* namespace Advofficetabset */
using namespace Advofficetabset;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvofficetabsetHPP
