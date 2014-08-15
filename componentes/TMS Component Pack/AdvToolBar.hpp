// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtoolbar.pas' rev: 21.00

#ifndef AdvtoolbarHPP
#define AdvtoolbarHPP

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
#include <Menus.hpp>	// Pascal unit
#include <Advmenus.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Uxtheme.hpp>	// Pascal unit
#include <Db.hpp>	// Pascal unit
#include <Axctrls.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtoolbar
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

class DELPHICLASS TAppIconGlowButton;
class PASCALIMPLEMENTATION TAppIconGlowButton : public Advglowbutton::TAdvGlowButton
{
	typedef Advglowbutton::TAdvGlowButton inherited;
	
public:
	/* TAdvCustomGlowButton.Create */ inline __fastcall virtual TAppIconGlowButton(Classes::TComponent* AOwner) : Advglowbutton::TAdvGlowButton(AOwner) { }
	/* TAdvCustomGlowButton.Destroy */ inline __fastcall virtual ~TAppIconGlowButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAppIconGlowButton(HWND ParentWindow) : Advglowbutton::TAdvGlowButton(ParentWindow) { }
	
};


#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TDockAlign { daLeft, daTop, daRight, daBottom };
#pragma option pop

#pragma option push -b-
enum TBackGroundDisplay { bdTile, bdCenter, bdStretch };
#pragma option pop

#pragma option push -b-
enum TDragGripStyle { dsDots, dsSingleLine, dsDoubleLine, dsFlatDots, dsNone };
#pragma option pop

#pragma option push -b-
enum TToolBarState { tsDocked, tsFloating, tsFixed };
#pragma option pop

#pragma option push -b-
enum TItemChangeAction { icRefresh, isResize };
#pragma option pop

#pragma option push -b-
enum TButtomItemStyle { bisButton, bisCheck };
#pragma option pop

#pragma option push -b-
enum TGlyphPosition { gpLeft, gpTop, gpRight, gpBottom };
#pragma option pop

#pragma option push -b-
enum TCaptionPosition { cpTop, cpBottom };
#pragma option pop

#pragma option push -b-
enum TCaptionButton { cbClose, cbMinimize, cbMaximize };
#pragma option pop

typedef Set<TCaptionButton, cbClose, cbMaximize>  TCaptionButtons;

#pragma option push -b-
enum TScrollArrow { saLeft, saTop, saRight, saBottom, saNone };
#pragma option pop

#pragma option push -b-
enum TArrowStyle { asSingle, asDouble, asWithLine };
#pragma option pop

#pragma option push -b-
enum TDockMode { dmAll, dmAllParentDockPanels, dmParentDockPanelOnly };
#pragma option pop

typedef Set<TDockAlign, daLeft, daBottom>  TDockableTo;

class DELPHICLASS TProForm;
class PASCALIMPLEMENTATION TProForm : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
public:
	/* TCustomForm.Create */ inline __fastcall virtual TProForm(Classes::TComponent* AOwner) : Forms::TCustomForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TProForm(Classes::TComponent* AOwner, int Dummy) : Forms::TCustomForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TProForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TProForm(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class DELPHICLASS TProWinControl;
class PASCALIMPLEMENTATION TProWinControl : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
public:
	/* TWinControl.Create */ inline __fastcall virtual TProWinControl(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TProWinControl(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TProWinControl(void) { }
	
};


class DELPHICLASS TProCustomGlowButton;
class PASCALIMPLEMENTATION TProCustomGlowButton : public Advglowbutton::TAdvCustomGlowButton
{
	typedef Advglowbutton::TAdvCustomGlowButton inherited;
	
public:
	/* TAdvCustomGlowButton.Create */ inline __fastcall virtual TProCustomGlowButton(Classes::TComponent* AOwner) : Advglowbutton::TAdvCustomGlowButton(AOwner) { }
	/* TAdvCustomGlowButton.Destroy */ inline __fastcall virtual ~TProCustomGlowButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TProCustomGlowButton(HWND ParentWindow) : Advglowbutton::TAdvCustomGlowButton(ParentWindow) { }
	
};


class DELPHICLASS TProControl;
class PASCALIMPLEMENTATION TProControl : public Controls::TControl
{
	typedef Controls::TControl inherited;
	
public:
	/* TControl.Create */ inline __fastcall virtual TProControl(Classes::TComponent* AOwner) : Controls::TControl(AOwner) { }
	/* TControl.Destroy */ inline __fastcall virtual ~TProControl(void) { }
	
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
	void __fastcall AssignList(Classes::TList* ListA);
	__property void * Items[int Index] = {read=GetItemsEx, write=SetItemsEx/*, default*/};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TDbgList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TDbgList(void) : Classes::TList() { }
	
};


class DELPHICLASS TButtonAppearance;
class PASCALIMPLEMENTATION TButtonAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorTo;
	Graphics::TColor FColor;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorDown;
	Graphics::TColor FBorderDownColor;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderHotColor;
	TGradientDirection FGradientDirection;
	Graphics::TColor FColorChecked;
	Graphics::TColor FColorCheckedTo;
	Graphics::TColor FCaptionTextColorChecked;
	Graphics::TColor FCaptionTextColor;
	Graphics::TColor FCaptionTextColorHot;
	Graphics::TColor FCaptionTextColorDown;
	Graphics::TColor FBorderCheckedColor;
	Graphics::TFont* FCaptionFont;
	TGlyphPosition FGlyphPosition;
	TGradientDirection FGradientDirectionDown;
	TGradientDirection FGradientDirectionHot;
	TGradientDirection FGradientDirectionChecked;
	bool FSystemFont;
	void __fastcall Change(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	void __fastcall SetColorChecked(const Graphics::TColor Value);
	void __fastcall SetColorCheckedTo(const Graphics::TColor Value);
	void __fastcall SetCaptionTextColor(const Graphics::TColor Value);
	void __fastcall SetCaptionTextColorDown(const Graphics::TColor Value);
	void __fastcall SetCaptionTextColorHot(const Graphics::TColor Value);
	void __fastcall SetCaptionTextColorChecked(const Graphics::TColor Value);
	void __fastcall SetBorderCheckedColor(const Graphics::TColor Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetGlyphPosition(const TGlyphPosition Value);
	void __fastcall SetGradientDirectionChecked(const TGradientDirection Value);
	void __fastcall SetGradientDirectionDown(const TGradientDirection Value);
	void __fastcall SetGradientDirectionHot(const TGradientDirection Value);
	void __fastcall SetSystemFont(const bool Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TGlyphPosition GlyphPosition = {read=FGlyphPosition, write=SetGlyphPosition, default=0};
	
public:
	__fastcall TButtonAppearance(void);
	__fastcall virtual ~TButtonAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor ColorChecked = {read=FColorChecked, write=SetColorChecked, default=14210516};
	__property Graphics::TColor ColorCheckedTo = {read=FColorCheckedTo, write=SetColorCheckedTo, default=536870911};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, default=11899525};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, default=536870911};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, default=13811126};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, default=536870911};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, default=0};
	__property Graphics::TColor CaptionTextColorHot = {read=FCaptionTextColorHot, write=SetCaptionTextColorHot, default=0};
	__property Graphics::TColor CaptionTextColorDown = {read=FCaptionTextColorDown, write=SetCaptionTextColorDown, default=0};
	__property Graphics::TColor CaptionTextColorChecked = {read=FCaptionTextColorChecked, write=SetCaptionTextColorChecked, default=0};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=1};
	__property TGradientDirection GradientDirectionHot = {read=FGradientDirectionHot, write=SetGradientDirectionHot, default=1};
	__property TGradientDirection GradientDirectionDown = {read=FGradientDirectionDown, write=SetGradientDirectionDown, default=1};
	__property TGradientDirection GradientDirectionChecked = {read=FGradientDirectionChecked, write=SetGradientDirectionChecked, default=1};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BorderDownColor = {read=FBorderDownColor, write=FBorderDownColor, default=6956042};
	__property Graphics::TColor BorderHotColor = {read=FBorderHotColor, write=FBorderHotColor, default=6956042};
	__property Graphics::TColor BorderCheckedColor = {read=FBorderCheckedColor, write=SetBorderCheckedColor, default=6956042};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
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


class DELPHICLASS TMirrorGradient;
class PASCALIMPLEMENTATION TMirrorGradient : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FColorTo;
	Graphics::TColor FColor;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FColorMirror;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TMirrorGradient(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, nodefault};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TMirrorGradient(void) { }
	
};


class DELPHICLASS TVistaGradientBackground;
class PASCALIMPLEMENTATION TVistaGradientBackground : public TGradientBackground
{
	typedef TGradientBackground inherited;
	
private:
	TMirrorGradient* FMirror;
	void __fastcall SetMirror(const TMirrorGradient* Value);
	
public:
	__fastcall TVistaGradientBackground(void);
	__fastcall virtual ~TVistaGradientBackground(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TMirrorGradient* Mirror = {read=FMirror, write=SetMirror};
};


class DELPHICLASS TContainerAppearance;
class PASCALIMPLEMENTATION TContainerAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	bool FLine3D;
	Graphics::TColor FLineColor;
	void __fastcall SetLine3D(const bool Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TContainerAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, nodefault};
	__property bool Line3D = {read=FLine3D, write=SetLine3D, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TContainerAppearance(void) { }
	
};


class DELPHICLASS TCaptionAppearance;
class PASCALIMPLEMENTATION TCaptionAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FCaptionTextColorHot;
	Graphics::TColor FCaptionTextColor;
	Graphics::TColor FCaptionBorderColorHot;
	Graphics::TColor FCaptionColorHot;
	Graphics::TColor FCaptionColorTo;
	Graphics::TColor FCaptionColor;
	Graphics::TColor FCaptionColorHotTo;
	Graphics::TColor FCaptionBorderColor;
	void __fastcall SetCaptionBorderColor(const Graphics::TColor Value);
	void __fastcall SetCaptionBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	void __fastcall SetCaptionColorHot(const Graphics::TColor Value);
	void __fastcall SetCaptionColorHotTo(const Graphics::TColor Value);
	void __fastcall SetCaptionColorTo(const Graphics::TColor Value);
	void __fastcall SetCaptionTextColor(const Graphics::TColor Value);
	void __fastcall SetCaptionTextColorHot(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TCaptionAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, nodefault};
	__property Graphics::TColor CaptionColorTo = {read=FCaptionColorTo, write=SetCaptionColorTo, default=536870911};
	__property Graphics::TColor CaptionTextColor = {read=FCaptionTextColor, write=SetCaptionTextColor, default=16777215};
	__property Graphics::TColor CaptionBorderColor = {read=FCaptionBorderColor, write=SetCaptionBorderColor, default=536870911};
	__property Graphics::TColor CaptionColorHot = {read=FCaptionColorHot, write=SetCaptionColorHot, default=536870911};
	__property Graphics::TColor CaptionColorHotTo = {read=FCaptionColorHotTo, write=SetCaptionColorHotTo, default=536870911};
	__property Graphics::TColor CaptionTextColorHot = {read=FCaptionTextColorHot, write=SetCaptionTextColorHot, default=16777215};
	__property Graphics::TColor CaptionBorderColorHot = {read=FCaptionBorderColorHot, write=SetCaptionBorderColorHot, default=536870911};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TCaptionAppearance(void) { }
	
};


class DELPHICLASS TCustomAdvToolBarStyler;
class DELPHICLASS TVistaTextBackground;
class DELPHICLASS TTabAppearance;
class DELPHICLASS TVistaPageBackground;
class DELPHICLASS TGroupAppearance;
class DELPHICLASS TQATAppearance;
class PASCALIMPLEMENTATION TCustomAdvToolBarStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FBackGroundTransparent;
	TBackGroundDisplay FBackGroundDisplay;
	Graphics::TBitmap* FBackGround;
	TVistaGradientBackground* FColor;
	TGradientBackground* FDockColor;
	Advmenus::TCustomAdvMenuStyler* FInternalAdvMenuStyler;
	Advmenus::TCustomAdvMenuStyler* FAdvMenuStyler;
	Advmenus::TCustomAdvMenuStyler* FCurrentAdvMenuStyler;
	TDragGripStyle FDragGripStyle;
	Graphics::TBitmap* FDragGripImage;
	Graphics::TBitmap* FRightHandleImage;
	Graphics::TFont* FFont;
	bool FTransparent;
	TDbgList* FControlList;
	bool FRoundEdges;
	Graphics::TColor FRightHandleColor;
	Graphics::TColor FRightHandleColorHot;
	Graphics::TColor FRightHandleColorTo;
	Graphics::TColor FRightHandleColorHotTo;
	int FFloatingWindowBorderWidth;
	Graphics::TColor FFloatingWindowBorderColor;
	TButtonAppearance* FButtonAppearance;
	bool FAutoThemeAdapt;
	Graphics::TColor FRightHandleColorDownTo;
	Graphics::TColor FRightHandleColorDown;
	Controls::TBevelCut FBevel;
	bool FUseBevel;
	Graphics::TColor FBorderColorHot;
	Graphics::TColor FBorderColor;
	TVistaGradientBackground* FColorHot;
	Graphics::TFont* FCaptionFont;
	Advstyleif::TTMSStyle FTMSStyle;
	TContainerAppearance* FContainerAppearance;
	Advglowbutton::TGlowButtonAppearance* FGlowButtonAppearance;
	TVistaTextBackground* FPagerCaption;
	TTabAppearance* FTabAppearance;
	TVistaPageBackground* FPageAppearance;
	TCaptionAppearance* FCaptionAppearance;
	TGroupAppearance* FGroupAppearance;
	Advglowbutton::TGlowButtonAppearance* FCompactGlowButtonAppearance;
	TQATAppearance* FQATAppearance;
	bool FSystemFont;
	bool FQatSharpCurve;
	Graphics::TColor FFormBorderColor;
	Graphics::TColor FSysButtonColor;
	Advstyleif::TTMSStyle FNewTMSStyle;
	void __fastcall OnPagerCaptionChanged(System::TObject* Sender);
	void __fastcall OnTabAppearanceChanged(System::TObject* Sender);
	void __fastcall OnPageAppearanceChanged(System::TObject* Sender);
	void __fastcall OnGroupAppearanceChanged(System::TObject* Sender);
	void __fastcall OnContainerAppearanceChanged(System::TObject* Sender);
	void __fastcall OnGlowButtonAppearanceChanged(System::TObject* Sender);
	void __fastcall OnCaptionAppearanceChanged(System::TObject* Sender);
	void __fastcall OnQATAppearanceChanged(System::TObject* Sender);
	void __fastcall SetBackGround(const Graphics::TBitmap* Value);
	void __fastcall SetBackGroundDisplay(const TBackGroundDisplay Value);
	void __fastcall SetBackGroundTransparent(const bool Value);
	void __fastcall SetColor(const TVistaGradientBackground* Value);
	void __fastcall SetAdvMenuStyler(const Advmenus::TCustomAdvMenuStyler* Value);
	void __fastcall SetDragGripStyle(const TDragGripStyle Value);
	void __fastcall SetDragGripImage(const Graphics::TBitmap* Value);
	void __fastcall SetRightHandleImage(const Graphics::TBitmap* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetRoundEdges(const bool Value);
	void __fastcall SetRightHandleColor(const Graphics::TColor Value);
	void __fastcall SetRightHandleColorHot(const Graphics::TColor Value);
	void __fastcall SetFloatingWindowBorderColor(const Graphics::TColor Value);
	void __fastcall SetFloatingWindowBorderWidth(const int Value);
	void __fastcall SetTButtonAppearance(const TButtonAppearance* Value);
	void __fastcall SetDockColor(const TGradientBackground* Value);
	void __fastcall SetRightHandleColorTo(const Graphics::TColor Value);
	void __fastcall SetRightHandleColorHotTo(const Graphics::TColor Value);
	void __fastcall SetRightHandleColorDown(const Graphics::TColor Value);
	void __fastcall SetRightHandleColorDownTo(const Graphics::TColor Value);
	void __fastcall SetBevel(const Controls::TBevelCut Value);
	void __fastcall SetUseBevel(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHot(const TVistaGradientBackground* Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetContainerAppearance(const TContainerAppearance* Value);
	void __fastcall SetGlowButtonAppearance(const Advglowbutton::TGlowButtonAppearance* Value);
	void __fastcall SetPagerCaption(const TVistaTextBackground* Value);
	void __fastcall SetTabAppearance(const TTabAppearance* Value);
	void __fastcall SetPageAppearance(const TVistaPageBackground* Value);
	void __fastcall SetGroupAppearance(const TGroupAppearance* Value);
	void __fastcall SetCaptionAppearance(const TCaptionAppearance* Value);
	void __fastcall SetCompactGlowButtonAppearance(const Advglowbutton::TGlowButtonAppearance* Value);
	void __fastcall SetQATAppearance(const TQATAppearance* Value);
	void __fastcall SetSystemFont(const bool Value);
	void __fastcall SetFormBorderColor(const Graphics::TColor Value);
	void __fastcall SetSysButtonColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall BackgroundChanged(System::TObject* Sender);
	__property Advmenus::TCustomAdvMenuStyler* CurrentAdvMenuStyler = {read=FCurrentAdvMenuStyler};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property TButtonAppearance* ButtonAppearance = {read=FButtonAppearance, write=SetTButtonAppearance};
	__property TVistaGradientBackground* Color = {read=FColor, write=SetColor};
	__property TGradientBackground* DockColor = {read=FDockColor, write=SetDockColor};
	__property Graphics::TBitmap* BackGround = {read=FBackGround, write=SetBackGround};
	__property bool BackGroundTransparent = {read=FBackGroundTransparent, write=SetBackGroundTransparent, default=1};
	__property TBackGroundDisplay BackGroundDisplay = {read=FBackGroundDisplay, write=SetBackGroundDisplay, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool QATSharpCurve = {read=FQatSharpCurve, write=FQatSharpCurve, nodefault};
	__property TDragGripStyle DragGripStyle = {read=FDragGripStyle, write=SetDragGripStyle, default=0};
	__property Graphics::TBitmap* DragGripImage = {read=FDragGripImage, write=SetDragGripImage};
	__property Graphics::TBitmap* RightHandleImage = {read=FRightHandleImage, write=SetRightHandleImage};
	__property Graphics::TColor RightHandleColor = {read=FRightHandleColor, write=SetRightHandleColor, default=8421504};
	__property Graphics::TColor RightHandleColorHot = {read=FRightHandleColorHot, write=SetRightHandleColorHot, nodefault};
	__property Graphics::TColor RightHandleColorTo = {read=FRightHandleColorTo, write=SetRightHandleColorTo, default=8421504};
	__property Graphics::TColor RightHandleColorHotTo = {read=FRightHandleColorHotTo, write=SetRightHandleColorHotTo, nodefault};
	__property Graphics::TColor RightHandleColorDown = {read=FRightHandleColorDown, write=SetRightHandleColorDown, nodefault};
	__property Graphics::TColor RightHandleColorDownTo = {read=FRightHandleColorDownTo, write=SetRightHandleColorDownTo, nodefault};
	__property Graphics::TColor FloatingWindowBorderColor = {read=FFloatingWindowBorderColor, write=SetFloatingWindowBorderColor, nodefault};
	__property int FloatingWindowBorderWidth = {read=FFloatingWindowBorderWidth, write=SetFloatingWindowBorderWidth, default=2};
	__property Controls::TBevelCut Bevel = {read=FBevel, write=SetBevel, default=0};
	__property bool RoundEdges = {read=FRoundEdges, write=SetRoundEdges, default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool UseBevel = {read=FUseBevel, write=SetUseBevel, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, default=536870911};
	__property TVistaGradientBackground* ColorHot = {read=FColorHot, write=SetColorHot};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property TContainerAppearance* ContainerAppearance = {read=FContainerAppearance, write=SetContainerAppearance};
	__property TVistaTextBackground* PagerCaption = {read=FPagerCaption, write=SetPagerCaption};
	__property TTabAppearance* TabAppearance = {read=FTabAppearance, write=SetTabAppearance};
	__property TVistaPageBackground* PageAppearance = {read=FPageAppearance, write=SetPageAppearance};
	__property TGroupAppearance* GroupAppearance = {read=FGroupAppearance, write=SetGroupAppearance};
	__property TQATAppearance* QATAppearance = {read=FQATAppearance, write=SetQATAppearance};
	__property Advstyleif::TTMSStyle TMSStyle = {read=FTMSStyle, write=FTMSStyle, nodefault};
	__property Advstyleif::TTMSStyle NewTMSStyle = {read=FNewTMSStyle, write=FNewTMSStyle, nodefault};
	__property Graphics::TColor FormBorderColor = {read=FFormBorderColor, write=SetFormBorderColor, default=0};
	void __fastcall Change(int PropID);
	void __fastcall ApplyStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall LoadPropFromFile(System::TextFile &F);
	void __fastcall SavePropToFile(System::TextFile &F);
	void __fastcall ReleaseAllControls(void);
	
public:
	__fastcall virtual TCustomAdvToolBarStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomAdvToolBarStyler(void);
	virtual void __fastcall Loaded(void);
	void __fastcall UpdateStyle(void);
	void __fastcall AddControl(Controls::TCustomControl* AControl);
	void __fastcall RemoveControl(Controls::TCustomControl* AControl);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Advmenus::TCustomAdvMenuStyler* AdvMenuStyler = {read=FAdvMenuStyler, write=SetAdvMenuStyler};
	__property Advglowbutton::TGlowButtonAppearance* GlowButtonAppearance = {read=FGlowButtonAppearance, write=SetGlowButtonAppearance};
	__property Advglowbutton::TGlowButtonAppearance* CompactGlowButtonAppearance = {read=FCompactGlowButtonAppearance, write=SetCompactGlowButtonAppearance};
	__property TCaptionAppearance* CaptionAppearance = {read=FCaptionAppearance, write=SetCaptionAppearance};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
	__property Graphics::TColor SysButtonColor = {read=FSysButtonColor, write=SetSysButtonColor, default=0};
};


typedef void __fastcall (__closure *TOnDeleteItemEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TRowCollectionItem;
class DELPHICLASS TAdvCustomToolBar;
class PASCALIMPLEMENTATION TRowCollectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TDbgList* FToolBarList;
	Types::TRect FRowRect;
	int __fastcall GetHeight(void);
	Types::TRect __fastcall GetRowRect(void);
	
protected:
	int __fastcall GetSpace(TAdvCustomToolBar* FirstAdvToolBar, TAdvCustomToolBar* SecondAdvToolBar);
	void __fastcall SetRowRect(const Types::TRect &R);
	__property TDbgList* ToolBarList = {read=FToolBarList};
	bool __fastcall IsAnyToolBarViolatingBounds(void);
	
public:
	__fastcall virtual TRowCollectionItem(Classes::TCollection* Collection);
	__fastcall virtual ~TRowCollectionItem(void);
	void __fastcall ArrangeToolBars(void);
	bool __fastcall IsAllowed(TAdvCustomToolBar* aAdvToolBar);
	int __fastcall AddToolBar(TAdvCustomToolBar* aAdvToolBar);
	bool __fastcall InsertToolBar(TAdvCustomToolBar* aAdvToolBar, int X);
	void __fastcall RemoveToolBar(TAdvCustomToolBar* aAdvToolBar, bool DeleteIfEmpty = true);
	void __fastcall SetToolBarLeftAndWidth(TAdvCustomToolBar* aAdvToolBar, int &ALeft, int &AWidth);
	void __fastcall SetToolBarTopAndHeight(TAdvCustomToolBar* aAdvToolBar, int &ATop, int &AHeight);
	__property int Height = {read=GetHeight, nodefault};
	__property Types::TRect RowRect = {read=GetRowRect};
};


class DELPHICLASS TRowCollection;
class DELPHICLASS TAdvDockPanel;
class PASCALIMPLEMENTATION TRowCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TRowCollectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvDockPanel* FOwner;
	Classes::TNotifyEvent FOnChange;
	TOnDeleteItemEvent FOnDeleteItem;
	int FOffSetY;
	int FOffSetX;
	void __fastcall SetParentSize(void);
	HIDESBASE TRowCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TRowCollectionItem* Value);
	
protected:
	void __fastcall DeleteMeIfEmpty(TRowCollectionItem* AItem);
	void __fastcall SetRowsPosition(void);
	void __fastcall SetToolBarFullSize(TAdvCustomToolBar* aAdvToolBar);
	void __fastcall UpdateToolBarVisibility(TAdvCustomToolBar* aAdvToolBar);
	void __fastcall ReArrangeAllToolBars(void);
	bool __fastcall IsAnyToolBarViolatingBounds(void);
	__property int OffSetX = {read=FOffSetX, default=2};
	__property int OffSetY = {read=FOffSetY, default=1};
	
public:
	__fastcall TRowCollection(TAdvDockPanel* AOwner);
	__property TRowCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TRowCollectionItem* __fastcall Add(void);
	HIDESBASE TRowCollectionItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	int __fastcall IsToolBarAlreadyAdded(TAdvCustomToolBar* aAdvToolBar);
	void __fastcall SetToolBarTopAndHeight(TAdvCustomToolBar* aAdvToolBar, int &ATop, int &AHeight);
	void __fastcall SetToolBarLeftAndWidth(TAdvCustomToolBar* aAdvToolBar, int &ALeft, int &AWidth);
	void __fastcall MoveToolBarToRow(TAdvCustomToolBar* aAdvToolBar, int ARowIndex);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TOnDeleteItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TRowCollection(void) { }
	
};


#pragma option push -b-
enum TPersistenceLocation { plRegistry, plIniFile };
#pragma option pop

class DELPHICLASS TPersistence;
class PASCALIMPLEMENTATION TPersistence : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TComponent* FOwner;
	System::UnicodeString FKey;
	System::UnicodeString FSection;
	TPersistenceLocation FLocation;
	bool FEnabled;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetKey(const System::UnicodeString Value);
	void __fastcall SetLocation(const TPersistenceLocation Value);
	void __fastcall SetSection(const System::UnicodeString Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TPersistence(Classes::TComponent* AOwner);
	__fastcall virtual ~TPersistence(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TPersistenceLocation Location = {read=FLocation, write=SetLocation, nodefault};
	__property System::UnicodeString Key = {read=FKey, write=SetKey};
	__property System::UnicodeString Section = {read=FSection, write=SetSection};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION TAdvDockPanel : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TCustomAdvToolBarStyler* FInternalToolBarStyler;
	TCustomAdvToolBarStyler* FToolBarStyler;
	TCustomAdvToolBarStyler* FCurrentToolBarStyler;
	TDockAlign FDockAlign;
	TRowCollection* FRows;
	int FOffSetY;
	int FOffSetX;
	TDbgList* FToolBars;
	TDbgList* FHiddenToolBars;
	Graphics::TBitmap* FMyImage;
	TPersistence* FPersistence;
	int FMinimumSize;
	bool FLockHeight;
	bool FPropertiesLoaded;
	bool FUseRunTimeHeight;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	void __fastcall OnPersistenceChange(System::TObject* Sender);
	void __fastcall SetToolBarStyler(const TCustomAdvToolBarStyler* Value);
	TDockAlign __fastcall GetAlign(void);
	HIDESBASE void __fastcall SetAlign(const TDockAlign Value);
	int __fastcall GetAdvToolBarCount(void);
	TAdvCustomToolBar* __fastcall GetAdvToolBars(int index);
	int __fastcall GetRowCount(void);
	void __fastcall SetPersistence(const TPersistence* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetMinimumSize(const int Value);
	Menus::TPopupMenu* __fastcall GetPopupMenuEx(void);
	void __fastcall SetPopupMenuEx(const Menus::TPopupMenu* Value);
	void __fastcall SetLockHeight(const bool Value);
	void __fastcall SetUseRunTimeHeight(const bool Value);
	
protected:
	void __fastcall UpdateMe(int PropID);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Paint(void);
	Graphics::TBitmap* __fastcall GetMyImage(void);
	int __fastcall IsAllowedInAnyRow(TAdvCustomToolBar* aAdvToolBar);
	bool __fastcall IsAnyToolBarViolatingBounds(void);
	void __fastcall UpdateToolBarsArrangement(void);
	int __fastcall AddToolBar(TAdvCustomToolBar* aAdvToolBar);
	void __fastcall RemoveToolBar(TAdvCustomToolBar* aAdvToolBar);
	void __fastcall UpdateToolBarVisibility(TAdvCustomToolBar* aAdvToolBar);
	void __fastcall SetToolBarFullSize(TAdvCustomToolBar* aAdvToolBar);
	void __fastcall SetToolBarBounds(TAdvCustomToolBar* aAdvToolBar, int &ALeft, int &ATop, int &AWidth, int &AHeight);
	__property TRowCollection* Rows = {read=FRows};
	__property int OffSetX = {read=FOffSetX, default=1};
	__property int OffSetY = {read=FOffSetY, default=0};
	__property TDbgList* ToolBars = {read=FToolBars};
	
public:
	__fastcall virtual TAdvDockPanel(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	__fastcall virtual ~TAdvDockPanel(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SaveToolBarsPosition(void);
	void __fastcall LoadToolBarsPosition(void);
	int __fastcall GetVersionNr(void);
	void __fastcall ArrangeToolBars(void);
	__property int RowCount = {read=GetRowCount, nodefault};
	__property int AdvToolBarCount = {read=GetAdvToolBarCount, nodefault};
	__property TAdvCustomToolBar* AdvToolBars[int index] = {read=GetAdvToolBars};
	
__published:
	__property TDockAlign Align = {read=GetAlign, write=SetAlign, default=1};
	__property int MinimumSize = {read=FMinimumSize, write=SetMinimumSize, nodefault};
	__property Hint;
	__property bool LockHeight = {read=FLockHeight, write=SetLockHeight, nodefault};
	__property ParentShowHint = {default=1};
	__property TPersistence* Persistence = {read=FPersistence, write=SetPersistence};
	__property Menus::TPopupMenu* PopupMenu = {read=GetPopupMenuEx, write=SetPopupMenuEx};
	__property ShowHint;
	__property TCustomAdvToolBarStyler* ToolBarStyler = {read=FToolBarStyler, write=SetToolBarStyler};
	__property bool UseRunTimeHeight = {read=FUseRunTimeHeight, write=SetUseRunTimeHeight, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvDockPanel(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvCustomToolBarControl;
class DELPHICLASS TAdvQuickAccessToolBar;
class PASCALIMPLEMENTATION TAdvCustomToolBarControl : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	TAdvCustomToolBar* FAdvToolBar;
	TDockAlign FPosition;
	TAdvQuickAccessToolBar* FAdvQuickAccessToolBar;
	void __fastcall SetPosition(const TDockAlign Value);
	void __fastcall SetAdvQuickAccessToolBar(const TAdvQuickAccessToolBar* Value);
	
protected:
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall SetAdvToolBar(const TAdvCustomToolBar* Value);
	__property TDockAlign Position = {read=FPosition, write=SetPosition, nodefault};
	
public:
	__fastcall virtual TAdvCustomToolBarControl(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomToolBarControl(void);
	__property TAdvCustomToolBar* AdvToolBar = {read=FAdvToolBar, write=SetAdvToolBar};
	__property TAdvQuickAccessToolBar* AdvQuickAccessToolBar = {read=FAdvQuickAccessToolBar, write=SetAdvQuickAccessToolBar};
};


#pragma option push -b-
enum TAdvToolButtonStyle { tasButton, tasCheck };
#pragma option pop

#pragma option push -b-
enum TAdvButtonState { absUp, absDisabled, absDown, absDropDown, absExclusive };
#pragma option pop

class DELPHICLASS TAdvToolBarButtonActionLink;
class DELPHICLASS TAdvCustomToolBarButton;
class PASCALIMPLEMENTATION TAdvToolBarButtonActionLink : public Controls::TControlActionLink
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	TAdvCustomToolBarButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetChecked(bool Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TAdvToolBarButtonActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TAdvToolBarButtonActionLink(void) { }
	
};


class DELPHICLASS TAdvToolBarButtonDrawPosition;
class PASCALIMPLEMENTATION TAdvToolBarButtonDrawPosition : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEnabled;
	int FTextX;
	int FTextY;
	int FImageX;
	int FImageY;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetImageX(const int Value);
	void __fastcall SetImageY(const int Value);
	void __fastcall SetTextX(const int Value);
	void __fastcall SetTextY(const int Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TAdvToolBarButtonDrawPosition(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property int TextX = {read=FTextX, write=SetTextX, default=0};
	__property int TextY = {read=FTextY, write=SetTextY, default=0};
	__property int ImageX = {read=FImageX, write=SetImageX, default=0};
	__property int ImageY = {read=FImageY, write=SetImageY, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAdvToolBarButtonDrawPosition(void) { }
	
};


class PASCALIMPLEMENTATION TAdvCustomToolBarButton : public TAdvCustomToolBarControl
{
	typedef TAdvCustomToolBarControl inherited;
	
private:
	int FGroupIndex;
	Graphics::TBitmap* FGlyph;
	bool FDown;
	bool FAllowAllUp;
	int FSpacing;
	bool FTransparent;
	int FOffSet;
	bool FFlat;
	bool FMouseInControl;
	bool FHot;
	bool FMenuSel;
	Graphics::TBitmap* FGlyphDisabled;
	Graphics::TBitmap* FGlyphHot;
	Graphics::TBitmap* FGlyphDown;
	Graphics::TBitmap* FGlyphChecked;
	Graphics::TBitmap* FGlyphShade;
	bool FShaded;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	TAdvToolButtonStyle FStyle;
	bool FDropDownButton;
	bool FAutoThemeAdapt;
	Classes::TNotifyEvent FOnDropDown;
	Advmenus::TAdvPopupMenu* FDropDownMenu;
	bool FRounded;
	bool FParentStyler;
	TAdvButtonState FState;
	TGlyphPosition FGlyphPosition;
	bool FMouseDownInControl;
	int FDropDownSectWidth;
	bool FGrouped;
	Menus::TMenuItem* FMenuItem;
	int FImageIndex;
	bool FShadedForGlyph;
	bool FDragging;
	TButtonAppearance* FAppearance;
	bool FShowCaption;
	bool FPropHot;
	Graphics::TPicture* FPicture;
	Graphics::TPicture* FPictureDisabled;
	Extctrls::TTimer* FUnHotTimer;
	TAdvToolBarButtonDrawPosition* FDrawPosition;
	bool FInitialDown;
	int FInternalTag;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	bool FDropDownSplit;
	bool FForceImageIndex;
	bool FInternalClick;
	bool FMenuBeingClosed;
	bool FMenuDisplayed;
	bool FCanRotate;
	void __fastcall UnHotTimerOnTime(System::TObject* Sender);
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall UpdateExclusive(void);
	void __fastcall SetSpacing(int Value);
	void __fastcall UpdateTracking(void);
	void __fastcall PopupBtnDown(void);
	void __fastcall ButtonDown(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Message);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	void __fastcall SetGlyphDisabled(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphDown(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphHot(const Graphics::TBitmap* Value);
	void __fastcall GenerateShade(void);
	void __fastcall SetShaded(const bool Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetDown(bool Value);
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetStyle(const TAdvToolButtonStyle Value);
	void __fastcall SetDropDownButton(const bool Value);
	void __fastcall SetGlyphPosition(const TGlyphPosition Value);
	void __fastcall SetParentStyler(const bool Value);
	void __fastcall SetState(const TAdvButtonState Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetGlyphChecked(const Graphics::TBitmap* Value);
	int __fastcall GetIndex(void);
	void __fastcall SetGrouped(const bool Value);
	void __fastcall SetMenuItem(const Menus::TMenuItem* Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetAppearance(const TButtonAppearance* Value);
	void __fastcall SetShowCaption(const bool Value);
	bool __fastcall GetAutoSize(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	bool __fastcall GetHot(void);
	void __fastcall SetHot(const bool Value);
	void __fastcall SetPicture(const Graphics::TPicture* Value);
	void __fastcall SetPictureDisabled(const Graphics::TPicture* Value);
	void __fastcall SetDrawPosition(const TAdvToolBarButtonDrawPosition* Value);
	void __fastcall PositionChanged(System::TObject* Sender);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetForceImageIndex(const bool Value);
	void __fastcall SetCanRotate(const bool Value);
	
protected:
	bool FToolBarCreated;
	int FCommandID;
	bool FCustomizerCreated;
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	DYNAMIC Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DrawGlyphAndCaption(Graphics::TCanvas* ACanvas, const Types::TRect &R, Graphics::TColor TxtClr, Graphics::TBitmap* aGlyph);
	virtual void __fastcall DrawButton(Graphics::TCanvas* ACanvas);
	virtual void __fastcall Paint(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall SetAutoSize(bool Value);
	DYNAMIC void __fastcall AdjustSize(void);
	void __fastcall OnAppearanceChange(System::TObject* Sender);
	void __fastcall ThemeAdapt(void);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	int __fastcall VisibleMenuItemCount(void);
	void __fastcall InvalidateMe(void);
	void __fastcall OnDropDownHide(void);
	virtual bool __fastcall IsMenuButton(void);
	__property TAdvButtonState State = {read=FState, write=SetState, nodefault};
	__property bool ForceImageIndex = {read=FForceImageIndex, write=SetForceImageIndex, nodefault};
	__property Action;
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property Anchors = {default=3};
	__property bool AutoSize = {read=GetAutoSize, write=SetAutoSize, default=1};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, nodefault};
	__property BiDiMode;
	__property TButtonAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property TGlyphPosition GlyphPosition = {read=FGlyphPosition, write=SetGlyphPosition, default=0};
	__property Constraints;
	__property TAdvToolBarButtonDrawPosition* DrawPosition = {read=FDrawPosition, write=SetDrawPosition};
	__property bool Grouped = {read=FGrouped, write=SetGrouped, default=0};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool DropDownSplit = {read=FDropDownSplit, write=FDropDownSplit, default=1};
	__property bool DropDownButton = {read=FDropDownButton, write=SetDropDownButton, default=0};
	__property Advmenus::TAdvPopupMenu* DropDownMenu = {read=FDropDownMenu, write=FDropDownMenu};
	__property Caption;
	__property Enabled = {default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Font;
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property Graphics::TBitmap* GlyphHot = {read=FGlyphHot, write=SetGlyphHot};
	__property Graphics::TBitmap* GlyphDown = {read=FGlyphDown, write=SetGlyphDown};
	__property Graphics::TBitmap* GlyphDisabled = {read=FGlyphDisabled, write=SetGlyphDisabled};
	__property Graphics::TBitmap* GlyphChecked = {read=FGlyphChecked, write=SetGlyphChecked};
	__property bool Hot = {read=GetHot, write=SetHot, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Menus::TMenuItem* MenuItem = {read=FMenuItem, write=SetMenuItem};
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property Graphics::TPicture* PictureDisabled = {read=FPictureDisabled, write=SetPictureDisabled};
	__property bool CanRotate = {read=FCanRotate, write=SetCanRotate, default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property bool ParentStyler = {read=FParentStyler, write=SetParentStyler, default=1};
	__property bool Rounded = {read=FRounded, write=SetRounded, default=0};
	__property bool Shaded = {read=FShaded, write=SetShaded, default=1};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=0};
	__property ShowHint;
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property TAdvToolButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	
public:
	__fastcall virtual TAdvCustomToolBarButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomToolBarButton(void);
	DYNAMIC void __fastcall Click(void);
	void __fastcall DoDropDown(void);
	DYNAMIC bool __fastcall CheckMenuDropdown(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property int Index = {read=GetIndex, nodefault};
	virtual int __fastcall GetVersionNr(void);
};


class DELPHICLASS TAdvToolBarButton;
class PASCALIMPLEMENTATION TAdvToolBarButton : public TAdvCustomToolBarButton
{
	typedef TAdvCustomToolBarButton inherited;
	
__published:
	__property Action;
	__property AllowAllUp = {default=0};
	__property AutoSize = {default=1};
	__property Appearance;
	__property CanRotate = {default=1};
	__property GlyphPosition = {default=0};
	__property Constraints;
	__property GroupIndex = {default=0};
	__property Down = {default=0};
	__property DropDownButton = {default=0};
	__property DropDownMenu;
	__property DropDownSplit = {default=1};
	__property Caption;
	__property Enabled = {default=1};
	__property DrawPosition;
	__property Font;
	__property Glyph;
	__property GlyphHot;
	__property GlyphDown;
	__property GlyphDisabled;
	__property GlyphChecked;
	__property ImageIndex = {default=-1};
	__property Picture;
	__property PictureDisabled;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property ParentStyler = {default=1};
	__property Position;
	__property Shaded = {default=1};
	__property ShowCaption = {default=0};
	__property ShowHint;
	__property OfficeHint;
	__property Style = {default=0};
	__property Version;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
public:
	/* TAdvCustomToolBarButton.Create */ inline __fastcall virtual TAdvToolBarButton(Classes::TComponent* AOwner) : TAdvCustomToolBarButton(AOwner) { }
	/* TAdvCustomToolBarButton.Destroy */ inline __fastcall virtual ~TAdvToolBarButton(void) { }
	
};


class DELPHICLASS TAdvToolBarMenuButton;
class PASCALIMPLEMENTATION TAdvToolBarMenuButton : public TAdvCustomToolBarButton
{
	typedef TAdvCustomToolBarButton inherited;
	
protected:
	virtual bool __fastcall IsMenuButton(void);
	virtual void __fastcall DrawButton(Graphics::TCanvas* aCanvas);
	
public:
	__fastcall virtual TAdvToolBarMenuButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvToolBarMenuButton(void);
	__property Hot = {default=0};
	
__published:
	__property Action;
	__property Appearance;
	__property CanRotate = {default=1};
	__property GlyphPosition = {default=0};
	__property Constraints;
	__property DropDownButton = {default=0};
	__property DropDownMenu;
	__property DropDownSplit = {default=1};
	__property Caption;
	__property Enabled = {default=1};
	__property Font;
	__property Glyph;
	__property GlyphHot;
	__property GlyphDown;
	__property GlyphDisabled;
	__property GlyphChecked;
	__property ImageIndex = {default=-1};
	__property Picture;
	__property ParentStyler = {default=1};
	__property Position;
	__property Shaded = {default=1};
	__property ShowHint;
	__property OfficeHint;
	__property ShowCaption = {default=0};
	__property Version;
	__property Visible = {default=1};
	__property OnClick;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
};


#pragma option push -b-
enum TAdvSeparatorStyle { ssOffice2003, ssBlank };
#pragma option pop

class DELPHICLASS TAdvToolBarSeparator;
class PASCALIMPLEMENTATION TAdvToolBarSeparator : public TAdvCustomToolBarControl
{
	typedef TAdvCustomToolBarControl inherited;
	
private:
	TAdvSeparatorStyle FSeparatorStyle;
	Graphics::TColor FLineColor;
	void __fastcall SetSeparatorStyle(const TAdvSeparatorStyle Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall AdjustSize(void);
	
public:
	__fastcall virtual TAdvToolBarSeparator(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvToolBarSeparator(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TAdvSeparatorStyle SeparatorStyle = {read=FSeparatorStyle, write=SetSeparatorStyle, default=0};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, nodefault};
};


#pragma option push -b-
enum TDBButtonType { dbtCustom, dbtFirst, dbtPrior, dbtNext, dbtLast, dbtInsert, dbtAppend, dbtDelete, dbtEdit, dbtPost, dbtCancel, dbtRefresh };
#pragma option pop

#pragma option push -b-
enum TDBBDisableControl { drBOF, drEOF, drReadonly, drNotEditing, drEditing, drEmpty, drEvent };
#pragma option pop

typedef Set<TDBBDisableControl, drBOF, drEvent>  TDBBDisableControls;

typedef void __fastcall (__closure *TBeforeActionEvent)(System::TObject* Sender, bool &DoAction);

typedef void __fastcall (__closure *TAfterActionEvent)(System::TObject* Sender, bool &ShowException);

typedef void __fastcall (__closure *TGetConfirmEvent)(System::TObject* Sender, System::UnicodeString &Question, Dialogs::TMsgDlgButtons &Buttons, int &HelpCtx);

typedef void __fastcall (__closure *TGetEnabledEvent)(System::TObject* Sender, bool &Enabled);

class DELPHICLASS TDBATBButtonDataLink;
class PASCALIMPLEMENTATION TDBATBButtonDataLink : public Db::TDataLink
{
	typedef Db::TDataLink inherited;
	
private:
	Classes::TNotifyEvent FOnEditingChanged;
	Classes::TNotifyEvent FOnDataSetChanged;
	Classes::TNotifyEvent FOnActiveChanged;
	
protected:
	virtual void __fastcall EditingChanged(void);
	virtual void __fastcall DataSetChanged(void);
	virtual void __fastcall ActiveChanged(void);
	
public:
	__fastcall TDBATBButtonDataLink(void);
	__property Classes::TNotifyEvent OnEditingChanged = {read=FOnEditingChanged, write=FOnEditingChanged};
	__property Classes::TNotifyEvent OnDataSetChanged = {read=FOnDataSetChanged, write=FOnDataSetChanged};
	__property Classes::TNotifyEvent OnActiveChanged = {read=FOnActiveChanged, write=FOnActiveChanged};
public:
	/* TDataLink.Destroy */ inline __fastcall virtual ~TDBATBButtonDataLink(void) { }
	
};


class DELPHICLASS TDBAdvToolBarButton;
class PASCALIMPLEMENTATION TDBAdvToolBarButton : public TAdvCustomToolBarButton
{
	typedef TAdvCustomToolBarButton inherited;
	
private:
	TDBATBButtonDataLink* FDataLink;
	bool FAutoDisable;
	TDBBDisableControls FDisableControls;
	TAfterActionEvent FOnAfterAction;
	TBeforeActionEvent FOnBeforeAction;
	TDBButtonType FDBButtonType;
	TGetConfirmEvent FOnGetConfirm;
	TGetEnabledEvent FOnGetEnabled;
	Classes::TNotifyEvent FOnEnabledChanged;
	bool FConfirmAction;
	System::UnicodeString FConfirmActionString;
	bool FInProcUpdateEnabled;
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	void __fastcall OnDataSetEvents(System::TObject* Sender);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataSource(const Db::TDataSource* Value);
	void __fastcall SetDBButtonType(const TDBButtonType Value);
	void __fastcall SetConfirmActionString(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Loaded(void);
	void __fastcall CalcDisableReasons(void);
	virtual void __fastcall DoBeforeAction(bool &DoAction);
	virtual void __fastcall DoGetQuestion(System::UnicodeString &Question, Dialogs::TMsgDlgButtons &Buttons, int &HelpCtx);
	virtual bool __fastcall DoConfirmAction(void);
	virtual void __fastcall DoAction(void);
	virtual void __fastcall UpdateEnabled(void);
	virtual void __fastcall LoadGlyph(void);
	
public:
	__fastcall virtual TDBAdvToolBarButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TDBAdvToolBarButton(void);
	DYNAMIC void __fastcall Click(void);
	
__published:
	__property Action;
	__property AutoSize = {default=1};
	__property Appearance;
	__property CanRotate = {default=1};
	__property GlyphPosition = {default=0};
	__property Constraints;
	__property bool AutoDisable = {read=FAutoDisable, write=FAutoDisable, nodefault};
	__property bool ConfirmAction = {read=FConfirmAction, write=FConfirmAction, nodefault};
	__property System::UnicodeString ConfirmActionString = {read=FConfirmActionString, write=SetConfirmActionString};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TDBButtonType DBButtonType = {read=FDBButtonType, write=SetDBButtonType, nodefault};
	__property TDBBDisableControls DisableControl = {read=FDisableControls, write=FDisableControls, nodefault};
	__property Caption;
	__property Enabled = {default=1};
	__property DrawPosition;
	__property Font;
	__property Glyph;
	__property GlyphHot;
	__property GlyphDown;
	__property GlyphDisabled;
	__property ImageIndex = {default=-1};
	__property Picture;
	__property PictureDisabled;
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property ParentStyler = {default=1};
	__property Position;
	__property Shaded = {default=1};
	__property ShowCaption = {default=0};
	__property ShowHint;
	__property OfficeHint;
	__property Version;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property TBeforeActionEvent OnBeforeAction = {read=FOnBeforeAction, write=FOnBeforeAction};
	__property TAfterActionEvent OnAfterAction = {read=FOnAfterAction, write=FOnAfterAction};
	__property TGetConfirmEvent OnGetConfirm = {read=FOnGetConfirm, write=FOnGetConfirm};
	__property TGetEnabledEvent OnGetEnabled = {read=FOnGetEnabled, write=FOnGetEnabled};
	__property Classes::TNotifyEvent OnEnabledChanged = {read=FOnEnabledChanged, write=FOnEnabledChanged};
};


typedef void __fastcall (__closure *TDockedEvent)(System::TObject* Sender, TAdvDockPanel* AdvDockPanel);

typedef void __fastcall (__closure *TOptionEvent)(System::TObject* Sender, const Types::TPoint &ClientPoint, const Types::TPoint &ScreenPoint);

typedef void __fastcall (__closure *TCanFloatEvent)(System::TObject* Sender, bool &Allow);

class DELPHICLASS TFloatingWindow;
class DELPHICLASS TOptionSelectorWindow;
class DELPHICLASS TControlSelectorPanel;
class DELPHICLASS TAdvToolBarCustomizer;
class DELPHICLASS TCompactWindow;
class PASCALIMPLEMENTATION TAdvCustomToolBar : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Advgdip::TAntiAlias FAntiAlias;
	TDbgList* FATBControls;
	TDbgList* FRUControls;
	TDbgList* FLUHidedControls;
	TCustomAdvToolBarStyler* FInternalToolBarStyler;
	TCustomAdvToolBarStyler* FToolBarStyler;
	TCustomAdvToolBarStyler* FCurrentToolBarStyler;
	bool FParentStyler;
	int FDragGripWidth;
	int FPopupIndicatorWidth;
	TAdvDockPanel* FCurrentDock;
	TAdvDockPanel* FLastDock;
	TDockAlign FPosition;
	Controls::TCursor FOldCursor;
	bool FDraging;
	int FOldMouseX;
	int FOldMouseY;
	bool FHotPopupIndicator;
	bool FDownPopupIndicator;
	int FRow;
	TToolBarState FToolBarState;
	bool FAllowBoundChange;
	bool FFullSize;
	TDockableTo FDockableTo;
	TDbgList* FDockList;
	TFloatingWindow* FFloatingWindow;
	Classes::TComponent* FOwner;
	System::UnicodeString FCaption;
	System::WideString FWideCaption;
	Graphics::TFont* FCaptionFont;
	bool FShowOptionIndicator;
	bool FShowPopupIndicator;
	bool FShowClose;
	int FCaptionHeight;
	bool FHotCustomizedBtn;
	bool FDownCustomizedBtn;
	bool FHotCloseBtn;
	bool FDownCloseBtn;
	Imglist::TCustomImageList* FImages;
	Menus::TMainMenu* FMenu;
	Menus::TMainMenu* FMergedMenu;
	int FTimerID;
	Advmenus::TAdvPopupMenu* FTempMenu;
	bool FInMenuLoop;
	bool FMenuResult;
	bool FCaptureChangeCancels;
	bool FMenuDropped;
	TAdvCustomToolBarButton* FMenuButton;
	TAdvCustomToolBarButton* FLastMenuButton;
	Menus::TMenuItem* FButtonMenu;
	bool FInternalControlPositioning;
	bool FAutoRUL;
	int FFloatingRows;
	int FSizeAtDock;
	int FMinLength;
	int FMaxLength;
	TToolBarState FOldState;
	bool FShowRightHandle;
	Classes::TNotifyEvent FOnClose;
	TOptionEvent FOnOptionClick;
	TDockedEvent FOnDocked;
	Classes::TNotifyEvent FOnUnDocked;
	TPersistence* FPersistence;
	bool FPersistSettingLoaded;
	Imglist::TCustomImageList* FMenuImages;
	int FTempMenuItemCount;
	TAdvCustomToolBarButton* FHotButton;
	bool FMenuFocused;
	Menus::TPopupMenu* FOptionMenu;
	bool FAllowFloating;
	bool FLocked;
	TOptionSelectorWindow* FOptionWindow;
	TControlSelectorPanel* FOptionWindowPanel;
	bool FInternalControlUpdation;
	bool FAutoOptionMenu;
	System::UnicodeString FHintOptionButton;
	System::UnicodeString FHintCloseButton;
	System::UnicodeString FTextAutoOptionMenu;
	System::UnicodeString FTextOptionMenu;
	bool FAutoArrangeButtons;
	Forms::TCustomForm* FParentForm;
	bool FAutoHiding;
	Imglist::TCustomImageList* FDisabledImages;
	bool FAutoMDIButtons;
	bool FMDIButtonsVisible;
	bool FMDIDownCloseBtn;
	bool FMDIHotCloseBtn;
	bool FMDIDownMaxBtn;
	bool FMDIHotMaxBtn;
	bool FMDIDownMinBtn;
	bool FMDIHotMinBtn;
	Forms::TCustomForm* FMDIChildForm;
	Extctrls::TTimer* FMenuItemTimer;
	TAdvCustomToolBarButton* FNextMenuHotButton;
	bool FUpdatingControls;
	TAdvToolBarCustomizer* FCustomizer;
	bool FAutoDockOnClose;
	bool FShowCaption;
	TCaptionPosition FCaptionPosition;
	Classes::TAlignment FCaptionAlignment;
	Classes::TStringList* FMDIChildMenuSL;
	Classes::TList* FMDIChildMenuList;
	Extctrls::TTimer* FTimer;
	bool FHot;
	int FTimeInc;
	int FStepHover;
	Advglowbutton::TGlowState FGlowState;
	bool FAutoSize;
	bool FCapOptIndicatorHot;
	bool FCapOptIndicatorDown;
	Gdipicture::TGDIPPicture* FIOptionDisabledPicture;
	Gdipicture::TGDIPPicture* FIOptionPicture;
	bool FAutoPositionControls;
	Extctrls::TTimer* FOptionTimer;
	int FOptionStepHover;
	int FOptionStepPush;
	int FOptionTimeInc;
	Advglowbutton::TGlowState FOptionGlowState;
	System::UnicodeString FCompactCaption;
	Gdipicture::TGDIPPicture* FICompactPicture;
	bool FCompact;
	bool FCompactMode;
	TAdvCustomToolBar* FSelfClone;
	TCompactWindow* FCompactWindow;
	int FCompactMinWidth;
	Advglowbutton::TAdvGlowButton* FCompactBtn;
	bool FOldAutoPosition;
	bool FOldAutoArrangeButtons;
	bool FOldAutoSize;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	bool FActive;
	bool FPropertiesLoaded;
	bool FParentOptionPicture;
	int FCompactImageIndex;
	int FUpdateCount;
	TDbgList* FSeqControlList;
	bool FCompactSmallest;
	System::WideString FWideCompactCaption;
	TDockMode FDockMode;
	Forms::TCloseQueryEvent FOnCompactCloseQuery;
	bool FDoCheckBoundChange;
	System::UnicodeString FCompactShortCutHint;
	bool FCompactShortCutHintShowing;
	StaticArray<int, 3> FButtonRows;
	bool FCompactChanging;
	bool FHideOnEmpty;
	TCanFloatEvent FOnCanFloat;
	bool FFirstRun;
	void __fastcall TimerProc(System::TObject* Sender);
	void __fastcall OptionTimerProc(System::TObject* Sender);
	void __fastcall InvalidateCapOptionBtn(void);
	void __fastcall InvalidateCaption(void);
	void __fastcall MenuItemTimerOnTime(System::TObject* Sender);
	void __fastcall InitializeOptionWindow(void);
	void __fastcall ShowOptionWindow(int X, int Y, bool ForcePoint = true);
	void __fastcall HideOptionWindow(void);
	void __fastcall OnOptionWindowHide(System::TObject* Sender);
	void __fastcall DrawDragGrip(void);
	void __fastcall DrawPopupIndicator(void);
	void __fastcall DrawCustomizedBtn(void);
	void __fastcall DrawCloseBtn(void);
	void __fastcall DrawMDIButtons(void);
	Types::TRect __fastcall GetMDIMinBtnRect(void);
	Types::TRect __fastcall GetMDIMaxBtnRect(void);
	Types::TRect __fastcall GetMDICloseBtnRect(void);
	bool __fastcall PtOnMDIMin(const Types::TPoint &P);
	bool __fastcall PtOnMDIMax(const Types::TPoint &P);
	bool __fastcall PtOnMDIClose(const Types::TPoint &P);
	Types::TRect __fastcall GetOptionIndicatorRect(void);
	void __fastcall MDICloseBtnClick(void);
	void __fastcall MDIMaxBtnClick(void);
	void __fastcall MDIMinBtnClick(void);
	bool __fastcall PtOnDragGrip(const Types::TPoint &P);
	bool __fastcall PtOnPopupIndicator(const Types::TPoint &P);
	bool __fastcall PtOnGripCaption(const Types::TPoint &P);
	bool __fastcall PtOnCustomizedBtn(const Types::TPoint &P);
	bool __fastcall PtOnCloseBtn(const Types::TPoint &P);
	Types::TRect __fastcall GetMyClientRect(void);
	Types::TRect __fastcall GetCaptionRect(void);
	Types::TRect __fastcall FWCustomizedBtnRect(void);
	Types::TRect __fastcall FWCloseBtnRect(void);
	void __fastcall CloseBtnClick(void);
	void __fastcall OptionIndicatorClick(void);
	void __fastcall CapOptionIndicatorClick(void);
	void __fastcall UpdateSize(void);
	int __fastcall GetMenuItemCount(void);
	void __fastcall OnMainMenuChange(System::TObject* Sender, Menus::TMenuItem* Source, bool Rebuild);
	void __fastcall OnMDIChildMenuClick(System::TObject* Sender);
	void __fastcall BuildSequenceControlList(void);
	void __fastcall GetSequenceControlList(TDbgList* aList, bool CheckVisibility = true);
	MESSAGE void __fastcall CNDropDownClosed(Messages::TMessage &Message);
	void __fastcall OnOptionPictureChanged(System::TObject* Sender);
	void __fastcall OnCompactPictureChanged(System::TObject* Sender);
	void __fastcall OnCompactBtnDropDown(System::TObject* Sender);
	void __fastcall OnGlowButtonKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall OnGlowButtonClick(System::TObject* Sender);
	void __fastcall OnSetGlowButtonSize(System::TObject* Sender, int &W, int &H);
	void __fastcall OnGetGlowButtonShortCutHintPos(System::TObject* Sender, Advglowbutton::TButtonSizeState ButtonSizeState, Advglowbutton::TShortCutHintPos &ShortCutHintPosition);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall WMTimer(Messages::TWMTimer &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMCaptureChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CNSysKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMSysCommand(Messages::TWMSysCommand &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TMessage &Message);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Controls::TCMControlListChange &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Controls::TCMHintShow &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	void __fastcall SetToolBarStyler(const TCustomAdvToolBarStyler* Value);
	void __fastcall SetParentStyler(const bool Value);
	void __fastcall SetDragGripWidth(const int Value);
	void __fastcall SetPopupIndicatorWidth(const int Value);
	void __fastcall SetPosition(const TDockAlign Value);
	void __fastcall SetRow(const int Value);
	void __fastcall SetAllowBoundChange(const bool Value);
	void __fastcall SetFullSize(const bool Value);
	void __fastcall SetDockableTo(const TDockableTo Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetWideCaption(const System::WideString Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetShowOptionIndicator(const bool Value);
	void __fastcall SetShowPopupIndicator(const bool Value);
	void __fastcall SetShowClose(const bool Value);
	void __fastcall SetCaptionHeight(const int Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetMenu(const Menus::TMainMenu* Value);
	void __fastcall SetAutoRUL(const bool Value);
	void __fastcall SetFloatingRows(const int Value);
	void __fastcall SetShowRightHandle(const bool Value);
	void __fastcall SetPersistence(const TPersistence* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetAllowFloating(const bool Value);
	void __fastcall SetLocked(const bool Value);
	void __fastcall SetAutoOptionMenu(const bool Value);
	void __fastcall SetAutoArrangeButtons(const bool Value);
	void __fastcall SetDisabledImages(const Imglist::TCustomImageList* Value);
	int __fastcall GetToolBarControlCount(void);
	Controls::TControl* __fastcall GetToolBarControls(int index);
	void __fastcall AddMergedMenuItems(void);
	void __fastcall DeleteMergedMenuItems(void);
	void __fastcall SetAutoMDIButtons(const bool Value);
	void __fastcall SetMDIButtonsVisible(const bool Value);
	void __fastcall SetCustomizer(const TAdvToolBarCustomizer* Value);
	void __fastcall SetAutoDockOnClose(const bool Value);
	void __fastcall SetCaptionPosition(const TCaptionPosition Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetCaptionAlignment(const Classes::TAlignment Value);
	void __fastcall SetAutoSizeEx(const bool Value);
	void __fastcall SetOptionDisabledPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetOptionPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetAutoPositionControls(const bool Value);
	void __fastcall SetCompactCaption(const System::UnicodeString Value);
	void __fastcall SetCompactPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetCompactMode(const bool Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetAntiAlias(const Advgdip::TAntiAlias Value);
	void __fastcall SetParentOptionPicture(const bool Value);
	void __fastcall SetCompactImageIndex(const int Value);
	int __fastcall GetToolBarIndex(void);
	void __fastcall SetToolBarIndex(const int Value);
	TAdvDockPanel* __fastcall GetAdvDockPanel(void);
	void __fastcall SetAdvDockPanel(const TAdvDockPanel* Value);
	void __fastcall UpdateCompactButton(void);
	void __fastcall UpdateButtonRowCount(void);
	void __fastcall SetHideOnEmpty(const bool Value);
	void __fastcall SetOnCompactCloseQuery(const Forms::TCloseQueryEvent Value);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdateMe(int PropID);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	virtual Types::TRect __fastcall GetClientRect(void);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	void __fastcall SetControlsPosition(bool UpdateMySize = true);
	int __fastcall AddAdvToolBarControl(TAdvCustomToolBarControl* aControl);
	void __fastcall InsertAdvToolBarControl(TAdvCustomToolBarControl* aControl, int Index);
	void __fastcall RemoveAdvToolBarControl(TAdvCustomToolBarControl* aControl);
	TAdvCustomToolBarButton* __fastcall ButtonAtPos(int X, int Y);
	int __fastcall GetMaxLength(void);
	void __fastcall AdjustSizeOfAllButtons(bool MenuButtonsOnly = false);
	int __fastcall GetSizeAtDock(bool ForFloating);
	void __fastcall GetMaxControlSize(int &W, int &H);
	void __fastcall GetMaxExternalControlSize(int &W, int &H);
	void __fastcall GetMaxToolBarButtonSize(int &W, int &H);
	void __fastcall UpdateAllGlowButtons(void);
	void __fastcall UpdateAllContainer(void);
	void __fastcall InvalidateTransparentControls(void);
	bool __fastcall CanUnCompact(void);
	void __fastcall SetCompact(const bool Value);
	void __fastcall HideCompactWindow(void);
	void __fastcall CheckAndOpenOtherCompactToolBar(void);
	bool __fastcall AnyDroppedDownButton(void);
	void __fastcall ShowShortCutHintOfButtons(void);
	void __fastcall HideShortCutHintOfButtons(void);
	bool __fastcall HasShortCut(System::UnicodeString aShortCut, int &VisibleHintCount);
	void __fastcall ReturnFocus(void);
	Controls::TWinControl* __fastcall GetControlFromHandle(HWND H);
	Controls::TWinControl* __fastcall GetFirstTabControl(bool CheckCanFocus);
	Controls::TWinControl* __fastcall GetLastTabControl(bool CheckCanFocus);
	HIDESBASE void __fastcall InsertControl(Controls::TControl* Control);
	HIDESBASE void __fastcall RemoveControl(Controls::TControl* Control);
	int __fastcall ControlIndex(int OldIndex, int ALeft, int ATop);
	int __fastcall ReorderControl(int OldIndex, int ALeft, int ATop);
	void __fastcall AdjustControl(Controls::TControl* Control);
	DYNAMIC bool __fastcall CheckMenuDropdown(TAdvCustomToolBarButton* Button);
	DYNAMIC void __fastcall CancelMenu(void);
	void __fastcall ClearTempMenu(void);
	DYNAMIC void __fastcall ClickButton(TAdvCustomToolBarButton* Button, bool RealClick = false);
	TAdvCustomToolBarButton* __fastcall FindButtonFromAccel(System::Word Accel);
	DYNAMIC bool __fastcall TrackMenu(TAdvCustomToolBarButton* Button);
	DYNAMIC void __fastcall InitMenu(TAdvCustomToolBarButton* Button);
	void __fastcall UpdateButtonHot(TAdvCustomToolBarButton* Button);
	bool __fastcall SetButtonHot(TAdvCustomToolBarButton* Button)/* overload */;
	bool __fastcall SetButtonHot(int ButtonNumber)/* overload */;
	void __fastcall UpControlInRUL(Controls::TControl* aControl);
	void __fastcall UpdateRULists(void);
	void __fastcall UnHideAllControls(void);
	void __fastcall CheckAndUpdateRUList(void);
	bool __fastcall GetFloatingWindowSizes(int aRows, int &aHeight, int &aWidth);
	void __fastcall GetFloatingSizes(int &aHeight, int &aWidth);
	int __fastcall GetMaxFloatingRowCount(void);
	__property int FloatingRows = {read=FFloatingRows, write=SetFloatingRows, default=1};
	bool __fastcall AcceptableDockPanel(TAdvDockPanel* ADockPanel);
	void __fastcall BeginMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall Move(Classes::TShiftState Shift, int X, int Y);
	void __fastcall EndMove(void);
	void __fastcall SetFloating(int X = 0x0, int Y = 0x0, bool ForcePoint = false);
	int __fastcall CanShrink(void);
	int __fastcall CanExpand(void);
	__property TAdvToolBarCustomizer* Customizer = {read=FCustomizer, write=SetCustomizer};
	__property bool AllowBoundChange = {read=FAllowBoundChange, write=SetAllowBoundChange, default=0};
	__property int DragGripWidth = {read=FDragGripWidth, write=SetDragGripWidth, default=7};
	__property int PopupIndicatorWidth = {read=FPopupIndicatorWidth, write=SetPopupIndicatorWidth, default=14};
	__property int Row = {read=FRow, write=SetRow, default=-1};
	__property TToolBarState ToolBarState = {read=FToolBarState, nodefault};
	void __fastcall OnCompactWindowHide(System::TObject* Sender);
	int __fastcall GetCompactWidth(void);
	int __fastcall GetInCompactWidth(void);
	void __fastcall UpdateCompactWindow(bool UpdateSize = false);
	__property bool Compact = {read=FCompact, write=SetCompactMode, nodefault};
	__property bool IsCompact = {read=FCompact, nodefault};
	bool __fastcall IsSmallestVariant(void);
	int __fastcall SetSmallerVariant(bool CanCompact, Advglowbutton::TButtonSizeState &NewState, bool RealSet = true);
	int __fastcall SmallerVariantDifference(bool CanCompact, Advglowbutton::TButtonSizeState &NewState);
	void __fastcall SetSmallestVaraint(void);
	int __fastcall SetLargerVariant(bool CanCompact, Advglowbutton::TButtonSizeState &NewState, bool RealSet = true);
	int __fastcall LargerVariantDifference(bool CanCompact, Advglowbutton::TButtonSizeState &NewState);
	void __fastcall SetLargestVaraint(void);
	__property TPersistence* Persistence = {read=FPersistence, write=SetPersistence};
	__property bool AutoRUL = {read=FAutoRUL, write=SetAutoRUL, default=1};
	__property bool Locked = {read=FLocked, write=SetLocked, default=0};
	__property bool AllowFloating = {read=FAllowFloating, write=SetAllowFloating, nodefault};
	__property bool AutoOptionMenu = {read=FAutoOptionMenu, write=SetAutoOptionMenu, default=0};
	__property bool AutoArrangeButtons = {read=FAutoArrangeButtons, write=SetAutoArrangeButtons, default=1};
	__property bool AutoMDIButtons = {read=FAutoMDIButtons, write=SetAutoMDIButtons, default=0};
	Forms::TCustomForm* __fastcall GetMyParentForm(void);
	__property bool MDIButtonsVisible = {read=FMDIButtonsVisible, write=SetMDIButtonsVisible, nodefault};
	__property Advgdip::TAntiAlias AntiAlias = {read=FAntiAlias, write=SetAntiAlias, default=1};
	__property bool AutoDockOnClose = {read=FAutoDockOnClose, write=SetAutoDockOnClose, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property int CaptionHeight = {read=FCaptionHeight, write=SetCaptionHeight, default=16};
	__property System::UnicodeString HintOptionButton = {read=FHintOptionButton, write=FHintOptionButton};
	__property System::UnicodeString HintCloseButton = {read=FHintCloseButton, write=FHintCloseButton};
	__property Menus::TPopupMenu* OptionMenu = {read=FOptionMenu, write=FOptionMenu};
	__property bool ShowPopupIndicator = {read=FShowPopupIndicator, write=SetShowPopupIndicator, default=1};
	__property bool ShowClose = {read=FShowClose, write=SetShowClose, default=1};
	__property bool ShowOptionIndicator = {read=FShowOptionIndicator, write=SetShowOptionIndicator, default=1};
	__property bool ShowRightHandle = {read=FShowRightHandle, write=SetShowRightHandle, default=1};
	__property TDockableTo DockableTo = {read=FDockableTo, write=SetDockableTo, default=15};
	__property TDockMode DockMode = {read=FDockMode, write=FDockMode, default=0};
	__property bool FullSize = {read=FFullSize, write=SetFullSize, default=0};
	__property bool ParentStyler = {read=FParentStyler, write=SetParentStyler, default=1};
	__property TCustomAdvToolBarStyler* ToolBarStyler = {read=FToolBarStyler, write=SetToolBarStyler, default=0};
	__property TDockAlign Position = {read=FPosition, write=SetPosition, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Menus::TMainMenu* Menu = {read=FMenu, write=SetMenu};
	__property System::UnicodeString TextAutoOptionMenu = {read=FTextAutoOptionMenu, write=FTextAutoOptionMenu};
	__property System::UnicodeString TextOptionMenu = {read=FTextOptionMenu, write=FTextOptionMenu};
	__property TCaptionPosition CaptionPosition = {read=FCaptionPosition, write=SetCaptionPosition, default=0};
	__property Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=0};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeEx, default=1};
	__property bool AutoPositionControls = {read=FAutoPositionControls, write=SetAutoPositionControls, default=1};
	__property Gdipicture::TGDIPPicture* OptionDisabledPicture = {read=FIOptionDisabledPicture, write=SetOptionDisabledPicture};
	__property Gdipicture::TGDIPPicture* OptionPicture = {read=FIOptionPicture, write=SetOptionPicture};
	__property Gdipicture::TGDIPPicture* CompactPicture = {read=FICompactPicture, write=SetCompactPicture};
	__property System::UnicodeString CompactCaption = {read=FCompactCaption, write=SetCompactCaption};
	__property System::WideString WideCompactCaption = {read=FWideCompactCaption, write=FWideCompactCaption};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property bool ParentOptionPicture = {read=FParentOptionPicture, write=SetParentOptionPicture, nodefault};
	__property int CompactImageIndex = {read=FCompactImageIndex, write=SetCompactImageIndex, nodefault};
	__property System::UnicodeString CompactShortCutHint = {read=FCompactShortCutHint, write=FCompactShortCutHint};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property Forms::TCloseQueryEvent OnCompactCloseQuery = {read=FOnCompactCloseQuery, write=SetOnCompactCloseQuery};
	__property TOptionEvent OnOptionClick = {read=FOnOptionClick, write=FOnOptionClick};
	__property TDockedEvent OnDocked = {read=FOnDocked, write=FOnDocked};
	__property Classes::TNotifyEvent OnUnDocked = {read=FOnUnDocked, write=FOnUnDocked};
	__property TCanFloatEvent OnCanFloat = {read=FOnCanFloat, write=FOnCanFloat};
	__property int ToolBarIndex = {read=GetToolBarIndex, write=SetToolBarIndex, nodefault};
	void __fastcall ResetToolBar(void);
	__property bool HideOnEmpty = {read=FHideOnEmpty, write=SetHideOnEmpty, default=0};
	
public:
	__fastcall virtual TAdvCustomToolBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomToolBar(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	HIDESBASE void __fastcall Dock(TAdvDockPanel* NewDockSite);
	virtual void __fastcall Update(void);
	void __fastcall UpdateControlsVisibility(void);
	DYNAMIC bool __fastcall IsShortCut(Messages::TWMKey &Message, bool ConsiderButtons = false);
	__property TAdvDockPanel* AdvDockPanel = {read=GetAdvDockPanel, write=SetAdvDockPanel};
	void __fastcall SetToolBarFloating(const Types::TPoint &P);
	__property Advmenus::TAdvPopupMenu* ActiveMenu = {read=FTempMenu};
	void __fastcall UpdateMenu(void);
	void __fastcall MergeMenu(Menus::TMainMenu* AMenu);
	void __fastcall UnmergeMenu(Menus::TMainMenu* AMenu);
	__property ShowHint = {default=1};
	int __fastcall GetVersionNr(void);
	void __fastcall MoveToolBarControl(int FromIndex, int ToIndex);
	void __fastcall InsertToolBarControl(int Index, Controls::TControl* AControl);
	int __fastcall AddToolBarControl(Controls::TControl* AControl);
	int __fastcall IndexOfToolBarControl(Controls::TControl* AControl);
	__property Controls::TControl* ToolBarControls[int index] = {read=GetToolBarControls};
	__property int ToolBarControlCount = {read=GetToolBarControlCount, nodefault};
	void __fastcall ShowCustomizer(void);
	void __fastcall AddMDIChildMenu(Forms::TCustomForm* ChildForm, System::UnicodeString Caption = L"");
	void __fastcall RemoveMDIChildMenu(Forms::TCustomForm* ChildForm, System::UnicodeString Caption = L"");
	void __fastcall RemoveAllMDIChildMenu(void);
	TToolBarState __fastcall GetToolBarState(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall UpdateImagesShade(void);
	Types::TPoint __fastcall GetPosition(void);
	void __fastcall SavePosition(void);
	void __fastcall LoadPosition(void);
	void __fastcall MoveUpInRUList(Controls::TControl* aControl);
	__property System::WideString WideCaption = {read=FWideCaption, write=SetWideCaption};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomToolBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvToolBar;
class PASCALIMPLEMENTATION TAdvToolBar : public TAdvCustomToolBar
{
	typedef TAdvCustomToolBar inherited;
	
public:
	__property Compact;
	__property IsCompact;
	__property WideCompactCaption;
	__property OnCompactCloseQuery;
	__property HideOnEmpty = {default=0};
	
__published:
	__property AllowFloating;
	__property AntiAlias = {default=1};
	__property AutoArrangeButtons = {default=1};
	__property AutoDockOnClose = {default=0};
	__property AutoMDIButtons = {default=0};
	__property AutoOptionMenu = {default=0};
	__property AutoPositionControls = {default=1};
	__property AutoSize = {default=1};
	__property Locked = {default=0};
	__property Caption;
	__property CaptionFont;
	__property CaptionHeight = {default=16};
	__property CaptionPosition = {default=0};
	__property CaptionAlignment = {default=0};
	__property CompactCaption;
	__property CompactPicture;
	__property CompactImageIndex;
	__property CompactShortCutHint;
	__property ShowCaption = {default=0};
	__property HintOptionButton;
	__property HintCloseButton;
	__property ShowRightHandle = {default=1};
	__property ShowClose = {default=1};
	__property ShowOptionIndicator = {default=1};
	__property DockableTo = {default=15};
	__property DockMode = {default=0};
	__property Enabled = {default=1};
	__property FullSize = {default=0};
	__property TextAutoOptionMenu;
	__property TextOptionMenu;
	__property ParentStyler = {default=1};
	__property ToolBarStyler = {default=0};
	__property Images;
	__property DisabledImages;
	__property Menu;
	__property OptionMenu;
	__property OptionDisabledPicture;
	__property OptionPicture;
	__property ParentOptionPicture;
	__property ParentShowHint = {default=0};
	__property ShowHint = {default=1};
	__property ToolBarIndex;
	__property OfficeHint;
	__property Version;
	__property OnClose;
	__property OnOptionClick;
	__property OnCanFloat;
	__property OnDocked;
	__property OnUnDocked;
	__property OnDragOver;
	__property OnDragDrop;
	__property OnEndDrag;
	__property OnStartDrag;
	__property OnEnter;
	__property OnExit;
	__property OnDblClick;
	__property OnKeyPress;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnResize;
public:
	/* TAdvCustomToolBar.Create */ inline __fastcall virtual TAdvToolBar(Classes::TComponent* AOwner) : TAdvCustomToolBar(AOwner) { }
	/* TAdvCustomToolBar.Destroy */ inline __fastcall virtual ~TAdvToolBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvToolBar(HWND ParentWindow) : TAdvCustomToolBar(ParentWindow) { }
	
};


#pragma option push -b-
enum TResizingClip { rcLeft, rcTop, rcRight, rcBottom };
#pragma option pop

class PASCALIMPLEMENTATION TFloatingWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	TAdvCustomToolBar* FAdvCustomToolBar;
	Classes::TComponent* FOwner;
	int FBorderWidth;
	Graphics::TColor FBorderColor;
	Controls::TCursor FOldCursor;
	bool FResizing;
	int FMouseX;
	int FMouseY;
	int FResizingDir;
	TResizingClip FResizingClip;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TFloatingWindow(Classes::TComponent* AOwner);
	__fastcall virtual TFloatingWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TFloatingWindow(void);
	void __fastcall SetWindowSize(void);
	
__published:
	__property TAdvCustomToolBar* AdvCustomToolBar = {read=FAdvCustomToolBar, write=FAdvCustomToolBar};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=2};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
public:
	/* TWinControl.CreateParented */ inline __fastcall TFloatingWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class DELPHICLASS TOptionSelectorPanel;
class PASCALIMPLEMENTATION TOptionSelectorWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	TAdvCustomToolBar* FAdvToolBar;
	TOptionSelectorPanel* FOptionsPanel;
	bool FHideOnDeActivate;
	bool FShowAbove;
	Classes::TComponent* FOwner;
	Extctrls::TTimer* FHideTimer;
	bool FShowLeft;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	void __fastcall HideTimerOnTime(System::TObject* Sender);
	
protected:
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoHide(void);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	__property bool ShowAbove = {read=FShowAbove, write=FShowAbove, nodefault};
	__property bool ShowLeft = {read=FShowLeft, write=FShowLeft, default=0};
	
public:
	__fastcall virtual TOptionSelectorWindow(Classes::TComponent* AOwner);
	__fastcall virtual TOptionSelectorWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TOptionSelectorWindow(void);
	void __fastcall SetWindowSize(void);
	
__published:
	__property TAdvCustomToolBar* AdvToolBar = {read=FAdvToolBar, write=FAdvToolBar};
	__property TOptionSelectorPanel* OptionsPanel = {read=FOptionsPanel, write=FOptionsPanel};
public:
	/* TWinControl.CreateParented */ inline __fastcall TOptionSelectorWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TOptionSelectorPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Classes::TComponent* FOwner;
	Graphics::TColor FColorTo;
	TGradientDirection FGradientDirection;
	Graphics::TColor FWindowBorderColor;
	Classes::TNotifyEvent FOnShouldHide;
	int FMarginY;
	int FMarginX;
	TAdvCustomToolBar* FAdvToolBar;
	TAdvQuickAccessToolBar* FAdvQuickAccessToolBar;
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	void __fastcall SetWindowBorderColor(const Graphics::TColor Value);
	void __fastcall SetMarginX(const int Value);
	void __fastcall SetMarginY(const int Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual int __fastcall GetVisibleHeight(void);
	virtual void __fastcall DoHide(void);
	__property Classes::TNotifyEvent OnShouldHide = {read=FOnShouldHide, write=FOnShouldHide};
	__property int MarginX = {read=FMarginX, write=SetMarginX, nodefault};
	__property int MarginY = {read=FMarginY, write=SetMarginY, nodefault};
	
public:
	__fastcall virtual TOptionSelectorPanel(Classes::TComponent* AOwner);
	
__published:
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor WindowBorderColor = {read=FWindowBorderColor, write=SetWindowBorderColor, default=8421504};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, nodefault};
	__property TAdvCustomToolBar* AdvToolBar = {read=FAdvToolBar, write=FAdvToolBar};
	__property TAdvQuickAccessToolBar* AdvQuickAccessToolBar = {read=FAdvQuickAccessToolBar, write=FAdvQuickAccessToolBar};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TOptionSelectorPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TOptionSelectorPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


class DELPHICLASS TCustomizeOption;
class PASCALIMPLEMENTATION TCustomizeOption : public TOptionSelectorPanel
{
	typedef TOptionSelectorPanel inherited;
	
private:
	Classes::TComponent* FOwner;
	bool FCustomizeBtnHot;
	bool FCustomizeBtnDown;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	Types::TRect __fastcall GetCustomizeBtnRect(void);
	
protected:
	System::UnicodeString FCustomizeText;
	void __fastcall UpDateSize(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TCustomizeOption(Classes::TComponent* AOwner);
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TCustomizeOption(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomizeOption(HWND ParentWindow) : TOptionSelectorPanel(ParentWindow) { }
	
};


class DELPHICLASS TSelectorItem;
class PASCALIMPLEMENTATION TSelectorItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FHeight;
	Controls::TCaption FCaption;
	Types::TRect FBRect;
	int FWidth;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	__property Types::TRect BRect = {read=FBRect, write=FBRect};
	
public:
	__fastcall TSelectorItem(void);
	__fastcall virtual ~TSelectorItem(void);
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
};


class DELPHICLASS TATBPopupWindow;
class PASCALIMPLEMENTATION TControlSelectorPanel : public TOptionSelectorPanel
{
	typedef TOptionSelectorPanel inherited;
	
private:
	TDbgList* FControlList;
	TSelectorItem* FAddAndRemoveBtn;
	bool FAddAndRemoveBtnHot;
	bool FAddAndRemoveBtnDown;
	Graphics::TColor FItemColorDown;
	Graphics::TColor FItemColorHot;
	int FSeparatorSize;
	Graphics::TColor FItemColorDownTo;
	Graphics::TColor FItemColorHotTo;
	Graphics::TColor FItemTextColorHot;
	Graphics::TColor FItemTextColor;
	Graphics::TColor FItemTextColorDown;
	TATBPopupWindow* FAddAndRemovePopup;
	bool FShowAddAndRemoveBtn;
	TSelectorItem* FOptionsBtn;
	bool FOptionsBtnHot;
	bool FOptionsBtnDown;
	Menus::TPopupMenu* FOptionsMenu;
	Extctrls::TTimer* FTimer;
	TDbgList* FSeparatorList;
	bool FInternalHiding;
	TAdvToolBarCustomizer* FCustomizer;
	TCustomizeOption* FCustomizeOptionPanel;
	TOptionSelectorWindow* FCustomizeOptionWindow;
	void __fastcall OnCustomizeOptionWindowHide(System::TObject* Sender);
	void __fastcall TimerOnTime(System::TObject* Sender);
	void __fastcall OnAddAndRemoveWindowHide(System::TObject* Sender);
	void __fastcall OnAARWindowDeActivateHide(System::TObject* Sender);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetItemColorDown(const Graphics::TColor Value);
	void __fastcall SetItemColorHot(const Graphics::TColor Value);
	void __fastcall SetItemColorDownTo(const Graphics::TColor Value);
	void __fastcall SetItemColorHotTo(const Graphics::TColor Value);
	void __fastcall SetItemTextColor(const Graphics::TColor Value);
	void __fastcall SetItemTextColorHot(const Graphics::TColor Value);
	void __fastcall SetItemTextColorDown(const Graphics::TColor Value);
	void __fastcall SetShowAddAndRemoveBtn(const bool Value);
	bool __fastcall GetShowOptionsBtn(void);
	void __fastcall SetOptionsMenu(const Menus::TPopupMenu* Value);
	void __fastcall SetTextAutoOptionMenu(const System::UnicodeString Value);
	void __fastcall SetTextOptionMenu(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetTextAutoOptionMenu(void);
	System::UnicodeString __fastcall GetTextOptionMenu(void);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoHide(void);
	void __fastcall ShowAddAndRemovePopup(void);
	void __fastcall HideAddAndRemovePopup(void);
	void __fastcall ShowOptionsBtnPopup(void);
	void __fastcall HideOptionsBtnPopup(void);
	void __fastcall ReSetButtonSize(void);
	TAdvToolBarSeparator* __fastcall AddCopySeparator(TAdvToolBarSeparator* ASeparator);
	__property TDbgList* ControlList = {read=FControlList};
	
public:
	__fastcall virtual TControlSelectorPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TControlSelectorPanel(void);
	void __fastcall ArrangeControls(void);
	int __fastcall AddControl(Controls::TControl* AControl);
	HIDESBASE void __fastcall RemoveControl(Controls::TControl* AControl);
	bool __fastcall IsEmpty(void);
	__property bool ShowAddAndRemoveBtn = {read=FShowAddAndRemoveBtn, write=SetShowAddAndRemoveBtn, nodefault};
	__property bool ShowOptionsBtn = {read=GetShowOptionsBtn, nodefault};
	__property System::UnicodeString TextAutoOptionMenu = {read=GetTextAutoOptionMenu, write=SetTextAutoOptionMenu};
	__property System::UnicodeString TextOptionMenu = {read=GetTextOptionMenu, write=SetTextOptionMenu};
	__property Menus::TPopupMenu* OptionsMenu = {read=FOptionsMenu, write=SetOptionsMenu};
	__property TAdvToolBarCustomizer* Customizer = {read=FCustomizer, write=FCustomizer};
	__property Graphics::TColor ItemColorHot = {read=FItemColorHot, write=SetItemColorHot, nodefault};
	__property Graphics::TColor ItemColorHotTo = {read=FItemColorHotTo, write=SetItemColorHotTo, nodefault};
	__property Graphics::TColor ItemColorDown = {read=FItemColorDown, write=SetItemColorDown, nodefault};
	__property Graphics::TColor ItemColorDownTo = {read=FItemColorDownTo, write=SetItemColorDownTo, nodefault};
	__property Graphics::TColor ItemTextColor = {read=FItemTextColor, write=SetItemTextColor, nodefault};
	__property Graphics::TColor ItemTextColorHot = {read=FItemTextColorHot, write=SetItemTextColorHot, nodefault};
	__property Graphics::TColor ItemTextColorDown = {read=FItemTextColorDown, write=SetItemTextColorDown, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TControlSelectorPanel(HWND ParentWindow) : TOptionSelectorPanel(ParentWindow) { }
	
};


class DELPHICLASS TATBPopupPanel;
class DELPHICLASS TATBMenuItem;
class PASCALIMPLEMENTATION TATBPopupWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	TAdvCustomToolBar* FAdvToolBar;
	TATBPopupPanel* FPopupPanel;
	bool FHideOnDeActivate;
	bool FShowAbove;
	Classes::TComponent* FOwner;
	Extctrls::TTimer* FHideTimer;
	bool FShowLeft;
	TATBMenuItem* FItems;
	Classes::TNotifyEvent FOnDeActivateHide;
	void __fastcall CreatePopupPanel(void);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	void __fastcall HideTimerOnTime(System::TObject* Sender);
	void __fastcall SetPopupPanel(const TATBPopupPanel* Value);
	
protected:
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall CreateItems(void);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	__property bool ShowAbove = {read=FShowAbove, write=FShowAbove, nodefault};
	__property bool ShowLeft = {read=FShowLeft, write=FShowLeft, default=0};
	
public:
	__fastcall virtual TATBPopupWindow(Classes::TComponent* AOwner);
	__fastcall virtual TATBPopupWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TATBPopupWindow(void);
	void __fastcall SetWindowSize(void);
	HIDESBASE void __fastcall Hide(void);
	
__published:
	__property TAdvCustomToolBar* AdvToolBar = {read=FAdvToolBar, write=FAdvToolBar};
	__property TATBPopupPanel* PopupPanel = {read=FPopupPanel, write=SetPopupPanel};
	__property Classes::TNotifyEvent OnDeActivateHide = {read=FOnDeActivateHide, write=FOnDeActivateHide};
public:
	/* TWinControl.CreateParented */ inline __fastcall TATBPopupWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class DELPHICLASS TATBCustomPopupPanel;
class PASCALIMPLEMENTATION TATBCustomPopupPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Classes::TComponent* FOwner;
	Graphics::TColor FColorTo;
	TGradientDirection FGradientDirection;
	Graphics::TColor FWindowBorderColor;
	Classes::TNotifyEvent FOnShouldHide;
	int FMarginY;
	int FMarginX;
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	void __fastcall SetWindowBorderColor(const Graphics::TColor Value);
	void __fastcall SetMarginX(const int Value);
	void __fastcall SetMarginY(const int Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual int __fastcall GetVisibleHeight(void);
	__property Classes::TNotifyEvent OnShouldHide = {read=FOnShouldHide, write=FOnShouldHide};
	__property int MarginX = {read=FMarginX, write=SetMarginX, nodefault};
	__property int MarginY = {read=FMarginY, write=SetMarginY, nodefault};
	
public:
	__fastcall virtual TATBCustomPopupPanel(Classes::TComponent* AOwner);
	
__published:
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor WindowBorderColor = {read=FWindowBorderColor, write=SetWindowBorderColor, default=8421504};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, nodefault};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TATBCustomPopupPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TATBCustomPopupPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TATBMenuItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TATBMenuItem* operator[](int Index) { return Items[Index]; }
	
private:
	bool FEnabled;
	bool FVisible;
	Types::TRect FBoundRect;
	Classes::TList* FItems;
	TATBMenuItem* FParentItem;
	int FHeight;
	Controls::TCaption FCaption;
	int FWidth;
	bool FChecked;
	System::UnicodeString FHint;
	bool FAutoCheck;
	System::TObject* FObjects;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	int __fastcall GetCount(void);
	TATBMenuItem* __fastcall GetItem(int Index);
	void __fastcall SetChecked(const bool Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetFParentItem(const TATBMenuItem* Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetAutoCheck(const bool Value);
	
protected:
	__property Types::TRect BoundRect = {read=FBoundRect, write=FBoundRect};
	
public:
	__fastcall TATBMenuItem(void);
	__fastcall virtual ~TATBMenuItem(void);
	void __fastcall Clear(void);
	bool __fastcall HasChildren(void);
	TATBMenuItem* __fastcall Add(void);
	void __fastcall RemoveItem(int ItemIndex);
	__property bool AutoCheck = {read=FAutoCheck, write=SetAutoCheck, nodefault};
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property bool Checked = {read=FChecked, write=SetChecked, nodefault};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property TATBMenuItem* ParentItem = {read=FParentItem, write=SetFParentItem};
	__property System::TObject* Objects = {read=FObjects, write=FObjects};
	__property int Count = {read=GetCount, nodefault};
	__property TATBMenuItem* Items[int Index] = {read=GetItem/*, default*/};
};


class PASCALIMPLEMENTATION TATBPopupPanel : public TATBCustomPopupPanel
{
	typedef TATBCustomPopupPanel inherited;
	
private:
	TATBMenuItem* FItems;
	Advmenus::TCustomAdvMenuStyler* FAdvMenuStyler;
	int FItemHeight;
	int FHotItem;
	int FPopupItem;
	bool FShowImageBar;
	bool FShowIconBar;
	int FImageBarSize;
	Graphics::TColor FImageBarColorTo;
	Graphics::TColor FImageBarColor;
	TATBPopupWindow* FItemPopup;
	void __fastcall OnItemPopupHide(System::TObject* Sender);
	void __fastcall OnItemPopupDeActivateHide(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetAdvMenuStyler(const Advmenus::TCustomAdvMenuStyler* Value);
	void __fastcall SetItems(const TATBMenuItem* Value);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetHotItem(const int Value);
	void __fastcall SetShowImageBar(const bool Value);
	void __fastcall SetShowIconBar(const bool Value);
	void __fastcall SetImageBarSize(const int Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ShowItemPopup(void);
	void __fastcall HideItemPopup(void);
	void __fastcall BeforeHide(void);
	void __fastcall ItemClick(int ItemIndex);
	bool __fastcall IsAnyAutoCheckItem(void);
	void __fastcall DrawItem(int ItemIndex);
	void __fastcall DrawAllItems(void);
	__property int ImageBarSize = {read=FImageBarSize, write=SetImageBarSize, nodefault};
	
public:
	__fastcall virtual TATBPopupPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TATBPopupPanel(void);
	void __fastcall InvalidateItem(int ItemIndex);
	int __fastcall IndexOfItemAt(int X, int Y);
	void __fastcall ToggleCheck(int ItemIndex);
	void __fastcall ArrangeItems(void);
	__property int HotItem = {read=FHotItem, write=SetHotItem, nodefault};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, nodefault};
	__property TATBMenuItem* Items = {read=FItems, write=SetItems};
	__property Advmenus::TCustomAdvMenuStyler* AdvMenuStyler = {read=FAdvMenuStyler, write=SetAdvMenuStyler};
	__property bool ShowImageBar = {read=FShowImageBar, write=SetShowImageBar, nodefault};
	__property bool ShowIconBar = {read=FShowIconBar, write=SetShowIconBar, nodefault};
	__property Graphics::TColor ImageBarColor = {read=FImageBarColor, write=FImageBarColor, nodefault};
	__property Graphics::TColor ImageBarColorTo = {read=FImageBarColorTo, write=FImageBarColorTo, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TATBPopupPanel(HWND ParentWindow) : TATBCustomPopupPanel(ParentWindow) { }
	
};


class DELPHICLASS TATBCommand;
class PASCALIMPLEMENTATION TATBCommand : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TNotifyEvent FOnExecute;
	Controls::TCaption FCaption;
	int FItemIndex;
	Classes::TBasicAction* FAction;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetAction(const Classes::TBasicAction* Value);
	
public:
	__fastcall virtual TATBCommand(Classes::TCollection* Collection);
	__fastcall virtual ~TATBCommand(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int ItemIndex = {read=FItemIndex, write=FItemIndex, nodefault};
	__property Classes::TBasicAction* Action = {read=FAction, write=SetAction};
	__property Classes::TNotifyEvent OnExecute = {read=FOnExecute, write=FOnExecute};
};


class DELPHICLASS TATBCommands;
class PASCALIMPLEMENTATION TATBCommands : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TATBCommand* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvToolBarCustomizer* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TATBCommand* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TATBCommand* Value);
	
public:
	__fastcall TATBCommands(TAdvToolBarCustomizer* AOwner);
	__property TATBCommand* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TATBCommand* __fastcall Add(void);
	HIDESBASE TATBCommand* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TATBCommands(void) { }
	
};


class DELPHICLASS TButtonProperties;
class PASCALIMPLEMENTATION TButtonProperties : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FCaption;
	bool FShowCaption;
	bool FVisible;
	bool FHint;
	bool FGlyph;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetCaption(const bool Value);
	void __fastcall SetGlyph(const bool Value);
	void __fastcall SetHint(const bool Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	void __fastcall Change(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TButtonProperties(void);
	__fastcall virtual ~TButtonProperties(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Caption = {read=FCaption, write=SetCaption, nodefault};
	__property bool Glyph = {read=FGlyph, write=SetGlyph, nodefault};
	__property bool Hint = {read=FHint, write=SetHint, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, nodefault};
};


class DELPHICLASS TCustomizedOptions;
class PASCALIMPLEMENTATION TCustomizedOptions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FAddButton;
	bool FReOrder;
	bool FDelete;
	bool FDeleteAll;
	bool FAddSeparator;
	Classes::TNotifyEvent FOnChange;
	bool FAddGlowButton;
	bool FEditButton;
	void __fastcall SetAddButton(const bool Value);
	void __fastcall SetAddSeparator(const bool Value);
	void __fastcall SetDelete(const bool Value);
	void __fastcall SetDeleteAll(const bool Value);
	void __fastcall SetReOrder(const bool Value);
	void __fastcall SetAddGlowButton(const bool Value);
	void __fastcall SetEditButton(const bool Value);
	
protected:
	void __fastcall Change(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TCustomizedOptions(void);
	__fastcall virtual ~TCustomizedOptions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool ReOrder = {read=FReOrder, write=SetReOrder, nodefault};
	__property bool AddButton = {read=FAddButton, write=SetAddButton, nodefault};
	__property bool AddSeparator = {read=FAddSeparator, write=SetAddSeparator, nodefault};
	__property bool AddGlowButton = {read=FAddGlowButton, write=SetAddGlowButton, default=1};
	__property bool Delete = {read=FDelete, write=SetDelete, nodefault};
	__property bool DeleteAll = {read=FDeleteAll, write=SetDeleteAll, nodefault};
	__property bool EditButton = {read=FEditButton, write=SetEditButton, default=1};
};


class DELPHICLASS TDialogSettings;
class PASCALIMPLEMENTATION TDialogSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FEditCaption;
	bool FLargeIcon;
	bool FEditGlyphPosition;
	System::UnicodeString FUpHint;
	System::UnicodeString FButtonEditCaptionLabel;
	System::UnicodeString FTopHint;
	System::UnicodeString FButtonEditIconLabel;
	System::UnicodeString FToolBarLabel;
	System::UnicodeString FDeleteHint;
	System::UnicodeString FEditHint;
	System::UnicodeString FCaptionLabel;
	System::UnicodeString FGlyphPosLabel;
	System::UnicodeString FCommandLabel;
	System::UnicodeString FButtonEditVisibleCheck;
	System::UnicodeString FButtonEditCaptionCheck;
	System::UnicodeString FButtonEditHintLabel;
	System::UnicodeString FAddHint;
	System::UnicodeString FAddSeparatorHint;
	System::UnicodeString FDeleteAllHint;
	System::UnicodeString FBottomHint;
	System::UnicodeString FDownHint;
	System::UnicodeString FCaption;
	System::UnicodeString FLargeIconCheck;
	System::UnicodeString FButtonEditCaption;
	Classes::TNotifyEvent FOnChange;
	bool FEditGlyph;
	System::UnicodeString FCustomize;
	System::UnicodeString FResetButtonCaption;
	System::UnicodeString FOKButtonCaption;
	System::UnicodeString FCancelButtonCaption;
	bool FEditGlyphVisible;
	System::UnicodeString FCancelButtonHint;
	System::UnicodeString FResetButtonHint;
	System::UnicodeString FAddGlowButtonHint;
	System::UnicodeString FGlyphPositionBottomCaption;
	System::UnicodeString FGlyphPositionLeftCaption;
	System::UnicodeString FGlyphPositionTopCaption;
	System::UnicodeString FGlyphPositionRightCaption;
	System::UnicodeString FOKButtonHint;
	System::UnicodeString FGlyphEditNoneIconCaption;
	
protected:
	void __fastcall Change(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TDialogSettings(void);
	__fastcall virtual ~TDialogSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString ToolBarLabel = {read=FToolBarLabel, write=FToolBarLabel};
	__property System::UnicodeString CommandLabel = {read=FCommandLabel, write=FCommandLabel};
	__property System::UnicodeString CaptionLabel = {read=FCaptionLabel, write=FCaptionLabel};
	__property System::UnicodeString GlyphPosLabel = {read=FGlyphPosLabel, write=FGlyphPosLabel};
	__property System::UnicodeString LargeIconCheck = {read=FLargeIconCheck, write=FLargeIconCheck};
	__property System::UnicodeString TopHint = {read=FTopHint, write=FTopHint};
	__property System::UnicodeString UpHint = {read=FUpHint, write=FUpHint};
	__property System::UnicodeString DownHint = {read=FDownHint, write=FDownHint};
	__property System::UnicodeString BottomHint = {read=FBottomHint, write=FBottomHint};
	__property System::UnicodeString AddHint = {read=FAddHint, write=FAddHint};
	__property System::UnicodeString AddSeparatorHint = {read=FAddSeparatorHint, write=FAddSeparatorHint};
	__property System::UnicodeString DeleteHint = {read=FDeleteHint, write=FDeleteHint};
	__property System::UnicodeString DeleteAllHint = {read=FDeleteAllHint, write=FDeleteAllHint};
	__property System::UnicodeString EditHint = {read=FEditHint, write=FEditHint};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property System::UnicodeString ButtonEditCaption = {read=FButtonEditCaption, write=FButtonEditCaption};
	__property System::UnicodeString ButtonEditCaptionLabel = {read=FButtonEditCaptionLabel, write=FButtonEditCaptionLabel};
	__property System::UnicodeString ButtonEditHintLabel = {read=FButtonEditHintLabel, write=FButtonEditHintLabel};
	__property System::UnicodeString ButtonEditIconLabel = {read=FButtonEditIconLabel, write=FButtonEditIconLabel};
	__property System::UnicodeString ButtonEditCaptionCheck = {read=FButtonEditCaptionCheck, write=FButtonEditCaptionCheck};
	__property System::UnicodeString ButtonEditVisibleCheck = {read=FButtonEditVisibleCheck, write=FButtonEditVisibleCheck};
	__property System::UnicodeString OKButtonCaption = {read=FOKButtonCaption, write=FOKButtonCaption};
	__property System::UnicodeString OKButtonHint = {read=FOKButtonHint, write=FOKButtonHint};
	__property System::UnicodeString CancelButtonCaption = {read=FCancelButtonCaption, write=FCancelButtonCaption};
	__property System::UnicodeString CancelButtonHint = {read=FCancelButtonHint, write=FCancelButtonHint};
	__property System::UnicodeString ResetButtonCaption = {read=FResetButtonCaption, write=FResetButtonCaption};
	__property System::UnicodeString ResetButtonHint = {read=FResetButtonHint, write=FResetButtonHint};
	__property System::UnicodeString AddGlowButtonHint = {read=FAddGlowButtonHint, write=FAddGlowButtonHint};
	__property System::UnicodeString GlyphPositionLeftCaption = {read=FGlyphPositionLeftCaption, write=FGlyphPositionLeftCaption};
	__property System::UnicodeString GlyphPositionTopCaption = {read=FGlyphPositionTopCaption, write=FGlyphPositionTopCaption};
	__property System::UnicodeString GlyphPositionRightCaption = {read=FGlyphPositionRightCaption, write=FGlyphPositionRightCaption};
	__property System::UnicodeString GlyphPositionBottomCaption = {read=FGlyphPositionBottomCaption, write=FGlyphPositionBottomCaption};
	__property System::UnicodeString GlyphEditNoneIconCaption = {read=FGlyphEditNoneIconCaption, write=FGlyphEditNoneIconCaption};
	__property bool EditGlyph = {read=FEditGlyph, write=FEditGlyph, default=1};
	__property bool EditGlyphVisible = {read=FEditGlyphVisible, write=FEditGlyphVisible, nodefault};
	__property bool EditCaption = {read=FEditCaption, write=FEditCaption, nodefault};
	__property bool EditGlyphPosition = {read=FEditGlyphPosition, write=FEditGlyphPosition, nodefault};
	__property bool LargeIcon = {read=FLargeIcon, write=FLargeIcon, nodefault};
	__property System::UnicodeString Customize = {read=FCustomize, write=FCustomize};
};


class DELPHICLASS TAdvToolBarWindow;
class PASCALIMPLEMENTATION TAdvToolBarWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	Classes::TComponent* FOwner;
	int FBorderWidth;
	Graphics::TColor FBorderColor;
	Graphics::TColor FColorTo;
	TGradientDirection FGradientDirection;
	Graphics::TColor FCaptionColorTo;
	Graphics::TColor FCaptionColor;
	
protected:
	DYNAMIC void __fastcall Paint(void);
	
public:
	__fastcall virtual TAdvToolBarWindow(Classes::TComponent* AOwner);
	__fastcall virtual TAdvToolBarWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TAdvToolBarWindow(void);
	
__published:
	__property Graphics::TColor ColorTo = {read=FColorTo, write=FColorTo, nodefault};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=FCaptionColor, nodefault};
	__property Graphics::TColor CaptionColorTo = {read=FCaptionColorTo, write=FCaptionColorTo, nodefault};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=FGradientDirection, nodefault};
	__property int BorderWidth = {read=FBorderWidth, write=FBorderWidth, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvToolBarWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class DELPHICLASS TATBItemProp;
class PASCALIMPLEMENTATION TATBItemProp : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::TObject* FATBItem;
	bool FCustomizerCreated;
	bool FIsSeparator;
	bool FIsATBButton;
	int FImageIndex;
	System::UnicodeString FCaption;
	bool FShowCaption;
	System::UnicodeString FHint;
	bool FVisible;
	System::UnicodeString FID;
	int FCommandID;
	bool FForceImageIndex;
	bool FIsGlowButton;
	void __fastcall SetIsATBButton(const bool Value);
	void __fastcall SetIsSeparator(const bool Value);
	
public:
	__fastcall TATBItemProp(void);
	__fastcall virtual ~TATBItemProp(void);
	__property bool IsATBButton = {read=FIsATBButton, write=SetIsATBButton, nodefault};
	__property bool IsSeparator = {read=FIsSeparator, write=SetIsSeparator, nodefault};
	__property bool IsGlowButton = {read=FIsGlowButton, write=FIsGlowButton, nodefault};
	__property System::TObject* ATBItem = {read=FATBItem, write=FATBItem};
	__property bool CustomizerCreated = {read=FCustomizerCreated, write=FCustomizerCreated, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property bool Visible = {read=FVisible, write=FVisible, nodefault};
	__property bool ShowCaption = {read=FShowCaption, write=FShowCaption, nodefault};
	__property System::UnicodeString ID = {read=FID, write=FID};
	__property int CommandID = {read=FCommandID, write=FCommandID, nodefault};
	__property bool ForceImageIndex = {read=FForceImageIndex, write=FForceImageIndex, nodefault};
};


typedef void __fastcall (__closure *TCustomizerCanShowEvent)(System::TObject* Sender, int &X, int &Y, bool &CanShow);

class PASCALIMPLEMENTATION TAdvToolBarCustomizer : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FEnablePersistence;
	System::UnicodeString FFileName;
	TAdvToolBar* FAdvToolBar;
	TATBCommands* FCommands;
	TButtonProperties* FButtonProperties;
	Imglist::TCustomImageList* FLargeImages;
	TCustomizedOptions* FOptions;
	Imglist::TCustomImageList* FSmallImages;
	Classes::TNotifyEvent FOnBeforeDisplay;
	Classes::TNotifyEvent FOnAfterPost;
	TDialogSettings* FDialogSettings;
	TCustomizerCanShowEvent FOnCanShow;
	void __fastcall OnButtonPropChange(System::TObject* Sender);
	void __fastcall OnOptionsChange(System::TObject* Sender);
	void __fastcall OnCommandsChange(System::TObject* Sender);
	void __fastcall SetAdvToolBar(const TAdvToolBar* Value);
	void __fastcall SetButtonProperties(const TButtonProperties* Value);
	void __fastcall SetCommands(const TATBCommands* Value);
	void __fastcall SetEnablePersistence(const bool Value);
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetLargeImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetOptions(const TCustomizedOptions* Value);
	void __fastcall SetSmallImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetDialogSettings(const TDialogSettings* Value);
	
protected:
	TDbgList* FDeleteItems;
	virtual void __fastcall UpdateAdvToolBar(void);
	void __fastcall InitializeWindow(void);
	virtual void __fastcall ShowCustomizer(void);
	virtual void __fastcall ResetToolBar(void);
	virtual void __fastcall SaveInitialState(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	Controls::TControl* __fastcall GetCtrl(System::UnicodeString CtrlName);
	
public:
	__fastcall virtual TAdvToolBarCustomizer(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvToolBarCustomizer(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property TAdvToolBar* AdvToolBar = {read=FAdvToolBar, write=SetAdvToolBar};
	__property Imglist::TCustomImageList* LargeImages = {read=FLargeImages, write=SetLargeImages};
	__property Imglist::TCustomImageList* SmallImages = {read=FSmallImages, write=SetSmallImages};
	__property TATBCommands* Commands = {read=FCommands, write=SetCommands};
	__property bool EnablePersistence = {read=FEnablePersistence, write=SetEnablePersistence, nodefault};
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
	__property TButtonProperties* ButtonProperties = {read=FButtonProperties, write=SetButtonProperties};
	__property TDialogSettings* DialogSettings = {read=FDialogSettings, write=SetDialogSettings};
	__property TCustomizedOptions* Options = {read=FOptions, write=SetOptions};
	__property Classes::TNotifyEvent OnBeforeDisplay = {read=FOnBeforeDisplay, write=FOnBeforeDisplay};
	__property Classes::TNotifyEvent OnAfterPost = {read=FOnAfterPost, write=FOnAfterPost};
	__property TCustomizerCanShowEvent OnCanShow = {read=FOnCanShow, write=FOnCanShow};
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


class DELPHICLASS TAdvToolBarContainer;
class PASCALIMPLEMENTATION TAdvToolBarContainer : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TAdvCustomToolBar* FAdvToolBar;
	bool FParentStyler;
	bool FLine3D;
	Controls::TCaption FCaption;
	Graphics::TColor FLineColor;
	TGradientBackground* FColor;
	int FMargin;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	int FMargins;
	bool FInternalUpdating;
	void __fastcall OnColorChange(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	void __fastcall SetAdvToolBar(const TAdvCustomToolBar* Value);
	void __fastcall SetCaption(const Controls::TCaption Value);
	HIDESBASE void __fastcall SetColor(const TGradientBackground* Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetParentStyler(const bool Value);
	void __fastcall SetLine3D(const bool Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	HIDESBASE void __fastcall SetMargins(const int Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	virtual void __fastcall Loaded(void);
	void __fastcall UpdateAllGlowButtons(void);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	void __fastcall ForceMargins(void);
	
public:
	__fastcall virtual TAdvToolBarContainer(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvToolBarContainer(void);
	__property TAdvCustomToolBar* AdvToolBar = {read=FAdvToolBar, write=SetAdvToolBar};
	
__published:
	__property Align = {default=0};
	__property AutoSize = {default=0};
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property TGradientBackground* Color = {read=FColor, write=SetColor};
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, nodefault};
	__property bool ParentStyler = {read=FParentStyler, write=SetParentStyler, default=1};
	__property bool Line3D = {read=FLine3D, write=SetLine3D, nodefault};
	__property int Margins = {read=FMargins, write=SetMargins, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvToolBarContainer(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvPageCaption;
class PASCALIMPLEMENTATION TAdvPageCaption : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	bool FVisible;
	int FHeight;
	Controls::TCaption FCaption;
	int FIndent;
	int FRightIndent;
	System::WideString FWideCaption;
	int FMinWidth;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetIndent(const int Value);
	void __fastcall SetWideCaption(const System::WideString Value);
	void __fastcall SetMinWidth(const int Value);
	
protected:
	void __fastcall Changed(void);
	__property int RightIndent = {read=FRightIndent, write=FRightIndent, nodefault};
	
public:
	__fastcall TAdvPageCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::WideString WideCaption = {read=FWideCaption, write=SetWideCaption};
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Height = {read=FHeight, write=SetHeight, default=27};
	__property int Indent = {read=FIndent, write=SetIndent, default=100};
	__property int MinWidth = {read=FMinWidth, write=SetMinWidth, default=100};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAdvPageCaption(void) { }
	
};


class DELPHICLASS TATBTabSettings;
class PASCALIMPLEMENTATION TATBTabSettings : public Classes::TPersistent
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
	int FMinSpacing;
	int FMinMargin;
	Classes::TNotifyEvent FOnGlassChange;
	void __fastcall SetLeftMargin(const int Value);
	void __fastcall SetRightMargin(const int Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetStartMargin(const int Value);
	void __fastcall SetEndMargin(const int Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetGlass(const bool Value);
	bool __fastcall GetGlass(void);
	
protected:
	void __fastcall Changed(void);
	__property int MinSpacing = {read=FMinSpacing, write=FMinSpacing, nodefault};
	__property int MinMargin = {read=FMinMargin, write=FMinMargin, nodefault};
	__property bool Glass = {read=GetGlass, write=SetGlass, default=0};
	
public:
	__fastcall TATBTabSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnGlassChange = {read=FOnGlassChange, write=FOnGlassChange};
	
__published:
	__property int LeftMargin = {read=FLeftMargin, write=SetLeftMargin, default=4};
	__property int RightMargin = {read=FRightMargin, write=SetRightMargin, default=4};
	__property int StartMargin = {read=FStartMargin, write=SetStartMargin, default=60};
	__property int EndMargin = {read=FEndMargin, write=SetEndMargin, nodefault};
	__property int Height = {read=FHeight, write=SetHeight, default=26};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TATBTabSettings(void) { }
	
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
	Graphics::TColor FShadowColor;
	Graphics::TColor FHighLightColor;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetGradient(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientMirror(const Advglowbutton::TGDIPGradient Value);
	
protected:
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=FShadowColor, nodefault};
	__property Graphics::TColor HighLightColor = {read=FHighLightColor, write=FHighLightColor, nodefault};
	
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


class PASCALIMPLEMENTATION TVistaPageBackground : public TVistaBackground
{
	typedef TVistaBackground inherited;
	
__published:
	__property ShadowColor;
	__property HighLightColor;
public:
	/* TVistaBackground.Create */ inline __fastcall TVistaPageBackground(void) : TVistaBackground() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TVistaPageBackground(void) { }
	
};


class PASCALIMPLEMENTATION TVistaTextBackground : public TVistaBackground
{
	typedef TVistaBackground inherited;
	
private:
	Graphics::TColor FTextColor;
	Graphics::TFont* FFont;
	bool FSystemFont;
	Graphics::TColor FTextColorExtended;
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetSystemFont(const bool Value);
	void __fastcall SetTextColorExtended(const Graphics::TColor Value);
	
public:
	__fastcall TVistaTextBackground(void);
	__fastcall virtual ~TVistaTextBackground(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property Graphics::TColor TextColorExtended = {read=FTextColorExtended, write=SetTextColorExtended, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
};


class PASCALIMPLEMENTATION TQATAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FFullSizeColorTo;
	Graphics::TColor FFullSizeColor;
	Graphics::TColor FFullSizeBorderColor;
	int FSteps;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FBorderColor;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetFullSizeColor(const Graphics::TColor Value);
	void __fastcall SetFullSizeColorTo(const Graphics::TColor Value);
	void __fastcall SetFullSizeBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetSteps(const int Value);
	
protected:
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TQATAppearance(void);
	__fastcall virtual ~TQATAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor FullSizeBorderColor = {read=FFullSizeBorderColor, write=SetFullSizeBorderColor, nodefault};
	__property Graphics::TColor FullSizeColor = {read=FFullSizeColor, write=SetFullSizeColor, nodefault};
	__property Graphics::TColor FullSizeColorTo = {read=FFullSizeColorTo, write=SetFullSizeColorTo, nodefault};
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
};


class DELPHICLASS TToolBarAppearance;
class PASCALIMPLEMENTATION TToolBarAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FBorderColorHot;
	Graphics::TColor FBorderColor;
	TGradientBackground* FColor;
	TGradientBackground* FColorHot;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColor(const TGradientBackground* Value);
	void __fastcall SetColorHot(const TGradientBackground* Value);
	
protected:
	void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TToolBarAppearance(void);
	__fastcall virtual ~TToolBarAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, default=536870911};
	__property TGradientBackground* Color = {read=FColor, write=SetColor};
	__property TGradientBackground* ColorHot = {read=FColorHot, write=SetColorHot};
};


class DELPHICLASS TCustomTabAppearance;
class PASCALIMPLEMENTATION TGroupAppearance : public Classes::TPersistent
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
	Graphics::TColor FTextColor;
	TCaptionAppearance* FCaptionAppearance;
	TVistaPageBackground* FPageAppearance;
	TToolBarAppearance* FToolBarAppearance;
	TCustomTabAppearance* FTabAppearance;
	Graphics::TFont* FFont;
	bool FSystemFont;
	void __fastcall OnCaptionAppearanceChanged(System::TObject* Sender);
	void __fastcall OnPageAppearanceChanged(System::TObject* Sender);
	void __fastcall OnToolBarAppearanceChanged(System::TObject* Sender);
	void __fastcall OnTabAppearanceChanged(System::TObject* Sender);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetGradient(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetGradientMirror(const Advglowbutton::TGDIPGradient Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetCaptionAppearance(const TCaptionAppearance* Value);
	void __fastcall SetPageAppearance(const TVistaPageBackground* Value);
	void __fastcall SetToolBarAppearance(const TToolBarAppearance* Value);
	void __fastcall SetTabAppearance(const TCustomTabAppearance* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetSystemFont(const bool Value);
	
protected:
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TGroupAppearance(void);
	__fastcall virtual ~TGroupAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, nodefault};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Advglowbutton::TGDIPGradient Gradient = {read=FGradient, write=SetGradient, nodefault};
	__property Advglowbutton::TGDIPGradient GradientMirror = {read=FGradientMirror, write=SetGradientMirror, nodefault};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property TCaptionAppearance* CaptionAppearance = {read=FCaptionAppearance, write=SetCaptionAppearance};
	__property TVistaPageBackground* PageAppearance = {read=FPageAppearance, write=SetPageAppearance};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
	__property TCustomTabAppearance* TabAppearance = {read=FTabAppearance, write=SetTabAppearance};
	__property TToolBarAppearance* ToolBarAppearance = {read=FToolBarAppearance, write=SetToolBarAppearance};
};


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
	bool FSystemFont;
	Graphics::TColor FShadowColor;
	Graphics::TColor FHighLightColor;
	Graphics::TColor FHighLightColorSelected;
	Graphics::TColor FHighLightColorDown;
	Graphics::TColor FHighLightColorHot;
	Graphics::TColor FHighLightColorSelectedHot;
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
	void __fastcall SetSystemFont(const bool Value);
	
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
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property Graphics::TColor TextColorHot = {read=FTextColorHot, write=SetTextColorHot, nodefault};
	__property Graphics::TColor TextColorSelected = {read=FTextColorSelected, write=SetTextColorSelected, nodefault};
	__property Graphics::TColor TextColorDisabled = {read=FTextColorDisabled, write=SetTextColorDisabled, nodefault};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=FShadowColor, nodefault};
	__property Graphics::TColor HighLightColor = {read=FHighLightColor, write=FHighLightColor, nodefault};
	__property Graphics::TColor HighLightColorHot = {read=FHighLightColorHot, write=FHighLightColorHot, nodefault};
	__property Graphics::TColor HighLightColorSelected = {read=FHighLightColorSelected, write=FHighLightColorSelected, nodefault};
	__property Graphics::TColor HighLightColorSelectedHot = {read=FHighLightColorSelectedHot, write=FHighLightColorSelectedHot, nodefault};
	__property Graphics::TColor HighLightColorDown = {read=FHighLightColorDown, write=FHighLightColorDown, nodefault};
};


class PASCALIMPLEMENTATION TTabAppearance : public TCustomTabAppearance
{
	typedef TCustomTabAppearance inherited;
	
__published:
	__property BackGround;
public:
	/* TCustomTabAppearance.Create */ inline __fastcall TTabAppearance(void) : TCustomTabAppearance() { }
	/* TCustomTabAppearance.Destroy */ inline __fastcall virtual ~TTabAppearance(void) { }
	
};


class DELPHICLASS TATBTabScroller;
class PASCALIMPLEMENTATION TATBTabScroller : public System::TObject
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
	__fastcall TATBTabScroller(void);
	bool __fastcall CanGoForward(void);
	bool __fastcall CanGoBack(void);
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TATBTabScroller(void) { }
	
};


class DELPHICLASS TTabGroupItem;
class PASCALIMPLEMENTATION TTabGroupItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	int FImageIndex;
	int FTabIndexStart;
	int FTabIndexEnd;
	System::WideString FWideCaption;
	bool FDefaultAppearance;
	TGroupAppearance* FGroupAppearance;
	Classes::TAlignment FCaptionAlignment;
	void __fastcall OnGroupAppearanceChanged(System::TObject* Sender);
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetTabIndexEnd(const int Value);
	void __fastcall SetTabIndexStart(const int Value);
	void __fastcall SetDefaultAppearance(const bool Value);
	void __fastcall SetGroupAppearance(const TGroupAppearance* Value);
	void __fastcall SetCaptionAlignment(const Classes::TAlignment Value);
	void __fastcall SetWideCaption(const System::WideString Value);
	
public:
	__fastcall virtual TTabGroupItem(Classes::TCollection* Collection);
	__fastcall virtual ~TTabGroupItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::WideString WideCaption = {read=FWideCaption, write=SetWideCaption};
	void __fastcall SetCustomColor(Graphics::TColor AColor);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, nodefault};
	__property bool DefaultAppearance = {read=FDefaultAppearance, write=SetDefaultAppearance, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property int TabIndexStart = {read=FTabIndexStart, write=SetTabIndexStart, nodefault};
	__property int TabIndexEnd = {read=FTabIndexEnd, write=SetTabIndexEnd, nodefault};
	__property TGroupAppearance* GroupAppearance = {read=FGroupAppearance, write=SetGroupAppearance};
};


class DELPHICLASS TTabGroups;
class DELPHICLASS TAdvToolBarPager;
class PASCALIMPLEMENTATION TTabGroups : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TTabGroupItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvToolBarPager* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TTabGroupItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TTabGroupItem* Value);
	
protected:
	void __fastcall UpdateChange(void);
	
public:
	__fastcall TTabGroups(TAdvToolBarPager* AOwner);
	__property TTabGroupItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TTabGroupItem* __fastcall Add(void);
	HIDESBASE TTabGroupItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TTabGroups(void) { }
	
};


class DELPHICLASS TAdvPageScrollButton;
class PASCALIMPLEMENTATION TAdvPageScrollButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	Advglowbutton::TGlowButtonAppearance* FAppearance;
	bool FTransparent;
	Advglowbutton::TButtonPosition FButtonPosition;
	bool FMouseDown;
	TScrollArrow FScrollArrow;
	Extctrls::TTimer* FRepeatTimer;
	int FInitRepeatPause;
	int FRepeatPause;
	bool FRepeatClick;
	void __fastcall AppearanceChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall TimerExpired(System::TObject* Sender);
	void __fastcall SetAppearance(const Advglowbutton::TGlowButtonAppearance* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetButtonPosition(const Advglowbutton::TButtonPosition Value);
	void __fastcall SetScrollArrow(const TScrollArrow Value);
	
protected:
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property Advglowbutton::TGlowButtonAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property Enabled = {default=1};
	__property Font;
	__property Advglowbutton::TButtonPosition Position = {read=FButtonPosition, write=SetButtonPosition, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property TScrollArrow ScrollArrow = {read=FScrollArrow, write=SetScrollArrow, nodefault};
	__property Visible = {default=1};
	__property int InitRepeatPause = {read=FInitRepeatPause, write=FInitRepeatPause, default=400};
	__property int RepeatPause = {read=FRepeatPause, write=FRepeatPause, default=100};
	__property bool RepeatClick = {read=FRepeatClick, write=FRepeatClick, default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	
public:
	__fastcall virtual TAdvPageScrollButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPageScrollButton(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPageScrollButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvPage;
class PASCALIMPLEMENTATION TAdvPage : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TDbgList* FAdvToolBars;
	bool FTabVisible;
	TAdvToolBarPager* FAdvToolBarPager;
	Controls::TCaption FCaption;
	System::WideString FWideCaption;
	bool FTabEnabled;
	int FImageIndex;
	bool FAutoPosition;
	bool FUpdatingATBPosition;
	Extctrls::TTimer* FTimer;
	int FTimeInc;
	int FStepHover;
	int FStepPush;
	Advglowbutton::TGlowState FGlowState;
	System::UnicodeString FTabHint;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	bool FUpdatingParent;
	Advglowbutton::TShortCutHintWindow* FShortCutHint;
	Advglowbutton::TShortCutHintPos FShortCutHintPos;
	System::UnicodeString FShortCutHintText;
	bool FToolBarShortCutShowing;
	System::UnicodeString FShortCutChars;
	TATBTabScroller* FToolBarScroller;
	bool FScrolling;
	int FLeftATBIndex;
	TAdvPageScrollButton* FLeftScrollBtn;
	TAdvPageScrollButton* FRightScrollBtn;
	int FTabWidth;
	int FTabLeft;
	int FTabClientWidth;
	int FTabRealClientWidth;
	int FOldWidth;
	TAdvPage* FSelfClone;
	bool FCloning;
	bool FOldAutoPosition;
	void __fastcall TimerProc(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Controls::TCMControlListChange &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	int __fastcall GetAdvToolBarCount(void);
	TAdvToolBar* __fastcall GetAdvToolBars(int index);
	void __fastcall SetAdvToolBarPager(const TAdvToolBarPager* Value);
	void __fastcall SetTabVisible(const bool Value);
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetWideCaption(const System::WideString Value);
	void __fastcall SetTabEnabled(const bool Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetAutoPosition(const bool Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	int __fastcall GetPageIndex(void);
	void __fastcall SetPageIndex(const int Value);
	void __fastcall SetTabLeft(const int Value);
	int __fastcall GetTabWidth(void);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ReadState(Classes::TReader* Reader);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall GetSequencialToolBarList(TDbgList* ATBList);
	void __fastcall UpdateAdvToolBarsPosition(void);
	void __fastcall InvalidateAllAdvToolBars(void);
	void __fastcall HideCompactWindowOfAdvToolBars(void);
	void __fastcall ShowShortCutHintOfAllToolBars(void);
	void __fastcall HideShortCutHintOfAllToolBars(void);
	TAdvToolBar* __fastcall GetFirstToolBar(bool Visible);
	bool __fastcall HasShortCut(System::UnicodeString aShortCut);
	int __fastcall RealIndexToVisIndex(int ATBIndex);
	int __fastcall VisIndexToRealIndex(int ATBIndex);
	int __fastcall VisibleToolBarCount(void);
	bool __fastcall ALLATBSmallestVariant(void);
	void __fastcall IncreaseToolBarSize(void);
	void __fastcall DecreaseToolBarSize(void);
	void __fastcall InitializeScroller(void);
	void __fastcall UpdateScroller(void);
	int __fastcall ScrollPageATBVisibleCount(int AIndex, bool GoForward);
	void __fastcall ChangeLeftATBIndexTo(int Value);
	int __fastcall ScrollToolBars(int Value);
	void __fastcall InvalidateScrollBtns(void);
	void __fastcall OnScrollLeftClick(System::TObject* Sender);
	void __fastcall OnScrollRightClick(System::TObject* Sender);
	void __fastcall ScrollInView(int ATBIndex);
	bool __fastcall IsGroupTab(void);
	TAdvPage* __fastcall CreateClone(Controls::TWinControl* ParntWin);
	void __fastcall DestroyClone(void);
	void __fastcall PopulateClone(void);
	void __fastcall UnPopulateClone(void);
	Advglowbutton::TAdvGlowButton* __fastcall GetCompactBtnFromHandle(HWND H);
	__property int TabWidth = {read=GetTabWidth, nodefault};
	__property int TabClientWidth = {read=FTabClientWidth, write=FTabClientWidth, nodefault};
	__property int TabRealClientWidth = {read=FTabRealClientWidth, write=FTabRealClientWidth, nodefault};
	__property int TabLeft = {read=FTabLeft, write=SetTabLeft, nodefault};
	
public:
	__fastcall virtual TAdvPage(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPage(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall ShowShortCutHint(void);
	void __fastcall HideShortCutHint(void);
	TAdvToolBar* __fastcall CreateAdvToolBar(void);
	int __fastcall AddAdvToolBar(TAdvToolBar* ToolBar);
	void __fastcall InsertAdvToolBar(int Index, TAdvToolBar* ToolBar);
	void __fastcall RemoveAdvToolBar(TAdvToolBar* ToolBar);
	int __fastcall IndexOfAdvToolBar(TAdvToolBar* ToolBar);
	void __fastcall MoveAdvToolBar(int CurIndex, int NewIndex);
	__property System::WideString WideCaption = {read=FWideCaption, write=SetWideCaption};
	void __fastcall UpdateAllToolBars(void);
	__property int AdvToolBarCount = {read=GetAdvToolBarCount, nodefault};
	__property TAdvToolBar* AdvToolBars[int index] = {read=GetAdvToolBars};
	__property TAdvToolBarPager* AdvToolBarPager = {read=FAdvToolBarPager, write=SetAdvToolBarPager};
	
__published:
	__property bool AutoPosition = {read=FAutoPosition, write=SetAutoPosition, default=1};
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property System::UnicodeString TabHint = {read=FTabHint, write=FTabHint};
	__property bool TabVisible = {read=FTabVisible, write=SetTabVisible, default=1};
	__property bool TabEnabled = {read=FTabEnabled, write=SetTabEnabled, default=1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property System::UnicodeString ShortCutHint = {read=FShortCutHintText, write=FShortCutHintText};
	__property Advglowbutton::TShortCutHintPos ShortCutHintPos = {read=FShortCutHintPos, write=FShortCutHintPos, default=3};
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvPage(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TTabChangingEvent)(System::TObject* Sender, int FromPage, int ToPage, bool &AllowChange);

typedef void __fastcall (__closure *TTabClickEvent)(System::TObject* Sender, int Page);

typedef void __fastcall (__closure *TTabGroupClickEvent)(System::TObject* Sender, int TabGroup);

class DELPHICLASS TMinimizedRibbonWindow;
class DELPHICLASS TCaptionLayer;
class PASCALIMPLEMENTATION TAdvToolBarPager : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FUpdateHelpButtonRes;
	TCustomAdvToolBarStyler* FInternalToolBarStyler;
	TCustomAdvToolBarStyler* FToolBarStyler;
	TCustomAdvToolBarStyler* FCurrentToolBarStyler;
	TCustomAdvToolBarStyler* FOfficeToolBarStyler;
	TDockAlign FDockAlign;
	int FOffSetY;
	int FOffSetX;
	TDbgList* FAdvPages;
	int FMinimumSize;
	bool FPropertiesLoaded;
	bool FShowNonSelectedTabs;
	TATBTabSettings* FTabSettings;
	TAdvPageCaption* FCaption;
	TATBTabScroller* FTabScroller;
	int FActivePageIndex;
	int FHotPageIndex;
	int FDownPageIndex;
	int FOldHotPageIndex;
	int FHintPageIndex;
	Imglist::TCustomImageList* FImages;
	Imglist::TCustomImageList* FDisabledImages;
	bool FScrollerHoverLeftBtn;
	bool FScrollerDownLeftBtn;
	bool FScrollerHoverRightBtn;
	bool FScrollerDownRightBtn;
	bool FShowTabHint;
	TTabGroups* FTabGroups;
	bool FCanMove;
	TCaptionButtons FCaptionButtons;
	Advglowbutton::TAdvGlowButton* FCaptionCloseBtn;
	Advglowbutton::TAdvGlowButton* FCaptionMinBtn;
	Advglowbutton::TAdvGlowButton* FCaptionMaxBtn;
	Classes::TNotifyEvent FOnCloseButtonClick;
	Classes::TNotifyEvent FOnMinButtonClick;
	Classes::TNotifyEvent FOnMaxButtonClick;
	Classes::TNotifyEvent FOnChange;
	TTabChangingEvent FOnChanging;
	int FOldCapRightIndent;
	Advhintinfo::TAdvHintInfo* FOfficeHint;
	Advgdip::TAntiAlias FAntiAlias;
	int FPageRightMargin;
	int FPageLeftMargin;
	TDbgList* FShortCutHintWinList;
	Classes::TWndMethod FFormWndProc;
	bool FTabShortCutHintShowing;
	System::UnicodeString FTabShortCutChars;
	Gdipicture::TGDIPPicture* FIOptionPicture;
	Gdipicture::TGDIPPicture* FIOptionDisabledPicture;
	bool FAutoMDIButtons;
	bool FMDIButtonsVisible;
	int FMDIButtonsWidth;
	int FMDIButtonsSpace;
	Advglowbutton::TAdvGlowButton* FMDICloseBtn;
	Advglowbutton::TAdvGlowButton* FMDIMinBtn;
	Advglowbutton::TAdvGlowButton* FMDIMaxBtn;
	Forms::TCustomForm* FMDIChildForm;
	Controls::TImageList* FMDIBtnImages;
	bool FExpanded;
	int FExpandedHeight;
	Extctrls::TTimer* FShortCutTimer;
	bool FALTDown;
	Forms::TWindowState FFormWindowState;
	int FCurrentTabSpacing;
	int FCurrentTabLeftMargin;
	int FCurrentTabRightMargin;
	int FCurrentGroupTabLeftMargin;
	int FCurrentGroupTabRightMargin;
	TAdvPageScrollButton* FLeftScrollBtn;
	TAdvPageScrollButton* FRightScrollBtn;
	int FStartTabIndex;
	bool FOnlyALT;
	TAdvQuickAccessToolBar* FQuickAccessToolBar;
	unsigned FShortCutDelay;
	bool FDesignTime;
	bool FEnableWheel;
	TTabClickEvent FOnTabClick;
	TTabClickEvent FOnTabDblClick;
	TPersistence* FPersistence;
	int FOldHeight;
	TTabGroupClickEvent FOnTabGroupClick;
	bool FHideState;
	int FQATOldVisible;
	int FShapeBtnOldVisible;
	Extctrls::TTimer* FDblClickTimer;
	int FClickCount;
	TMinimizedRibbonWindow* FMinimizedRibbonWindow;
	Classes::TNotifyEvent FOnExpand;
	Classes::TNotifyEvent FOnCollaps;
	bool FNonActiveMouseWheelOnFocus;
	bool FHidePagesOnDblClick;
	bool FIsAeroVista;
	bool FFirstRun;
	bool FRegionSet;
	TCaptionLayer* FCaptionLayer;
	bool FMinimizeApp;
	bool FChangeActiveTab;
	bool FShowHelpButton;
	Classes::TNotifyEvent FOnHelpClick;
	Advglowbutton::TAdvGlowButton* FHelpBtn;
	Advglowbutton::TAdvGlowButton* FExpCollapsBtn;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	HWND FFocusCtrlH;
	bool FShowExpandCollapsButton;
	bool FTabBackGroundShaded;
	bool FIsWin7;
	bool FUseCaptionLayer;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
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
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	void __fastcall SubclassProc(Messages::TMessage &Msg);
	void __fastcall OnPersistenceChanged(System::TObject* Sender);
	void __fastcall OnDblClickTimer(System::TObject* Sender);
	void __fastcall OnFloatingRibbonWindowCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall OnFloatingRibbonWindowClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall OnRibbonWindowHide(System::TObject* Sender);
	void __fastcall OnCaptionTextPaint(System::TObject* Sender, System::UnicodeString &Text, Types::TRect &TxtR, Classes::TAlignment &Algn);
	void __fastcall OnCaptionLayerMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnCaptionLayerMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnCaptionLayerDoubleClick(System::TObject* Sender, int X, int Y);
	void __fastcall UpdateCaptionButtons(bool UpdateImage);
	void __fastcall UpdateShapeButton(void);
	void __fastcall OnCaptionCloseBtnClick(System::TObject* Sender);
	void __fastcall OnCaptionMaxBtnClick(System::TObject* Sender);
	void __fastcall OnCaptionMinBtnClick(System::TObject* Sender);
	void __fastcall OnHelpBtnClick(System::TObject* Sender);
	void __fastcall OnExpCollapsBtnClick(System::TObject* Sender);
	void __fastcall OnTabGroupsChanged(System::TObject* Sender);
	void __fastcall OnTabSettingsChanged(System::TObject* Sender);
	void __fastcall OnTabSettingsGlassChanged(System::TObject* Sender);
	void __fastcall CheckCaptionHeight(void);
	void __fastcall OnCaptionChanged(System::TObject* Sender);
	void __fastcall OnOptionPictureChanged(System::TObject* Sender);
	void __fastcall OnShortCutTime(System::TObject* Sender);
	void __fastcall OnMDICloseBtnClick(System::TObject* Sender);
	void __fastcall OnMDIMaxBtnClick(System::TObject* Sender);
	void __fastcall OnMDIMinBtnClick(System::TObject* Sender);
	void __fastcall UpdateMDIButtonsShowing(void);
	void __fastcall OnEnterTab(int PageIndex);
	void __fastcall OnExitTab(int PageIndex);
	void __fastcall SetPagePosition(TAdvPage* AdvPage);
	void __fastcall SetAllPagesPosition(void);
	void __fastcall SetToolBarStyler(const TCustomAdvToolBarStyler* Value);
	TDockAlign __fastcall GetAlign(void);
	HIDESBASE void __fastcall SetAlign(const TDockAlign Value);
	int __fastcall GetAdvToolBarPageCount(void);
	TAdvPage* __fastcall GetAdvPages(int index);
	Menus::TPopupMenu* __fastcall GetPopupMenuEx(void);
	void __fastcall SetPopupMenuEx(const Menus::TPopupMenu* Value);
	void __fastcall SetShowNonSelectedTabs(const bool Value);
	TAdvPage* __fastcall GetActivePage(void);
	int __fastcall GetActivePageIndex(void);
	void __fastcall SetActivePage(const TAdvPage* Value);
	void __fastcall SetActivePageIndex(const int Value);
	void __fastcall SetTabSettings(const TATBTabSettings* Value);
	void __fastcall SetCaption(const TAdvPageCaption* Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetDisabledImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetTabGroups(const TTabGroups* Value);
	void __fastcall SetCaptionButtons(const TCaptionButtons Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetOfficeHint(const Advhintinfo::TAdvHintInfo* Value);
	void __fastcall SetAntiAlias(const Advgdip::TAntiAlias Value);
	void __fastcall SetPageLeftMargin(const int Value);
	void __fastcall SetPageRightMargin(const int Value);
	void __fastcall SetOptionPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetOptionDisabledPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetAutoMDIButtons(const bool Value);
	void __fastcall SetMDIButtonsVisible(const bool Value);
	void __fastcall SetExpanded(bool Value);
	int __fastcall GetTabsWidth(int FromIndex, int ToIndex);
	int __fastcall GetLargestTabIndex(bool ConsiderGroupTabs);
	int __fastcall GetSmallestExpandableTabIndex(bool PriorityGroupTabs);
	bool __fastcall ShouldDrawSeparator(int PageIndex);
	void __fastcall SetShowQATBelow(const bool Value);
	bool __fastcall GetShowQATBelow(void);
	void __fastcall UpdateQATVisibility(void);
	void __fastcall SetPersistence(const TPersistence* Value);
	void __fastcall SetHideState(const bool Value);
	void __fastcall SetShowHelpButton(const bool Value);
	void __fastcall UpdateHelpButton(void);
	void __fastcall UpdateExpCollapsBtn(void);
	void __fastcall UpdateExpCollapsBtnImage(void);
	void __fastcall SetWin7ScenicRibbon(const bool Value);
	bool __fastcall GetWin7ScenicRibbon(void);
	void __fastcall SetShowExpandCollapsButton(const bool Value);
	Forms::TWindowState __fastcall GetParentWindowState(void);
	
protected:
	bool FChangeByKeyPress;
	Advglowbutton::TAdvGlowButton* FLastDroppedCompactBtn;
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	void __fastcall DrawCaption(void);
	void __fastcall DrawTab(int PageIndex);
	void __fastcall DrawAllTabs(void);
	void __fastcall DrawTabScrollBtnLeft(void);
	void __fastcall DrawTabScrollBtnRight(void);
	void __fastcall DrawTabScrollButtons(void);
	void __fastcall DrawTabGroups(void);
	void __fastcall DrawVistaCaptionAndTabGroups(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	bool __fastcall IsMyChild(HWND PH, HWND H);
	void __fastcall ReturnFocus(void);
	void __fastcall CheckAndOpenOtherCompactToolBar(void);
	void __fastcall SetRegion(void);
	void __fastcall RemoveRegion(void);
	void __fastcall CreateLayeredControl(void);
	void __fastcall UpdateLayeredControl(void);
	void __fastcall SetAdvPageBounds(TAdvPage* AdvPage, int &ALeft, int &ATop, int &AWidth, int &AHeight);
	bool __fastcall TabInDisplayRange(int PageIndex);
	void __fastcall UpdateMe(int PropID);
	void __fastcall ChangeActivePage(int PageIndex);
	int __fastcall GetRealTabWidth(int TabIndex, int &TabClientWidth);
	bool __fastcall AnyTabCanBeExpanded(void);
	int __fastcall TotalGroupTabsCanBeExpanded(void);
	bool __fastcall AnyTabCanBeShrunk(bool ConsiderGroupTabs);
	bool __fastcall AnyGroupTabCanBeExpanded(void);
	int __fastcall GetMinTabWidth(void);
	int __fastcall GetTotalTabsWidth(void);
	void __fastcall UpdateTabSizes(void);
	void __fastcall ResetTabsPosition(void);
	void __fastcall UpdateTabPosition(int FromIndex, int ToIndex)/* overload */;
	void __fastcall UpdateTabPosition(void)/* overload */;
	void __fastcall InitializeTabsSize(void);
	void __fastcall InitializeTabWidth(int TabIndex);
	void __fastcall InitializeScroller(void);
	void __fastcall UpdateTabScroller(void);
	int __fastcall TabCountOnVisibleArea(int TabIndex, bool GoForward, int &LastTabIndex);
	int __fastcall VisibleTabCount(int FromIndex, int ToIndex)/* overload */;
	int __fastcall VisibleTabCount(void)/* overload */;
	int __fastcall GetFirstVisibleTabIndex(void);
	int __fastcall GetLastVisibleTabIndex(void);
	void __fastcall ChangeLeftTabIndexTo(int Value);
	int __fastcall ScrollTabsPage(int Value);
	void __fastcall InvalidateScrollBtns(void);
	void __fastcall ScrollInView(int TabIndex);
	void __fastcall OnScrollLeftBtnClick(System::TObject* Sender);
	void __fastcall OnScrollRightBtnClick(System::TObject* Sender);
	void __fastcall ShowShortCutHintOfAllPages(void);
	void __fastcall HideShortCutHintOfAllPages(bool ToolBarHint = false);
	Advglowbutton::TShortCutHintWindow* __fastcall CreateShortCutHintWin(void);
	void __fastcall DestroyShortCutHintWin(Advglowbutton::TShortCutHintWindow* ShortCutWin);
	bool __fastcall IsTabGroupVisible(int GroupIndex);
	int __fastcall GroupOfTab(int PageIndex);
	bool __fastcall CanShowTab(int PageIndex);
	void __fastcall InvalidateActivePageAttachement(void);
	void __fastcall InvalidateTab(int PageIndex);
	Types::TRect __fastcall GetCaptionTextRect(Classes::TAlignment &Alignment);
	Types::TRect __fastcall GetCaptionRect(void);
	Types::TRect __fastcall GetAvailableCaptionRect(void);
	Types::TRect __fastcall GetAdvPageRect(void);
	Types::TRect __fastcall GetTabsArea(void);
	Types::TRect __fastcall GetTabsRect(void);
	Types::TRect __fastcall GetTabVisibleRect(TAdvPage* Page)/* overload */;
	Types::TRect __fastcall GetTabVisibleRect(int PageIndex)/* overload */;
	Types::TRect __fastcall GetTabRect(int StartIndex, int PageIndex, bool ConsiderTabScroller)/* overload */;
	Types::TRect __fastcall GetTabRect(int PageIndex)/* overload */;
	Types::TRect __fastcall GetTabRect(TAdvPage* Page)/* overload */;
	int __fastcall PTOnTab(int X, int Y);
	int __fastcall PtOntTabGroup(int X, int Y);
	Types::TRect __fastcall GetTabScrollerRect(void);
	Types::TRect __fastcall GetTabScrollerLeftRect(void);
	Types::TRect __fastcall GetTabScrollerRightRect(void);
	bool __fastcall PtOnTabScrollLeftBtn(int X, int Y);
	bool __fastcall PtOnTabScrollRightBtn(int X, int Y);
	Types::TRect __fastcall GetTabGroupRect(int GroupIndex, bool &LeftVisible, bool &RightVisible);
	Types::TRect __fastcall GetMDIButtonsRectRect(void);
	void __fastcall UpdateMDIButtons(bool UpdateImage);
	Types::TRect __fastcall GetCaptionButtonsRect(void);
	Types::TRect __fastcall MaxQATRect(void);
	int __fastcall GetQATHeight(void);
	void __fastcall CreateFloatingRibbon(void);
	void __fastcall DestroyFloatingRibbon(void);
	void __fastcall ShowFloatingRibbon(void);
	void __fastcall HideFloatingRibbon(void);
	bool __fastcall IsFloatingRibbonShowing(void);
	void __fastcall HandleKey(System::Word Code);
	Types::TRect __fastcall GetHelpBtnRect(void);
	Types::TRect __fastcall GetExpCollapsBtnRect(void);
	void __fastcall SetAeroVista(bool Value);
	bool __fastcall IsGlass(bool ConsiderWindowState = true);
	__property bool TabBackGroundShaded = {read=FTabBackGroundShaded, write=FTabBackGroundShaded, default=0};
	__property TDockAlign Align = {read=GetAlign, write=SetAlign, default=1};
	__property bool MDIButtonsVisible = {read=FMDIButtonsVisible, write=SetMDIButtonsVisible, nodefault};
	__property TCustomAdvToolBarStyler* CurrentToolBarStyler = {read=FCurrentToolBarStyler};
	__property bool HideState = {read=FHideState, write=SetHideState, default=0};
	
public:
	__fastcall virtual TAdvToolBarPager(Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	__fastcall virtual ~TAdvToolBarPager(void);
	DYNAMIC void __fastcall GetChildren(Classes::TGetChildProc Proc, Classes::TComponent* Root);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Invalidate(void);
	void __fastcall SetGlowSpeed(int speed);
	int __fastcall GetVersionNr(void);
	void __fastcall ShowShortCutHint(void);
	void __fastcall HideShortCutHint(void);
	void __fastcall SaveState(void);
	void __fastcall LoadState(void);
	void __fastcall Expand(void);
	void __fastcall Collaps(void);
	int __fastcall AddAdvPage(TAdvPage* AdvPage)/* overload */;
	int __fastcall AddAdvPage(Controls::TCaption PageCaption)/* overload */;
	void __fastcall RemoveAdvPage(TAdvPage* AdvPage);
	void __fastcall MoveAdvPage(int CurIndex, int NewIndex);
	TAdvPage* __fastcall FindNextPage(TAdvPage* CurPage, bool GoForward, bool CheckTabVisible);
	void __fastcall SelectNextPage(bool GoForward);
	int __fastcall IndexOfPage(TAdvPage* AdvPage);
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	__property int AdvPageCount = {read=GetAdvToolBarPageCount, nodefault};
	__property TAdvPage* AdvPages[int index] = {read=GetAdvPages};
	void __fastcall NextActivePage(void);
	void __fastcall PrevActivePage(void);
	__property bool ShowQATBelow = {read=GetShowQATBelow, write=SetShowQATBelow, default=0};
	__property TAdvQuickAccessToolBar* QuickAccessToolBar = {read=FQuickAccessToolBar};
	__property bool Expanded = {read=FExpanded, nodefault};
	__property bool NonActiveMouseWheelOnFocus = {read=FNonActiveMouseWheelOnFocus, write=FNonActiveMouseWheelOnFocus, default=0};
	__property bool MinimizeApp = {read=FMinimizeApp, write=FMinimizeApp, nodefault};
	__property int HotPageIndex = {read=FHotPageIndex, nodefault};
	__property Advglowbutton::TAdvGlowButton* HelpButton = {read=FHelpBtn};
	__property Advglowbutton::TAdvGlowButton* ExpandCollapsButton = {read=FExpCollapsBtn};
	void __fastcall ShapeButtonRefreshed(void);
	
__published:
	__property TAdvPage* ActivePage = {read=GetActivePage, write=SetActivePage};
	__property Advgdip::TAntiAlias AntiAlias = {read=FAntiAlias, write=SetAntiAlias, default=1};
	__property bool AutoMDIButtons = {read=FAutoMDIButtons, write=SetAutoMDIButtons, default=0};
	__property bool CanMove = {read=FCanMove, write=FCanMove, default=1};
	__property TAdvPageCaption* Caption = {read=FCaption, write=SetCaption};
	__property TCaptionButtons CaptionButtons = {read=FCaptionButtons, write=SetCaptionButtons, nodefault};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property bool HidePagesOnDblClick = {read=FHidePagesOnDblClick, write=FHidePagesOnDblClick, default=1};
	__property bool EnableWheel = {read=FEnableWheel, write=FEnableWheel, default=1};
	__property TTabGroups* TabGroups = {read=FTabGroups, write=SetTabGroups};
	__property TATBTabSettings* TabSettings = {read=FTabSettings, write=SetTabSettings};
	__property TPersistence* Persistence = {read=FPersistence, write=SetPersistence};
	__property Menus::TPopupMenu* PopupMenu = {read=GetPopupMenuEx, write=SetPopupMenuEx};
	__property TCustomAdvToolBarStyler* ToolBarStyler = {read=FToolBarStyler, write=SetToolBarStyler};
	__property bool ShowHelpButton = {read=FShowHelpButton, write=SetShowHelpButton, default=1};
	__property bool ShowExpandCollapsButton = {read=FShowExpandCollapsButton, write=SetShowExpandCollapsButton, default=0};
	__property bool ShowNonSelectedTabs = {read=FShowNonSelectedTabs, write=SetShowNonSelectedTabs, default=0};
	__property bool ShowTabHint = {read=FShowTabHint, write=FShowTabHint, default=0};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Advhintinfo::TAdvHintInfo* OfficeHint = {read=FOfficeHint, write=SetOfficeHint};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property int PageLeftMargin = {read=FPageLeftMargin, write=SetPageLeftMargin, nodefault};
	__property int PageRightMargin = {read=FPageRightMargin, write=SetPageRightMargin, nodefault};
	__property Gdipicture::TGDIPPicture* OptionPicture = {read=FIOptionPicture, write=SetOptionPicture};
	__property Gdipicture::TGDIPPicture* OptionDisabledPicture = {read=FIOptionDisabledPicture, write=SetOptionDisabledPicture};
	__property Visible = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Classes::TNotifyEvent OnCloseButtonClick = {read=FOnCloseButtonClick, write=FOnCloseButtonClick};
	__property Classes::TNotifyEvent OnMinButtonClick = {read=FOnMinButtonClick, write=FOnMinButtonClick};
	__property Classes::TNotifyEvent OnMaxButtonClick = {read=FOnMaxButtonClick, write=FOnMaxButtonClick};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TTabChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property OnDblClick;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property TTabClickEvent OnTabClick = {read=FOnTabClick, write=FOnTabClick};
	__property TTabClickEvent OnTabDblClick = {read=FOnTabDblClick, write=FOnTabDblClick};
	__property TTabGroupClickEvent OnTabGroupClick = {read=FOnTabGroupClick, write=FOnTabGroupClick};
	__property Classes::TNotifyEvent OnExpand = {read=FOnExpand, write=FOnExpand};
	__property Classes::TNotifyEvent OnCollaps = {read=FOnCollaps, write=FOnCollaps};
	__property Classes::TNotifyEvent OnHelpClick = {read=FOnHelpClick, write=FOnHelpClick};
	__property bool Win7ScenicRibbon = {read=GetWin7ScenicRibbon, write=SetWin7ScenicRibbon, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvToolBarPager(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvVistaButton;
class PASCALIMPLEMENTATION TAdvVistaButton : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	Advglowbutton::TGlowButtonAppearance* FAppearance;
	bool FTransparent;
	Advglowbutton::TButtonPosition FButtonPosition;
	bool FMouseDown;
	TScrollArrow FScrollArrow;
	TArrowStyle FArrowStyle;
	bool FDown;
	void __fastcall AppearanceChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetAppearance(const Advglowbutton::TGlowButtonAppearance* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetButtonPosition(const Advglowbutton::TButtonPosition Value);
	void __fastcall SetScrollArrow(const TScrollArrow Value);
	void __fastcall SetArrowStyle(const TArrowStyle Value);
	void __fastcall SetDown(const bool Value);
	
protected:
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property Advglowbutton::TGlowButtonAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property bool Down = {read=FDown, write=SetDown, nodefault};
	__property Enabled = {default=1};
	__property Font;
	__property Advglowbutton::TButtonPosition Position = {read=FButtonPosition, write=SetButtonPosition, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property TScrollArrow ScrollArrow = {read=FScrollArrow, write=SetScrollArrow, nodefault};
	__property TArrowStyle ArrowStyle = {read=FArrowStyle, write=SetArrowStyle, nodefault};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	
public:
	__fastcall virtual TAdvVistaButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvVistaButton(void);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
};


typedef void __fastcall (__closure *TTextPaintEvent)(System::TObject* Sender, System::UnicodeString &Text, Types::TRect &TxtR, Classes::TAlignment &Algn);

typedef void __fastcall (__closure *TDblClickEvent)(System::TObject* Sender, int X, int Y);

class PASCALIMPLEMENTATION TCaptionLayer : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TTextPaintEvent FOnTextPaint;
	Graphics::TColor FBackColor;
	TDblClickEvent FOnDoubleClick;
	Advglowbutton::TAdvGlowButton* FRefGlowButton;
	bool FRef;
	bool FResizing;
	int FMouseY;
	int FResizingDir;
	TResizingClip FResizingClip;
	Controls::TCursor FOldCursor;
	Controls::TMouseEvent FOnMouseDown;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TCaptionLayer(Classes::TComponent* AOwner);
	__fastcall virtual ~TCaptionLayer(void);
	__property Graphics::TColor BackColor = {read=FBackColor, write=FBackColor, default=536870911};
	__property TTextPaintEvent OnTextPaint = {read=FOnTextPaint, write=FOnTextPaint};
	__property TDblClickEvent OnDoubleClick = {read=FOnDoubleClick, write=FOnDoubleClick};
	
__published:
	__property Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCaptionLayer(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvCustomQuickAccessToolBar;
class PASCALIMPLEMENTATION TAdvCustomQuickAccessToolBar : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	unsigned FAppButtonTime;
	TAppIconGlowButton* Fapp;
	bool FFullSize;
	bool FShowCustomizeOption;
	TDbgList* FCtrlList;
	TDbgList* FHiddenCtrlList;
	bool FInternalUpdatingControlPos;
	bool FInternalUpdatingSize;
	TAdvVistaButton* FCustomizeButton;
	TAdvVistaButton* FScrollButton;
	TOptionSelectorWindow* FOverflowWindow;
	TControlSelectorPanel* FOverflowWindowPanel;
	Imglist::TCustomImageList* FDisabledImages;
	Imglist::TCustomImageList* FImages;
	int FButtonWidth;
	int FButtonGap;
	Menus::TPopupMenu* FDropDownPopupMenu;
	int FUpdateCount;
	System::UnicodeString FCustomizeHint;
	Classes::TNotifyEvent FOnCustomizeClick;
	bool FIsAeroVista;
	Advglowbutton::TAdvGlowButton* FRefGlowButton;
	bool FRef;
	bool FVisibleChanged;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	void __fastcall OnCustomizeButtonClick(System::TObject* Sender);
	void __fastcall OnScrollButtonClick(System::TObject* Sender);
	void __fastcall OnScrollButtonDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall OnGlowButtonClick(System::TObject* Sender);
	void __fastcall SetFullSize(const bool Value);
	void __fastcall SetShowCustomizeOption(const bool Value);
	TCustomAdvToolBarStyler* __fastcall GetCustomAdvToolBarStyler(void);
	void __fastcall SetDisabledImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	bool __fastcall GetShowScrollButton(void);
	void __fastcall SetShowScrollButton(const bool Value);
	void __fastcall SetCustomizeHint(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &ARect);
	virtual void __fastcall RequestAlign(void);
	virtual void __fastcall Loaded(void);
	void __fastcall UpdateMe(int PropID);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall SetParent(Controls::TWinControl* AParent);
	virtual void __fastcall Paint(void);
	void __fastcall AppButtonClick(System::TObject* Sender);
	void __fastcall FakeRefresh(void);
	void __fastcall RefreshAllGlowButtons(void);
	void __fastcall RefreshAllATBButtons(void);
	int __fastcall CountATBButtons(void);
	void __fastcall UpdateAllGlowButtons(void);
	void __fastcall UpdateAppIcon(void);
	void __fastcall ShowShortCutHintOfButtons(void);
	void __fastcall HideShortCutHintOfButtons(void);
	bool __fastcall HasShortCut(System::UnicodeString aShortCut, int &VisibleHintCount);
	void __fastcall ReturnFocus(void);
	void __fastcall UpdateHidedControlList(void);
	void __fastcall UpdateControlList(void);
	void __fastcall GetSequentialControlList(TDbgList* aList);
	void __fastcall UpdateControlsPos(bool SizeUpdate = false);
	void __fastcall UpdateControlsVisiblity(void);
	int __fastcall CanShrink(void);
	int __fastcall CanExpand(void);
	int __fastcall TotalCtrlsWidth(void);
	int __fastcall MaxWidth(void);
	int __fastcall MinWidth(void);
	void __fastcall UpdateSize(void);
	void __fastcall InitializeOverflowWindow(void);
	void __fastcall ShowOverflowWindow(int X, int Y, bool ForcePoint = true);
	void __fastcall OnOverflowWindowHide(System::TObject* Sender);
	Types::TRect __fastcall GetMyClientRect(void);
	Types::TRect __fastcall GetDrawingRect(void);
	int __fastcall GetLeftMargin(void);
	int __fastcall GetRightMargin(void);
	Types::TRect __fastcall GetCustomizeBtnRect(void);
	void __fastcall SetAeroVista(bool Value);
	__property TCustomAdvToolBarStyler* CurrentToolBarStyler = {read=GetCustomAdvToolBarStyler};
	__property bool ShowScrollButton = {read=GetShowScrollButton, write=SetShowScrollButton, nodefault};
	__property bool FullSize = {read=FFullSize, write=SetFullSize, default=0};
	__property bool ShowCustomizeOption = {read=FShowCustomizeOption, write=SetShowCustomizeOption, nodefault};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Imglist::TCustomImageList* DisabledImages = {read=FDisabledImages, write=SetDisabledImages};
	__property Menus::TPopupMenu* DropDownPopupMenu = {read=FDropDownPopupMenu, write=FDropDownPopupMenu};
	__property System::UnicodeString CustomizeHint = {read=FCustomizeHint, write=SetCustomizeHint};
	
public:
	__fastcall virtual TAdvCustomQuickAccessToolBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomQuickAccessToolBar(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual void __fastcall Update(void);
	void __fastcall AddToolBarControl(Controls::TControl* AControl);
	HIDESBASE void __fastcall RemoveControl(Controls::TControl* AControl);
	void __fastcall Clear(void);
	void __fastcall HideOverflowWindow(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property Classes::TNotifyEvent OnCustomizeClick = {read=FOnCustomizeClick, write=FOnCustomizeClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomQuickAccessToolBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvQuickAccessToolBar : public TAdvCustomQuickAccessToolBar
{
	typedef TAdvCustomQuickAccessToolBar inherited;
	
__published:
	__property CustomizeHint;
	__property DisabledImages;
	__property Images;
	__property ShowCustomizeOption;
	__property DropDownPopupMenu;
	__property PopupMenu;
	__property ShowHint;
	__property OnCustomizeClick;
public:
	/* TAdvCustomQuickAccessToolBar.Create */ inline __fastcall virtual TAdvQuickAccessToolBar(Classes::TComponent* AOwner) : TAdvCustomQuickAccessToolBar(AOwner) { }
	/* TAdvCustomQuickAccessToolBar.Destroy */ inline __fastcall virtual ~TAdvQuickAccessToolBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvQuickAccessToolBar(HWND ParentWindow) : TAdvCustomQuickAccessToolBar(ParentWindow) { }
	
};


class DELPHICLASS TAdvGlowMenuButton;
class PASCALIMPLEMENTATION TAdvGlowMenuButton : public Advglowbutton::TAdvCustomGlowButton
{
	typedef Advglowbutton::TAdvCustomGlowButton inherited;
	
protected:
	virtual bool __fastcall IsMenuButton(void);
	
public:
	__fastcall virtual TAdvGlowMenuButton(Classes::TComponent* AOwner);
	
__published:
	__property Appearance;
	__property Enabled = {default=1};
	__property Layout = {default=0};
	__property DropDownButton = {default=0};
	__property DropDownPosition = {default=0};
	__property DropDownSplit = {default=1};
	__property DropDownMenu;
	__property OnDropDown;
public:
	/* TAdvCustomGlowButton.Destroy */ inline __fastcall virtual ~TAdvGlowMenuButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGlowMenuButton(HWND ParentWindow) : Advglowbutton::TAdvCustomGlowButton(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TCompactWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	TAdvCustomToolBar* FAdvToolBar;
	bool FHideOnDeActivate;
	Classes::TComponent* FOwner;
	Extctrls::TTimer* FHideTimer;
	Advglowbutton::TAdvGlowButton* FDropDownButton;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	void __fastcall HideTimerOnTime(System::TObject* Sender);
	bool __fastcall GetHideOnDeActivate(void);
	
protected:
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoHide(void);
	void __fastcall SetCornersRounded(void);
	__property bool HideOnDeActivate = {read=GetHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	
public:
	__fastcall virtual TCompactWindow(Classes::TComponent* AOwner);
	__fastcall virtual TCompactWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TCompactWindow(void);
	void __fastcall SetWindowSize(void);
	
__published:
	__property TAdvCustomToolBar* AdvToolBar = {read=FAdvToolBar, write=FAdvToolBar};
	__property Advglowbutton::TAdvGlowButton* DropDownButton = {read=FDropDownButton, write=FDropDownButton};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCompactWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TMinimizedRibbonWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	bool FHideOnDeActivate;
	Classes::TComponent* FOwner;
	Extctrls::TTimer* FHideTimer;
	TAdvToolBarPager* FAdvToolBarPager;
	TAdvPage* FAdvPage;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	void __fastcall HideTimerOnTime(System::TObject* Sender);
	bool __fastcall GetHideOnDeActivate(void);
	
protected:
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoHide(void);
	__property bool HideOnDeActivate = {read=GetHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	
public:
	__fastcall virtual TMinimizedRibbonWindow(Classes::TComponent* AOwner);
	__fastcall virtual TMinimizedRibbonWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TMinimizedRibbonWindow(void);
	void __fastcall SetWindowSize(void);
	__property TAdvToolBarPager* AdvToolBarPager = {read=FAdvToolBarPager, write=FAdvToolBarPager};
	__property TAdvPage* AdvPage = {read=FAdvPage, write=FAdvPage};
public:
	/* TWinControl.CreateParented */ inline __fastcall TMinimizedRibbonWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvToolBarForm;
class PASCALIMPLEMENTATION TAdvToolBarForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	bool FIsAeroVista;
	bool FDestroying;
	Forms::TWindowState FOldWndState;
	bool FActivated;
	bool FCreated;
	Classes::TNotifyEvent FOnActivate;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Msg);
	void __fastcall UpdateOnWindowStateChange(void);
	int __fastcall GetTabHeight(void);
	
protected:
	virtual Types::TRect __fastcall GetClientRect(void);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual void __fastcall AlignControls(Controls::TControl* AControl, Types::TRect &Rect);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall Paint(void);
	DYNAMIC void __fastcall Activate(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	bool __fastcall IsFullMaximized(void);
	void __fastcall UpdateAeroVistaMode(void);
	
public:
	__fastcall virtual TAdvToolBarForm(Classes::TComponent* AOwner);
	__fastcall virtual TAdvToolBarForm(Classes::TComponent* AOwner, int Dummy);
	
__published:
	__property Classes::TNotifyEvent OnActivate = {read=FOnActivate, write=FOnActivate};
public:
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvToolBarForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvToolBarForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const Word CN_DROPDOWNCLOSED = 0x1400;
static const ShortInt DEFAULT_TOOLBARHEIGHT = 0x1a;
static const ShortInt DEFAULT_MINLENGTH = 0x3c;
static const ShortInt MINDOCKPANELHEIGHT = 0x3;
static const ShortInt DEFAULT_CAPTIONHEIGHT = 0x10;
static const ShortInt DEFAULT_ITEMHEIGHT = 0x14;
static const ShortInt DEFAULT_SEPARATORWIDTH = 0xa;
static const ShortInt IMG_SPACE = 0x2;
static const ShortInt MIN_BUTTONSIZE = 0xf;
static const ShortInt DEFAULT_POPUPINDICATORWIDTH = 0xe;
static const ShortInt MIN_POPUPWINDOWSIZE = 0x46;
#define TOOLBAR_SECTION L"UnDockedAdvToolBars"
static const ShortInt SCROLLER_SIZE = 0x20;
static const ShortInt DEFAULT_PAGERCAPTIONHEIGHT = 0x1b;
static const ShortInt DEFAULT_TABHEIGHT = 0x1a;
static const ShortInt ADVPAGE_OFFSET = 0x4;
static const ShortInt MIN_SPACING = 0x3;
static const ShortInt MDIBTNSIZE = 0x12;
static const ShortInt SCROLLBTN_WIDTH = 0xc;
static const ShortInt TOOLBAR_ROWS = 0x3;
static const ShortInt TABGROUP_ALPHATOP = 0x5;
static const Byte TABGROUP_ALPHABOTTOM = 0x82;
static const ShortInt MAJ_VER = 0x5;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;
extern PACKAGE System::Word WM_TBCOMPACTWINHIDE;
extern PACKAGE System::Word WM_TBSETAEROVISTA;
extern PACKAGE unsigned SHORTCUT_DELAY;
extern PACKAGE bool CANCAPTURE;
extern PACKAGE void __fastcall DrawVerticalText(Graphics::TCanvas* Canvas, System::UnicodeString Text, const Types::TPoint &TextP);
extern PACKAGE unsigned __fastcall ColorToARGB(Graphics::TColor Color);
extern PACKAGE void __fastcall DrawGDIPArc(Advgdip::TGPGraphics* graphics, Advgdip::TGPPen* Pen, int X, int Y, int Width, int Height, float StartAngle, float SweepAngle, bool closed = true);

}	/* namespace Advtoolbar */
using namespace Advtoolbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtoolbarHPP
