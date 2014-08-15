// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipmenu.pas' rev: 21.00

#ifndef GdipmenuHPP
#define GdipmenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advsmooththeme.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipmenu
{
//-- type declarations -------------------------------------------------------
__interface ITMSMegaMenu;
typedef System::DelphiInterface<ITMSMegaMenu> _di_ITMSMegaMenu;
class DELPHICLASS TGDIPMenuSectionItemAppearance;
class DELPHICLASS TGDIPMenuSection;
class DELPHICLASS TGDIPMenuTopLayerItem;
class DELPHICLASS TGDIPMenu;
__interface  INTERFACE_UUID("{05B08D30-11B9-48D6-92A0-83904F27F19A}") ITMSMegaMenu  : public System::IInterface 
{
	
public:
	virtual Gdippicturecontainer::TGDIPPictureContainer* __fastcall GetPictureContainer(void) = 0 ;
	virtual Imglist::TCustomImageList* __fastcall GetImageList(void) = 0 ;
	virtual TGDIPMenuSectionItemAppearance* __fastcall GetDefaultItemAppearance(void) = 0 ;
	virtual TGDIPMenuSection* __fastcall GetDefaultSection(void) = 0 ;
	virtual TGDIPMenuTopLayerItem* __fastcall GetDefaultTopLayerItem(void) = 0 ;
	virtual bool __fastcall HasMultipleMenus(void) = 0 ;
	virtual TGDIPMenu* __fastcall GetNextMenu(TGDIPMenu* Menu) = 0 ;
	virtual TGDIPMenu* __fastcall GetPreviousMenu(TGDIPMenu* Menu) = 0 ;
	virtual TGDIPMenu* __fastcall GetFirstMenu(void) = 0 ;
};

#pragma option push -b-
enum TGDIPMenuLocation { mlTopLeft, mlTopCenter, mlTopRight, mlCenterLeft, mlCenterCenter, mlCenterRight, mlBottomLeft, mlBottomCenter, mlBottomRight, mlCustom };
#pragma option pop

#pragma option push -b-
enum TGDIPMenuDropDownLocation { ddTopLeft, ddTopCenter, ddTopRight, ddLeftCenterTop, ddLeftCenterCenter, ddLeftCenterBottom, ddRightCenterTop, ddRightCenterCenter, ddRightCenterBottom, ddBottomLeft, ddBottomCenter, ddBottomRight, ddCustom };
#pragma option pop

class DELPHICLASS TGDIPMenuHTMLText;
class PASCALIMPLEMENTATION TGDIPMenuHTMLText : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FDisableRepaint;
	TGDIPMenu* FOwner;
	Graphics::TColor FURLColor;
	int FShadowOffset;
	System::UnicodeString FText;
	Graphics::TColor FShadowColor;
	Classes::TNotifyEvent FOnChange;
	int FTop;
	int FLeft;
	void __fastcall SetLeft(const int Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall TGDIPMenuHTMLText(TGDIPMenu* AOwner);
	__fastcall virtual ~TGDIPMenuHTMLText(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=5};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TGDIPMenuMargin;
class PASCALIMPLEMENTATION TGDIPMenuMargin : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TGDIPMenu* FOwner;
	int FRight;
	int FBottom;
	int FTop;
	int FLeft;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetBottom(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetRight(const int Value);
	void __fastcall SetTop(const int Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TGDIPMenuMargin(TGDIPMenu* AOwner);
	__fastcall virtual ~TGDIPMenuMargin(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Bottom = {read=FBottom, write=SetBottom, default=0};
	__property int Right = {read=FRight, write=SetRight, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION TGDIPMenuTopLayerItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Advgdip::TGPRectF FTopLayerRect;
	TGDIPMenu* FOwner;
	Controls::TAlign FAlign;
	int FWidth;
	bool FVisible;
	Gdipfill::TGDIPFill* FFill;
	int FTop;
	int FHeight;
	int FLeft;
	System::UnicodeString FHTMLText;
	TGDIPMenuLocation FHTMLTextLocation;
	int FHTMLTextTop;
	int FHTMLTextLeft;
	Graphics::TFont* FHTMLTextFont;
	void __fastcall SetAlign(const Controls::TAlign Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetHTMLLocation(const TGDIPMenuLocation Value);
	void __fastcall SetHTMLText(const System::UnicodeString Value);
	void __fastcall SetHTMLTextLeft(const int Value);
	void __fastcall SetHTMLTextTop(const int Value);
	void __fastcall SetHTMLTextFont(const Graphics::TFont* Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall HTMLTextChanged(System::TObject* Sender);
	void __fastcall HTMLFontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, TGDIPMenuHTMLText* Detailtxt);
	
public:
	__fastcall virtual TGDIPMenuTopLayerItem(Classes::TCollection* Collection);
	__fastcall virtual ~TGDIPMenuTopLayerItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	Advgdip::TGPRectF __fastcall GetTopLayerRect(void);
	void __fastcall SaveToFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	void __fastcall LoadFromFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Controls::TAlign Align = {read=FAlign, write=SetAlign, default=6};
	__property int Width = {read=FWidth, write=SetWidth, default=100};
	__property int Height = {read=FHeight, write=SetHeight, default=100};
	__property System::UnicodeString HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property TGDIPMenuLocation HTMLTextLocation = {read=FHTMLTextLocation, write=SetHTMLLocation, default=4};
	__property int HTMLTextLeft = {read=FHTMLTextLeft, write=SetHTMLTextLeft, default=0};
	__property int HTMLTextTop = {read=FHTMLTextTop, write=SetHTMLTextTop, default=0};
	__property Graphics::TFont* HTMLTextFont = {read=FHTMLTextFont, write=SetHTMLTextFont};
};


class DELPHICLASS TGDIPMenuTopLayerItems;
class PASCALIMPLEMENTATION TGDIPMenuTopLayerItems : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TGDIPMenuTopLayerItem* operator[](int Index) { return Items[Index]; }
	
private:
	TGDIPMenu* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TGDIPMenuTopLayerItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TGDIPMenuTopLayerItem* Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TGDIPMenuTopLayerItems(Controls::TWinControl* AOwner, TGDIPMenu* Menu);
	__property TGDIPMenuTopLayerItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TGDIPMenuTopLayerItem* __fastcall Add(void);
	HIDESBASE TGDIPMenuTopLayerItem* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGDIPMenuTopLayerItems(void) { }
	
};


#pragma option push -b-
enum TGDIPMenuSectionItemType { itNormal, itHeader, itSeparator, itBreak, itLineSeparator, itLineBreak };
#pragma option pop

#pragma option push -b-
enum TGDIPMenuSectionControlType { ctNone, ctControl, ctCheckBox, ctRadioButton, ctEdit };
#pragma option pop

class PASCALIMPLEMENTATION TGDIPMenuSectionItemAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TGDIPMenu* FOwner;
	Graphics::TFont* FFontDisabled;
	Graphics::TFont* FFontSelected;
	Gdipfill::TGDIPFill* FFillDisabled;
	Gdipfill::TGDIPFill* FFillSelected;
	Graphics::TFont* FFontHover;
	Gdipfill::TGDIPFill* FFillHover;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	int FBreakSize;
	Gdipfill::TGDIPFill* FBreakFill;
	int FSeparatorSize;
	Gdipfill::TGDIPFill* FSeparatorFill;
	Gdipfill::TGDIPFill* FFill;
	Graphics::TColor FURLColor;
	int FShadowOffset;
	Graphics::TColor FShadowColor;
	Graphics::TFont* FDetailFont;
	bool FAllowSelection;
	Graphics::TFont* FShortCutFont;
	void __fastcall SetFillDisabled(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFillHover(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFillSelected(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFontDisabled(const Graphics::TFont* Value);
	void __fastcall SetFontHover(const Graphics::TFont* Value);
	void __fastcall SetFontSelected(const Graphics::TFont* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetBreakFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetBreakWidth(const int Value);
	void __fastcall SetSeparatorFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSeparatorWidth(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetDetailFont(const Graphics::TFont* Value);
	void __fastcall SetAllowSelection(const bool Value);
	void __fastcall SetShortCutFont(const Graphics::TFont* Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall TGDIPMenuSectionItemAppearance(TGDIPMenu* AOwner);
	__fastcall virtual ~TGDIPMenuSectionItemAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SaveToFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	void __fastcall LoadFromFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	
__published:
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=5};
	__property Gdipfill::TGDIPFill* SeparatorFill = {read=FSeparatorFill, write=SetSeparatorFill};
	__property Gdipfill::TGDIPFill* BreakFill = {read=FBreakFill, write=SetBreakFill};
	__property int SeparatorSize = {read=FSeparatorSize, write=SetSeparatorWidth, default=2};
	__property int BreakSize = {read=FBreakSize, write=SetBreakWidth, default=2};
	__property Gdipfill::TGDIPFill* FillSelected = {read=FFillSelected, write=SetFillSelected};
	__property Gdipfill::TGDIPFill* FillDisabled = {read=FFillDisabled, write=SetFillDisabled};
	__property Gdipfill::TGDIPFill* FillHover = {read=FFillHover, write=SetFillHover};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Graphics::TFont* FontSelected = {read=FFontSelected, write=SetFontSelected};
	__property Graphics::TFont* FontDisabled = {read=FFontDisabled, write=SetFontDisabled};
	__property Graphics::TFont* FontHover = {read=FFontHover, write=SetFontHover};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* ShortCutFont = {read=FShortCutFont, write=SetShortCutFont};
	__property Graphics::TFont* DetailFont = {read=FDetailFont, write=SetDetailFont};
	__property bool AllowSelection = {read=FAllowSelection, write=SetAllowSelection, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TGDIPMenuSectionItem;
class PASCALIMPLEMENTATION TGDIPMenuSectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Stdctrls::TEdit* FEdit;
	int FCount;
	Advgdip::TGPRectF FItemRect;
	Advgdip::TGPRectF FFillRect;
	TGDIPMenu* FOwner;
	TGDIPMenuSection* FSectionOwner;
	TGDIPMenuSectionControlType FControlType;
	TGDIPMenuSectionItemType FItemType;
	System::UnicodeString FText;
	System::UnicodeString FData;
	bool FEnabled;
	Controls::TControl* FControl;
	System::UnicodeString FHoverText;
	TGDIPMenuLocation FHoverTextLocation;
	int FHoverTextTop;
	int FHoverTextLeft;
	bool FChecked;
	int FGroupIndex;
	int FControlIndent;
	System::UnicodeString FGraphicLeftName;
	System::UnicodeString FGraphicRightName;
	bool FEnableFill;
	int FSelectedTopLayerItem;
	int FHoverTopLayerItem;
	int FHeight;
	int FTextTop;
	int FTextLeft;
	TGDIPMenuLocation FTextLocation;
	System::TObject* FItemObject;
	int FTag;
	bool FHideOnSelection;
	Classes::TShortCut FShortCut;
	Classes::TNotifyEvent FOnClick;
	int FImageIndex;
	bool FVisible;
	void __fastcall SetControlType(const TGDIPMenuSectionControlType Value);
	void __fastcall SetItemType(const TGDIPMenuSectionItemType Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetData(const System::UnicodeString Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetHoverText(const System::UnicodeString Value);
	void __fastcall SetHoverTextLocation(const TGDIPMenuLocation Value);
	void __fastcall SetHoverTextLeft(const int Value);
	void __fastcall SetHoverTextTop(const int Value);
	void __fastcall SetControl(const Controls::TControl* Value);
	void __fastcall SetChecked(const bool Value);
	void __fastcall SetGroupIndex(const int Value);
	void __fastcall SetGraphicLeftName(const System::UnicodeString Value);
	void __fastcall SetGraphicRightName(const System::UnicodeString Value);
	void __fastcall SetControlIndent(const int Value);
	void __fastcall SetEnableFill(const bool Value);
	void __fastcall SetHoverTopLayerItem(const int Value);
	void __fastcall SetSelectedTopLayerItem(const int Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetTextLeft(const int Value);
	void __fastcall SetTextLocation(const TGDIPMenuLocation Value);
	void __fastcall SetTextTop(const int Value);
	void __fastcall SetItemObject(const System::TObject* Value);
	void __fastcall SetTag(const int Value);
	void __fastcall SetHideOnSelection(const bool Value);
	void __fastcall SetShortCut(const Classes::TShortCut Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall HTMLChanged(System::TObject* Sender);
	void __fastcall HoverTextChanged(System::TObject* Sender);
	void __fastcall ControlItemsChange(System::TObject* Sender);
	System::UnicodeString __fastcall GetAnchorAt(int X, int Y);
	
public:
	__fastcall virtual TGDIPMenuSectionItem(Classes::TCollection* Collection);
	__fastcall virtual ~TGDIPMenuSectionItem(void);
	void __fastcall EditChange(System::TObject* Sender);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &rd, const Advgdip::TGPRectF &r, const Advgdip::TGPRectF &rf, bool DoItemHoverFill, bool DoItemSelectedFill);
	__property Stdctrls::TEdit* Edit = {read=FEdit, write=FEdit};
	TGDIPMenuSection* __fastcall Section(void);
	TGDIPMenu* __fastcall Menu(void);
	Advgdip::TGPRectF __fastcall ItemRect(void);
	
__published:
	__property int Height = {read=FHeight, write=SetHeight, default=25};
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Checked = {read=FChecked, write=SetChecked, default=0};
	__property TGDIPMenuSectionItemType ItemType = {read=FItemType, write=SetItemType, default=0};
	__property TGDIPMenuSectionControlType ControlType = {read=FControlType, write=SetControlType, default=0};
	__property Controls::TControl* Control = {read=FControl, write=SetControl};
	__property int ControlIndent = {read=FControlIndent, write=SetControlIndent, default=20};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TGDIPMenuLocation TextLocation = {read=FTextLocation, write=SetTextLocation, default=3};
	__property int TextLeft = {read=FTextLeft, write=SetTextLeft, default=0};
	__property int TextTop = {read=FTextTop, write=SetTextTop, default=0};
	__property System::UnicodeString Data = {read=FData, write=SetData};
	__property bool EnableFill = {read=FEnableFill, write=SetEnableFill, default=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property System::UnicodeString DetailText = {read=FHoverText, write=SetHoverText};
	__property int HoverTopLayerItem = {read=FHoverTopLayerItem, write=SetHoverTopLayerItem, default=-1};
	__property int SelectedTopLayerItem = {read=FSelectedTopLayerItem, write=SetSelectedTopLayerItem, default=-1};
	__property TGDIPMenuLocation DetailTextLocation = {read=FHoverTextLocation, write=SetHoverTextLocation, default=4};
	__property int DetailTextLeft = {read=FHoverTextLeft, write=SetHoverTextLeft, default=0};
	__property int DetailTextTop = {read=FHoverTextTop, write=SetHoverTextTop, default=0};
	__property System::UnicodeString GraphicLeftName = {read=FGraphicLeftName, write=SetGraphicLeftName};
	__property System::UnicodeString GraphicRightName = {read=FGraphicRightName, write=SetGraphicRightName};
	__property int Tag = {read=FTag, write=SetTag, default=0};
	__property System::TObject* ItemObject = {read=FItemObject, write=SetItemObject};
	__property bool HideOnSelection = {read=FHideOnSelection, write=SetHideOnSelection, default=1};
	__property Classes::TShortCut ShortCut = {read=FShortCut, write=SetShortCut, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
};


class DELPHICLASS TGDIPMenuSectionItems;
class PASCALIMPLEMENTATION TGDIPMenuSectionItems : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TGDIPMenuSectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	TGDIPMenu* FOwner;
	TGDIPMenuSection* FSectionOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TGDIPMenuSectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TGDIPMenuSectionItem* Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TGDIPMenuSectionItems(TGDIPMenu* AOwner, TGDIPMenuSection* ASectionOwner);
	__property TGDIPMenuSectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TGDIPMenuSectionItem* __fastcall Add(void);
	HIDESBASE TGDIPMenuSectionItem* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGDIPMenuSectionItems(void) { }
	
};


class PASCALIMPLEMENTATION TGDIPMenuSection : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FBR;
	double FAutoWidth;
	double FAutoHeight;
	int FCnt;
	TGDIPMenu* FOwner;
	Gdipfill::TGDIPFill* FBackGroundFill;
	Gdipfill::TGDIPFill* FCaptionFill;
	TGDIPMenuSectionItems* FItems;
	int FCaptionSize;
	int FCaptionTop;
	int FCaptionLeft;
	System::UnicodeString FCaption;
	TGDIPMenuLocation FCaptionLocation;
	Graphics::TFont* FCaptionFont;
	int FWidth;
	int FHeight;
	int FItemSpacing;
	TGDIPMenuMargin* FItemMargin;
	TGDIPMenuMargin* FItemRectangleMargin;
	bool FAutoItemHeight;
	void __fastcall SetBackGroundFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetCaptionFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetItems(const TGDIPMenuSectionItems* Value);
	void __fastcall SetCaptionSize(const int Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionLocation(const TGDIPMenuLocation Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetItemSpacing(const int Value);
	void __fastcall SetItemMargin(const TGDIPMenuMargin* Value);
	void __fastcall SetItemRectangleMargin(const TGDIPMenuMargin* Value);
	void __fastcall SetAutoItemHeight(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall ItemMarginChanged(System::TObject* Sender);
	Advgdip::TGPRectF __fastcall GetContentRect(const Advgdip::TGPRectF &r);
	Advgdip::TGPRectF __fastcall GetCaptionRect(const Advgdip::TGPRectF &r);
	Advgdip::TGPRectF __fastcall GetSectionRect(const Advgdip::TGPRectF &r);
	Advgdip::TGPRectF __fastcall GetSectionInsideRect(const Advgdip::TGPRectF &r);
	void __fastcall BuildItemRects(bool first = false);
	void __fastcall CalculateAutoSize(void);
	__property double AutoHeight = {read=FAutoHeight};
	__property double AutoWidth = {read=FAutoWidth};
	
public:
	__fastcall virtual TGDIPMenuSection(Classes::TCollection* Collection);
	__fastcall virtual ~TGDIPMenuSection(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	double __fastcall GetWidth(void);
	double __fastcall GetHeight(void);
	void __fastcall SaveToFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	void __fastcall LoadFromFile(Inifiles::TIniFile* ini, System::UnicodeString Section);
	
__published:
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property TGDIPMenuLocation CaptionLocation = {read=FCaptionLocation, write=SetCaptionLocation, default=3};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property int CaptionSize = {read=FCaptionSize, write=SetCaptionSize, default=20};
	__property Gdipfill::TGDIPFill* CaptionFill = {read=FCaptionFill, write=SetCaptionFill};
	__property int Height = {read=FHeight, write=SetHeight, default=150};
	__property int Width = {read=FWidth, write=SetWidth, default=250};
	__property Gdipfill::TGDIPFill* BackGroundFill = {read=FBackGroundFill, write=SetBackGroundFill};
	__property TGDIPMenuSectionItems* Items = {read=FItems, write=SetItems};
	__property bool AutoItemHeight = {read=FAutoItemHeight, write=SetAutoItemHeight, nodefault};
	__property TGDIPMenuMargin* ItemMargin = {read=FItemMargin, write=SetItemMargin};
	__property TGDIPMenuMargin* ItemRectangleMargin = {read=FItemRectangleMargin, write=SetItemRectangleMargin};
	__property int ItemSpacing = {read=FItemSpacing, write=SetItemSpacing, default=2};
};


class DELPHICLASS TGDIPMenuSections;
class PASCALIMPLEMENTATION TGDIPMenuSections : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TGDIPMenuSection* operator[](int Index) { return Items[Index]; }
	
private:
	Controls::TWinControl* FMenuOwner;
	TGDIPMenu* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TGDIPMenuSection* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TGDIPMenuSection* Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TGDIPMenuSections(Controls::TWinControl* AOwner, TGDIPMenu* Menu);
	__property TGDIPMenuSection* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TGDIPMenuSection* __fastcall Add(void);
	HIDESBASE TGDIPMenuSection* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGDIPMenuSections(void) { }
	
};


#pragma option push -b-
enum TGDIPMenuSectionLayout { slHorizontal, slVertical };
#pragma option pop

typedef void __fastcall (__closure *TGDIPMenuItemCheckChangedEvent)(System::TObject* Sender, TGDIPMenuSectionItem* item);

typedef void __fastcall (__closure *TGDIPMenuItemEditChanged)(System::TObject* Sender, System::UnicodeString Text, TGDIPMenuSectionItem* item);

typedef void __fastcall (__closure *TGDIPMenuItemEvent)(System::TObject* Sender, TGDIPMenuSectionItem* Item, System::UnicodeString Text);

typedef void __fastcall (__closure *TGDIPMenuItemAnchorEvent)(System::TObject* Sender, TGDIPMenuSectionItem* Item, System::UnicodeString Anchor);

struct TCurrentItem
{
	
public:
	TGDIPMenuSectionItem* item;
	TGDIPMenuSection* section;
};


class PASCALIMPLEMENTATION TGDIPMenu : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool Fdestroying;
	bool FNeedsUpdate;
	Controls::TWinControl* FWinC;
	bool FIsWinXP;
	bool FDesignTime;
	TCurrentItem FHoveredItem;
	TCurrentItem FSelectedItem;
	Types::TRect FRect;
	int FUpdateCount;
	Gdipfill::TGDIPFill* FContentFill;
	Classes::TNotifyEvent FOnChange;
	TGDIPMenuTopLayerItems* FTopLayerItems;
	TGDIPMenuSections* FSections;
	TGDIPMenuSectionLayout FSectionLayout;
	TGDIPMenuMargin* FSectionMargin;
	Gdippicturecontainer::TGDIPPictureContainer* FPictureContainer;
	Imglist::TCustomImageList* FImageList;
	TGDIPMenuSectionItemAppearance* FItemAppearance;
	TGDIPMenuItemEvent FOnItemClick;
	TGDIPMenuItemEvent FOnItemHover;
	int FDropDownTop;
	int FDropDownLeft;
	TGDIPMenuDropDownLocation FDropDownLocation;
	bool FAutoSectionSize;
	TGDIPMenuItemCheckChangedEvent FOnItemCheckChanged;
	bool FTearOff;
	int FTearOffSize;
	Gdipfill::TGDIPFill* FTearOffFill;
	TGDIPMenuItemEditChanged FOnItemEditChanged;
	TGDIPMenuItemAnchorEvent FOnItemAnchorClick;
	System::UnicodeString FRootCaption;
	Imglist::TCustomImageList* __fastcall GetImageList(void);
	Gdippicturecontainer::TGDIPPictureContainer* __fastcall GetPictureContainer(void);
	void __fastcall SetContentFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSections(const TGDIPMenuSections* Value);
	void __fastcall SetTopLayerItems(const TGDIPMenuTopLayerItems* Value);
	void __fastcall SetSectionLayout(const TGDIPMenuSectionLayout Value);
	void __fastcall SetSectionMargin(const TGDIPMenuMargin* Value);
	void __fastcall SetImageList(const Imglist::TCustomImageList* Value);
	void __fastcall SetPictureContainer(const Gdippicturecontainer::TGDIPPictureContainer* Value);
	void __fastcall SetItemAppearance(const TGDIPMenuSectionItemAppearance* Value);
	void __fastcall SetDropDownLeft(const int Value);
	void __fastcall SetDropDownLocation(const TGDIPMenuDropDownLocation Value);
	void __fastcall SetDropDownTop(const int Value);
	void __fastcall SetAutoSectionSize(const bool Value);
	void __fastcall SetTearOff(const bool Value);
	void __fastcall SetTearOffFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetTearOffSize(const int Value);
	void __fastcall SetSelectedItem(const TCurrentItem &Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall ItemAppearanceChanged(System::TObject* Sender);
	void __fastcall TopLayerItemsChanged(System::TObject* Sender);
	void __fastcall SectionsChanged(System::TObject* Sender);
	Types::TRect __fastcall InsideRect(const Types::TRect &r);
	Advgdip::TGPRectF __fastcall GetContentRect(const Types::TRect &r);
	Advgdip::TGPRectF __fastcall GetSectionsRect(const Types::TRect &r);
	Advgdip::TGPRectF __fastcall GetTearOffRect(const Types::TRect &r);
	void __fastcall GetLocation(double &x, double &y, const Advgdip::TGPRectF &rectangle, double objectwidth, double objectheight, TGDIPMenuLocation location);
	bool __fastcall PtInGPRect(const Advgdip::TGPRectF &r, const Types::TPoint &pt);
	void __fastcall ReBuildTopLayerItems(void);
	void __fastcall BuildTopLayerItems(const Advgdip::TGPRectF &r);
	
public:
	__fastcall TGDIPMenu(Controls::TWinControl* AOwner);
	__fastcall virtual ~TGDIPMenu(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Types::TRect &r);
	TGDIPMenuTopLayerItem* __fastcall XYToTopLayerItem(int X, int Y);
	TCurrentItem __fastcall XYToSectionItem(int X, int Y);
	TCurrentItem __fastcall XYToSectionItemControl(int X, int Y);
	System::UnicodeString __fastcall GetStrippedHTMLText(System::UnicodeString txt);
	System::UnicodeString __fastcall DrawItemHTMLText(Advgdip::TGPGraphics* g, Advgdip::TGPRectF &htmlr, Graphics::TFont* f, TGDIPMenuHTMLText* HTML, const Advgdip::TGPRectF &r, System::UnicodeString str, TGDIPMenuLocation Location, int TextLeft, int TextTop, bool DoCalculate = false, bool DoAnchor = false, int fX = 0xffffffff, int fY = 0xffffffff);
	System::UnicodeString __fastcall DrawTopLayerHTMLText(Advgdip::TGPGraphics* g, Graphics::TFont* f, TGDIPMenuHTMLText* HTML, TGDIPMenuLocation Location, const Advgdip::TGPRectF &r, System::UnicodeString str, bool DoAnchor = false, int fX = 0xffffffff, int fY = 0xffffffff);
	void __fastcall DoMouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoMouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoMouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	MESSAGE void __fastcall DoCMMouseLeave(Messages::TMessage &Message);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall DoAutoSize(void);
	bool __fastcall UsesControls(void);
	Controls::TWinControl* __fastcall GetWinOwner(void);
	void __fastcall Init(const Types::TRect &r, bool Update, bool UpdateRectangle);
	__property TCurrentItem SelectedItem = {read=FSelectedItem, write=SetSelectedItem};
	bool __fastcall HasMultipleMenus(void);
	TGDIPMenu* __fastcall GetNextMenu(void);
	TGDIPMenu* __fastcall GetPreviousMenu(void);
	TGDIPMenu* __fastcall GetFirstMenu(void);
	__property bool NeedsUpdate = {read=FNeedsUpdate, write=FNeedsUpdate, nodefault};
	__property System::UnicodeString RootCaption = {read=FRootCaption, write=FRootCaption};
	
__published:
	__property bool AutoSectionSize = {read=FAutoSectionSize, write=SetAutoSectionSize, default=1};
	__property TGDIPMenuSectionItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
	__property Gdipfill::TGDIPFill* TearOffFill = {read=FTearOffFill, write=SetTearOffFill};
	__property int TearOffSize = {read=FTearOffSize, write=SetTearOffSize, default=8};
	__property Gdipfill::TGDIPFill* ContentFill = {read=FContentFill, write=SetContentFill};
	__property TGDIPMenuMargin* SectionMargin = {read=FSectionMargin, write=SetSectionMargin};
	__property TGDIPMenuSections* Sections = {read=FSections, write=SetSections};
	__property TGDIPMenuDropDownLocation DropDownLocation = {read=FDropDownLocation, write=SetDropDownLocation, default=11};
	__property int DropDownLeft = {read=FDropDownLeft, write=SetDropDownLeft, default=0};
	__property int DropDownTop = {read=FDropDownTop, write=SetDropDownTop, default=0};
	__property TGDIPMenuSectionLayout SectionLayout = {read=FSectionLayout, write=SetSectionLayout, default=0};
	__property TGDIPMenuTopLayerItems* TopLayerItems = {read=FTopLayerItems, write=SetTopLayerItems};
	__property Imglist::TCustomImageList* ImageList = {read=GetImageList, write=SetImageList};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=GetPictureContainer, write=SetPictureContainer};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool TearOff = {read=FTearOff, write=SetTearOff, default=1};
	__property TGDIPMenuItemEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TGDIPMenuItemAnchorEvent OnItemAnchorClick = {read=FOnItemAnchorClick, write=FOnItemAnchorClick};
	__property TGDIPMenuItemEvent OnItemHover = {read=FOnItemHover, write=FOnItemHover};
	__property TGDIPMenuItemCheckChangedEvent OnItemCheckChanged = {read=FOnItemCheckChanged, write=FOnItemCheckChanged};
	__property TGDIPMenuItemEditChanged OnItemEditChanged = {read=FOnItemEditChanged, write=FOnItemEditChanged};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt TEAROFFELLIPSESIZE = 0x4;
static const ShortInt TEAROFFELLIPSESPACING = 0x2;

}	/* namespace Gdipmenu */
using namespace Gdipmenu;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipmenuHPP
