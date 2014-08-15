// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advalertwindow.pas' rev: 21.00

#ifndef AdvalertwindowHPP
#define AdvalertwindowHPP

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
#include <Extctrls.hpp>	// Pascal unit
#include <Picturecontainer.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Registry.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advalertwindow
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

typedef void __fastcall (__closure *TAnchorClickEvent)(System::TObject* Sender, System::UnicodeString Anchor, int index);

typedef void __fastcall (__closure *TDeleteMessageEvent)(System::TObject* Sender, int index);

typedef void __fastcall (__closure *TCanCloseEvent)(System::TObject* Sender, bool &CanClose);

typedef void __fastcall (__closure *TCanDeleteEvent)(System::TObject* Sender, int Index, bool &CanDelete);

typedef void __fastcall (__closure *TCustomPaintEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool &DefaultPaint);

#pragma option push -b-
enum TAdvAlertWindowStyle { asOffice2003Blue, asOffice2003Silver, asOffice2003Olive, asOffice2003Classic, asOffice2007Luna, asOffice2007Obsidian, asWindowsXP, asWhidbey, asCustom, asOffice2007Silver, asWindowsVista, asWindows7, asTerminal, asOffice2010Blue, asOffice2010Silver, asOffice2010Black };
#pragma option pop

class DELPHICLASS TMsgScroller;
class PASCALIMPLEMENTATION TMsgScroller : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FMin;
	int FMax;
	int FPosition;
	bool FVisible;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TMsgScroller(void);
	bool __fastcall CanGoForward(void);
	bool __fastcall CanGoBack(void);
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMsgScroller(void) { }
	
};


class DELPHICLASS TAlertWindow;
class DELPHICLASS TMsgCollection;
class PASCALIMPLEMENTATION TAlertWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	Graphics::TColor FWindowColor;
	Graphics::TColor FWindowColorTo;
	TGradientDirection FGradientDir;
	Picturecontainer::THTMLPictureCache* FImageCache;
	Picturecontainer::TPictureContainer* FContainer;
	int FHoverLink;
	bool FHover;
	Types::TRect FHoverRect;
	TAnchorClickEvent FOnAnchorClick;
	Controls::TImageList* FImages;
	bool FAutoHide;
	bool FAutoSize;
	int FBorderSize;
	bool FAlwaysOnTop;
	int FMarginY;
	int FMarginX;
	bool FHoverClose;
	bool FDownClose;
	bool FScrollLeftHover;
	bool FScrollLeftDown;
	bool FScrollRightHover;
	bool FScrollRightDown;
	bool FDeleteHover;
	bool FDeleteDown;
	Graphics::TColor FSelectedColor;
	bool FDragingStart;
	int FOldMouseX;
	int FOldMouseY;
	TMsgScroller* FMsgScroller;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TStringList* FAlertMessages;
	Classes::TNotifyEvent FOnWindowMoved;
	System::UnicodeString FHintNextBtn;
	System::UnicodeString FHintPrevBtn;
	System::UnicodeString FHintCloseBtn;
	Graphics::TColor FCaptionColorTo;
	Graphics::TColor FCaptionColor;
	System::UnicodeString FOriginalHint;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBtnHoverColor;
	Graphics::TColor FBtnDownColor;
	Graphics::TColor FBtnHoverColorTo;
	Graphics::TColor FBtnDownColorTo;
	Graphics::TBitmap* FGlyphNext;
	Graphics::TBitmap* FGlyphNextDisabled;
	Graphics::TBitmap* FGlyphPrev;
	Graphics::TBitmap* FGlyphPrevDisabled;
	Graphics::TBitmap* FGlyphDelete;
	bool FAutoDelete;
	bool FShowDelete;
	System::UnicodeString FHintDeleteBtn;
	TDeleteMessageEvent FOnDeleteMessage;
	Classes::TNotifyEvent FOnClose;
	TCanCloseEvent FOnCanClose;
	Classes::TNotifyEvent FOnNextMessage;
	Classes::TNotifyEvent FOnPrevMessage;
	Graphics::TBitmap* FGlyphClose;
	int FMaxWidth;
	int FMaxHeight;
	System::UnicodeString FPositionFormat;
	TMsgCollection* FAlertMessagesInfo;
	bool FShowPopup;
	System::UnicodeString FHintPopupBtn;
	bool FPopupBtnDown;
	bool FPopupBtnHover;
	bool FScrollUpBtnDown;
	bool FScrollUpBtnHover;
	bool FScrollDnBtnDown;
	bool FScrollDnBtnHover;
	Graphics::TBitmap* FGlyphPopup;
	Graphics::TPicture* FBackground;
	Classes::TNotifyEvent FOnPopupbtnClick;
	int FScrollPos;
	bool FShowScrollUp;
	bool FShowScrollDn;
	bool FShowScrollers;
	Extctrls::TTimer* FTimer;
	Classes::TNotifyEvent FOnDestroy;
	TCustomPaintEvent FOnCustomPaint;
	bool FAutoHiding;
	Graphics::TColor FURLColor;
	Classes::TNotifyEvent FOnAlertClick;
	int FOldX;
	int FOldY;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetHover(const bool Value);
	void __fastcall SetAlwaysOnTop(const bool Value);
	void __fastcall SetAutoSizeEx(const bool Value);
	void __fastcall DrawTopBar(void);
	void __fastcall DrawCloseButton(void);
	void __fastcall DrawLeftScrollBtn(void);
	void __fastcall DrawRightScrollBtn(void);
	void __fastcall DrawScrollBtns(void);
	void __fastcall DrawDeleteBtn(void);
	void __fastcall DrawPopupBtn(void);
	void __fastcall DrawScrollUpBtn(void);
	void __fastcall DrawScrollDnBtn(void);
	HIDESBASE void __fastcall Hide(void);
	void __fastcall SetAlertMessages(const Classes::TStringList* Value);
	void __fastcall SetGlyphDelete(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphNext(const Graphics::TBitmap* Value);
	void __fastcall GlyphNextOnChange(System::TObject* Sender);
	void __fastcall SetGlyphPrev(const Graphics::TBitmap* Value);
	void __fastcall GlyphPrevOnChange(System::TObject* Sender);
	void __fastcall SetGlyphClose(const Graphics::TBitmap* Value);
	void __fastcall SetAutoDelete(const bool Value);
	void __fastcall SetShowDelete(const bool Value);
	Types::TRect __fastcall GetCloseRect(void);
	Types::TRect __fastcall GetLeftScrollBtnRect(void);
	Types::TRect __fastcall GetRightScrollBtnRect(void);
	Types::TRect __fastcall GetDeleteBtnRect(void);
	int __fastcall ScrollTextWidth(void);
	Types::TRect __fastcall GetPopupBtnRect(void);
	Types::TRect __fastcall GetScrollUpBtnRect(void);
	Types::TRect __fastcall GetScrollDnBtnRect(void);
	bool __fastcall PtOnDeleteBtn(int X, int Y);
	bool __fastcall PtOnPopupBtn(int X, int Y);
	bool __fastcall PtOnLeftScrollBtn(int X, int Y);
	bool __fastcall PtOnRightScrollBtn(int X, int Y);
	bool __fastcall PtOnScrollUpBtn(int X, int Y);
	bool __fastcall PtOnScrollDnBtn(int X, int Y);
	int __fastcall GetWidthFromTextWidth(int w);
	int __fastcall GetHeightFromTextHeight(int H);
	bool __fastcall PtOnCaption(int X, int Y);
	int __fastcall MinWindowWidth(void);
	int __fastcall MinWindowHeight(void);
	int __fastcall GetPopupBtnWidth(void);
	__property int BorderSize = {read=FBorderSize, write=FBorderSize, nodefault};
	int __fastcall GetActiveMessage(void);
	void __fastcall SetActiveMessage(const int Value);
	void __fastcall SetPositionFormat(const System::UnicodeString Value);
	void __fastcall SetShowPopup(const bool Value);
	void __fastcall SetGlyphPopup(const Graphics::TBitmap* Value);
	void __fastcall SetBackground(const Graphics::TPicture* Value);
	void __fastcall PositionChanged(System::TObject* Sender);
	void __fastcall TimerMessage(System::TObject* Sender);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	void __fastcall AlertMessagesOnChange(System::TObject* Sender);
	bool __fastcall PtOnClose(int X, int Y);
	int __fastcall GetMessageHeight(int Index);
	Types::TRect __fastcall GetTextRect(void);
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=FSelectedColor, nodefault};
	__property TMsgCollection* AlertMessagesInfo = {read=FAlertMessagesInfo, write=FAlertMessagesInfo};
	__property bool AutoHiding = {read=FAutoHiding, write=FAutoHiding, nodefault};
	
public:
	__fastcall virtual TAlertWindow(Classes::TComponent* AOwner);
	__fastcall virtual ~TAlertWindow(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall Next(void);
	void __fastcall Previous(void);
	void __fastcall First(void);
	void __fastcall Last(void);
	void __fastcall Delete(int Index)/* overload */;
	void __fastcall Delete(void)/* overload */;
	__property int ActiveMessage = {read=GetActiveMessage, write=SetActiveMessage, nodefault};
	
__published:
	__property Classes::TStringList* AlertMessages = {read=FAlertMessages, write=SetAlertMessages};
	__property bool AlwaysOnTop = {read=FAlwaysOnTop, write=SetAlwaysOnTop, nodefault};
	__property bool AutoHide = {read=FAutoHide, write=FAutoHide, nodefault};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSizeEx, nodefault};
	__property bool AutoDelete = {read=FAutoDelete, write=SetAutoDelete, nodefault};
	__property Graphics::TPicture* Background = {read=FBackground, write=SetBackground};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
	__property Graphics::TColor BtnHoverColor = {read=FBtnHoverColor, write=FBtnHoverColor, nodefault};
	__property Graphics::TColor BtnHoverColorTo = {read=FBtnHoverColorTo, write=FBtnHoverColorTo, nodefault};
	__property Graphics::TColor BtnDownColor = {read=FBtnDownColor, write=FBtnDownColor, nodefault};
	__property Graphics::TColor BtnDownColorTo = {read=FBtnDownColorTo, write=FBtnDownColorTo, nodefault};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=FCaptionColor, nodefault};
	__property Graphics::TColor CaptionColorTo = {read=FCaptionColorTo, write=FCaptionColorTo, nodefault};
	__property TGradientDirection GradientDirection = {read=FGradientDir, write=FGradientDir, nodefault};
	__property Graphics::TBitmap* GlyphPrev = {read=FGlyphPrev, write=SetGlyphPrev};
	__property Graphics::TBitmap* GlyphNext = {read=FGlyphNext, write=SetGlyphNext};
	__property Graphics::TBitmap* GlyphDelete = {read=FGlyphDelete, write=SetGlyphDelete};
	__property Graphics::TBitmap* GlyphClose = {read=FGlyphClose, write=SetGlyphClose};
	__property Graphics::TBitmap* GlyphPopup = {read=FGlyphPopup, write=SetGlyphPopup};
	__property System::UnicodeString HintNextBtn = {read=FHintNextBtn, write=FHintNextBtn};
	__property System::UnicodeString HintPrevBtn = {read=FHintPrevBtn, write=FHintPrevBtn};
	__property System::UnicodeString HintCloseBtn = {read=FHintCloseBtn, write=FHintCloseBtn};
	__property System::UnicodeString HintDeleteBtn = {read=FHintDeleteBtn, write=FHintDeleteBtn};
	__property System::UnicodeString HintPopupBtn = {read=FHintPopupBtn, write=FHintPopupBtn};
	__property bool Hover = {read=FHover, write=SetHover, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property int MarginX = {read=FMarginX, write=FMarginX, nodefault};
	__property int MarginY = {read=FMarginY, write=FMarginY, nodefault};
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, default=0};
	__property int MaxHeight = {read=FMaxHeight, write=FMaxHeight, default=0};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property System::UnicodeString PositionFormat = {read=FPositionFormat, write=SetPositionFormat};
	__property bool ShowScrollers = {read=FShowScrollers, write=FShowScrollers, nodefault};
	__property bool ShowDelete = {read=FShowDelete, write=SetShowDelete, nodefault};
	__property bool ShowPopup = {read=FShowPopup, write=SetShowPopup, nodefault};
	__property Graphics::TColor URLColor = {read=FURLColor, write=FURLColor, nodefault};
	__property Graphics::TColor WindowColor = {read=FWindowColor, write=FWindowColor, nodefault};
	__property Graphics::TColor WindowColorTo = {read=FWindowColorTo, write=FWindowColorTo, nodefault};
	__property Classes::TNotifyEvent OnAlertClick = {read=FOnAlertClick, write=FOnAlertClick};
	__property TAnchorClickEvent OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property TDeleteMessageEvent OnDeleteMessage = {read=FOnDeleteMessage, write=FOnDeleteMessage};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnWindowMoved = {read=FOnWindowMoved, write=FOnWindowMoved};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property TCanCloseEvent OnCanClose = {read=FOnCanClose, write=FOnCanClose};
	__property Classes::TNotifyEvent OnNextMessage = {read=FOnNextMessage, write=FOnNextMessage};
	__property Classes::TNotifyEvent OnPrevMessage = {read=FOnPrevMessage, write=FOnPrevMessage};
	__property Classes::TNotifyEvent OnPopupbtnClick = {read=FOnPopupbtnClick, write=FOnPopupbtnClick};
	__property TCustomPaintEvent OnCustomPaint = {read=FOnCustomPaint, write=FOnCustomPaint};
	__property Classes::TNotifyEvent OnDestroy = {read=FOnDestroy, write=FOnDestroy};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAlertWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TFadeThreadDone)(System::TObject* Sender);

typedef void __fastcall (__closure *TOnDeleteItemEvent)(System::TObject* Sender, int Index);

#pragma option push -b-
enum TFadeAction { faNone, faShow, faHide };
#pragma option pop

class DELPHICLASS TFadeThread;
class DELPHICLASS TAdvAlertWindow;
class PASCALIMPLEMENTATION TFadeThread : public Classes::TThread
{
	typedef Classes::TThread inherited;
	
private:
	TAdvAlertWindow* FLayeredWindow;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TFadeThread(TAdvAlertWindow* aLayeredWindow);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TFadeThread(void) { }
	
};


class DELPHICLASS TMsgCollectionItem;
class PASCALIMPLEMENTATION TMsgCollectionItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Classes::TStringList* FText;
	int FImageIndex;
	int FTag;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetText(const Classes::TStringList* Value);
	void __fastcall TextChanged(System::TObject* Sender);
	void __fastcall SetTag(const int Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	
public:
	__fastcall virtual TMsgCollectionItem(Classes::TCollection* Collection);
	__fastcall virtual ~TMsgCollectionItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Classes::TStringList* Text = {read=FText, write=SetText};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property int Tag = {read=FTag, write=SetTag, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
};


class PASCALIMPLEMENTATION TMsgCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TMsgCollectionItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FOwner;
	Classes::TNotifyEvent FOnChange;
	TOnDeleteItemEvent FOnDeleteItem;
	HIDESBASE TMsgCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TMsgCollectionItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TMsgCollection(Classes::TComponent* AOwner);
	__property TMsgCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TMsgCollectionItem* __fastcall Add(void);
	HIDESBASE TMsgCollectionItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TOnDeleteItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TMsgCollection(void) { }
	
};


#pragma option push -b-
enum TWindowPosition { wpLeftTop, wpRightTop, wpLeftBottom, wpRightBottom, wpPreset, wpCenter };
#pragma option pop

typedef void __fastcall (__closure *TOnAnchorClickEvent)(System::TObject* Sender, System::UnicodeString Anchor, TMsgCollectionItem* Item);

class PASCALIMPLEMENTATION TAdvAlertWindow : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Controls::TWinControl* FOwner;
	TAlertWindow* FAlertWindow;
	Picturecontainer::TPictureContainer* FContainer;
	bool FHover;
	TOnAnchorClickEvent FOnAnchorClick;
	System::Byte FAlphaActual;
	System::Byte FAlphaStart;
	System::Byte FAlphaEnd;
	bool FFadeIn;
	bool FFadeOut;
	bool FFading;
	int FHeight;
	int FWidth;
	int FLeft;
	int FTop;
	Controls::TImageList* FImages;
	Graphics::TColor FWindowColor;
	Graphics::TColor FWindowColorTo;
	Graphics::TFont* FFont;
	TGradientDirection FGradientDirection;
	bool FAutoHide;
	bool FAutoSize;
	int FBorderSize;
	bool FAlwaysOnTop;
	int FMarginY;
	int FMarginX;
	System::Byte FFadeStep;
	int FFadeTime;
	TFadeThread* FFadeThread;
	bool FShowFullAlpha;
	Extctrls::TTimer* FTimer;
	TMsgCollection* FAlertMessages;
	int FDisplayTime;
	int FDisplayCounter;
	TWindowPosition FWindowPosition;
	Graphics::TColor FCaptionColorTo;
	Graphics::TColor FCaptionColor;
	System::UnicodeString FHintNextBtn;
	System::UnicodeString FHintPrevBtn;
	System::UnicodeString FHintCloseBtn;
	TAdvAlertWindowStyle FStyle;
	Graphics::TColor FBtnHoverColor;
	Graphics::TColor FBtnDownColor;
	Graphics::TColor FBtnHoverColorTo;
	Graphics::TColor FBtnDownColorTo;
	Graphics::TColor FBorderColor;
	Graphics::TBitmap* FGlyphNext;
	Graphics::TBitmap* FGlyphPrev;
	Graphics::TBitmap* FGlyphDelete;
	bool FAutoDelete;
	TDeleteMessageEvent FOnDeleteMessage;
	TCanDeleteEvent FOnCanDeleteMessage;
	Classes::TNotifyEvent FOnShowMessage;
	Classes::TNotifyEvent FOnAutoHide;
	Classes::TNotifyEvent FOnClose;
	TCanCloseEvent FOnCanClose;
	Classes::TNotifyEvent FOnNextMessage;
	Classes::TNotifyEvent FOnPrevMessage;
	bool FShowDelete;
	System::UnicodeString FHintDeleteBtn;
	Graphics::TBitmap* FGlyphClose;
	System::UnicodeString FPositionFormat;
	int FMaxWidth;
	int FMaxHeight;
	bool FAutoThemeAdapt;
	int FScreenMarginX;
	int FScreenMarginY;
	bool FShowPopup;
	Graphics::TBitmap* FGlyphPopup;
	System::UnicodeString FHintPopupBtn;
	Menus::TPopupMenu* FPopupMenu;
	Classes::TNotifyEvent FOnPopupClick;
	Graphics::TPicture* FBackground;
	bool FShowScrollers;
	bool FPersistPosition;
	System::UnicodeString FRegistryKey;
	TCustomPaintEvent FOnCustomPaint;
	bool FAutoHiding;
	Graphics::TColor FURLColor;
	Classes::TNotifyEvent FOnAlertClick;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetAlphaEnd(const System::Byte Value);
	void __fastcall SetAlphaStart(const System::Byte Value);
	void __fastcall SetAlphaActual(const System::Byte Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	int __fastcall SetAlertPos(void);
	void __fastcall ThreadDone(System::TObject* Sender);
	void __fastcall UpdateAlertMessages(void);
	void __fastcall AlertMessagesOnChange(System::TObject* Sender);
	void __fastcall AlertMessagesOnDeleteItem(System::TObject* Sender, int index);
	void __fastcall AlertWindowMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall AlertWindowOnMouseLeave(System::TObject* Sender);
	void __fastcall AlertWindowOnClose(System::TObject* Sender);
	void __fastcall AlertWindowOnCanClose(System::TObject* Sender, bool &CanClose);
	void __fastcall AlertWindowOnNextMessage(System::TObject* Sender);
	void __fastcall AlertWindowOnPrevMessage(System::TObject* Sender);
	void __fastcall AlertWindowOnDelete(System::TObject* Sender, int index);
	void __fastcall AlertWindowOnPopupBtnClick(System::TObject* Sender);
	void __fastcall OnTimer(System::TObject* Sender);
	void __fastcall SetDisplayTime(const int Value);
	void __fastcall SetWindowPosition(const TWindowPosition Value);
	void __fastcall AlertWindowMoved(System::TObject* Sender);
	void __fastcall SetTimer(bool Active);
	void __fastcall SetStyle(const TAdvAlertWindowStyle Value);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SetGlyphDelete(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphNext(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphPrev(const Graphics::TBitmap* Value);
	void __fastcall SetAutoHide(const bool Value);
	void __fastcall SetAutoDelete(const bool Value);
	void __fastcall SetShowDelete(const bool Value);
	void __fastcall SetShowPopup(const bool Value);
	void __fastcall SetGlyphClose(const Graphics::TBitmap* Value);
	int __fastcall GetActiveMessage(void);
	void __fastcall SetActiveMessage(const int Value);
	void __fastcall SetPositionFormat(const System::UnicodeString Value);
	void __fastcall SetBackground(const Graphics::TPicture* Value);
	void __fastcall ThemeAdapt(void);
	void __fastcall SetGlyphPopup(const Graphics::TBitmap* Value);
	void __fastcall SetPopupMenu(const Menus::TPopupMenu* Value);
	bool __fastcall GetVisible(void);
	int __fastcall GetLeft(void);
	int __fastcall GetTop(void);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	unsigned __fastcall GetWindowHandle(void);
	
protected:
	void __fastcall WindowAnchorClick(System::TObject* Sender, System::UnicodeString Anchor, int index);
	void __fastcall AlertClick(System::TObject* Sender);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall CreateAlertWindow(void);
	void __fastcall ApplyStyle(void);
	void __fastcall SetMessages(void);
	void __fastcall TextChanged(System::TObject* Sender);
	void __fastcall AlertDestroyed(System::TObject* Sender);
	void __fastcall CustomPaint(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect, bool &DefaultDraw);
	__property int BorderSize = {read=FBorderSize, write=FBorderSize, nodefault};
	__property System::Byte AlphaActual = {read=FAlphaActual, write=SetAlphaActual, nodefault};
	__property bool AutoHiding = {read=FAutoHiding, write=FAutoHiding, nodefault};
	
public:
	__fastcall virtual TAdvAlertWindow(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvAlertWindow(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Update(void);
	void __fastcall Show(void);
	void __fastcall Hide(void);
	void __fastcall CloseAlert(void);
	void __fastcall Next(void);
	void __fastcall Previous(void);
	void __fastcall First(void);
	void __fastcall Last(void);
	void __fastcall SavePosition(void);
	void __fastcall LoadPosition(void);
	void __fastcall DeleteMessage(int Index);
	__property int ActiveMessage = {read=GetActiveMessage, write=SetActiveMessage, nodefault};
	__property bool IsVisible = {read=GetVisible, nodefault};
	__property bool IsFading = {read=FFading, nodefault};
	__property unsigned Handle = {read=GetWindowHandle, nodefault};
	__property TAlertWindow* AlertWindow = {read=FAlertWindow};
	
__published:
	__property TMsgCollection* AlertMessages = {read=FAlertMessages, write=FAlertMessages};
	__property bool AlwaysOnTop = {read=FAlwaysOnTop, write=FAlwaysOnTop, nodefault};
	__property bool AutoHide = {read=FAutoHide, write=SetAutoHide, nodefault};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property bool AutoSize = {read=FAutoSize, write=FAutoSize, nodefault};
	__property bool AutoDelete = {read=FAutoDelete, write=SetAutoDelete, nodefault};
	__property Graphics::TPicture* Background = {read=FBackground, write=SetBackground};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, nodefault};
	__property Graphics::TColor BtnHoverColor = {read=FBtnHoverColor, write=FBtnHoverColor, nodefault};
	__property Graphics::TColor BtnHoverColorTo = {read=FBtnHoverColorTo, write=FBtnHoverColorTo, nodefault};
	__property Graphics::TColor BtnDownColor = {read=FBtnDownColor, write=FBtnDownColor, nodefault};
	__property Graphics::TColor BtnDownColorTo = {read=FBtnDownColorTo, write=FBtnDownColorTo, nodefault};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=FCaptionColor, nodefault};
	__property Graphics::TColor CaptionColorTo = {read=FCaptionColorTo, write=FCaptionColorTo, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=FGradientDirection, nodefault};
	__property Graphics::TBitmap* GlyphPrev = {read=FGlyphPrev, write=SetGlyphPrev};
	__property Graphics::TBitmap* GlyphNext = {read=FGlyphNext, write=SetGlyphNext};
	__property Graphics::TBitmap* GlyphDelete = {read=FGlyphDelete, write=SetGlyphDelete};
	__property Graphics::TBitmap* GlyphClose = {read=FGlyphClose, write=SetGlyphClose};
	__property Graphics::TBitmap* GlyphPopup = {read=FGlyphPopup, write=SetGlyphPopup};
	__property System::UnicodeString HintNextBtn = {read=FHintNextBtn, write=FHintNextBtn};
	__property System::UnicodeString HintPrevBtn = {read=FHintPrevBtn, write=FHintPrevBtn};
	__property System::UnicodeString HintCloseBtn = {read=FHintCloseBtn, write=FHintCloseBtn};
	__property System::UnicodeString HintDeleteBtn = {read=FHintDeleteBtn, write=FHintDeleteBtn};
	__property System::UnicodeString HintPopupBtn = {read=FHintPopupBtn, write=FHintPopupBtn};
	__property bool Hover = {read=FHover, write=FHover, nodefault};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property int MarginX = {read=FMarginX, write=FMarginX, nodefault};
	__property int MarginY = {read=FMarginY, write=FMarginY, nodefault};
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, default=0};
	__property int MaxHeight = {read=FMaxHeight, write=FMaxHeight, default=0};
	__property bool PersistPosition = {read=FPersistPosition, write=FPersistPosition, default=0};
	__property Picturecontainer::TPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property int PopupLeft = {read=GetLeft, write=SetLeft, nodefault};
	__property int PopupTop = {read=GetTop, write=SetTop, nodefault};
	__property int PopupWidth = {read=FWidth, write=FWidth, nodefault};
	__property int PopupHeight = {read=FHeight, write=FHeight, nodefault};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=SetPopupMenu};
	__property System::UnicodeString PositionFormat = {read=FPositionFormat, write=SetPositionFormat};
	__property System::UnicodeString RegistryKey = {read=FRegistryKey, write=FRegistryKey};
	__property Graphics::TColor WindowColor = {read=FWindowColor, write=FWindowColor, nodefault};
	__property Graphics::TColor WindowColorTo = {read=FWindowColorTo, write=FWindowColorTo, nodefault};
	__property bool ShowScrollers = {read=FShowScrollers, write=FShowScrollers, nodefault};
	__property bool ShowDelete = {read=FShowDelete, write=SetShowDelete, nodefault};
	__property bool ShowPopup = {read=FShowPopup, write=SetShowPopup, nodefault};
	__property System::Byte AlphaEnd = {read=FAlphaEnd, write=SetAlphaEnd, nodefault};
	__property System::Byte AlphaStart = {read=FAlphaStart, write=SetAlphaStart, nodefault};
	__property int FadeTime = {read=FFadeTime, write=FFadeTime, default=50};
	__property int DisplayTime = {read=FDisplayTime, write=SetDisplayTime, nodefault};
	__property System::Byte FadeStep = {read=FFadeStep, write=FFadeStep, nodefault};
	__property TWindowPosition WindowPosition = {read=FWindowPosition, write=SetWindowPosition, nodefault};
	__property int ScreenMarginX = {read=FScreenMarginX, write=FScreenMarginX, default=0};
	__property int ScreenMarginY = {read=FScreenMarginY, write=FScreenMarginY, default=0};
	__property TAdvAlertWindowStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Graphics::TColor URLColor = {read=FURLColor, write=FURLColor, default=16711680};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TOnAnchorClickEvent OnAnchorClick = {read=FOnAnchorClick, write=FOnAnchorClick};
	__property Classes::TNotifyEvent OnAlertClick = {read=FOnAlertClick, write=FOnAlertClick};
	__property Classes::TNotifyEvent OnAutoHide = {read=FOnAutoHide, write=FOnAutoHide};
	__property TCanDeleteEvent OnCanDeleteMessage = {read=FOnCanDeleteMessage, write=FOnCanDeleteMessage};
	__property TDeleteMessageEvent OnDeleteMessage = {read=FOnDeleteMessage, write=FOnDeleteMessage};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property TCanCloseEvent OnCanClose = {read=FOnCanClose, write=FOnCanClose};
	__property TCustomPaintEvent OnCustomPaint = {read=FOnCustomPaint, write=FOnCustomPaint};
	__property Classes::TNotifyEvent OnNextMessage = {read=FOnNextMessage, write=FOnNextMessage};
	__property Classes::TNotifyEvent OnPrevMessage = {read=FOnPrevMessage, write=FOnPrevMessage};
	__property Classes::TNotifyEvent OnPopupClick = {read=FOnPopupClick, write=FOnPopupClick};
	__property Classes::TNotifyEvent OnShowMessage = {read=FOnShowMessage, write=FOnShowMessage};
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
static const ShortInt CloseBtnSize = 0x14;
static const ShortInt ScrollBtnHeight = 0x19;
static const ShortInt ScrollBtnWidth = 0x14;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x7;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advalertwindow */
using namespace Advalertwindow;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvalertwindowHPP
