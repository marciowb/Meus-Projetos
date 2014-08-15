// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcardlist.pas' rev: 21.00

#ifndef AdvcardlistHPP
#define AdvcardlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Extdlgs.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Acldd.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Themes.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <Uxtheme.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcardlist
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

class DELPHICLASS ECardTemplateError;
class PASCALIMPLEMENTATION ECardTemplateError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ECardTemplateError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ECardTemplateError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ECardTemplateError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ECardTemplateError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ECardTemplateError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ECardTemplateError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECardTemplateError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECardTemplateError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ECardTemplateError(void) { }
	
};


class DELPHICLASS ECardItemListError;
class PASCALIMPLEMENTATION ECardItemListError : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ECardItemListError(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ECardItemListError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall ECardItemListError(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall ECardItemListError(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall ECardItemListError(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ECardItemListError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ECardItemListError(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ECardItemListError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ECardItemListError(void) { }
	
};


#pragma option push -b-
enum TAdvGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

class DELPHICLASS TAdvGradient;
class PASCALIMPLEMENTATION TAdvGradient : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	TAdvGradientDirection FDirection;
	Classes::TNotifyEvent FOnGradientChange;
	void __fastcall SetColor(Graphics::TColor Value);
	void __fastcall SetColorTo(Graphics::TColor Value);
	void __fastcall SetDirection(TAdvGradientDirection Value);
	void __fastcall DoGradientChange(void);
	
protected:
	__property Classes::TNotifyEvent OnGradientChange = {read=FOnGradientChange, write=FOnGradientChange};
	
public:
	__fastcall TAdvGradient(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Draw(Graphics::TCanvas* Canvas, const Types::TRect &Rect);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=-16777211};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property TAdvGradientDirection Direction = {read=FDirection, write=SetDirection, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAdvGradient(void) { }
	
};


class DELPHICLASS TCardListEditLink;
class PASCALIMPLEMENTATION TCardListEditLink : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Controls::TKeyEvent FOnKeyDown;
	
protected:
	void __fastcall ControlKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	
public:
	virtual Controls::TWinControl* __fastcall CreateControl(void) = 0 ;
	virtual void __fastcall SetProperties(void) = 0 ;
	virtual void __fastcall SetSelection(int SelStart, int SelLength) = 0 ;
	virtual void __fastcall SetFocus(void) = 0 ;
	virtual void __fastcall ValueToControl(const System::Variant &value) = 0 ;
	virtual System::Variant __fastcall ControlToValue(void) = 0 ;
	__property Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
public:
	/* TComponent.Create */ inline __fastcall virtual TCardListEditLink(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TCardListEditLink(void) { }
	
};


typedef void __fastcall (__closure *TOnAppearanceChange)(System::TObject* Sender, bool EnabledChanged);

class DELPHICLASS TAdvCardAppearance;
class PASCALIMPLEMENTATION TAdvCardAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FUpdate;
	Controls::TBevelCut FBevelInner;
	Controls::TBevelCut FBevelOuter;
	int FBevelWidth;
	Graphics::TColor FBorderColor;
	int FBorderWidth;
	int FMergedBorderWidth;
	TAdvGradient* FCaptionColor;
	Graphics::TColor FCaptionBorderColor;
	int FCaptionBorderWidth;
	Graphics::TFont* FCaptionFont;
	TAdvGradient* FColor;
	bool FEnabled;
	Graphics::TFont* FItemLabelFont;
	Graphics::TFont* FItemEditFont;
	bool FReplaceLabelFont;
	bool FReplaceEditFont;
	TOnAppearanceChange FOnAppearanceChange;
	bool FCardItem;
	void __fastcall RecalcMergedBorder(void);
	void __fastcall DoAppearanceChange(bool EnabledChanged);
	void __fastcall HandleFontChanges(System::TObject* Sender);
	void __fastcall HandleGradientChanges(System::TObject* Sender);
	void __fastcall SetBevelInner(Controls::TBevelCut Value);
	void __fastcall SetBevelOuter(Controls::TBevelCut Value);
	void __fastcall SetBevelWidth(int Value);
	void __fastcall SetBorderColor(Graphics::TColor Value);
	void __fastcall SetBorderWidth(int Value);
	void __fastcall SetCaptionColor(TAdvGradient* Value);
	void __fastcall SetCaptionBorderColor(Graphics::TColor Value);
	void __fastcall SetCaptionBorderWidth(int Value);
	void __fastcall SetCaptionFont(Graphics::TFont* Value);
	void __fastcall SetColor(TAdvGradient* Value);
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetItemLabelFont(Graphics::TFont* Value);
	void __fastcall SetItemEditFont(Graphics::TFont* Value);
	void __fastcall SetReplaceLabelFont(bool Value);
	void __fastcall SetReplaceEditFont(bool Value);
	
protected:
	__property bool CardItem = {read=FCardItem, write=FCardItem, nodefault};
	__property TOnAppearanceChange OnAppearanceChange = {read=FOnAppearanceChange, write=FOnAppearanceChange};
	
public:
	__fastcall TAdvCardAppearance(void);
	__fastcall virtual ~TAdvCardAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property int MergedBorderWidth = {read=FMergedBorderWidth, nodefault};
	
__published:
	__property Controls::TBevelCut BevelInner = {read=FBevelInner, write=SetBevelInner, default=0};
	__property Controls::TBevelCut BevelOuter = {read=FBevelOuter, write=SetBevelOuter, default=2};
	__property int BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=1};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=1};
	__property TAdvGradient* CaptionColor = {read=FCaptionColor, write=SetCaptionColor};
	__property Graphics::TColor CaptionBorderColor = {read=FCaptionBorderColor, write=SetCaptionBorderColor, default=536870911};
	__property int CaptionBorderWidth = {read=FCaptionBorderWidth, write=SetCaptionBorderWidth, default=1};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property TAdvGradient* Color = {read=FColor, write=SetColor};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property Graphics::TFont* ItemLabelFont = {read=FItemLabelFont, write=SetItemLabelFont};
	__property Graphics::TFont* ItemEditFont = {read=FItemEditFont, write=SetItemEditFont};
	__property bool ReplaceLabelFont = {read=FReplaceLabelFont, write=SetReplaceLabelFont, default=0};
	__property bool ReplaceEditFont = {read=FReplaceEditFont, write=SetReplaceEditFont, default=0};
};


#pragma option push -b-
enum TAdvCardItemType { itLabeledItem, itItem, itLabel, itProgressBar };
#pragma option pop

typedef Classes::TAlignment TItemAlignment;

typedef Stdctrls::TTextLayout TItemLayout;

#pragma option push -b-
enum TAdvCardItemEditor { ieText, ieNumber, ieFloat, ieBoolean, ieDropDownList, ieDropDownEdit, ieDate, ieTime, iePictureDialog, ieCustom, ieRating };
#pragma option pop

#pragma option push -b-
enum TAdvCardItemDataType { idtString, idtFloat, idtInteger, idtBoolean, idtDate, idtTime, idtImage };
#pragma option pop

#pragma option push -b-
enum TAdvCardItemURLType { utNone, utLink, utHTTP, utHTTPS, utFTP, utMailto, utNNTP };
#pragma option pop

#pragma option push -b-
enum TAdvCardBooleanHideCondition { bhcAlwaysShow, bhcTrue, bhcFalse, bhcCustom };
#pragma option pop

#pragma option push -b-
enum TAdvCardDateHideCondition { dhcAlwaysShow, dhcNullDate, dhcNotNullDate, dhcCustom };
#pragma option pop

#pragma option push -b-
enum TAdvCardFloatHideCondition { fhcAlwaysShow, fhcNull, fhcNotNull, fhcCustom };
#pragma option pop

#pragma option push -b-
enum TAdvCardIntegerHideCondition { ihcAlwaysShow, ihcNull, ihcNotNull, ihcCustom };
#pragma option pop

#pragma option push -b-
enum TAdvCardPictureHideCondition { phcAlwaysShow, phcEmpty, phcNotEmpty, phcCustom };
#pragma option pop

#pragma option push -b-
enum TAdvCardStringHideCondition { shcAlwaysShow, shcEmpty, shcNotEmpty, shcCustom };
#pragma option pop

#pragma option push -b-
enum TAdvCardImageSize { isOriginal, isStretched, isStretchedProp };
#pragma option pop

#pragma option push -b-
enum TCardState { csNormal, csHover, csSelected, csEditing };
#pragma option pop

class DELPHICLASS TAdvCardTemplateItem;
class DELPHICLASS TAdvCardTemplate;
class DELPHICLASS TCustomAdvCardList;
class PASCALIMPLEMENTATION TAdvCardTemplateItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FUpdate;
	bool FAutoSize;
	System::UnicodeString FCaption;
	Classes::TAlignment FCaptionAlignment;
	Graphics::TColor FCaptionColor;
	Graphics::TFont* FCaptionFont;
	Stdctrls::TTextLayout FCaptionLayout;
	bool FCustomDraw;
	TAdvCardItemDataType FDataType;
	System::UnicodeString FDefaultValue;
	TAdvCardImageSize FImageSize;
	System::UnicodeString FFormat;
	Classes::TAlignment FValueAlignment;
	Graphics::TColor FValueColor;
	Graphics::TFont* FValueFont;
	Stdctrls::TTextLayout FValueLayout;
	Graphics::TColor FEditColor;
	int FHeight;
	TAdvCardBooleanHideCondition FHideBooleanCondition;
	TAdvCardDateHideCondition FHideDateCondition;
	TAdvCardFloatHideCondition FHideFloatCondition;
	TAdvCardIntegerHideCondition FHideIntegerCondition;
	TAdvCardPictureHideCondition FHidePictureCondition;
	TAdvCardStringHideCondition FHideStringCondition;
	TAdvCardItemEditor FItemEditor;
	TAdvCardItemType FItemType;
	Classes::TStringList* FList;
	System::UnicodeString FMask;
	int FMaxHeight;
	System::UnicodeString FName;
	System::UnicodeString FPrefix;
	bool FReadOnly;
	bool FShowHint;
	System::UnicodeString FSuffix;
	int FTag;
	bool FVisible;
	bool FWordWrap;
	bool FDirectEdit;
	bool FTransparentImage;
	TCardListEditLink* FItemEditLink;
	Classes::TNotifyEvent FOnTemplateItemChange;
	Classes::TNotifyEvent FOnTemplateItemListChange;
	TAdvCardItemURLType FValueURLType;
	int FRatingCount;
	int FProgressMin;
	int FProgressMax;
	void __fastcall CheckEditorType(TAdvCardItemDataType Data, TAdvCardItemEditor Editor);
	void __fastcall DoTemplateItemChange(void);
	void __fastcall DoTemplateItemDefValChange(void);
	void __fastcall DoTemplateItemHideCondChange(void);
	void __fastcall DoTemplateItemListChange(void);
	void __fastcall DoTemplateItemLinkedPropChange(System::UnicodeString OldName);
	void __fastcall HandleChildChange(System::TObject* Sender);
	void __fastcall HandleListChange(System::TObject* Sender);
	void __fastcall SetAutoSize(bool Value);
	void __fastcall SetCaption(System::UnicodeString Value);
	void __fastcall SetCaptionAlignment(Classes::TAlignment Value);
	void __fastcall SetCaptionColor(Graphics::TColor Value);
	void __fastcall SetCaptionLayout(Stdctrls::TTextLayout Value);
	void __fastcall SetCustomDraw(bool Value);
	void __fastcall SetDataType(TAdvCardItemDataType Value);
	void __fastcall SetDefaultValue(System::UnicodeString Value);
	void __fastcall SetImageSize(TAdvCardImageSize Value);
	void __fastcall SetFormat(System::UnicodeString Value);
	void __fastcall SetValueAlignment(Classes::TAlignment Value);
	void __fastcall SetValueColor(Graphics::TColor Value);
	void __fastcall SetValueLayout(Stdctrls::TTextLayout Value);
	void __fastcall SetEditColor(Graphics::TColor Value);
	void __fastcall SetHeight(int Value);
	void __fastcall SetHideBooleanCondition(TAdvCardBooleanHideCondition Value);
	void __fastcall SetHideDateCondition(TAdvCardDateHideCondition Value);
	void __fastcall SetHideFloatCondition(TAdvCardFloatHideCondition Value);
	void __fastcall SetHideIntegerCondition(TAdvCardIntegerHideCondition Value);
	void __fastcall SetHidePictureCondition(TAdvCardPictureHideCondition Value);
	void __fastcall SetHideStringCondition(TAdvCardStringHideCondition Value);
	void __fastcall SetItemEditor(TAdvCardItemEditor Value);
	void __fastcall SetItemType(TAdvCardItemType Value);
	void __fastcall SetList(Classes::TStringList* Value);
	void __fastcall SetMask(System::UnicodeString Value);
	void __fastcall SetMaxHeight(int Value);
	void __fastcall SetName(System::UnicodeString Value);
	void __fastcall SetPrefix(System::UnicodeString Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetShowHint(bool Value);
	void __fastcall SetSuffix(System::UnicodeString Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetWordWrap(bool Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetValueFont(const Graphics::TFont* Value);
	void __fastcall SetValueURLType(const TAdvCardItemURLType Value);
	void __fastcall SetRatingCount(const int Value);
	void __fastcall SetProgressMax(const int Value);
	void __fastcall SetProgressMin(const int Value);
	
protected:
	TAdvCardTemplate* __fastcall GetTemplate(void);
	TCustomAdvCardList* __fastcall GetCardList(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall SetDisplayName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TAdvCardTemplateItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvCardTemplateItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall AssignVisuals(Classes::TPersistent* Source);
	__property TCustomAdvCardList* CardList = {read=GetCardList};
	__property TAdvCardTemplate* CardTemplate = {read=GetTemplate};
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, default=0};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=536870911};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property Stdctrls::TTextLayout CaptionLayout = {read=FCaptionLayout, write=SetCaptionLayout, default=1};
	__property bool CustomDraw = {read=FCustomDraw, write=SetCustomDraw, default=0};
	__property TAdvCardItemDataType DataType = {read=FDataType, write=SetDataType, default=0};
	__property System::UnicodeString DefaultValue = {read=FDefaultValue, write=SetDefaultValue};
	__property bool DirectEdit = {read=FDirectEdit, write=FDirectEdit, default=0};
	__property Graphics::TColor EditColor = {read=FEditColor, write=SetEditColor, default=-16777211};
	__property System::UnicodeString Format = {read=FFormat, write=SetFormat};
	__property int MaxHeight = {read=FMaxHeight, write=SetMaxHeight, default=66};
	__property int Height = {read=FHeight, write=SetHeight, default=22};
	__property TAdvCardBooleanHideCondition HideBooleanCondition = {read=FHideBooleanCondition, write=SetHideBooleanCondition, default=0};
	__property TAdvCardDateHideCondition HideDateCondition = {read=FHideDateCondition, write=SetHideDateCondition, default=0};
	__property TAdvCardFloatHideCondition HideFloatCondition = {read=FHideFloatCondition, write=SetHideFloatCondition, default=0};
	__property TAdvCardIntegerHideCondition HideIntegerCondition = {read=FHideIntegerCondition, write=SetHideIntegerCondition, default=0};
	__property TAdvCardPictureHideCondition HidePictureCondition = {read=FHidePictureCondition, write=SetHidePictureCondition, default=0};
	__property TAdvCardStringHideCondition HideStringCondition = {read=FHideStringCondition, write=SetHideStringCondition, default=0};
	__property TAdvCardImageSize ImageSize = {read=FImageSize, write=SetImageSize, default=0};
	__property TCardListEditLink* ItemEditLink = {read=FItemEditLink, write=FItemEditLink};
	__property TAdvCardItemEditor ItemEditor = {read=FItemEditor, write=SetItemEditor, stored=true, nodefault};
	__property TAdvCardItemType ItemType = {read=FItemType, write=SetItemType, default=0};
	__property Classes::TStringList* List = {read=FList, write=SetList};
	__property System::UnicodeString Mask = {read=FMask, write=SetMask};
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString Prefix = {read=FPrefix, write=SetPrefix};
	__property int ProgressMin = {read=FProgressMin, write=SetProgressMin, default=0};
	__property int ProgressMax = {read=FProgressMax, write=SetProgressMax, default=100};
	__property int RatingCount = {read=FRatingCount, write=SetRatingCount, default=5};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property bool ShowHint = {read=FShowHint, write=SetShowHint, default=0};
	__property System::UnicodeString Suffix = {read=FSuffix, write=SetSuffix};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property bool TransparentImage = {read=FTransparentImage, write=FTransparentImage, default=1};
	__property Classes::TAlignment ValueAlignment = {read=FValueAlignment, write=SetValueAlignment, default=0};
	__property Graphics::TColor ValueColor = {read=FValueColor, write=SetValueColor, default=536870911};
	__property Graphics::TFont* ValueFont = {read=FValueFont, write=SetValueFont};
	__property Stdctrls::TTextLayout ValueLayout = {read=FValueLayout, write=SetValueLayout, default=1};
	__property TAdvCardItemURLType ValueURLType = {read=FValueURLType, write=SetValueURLType, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property Classes::TNotifyEvent OnTemplateItemChange = {read=FOnTemplateItemChange, write=FOnTemplateItemChange};
	__property Classes::TNotifyEvent OnTemplateItemListChange = {read=FOnTemplateItemListChange, write=FOnTemplateItemListChange};
};


class DELPHICLASS TAdvCardTemplateItems;
class DELPHICLASS TAdvCards;
class PASCALIMPLEMENTATION TAdvCardTemplateItems : public Classes::TOwnedCollection
{
	typedef Classes::TOwnedCollection inherited;
	
public:
	TAdvCardTemplateItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvCardTemplate* FCardTemplate;
	HIDESBASE TAdvCardTemplateItem* __fastcall GetItem(int Index);
	void __fastcall SetCards(TAdvCards* Value);
	HIDESBASE void __fastcall SetItem(int Index, TAdvCardTemplateItem* Value);
	
protected:
	TAdvCards* FCards;
	virtual void __fastcall SetItemName(Classes::TCollectionItem* AItem);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	void __fastcall ItemChanged(TAdvCardTemplateItem* Item);
	void __fastcall ItemHideCondChanged(TAdvCardTemplateItem* Item);
	void __fastcall ItemListChanged(TAdvCardTemplateItem* Item);
	void __fastcall ItemLinkedPropChanged(TAdvCardTemplateItem* Item, System::UnicodeString OldName);
	
public:
	__fastcall virtual TAdvCardTemplateItems(TAdvCardTemplate* CardTemplate, Classes::TCollectionItemClass ItemClass);
	HIDESBASE TAdvCardTemplateItem* __fastcall Add(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	HIDESBASE void __fastcall Delete(int Index);
	TAdvCardTemplateItem* __fastcall GetItemByName(System::UnicodeString Name);
	HIDESBASE TAdvCardTemplateItem* __fastcall Insert(int Index);
	__property TAdvCards* Cards = {read=FCards, write=SetCards};
	__property TAdvCardTemplate* CardTemplate = {read=FCardTemplate};
	__property TAdvCardTemplateItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvCardTemplateItems(void) { }
	
};


typedef TMetaClass* TCardTemplateItemsClass;

typedef void __fastcall (__closure *TTemplateItemEvent)(System::TObject* Sender, TAdvCardTemplateItem* Item);

class PASCALIMPLEMENTATION TAdvCardTemplate : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomAdvCardList* FCardList;
	TAdvCardTemplateItems* FItems;
	TAdvCardTemplateItems* FDefItems;
	TAdvCardTemplateItem* FDefaultItem;
	Classes::TAlignment FCardCaptionAlignment;
	int FCardCaptionHeight;
	int FCardWidth;
	int FHorMargins;
	int FIndent;
	int FItemLabelWidth;
	int FItemLabelRealWidth;
	int FItemSpacing;
	int FItemValueWidth;
	int FVertMargins;
	TTemplateItemEvent FOnTemplateItemAdd;
	TTemplateItemEvent FOnBeforTemplateItemDelete;
	Classes::TNotifyEvent FOnCardTemplateChange;
	void __fastcall AdjustItemLabelWidth(void);
	void __fastcall AdjustItemValueWidth(void);
	void __fastcall DoCardTemplateChange(void);
	void __fastcall SetCardCaptionAlignment(Classes::TAlignment Value);
	void __fastcall SetCardCaptionHeight(int Value);
	void __fastcall SetCardWidth(int Value);
	void __fastcall SetHorMargins(int Value);
	void __fastcall SetIndent(int Value);
	void __fastcall SetItemLabelWidth(int Value);
	void __fastcall SetItems(TAdvCardTemplateItems* Value);
	void __fastcall SetItemSpacing(int Value);
	void __fastcall SetItemValueWidth(int Value);
	void __fastcall SetVertMargins(int Value);
	void __fastcall SetDefaultItem(const TAdvCardTemplateItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	void __fastcall BeforTemplateItemDelete(TAdvCardTemplateItem* Item);
	void __fastcall TemplateItemAdd(TAdvCardTemplateItem* Item);
	
public:
	__fastcall TAdvCardTemplate(TCustomAdvCardList* CardList, TCardTemplateItemsClass TemplateItemsClass, Classes::TCollectionItemClass ItemClass);
	__fastcall virtual ~TAdvCardTemplate(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TCustomAdvCardList* CardList = {read=FCardList};
	__property int ItemLabelRealWidth = {read=FItemLabelRealWidth, nodefault};
	
__published:
	__property Classes::TAlignment CardCaptionAlignment = {read=FCardCaptionAlignment, write=SetCardCaptionAlignment, default=0};
	__property int CardCaptionHeight = {read=FCardCaptionHeight, write=SetCardCaptionHeight, default=22};
	__property int CardWidth = {read=FCardWidth, write=SetCardWidth, default=200};
	__property TAdvCardTemplateItem* DefaultItem = {read=FDefaultItem, write=SetDefaultItem};
	__property int HorMargins = {read=FHorMargins, write=SetHorMargins, default=10};
	__property int Indent = {read=FIndent, write=SetIndent, default=5};
	__property int ItemLabelWidth = {read=FItemLabelWidth, write=SetItemLabelWidth, default=100};
	__property TAdvCardTemplateItems* Items = {read=FItems, write=SetItems};
	__property int ItemSpacing = {read=FItemSpacing, write=SetItemSpacing, default=5};
	__property int ItemValueWidth = {read=FItemValueWidth, write=SetItemValueWidth, stored=false, nodefault};
	__property int VertMargins = {read=FVertMargins, write=SetVertMargins, default=10};
	__property TTemplateItemEvent OnTemplateItemAdd = {read=FOnTemplateItemAdd, write=FOnTemplateItemAdd};
	__property TTemplateItemEvent OnBeforTemplateItemDelete = {read=FOnBeforTemplateItemDelete, write=FOnBeforTemplateItemDelete};
	__property Classes::TNotifyEvent OnCardTemplateChange = {read=FOnCardTemplateChange, write=FOnCardTemplateChange};
};


class DELPHICLASS TAdvCardItem;
class PASCALIMPLEMENTATION TAdvCardItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FBoolean;
	bool FHided;
	bool FSelected;
	System::UnicodeString FString;
	int FInteger;
	double FFloat;
	System::TDateTime FDate;
	System::TDateTime FTime;
	Graphics::TPicture* FPicture;
	void __fastcall DoChangeValue(void);
	bool __fastcall GetBoolean(void);
	System::UnicodeString __fastcall GetString(void);
	double __fastcall GetFloat(void);
	int __fastcall GetInteger(void);
	System::TDateTime __fastcall GetDate(void);
	System::TDateTime __fastcall GetTime(void);
	void __fastcall SetBoolean(bool Value);
	void __fastcall SetSelected(bool Value);
	void __fastcall SetString(System::UnicodeString Value);
	void __fastcall SetFloat(double Value);
	void __fastcall SetInteger(int Value);
	void __fastcall SetDate(System::TDateTime Value);
	void __fastcall SetTime(System::TDateTime Value);
	void __fastcall SetPicture(Graphics::TPicture* Value);
	void __fastcall PictureChange(System::TObject* Sender);
	
protected:
	TAdvCardItemDataType DataType;
	System::UnicodeString Format;
	System::UnicodeString FName;
	Types::TRect FLabelClientRect;
	Types::TRect FLabelCardRect;
	Types::TRect FLabelListRect;
	Types::TRect FValueClientRect;
	Types::TRect FValueCardRect;
	Types::TRect FValueListRect;
	Types::TRect FUnitedListRect;
	
public:
	System::UnicodeString Hint;
	System::TObject* Obj;
	bool OwnsObject;
	int Tag;
	__fastcall virtual TAdvCardItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvCardItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool AsBoolean = {read=GetBoolean, write=SetBoolean, nodefault};
	__property System::UnicodeString AsString = {read=GetString, write=SetString};
	__property double AsFloat = {read=GetFloat, write=SetFloat};
	__property int AsInteger = {read=GetInteger, write=SetInteger, nodefault};
	__property System::TDateTime AsDate = {read=GetDate, write=SetDate};
	__property System::TDateTime AsTime = {read=GetTime, write=SetTime};
	__property Graphics::TPicture* Picture = {read=FPicture, write=SetPicture};
	__property bool Hided = {read=FHided, nodefault};
	__property System::UnicodeString Name = {read=FName};
	__property bool Selected = {read=FSelected, write=SetSelected, nodefault};
};


class DELPHICLASS TAdvCardItemList;
class DELPHICLASS TAdvCard;
class PASCALIMPLEMENTATION TAdvCardItemList : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvCardItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvCard* FCard;
	HIDESBASE TAdvCardItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TAdvCardItem* Value);
	
protected:
	bool AllowListModification;
	
public:
	__fastcall TAdvCardItemList(Classes::TCollectionItemClass ItemClass);
	__fastcall virtual ~TAdvCardItemList(void);
	HIDESBASE TAdvCardItem* __fastcall Add(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall BeginUpdate(void);
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall EndUpdate(void);
	HIDESBASE TAdvCardItem* __fastcall Insert(int Index);
	TAdvCardItem* __fastcall GetItemByName(System::UnicodeString Name);
	__property TAdvCardItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TAdvCard* Card = {read=FCard};
};


class PASCALIMPLEMENTATION TAdvCard : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvCardAppearance* FAppearance;
	System::UnicodeString FCaption;
	int FColumn;
	int FRow;
	bool FEditing;
	bool FFiltered;
	System::UnicodeString FHint;
	TAdvCardItemList* FItemList;
	bool FMouseOver;
	bool FSelected;
	int FSelectedItem;
	int FImageIndex;
	int FTag;
	bool FVisible;
	void __fastcall DoCardChange(void);
	void __fastcall DoSelectChanged(int OldSelected);
	void __fastcall SetCaption(System::UnicodeString Value);
	void __fastcall SetSelected(bool Value);
	void __fastcall SetSelectedItem(int Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetItemList(TAdvCardItemList* Value);
	void __fastcall OnCardAppearanceChanged(System::TObject* Sender, bool EnabledChanged);
	
protected:
	Types::TRect FCaptionClientRect;
	Types::TRect FCaptionCardRect;
	Types::TRect FCaptionListRect;
	Types::TRect FClientRect;
	Types::TRect FListRect;
	int FHeight;
	int __fastcall IndexOfRate(int ItemIndex, int X, int Y);
	Types::TRect __fastcall RateRect(int ItemIndex, int RateIndex);
	__property TAdvCardAppearance* Appearance = {read=FAppearance};
	
public:
	__fastcall virtual TAdvCard(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvCard(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int Column = {read=FColumn, nodefault};
	__property bool Editing = {read=FEditing, nodefault};
	__property bool Filtered = {read=FFiltered, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property bool Selected = {read=FSelected, write=SetSelected, nodefault};
	__property int SelectedItem = {read=FSelectedItem, write=SetSelectedItem, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property TAdvCardItemList* ItemList = {read=FItemList, write=SetItemList};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
};


typedef void __fastcall (__closure *TAdvCardEvent)(System::TObject* Sender, TAdvCard* Card);

typedef void __fastcall (__closure *TAdvCardCompareEvent)(System::TObject* Sender, TAdvCard* CardA, TAdvCard* CardB, int &res);

class PASCALIMPLEMENTATION TAdvCards : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvCard* operator[](int Index) { return Items[Index]; }
	
private:
	TCustomAdvCardList* FCardList;
	bool FUpdateSelected;
	TAdvCardEvent FOnCardAdd;
	TAdvCardEvent FOnBeforCardDelete;
	TAdvCardEvent FOnCardChange;
	void __fastcall ApplyAppearance(TAdvCard* Card);
	HIDESBASE TAdvCard* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TAdvCard* Value);
	void __fastcall SetUpdateSelected(bool Value);
	
protected:
	void __fastcall CalcClientRects(TAdvCard* Card);
	void __fastcall CardItemValueChanged(TAdvCard* Card, TAdvCardItem* Item);
	void __fastcall CardTemplateItemOrderCountChanged(void);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TAdvCards(TCustomAdvCardList* CardList, Classes::TCollectionItemClass ItemClass);
	bool __fastcall CheckItemShow(TAdvCard* Card, int ItemIndex);
	HIDESBASE TAdvCard* __fastcall Add(void);
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE TAdvCard* __fastcall Insert(int Index);
	void __fastcall UpdateCardItems(TAdvCard* Card);
	__property TAdvCard* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property bool UpdateSelected = {read=FUpdateSelected, write=SetUpdateSelected, nodefault};
	__property TAdvCardEvent OnCardAdd = {read=FOnCardAdd, write=FOnCardAdd};
	__property TAdvCardEvent OnBeforCardDelete = {read=FOnBeforCardDelete, write=FOnBeforCardDelete};
	__property TAdvCardEvent OnCardChange = {read=FOnCardChange, write=FOnCardChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvCards(void) { }
	
};


#pragma option push -b-
enum TSortDirection { sdAscending, sdDescending };
#pragma option pop

#pragma option push -b-
enum TSortType { stNone, stCaption, stItem, stCustom };
#pragma option pop

class DELPHICLASS TAdvCardSortSettings;
class PASCALIMPLEMENTATION TAdvCardSortSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TSortDirection FSortDirection;
	int FSortIndex;
	TSortType FSortType;
	bool FCaseSensitive;
	Classes::TNotifyEvent FOnSortChange;
	void __fastcall DoSortSettingChange(void);
	void __fastcall SetSortDirection(TSortDirection Value);
	void __fastcall SetSortIndex(int Value);
	void __fastcall SetSortType(const TSortType Value);
	
protected:
	__property Classes::TNotifyEvent OnSortChange = {read=FOnSortChange, write=FOnSortChange};
	
public:
	__fastcall TAdvCardSortSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool CaseSensitive = {read=FCaseSensitive, write=FCaseSensitive, default=0};
	__property TSortDirection SortDirection = {read=FSortDirection, write=SetSortDirection, default=0};
	__property int SortIndex = {read=FSortIndex, write=SetSortIndex, default=0};
	__property TSortType SortType = {read=FSortType, write=SetSortType, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAdvCardSortSettings(void) { }
	
};


class DELPHICLASS TAdvCardFilterSettings;
class PASCALIMPLEMENTATION TAdvCardFilterSettings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FFilterCondition;
	int FFilterIndex;
	Classes::TNotifyEvent FOnFilterChange;
	void __fastcall DoFilterSettingsChange(void);
	void __fastcall SetFilterCondition(System::UnicodeString Value);
	void __fastcall SetFilterIndex(int Value);
	
protected:
	__property Classes::TNotifyEvent OnFilterChange = {read=FOnFilterChange, write=FOnFilterChange};
	
public:
	__fastcall TAdvCardFilterSettings(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString FilterCondition = {read=FFilterCondition, write=SetFilterCondition};
	__property int FilterIndex = {read=FFilterIndex, write=SetFilterIndex, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TAdvCardFilterSettings(void) { }
	
};


#pragma option push -b-
enum TProgressStyle { psXP, psClassic };
#pragma option pop

class DELPHICLASS TProgressAppearance;
class PASCALIMPLEMENTATION TProgressAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FUnCompleteFontColor;
	Graphics::TColor FCompleteColor;
	Graphics::TColor FUnCompleteColor;
	Graphics::TColor FCompleteFontColor;
	Classes::TNotifyEvent FOnChange;
	bool FStacked;
	bool FShowPercentage;
	bool FShowBorder;
	bool FCompletionSmooth;
	bool FShowGradient;
	int FLevel2Perc;
	int FLevel1Perc;
	int FSteps;
	Graphics::TColor FLevel3Color;
	Graphics::TColor FLevel1Color;
	Graphics::TColor FLevel0Color;
	Graphics::TColor FLevel3ColorTo;
	Graphics::TColor FLevel2ColorTo;
	Graphics::TColor FLevel0ColorTo;
	Graphics::TColor FLevel1ColorTo;
	Graphics::TColor FBorderColor;
	Graphics::TColor FLevel2Color;
	TProgressStyle FStyle;
	void __fastcall SetCompleteColor(const Graphics::TColor Value);
	void __fastcall SetCompleteFontColor(const Graphics::TColor Value);
	void __fastcall SetUnCompleteColor(const Graphics::TColor Value);
	void __fastcall SetUnCompleteFontColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetCompletionSmooth(const bool Value);
	void __fastcall SetLevel0Color(const Graphics::TColor Value);
	void __fastcall SetLevel0ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Color(const Graphics::TColor Value);
	void __fastcall SetLevel1ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel1Perc(const int Value);
	void __fastcall SetLevel2Color(const Graphics::TColor Value);
	void __fastcall SetLevel2ColorTo(const Graphics::TColor Value);
	void __fastcall SetLevel2Perc(const int Value);
	void __fastcall SetLevel3Color(const Graphics::TColor Value);
	void __fastcall SetLevel3ColorTo(const Graphics::TColor Value);
	void __fastcall SetShowBorder(const bool Value);
	void __fastcall SetShowGradient(const bool Value);
	void __fastcall SetShowPercentage(const bool Value);
	void __fastcall SetStacked(const bool Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall SetStyle(const TProgressStyle Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TProgressAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor CompleteColor = {read=FCompleteColor, write=SetCompleteColor, default=255};
	__property Graphics::TColor CompleteFontColor = {read=FCompleteFontColor, write=SetCompleteFontColor, default=16711680};
	__property Graphics::TColor UnCompleteColor = {read=FUnCompleteColor, write=SetUnCompleteColor, default=536870911};
	__property Graphics::TColor UnCompleteFontColor = {read=FUnCompleteFontColor, write=SetUnCompleteFontColor, default=-16777208};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Graphics::TColor Level0Color = {read=FLevel0Color, write=SetLevel0Color, default=65280};
	__property Graphics::TColor Level0ColorTo = {read=FLevel0ColorTo, write=SetLevel0ColorTo, default=14811105};
	__property Graphics::TColor Level1Color = {read=FLevel1Color, write=SetLevel1Color, default=65535};
	__property Graphics::TColor Level1ColorTo = {read=FLevel1ColorTo, write=SetLevel1ColorTo, default=13303807};
	__property Graphics::TColor Level2Color = {read=FLevel2Color, write=SetLevel2Color, default=5483007};
	__property Graphics::TColor Level2ColorTo = {read=FLevel2ColorTo, write=SetLevel2ColorTo, default=11064319};
	__property Graphics::TColor Level3Color = {read=FLevel3Color, write=SetLevel3Color, default=255};
	__property Graphics::TColor Level3ColorTo = {read=FLevel3ColorTo, write=SetLevel3ColorTo, default=13290239};
	__property int Level1Perc = {read=FLevel1Perc, write=SetLevel1Perc, default=70};
	__property int Level2Perc = {read=FLevel2Perc, write=SetLevel2Perc, default=90};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=0};
	__property bool Stacked = {read=FStacked, write=SetStacked, default=0};
	__property TProgressStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property bool ShowPercentage = {read=FShowPercentage, write=SetShowPercentage, default=1};
	__property bool CompletionSmooth = {read=FCompletionSmooth, write=SetCompletionSmooth, default=1};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, default=1};
	__property int Steps = {read=FSteps, write=SetSteps, default=11};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TProgressAppearance(void) { }
	
};


class DELPHICLASS TACLDropTarget;
class PASCALIMPLEMENTATION TACLDropTarget : public Acldd::TCustomACLDropTarget
{
	typedef Acldd::TCustomACLDropTarget inherited;
	
private:
	TCustomAdvCardList* FACL;
	
public:
	__fastcall TACLDropTarget(TCustomAdvCardList* aACL);
	virtual void __fastcall DropCard(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DragMouseMove(const Types::TPoint &pt, bool &Allow);
	virtual void __fastcall DragMouseLeave(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TACLDropTarget(void) { }
	
};


class DELPHICLASS TACLDropSource;
class PASCALIMPLEMENTATION TACLDropSource : public Acldd::TCustomACLDropSource
{
	typedef Acldd::TCustomACLDropSource inherited;
	
private:
	TCustomAdvCardList* FACL;
	int FLastEffect;
	
protected:
	virtual void __fastcall DragDropStop(void);
	
public:
	__fastcall TACLDropSource(TCustomAdvCardList* aACL);
	virtual void __fastcall CurrentEffect(int dwEffect);
	virtual void __fastcall QueryDrag(void);
	__property int LastEffect = {read=FLastEffect, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TACLDropSource(void) { }
	
};


#pragma option push -b-
enum TArrowDirection { arrUp, arrDown, arrLeft, arrRight };
#pragma option pop

class DELPHICLASS TArrowWindow;
class PASCALIMPLEMENTATION TArrowWindow : public Extctrls::TPanel
{
	typedef Extctrls::TPanel inherited;
	
private:
	TArrowDirection Dir;
	StaticArray<Types::TPoint, 9> Arrow;
	
public:
	__fastcall TArrowWindow(Classes::TComponent* AOwner, TArrowDirection direction);
	virtual void __fastcall Loaded(void);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
public:
	/* TCustomPanel.Create */ inline __fastcall virtual TArrowWindow(Classes::TComponent* AOwner) : Extctrls::TPanel(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TArrowWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TArrowWindow(HWND ParentWindow) : Extctrls::TPanel(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TAdvCardItemEvent)(System::TObject* Sender, int CardIndex, int ItemIndex);

typedef void __fastcall (__closure *TAdvCardItemAllowEvent)(System::TObject* Sender, int CardIndex, int ItemIndex, bool &Allow);

typedef void __fastcall (__closure *TAdvCardCaptionGetDisplText)(System::TObject* Sender, int CardIndex, System::UnicodeString &Text);

typedef void __fastcall (__closure *TAdvCardItemGetDisplText)(System::TObject* Sender, int CardIndex, int ItemIndex, System::UnicodeString &Text);

typedef void __fastcall (__closure *TAdvCardDrawCardItem)(System::TObject* Sender, TAdvCard* Card, TAdvCardItem* Item, Graphics::TCanvas* Canvas, const Types::TRect &Rect);

typedef void __fastcall (__closure *TAdvCardDrawCardItemProp)(System::TObject* Sender, TAdvCard* Card, TAdvCardItem* Item, Graphics::TFont* AFont, Graphics::TBrush* ABrush);

typedef void __fastcall (__closure *TAdvCardColumnResizing)(System::TObject* Sender, int &NewSize);

typedef void __fastcall (__closure *TAdvCardDelayedLoad)(System::TObject* Sender, TAdvCard* Card);

typedef void __fastcall (__closure *TCardCheckChangeEvent)(System::TObject* Sender, TAdvCard* Card, TAdvCardItem* Item);

typedef void __fastcall (__closure *TCardRatingChangeEvent)(System::TObject* Sender, TAdvCard* Card, TAdvCardItem* Item, int &NewValue, bool AllowChange);

typedef void __fastcall (__closure *TCardAppearanceEvent)(System::TObject* Sender, TAdvCard* Card, TCardState CardState, TAdvCardAppearance* CardAppearance);

typedef void __fastcall (__closure *TAdvCardItemURLEvent)(System::TObject* Sender, int CardIndex, int ItemIndex, System::UnicodeString URL, bool &Default);

typedef void __fastcall (__closure *TOleDragDropEvent)(System::TObject* Sender, TAdvCard* Card, bool &Allow);

typedef void __fastcall (__closure *TOleDragOverEvent)(System::TObject* Sender, TAdvCard* Card, bool &Allow);

typedef void __fastcall (__closure *TOleDragStartEvent)(System::TObject* Sender, TAdvCard* Card);

typedef void __fastcall (__closure *TOleDragStopEvent)(System::TObject* Sender, int OLEEffect);

typedef void __fastcall (__closure *TOleDroppedEvent)(System::TObject* Sender, TAdvCard* Card);

typedef void __fastcall (__closure *TCardRearrangedEvent)(System::TObject* Sender, int FromCardIndex, int ToCardIndex);

typedef DynamicArray<int> TSortedCards;

typedef DynamicArray<int> TFilteredCards;

typedef DynamicArray<int> TInClientAreaCards;

#pragma option push -b-
enum TCalcListRectsResult { clrSkipped, clrFollowed, clrNextColumn };
#pragma option pop

#pragma option push -b-
enum TControlType { ctEdit, ctMemo, ctMaskEdit, ctCheckBox, ctComboBox, ctDateTimePicker, ctOpenPictureDialog, ctCustom };
#pragma option pop

#pragma option push -b-
enum TDataChangedObject { dcoCaption, dcoItem };
#pragma option pop

#pragma option push -b-
enum TScrollBarType { sbtHorizontal, sbtVertical };
#pragma option pop

class PASCALIMPLEMENTATION TCustomAdvCardList : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FScrolling;
	Controls::TControl* FEdControl;
	TControlType FEdControlType;
	int FEdCardIndex;
	int FEdItemIndex;
	bool FEdByMouse;
	Graphics::TBitmap* FDspBMPUnchecked;
	Graphics::TBitmap* FDspBMPChecked;
	Extdlgs::TOpenPictureDialog* FOpenPictDialog;
	int FHoverCardIndex;
	int FOverItemIndex;
	int FViewedColumns;
	int FViewedRows;
	TSortedCards FSortedCards;
	TInClientAreaCards FInClientAreaCards;
	int FCanvasLeft;
	int FCanvasRight;
	int FCanvasBottom;
	int FUpdateCount;
	HPEN FocusPen;
	Graphics::TPen* OldPen;
	#pragma pack(push,1)
	tagLOGBRUSH FocusPenBrush;
	#pragma pack(pop)
	bool FGridLineDragging;
	bool FCursorOverGridLine;
	int FPressedAtX;
	int FOldColumnWidth;
	int FResizingColumn;
	int FOldLeftTopCard;
	bool FSilentMouseMove;
	bool FAutoEdit;
	Graphics::TColor FBorderColor;
	int FBorderWidth;
	TAdvCardAppearance* FCardNormalAppearance;
	TAdvCardAppearance* FCardHoverAppearance;
	TAdvCards* FCards;
	TAdvCardAppearance* FCardSelectedAppearance;
	TAdvCardAppearance* FCardEditingAppearance;
	int FCardHorSpacing;
	int FCardVertSpacing;
	int FCheckBoxSize;
	TAdvGradient* FColor;
	int FColumns;
	bool FColumnSizing;
	int FColumnWidth;
	bool FFiltered;
	TAdvCardFilterSettings* FFilterSettings;
	Graphics::TColor FFocusColor;
	Graphics::TColor FGridLineColor;
	int FGridLineWidth;
	int FLeftCol;
	int FMaxColumnWidth;
	int FMinColumnWidth;
	bool FMultiSelect;
	int FPageCount;
	bool FReadOnly;
	TAdvCard* FSelectedCard;
	int FSelectedCount;
	int FSelectedIndex;
	bool FShowGridLine;
	bool FShowFocus;
	bool FShowScrollBar;
	bool FSorted;
	bool FEditMode;
	Controls::TImageList* FImages;
	bool FDblClick;
	TAdvCardSortSettings* FSortSettings;
	bool FGotoSelectedAutomatic;
	bool FDelayedCardLoad;
	Extctrls::TTimer* DelayedCardLoadTimer;
	TAdvCardItemAllowEvent FOnCardStartEdit;
	TAdvCardItemEvent FOnCardEndEdit;
	TAdvCardCaptionGetDisplText FOnCardCaptionGetDisplText;
	TAdvCardItemGetDisplText FOnCardItemGetDisplText;
	TAdvCardEvent FOnCardCaptionClick;
	TAdvCardEvent FOnCardCaptionDblClick;
	TAdvCardEvent FOnCardClick;
	TAdvCardEvent FOnCardRightClick;
	TAdvCardCompareEvent FOnCardCompare;
	TAdvCardEvent FOnCardDblClick;
	TAdvCardItemEvent FOnCardItemClick;
	TAdvCardItemEvent FOnCardItemRightClick;
	TAdvCardColumnResizing FOnColumnResizing;
	TAdvCardDrawCardItem FOnDrawCardItem;
	TAdvCardDrawCardItemProp FOnDrawCardItemProp;
	TAdvCardItemAllowEvent FOnShowCardItem;
	TAdvCardItemURLEvent FOnCardItemURLClick;
	TAdvCardDelayedLoad FOnDelayedCardLoad;
	Graphics::TColor FURLColor;
	int FRows;
	int FTopRow;
	TScrollBarType FScrollBarType;
	bool FExceedBounds;
	bool FCardRearrange;
	TAdvCard* FDraggingCard;
	TCardCheckChangeEvent FOnCardCheckChange;
	TProgressAppearance* FProgressAppearance;
	Graphics::TPicture* FRatingActive;
	Graphics::TPicture* FRatingInactive;
	TCardRatingChangeEvent FOnCardRatingChange;
	TCardAppearanceEvent FOnCardAppearance;
	Forms::TForm* FMoveForm;
	bool FSelectionClick;
	TACLDropTarget* FACLDropTarget;
	bool FOleDropTargetAssigned;
	bool FOleDropTarget;
	bool FOleDropSource;
	TOleDragStopEvent FOnOleDragStop;
	TOleDragStartEvent FOnOleDragStart;
	TOleDragDropEvent FOnOleDrag;
	TOleDragOverEvent FOnOleDragOver;
	TOleDragDropEvent FOnOleDrop;
	bool FShowDragImage;
	TArrowWindow* ArwU;
	TArrowWindow* ArwD;
	TArrowWindow* ArwL;
	TArrowWindow* ArwR;
	TOleDroppedEvent FOnOleDropped;
	bool FArrowKeySelectFreedom;
	TCardRearrangedEvent FOnCardRearranged;
	int FDragPointOffset;
	TAdvCard* FDragOverCard;
	bool FStayOnTopForm;
	void __fastcall OnProgressAppearanceChanged(System::TObject* Sender);
	void __fastcall OnRatingPicChanged(System::TObject* Sender);
	bool __fastcall AddToClientAreaCards(TAdvCard* Card, bool FirstTime);
	void __fastcall ConvertTypeAndDoneEdit(void);
	void __fastcall ConvertTypeAndStartEdit(const Types::TRect &EditRect, int CardIndex, int ItemIndex, System::WideChar StartChar);
	void __fastcall CreateDesignCards(void);
	void __fastcall ReCreateFocusPen(void);
	void __fastcall DoCardListChange(void);
	void __fastcall HandleControlKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall HandleScrBarScroll(System::TObject* Sender, Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
	bool __fastcall IsInClientArea(const Types::TRect &Rect);
	Types::TRect __fastcall GetCheckBoxRect(const Types::TRect &ValueListRect, Classes::TAlignment Align, Stdctrls::TTextLayout Layout);
	bool __fastcall GetEditing(void);
	int __fastcall GetDelayedCardLoadTimerInterval(void);
	void __fastcall SetDelayedCardLoadTimerInterval(int Value);
	void __fastcall SetMouseOverCard(int CardIndex);
	void __fastcall SetBorderColor(Graphics::TColor Value);
	HIDESBASE void __fastcall SetBorderWidth(int Value);
	void __fastcall SetCardNormalAppearance(TAdvCardAppearance* Value);
	void __fastcall SetCardHoverAppearance(TAdvCardAppearance* Value);
	void __fastcall SetCardSelectedAppearance(TAdvCardAppearance* Value);
	void __fastcall SetCardEditingAppearance(TAdvCardAppearance* Value);
	void __fastcall SetCardHorSpacing(int Value);
	void __fastcall SetCardTemplate(TAdvCardTemplate* Value);
	void __fastcall SetCardVertSpacing(int Value);
	HIDESBASE void __fastcall SetColor(TAdvGradient* Value);
	void __fastcall SetColumnSizing(bool Value);
	void __fastcall SetColumnWidth(int Value);
	void __fastcall SetFiltered(bool Value);
	void __fastcall SetFilterSettings(TAdvCardFilterSettings* Value);
	void __fastcall SetFocusColor(Graphics::TColor Value);
	void __fastcall SetGridLineColor(Graphics::TColor Value);
	void __fastcall SetGridLineWidth(int Value);
	void __fastcall SetLeftCol(int Value);
	void __fastcall SetMaxColumnWidth(int Value);
	void __fastcall SetMinColumnWidth(int Value);
	void __fastcall SetMultiSelect(bool Value);
	void __fastcall SetPageCount(int Value);
	void __fastcall SetReadOnly(bool Value);
	void __fastcall SetSelectedIndex(int Value);
	void __fastcall SetShowGridLine(bool Value);
	void __fastcall SetShowFocus(bool Value);
	void __fastcall SetShowScrollBar(bool Value);
	void __fastcall SetSorted(bool Value);
	void __fastcall SetSortSettings(TAdvCardSortSettings* Value);
	void __fastcall SetDelayedCardLoad(bool Value);
	void __fastcall DelayedCardLoadTimerOnTimer(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMKillFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Msg);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetTopRow(int Value);
	void __fastcall SetScrollBarType(const TScrollBarType Value);
	void __fastcall SetProgressAppearance(const TProgressAppearance* Value);
	void __fastcall SetRatingActive(const Graphics::TPicture* Value);
	void __fastcall SetRatingInactive(const Graphics::TPicture* Value);
	Forms::TForm* __fastcall SelectionToForm(const Types::TRect &ARect);
	void __fastcall SetOleDropTarget(const bool Value);
	void __fastcall SetCardRearrange(const bool Value);
	void __fastcall SetArrowColor(Graphics::TColor Value);
	Graphics::TColor __fastcall GetArrowColor(void);
	
protected:
	TAdvCardTemplate* FCardTemplate;
	Stdctrls::TScrollBar* ScrollBar;
	virtual void __fastcall LocateByChar(System::WideChar Key);
	virtual bool __fastcall JumpToCard(int Offset, bool ToBegin, bool ToEnd);
	virtual bool __fastcall JumpToItem(int Offset, bool ToBegin, bool ToEnd);
	virtual void __fastcall UpdateScrollBar(void);
	virtual void __fastcall OnScroll(int &ScrollPos, Stdctrls::TScrollCode ScrollCode);
	virtual void __fastcall CreateTemplate(TAdvCards* Cards);
	TAdvCard* __fastcall GetUpperCard(TAdvCard* Card, int Col);
	TCalcListRectsResult __fastcall CalcListRects(TAdvCard* Card, TAdvCard* AfterCard, bool DoCheckScroll);
	virtual void __fastcall DataChanged(TAdvCard* Card, TAdvCardItem* Item, TDataChangedObject DataObject);
	virtual void __fastcall SelectedChanged(void);
	virtual void __fastcall ColumnSized(void);
	void __fastcall GetColumnCardList(Classes::TList* aList, int Col);
	void __fastcall ShiftListRects(int Value);
	bool __fastcall InValueRect(int X, TAdvCard* ACard, TAdvCardTemplateItem* ATemplate, TAdvCardItem* AItem);
	DYNAMIC void __fastcall Click(void);
	virtual void __fastcall CreateWnd(void);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall DrawItemCaption(Graphics::TCanvas* Canvas, TAdvCard* Card, int ItemIndex, bool Preview);
	virtual void __fastcall DrawItemValue(Graphics::TCanvas* Canvas, TAdvCard* Card, int ItemIndex, bool Preview);
	virtual void __fastcall DrawCard(Graphics::TCanvas* Canvas, TAdvCard* Card, bool Preview);
	virtual void __fastcall DoFilter(bool Filtered);
	void __fastcall UpdateCards(bool AClientRects, bool AListRects, bool ASort, bool AFilter);
	virtual void __fastcall Paint(void);
	void __fastcall PaintCard(int CardIndex);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall DoSort(bool Sorted);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall HandleAppearanceChange(System::TObject* Sender, bool EnabledChanged);
	void __fastcall HandleColorChange(System::TObject* Sender);
	void __fastcall CardTemplateChanged(void);
	void __fastcall CardTemplateItemChanged(TAdvCardTemplateItem* Item);
	void __fastcall CardTemplateItemHideCondChanged(TAdvCardTemplateItem* Item);
	void __fastcall DefaultValueChanged(TAdvCardTemplateItem* TItem);
	void __fastcall CardChanged(TAdvCard* Card);
	void __fastcall CardOrderCountChanged(void);
	void __fastcall HandleSortSettingsChange(System::TObject* Sender);
	void __fastcall HandleFilterSettingsChange(System::TObject* Sender);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall Filter(void);
	void __fastcall Sort(void);
	void __fastcall Next(void);
	void __fastcall Previous(void);
	bool __fastcall GoToCard(TAdvCard* Card);
	void __fastcall HideAllArrows(TArrowWindow* ExcludeArrow);
	void __fastcall OleDragDrop(const Types::TPoint &p);
	tagSIZE __fastcall RatingSize(void);
	void __fastcall MoveCard(int FromIndex, int ToIndex);
	int __fastcall GetSortedIndex(TAdvCard* Card);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	__property bool CardRearrange = {read=FCardRearrange, write=SetCardRearrange, default=0};
	__property TAdvCard* DraggingCard = {read=FDraggingCard, write=FDraggingCard};
	__property int Rows = {read=FRows, nodefault};
	__property int TopRow = {read=FTopRow, write=SetTopRow, nodefault};
	__property int VisibleRows = {read=FViewedRows, nodefault};
	__property bool ArrowKeySelectFreedom = {read=FArrowKeySelectFreedom, write=FArrowKeySelectFreedom, default=0};
	__property Graphics::TColor ArrowColor = {read=GetArrowColor, write=SetArrowColor, nodefault};
	__property bool OleDropTarget = {read=FOleDropTarget, write=SetOleDropTarget, default=1};
	__property bool OleDropSource = {read=FOleDropSource, write=FOleDropSource, default=1};
	__property bool ShowDragImage = {read=FShowDragImage, write=FShowDragImage, default=1};
	__property TOleDragDropEvent OnOleDrop = {read=FOnOleDrop, write=FOnOleDrop};
	__property TOleDroppedEvent OnOleDropped = {read=FOnOleDropped, write=FOnOleDropped};
	__property TOleDragDropEvent OnOleDrag = {read=FOnOleDrag, write=FOnOleDrag};
	__property TOleDragOverEvent OnOleDragOver = {read=FOnOleDragOver, write=FOnOleDragOver};
	__property TOleDragStartEvent OnOleDragStart = {read=FOnOleDragStart, write=FOnOleDragStart};
	__property TOleDragStopEvent OnOleDragStop = {read=FOnOleDragStop, write=FOnOleDragStop};
	__property TCardRearrangedEvent OnCardRearranged = {read=FOnCardRearranged, write=FOnCardRearranged};
	
public:
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
	__property int CanvasRight = {read=FCanvasRight, nodefault};
	__property int Columns = {read=FColumns, nodefault};
	__property TAdvCards* Cards = {read=FCards};
	__property int LeftCol = {read=FLeftCol, write=SetLeftCol, nodefault};
	__property bool AutoEdit = {read=FAutoEdit, write=FAutoEdit, default=1};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=-16777206};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=1};
	__property TAdvCardAppearance* CardEditingAppearance = {read=FCardEditingAppearance, write=SetCardEditingAppearance};
	__property TAdvCardAppearance* CardNormalAppearance = {read=FCardNormalAppearance, write=SetCardNormalAppearance};
	__property TAdvCardAppearance* CardSelectedAppearance = {read=FCardSelectedAppearance, write=SetCardSelectedAppearance};
	__property TAdvCardAppearance* CardHoverAppearance = {read=FCardHoverAppearance, write=SetCardHoverAppearance};
	__property int CardHorSpacing = {read=FCardHorSpacing, write=SetCardHorSpacing, default=20};
	__property int CardVertSpacing = {read=FCardVertSpacing, write=SetCardVertSpacing, default=20};
	__property TAdvGradient* Color = {read=FColor, write=SetColor};
	__property bool ColumnSizing = {read=FColumnSizing, write=SetColumnSizing, default=1};
	__property int ColumnWidth = {read=FColumnWidth, write=SetColumnWidth, default=240};
	__property bool DelayedCardLoad = {read=FDelayedCardLoad, write=SetDelayedCardLoad, nodefault};
	__property int DelayedCardLoadInterval = {read=GetDelayedCardLoadTimerInterval, write=SetDelayedCardLoadTimerInterval, nodefault};
	__property bool Filtered = {read=FFiltered, write=SetFiltered, default=0};
	__property TAdvCardFilterSettings* FilterSettings = {read=FFilterSettings, write=SetFilterSettings};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=8421504};
	__property bool GotoSelectedAutomatic = {read=FGotoSelectedAutomatic, write=FGotoSelectedAutomatic, default=1};
	__property Graphics::TColor GridLineColor = {read=FGridLineColor, write=SetGridLineColor, default=-16777201};
	__property int GridLineWidth = {read=FGridLineWidth, write=SetGridLineWidth, default=3};
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property int MaxColumnWidth = {read=FMaxColumnWidth, write=SetMaxColumnWidth, default=0};
	__property int MinColumnWidth = {read=FMinColumnWidth, write=SetMinColumnWidth, default=150};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=0};
	__property int PageCount = {read=FPageCount, write=SetPageCount, default=4};
	__property TProgressAppearance* ProgressAppearance = {read=FProgressAppearance, write=SetProgressAppearance};
	__property Graphics::TPicture* RatingActive = {read=FRatingActive, write=SetRatingActive};
	__property Graphics::TPicture* RatingInactive = {read=FRatingInactive, write=SetRatingInactive};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property TScrollBarType ScrollBarType = {read=FScrollBarType, write=SetScrollBarType, default=0};
	__property bool ShowGridLine = {read=FShowGridLine, write=SetShowGridLine, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property bool ShowScrollBar = {read=FShowScrollBar, write=SetShowScrollBar, default=1};
	__property bool Sorted = {read=FSorted, write=SetSorted, default=1};
	__property TAdvCardSortSettings* SortSettings = {read=FSortSettings, write=SetSortSettings};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAdvCardDelayedLoad OnDelayedCardLoad = {read=FOnDelayedCardLoad, write=FOnDelayedCardLoad};
	__property TAdvCardItemAllowEvent OnCardStartEdit = {read=FOnCardStartEdit, write=FOnCardStartEdit};
	__property TAdvCardItemEvent OnCardEndEdit = {read=FOnCardEndEdit, write=FOnCardEndEdit};
	__property TAdvCardCaptionGetDisplText OnCardCaptionGetDisplText = {read=FOnCardCaptionGetDisplText, write=FOnCardCaptionGetDisplText};
	__property TAdvCardItemGetDisplText OnCardItemGetDisplText = {read=FOnCardItemGetDisplText, write=FOnCardItemGetDisplText};
	__property TAdvCardEvent OnCardCaptionClick = {read=FOnCardCaptionClick, write=FOnCardCaptionClick};
	__property TAdvCardEvent OnCardCaptionDblClick = {read=FOnCardCaptionDblClick, write=FOnCardCaptionDblClick};
	__property TAdvCardEvent OnCardClick = {read=FOnCardClick, write=FOnCardClick};
	__property TAdvCardEvent OnCardRightClick = {read=FOnCardRightClick, write=FOnCardRightClick};
	__property TAdvCardCompareEvent OnCardCompare = {read=FOnCardCompare, write=FOnCardCompare};
	__property TAdvCardEvent OnCardDblClick = {read=FOnCardDblClick, write=FOnCardDblClick};
	__property TAdvCardItemEvent OnCardItemClick = {read=FOnCardItemClick, write=FOnCardItemClick};
	__property TAdvCardItemEvent OnCardItemRightClick = {read=FOnCardItemRightClick, write=FOnCardItemRightClick};
	__property TAdvCardItemURLEvent OnCardItemURLClick = {read=FOnCardItemURLClick, write=FOnCardItemURLClick};
	__property TAdvCardColumnResizing OnColumnResizing = {read=FOnColumnResizing, write=FOnColumnResizing};
	__property TAdvCardDrawCardItem OnDrawCardItem = {read=FOnDrawCardItem, write=FOnDrawCardItem};
	__property TAdvCardDrawCardItemProp OnDrawCardItemProp = {read=FOnDrawCardItemProp, write=FOnDrawCardItemProp};
	__property TAdvCardItemAllowEvent OnShowCardItem = {read=FOnShowCardItem, write=FOnShowCardItem};
	__property TCardCheckChangeEvent OnCardCheckChange = {read=FOnCardCheckChange, write=FOnCardCheckChange};
	__property TCardRatingChangeEvent OnCardRatingChange = {read=FOnCardRatingChange, write=FOnCardRatingChange};
	__property TCardAppearanceEvent OnCardAppearance = {read=FOnCardAppearance, write=FOnCardAppearance};
	__fastcall virtual TCustomAdvCardList(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomAdvCardList(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	TAdvCard* __fastcall CardAtXY(int x, int y, bool OnlyViewed);
	__property TAdvCardTemplate* CardTemplate = {read=FCardTemplate, write=SetCardTemplate};
	int __fastcall ItemAtXY(int x, int y, TAdvCard* Card);
	void __fastcall DeSelectAll(void);
	void __fastcall SelectAll(void);
	void __fastcall SelectCard(int CardIndex, bool Select);
	virtual TAdvCard* __fastcall FindCard(System::UnicodeString BeginWith);
	bool __fastcall IsCardCurrentlyDisplayed(TAdvCard* Card);
	bool __fastcall GoToSelected(void);
	void __fastcall StartEdit(const Types::TRect &EditRect, int CardIndex, int ItemIndex, const System::Variant &Value, System::WideChar StartChar);
	void __fastcall CancelEditing(void);
	void __fastcall DoneEdit(const System::Variant &Value);
	int __fastcall VisibleCardCount(void);
	__property int VisibleColumns = {read=FViewedColumns, nodefault};
	__property bool Editing = {read=GetEditing, nodefault};
	__property TAdvCard* SelectedCard = {read=FSelectedCard};
	__property int SelectedCount = {read=FSelectedCount, nodefault};
	__property int SelectedIndex = {read=FSelectedIndex, write=SetSelectedIndex, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomAdvCardList(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvCardList;
class PASCALIMPLEMENTATION TAdvCardList : public TCustomAdvCardList
{
	typedef TCustomAdvCardList inherited;
	
public:
	__property Columns;
	__property Cards;
	__property LeftCol;
	__property Rows;
	__property TopRow;
	__property ArrowKeySelectFreedom = {default=0};
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Enabled = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property HelpContext = {default=0};
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property BiDiMode;
	__property Constraints;
	__property DockOrientation;
	__property ShowHint;
	__property Visible = {default=1};
	__property Left;
	__property Top;
	__property Width;
	__property Height;
	__property Cursor = {default=0};
	__property Hint;
	__property PopupMenu;
	__property AutoEdit = {default=1};
	__property BorderColor = {default=-16777206};
	__property BorderWidth = {default=1};
	__property CardEditingAppearance;
	__property CardNormalAppearance;
	__property CardSelectedAppearance;
	__property CardHoverAppearance;
	__property CardHorSpacing = {default=20};
	__property CardRearrange = {default=0};
	__property CardTemplate;
	__property CardVertSpacing = {default=20};
	__property Color;
	__property ColumnSizing = {default=1};
	__property ColumnWidth = {default=240};
	__property DelayedCardLoad;
	__property DelayedCardLoadInterval;
	__property Filtered = {default=0};
	__property FilterSettings;
	__property FocusColor = {default=8421504};
	__property GotoSelectedAutomatic = {default=1};
	__property GridLineColor = {default=-16777201};
	__property GridLineWidth = {default=3};
	__property Images;
	__property MaxColumnWidth = {default=0};
	__property MinColumnWidth = {default=150};
	__property MultiSelect = {default=0};
	__property ShowDragImage = {default=1};
	__property ProgressAppearance;
	__property PageCount = {default=4};
	__property RatingActive;
	__property RatingInactive;
	__property ReadOnly = {default=0};
	__property ScrollBarType = {default=0};
	__property ShowGridLine = {default=1};
	__property ShowFocus = {default=1};
	__property ShowScrollBar = {default=1};
	__property Sorted = {default=1};
	__property SortSettings;
	__property URLColor = {default=16711680};
	__property Version;
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnDelayedCardLoad;
	__property OnCardAppearance;
	__property OnCardStartEdit;
	__property OnCardEndEdit;
	__property OnCardCaptionGetDisplText;
	__property OnCardItemGetDisplText;
	__property OnCardCaptionClick;
	__property OnCardCaptionDblClick;
	__property OnCardClick;
	__property OnCardRatingChange;
	__property OnCardRightClick;
	__property OnCardCheckChange;
	__property OnCardCompare;
	__property OnCardDblClick;
	__property OnCardItemClick;
	__property OnCardItemRightClick;
	__property OnCardItemURLClick;
	__property OnCardRearranged;
	__property OnColumnResizing;
	__property OnDrawCardItem;
	__property OnDrawCardItemProp;
	__property OnShowCardItem;
public:
	/* TCustomAdvCardList.Create */ inline __fastcall virtual TAdvCardList(Classes::TComponent* AOwner) : TCustomAdvCardList(AOwner) { }
	/* TCustomAdvCardList.Destroy */ inline __fastcall virtual ~TAdvCardList(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCardList(HWND ParentWindow) : TCustomAdvCardList(ParentWindow) { }
	
};


#pragma option push -b-
enum TFontDirection { fdHorizontal, fdVertical };
#pragma option pop

class DELPHICLASS TAdvButton;
class PASCALIMPLEMENTATION TAdvButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	HFONT FFont;
	int FBorderWidth;
	System::UnicodeString FCaption;
	TFontDirection FFontDirection;
	void __fastcall SetBorderWidth(int Value);
	void __fastcall SetCaption(System::UnicodeString Value);
	void __fastcall SetFontDirection(TFontDirection Value);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	void __fastcall ReCreateFont(void);
	
public:
	System::UnicodeString Symbols;
	__fastcall virtual TAdvButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvButton(void);
	
__published:
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=3};
	__property TFontDirection FontDirection = {read=FFontDirection, write=SetFontDirection, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
};


typedef void __fastcall (__closure *TAdvButtonClickEvent)(System::TObject* Sender, int ButtonIndex, System::UnicodeString ButtonCaption);

#pragma option push -b-
enum TAdvBarAlignment { baHorizontal, baVertical };
#pragma option pop

#pragma option push -b-
enum TAdvBarButtonDirection { bdHorizontal, bdVertical };
#pragma option pop

class DELPHICLASS TAdvButtonsBar;
class PASCALIMPLEMENTATION TAdvButtonsBar : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	typedef DynamicArray<TAdvButton*> _TAdvButtonsBar__1;
	
	
private:
	_TAdvButtonsBar__1 FButtons;
	System::UnicodeString FAlphabet;
	TAdvBarAlignment FBarAlignment;
	int FBorderWidth;
	int FButBorderWidth;
	TAdvBarButtonDirection FButtonDirection;
	int FButtonGap;
	int FButtonSize;
	TCustomAdvCardList* FCardList;
	bool FFlat;
	bool FShowNumButton;
	TAdvButtonClickEvent FOnButtonClick;
	void __fastcall SetAlphabet(System::UnicodeString Value);
	void __fastcall SetBarAlignment(TAdvBarAlignment Value);
	HIDESBASE void __fastcall SetBorderWidth(int Value);
	void __fastcall SetButBorderWidth(int Value);
	void __fastcall SetButtonDirection(TAdvBarButtonDirection Value);
	void __fastcall SetButtonGap(int Value);
	void __fastcall SetButtonSize(int Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetShowNumButton(bool Value);
	void __fastcall Adjust(void);
	void __fastcall HandleButtonClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	
public:
	__fastcall virtual TAdvButtonsBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvButtonsBar(void);
	int __fastcall ButtonCount(void);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Color = {default=-16777211};
	__property Font;
	__property Enabled = {default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property HelpContext = {default=0};
	__property Constraints;
	__property ShowHint;
	__property Visible = {default=1};
	__property Left;
	__property Top;
	__property Width;
	__property Height;
	__property Cursor = {default=0};
	__property Hint;
	__property PopupMenu;
	__property System::UnicodeString Alphabet = {read=FAlphabet, write=SetAlphabet};
	__property TAdvBarAlignment BarAlignment = {read=FBarAlignment, write=SetBarAlignment, default=1};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=10};
	__property int ButBorderWidth = {read=FButBorderWidth, write=SetButBorderWidth, default=3};
	__property TAdvBarButtonDirection ButtonDirection = {read=FButtonDirection, write=SetButtonDirection, default=0};
	__property int ButtonGap = {read=FButtonGap, write=SetButtonGap, default=5};
	__property int ButtonSize = {read=FButtonSize, write=SetButtonSize, default=25};
	__property TCustomAdvCardList* CardList = {read=FCardList, write=FCardList};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool ShowNumButton = {read=FShowNumButton, write=SetShowNumButton, default=1};
	__property OnCanResize;
	__property OnClick;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnEnter;
	__property OnExit;
	__property TAdvButtonClickEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvButtonsBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE System::ResourceString _SResInvalidItemName;
#define Advcardlist_SResInvalidItemName System::LoadResourceString(&Advcardlist::_SResInvalidItemName)
extern PACKAGE System::ResourceString _SResInvalidOperation;
#define Advcardlist_SResInvalidOperation System::LoadResourceString(&Advcardlist::_SResInvalidOperation)
extern PACKAGE System::ResourceString _SResInvalidEditor;
#define Advcardlist_SResInvalidEditor System::LoadResourceString(&Advcardlist::_SResInvalidEditor)
extern PACKAGE System::ResourceString _SResDefAlphabet;
#define Advcardlist_SResDefAlphabet System::LoadResourceString(&Advcardlist::_SResDefAlphabet)
extern PACKAGE System::ResourceString _SResDesignNoItemCaption;
#define Advcardlist_SResDesignNoItemCaption System::LoadResourceString(&Advcardlist::_SResDesignNoItemCaption)
extern PACKAGE System::ResourceString _SResDesignNoItemDefValue;
#define Advcardlist_SResDesignNoItemDefValue System::LoadResourceString(&Advcardlist::_SResDesignNoItemDefValue)
extern PACKAGE System::ResourceString _SResTrue;
#define Advcardlist_SResTrue System::LoadResourceString(&Advcardlist::_SResTrue)
extern PACKAGE System::ResourceString _SResFalse;
#define Advcardlist_SResFalse System::LoadResourceString(&Advcardlist::_SResFalse)

}	/* namespace Advcardlist */
using namespace Advcardlist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcardlistHPP
