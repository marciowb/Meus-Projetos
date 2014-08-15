// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothimagelistbox.pas' rev: 21.00

#ifndef AdvsmoothimagelistboxHPP
#define AdvsmoothimagelistboxHPP

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
#include <Activex.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advsmoothimagelistboxdragdrop.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothimagelistbox
{
//-- type declarations -------------------------------------------------------
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


class DELPHICLASS TImageLoaderThread;
class DELPHICLASS TAdvSmoothImageListBox;
class PASCALIMPLEMENTATION TImageLoaderThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TAdvSmoothImageListBox* ImageListBox;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TImageLoaderThread(TAdvSmoothImageListBox* AImageListBox);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TImageLoaderThread(void) { }
	
};


#pragma option push -b-
enum TImageThreadStatus { stNone, stInitialized, stStarted, stLoaded };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothImageListBoxLocation { cpTopLeft, cpTopCenter, cpTopRight, cpCenterLeft, cpCenterCenter, cpCenterRight, cpBottomLeft, cpBottomCenter, cpBottomRight, cpCustom };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothImageListBoxImageState { isDefault, isLoaded, isResizedLarger };
#pragma option pop

class DELPHICLASS TAdvSmoothImageListBoxTopLayerItem;
class DELPHICLASS TAdvSmoothImageListBoxHTMLText;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxTopLayerItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvSmoothImageListBox* Fowner;
	Controls::TAlign FAlign;
	TAdvSmoothImageListBoxHTMLText* FHTMLText;
	int FWidth;
	bool FVisible;
	int FTop;
	int FHeight;
	int FLeft;
	Gdipfill::TGDIPFill* FFill;
	int FTag;
	System::TObject* FItemObject;
	void __fastcall SetAlign(const Controls::TAlign Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetHTMLText(const TAdvSmoothImageListBoxHTMLText* Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall HTMLTextChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	
public:
	__fastcall virtual TAdvSmoothImageListBoxTopLayerItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothImageListBoxTopLayerItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property TAdvSmoothImageListBoxHTMLText* HTMLText = {read=FHTMLText, write=SetHTMLText};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Controls::TAlign Align = {read=FAlign, write=SetAlign, default=6};
	__property int Width = {read=FWidth, write=SetWidth, default=100};
	__property int Height = {read=FHeight, write=SetHeight, default=100};
	__property System::TObject* ItemObject = {read=FItemObject, write=FItemObject};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TAdvSmoothImageListBoxTopLayerItems;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxTopLayerItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothImageListBoxTopLayerItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothImageListBox* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothImageListBoxTopLayerItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothImageListBoxTopLayerItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothImageListBoxTopLayerItems(TAdvSmoothImageListBox* AOwner);
	HIDESBASE TAdvSmoothImageListBoxTopLayerItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothImageListBoxTopLayerItem* __fastcall Insert(int Index);
	__property TAdvSmoothImageListBoxTopLayerItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothImageListBoxTopLayerItems(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothImageListBoxSplitterState { stExpanded, stCollapsed };
#pragma option pop

class DELPHICLASS TAdvSmoothImageListBoxItem;
typedef DynamicArray<TAdvSmoothImageListBoxItem*> TAdvSmoothImageListBoxItemArray;

class PASCALIMPLEMENTATION TAdvSmoothImageListBoxItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FCollapsed;
	int FSelExp;
	int FHovExp;
	bool FMouseEntered;
	bool FMouseLeft;
	bool FGoToNormalState;
	bool FDoubleClicked;
	int FX;
	int FxTo;
	int FY;
	int FYTo;
	int FWidth;
	int FWidthTo;
	int FHeight;
	int FHeightTo;
	Advgdip::TGPImage* FCachedNormal;
	int FCachedMaxWidth;
	int FCachedMaxHeight;
	float FOriginalImageWidth;
	float FOriginalImageHeight;
	TImageThreadStatus FThreadStatus;
	TAdvSmoothImageListBox* FOwner;
	Advgdip::TGPRectF FItemRect;
	Advgdip::TAdvGDIPPicture* FImage;
	TAdvSmoothImageListBoxHTMLText* FCaption;
	int FTag;
	bool FSplitter;
	System::UnicodeString FLocation;
	bool FEnabled;
	System::UnicodeString FHint;
	bool FVisible;
	System::UnicodeString FSplitterText;
	System::TDateTime FFileDate;
	int FFileSize;
	System::UnicodeString FFileName;
	TAdvSmoothImageListBoxSplitterState FSplitterState;
	bool FSelected;
	bool FHasPalette;
	bool FHasAlphaChannel;
	int FPixelDepth;
	int FPixelFormat;
	void __fastcall SetImage(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetCaption(const TAdvSmoothImageListBoxHTMLText* Value);
	void __fastcall SetSplitter(bool Value);
	void __fastcall SetTag(const int Value);
	void __fastcall SetLocation(const System::UnicodeString Value);
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetVisible(bool Value);
	void __fastcall SetSplitterText(const System::UnicodeString Value);
	void __fastcall SetFileDate(const System::TDateTime Value);
	void __fastcall SetFileSize(const int Value);
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetSplitterState(const TAdvSmoothImageListBoxSplitterState Value);
	void __fastcall SetSelected(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall ImageChanged(System::TObject* Sender);
	void __fastcall CaptionChanged(System::TObject* Sender);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, bool dblclicked);
	void __fastcall DrawSplitter(Advgdip::TGPGraphics* g, TAdvSmoothImageListBoxHTMLText* h, const Advgdip::TGPRectF &r);
	void __fastcall DrawExpander(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, int Down, int Hover);
	void __fastcall ExpanderTextRect(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &rText, Advgdip::TGPRectF &rTextArea);
	void __fastcall SetInternalHint(System::UnicodeString Value);
	void __fastcall SetInternalCaptionText(System::UnicodeString Value);
	void __fastcall LoadImageFromStream(Classes::TStream* s);
	__property Advgdip::TGPImage* CachedNormal = {read=FCachedNormal};
	__property Advgdip::TGPRectF ItemRect = {read=FItemRect};
	
public:
	__fastcall virtual TAdvSmoothImageListBoxItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothImageListBoxItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	int __fastcall GetOriginalImageWidth(void);
	int __fastcall GetOriginalImageHeight(void);
	__property int PixelFormat = {read=FPixelFormat, nodefault};
	__property int PixelDepth = {read=FPixelDepth, nodefault};
	__property bool HasPalette = {read=FHasPalette, nodefault};
	__property bool HasAlphaChannel = {read=FHasAlphaChannel, nodefault};
	Advgdip::TGPRectF __fastcall GetImageRectangle(void);
	
__published:
	__property TAdvSmoothImageListBoxSplitterState SplitterState = {read=FSplitterState, write=SetSplitterState, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Advgdip::TAdvGDIPPicture* Image = {read=FImage, write=SetImage};
	__property System::UnicodeString Location = {read=FLocation, write=SetLocation};
	__property int FileSize = {read=FFileSize, write=SetFileSize, default=0};
	__property System::TDateTime FileDate = {read=FFileDate, write=SetFileDate};
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
	__property bool Splitter = {read=FSplitter, write=SetSplitter, default=0};
	__property int Tag = {read=FTag, write=SetTag, default=0};
	__property TAdvSmoothImageListBoxHTMLText* Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString SplitterText = {read=FSplitterText, write=SetSplitterText};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property bool Selected = {read=FSelected, write=SetSelected, default=0};
};


class DELPHICLASS TAdvSmoothImageListBoxItems;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothImageListBoxItem* operator[](int Index) { return Items[Index]; }
	
private:
	int FUpdateCount;
	TAdvSmoothImageListBox* FOwner;
	Classes::TNotifyEvent FOnChange;
	bool FInternalCall;
	HIDESBASE TAdvSmoothImageListBoxItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothImageListBoxItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	virtual int __fastcall Compare(TAdvSmoothImageListBoxItem* Item1, TAdvSmoothImageListBoxItem* Item2);
	void __fastcall QuickSort(int L, int R);
	__property bool InternalCall = {read=FInternalCall, write=FInternalCall, default=0};
	
public:
	__fastcall TAdvSmoothImageListBoxItems(TAdvSmoothImageListBox* AOwner);
	HIDESBASE TAdvSmoothImageListBoxItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothImageListBoxItem* __fastcall Insert(int Index);
	__property TAdvSmoothImageListBoxItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE void __fastcall Clear(void);
	void __fastcall Sort(void);
	int __fastcall Find(const System::UnicodeString s);
	virtual void __fastcall BeginUpdate(void);
	virtual void __fastcall EndUpdate(void);
	bool __fastcall HasSplitters(void);
	bool __fastcall HasItems(void);
	int __fastcall FirstSplitter(void);
	int __fastcall NextSplitter(int index);
	int __fastcall FirstItem(void);
	int __fastcall NextItem(int index);
	void __fastcall SelectAll(void);
	void __fastcall UnSelectAll(void);
	void __fastcall Select(int *AItems, const int AItems_Size);
	TAdvSmoothImageListBoxItemArray __fastcall SelectedItems(void);
	int __fastcall CountSelected(void);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothImageListBoxItems(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothImageListBoxNavigatorButtonsShape { nsRounded, nsRoundRect, nsRect };
#pragma option pop

#pragma option push -b-
enum TImageStretch { isAlways, isShrinkOnly };
#pragma option pop

class DELPHICLASS TAdvSmoothImageListBoxSplitter;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxSplitter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothImageListBox* FOwner;
	int FSpacing;
	Gdipfill::TGDIPFill* FFill;
	int FSize;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothImageListBoxNavigatorButtonsShape FExpanderShape;
	Graphics::TColor FExpanderColor;
	Graphics::TColor FExpanderHoverColor;
	int FExpanderSize;
	Graphics::TColor FExpanderDownColor;
	bool FExpander;
	TAdvSmoothImageListBoxLocation FExpanderLocation;
	Graphics::TColor FExpanderBorderColor;
	int FExpanderTop;
	int FExpanderLeft;
	Graphics::TFont* FTextFont;
	TAdvSmoothImageListBoxLocation FTextLocation;
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetExpander(const bool Value);
	void __fastcall SetExpanderColor(const Graphics::TColor Value);
	void __fastcall SetExpanderDownColor(const Graphics::TColor Value);
	void __fastcall SetExpanderHoverColor(const Graphics::TColor Value);
	void __fastcall SetExpanderLocation(const TAdvSmoothImageListBoxLocation Value);
	void __fastcall SetExpanderShape(const TAdvSmoothImageListBoxNavigatorButtonsShape Value);
	void __fastcall SetExpanderSize(const int Value);
	void __fastcall SetExpanderBorderColor(const Graphics::TColor Value);
	void __fastcall SetExpanderLeft(const int Value);
	void __fastcall SetExpanderTop(const int Value);
	void __fastcall SetTextFont(const Graphics::TFont* Value);
	void __fastcall SetTextLocation(const TAdvSmoothImageListBoxLocation Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall TextFontChanged(System::TObject* Sender);
	Advgdip::TGPRectF __fastcall GetExpanderRect(const Advgdip::TGPRectF &r);
	Advgdip::TGPRectF __fastcall GetRect(const Advgdip::TGPRectF &r);
	
public:
	__fastcall TAdvSmoothImageListBoxSplitter(TAdvSmoothImageListBox* AOwner);
	__fastcall virtual ~TAdvSmoothImageListBoxSplitter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=10};
	__property int Size = {read=FSize, write=SetSize, default=3};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property TAdvSmoothImageListBoxLocation TextLocation = {read=FTextLocation, write=SetTextLocation, default=3};
	__property Graphics::TFont* TextFont = {read=FTextFont, write=SetTextFont};
	__property bool Expander = {read=FExpander, write=SetExpander, default=0};
	__property Graphics::TColor ExpanderColor = {read=FExpanderColor, write=SetExpanderColor, default=8421504};
	__property Graphics::TColor ExpanderBorderColor = {read=FExpanderBorderColor, write=SetExpanderBorderColor, default=0};
	__property Graphics::TColor ExpanderDownColor = {read=FExpanderDownColor, write=SetExpanderDownColor, default=16711680};
	__property Graphics::TColor ExpanderHoverColor = {read=FExpanderHoverColor, write=SetExpanderHoverColor, default=255};
	__property int ExpanderSize = {read=FExpanderSize, write=SetExpanderSize, default=20};
	__property TAdvSmoothImageListBoxNavigatorButtonsShape ExpanderShape = {read=FExpanderShape, write=SetExpanderShape, default=0};
	__property TAdvSmoothImageListBoxLocation ExpanderLocation = {read=FExpanderLocation, write=SetExpanderLocation, default=5};
	__property int ExpanderLeft = {read=FExpanderLeft, write=SetExpanderLeft, default=0};
	__property int ExpanderTop = {read=FExpanderTop, write=SetExpanderTop, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothImageListBoxItemAppearance;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxItemAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Advgdip::TGPBitmap* FCachedFill;
	Advgdip::TGPBitmap* FCachedSelectedFill;
	Advgdip::TGPBitmap* FCachedDisabledFill;
	Advgdip::TGPBitmap* FCachedHoveredFill;
	TAdvSmoothImageListBox* FOwner;
	Classes::TNotifyEvent FOnChange;
	int FItemHorizontalSpacing;
	int FItemVerticalSpacing;
	Gdipfill::TGDIPFill* FDisabledFill;
	Gdipfill::TGDIPFill* FSelectedFill;
	Gdipfill::TGDIPFill* FFill;
	Gdipfill::TGDIPFill* FHoverFill;
	int FItemHeight;
	int FItemWidth;
	int FHoverSize;
	int FTextWidth;
	Controls::TMargins* FImageMargin;
	int FImageTop;
	int FImageHeight;
	int FImageLeft;
	Controls::TMargins* FTextMargin;
	int FTextTop;
	int FTextHeight;
	int FTextLeft;
	int FImageWidth;
	Controls::TAlign FImageAlign;
	Controls::TAlign FTextAlign;
	bool FAutoSize;
	TAdvSmoothImageListBoxSplitter* FSplitter;
	bool FTextVisible;
	bool FImageVisible;
	bool FAspectRatio;
	TImageStretch FStretch;
	void __fastcall SetItemHorizontalSpacing(const int Value);
	void __fastcall SetItemVerticalSpacing(const int Value);
	void __fastcall SetDisabledFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSelectedFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHoverFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetItemWidth(const int Value);
	void __fastcall SetHoverSize(const int Value);
	void __fastcall SetImageHeight(const int Value);
	void __fastcall SetImageLeft(const int Value);
	void __fastcall SetImageMargin(const Controls::TMargins* Value);
	void __fastcall SetImageTop(const int Value);
	void __fastcall SetImageWidth(const int Value);
	void __fastcall SetTextHeight(const int Value);
	void __fastcall SetTextLeft(const int Value);
	void __fastcall SetTextMargin(const Controls::TMargins* Value);
	void __fastcall SetTextTop(const int Value);
	void __fastcall SetTextWidth(const int Value);
	void __fastcall SetImageAlign(const Controls::TAlign Value);
	void __fastcall SetTextAlign(const Controls::TAlign Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetSplitter(const TAdvSmoothImageListBoxSplitter* Value);
	void __fastcall SetImageVisible(const bool Value);
	void __fastcall SetTextVisible(const bool Value);
	void __fastcall SetAspectRatio(const bool Value);
	void __fastcall SetStretch(const TImageStretch Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall SelectedFillChanged(System::TObject* Sender);
	void __fastcall DisabledFillChanged(System::TObject* Sender);
	void __fastcall HoveredFillChanged(System::TObject* Sender);
	void __fastcall SplitterChanged(System::TObject* Sender);
	void __fastcall MarginChanged(System::TObject* Sender);
	void __fastcall InitFills(void);
	void __fastcall CheckItemWidth(void);
	void __fastcall CheckItemHeight(void);
	void __fastcall DrawFocusRect(Gdipfill::TGDIPFill* f, Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	int __fastcall GetRowHeight(void);
	int __fastcall GetColumnWidth(void);
	
public:
	__fastcall TAdvSmoothImageListBoxItemAppearance(TAdvSmoothImageListBox* AOwner);
	__fastcall virtual ~TAdvSmoothImageListBoxItemAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=0};
	__property bool AspectRatio = {read=FAspectRatio, write=SetAspectRatio, default=1};
	__property bool ImageVisible = {read=FImageVisible, write=SetImageVisible, default=1};
	__property Controls::TAlign ImageAlign = {read=FImageAlign, write=SetImageAlign, default=5};
	__property Controls::TMargins* ImageMargin = {read=FImageMargin, write=SetImageMargin};
	__property int ImageLeft = {read=FImageLeft, write=SetImageLeft, default=10};
	__property int ImageTop = {read=FImageTop, write=SetImageTop, default=10};
	__property int ImageWidth = {read=FImageWidth, write=SetImageWidth, default=50};
	__property int ImageHeight = {read=FImageHeight, write=SetImageHeight, default=50};
	__property bool TextVisible = {read=FTextVisible, write=SetTextVisible, default=0};
	__property Controls::TAlign TextAlign = {read=FTextAlign, write=SetTextAlign, default=2};
	__property Controls::TMargins* TextMargin = {read=FTextMargin, write=SetTextMargin};
	__property int TextLeft = {read=FTextLeft, write=SetTextLeft, default=10};
	__property int TextTop = {read=FTextTop, write=SetTextTop, default=10};
	__property int TextWidth = {read=FTextWidth, write=SetTextWidth, default=10};
	__property int TextHeight = {read=FTextHeight, write=SetTextHeight, default=10};
	__property int ItemWidth = {read=FItemWidth, write=SetItemWidth, default=70};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, default=70};
	__property int ItemVerticalSpacing = {read=FItemVerticalSpacing, write=SetItemVerticalSpacing, default=10};
	__property int ItemHorizontalSpacing = {read=FItemHorizontalSpacing, write=SetItemHorizontalSpacing, default=10};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Gdipfill::TGDIPFill* SelectedFill = {read=FSelectedFill, write=SetSelectedFill};
	__property Gdipfill::TGDIPFill* DisabledFill = {read=FDisabledFill, write=SetDisabledFill};
	__property Gdipfill::TGDIPFill* HoverFill = {read=FHoverFill, write=SetHoverFill};
	__property int HoverSize = {read=FHoverSize, write=SetHoverSize, default=0};
	__property TAdvSmoothImageListBoxSplitter* Splitter = {read=FSplitter, write=SetSplitter};
	__property TImageStretch Stretch = {read=FStretch, write=SetStretch, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION TAdvSmoothImageListBoxHTMLText : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FDisableRepaint;
	TAdvSmoothImageListBox* FOwner;
	Graphics::TColor FURLColor;
	int FShadowOffset;
	Graphics::TFont* FFont;
	System::UnicodeString FText;
	Graphics::TColor FShadowColor;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothImageListBoxLocation FLocation;
	int FTop;
	int FLeft;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetURLColor(const Graphics::TColor Value);
	void __fastcall SetLocation(const TAdvSmoothImageListBoxLocation Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothImageListBoxHTMLText(TAdvSmoothImageListBox* AOwner);
	__fastcall virtual ~TAdvSmoothImageListBoxHTMLText(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TAdvSmoothImageListBoxLocation Location = {read=FLocation, write=SetLocation, default=3};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property Graphics::TColor URLColor = {read=FURLColor, write=SetURLColor, default=16711680};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, default=5};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TAdvSmoothImageListBoxItemKind { ikItem, ikSplitter };
#pragma option pop

class DELPHICLASS TAdvSmoothImageListBoxDisplayListItem;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxDisplayListItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Advgdip::TGPRectF FRectangle;
	TAdvSmoothImageListBoxItemKind FKind;
	TAdvSmoothImageListBoxItem* FItem;
	void __fastcall SetKind(const TAdvSmoothImageListBoxItemKind Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__property TAdvSmoothImageListBoxItemKind Kind = {read=FKind, write=SetKind, nodefault};
	__property TAdvSmoothImageListBoxItem* DisplayItem = {read=FItem, write=FItem};
	__property Advgdip::TGPRectF Rectangle = {read=FRectangle, write=FRectangle};
public:
	/* TObject.Create */ inline __fastcall TAdvSmoothImageListBoxDisplayListItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvSmoothImageListBoxDisplayListItem(void) { }
	
};


class DELPHICLASS TAdvSmoothImageListBoxDisplayList;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxDisplayList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	virtual void __fastcall Clear(void);
	void __fastcall DeleteItem(int index);
	TAdvSmoothImageListBoxDisplayListItem* __fastcall AddItem(void);
	TAdvSmoothImageListBoxDisplayListItem* __fastcall GetItem(int index);
public:
	/* TList.Destroy */ inline __fastcall virtual ~TAdvSmoothImageListBoxDisplayList(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TAdvSmoothImageListBoxDisplayList(void) : Classes::TList() { }
	
};


class DELPHICLASS TAdvSmoothImageListBoxNavigator;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxNavigator : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothImageListBox* FOwner;
	TAdvSmoothImageListBoxNavigatorButtonsShape FShape;
	Graphics::TColor FColor;
	Graphics::TColor FHoverColor;
	bool FVisible;
	int FSize;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothImageListBoxLocation FLocation;
	int FLeft;
	int FTop;
	Graphics::TColor FDownColor;
	Graphics::TColor FBorderColor;
	Graphics::TColor FDisabledColor;
	System::UnicodeString FHintNext;
	System::UnicodeString FHintPreviousPage;
	System::UnicodeString FHintPrevious;
	System::UnicodeString FHintNextPage;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetHoverColor(const Graphics::TColor Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetShape(const TAdvSmoothImageListBoxNavigatorButtonsShape Value);
	void __fastcall SetLocation(const TAdvSmoothImageListBoxLocation Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetDownColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetDisabledColor(const Graphics::TColor Value);
	void __fastcall SetHintNext(const System::UnicodeString Value);
	void __fastcall SetHintNextPage(const System::UnicodeString Value);
	void __fastcall SetHintPrevious(const System::UnicodeString Value);
	void __fastcall SetHintPreviousPage(const System::UnicodeString Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall Draw(const Advgdip::TGPRectF &r, int Down, int Hover);
	Advgdip::TGPRectF __fastcall GetNavigatorButtonRect(const Advgdip::TGPRectF &r, int Button);
	Advgdip::TGPRectF __fastcall GetNavigatorRect(const Advgdip::TGPRectF &r, TAdvSmoothImageListBoxLocation TextLocation, const Advgdip::TGPRectF &TextRect);
	
public:
	__fastcall TAdvSmoothImageListBoxNavigator(TAdvSmoothImageListBox* AOwner);
	__fastcall virtual ~TAdvSmoothImageListBoxNavigator(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=8421504};
	__property System::UnicodeString HintNext = {read=FHintNext, write=SetHintNext};
	__property System::UnicodeString HintPrevious = {read=FHintPrevious, write=SetHintPrevious};
	__property System::UnicodeString HintNextPage = {read=FHintNextPage, write=SetHintNextPage};
	__property System::UnicodeString HintPreviousPage = {read=FHintPreviousPage, write=SetHintPreviousPage};
	__property Graphics::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, nodefault};
	__property Graphics::TColor HoverColor = {read=FHoverColor, write=SetHoverColor, default=16711680};
	__property Graphics::TColor DownColor = {read=FDownColor, write=SetDownColor, default=255};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property int Size = {read=FSize, write=SetSize, default=20};
	__property TAdvSmoothImageListBoxNavigatorButtonsShape Shape = {read=FShape, write=SetShape, default=1};
	__property TAdvSmoothImageListBoxLocation Location = {read=FLocation, write=SetLocation, default=5};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothImageListBoxHeader;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxHeader : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothImageListBox* FOwner;
	System::UnicodeString FCaption;
	TAdvSmoothImageListBoxLocation FCaptionLocation;
	Gdipfill::TGDIPFill* FFill;
	int FHeight;
	Classes::TNotifyEvent FOnChange;
	bool FVisible;
	int FCaptionTop;
	int FCaptionLeft;
	Graphics::TFont* FFont;
	TAdvSmoothImageListBoxNavigator* FNavigator;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCaptionLocation(const TAdvSmoothImageListBoxLocation Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetNavigator(const TAdvSmoothImageListBoxNavigator* Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall NavigatorChanged(System::TObject* Sender);
	int __fastcall GetHeight(void);
	Advgdip::TGPRectF __fastcall GetRect(void);
	
public:
	__fastcall TAdvSmoothImageListBoxHeader(TAdvSmoothImageListBox* AOwner);
	__fastcall virtual ~TAdvSmoothImageListBoxHeader(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property TAdvSmoothImageListBoxLocation CaptionLocation = {read=FCaptionLocation, write=SetCaptionLocation, default=4};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Height = {read=FHeight, write=SetHeight, default=50};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TAdvSmoothImageListBoxNavigator* Navigator = {read=FNavigator, write=SetNavigator};
};


class DELPHICLASS TAdvSmoothImageListBoxFooter;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxFooter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothImageListBox* FOwner;
	System::UnicodeString FCaption;
	TAdvSmoothImageListBoxLocation FCaptionLocation;
	Gdipfill::TGDIPFill* FFill;
	int FHeight;
	Classes::TNotifyEvent FOnChange;
	bool FVisible;
	int FCaptionTop;
	int FCaptionLeft;
	Graphics::TFont* FFont;
	TAdvSmoothImageListBoxNavigator* FNavigator;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCaptionLocation(const TAdvSmoothImageListBoxLocation Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetNavigator(const TAdvSmoothImageListBoxNavigator* Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall NavigatorChanged(System::TObject* Sender);
	int __fastcall GetHeight(void);
	Advgdip::TGPRectF __fastcall GetRect(void);
	
public:
	__fastcall TAdvSmoothImageListBoxFooter(TAdvSmoothImageListBox* AOwner);
	__fastcall virtual ~TAdvSmoothImageListBoxFooter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property TAdvSmoothImageListBoxLocation CaptionLocation = {read=FCaptionLocation, write=SetCaptionLocation, default=4};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Height = {read=FHeight, write=SetHeight, default=50};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TAdvSmoothImageListBoxNavigator* Navigator = {read=FNavigator, write=SetNavigator};
};


#pragma option push -b-
enum TAdvSmoothImageThreadLoading { tlAll, tlOnDemand, tlOnDemandAfterAnimation };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothImageListBoxNavigationMode { nmNone, nmPrior, nmPriorPage, nmNext, nmNextPage };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothImageListBoxItemClickEvent)(System::TObject* Sender, int itemindex, Controls::TMouseButton Button, Classes::TShiftState Shift);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxItemEvent)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxItemDrawEvent)(System::TObject* Sender, int itemindex, const Advgdip::TGPRectF &AItemRect, const Advgdip::TGPRectF &AImageRect, Advgdip::TGPGraphics* g);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxNavigateEvent)(System::TObject* Sender, TAdvSmoothImageListBoxNavigationMode NavigationMode, bool &allow);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxItemHintEvent)(System::TObject* Sender, int itemindex, System::UnicodeString &hint);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxItemTextEvent)(System::TObject* Sender, int itemindex, System::UnicodeString &text);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxItemZoomEvent)(System::TObject* Sender, int itemindex, bool &allow);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxScrollEvent)(System::TObject* Sender, int scrollposition);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxItemAnchorEvent)(System::TObject* Sender, int itemindex, System::UnicodeString Anchor);

#pragma option push -b-
enum TAdvSmoothImageListBoxZoomMode { zmFullScreen, zmAspectRatio };
#pragma option pop

struct TItemAnchor
{
	
public:
	int itemindex;
	System::UnicodeString anchor;
};


#pragma option push -b-
enum TDragMode { dmDrag, dmRelease };
#pragma option pop

typedef TMetaClass* TDropDownControlClass;

class DELPHICLASS TAdvSmoothImageListBoxDropTarget;
class PASCALIMPLEMENTATION TAdvSmoothImageListBoxDropTarget : public Advsmoothimagelistboxdragdrop::TImageListBoxDropTarget
{
	typedef Advsmoothimagelistboxdragdrop::TImageListBoxDropTarget inherited;
	
private:
	TAdvSmoothImageListBox* FImageListBox;
	
public:
	__fastcall TAdvSmoothImageListBoxDropTarget(TAdvSmoothImageListBox* AImageListBox);
	virtual void __fastcall DropText(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropCol(const Types::TPoint &pt, int Col);
	virtual void __fastcall DropRTF(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropFiles(const Types::TPoint &pt, Classes::TStrings* files);
	virtual void __fastcall DropURL(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DragMouseMove(System::TObject* Source, const Types::TPoint &pt, bool &Allow, Advsmoothimagelistboxdragdrop::TDropFormats DropFormats);
	virtual void __fastcall DragMouseLeave(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvSmoothImageListBoxDropTarget(void) { }
	
};


typedef void __fastcall (__closure *TAdvSmoothImageListBoxItemDragEvent)(System::TObject* Sender, int ItemIndex, bool &AllowDrag);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxDragOver)(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);

typedef void __fastcall (__closure *TAdvSmoothImageListBoxDragDrop)(System::TObject* Sender, System::TObject* Source, int X, int Y);

#pragma option push -b-
enum TAdvSmoothImageListBoxTextRendering { tAntiAlias, tAntiAliasGridFit, tClearType };
#pragma option pop

class PASCALIMPLEMENTATION TAdvSmoothImageListBox : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDragging;
	bool FKeyDown;
	TAdvSmoothImageListBoxDragDrop FOnDragDrop;
	TAdvSmoothImageListBoxDragOver FOnDragOver;
	bool FFocused;
	int FStartImage;
	bool FRestartLoop;
	bool FDesignTime;
	int FPaintIndex;
	int FTimerCount;
	System::UnicodeString FLookupKey;
	Stdctrls::TScrollBar* FScrollBar;
	int FOriginalDefaultWidth;
	int FOriginalDefaultHeight;
	bool FItemsInitialized;
	bool FItemRectsInitialized;
	TImageLoaderThread* FImageLoaderThread;
	bool FThreadDone;
	bool FUseThreading;
	Advgdip::TGPBitmap* FDefaultNormal;
	float FSp;
	int FCurrentScPos;
	int FScPosTo;
	int FClickY;
	int FClickX;
	bool FMouseDown;
	bool FMouseUp;
	int FTimeStart;
	int FTimeStop;
	int FDragXY;
	int FScrollXY;
	TAdvSmoothImageListBoxDisplayList* FDisplayList;
	bool FAnimating;
	bool FAnimate;
	bool FAnimateX;
	bool FAnimateY;
	bool FAnimateW;
	bool FAnimateH;
	bool FAnimateDoubleClick;
	Extctrls::TTimer* FAnimateTimer;
	TAdvSmoothImageListBoxItems* FItems;
	Gdipfill::TGDIPFill* FFill;
	bool FTransparent;
	Advgdip::TAdvGDIPPicture* FDefaultImage;
	TAdvSmoothImageListBoxItemAppearance* FItemAppearance;
	int FRows;
	int FColumns;
	int FSelectedItemIndex;
	int FFocusedItemIndex;
	int FHovF;
	int FHovH;
	int FSelF;
	int FSelH;
	int FHoveredItemIndex;
	TAdvSmoothImageListBoxHeader* FHeader;
	TAdvSmoothImageListBoxFooter* FFooter;
	int FAnimationFactor;
	TAdvSmoothImageThreadLoading FThreadLoading;
	bool FZoomOnDblClick;
	TAdvSmoothImageListBoxHTMLText* FDefaultHTMLText;
	Imglist::TCustomImageList* FImages;
	Gdippicturecontainer::TGDIPPictureContainer* FContainer;
	TAdvSmoothImageListBoxTopLayerItems* FTopLayerItems;
	bool FZoomOnTop;
	bool FShowScrollBar;
	TAdvSmoothImageListBoxItemEvent FOnItemSelect;
	TAdvSmoothImageListBoxScrollEvent FOnScroll;
	bool FKeyBoardLookUp;
	bool FSorted;
	bool FHover;
	System::UnicodeString FMark;
	System::UnicodeString FMarkTag;
	bool FMarkCase;
	TAdvSmoothImageListBoxZoomMode FZoomMode;
	TAdvSmoothImageListBoxItemEvent FOnItemDblClick;
	TAdvSmoothImageListBoxItemEvent FOnItemMouseLeave;
	TAdvSmoothImageListBoxItemEvent FOnItemZoomedOut;
	TAdvSmoothImageListBoxItemClickEvent FOnItemClick;
	TAdvSmoothImageListBoxItemZoomEvent FOnItemZoomOut;
	TAdvSmoothImageListBoxItemEvent FOnItemZoomedIn;
	TAdvSmoothImageListBoxItemEvent FOnItemMouseDown;
	TAdvSmoothImageListBoxItemEvent FOnItemMouseEnter;
	TAdvSmoothImageListBoxItemZoomEvent FOnItemZoomIn;
	TAdvSmoothImageListBoxItemHintEvent FOnItemHint;
	TAdvSmoothImageListBoxItemEvent FOnItemMouseUp;
	TAdvSmoothImageListBoxItemTextEvent FOnItemGetDisplayText;
	TAdvSmoothImageListBoxNavigateEvent FOnNavigate;
	bool FMultiSelect;
	bool FShowFocus;
	Graphics::TColor FFocusColor;
	TAdvSmoothImageListBoxItemAnchorEvent FOnItemAnchorClick;
	TAdvSmoothImageListBoxItemDrawEvent FOnItemDraw;
	int FVisibleItemCount;
	int FVisibleCol;
	int FVisibleRow;
	bool FInternalSel;
	int FLookupItemIndex;
	bool FOleDragDrop;
	bool FOleDropTargetAssigned;
	TAdvSmoothImageListBoxDropTarget* FImageListBoxDropTarget;
	TAdvSmoothImageListBoxItemDragEvent FOnItemStartDrag;
	TAdvSmoothImageListBoxTextRendering FTextRendering;
	void __fastcall SetItems(const TAdvSmoothImageListBoxItems* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetDefaultImage(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetItemAppearance(const TAdvSmoothImageListBoxItemAppearance* Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetRows(const int Value);
	void __fastcall SetSelectedItemIndex(const int Value);
	void __fastcall SetHeader(const TAdvSmoothImageListBoxHeader* Value);
	void __fastcall SetFooter(const TAdvSmoothImageListBoxFooter* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetAnimationFactor(const int Value);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	void __fastcall SetThreadLoading(const TAdvSmoothImageThreadLoading Value);
	void __fastcall SetZoomOnDblClick(const bool Value);
	void __fastcall SetDefaultHTMLText(const TAdvSmoothImageListBoxHTMLText* Value);
	void __fastcall SetTopLayerItems(const TAdvSmoothImageListBoxTopLayerItems* Value);
	void __fastcall SetZoomOnTop(const bool Value);
	void __fastcall SetShowScrollBar(const bool Value);
	void __fastcall SetKeyBoardLookUp(const bool Value);
	void __fastcall SetSorted(const bool Value);
	void __fastcall SetHover(const bool Value);
	void __fastcall SetZoomMode(const TAdvSmoothImageListBoxZoomMode Value);
	void __fastcall SetFocusColor(const Graphics::TColor Value);
	void __fastcall SetShowFocus(const bool Value);
	int __fastcall GetItemCount(void);
	void __fastcall SetItemCount(const int Value);
	void __fastcall SetOleDragDrop(const bool Value);
	void __fastcall SetTextRendering(const TAdvSmoothImageListBoxTextRendering Value);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall HeaderChanged(System::TObject* Sender);
	void __fastcall DefaultHTMLTextChanged(System::TObject* Sender);
	void __fastcall FooterChanged(System::TObject* Sender);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall Scroll(System::TObject* Sender, Stdctrls::TScrollCode ScrollCode, int &ScrollPos);
	void __fastcall TopLayerItemsChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall ItemAppearanceChanged(System::TObject* Sender);
	void __fastcall DefaultImageChanged(System::TObject* Sender);
	void __fastcall InitListBoxItems(void);
	void __fastcall Animate(System::TObject* Sender);
	System::UnicodeString __fastcall DrawHTMLText(Advgdip::TGPGraphics* g, TAdvSmoothImageListBoxHTMLText* HTML, const Advgdip::TGPRectF &r, System::UnicodeString str, bool DoAnchor = false, int fX = 0xffffffff, int fY = 0xffffffff);
	void __fastcall DrawText(Advgdip::TGPGraphics* g, TAdvSmoothImageListBoxHTMLText* HTML, const Advgdip::TGPRectF &r, System::UnicodeString str);
	Advgdip::TGPRectF __fastcall GetHeaderTextRect(void);
	Advgdip::TGPRectF __fastcall GetFooterTextRect(void);
	virtual void __fastcall SelectImage(System::Word Key, int &itemindex, bool itemselect);
	void __fastcall GetAspectSize(int &w, int &h, double ow, double oh, double nw, double nh);
	void __fastcall InitPreview(void);
	void __fastcall Navigate(System::Word Key, Classes::TShiftState Shift);
	void __fastcall SetScrollBarPosition(void);
	void __fastcall DrawDefaultImage(int item, Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall DrawBackGround(void);
	void __fastcall DrawHeader(void);
	void __fastcall DrawFooter(void);
	void __fastcall DrawItems(void);
	void __fastcall DrawFill(Advgdip::TGPGraphics* g);
	void __fastcall DrawHTML(Advgdip::TGPGraphics* g);
	void __fastcall DrawDisplayItems(Advgdip::TGPGraphics* g);
	void __fastcall DrawTopLayerItems(void);
	void __fastcall DrawZoomedItem(void);
	void __fastcall ThreadDone(System::TObject* Sender);
	DYNAMIC void __fastcall Resize(void);
	int __fastcall GetScrollBarWidth(void);
	int __fastcall GetScrollBarHeight(void);
	Advgdip::TGPRectF __fastcall GetTextRect(Advgdip::TGPGraphics* g, TAdvSmoothImageListBoxHTMLText* HTML, const Advgdip::TGPRectF &r, System::UnicodeString str);
	Advgdip::TGPRectF __fastcall GetHTMLTextRect(Advgdip::TGPGraphics* g, TAdvSmoothImageListBoxHTMLText* HTML, const Advgdip::TGPRectF &r, System::UnicodeString str);
	int __fastcall HeaderButton(int X, int Y, int &State);
	int __fastcall FooterButton(int X, int Y, int &State);
	int __fastcall ExpanderButton(int X, int Y, const Advgdip::TGPRectF &r, TAdvSmoothImageListBoxItem* item, int &State);
	Advgdip::TGPRectF __fastcall GetDisplayRectangle(void);
	System::UnicodeString __fastcall GetStrippedHTMLText(TAdvSmoothImageListBoxHTMLText* HTML);
	bool __fastcall ProcessKeyDown(System::Word Key, int &itemindex);
	Types::TRect __fastcall InsideRect(void);
	Advgdip::TGPRectF __fastcall GetItemRectangleOnXY(int X, int Y);
	int __fastcall FindItemOnXY(int X, int Y);
	TItemAnchor __fastcall GetAnchorAt(int X, int Y);
	int __fastcall GetShadowOffset(void);
	int __fastcall GetOuterBorderWidth(void);
	int __fastcall GetVersionNr(void);
	int __fastcall GetPositionTo(void);
	int __fastcall GetPosition(void);
	virtual int __fastcall GetFullSize(void);
	int __fastcall GetFirstVisibleItem(void);
	int __fastcall GetLastVisibleItem(void);
	bool __fastcall GetItemIsVisible(const Advgdip::TGPRectF &r);
	bool __fastcall GetItemIsDblClicked(void);
	int __fastcall GetTotalImageHeight(void);
	int __fastcall GetTotalImageWidth(void);
	int __fastcall GetTotalTextHeight(void);
	int __fastcall GetTotalTextWidth(void);
	int __fastcall GetImageHeight(void);
	int __fastcall GetImageWidth(void);
	int __fastcall GetTextHeight(void);
	int __fastcall GetTextWidth(void);
	Advgdip::TGPRectF __fastcall GetItemImageRect(const Advgdip::TGPRectF &r);
	Advgdip::TGPRectF __fastcall GetItemTextRect(const Advgdip::TGPRectF &r);
	void __fastcall DoDragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall DoDragDrop(System::TObject* Source, int X, int Y);
	virtual void __fastcall SetMultiSelect(bool Value);
	virtual void __fastcall DoItemPropertyChange(TAdvSmoothImageListBoxItem* Item, int PropID, bool &Value);
	virtual void __fastcall DoLookup(int ItemIndex);
	virtual void __fastcall DoItemText(TAdvSmoothImageListBoxItem* Item);
	virtual void __fastcall DoItemImage(TAdvSmoothImageListBoxItem* Item);
	virtual void __fastcall DoSelectItem(int NewItemIndex);
	virtual void __fastcall DoSmoothScroll(double CurrentPosition, double EndPosition);
	int __fastcall GetVisibleItemCount(void);
	int __fastcall GetLeftTopIndex(void);
	int __fastcall GetRightBottomIndex(void);
	void __fastcall SetLeftTopIndex(int Value);
	__property int ItemCount = {read=GetItemCount, write=SetItemCount, nodefault};
	__property int VisibleCol = {read=FVisibleCol, nodefault};
	__property int VisibleRow = {read=FVisibleRow, nodefault};
	__property int CurrentScPos = {read=FCurrentScPos, nodefault};
	__property int ScPosTo = {read=FScPosTo, nodefault};
	
public:
	__fastcall virtual TAdvSmoothImageListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothImageListBox(void);
	DYNAMIC void __fastcall MouseWheelHandler(Messages::TMessage &Message);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall AddImagesFromFolder(System::UnicodeString AFolder, bool SetImageCaption = false);
	void __fastcall AddImageLocationsFromFolder(System::UnicodeString AFolder, bool SetImageCaption = false);
	void __fastcall Highlight(bool DoCase, System::UnicodeString HiText);
	void __fastcall UnHighlight(void);
	void __fastcall Mark(bool DoCase, System::UnicodeString HiText);
	void __fastcall UnMark(void);
	void __fastcall ExpandAll(void);
	void __fastcall CollapseAll(void);
	void __fastcall StopThread(void);
	void __fastcall StartThread(void);
	void __fastcall ScrollToItem(int itemindex);
	int __fastcall GetRowCount(void);
	int __fastcall GetColumnCount(void);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	void __fastcall DoZoom(int AItemIndex = 0xffffffff);
	__property int HoveredItemIndex = {read=FHoveredItemIndex, nodefault};
	
__published:
	__property int AnimationFactor = {read=FAnimationFactor, write=SetAnimationFactor, default=4};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property System::UnicodeString Version = {read=GetVersion};
	__property int SelectedItemIndex = {read=FSelectedItemIndex, write=SetSelectedItemIndex, default=-1};
	__property TAdvSmoothImageListBoxItems* Items = {read=FItems, write=SetItems};
	__property TAdvSmoothImageListBoxTopLayerItems* TopLayerItems = {read=FTopLayerItems, write=SetTopLayerItems};
	__property TAdvSmoothImageListBoxItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
	__property TAdvSmoothImageListBoxHeader* Header = {read=FHeader, write=SetHeader};
	__property TAdvSmoothImageListBoxFooter* Footer = {read=FFooter, write=SetFooter};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Advgdip::TAdvGDIPPicture* DefaultImage = {read=FDefaultImage, write=SetDefaultImage};
	__property TAdvSmoothImageListBoxHTMLText* DefaultHTMLText = {read=FDefaultHTMLText, write=SetDefaultHTMLText};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property int Columns = {read=FColumns, write=SetColumns, default=0};
	__property int Rows = {read=FRows, write=SetRows, default=3};
	__property TAdvSmoothImageThreadLoading ThreadLoading = {read=FThreadLoading, write=SetThreadLoading, default=2};
	__property bool ZoomOnDblClick = {read=FZoomOnDblClick, write=SetZoomOnDblClick, default=1};
	__property TAdvSmoothImageListBoxZoomMode ZoomMode = {read=FZoomMode, write=SetZoomMode, default=0};
	__property bool ZoomOnTop = {read=FZoomOnTop, write=SetZoomOnTop, default=0};
	__property bool KeyBoardLookUp = {read=FKeyBoardLookUp, write=SetKeyBoardLookUp, default=0};
	__property bool ShowScrollBar = {read=FShowScrollBar, write=SetShowScrollBar, default=1};
	__property bool Sorted = {read=FSorted, write=SetSorted, default=0};
	__property bool Hover = {read=FHover, write=SetHover, default=1};
	__property bool MultiSelect = {read=FMultiSelect, write=SetMultiSelect, default=0};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=0};
	__property bool OleDragDrop = {read=FOleDragDrop, write=SetOleDragDrop, default=0};
	__property TAdvSmoothImageListBoxTextRendering TextRendering = {read=FTextRendering, write=SetTextRendering, default=2};
	__property TAdvSmoothImageListBoxDragOver OnOleDragOver = {read=FOnDragOver, write=FOnDragOver};
	__property TAdvSmoothImageListBoxDragDrop OnOleDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property TAdvSmoothImageListBoxNavigateEvent OnNavigate = {read=FOnNavigate, write=FOnNavigate};
	__property TAdvSmoothImageListBoxItemEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property TAdvSmoothImageListBoxItemClickEvent OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TAdvSmoothImageListBoxItemEvent OnItemMouseDown = {read=FOnItemMouseDown, write=FOnItemMouseDown};
	__property TAdvSmoothImageListBoxItemEvent OnItemMouseUp = {read=FOnItemMouseUp, write=FOnItemMouseUp};
	__property TAdvSmoothImageListBoxItemEvent OnItemMouseEnter = {read=FOnItemMouseEnter, write=FOnItemMouseEnter};
	__property TAdvSmoothImageListBoxItemEvent OnItemMouseLeave = {read=FOnItemMouseLeave, write=FOnItemMouseLeave};
	__property TAdvSmoothImageListBoxItemEvent OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property TAdvSmoothImageListBoxItemZoomEvent OnItemZoomIn = {read=FOnItemZoomIn, write=FOnItemZoomIn};
	__property TAdvSmoothImageListBoxItemEvent OnItemZoomedIn = {read=FOnItemZoomedIn, write=FOnItemZoomedIn};
	__property TAdvSmoothImageListBoxItemZoomEvent OnItemZoomOut = {read=FOnItemZoomOut, write=FOnItemZoomOut};
	__property TAdvSmoothImageListBoxItemEvent OnItemZoomedOut = {read=FOnItemZoomedOut, write=FOnItemZoomedOut};
	__property TAdvSmoothImageListBoxItemHintEvent OnItemHint = {read=FOnItemHint, write=FOnItemHint};
	__property TAdvSmoothImageListBoxItemAnchorEvent OnItemAnchorClick = {read=FOnItemAnchorClick, write=FOnItemAnchorClick};
	__property TAdvSmoothImageListBoxItemTextEvent OnItemGetDisplayText = {read=FOnItemGetDisplayText, write=FOnItemGetDisplayText};
	__property TAdvSmoothImageListBoxScrollEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property TAdvSmoothImageListBoxItemDrawEvent OnItemDraw = {read=FOnItemDraw, write=FOnItemDraw};
	__property TAdvSmoothImageListBoxItemDragEvent OnItemStartDrag = {read=FOnItemStartDrag, write=FOnItemStartDrag};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnDblClick;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property Visible = {default=1};
	__property TabStop = {default=1};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothImageListBox(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x3;

}	/* namespace Advsmoothimagelistbox */
using namespace Advsmoothimagelistbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothimagelistboxHPP
