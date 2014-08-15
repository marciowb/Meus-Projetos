// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothslideshow.pas' rev: 21.00

#ifndef AdvsmoothslideshowHPP
#define AdvsmoothslideshowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Shlobj.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothslideshow
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TImageLoaderThread;
class DELPHICLASS TAdvSmoothSlideShow;
class PASCALIMPLEMENTATION TImageLoaderThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	Controls::TWinControl* FCtrl;
	Graphics::TBitmap* FCtrlBitmap;
	_di_IMalloc fMalloc;
	_di_IRunnableTask fRunnableTask;
	TAdvSmoothSlideShow* SlideShow;
	
protected:
	virtual void __fastcall Execute(void);
	void __fastcall PaintControl(void);
	bool __fastcall GetFilePreview(const System::UnicodeString FileName, int w, int h, /* out */ Graphics::TBitmap* &bmp, /* out */ System::UnicodeString &ErrorInfo);
	
public:
	__fastcall TImageLoaderThread(TAdvSmoothSlideShow* ASlideShow);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TImageLoaderThread(void) { }
	
};


#pragma option push -b-
enum TImageThreadStatus { stNone, stInitialized, stStarted, stLoaded };
#pragma option pop

#pragma option push -b-
enum TSlideShowItemKind { ikImage, ikControl, ikPreview, ikText, ikImageText, ikCustom };
#pragma option pop

#pragma option push -b-
enum TSlideShowTextLocation { tlLeft, tlTop, tlRight, tlBottom };
#pragma option pop

#pragma option push -b-
enum TDescriptionPosition { dpTopLeft, dpTopCenter, dpTopRight, dpBottomLeft, dpBottomCenter, dpBottomRight };
#pragma option pop

class DELPHICLASS TAdvSmoothSlideShowItem;
class PASCALIMPLEMENTATION TAdvSmoothSlideShowItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TImageThreadStatus FThumbThreadStatus;
	TImageThreadStatus FThreadStatus;
	Advgdip::TGPImage* FThumbnail;
	Advgdip::TGPBitmap* FOriginalImage;
	Advgdip::TGPRectF FItemRect;
	Advgdip::TGPRectF FPlaceHolderRect;
	Advgdip::TGPRectF FThumbRect;
	Advgdip::TGPRectF FThumbItemRect;
	TAdvSmoothSlideShow* FOwner;
	Advgdip::TAdvGDIPPicture* FImage;
	System::UnicodeString FLocation;
	Controls::TWinControl* FControl;
	TSlideShowItemKind FKind;
	bool FEnabled;
	bool FVisible;
	System::TObject* FObject;
	int FTag;
	System::UnicodeString FText;
	System::UnicodeString FHint;
	int FCustomImageHeight;
	int FCustomImageWidth;
	Graphics::TFont* FTextFont;
	int FTextWidth;
	int FTextHeight;
	bool FTextAutoSize;
	bool FEllipsis;
	bool FWordWrap;
	TSlideShowTextLocation FTextLocation;
	Classes::TVerticalAlignment FTextVerticalAlignment;
	Classes::TAlignment FTextHorizontalAlignment;
	System::UnicodeString FURL;
	TDescriptionPosition FDescriptionPosition;
	System::UnicodeString FDescription;
	Graphics::TFont* FDescriptionFont;
	void __fastcall SetImage(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetLocation(const System::UnicodeString Value);
	void __fastcall SetControl(const Controls::TWinControl* Value);
	void __fastcall SetKind(const TSlideShowItemKind Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetTextFont(const Graphics::TFont* Value);
	void __fastcall SetTextWidth(const int Value);
	void __fastcall SetTextAutoSize(const bool Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetTextHeight(const int Value);
	void __fastcall SetTextLocation(const TSlideShowTextLocation Value);
	void __fastcall SetTextHorizontalAlignment(const Classes::TAlignment Value);
	void __fastcall SetTextVerticalAlignment(const Classes::TVerticalAlignment Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	void __fastcall SetDescription(const System::UnicodeString Value);
	void __fastcall SetDescriptionPosition(const TDescriptionPosition Value);
	void __fastcall SetDescriptionFont(const Graphics::TFont* Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall ImageChanged(System::TObject* Sender);
	void __fastcall DrawPlaceHolder(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R, System::Byte Opacity);
	void __fastcall DrawItem(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R, System::Byte Opacity);
	void __fastcall DrawDescription(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R, System::Byte Opacity);
	void __fastcall GetAspectSize(double &w, double &h, double ow, double oh, double nw, double nh);
	
public:
	__fastcall virtual TAdvSmoothSlideShowItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothSlideShowItem(void);
	void __fastcall Update(void);
	__property int CustomImageWidth = {read=FCustomImageWidth, write=FCustomImageWidth, default=100};
	__property int CustomImageHeight = {read=FCustomImageHeight, write=FCustomImageHeight, default=100};
	
__published:
	__property Advgdip::TAdvGDIPPicture* Image = {read=FImage, write=SetImage};
	__property System::UnicodeString Location = {read=FLocation, write=SetLocation};
	__property TSlideShowItemKind Kind = {read=FKind, write=SetKind, default=0};
	__property Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property System::TObject* ItemObject = {read=FObject, write=FObject};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property System::UnicodeString Description = {read=FDescription, write=SetDescription};
	__property TDescriptionPosition DescriptionPosition = {read=FDescriptionPosition, write=SetDescriptionPosition, default=4};
	__property Graphics::TFont* DescriptionFont = {read=FDescriptionFont, write=SetDescriptionFont};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property Graphics::TFont* TextFont = {read=FTextFont, write=SetTextFont};
	__property int TextWidth = {read=FTextWidth, write=SetTextWidth, default=100};
	__property int TextHeight = {read=FTextHeight, write=SetTextHeight, default=100};
	__property bool TextAutoSize = {read=FTextAutoSize, write=SetTextAutoSize, default=1};
	__property Classes::TAlignment TextHorizontalAlignment = {read=FTextHorizontalAlignment, write=SetTextHorizontalAlignment, default=2};
	__property Classes::TVerticalAlignment TextVerticalAlignment = {read=FTextVerticalAlignment, write=SetTextVerticalAlignment, default=2};
	__property TSlideShowTextLocation TextLocation = {read=FTextLocation, write=SetTextLocation, default=3};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
};


class DELPHICLASS TAdvSmoothSlideShowItems;
class PASCALIMPLEMENTATION TAdvSmoothSlideShowItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothSlideShowItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothSlideShow* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothSlideShowItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothSlideShowItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothSlideShowItems(TAdvSmoothSlideShow* AOwner);
	HIDESBASE TAdvSmoothSlideShowItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothSlideShowItem* __fastcall Insert(int Index);
	__property TAdvSmoothSlideShowItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothSlideShowItems(void) { }
	
};


#pragma option push -b-
enum TSlideShowItemMode { imStretch, imNormal };
#pragma option pop

#pragma option push -b-
enum TSlideShowTransition { stFade, stPlaceHolder };
#pragma option pop

typedef Set<TSlideShowTransition, stFade, stPlaceHolder>  TSlideShowTransitions;

#pragma option push -b-
enum TSlideShowAnimation { saBottomLeftToTopRight, saBottomRightToTopLeft, saTopLeftToBottomRight, saTopRightToBottomLeft, saBottomToTop, saTopToBottom, saLeftToRight, saRightToLeft, saWipeBottomToTop, saWipeTopToBottom, saWipeLeftToRight, saWipeRightToLeft, saWipeBottomLeftToTopRight, saWipeBottomRightToTopLeft, saWipeTopLeftToBottomRight, saWipeTopRightToBottomLeft, saCheckBoard, saVerticalCheckBoard, saHorizontalCheckBoard, saEllipse, saRectangle, saRotate, saSpin, saSpiral, saFadeInOut, saTearHorizontal, saTearVertical, saTearRotate };
#pragma option pop

typedef Set<TSlideShowAnimation, saBottomLeftToTopRight, saTearRotate>  TSlideShowAnimations;

#pragma option push -b-
enum TThumbNailPosition { tpLeft, tpTop, tpRight, tpBottom };
#pragma option pop

typedef void __fastcall (__closure *TSlideShowHintEvent)(System::TObject* Sender, int itemindex, System::UnicodeString &Hint);

typedef void __fastcall (__closure *TSlideShowClickEvent)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TSlideShowLoadEvent)(System::TObject* Sender, int itemindex);

typedef void __fastcall (__closure *TSlideShowCustomDrawEvent)(System::TObject* Sender, int itemindex, Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R, TSlideShowItemKind Kind);

class DELPHICLASS THandleAppearance;
class PASCALIMPLEMENTATION THandleAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothSlideShow* FOwner;
	System::Byte FOpacity;
	Graphics::TColor FBorderColor;
	Graphics::TColor FArrowColor;
	Graphics::TColor FColor;
	Classes::TNotifyEvent FOnChange;
	int FSize;
	void __fastcall SetArrowColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetSize(const int Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall THandleAppearance(TAdvSmoothSlideShow* AOwner);
	__fastcall virtual ~THandleAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12632256};
	__property Graphics::TColor ArrowColor = {read=FArrowColor, write=SetArrowColor, default=0};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=200};
	__property int Size = {read=FSize, write=SetSize, default=35};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION TAdvSmoothSlideShow : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FhoveredDescription;
	bool ShowDescription;
	int effect;
	int FhoveredItem;
	bool FHandleOk;
	bool FDoHandleTimer;
	Extctrls::TTimer* FHandleTimer;
	int FTimeDownOnArrow;
	double MaxScrollPos;
	bool FHandleHorzLeftDown;
	bool FHandleHorzLeftHover;
	bool FHandleHorzRightDown;
	bool FHandleHorzRightHover;
	bool FHandleVertTopDown;
	bool FHandleVertTopHover;
	bool FHandleVertBottomDown;
	bool FHandleVertBottomHover;
	bool FCacheBG;
	Advgdip::TGPBitmap* FCacheBackGround;
	Controls::TWinControl* FControlParent;
	Controls::TAlign FControlAlign;
	int FControlLeft;
	int FControlTop;
	int FControlWidth;
	int FControlHeight;
	Forms::TForm* FFullScreen;
	bool RestartLoop;
	bool FThreadDone;
	TImageLoaderThread* FImageLoaderThread;
	bool FDesignTime;
	int FUpdateCount;
	Advgdip::ColorMatrix FColorMatrix;
	bool FDoAnimation;
	bool FAnimatePlaceHolder;
	bool FAnimateImage;
	bool FAnimating;
	Advgdip::TGPRectF FCurrentPlaceHolder;
	System::Byte FCurrentOpacityTo;
	System::Byte FNextOpacityTo;
	System::Byte FCurrentOpacity;
	System::Byte FNextOpacity;
	Extctrls::TTimer* FRotateTimer;
	Extctrls::TTimer* FAnimateTimer;
	int FItemIndex;
	int FCurrentItemIndex;
	int FNextItemIndex;
	int FPreviousItemIndex;
	TAdvSmoothSlideShowItems* FItems;
	Gdipfill::TGDIPFill* FFill;
	Controls::TMargins* FMargin;
	Gdipfill::TGDIPFill* FPlaceHolderFill;
	int FPlaceHolderSpacing;
	TSlideShowItemMode FItemMode;
	bool FAspectRatio;
	int FFadeAnimationFactor;
	int FRotationInterval;
	TSlideShowTransitions FTransitions;
	bool FRotation;
	bool FAnimation;
	int FHolderAnimationFactor;
	int FThumbNailWidth;
	Gdipfill::TGDIPFill* FThumbNailHolderFill;
	int FThumbNailSpacing;
	bool FThumbNails;
	int FThumbNailHeight;
	Controls::TMargins* FThumbNailHolderMargin;
	TThumbNailPosition FThumbnailPosition;
	THandleAppearance* FThumbNailHandles;
	TSlideShowAnimations FAnimations;
	Gdipfill::TGDIPFill* FThumbNailSelectedFill;
	double FScrollPos;
	TSlideShowHintEvent FOnThumbHint;
	TSlideShowCustomDrawEvent FOnCustomDraw;
	bool FPlaceHolderVisible;
	bool FThumbNailsFloating;
	bool FLoadEffect;
	TSlideShowClickEvent FOnThumbDblClick;
	TSlideShowClickEvent FOnThumbClick;
	TSlideShowLoadEvent FOnThumbLoaded;
	TSlideShowLoadEvent FOnImageLoaded;
	Gdipfill::TGDIPFill* FDescriptionFill;
	void __fastcall SetItems(const TAdvSmoothSlideShowItems* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetMargin(const Controls::TMargins* Value);
	void __fastcall SetPlaceHolderFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetPlaceHolderSpacing(const int Value);
	void __fastcall SetItemMode(const TSlideShowItemMode Value);
	void __fastcall SetAspectRatio(const bool Value);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetRotationInterval(const int Value);
	void __fastcall SetTransitions(const TSlideShowTransitions Value);
	void __fastcall SetRotation(const bool Value);
	void __fastcall SetAnimation(const bool Value);
	void __fastcall SetHolderAnimationFactor(const int Value);
	void __fastcall SetFadeAnimationFactor(const int Value);
	void __fastcall SetThumbNailHeight(const int Value);
	void __fastcall SetThumbNailHolderFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetThumbNails(const bool Value);
	void __fastcall SetThumbNailSpacing(const int Value);
	void __fastcall SetThumbNailWidth(const int Value);
	void __fastcall SetThumbNailHolderMargin(const Controls::TMargins* Value);
	void __fastcall SetThumbNailPosition(const TThumbNailPosition Value);
	void __fastcall SetThumbNailHandles(const THandleAppearance* Value);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Messages::TWMMouseWheel &Message);
	void __fastcall SetAnimations(const TSlideShowAnimations Value);
	void __fastcall SetThumbNailSelectedFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetScrollPos(const double Value);
	void __fastcall SetPlaceHolderVisible(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetThumbNailsFloating(const bool Value);
	void __fastcall SetLoadEffect(const bool Value);
	void __fastcall SetDescriptionFill(const Gdipfill::TGDIPFill* Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall MarginChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall PlaceHolderFillChanged(System::TObject* Sender);
	void __fastcall ThumbNailFillChanged(System::TObject* Sender);
	void __fastcall HandleTimerChanged(System::TObject* Sender);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall Draw(Advgdip::TGPGraphics* g);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g);
	void __fastcall DrawHandles(Advgdip::TGPGraphics* g);
	void __fastcall DrawThumbs(Advgdip::TGPGraphics* g);
	void __fastcall Animate(System::TObject* Sender);
	void __fastcall Rotate(System::TObject* Sender);
	void __fastcall HandlesChanged(System::TObject* Sender);
	void __fastcall BuildItems(void);
	bool __fastcall AnimatePlaceHolder(void);
	Advgdip::TGPRectF __fastcall GetThumbNailRect(void);
	Types::TRect __fastcall GetThumbNailRectangle(void);
	bool __fastcall AnimateImage(void);
	void __fastcall ThreadDone(System::TObject* Sender);
	virtual void __fastcall CreateWnd(void);
	void __fastcall ScrollToItem(int Index);
	int __fastcall XYToThumb(int pX, int pY);
	int __fastcall XYToCurrentItem(int pX, int pY);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FormClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	Advgdip::TGPRectF __fastcall GetHandleHorzLeft(void);
	Advgdip::TGPRectF __fastcall GetHandleHorzRight(void);
	Advgdip::TGPRectF __fastcall GetHandleVertTop(void);
	Advgdip::TGPRectF __fastcall GetHandleVertBottom(void);
	bool __fastcall IsHandleHorzLeft(void);
	bool __fastcall IsHandleHorzRight(void);
	bool __fastcall IsHandleVertTop(void);
	bool __fastcall IsHandleVertBottom(void);
	void __fastcall PaintThumbnails(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	int __fastcall GetAnimationCount(void);
	TSlideShowAnimation __fastcall GetRandomAnimation(void);
	int __fastcall GetCountSelectable(void);
	int __fastcall GetMaxSelectable(void);
	int __fastcall GetMinSelectable(void);
	__property double ScrollPos = {read=FScrollPos, write=SetScrollPos};
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall DblClick(void);
	
public:
	__fastcall virtual TAdvSmoothSlideShow(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothSlideShow(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall AddItemsFromFolder(System::UnicodeString AFolder, TSlideShowItemKind AKind, bool DescriptionLocation = false, bool CaptionLocation = false, bool LocationThumbHint = false);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall StopThread(void);
	void __fastcall StartThread(void);
	void __fastcall FullScreen(void);
	void __fastcall Normal(void);
	void __fastcall Next(void);
	void __fastcall Previous(void);
	void __fastcall UpdateControlImage(Controls::TWinControl* AControl);
	void __fastcall UpdateImages(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property int FadeAnimationFactor = {read=FFadeAnimationFactor, write=SetFadeAnimationFactor, default=6};
	__property int HolderAnimationFactor = {read=FHolderAnimationFactor, write=SetHolderAnimationFactor, default=6};
	__property Gdipfill::TGDIPFill* PlaceHolderFill = {read=FPlaceHolderFill, write=SetPlaceHolderFill};
	__property int PlaceHolderSpacing = {read=FPlaceHolderSpacing, write=SetPlaceHolderSpacing, default=40};
	__property bool PlaceHolder = {read=FPlaceHolderVisible, write=SetPlaceHolderVisible, default=1};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Gdipfill::TGDIPFill* DescriptionFill = {read=FDescriptionFill, write=SetDescriptionFill};
	__property TAdvSmoothSlideShowItems* Items = {read=FItems, write=SetItems};
	__property Controls::TMargins* Margin = {read=FMargin, write=SetMargin};
	__property TSlideShowItemMode ItemMode = {read=FItemMode, write=SetItemMode, default=1};
	__property bool AspectRatio = {read=FAspectRatio, write=SetAspectRatio, default=1};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=0};
	__property bool Rotation = {read=FRotation, write=SetRotation, default=1};
	__property bool Animation = {read=FAnimation, write=SetAnimation, default=1};
	__property int RotationInterval = {read=FRotationInterval, write=SetRotationInterval, default=3500};
	__property TSlideShowTransitions Transitions = {read=FTransitions, write=SetTransitions, default=3};
	__property TSlideShowAnimations Animations = {read=FAnimations, write=SetAnimations, default=64};
	__property bool LoadEffect = {read=FLoadEffect, write=SetLoadEffect, default=1};
	__property bool ThumbNailsFloating = {read=FThumbNailsFloating, write=SetThumbNailsFloating, default=0};
	__property THandleAppearance* ThumbNailHandles = {read=FThumbNailHandles, write=SetThumbNailHandles};
	__property int ThumbNailSpacing = {read=FThumbNailSpacing, write=SetThumbNailSpacing, default=10};
	__property bool ThumbNails = {read=FThumbNails, write=SetThumbNails, default=1};
	__property Controls::TMargins* ThumbNailHolderMargin = {read=FThumbNailHolderMargin, write=SetThumbNailHolderMargin};
	__property Gdipfill::TGDIPFill* ThumbNailHolderFill = {read=FThumbNailHolderFill, write=SetThumbNailHolderFill};
	__property int ThumbNailWidth = {read=FThumbNailWidth, write=SetThumbNailWidth, default=100};
	__property int ThumbNailHeight = {read=FThumbNailHeight, write=SetThumbNailHeight, default=100};
	__property TThumbNailPosition ThumbNailPosition = {read=FThumbnailPosition, write=SetThumbNailPosition, default=3};
	__property Gdipfill::TGDIPFill* ThumbNailSelectedFill = {read=FThumbNailSelectedFill, write=SetThumbNailSelectedFill};
	__property TSlideShowHintEvent OnThumbHint = {read=FOnThumbHint, write=FOnThumbHint};
	__property TSlideShowClickEvent OnThumbClick = {read=FOnThumbClick, write=FOnThumbClick};
	__property TSlideShowClickEvent OnThumbDblClick = {read=FOnThumbDblClick, write=FOnThumbDblClick};
	__property TSlideShowLoadEvent OnThumbLoaded = {read=FOnThumbLoaded, write=FOnThumbLoaded};
	__property TSlideShowLoadEvent OnImageLoaded = {read=FOnImageLoaded, write=FOnImageLoaded};
	__property TSlideShowCustomDrawEvent OnCustomDraw = {read=FOnCustomDraw, write=FOnCustomDraw};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothSlideShow(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advsmoothslideshow */
using namespace Advsmoothslideshow;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothslideshowHPP
