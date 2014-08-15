// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmenus.pas' rev: 21.00

#ifndef AdvmenusHPP
#define AdvmenusHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Actnman.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmenus
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TDrawStyle { dsNormal, dsTile, dsStretch };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TGradientType { gtLeft, gtRight, gtBoth };
#pragma option pop

#pragma option push -b-
enum TBarPart { bpGradient, bpPicture, bpBackPicture, bpCaption, bpBorder, bpSplitter };
#pragma option pop

typedef Set<TBarPart, bpGradient, bpSplitter>  TBarParts;

#pragma option push -b-
enum TSideBarPosition { spLeft, spRight };
#pragma option pop

#pragma option push -b-
enum TSideBarVisibleIn { viFirstVisible, viFirstLevel, viAnyLevel };
#pragma option pop

#pragma option push -b-
enum TDirection { dDownToUp, dUpToDown };
#pragma option pop

#pragma option push -b-
enum TSeparatorStyle { ssNormal, ssShortLine, ssCaption };
#pragma option pop

#pragma option push -b-
enum TBackgroundPosition { bpTopLeft, bpTopRight, bpBottomLeft, bpBottomRight, bpTopCenter, bpBottomCenter, bpTiled, bpStretched, bpCenter, bpXY };
#pragma option pop

#pragma option push -b-
enum TGlyphPosition { gpLeft, gpRight };
#pragma option pop

typedef void * IntPtr;

__interface IAdvMenu;
typedef System::DelphiInterface<IAdvMenu> _di_IAdvMenu;
class DELPHICLASS TCustomAdvMenuStyler;
__interface IAdvMenu  : public System::IInterface 
{
	
public:
	virtual void __fastcall UpdateItems(void) = 0 ;
	virtual Menus::TMenu* __fastcall GetSelf(void) = 0 ;
	virtual TCustomAdvMenuStyler* __fastcall GetMenuStyler(void) = 0 ;
	virtual TCustomAdvMenuStyler* __fastcall GetCurrentMenuStyler(void) = 0 ;
	virtual void __fastcall SetMenuStyler(const TCustomAdvMenuStyler* Value) = 0 ;
	virtual System::Byte __fastcall GetOpacity(void) = 0 ;
	virtual void __fastcall SetOpacity(const System::Byte Value) = 0 ;
	virtual bool __fastcall GetShowNotes(void) = 0 ;
	virtual void __fastcall SetShowNotes(const bool Value) = 0 ;
	virtual bool __fastcall GetIntlKeybShortCuts(void) = 0 ;
	virtual void __fastcall SetIntlKeybShortCuts(const bool Value) = 0 ;
	__property Menus::TMenu* Self = {read=GetSelf};
	__property TCustomAdvMenuStyler* CurrentMenuStyler = {read=GetCurrentMenuStyler};
	__property TCustomAdvMenuStyler* MenuStyler = {read=GetMenuStyler, write=SetMenuStyler};
	__property System::Byte Opacity = {read=GetOpacity, write=SetOpacity};
	__property bool ShowNotes = {read=GetShowNotes, write=SetShowNotes};
	__property bool IntlKeybShortCuts = {read=GetIntlKeybShortCuts, write=SetIntlKeybShortCuts};
};

class DELPHICLASS TButtonAppearance;
class PASCALIMPLEMENTATION TButtonAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FHoverColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FColor;
	Graphics::TColor FHoverColorTo;
	Graphics::TColor FDownColorTo;
	Graphics::TColor FDownColor;
	Graphics::TColor FDownBorderColor;
	Graphics::TColor FBorderColor;
	Graphics::TColor FHoverBorderColor;
	TGradientDirection FGradientDirection;
	Graphics::TFont* FCaptionFont;
	TGlyphPosition FGlyphPosition;
	bool FUseSystemFont;
	void __fastcall Change(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetDownColor(const Graphics::TColor Value);
	void __fastcall SetDownColorTo(const Graphics::TColor Value);
	void __fastcall SetHoverColor(const Graphics::TColor Value);
	void __fastcall SetHoverColorTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetGlyphPosition(const TGlyphPosition Value);
	void __fastcall SetUseSystemFont(const bool Value);
	
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
	__property Graphics::TColor DownColor = {read=FDownColor, write=SetDownColor, default=11899525};
	__property Graphics::TColor DownColorTo = {read=FDownColorTo, write=SetDownColorTo, default=536870911};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=SetHoverColor, default=13811126};
	__property Graphics::TColor HoverColorTo = {read=FHoverColorTo, write=SetHoverColorTo, default=536870911};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor DownBorderColor = {read=FDownBorderColor, write=FDownBorderColor, default=6956042};
	__property Graphics::TColor HoverBorderColor = {read=FHoverBorderColor, write=FHoverBorderColor, default=6956042};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property bool UseSystemFont = {read=FUseSystemFont, write=SetUseSystemFont, default=1};
};


class DELPHICLASS TSeparator;
class DELPHICLASS TBackground;
class DELPHICLASS TIconBar;
class DELPHICLASS TMenuGlyphs;
class DELPHICLASS TRootItem;
class DELPHICLASS TSelectedItem;
class DELPHICLASS TSideBar;
class PASCALIMPLEMENTATION TCustomAdvMenuStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FUseSystemFont;
	TSeparator* FSeparator;
	TBackground* FBackground;
	Graphics::TFont* FFont;
	TIconBar* FIconBar;
	TMenuGlyphs* FGlyphs;
	TRootItem* FRootItem;
	TSelectedItem* FSelectedItem;
	TSideBar* FSideBar;
	Graphics::TColor FMenuBorderColor;
	bool FMenuBarUpdating;
	Menus::TMenu* FMenu;
	Graphics::TBitmap* FBackgroundBitmap;
	Graphics::TFont* FNotesFont;
	Advgdip::TAntiAlias FAntiAlias;
	TButtonAppearance* FButtonAppearance;
	void __fastcall SetBackground(const TBackground* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetGlyphs(const TMenuGlyphs* Value);
	void __fastcall SetIconBar(const TIconBar* Value);
	void __fastcall SetRootItem(const TRootItem* Value);
	void __fastcall SetSelectedItem(const TSelectedItem* Value);
	void __fastcall SetSeparator(const TSeparator* Value);
	void __fastcall SetSideBar(const TSideBar* Value);
	void __fastcall SetUseSystemFont(const bool Value);
	void __fastcall SetMenu(const Menus::TMenu* Value);
	void __fastcall SetNotesFont(const Graphics::TFont* Value);
	void __fastcall SetAntiAlias(const Advgdip::TAntiAlias Value);
	void __fastcall SetTButtonAppearance(const TButtonAppearance* Value);
	
protected:
	__property bool MenuBarUpdating = {read=FMenuBarUpdating, write=FMenuBarUpdating, default=0};
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	
public:
	__fastcall virtual TCustomAdvMenuStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomAdvMenuStyler(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Menus::TMenu* Menu = {read=FMenu, write=SetMenu};
	__property Advgdip::TAntiAlias AntiAlias = {read=FAntiAlias, write=SetAntiAlias, nodefault};
	__property TBackground* Background = {read=FBackground, write=SetBackground};
	__property TIconBar* IconBar = {read=FIconBar, write=SetIconBar};
	__property TSelectedItem* SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	__property TRootItem* RootItem = {read=FRootItem, write=SetRootItem};
	__property TMenuGlyphs* Glyphs = {read=FGlyphs, write=SetGlyphs};
	__property TSideBar* SideBar = {read=FSideBar, write=SetSideBar};
	__property TSeparator* Separator = {read=FSeparator, write=SetSeparator};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* NotesFont = {read=FNotesFont, write=SetNotesFont};
	__property bool UseSystemFont = {read=FUseSystemFont, write=SetUseSystemFont, default=1};
	__property Graphics::TColor MenuBorderColor = {read=FMenuBorderColor, write=FMenuBorderColor, default=8158356};
	__property TButtonAppearance* ButtonAppearance = {read=FButtonAppearance, write=SetTButtonAppearance};
};


class DELPHICLASS TAdvMenuStyler;
class PASCALIMPLEMENTATION TAdvMenuStyler : public TCustomAdvMenuStyler
{
	typedef TCustomAdvMenuStyler inherited;
	
__published:
	__property AntiAlias;
	__property Background;
	__property IconBar;
	__property SelectedItem;
	__property RootItem;
	__property Glyphs;
	__property SideBar;
	__property Separator;
	__property Font;
	__property NotesFont;
	__property UseSystemFont = {default=1};
	__property MenuBorderColor = {default=8158356};
	__property ButtonAppearance;
public:
	/* TCustomAdvMenuStyler.Create */ inline __fastcall virtual TAdvMenuStyler(Classes::TComponent* AOwner) : TCustomAdvMenuStyler(AOwner) { }
	/* TCustomAdvMenuStyler.Destroy */ inline __fastcall virtual ~TAdvMenuStyler(void) { }
	
};


class DELPHICLASS TGradientBar;
class PASCALIMPLEMENTATION TGradientBar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TGradientDirection FGradientDirection;
	Menus::TMenu* FMenu;
	Graphics::TColor __fastcall GetGradientColor(const int Index);
	void __fastcall SetGradientColor(const int Index, const Graphics::TColor Value);
	void __fastcall SetGradientDirection(const TGradientDirection Value);
	
protected:
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	
public:
	__fastcall TGradientBar(Menus::TMenu* AMenu);
	__fastcall virtual ~TGradientBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Graphics::TColor Color = {read=GetGradientColor, write=SetGradientColor, index=0, default=14204335};
	__property Graphics::TColor ColorTo = {read=GetGradientColor, write=SetGradientColor, index=1, default=536870911};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetGradientDirection, default=0};
	__property Menus::TMenu* Menu = {read=FMenu};
};


class PASCALIMPLEMENTATION TIconBar : public TGradientBar
{
	typedef TGradientBar inherited;
	
private:
	Graphics::TColor FRadioBorder;
	Graphics::TColor FCheckBorder;
	Graphics::TColor FRadioColor;
	Graphics::TColor FRadioColorTo;
	Graphics::TColor FCheckColor;
	Graphics::TColor FCheckColorTo;
	TGradientDirection FCheckGradientDirection;
	TGradientDirection FRadioGradientDirection;
	bool FDrawn;
	int FSize;
	Graphics::TColor FSeparatorColor;
	Graphics::TColor __fastcall GetCheckColor(const int Index);
	void __fastcall SetCheckColor(const int Index, const Graphics::TColor Value);
	Graphics::TColor __fastcall GetRadioColor(const int Index);
	void __fastcall SetRadioColor(const int Index, const Graphics::TColor Value);
	void __fastcall SetSize(const int Value);
	
protected:
	__property bool Drawn = {read=FDrawn, write=FDrawn, nodefault};
	
public:
	__fastcall TIconBar(Menus::TMenu* AMenu);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Color = {index=0, default=16775673};
	__property ColorTo = {index=1, default=12296353};
	__property GradientDirection = {default=1};
	__property Graphics::TColor CheckColor = {read=GetCheckColor, write=SetCheckColor, index=0, default=7323903};
	__property Graphics::TColor CheckColorTo = {read=GetCheckColor, write=SetCheckColor, index=1, default=536870911};
	__property Graphics::TColor CheckBorder = {read=FCheckBorder, write=FCheckBorder, default=7293771};
	__property TGradientDirection CheckGradientDirection = {read=FCheckGradientDirection, write=FCheckGradientDirection, default=0};
	__property Graphics::TColor RadioColor = {read=GetRadioColor, write=SetRadioColor, index=0, default=7323903};
	__property Graphics::TColor RadioColorTo = {read=GetRadioColor, write=SetRadioColor, index=1, default=536870911};
	__property Graphics::TColor RadioBorder = {read=FRadioBorder, write=FRadioBorder, default=7293771};
	__property TGradientDirection RadioGradientDirection = {read=FRadioGradientDirection, write=FRadioGradientDirection, default=0};
	__property Graphics::TColor SeparatorColor = {read=FSeparatorColor, write=FSeparatorColor, default=536870911};
	__property int Size = {read=FSize, write=SetSize, default=24};
public:
	/* TGradientBar.Destroy */ inline __fastcall virtual ~TIconBar(void) { }
	
};


class PASCALIMPLEMENTATION TSelectedItem : public TGradientBar
{
	typedef TGradientBar inherited;
	
private:
	Graphics::TColor FRadioBorder;
	Graphics::TColor FCheckBorder;
	Graphics::TColor FRadioColor;
	Graphics::TColor FRadioColorTo;
	Graphics::TColor FCheckColor;
	Graphics::TColor FCheckColorTo;
	TGradientDirection FCheckGradientDirection;
	TGradientDirection FRadioGradientDirection;
	Graphics::TColor FBorderColor;
	Graphics::TFont* FFont;
	bool FUseSystemFont;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TFont* FNotesFont;
	Graphics::TColor __fastcall GetCheckColor(const int Index);
	void __fastcall SetCheckColor(const int Index, const Graphics::TColor Value);
	Graphics::TColor __fastcall GetRadioColor(const int Index);
	void __fastcall SetRadioColor(const int Index, const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetNotesFont(const Graphics::TFont* Value);
	void __fastcall SetUseSystemFont(const bool Value);
	
public:
	__fastcall TSelectedItem(Menus::TMenu* AMenu);
	__fastcall virtual ~TSelectedItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Color = {index=0, default=12775167};
	__property ColorTo = {index=1, default=536870911};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=FColorMirror, default=536870911};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=FColorMirrorTo, default=536870911};
	__property GradientDirection = {default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, default=7293771};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* NotesFont = {read=FNotesFont, write=SetNotesFont};
	__property bool UseSystemFont = {read=FUseSystemFont, write=SetUseSystemFont, default=1};
	__property Graphics::TColor CheckColor = {read=GetCheckColor, write=SetCheckColor, index=0, default=4096254};
	__property Graphics::TColor CheckColorTo = {read=GetCheckColor, write=SetCheckColor, index=1, default=536870911};
	__property Graphics::TColor CheckBorder = {read=FCheckBorder, write=FCheckBorder, default=7293771};
	__property TGradientDirection CheckGradientDirection = {read=FCheckGradientDirection, write=FCheckGradientDirection, default=0};
	__property Graphics::TColor RadioColor = {read=GetRadioColor, write=SetRadioColor, index=0, default=4096254};
	__property Graphics::TColor RadioColorTo = {read=GetRadioColor, write=SetRadioColor, index=1, default=536870911};
	__property Graphics::TColor RadioBorder = {read=FRadioBorder, write=FRadioBorder, default=7293771};
	__property TGradientDirection RadioGradientDirection = {read=FRadioGradientDirection, write=FRadioGradientDirection, default=0};
};


class PASCALIMPLEMENTATION TRootItem : public TGradientBar
{
	typedef TGradientBar inherited;
	
private:
	Graphics::TFont* FFont;
	Graphics::TColor FSelectedBorderColor;
	Graphics::TColor FSelectedTextColor;
	bool FUseSystemFont;
	Graphics::TColor FHoverTextColor;
	Graphics::TColor FHoverBorderColor;
	Graphics::TColor FSelectedColor;
	Graphics::TColor FSelectedColorTo;
	Graphics::TColor FSelectedColorMirror;
	Graphics::TColor FSelectedColorMirrorTo;
	Graphics::TColor FHoverColor;
	Graphics::TColor FHoverColorTo;
	Graphics::TColor FHoverColorMirror;
	Graphics::TColor FHoverColorMirrorTo;
	TGradientDirection FHoverGradientDirection;
	TGradientDirection FSelectedGradientDirection;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetUseSystemFont(const bool Value);
	Graphics::TColor __fastcall GetSelectedColor(const int Index);
	void __fastcall SetSelectedColor(const int Index, const Graphics::TColor Value);
	Graphics::TColor __fastcall GetHoverColor(const int Index);
	void __fastcall SetHoverColor(const int Index, const Graphics::TColor Value);
	
public:
	__fastcall TRootItem(Menus::TMenu* AMenu);
	__fastcall virtual ~TRootItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Color = {index=0, default=15062999};
	__property ColorTo = {index=1, default=16249586};
	__property GradientDirection = {default=1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool UseSystemFont = {read=FUseSystemFont, write=SetUseSystemFont, default=1};
	__property Graphics::TColor SelectedColor = {read=GetSelectedColor, write=SetSelectedColor, index=0, default=15919336};
	__property Graphics::TColor SelectedColorTo = {read=GetSelectedColor, write=SetSelectedColor, index=1, default=13482169};
	__property Graphics::TColor SelectedColorMirror = {read=GetSelectedColor, write=SetSelectedColor, index=2, default=536870911};
	__property Graphics::TColor SelectedColorMirrorTo = {read=GetSelectedColor, write=SetSelectedColor, index=3, default=536870911};
	__property TGradientDirection SelectedGradientDirection = {read=FSelectedGradientDirection, write=FSelectedGradientDirection, default=0};
	__property Graphics::TColor SelectedBorderColor = {read=FSelectedBorderColor, write=FSelectedBorderColor, default=9731196};
	__property Graphics::TColor SelectedTextColor = {read=FSelectedTextColor, write=FSelectedTextColor, default=-16777208};
	__property Graphics::TColor HoverColor = {read=GetHoverColor, write=SetHoverColor, index=0, default=13629183};
	__property Graphics::TColor HoverColorTo = {read=GetHoverColor, write=SetHoverColor, index=1, default=10344703};
	__property Graphics::TColor HoverColorMirror = {read=GetHoverColor, write=SetHoverColor, index=2, default=536870911};
	__property Graphics::TColor HoverColorMirrorTo = {read=GetHoverColor, write=SetHoverColor, index=3, default=536870911};
	__property TGradientDirection HoverGradientDirection = {read=FHoverGradientDirection, write=FHoverGradientDirection, default=0};
	__property Graphics::TColor HoverBorderColor = {read=FHoverBorderColor, write=FHoverBorderColor, default=7293771};
	__property Graphics::TColor HoverTextColor = {read=FHoverTextColor, write=FHoverTextColor, default=-16777208};
};


class PASCALIMPLEMENTATION TMenuGlyphs : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TBitmap* FSubMenu;
	Graphics::TBitmap* FCheck;
	Graphics::TBitmap* FRadio;
	Menus::TMenu* FMenu;
	void __fastcall SetSubMenu(const Graphics::TBitmap* Value);
	void __fastcall SetCheck(const Graphics::TBitmap* Value);
	void __fastcall SetRadio(const Graphics::TBitmap* Value);
	
public:
	__fastcall TMenuGlyphs(Menus::TMenu* AMenu);
	__fastcall virtual ~TMenuGlyphs(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Menus::TMenu* Menu = {read=FMenu};
	
__published:
	__property Graphics::TBitmap* SubMenu = {read=FSubMenu, write=SetSubMenu};
	__property Graphics::TBitmap* Check = {read=FCheck, write=SetCheck};
	__property Graphics::TBitmap* Radio = {read=FRadio, write=SetRadio};
};


class DELPHICLASS TBarCaption;
class PASCALIMPLEMENTATION TBarCaption : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FCaption;
	Graphics::TFont* FFont;
	int FOffsetY;
	TDirection FDirection;
	Graphics::TColor FShadowColor;
	Graphics::TColor FHighlightColor;
	int FDepth;
	Classes::TAlignment FAlignment;
	Menus::TMenu* FMenu;
	
protected:
	void __fastcall SetFont(Graphics::TFont* Value);
	__property int OffsetY = {read=FOffsetY, write=FOffsetY, default=6};
	
public:
	__fastcall TBarCaption(Menus::TMenu* AMenu);
	__fastcall virtual ~TBarCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=FHighlightColor, default=536870911};
	__property Menus::TMenu* Menu = {read=FMenu};
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=FAlignment, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=FShadowColor, default=536870911};
	__property int Depth = {read=FDepth, write=FDepth, default=1};
	__property TDirection Direction = {read=FDirection, write=FDirection, default=0};
};


class PASCALIMPLEMENTATION TSideBar : public TBarCaption
{
	typedef TBarCaption inherited;
	
private:
	bool FVisible;
	TBackground* FBackground;
	TBackground* FImage;
	int FSplitterWidth;
	TSideBarPosition FPosition;
	int FSize;
	int FSplitterMargin;
	int FSplitterGradientWidth;
	TGradientType FSplitterGradientType;
	Graphics::TColor FBorderColor;
	Graphics::TColor FSplitterColor;
	Graphics::TColor FSplitterColorTo;
	TSideBarVisibleIn FVisibleIn;
	int FPopupHeight;
	Menus::TMenu* FMenu;
	TBackground* __fastcall GetImage(void);
	TBackground* __fastcall GetBackground(void);
	void __fastcall SetImage(const TBackground* Value);
	void __fastcall SetBackground(const TBackground* Value);
	void __fastcall SetVisible(bool Value);
	bool __fastcall GetVisible(void);
	
protected:
	__property int PopupHeight = {read=FPopupHeight, write=FPopupHeight, nodefault};
	__property TSideBarPosition Position = {read=FPosition, write=FPosition, default=0};
	
public:
	__fastcall TSideBar(Menus::TMenu* AMenu);
	__fastcall virtual ~TSideBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Menus::TMenu* Menu = {read=FMenu};
	
__published:
	__property bool Visible = {read=GetVisible, write=SetVisible, default=0};
	__property TSideBarVisibleIn VisibleIn = {read=FVisibleIn, write=FVisibleIn, default=0};
	__property TBackground* Image = {read=GetImage, write=SetImage};
	__property TBackground* Background = {read=GetBackground, write=SetBackground};
	__property int Size = {read=FSize, write=FSize, default=24};
	__property Graphics::TColor SplitterColor = {read=FSplitterColor, write=FSplitterColor, default=8421504};
	__property Graphics::TColor SplitterColorTo = {read=FSplitterColorTo, write=FSplitterColorTo, default=536870911};
	__property int SplitterWidth = {read=FSplitterWidth, write=FSplitterWidth, default=1};
	__property int SplitterMargin = {read=FSplitterMargin, write=FSplitterMargin, default=0};
	__property int SplitterGradientWidth = {read=FSplitterGradientWidth, write=FSplitterGradientWidth, default=0};
	__property TGradientType SplitterGradientType = {read=FSplitterGradientType, write=FSplitterGradientType, default=2};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, default=10591645};
};


class PASCALIMPLEMENTATION TBackground : public TGradientBar
{
	typedef TGradientBar inherited;
	
private:
	Graphics::TPicture* FImage;
	int FOffsetX;
	int FOffsetY;
	TBackgroundPosition FPosition;
	int FMarginX;
	int FMarginY;
	Graphics::TBitmap* FBitmap;
	Menus::TMenu* FMenu;
	Graphics::TPicture* __fastcall GetImage(void);
	Graphics::TBitmap* __fastcall GetBitmap(void);
	
protected:
	void __fastcall SetImage(Graphics::TPicture* Value);
	__property Graphics::TBitmap* Bitmap = {read=GetBitmap, write=FBitmap};
	
public:
	__fastcall TBackground(Menus::TMenu* AMenu);
	__fastcall virtual ~TBackground(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall CalcPicturePosition(const Types::TRect &ARect, int &X, int &Y);
	__property Menus::TMenu* Menu = {read=FMenu};
	
__published:
	__property Graphics::TPicture* Image = {read=GetImage, write=SetImage};
	__property TBackgroundPosition Position = {read=FPosition, write=FPosition, nodefault};
	__property int OffsetX = {read=FOffsetX, write=FOffsetX, default=0};
	__property int OffsetY = {read=FOffsetY, write=FOffsetY, default=0};
	__property int MarginX = {read=FMarginX, write=FMarginX, default=0};
	__property int MarginY = {read=FMarginY, write=FMarginY, default=0};
	__property Color = {index=0, default=16775933};
	__property ColorTo = {index=1, default=536870911};
	__property GradientDirection = {default=0};
};


class PASCALIMPLEMENTATION TSeparator : public TGradientBar
{
	typedef TGradientBar inherited;
	
private:
	TGradientType FGradientType;
	int FGradientWidth;
	int FMargin;
	int FWidth;
	Menus::TMenu* FMenu;
	
public:
	__fastcall TSeparator(Menus::TMenu* AMenu);
	__fastcall virtual ~TSeparator(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Menus::TMenu* Menu = {read=FMenu};
	
__published:
	__property Color = {index=0, default=9399662};
	__property ColorTo = {index=1, default=536870911};
	__property int Width = {read=FWidth, write=FWidth, default=1};
	__property TGradientType GradientType = {read=FGradientType, write=FGradientType, nodefault};
	__property int GradientWidth = {read=FGradientWidth, write=FGradientWidth, default=0};
	__property int Margin = {read=FMargin, write=FMargin, default=2};
};


class DELPHICLASS TAdvMainMenu;
class PASCALIMPLEMENTATION TAdvMainMenu : public Menus::TMainMenu
{
	typedef Menus::TMainMenu inherited;
	
private:
	TCustomAdvMenuStyler* FMenuStyler;
	TCustomAdvMenuStyler* FInternalMenuStyler;
	TCustomAdvMenuStyler* FCurrentMenuStyler;
	System::Byte FOpacity;
	bool FShowNotes;
	bool FMenuUpdating;
	int FUpdateRef;
	unsigned FOldWndHandle;
	void *FOldWndProcPtr;
	bool FDirectUpdate;
	Controls::TImageList* FDisabledImages;
	bool FIntlKeybShortCuts;
	TCustomAdvMenuStyler* __fastcall GetMenuStyler(void);
	TCustomAdvMenuStyler* __fastcall GetCurrentMenuStyler(void);
	void __fastcall SetMenuStyler(const TCustomAdvMenuStyler* Value);
	System::Byte __fastcall GetOpacity(void);
	void __fastcall SetOpacity(const System::Byte Value);
	bool __fastcall GetShowNotes(void);
	void __fastcall SetShowNotes(const bool Value);
	bool __fastcall GetIntlKeybShortCuts(void);
	void __fastcall SetIntlKeybShortCuts(const bool Value);
	void __fastcall DrawMDIFormIcon(Menus::TMenuItem* MI, const Types::TRect &MR);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	HIDESBASE int __stdcall _AddRef(void);
	HIDESBASE int __stdcall _Release(void);
	Menus::TMenu* __fastcall GetSelf(void);
	virtual void __fastcall MenuChanged(System::TObject* Sender, Menus::TMenuItem* Source, bool Rebuild);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall AllocMenuStyler(void);
	void __fastcall MenuFontChanged(System::TObject* Sender);
	void __fastcall ActivateMDIChild(System::TObject* Sender);
	__property System::Byte Opacity = {read=GetOpacity, write=SetOpacity, default=255};
	virtual int __fastcall GetVersionNr(void);
	__property unsigned OldWndHandle = {read=FOldWndHandle, write=FOldWndHandle, nodefault};
	__property void * OldWndProcPtr = {read=FOldWndProcPtr, write=FOldWndProcPtr};
	__property TCustomAdvMenuStyler* CurrentMenuStyler = {read=GetCurrentMenuStyler};
	
public:
	__fastcall virtual TAdvMainMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMainMenu(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	HIDESBASE void __fastcall Merge(Menus::TMainMenu* Menu);
	void __fastcall ExpandItemWidth(System::TObject* Sender, Graphics::TCanvas* ACanvas, int &Width, int &Height);
	void __fastcall AdvancedDrawItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	__property bool MenuUpdating = {read=FMenuUpdating, nodefault};
	__property bool DirectUpdate = {read=FDirectUpdate, write=FDirectUpdate, nodefault};
	void __fastcall Refresh(void);
	
__published:
	__property Controls::TImageList* DisabledImages = {read=FDisabledImages, write=FDisabledImages};
	__property TCustomAdvMenuStyler* MenuStyler = {read=GetMenuStyler, write=SetMenuStyler};
	__property OwnerDraw = {default=1};
	__property bool IntlKeybShortCuts = {read=GetIntlKeybShortCuts, write=SetIntlKeybShortCuts, default=0};
	__property bool ShowNotes = {read=GetShowNotes, write=SetShowNotes, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
private:
	void *__IAdvMenu;	/* IAdvMenu */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IInterface*(void) { return (IInterface*)&__IAdvMenu; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IAdvMenu()
	{
		_di_IAdvMenu intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IAdvMenu*(void) { return (IAdvMenu*)&__IAdvMenu; }
	#endif
	
};


class DELPHICLASS TAdvPopupMenu;
class PASCALIMPLEMENTATION TAdvPopupMenu : public Menus::TPopupMenu
{
	typedef Menus::TPopupMenu inherited;
	
private:
	TCustomAdvMenuStyler* FMenuStyler;
	TCustomAdvMenuStyler* FInternalMenuStyler;
	TCustomAdvMenuStyler* FCurrentMenuStyler;
	System::Byte FOpacity;
	bool FShowNotes;
	bool FMenuUpdating;
	int FUpdateRef;
	bool FDirectUpdate;
	Controls::TImageList* FDisabledImages;
	bool FIntlKeybShortCuts;
	TCustomAdvMenuStyler* __fastcall GetMenuStyler(void);
	TCustomAdvMenuStyler* __fastcall GetCurrentMenuStyler(void);
	void __fastcall SetMenuStyler(const TCustomAdvMenuStyler* Value);
	System::Byte __fastcall GetOpacity(void);
	void __fastcall SetOpacity(const System::Byte Value);
	bool __fastcall GetShowNotes(void);
	void __fastcall SetShowNotes(const bool Value);
	bool __fastcall GetIntlKeybShortCuts(void);
	void __fastcall SetIntlKeybShortCuts(const bool Value);
	void __fastcall AllocMenuStyler(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	HIDESBASE int __stdcall _AddRef(void);
	HIDESBASE int __stdcall _Release(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	Menus::TMenu* __fastcall GetSelf(void);
	virtual void __fastcall MenuChanged(System::TObject* Sender, Menus::TMenuItem* Source, bool Rebuild);
	__property System::Byte Opacity = {read=GetOpacity, write=SetOpacity, default=255};
	virtual int __fastcall GetVersionNr(void);
	__property TCustomAdvMenuStyler* CurrentMenuStyler = {read=GetCurrentMenuStyler};
	
public:
	__fastcall virtual TAdvPopupMenu(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPopupMenu(void);
	void __fastcall ExpandItemWidth(System::TObject* Sender, Graphics::TCanvas* ACanvas, int &Width, int &Height);
	void __fastcall AdvancedDrawItem(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Windows::TOwnerDrawState State);
	virtual void __fastcall Popup(int X, int Y)/* overload */;
	HIDESBASE virtual void __fastcall Popup(const Types::TPoint &P)/* overload */;
	void __fastcall PopupAtCursor(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property bool MenuUpdating = {read=FMenuUpdating, nodefault};
	__property bool DirectUpdate = {read=FDirectUpdate, write=FDirectUpdate, nodefault};
	
__published:
	__property Controls::TImageList* DisabledImages = {read=FDisabledImages, write=FDisabledImages};
	__property TCustomAdvMenuStyler* MenuStyler = {read=GetMenuStyler, write=SetMenuStyler};
	__property OwnerDraw = {default=1};
	__property bool IntlKeybShortCuts = {read=GetIntlKeybShortCuts, write=SetIntlKeybShortCuts, default=0};
	__property bool ShowNotes = {read=GetShowNotes, write=SetShowNotes, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
private:
	void *__IAdvMenu;	/* IAdvMenu */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IInterface*(void) { return (IInterface*)&__IAdvMenu; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator _di_IAdvMenu()
	{
		_di_IAdvMenu intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IAdvMenu*(void) { return (IAdvMenu*)&__IAdvMenu; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x3;
static const ShortInt BLD_VER = 0x1;
extern PACKAGE System::ResourceString _AdvResourceRadioItem;
#define Advmenus_AdvResourceRadioItem System::LoadResourceString(&Advmenus::_AdvResourceRadioItem)
extern PACKAGE System::ResourceString _AdvResourceCheckItem;
#define Advmenus_AdvResourceCheckItem System::LoadResourceString(&Advmenus::_AdvResourceCheckItem)
extern PACKAGE System::ResourceString _AdvResourceSubMenuItem;
#define Advmenus_AdvResourceSubMenuItem System::LoadResourceString(&Advmenus::_AdvResourceSubMenuItem)
extern PACKAGE System::ResourceString _AdvWinKeyString;
#define Advmenus_AdvWinKeyString System::LoadResourceString(&Advmenus::_AdvWinKeyString)
static const ShortInt MENUITEM_SPACING = 0x2;
static const ShortInt ItemTextOffset = 0x8;
static const ShortInt GlyphOffset = 0x6;
static const ShortInt MinItemHeight = 0x10;
static const ShortInt ItemHeightIncrement = 0x0;
static const ShortInt TriangleSize = 0x11;
static const ShortInt SystemImageWidth = 0x8;
static const int TriangleColor = 0;
static const Byte DefaultOpacity = 0xff;
static const bool DefaultFlat = true;
static const bool DefaultUseSystemFont = true;
static const int DefaultMenuBorderColor = 0x7c7c94;
static const int DefaultColor = 0xd8bdaf;
static const int DefaultColorTo = 536870911;
static const TGradientDirection DefaultMenuGradientDirection = (TGradientDirection)(0);
static const bool DefaultBarVisible = false;
static const TSideBarVisibleIn DefaultBarVisibleIn = (TSideBarVisibleIn)(0);
static const TSideBarPosition DefaultBarSide = (TSideBarPosition)(0);
static const ShortInt DefaultBarSize = 0x18;
static const int DefaultBarBorder = 0xa19d9d;
static const int DefaultBarSplitterColor = 8421504;
static const int DefaultBarSplitterColorTo = 536870911;
static const ShortInt DefaultBarSplitterWidth = 0x1;
static const ShortInt DefaultBarSplitterMargin = 0x0;
static const ShortInt DefaultBarSplitterGradientWidth = 0x0;
static const TGradientType DefaultBarSplitterGradientType = (TGradientType)(2);
static const int DefaultItemColor = 0xfffafd;
static const int DefaultItemColorTo = 536870911;
static const TGradientDirection DefaultItemGradientDirection = (TGradientDirection)(0);
static const int DefaultTextColor = -16777208;
static const int DefaultRootItemColor = 0xe5d7d7;
static const int DefaultRootItemColorTo = 0xf7f2f2;
static const TGradientDirection DefaultRootItemGradientDirection = (TGradientDirection)(1);
static const int DefaultRootTextColor = -16777208;
static const int DefaultRootSelectedColor = 0xf2e8e8;
static const int DefaultRootSelectedColorTo = 0xcdb8b9;
static const TGradientDirection DefaultRootSelectedGradientDirection = (TGradientDirection)(0);
static const int DefaultRootSelectedBorder = 0x947c7c;
static const int DefaultRootSelectedTextColor = -16777208;
static const int DefaultHoverColor = 0xcff6ff;
static const int DefaultHoverColorTo = 0x9dd8ff;
static const TGradientDirection DefaultHoverGradientDirection = (TGradientDirection)(0);
static const int DefaultHoverBorder = 0x6f4b4b;
static const int DefaultHoverTextColor = -16777208;
static const int DefaultSelectedColor = 0xc2eeff;
static const int DefaultSelectedColorTo = 536870911;
static const TGradientDirection DefaultSelectedGradientDirection = (TGradientDirection)(0);
static const int DefaultSelectedBorder = 0x6f4b4b;
static const int DefaultSelectedTextColor = -16777208;
static const int DefaultSelectedCheckColor = 0x3e80fe;
static const int DefaultSelectedCheckColorTo = 536870911;
static const int DefaultSelectedCheckBorder = 0x6f4b4b;
static const TGradientDirection DefaultSelectedCheckGradientDirection = (TGradientDirection)(0);
static const int DefaultSelectedRadioColor = 0x3e80fe;
static const int DefaultSelectedRadioColorTo = 536870911;
static const int DefaultSelectedRadioBorder = 0x6f4b4b;
static const TGradientDirection DefaultSelectedRadioGradientDirection = (TGradientDirection)(0);
static const ShortInt DefaultIconBarSize = 0x18;
static const ShortInt MinIconBarSize = 0x10;
static const int DefaultIconBarColor = 0xfff9f9;
static const int DefaultIconBarColorTo = 0xbba0a1;
static const TGradientDirection DefaultIconBarGradientDirection = (TGradientDirection)(1);
static const int DefaultCheckColor = 0x6fc0ff;
static const int DefaultCheckColorTo = 536870911;
static const int DefaultCheckBorder = 0x6f4b4b;
static const TGradientDirection DefaultCheckGradientDirection = (TGradientDirection)(0);
static const int DefaultRadioColor = 0x6fc0ff;
static const int DefaultRadioColorTo = 536870911;
static const int DefaultRadioBorder = 0x6f4b4b;
static const TGradientDirection DefaultRadioGradientDirection = (TGradientDirection)(0);
static const ShortInt DefaultBarCaptionOffsetY = 0x6;
static const Classes::TAlignment DefaultBarCaptionAlignment = (Classes::TAlignment)(0);
static const TDirection DefaultBarCaptionDirection = (TDirection)(0);
static const int DefaultBarCaptionShadowColor = 536870911;
static const int DefaultBarCaptionHighlightColor = 536870911;
static const ShortInt DefaultBarCaptionDepth = 0x1;
static const TBackgroundPosition DefaultBarBitmapPosition = (TBackgroundPosition)(8);
static const bool DefaultBarBitmapTransparent = true;
static const TDrawStyle DefaultBarBackBitmapDrawStyle = (TDrawStyle)(0);
static const TBackgroundPosition DefaultBarBackBitmapPosition = (TBackgroundPosition)(0);
static const bool DefaultBarBackBitmapTransparent = false;
static const ShortInt DefaultSeparatorMargin = 0x2;
static const ShortInt DefaultSeparatorWidth = 0x1;
static const int DefaultSeparatorColor = 0x8f6d6e;
static const int DefaultSeparatorColorTo = 536870911;
static const TGradientDirection DefaultSeparatorGradientDirection = (TGradientDirection)(1);
static const TGradientType DefaultSeparatorGradientType = (TGradientType)(2);
static const ShortInt DefaultSeparatorGradientWidth = 0x0;
extern PACKAGE void __fastcall MeasureItem(Menus::TMenuItem* MenuItem, Graphics::TCanvas* ACanvas, int &Width, int &Height, bool SideBarVisible = false);
extern PACKAGE void __fastcall DrawMenuItemBackground(Menus::TMenuItem* MenuItem, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Windows::TOwnerDrawState State, bool SideBarVisible = false);
extern PACKAGE void __fastcall DrawMenuItemText(Menus::TMenuItem* MenuItem, Graphics::TCanvas* ACanvas, const System::UnicodeString ACaption, Types::TRect &Rect, Windows::TOwnerDrawState State, int Flags);
extern PACKAGE void __fastcall DrawMenuItem(_di_IAdvMenu AdvMenu, Menus::TMenuItem* MenuItem, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Windows::TOwnerDrawState State);
extern PACKAGE void __fastcall DrawMenuItemEx(_di_IAdvMenu AdvMenu, Menus::TMenuItem* MenuItem, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Windows::TOwnerDrawState State);
extern PACKAGE void __fastcall DrawLineItem(_di_IAdvMenu AdvMenu, Menus::TMenuItem* MenuItem, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Windows::TOwnerDrawState State);
extern PACKAGE void __fastcall DrawFadeLine(Graphics::TCanvas* ACanvas, const Types::TRect &AClipRect, const Types::TRect &ALineRect, Graphics::TColor AColor, int AGradientWidth, bool AClip);
extern PACKAGE void __fastcall DrawBarCaption(_di_IAdvMenu AdvMenu, Graphics::TCanvas* ACanvas, const Types::TRect &AClipRect);
extern PACKAGE void __fastcall DrawGradient(Graphics::TBitmap* ABitmap, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Graphics::TColor ColorFrom, Graphics::TColor ColorTo, TGradientDirection Direction);
extern PACKAGE void __fastcall DrawGradientClipped(Graphics::TBitmap* ABitmap, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, const Types::TRect &AClipRect, Graphics::TColor ColorFrom, Graphics::TColor ColorTo, TGradientDirection Direction);
extern PACKAGE void __fastcall DrawFramedGradient(Graphics::TBitmap* ABitmap, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Graphics::TColor ColorFrom, Graphics::TColor ColorTo, TGradientDirection Direction, Graphics::TColor BorderColor, bool Fill = true);
extern PACKAGE void __fastcall DrawFramedVistaGradient(Graphics::TBitmap* ABitmap, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Graphics::TColor ColorFrom, Graphics::TColor ColorTo, Graphics::TColor ColorMirrorFrom, Graphics::TColor ColorMirrorTo, TGradientDirection Direction, Graphics::TColor BorderColor, bool Fill = true);
extern PACKAGE void __fastcall DrawGradientEx(Graphics::TBitmap* ABitmap, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, Graphics::TColor ColorFrom, Graphics::TColor ColorTo, TGradientDirection Direction, TGradientType GradientType, int GradientWidth, int Margin);
extern PACKAGE void __fastcall DrawBarBorder(_di_IAdvMenu AdvMenu, Graphics::TCanvas* ACanvas, const Types::TRect &ARect);
extern PACKAGE void __fastcall DrawBarSplitter(_di_IAdvMenu AdvMenu, Graphics::TCanvas* ACanvas, const Types::TRect &ARect);
extern PACKAGE void __fastcall DrawImage(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, TBackground* AImage, bool BackGradient = true);
extern PACKAGE Menus::TMenu* __fastcall GetParentMenuEx(Menus::TMenuItem* MenuItem);
extern PACKAGE void __fastcall SetMenuItemEvents(Menus::TMenu* Menu, Menus::TMenuItem* MenuItem, Menus::TMenuMeasureItemEvent ExpandItemWidth, Menus::TAdvancedMenuDrawItemEvent AdvancedDrawItem, bool Recursive, bool AllowOwnerDrawn = true);
extern PACKAGE void __fastcall SetMenuOpacity(Menus::TMenuItem* MenuItem, Graphics::TCanvas* Canvas)/* overload */;
extern PACKAGE void __fastcall SetMenuOpacity(_di_IAdvMenu AdvMenu, const unsigned WindowHandle, const System::Byte Opacity)/* overload */;
extern PACKAGE void __fastcall DrawMenuWindowBorder(Menus::TMenuItem* MenuItem, Graphics::TCanvas* Canvas)/* overload */;
extern PACKAGE void __fastcall RefreshMenu(_di_IAdvMenu AdvMenu, const bool BarChanged, const bool WidthChanged);
extern PACKAGE Menus::TMenuItem* __fastcall FirstVisibleItem(Menus::TMenuItem* MenuItem);
extern PACKAGE Menus::TMenuItem* __fastcall LastVisibleItem(Menus::TMenuItem* MenuItem);
extern PACKAGE int __fastcall VisibleMenuIndex(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsInFirstVisibleMenu(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsInTopMenu(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsInFirstLevelMenu(Menus::TMenuItem* MenuItem);
extern PACKAGE int __fastcall GetMenuItemLevel(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsSideBarVisible(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsInTopPopupMenu(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsFirstSubMenuItem(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsInTopMainMenu(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsAfterMenuBreak(Menus::TMenuItem* MenuItem);
extern PACKAGE bool __fastcall IsRightAligned(Menus::TMenuItem* MenuItem, unsigned MenuWnd);
extern PACKAGE bool __fastcall IsRightmost(Menus::TMenuItem* MenuItem);
extern PACKAGE _di_IAdvMenu __fastcall GetAdvMenuIntf(Menus::TMenu* AMenu);
extern PACKAGE _di_IAdvMenu __fastcall GetMenuItemIntf(Menus::TMenuItem* AMenuItem);
extern PACKAGE System::UnicodeString __fastcall AdvShortCutToText(Classes::TShortCut ShortCut, bool Intl);
extern PACKAGE Types::TRect __fastcall GetMenuRect(Menus::TMenuItem* MenuItem, unsigned MenuWnd);
extern PACKAGE unsigned __fastcall GetMenuWnd(Menus::TMenu* Menu);
extern PACKAGE unsigned __fastcall GetMDIClientWnd(_di_IAdvMenu AdvMenu);
extern PACKAGE Forms::TForm* __fastcall FindForm(unsigned Window);
extern PACKAGE void __fastcall DisableMenuAnimation(void);
extern PACKAGE void __fastcall RestoreMenuAnimation(void);

}	/* namespace Advmenus */
using namespace Advmenus;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmenusHPP
