// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtouchkeyboard.pas' rev: 21.00

#ifndef AdvtouchkeyboardHPP
#define AdvtouchkeyboardHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtouchkeyboard
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TSpecialKey { skNone, skAlt, skAltGr, skShift, skCaps, skCtrl, skNum, skScroll, skReturn, skAdd, skDivide, skDecimal, skSubstract, skMultiply, skTab, skWin, skApp, skBackSpace, skSpaceBar, skLeft, skRight, skUp, skDown, skNext, skPrior, skHome, skEnd };
#pragma option pop

typedef void __fastcall (__closure *TTouchKeyEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TAdvTouchKey;
class DELPHICLASS TAdvTouchKeyItem;
class PASCALIMPLEMENTATION TAdvTouchKey : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	System::UnicodeString FCaption;
	Graphics::TBitmap* FCurrentBitmap;
	TAdvTouchKeyItem* FItem;
	Graphics::TBitmap* FPictureNormalState;
	Graphics::TBitmap* FPictureDownState;
	int FKeyValue;
	Controls::TKeyEvent FOnKeyDown;
	Graphics::TBitmap* FBmp;
	TSpecialKey FSpecialKey;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderColorDown;
	Graphics::TColor FColor;
	Graphics::TColor FTextColorDown;
	Graphics::TColor FColorDown;
	int FImageIndex;
	Graphics::TColor FTextColor;
	System::UnicodeString FAltGrCaption;
	System::UnicodeString FShiftCaption;
	System::Byte FDownState;
	bool FKeyNormalPosition;
	Graphics::TFont* FSmallFont;
	Graphics::TFont* FFont;
	int FAltGrKeyValue;
	int FShiftKeyValue;
	int FOldH;
	int FOldW;
	int FOldX;
	int FOldY;
	System::UnicodeString FShortCut;
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetPictureDownState(const Graphics::TBitmap* Value);
	void __fastcall SetPictureNormalState(const Graphics::TBitmap* Value);
	void __fastcall SetAltGrCaption(const System::UnicodeString Value);
	void __fastcall SetAltrCaption(const System::UnicodeString Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	bool __fastcall GetDownState(void);
	void __fastcall SetDownState(const bool Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TAdvTouchKey(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvTouchKey(void);
	__property TAdvTouchKeyItem* TouchKeyItem = {read=FItem, write=FItem};
	__property int OldH = {read=FOldH, write=FOldH, nodefault};
	__property int OldW = {read=FOldW, write=FOldW, nodefault};
	__property int OldX = {read=FOldX, write=FOldX, nodefault};
	__property int OldY = {read=FOldY, write=FOldY, nodefault};
	__property bool Down = {read=GetDownState, write=SetDownState, nodefault};
	
__published:
	__property Left;
	__property Top;
	__property System::UnicodeString ShiftCaption = {read=FShiftCaption, write=SetAltrCaption};
	__property System::UnicodeString AltGrCaption = {read=FAltGrCaption, write=SetAltGrCaption};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=FBorderColorDown, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=FColorDown, default=8421504};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, default=0};
	__property Graphics::TColor TextColorDown = {read=FTextColorDown, write=FTextColorDown, default=0};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property Height = {default=40};
	__property Width = {default=40};
	__property TSpecialKey SpecialKey = {read=FSpecialKey, write=FSpecialKey, nodefault};
	__property int KeyValue = {read=FKeyValue, write=FKeyValue, default=-1};
	__property int ShiftKeyValue = {read=FShiftKeyValue, write=FShiftKeyValue, default=-1};
	__property int AltGrKeyValue = {read=FAltGrKeyValue, write=FAltGrKeyValue, default=-1};
	__property Graphics::TBitmap* PictureDownState = {read=FPictureDownState, write=SetPictureDownState};
	__property Graphics::TBitmap* PictureNormalState = {read=FPictureNormalState, write=SetPictureNormalState};
	__property System::UnicodeString ShortCut = {read=FShortCut, write=FShortCut};
	__property Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
};


class PASCALIMPLEMENTATION TAdvTouchKeyItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvTouchKey* FTouchKey;
	System::UnicodeString __fastcall GetCaption(void);
	int __fastcall GetX(void);
	int __fastcall GetY(void);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetX(const int Value);
	void __fastcall SetY(const int Value);
	void __fastcall SetPictureDownState(const Graphics::TBitmap* Value);
	void __fastcall SetPictureNormalState(const Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetPictureDownState(void);
	Graphics::TBitmap* __fastcall GetPictureNormalState(void);
	int __fastcall GetHeight(void);
	int __fastcall GetWidth(void);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	int __fastcall GetOldH(void);
	int __fastcall GetOldW(void);
	void __fastcall SetOldH(const int Value);
	void __fastcall SetOldW(const int Value);
	int __fastcall GetOldX(void);
	int __fastcall GetOldY(void);
	void __fastcall SetOldX(const int Value);
	void __fastcall SetOldY(const int Value);
	int __fastcall GetKeyValue(void);
	void __fastcall SetKeyvalue(const int Value);
	Graphics::TColor __fastcall GetBorderColor(void);
	Graphics::TColor __fastcall GetBorderColorDown(void);
	Graphics::TColor __fastcall GetColor(void);
	Graphics::TColor __fastcall GetColorDown(void);
	int __fastcall GetImageIndex(void);
	TSpecialKey __fastcall GetSpecialKey(void);
	Graphics::TColor __fastcall GetTextColor(void);
	Graphics::TColor __fastcall GetTextColorDown(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetpecialKey(const TSpecialKey Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetTextColorDown(const Graphics::TColor Value);
	System::UnicodeString __fastcall GetShiftCaption(void);
	System::UnicodeString __fastcall GetAltGrCaption(void);
	void __fastcall SetAltGrCaption(const System::UnicodeString Value);
	void __fastcall SetShiftCaption(const System::UnicodeString Value);
	int __fastcall GetAltGrKeyValue(void);
	int __fastcall GetShiftKeyValue(void);
	void __fastcall SetAltGrKeyValue(const int Value);
	void __fastcall SetShiftKeyValue(const int Value);
	System::UnicodeString __fastcall GetShortCut(void);
	void __fastcall SetShortCut(const System::UnicodeString Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TAdvTouchKeyItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvTouchKeyItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property int OldH = {read=GetOldH, write=SetOldH, nodefault};
	__property int OldW = {read=GetOldW, write=SetOldW, nodefault};
	__property int OldX = {read=GetOldX, write=SetOldX, nodefault};
	__property int OldY = {read=GetOldY, write=SetOldY, nodefault};
	
__published:
	__property int X = {read=GetX, write=SetX, nodefault};
	__property int Y = {read=GetY, write=SetY, nodefault};
	__property System::UnicodeString Caption = {read=GetCaption, write=SetCaption};
	__property System::UnicodeString ShiftCaption = {read=GetShiftCaption, write=SetShiftCaption};
	__property System::UnicodeString AltGrCaption = {read=GetAltGrCaption, write=SetAltGrCaption};
	__property int KeyValue = {read=GetKeyValue, write=SetKeyvalue, nodefault};
	__property int ShiftKeyValue = {read=GetShiftKeyValue, write=SetShiftKeyValue, nodefault};
	__property int AltGrKeyValue = {read=GetAltGrKeyValue, write=SetAltGrKeyValue, nodefault};
	__property Graphics::TBitmap* PictureDownState = {read=GetPictureDownState, write=SetPictureDownState};
	__property Graphics::TBitmap* PictureNormalState = {read=GetPictureNormalState, write=SetPictureNormalState};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
	__property TSpecialKey SpecialKey = {read=GetSpecialKey, write=SetpecialKey, nodefault};
	__property Graphics::TColor BorderColor = {read=GetBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderColorDown = {read=GetBorderColorDown, write=SetBorderColorDown, nodefault};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorDown = {read=GetColorDown, write=SetColorDown, nodefault};
	__property Graphics::TColor TextColor = {read=GetTextColor, write=SetTextColor, nodefault};
	__property Graphics::TColor TextColorDown = {read=GetTextColorDown, write=SetTextColorDown, nodefault};
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, nodefault};
	__property System::UnicodeString ShortCut = {read=GetShortCut, write=SetShortCut};
};


class DELPHICLASS TAdvTouchKeyCollection;
class PASCALIMPLEMENTATION TAdvTouchKeyCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvTouchKeyItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TComponent* FOwner;
	HIDESBASE TAdvTouchKeyItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvTouchKeyItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvTouchKeyCollection(Classes::TComponent* AOwner);
	HIDESBASE TAdvTouchKeyItem* __fastcall Add(void);
	HIDESBASE TAdvTouchKeyItem* __fastcall Insert(int index);
	__property TAdvTouchKeyItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvTouchKeyCollection(void) { }
	
};


#pragma option push -b-
enum TKeyboardType { ktQWERTY, ktAZERTY, ktDVORAK, ktNUMERIC, ktCELLPHONE, ktQWERTZ, ktCustom };
#pragma option pop

typedef void __fastcall (__closure *TDrawKeyEvent)(System::TObject* Sender, TAdvTouchKeyItem* Key, Graphics::TCanvas* Canvas, bool Down, const Types::TRect &Rect, bool &DefaultDraw);

class DELPHICLASS TAdvTouchKeyboard;
class PASCALIMPLEMENTATION TAdvTouchKeyboard : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Extctrls::TTimer* FCapsTimer;
	TAdvTouchKeyCollection* FKeys;
	Controls::TKeyEvent FOnKeyDown;
	Graphics::TBitmap* FPictureNormalState;
	Graphics::TBitmap* FPictureDownState;
	Graphics::TFont* FSmallFont;
	TKeyboardType FKeyboardType;
	TDrawKeyEvent FOnDrawKey;
	Controls::TImageList* FImages;
	Classes::TShiftState FShift;
	bool FAutoPostKey;
	Graphics::TColor FHighlightCaps;
	bool FAutoCapsDisplay;
	Graphics::TColor FHighlightAltGr;
	bool FDisableErase;
	Extctrls::TTimer* FRepeatTimer;
	int FRepeatTimerCount;
	int FRepeatItemIndex;
	TTouchKeyEvent FOnKeyClick;
	int FKeyDistance;
	int FOldW;
	int FOldH;
	bool FPostWMCharOnly;
	bool FCapsDown;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	void __fastcall SetKeys(const TAdvTouchKeyCollection* Value);
	void __fastcall SetPictureDownState(const Graphics::TBitmap* Value);
	void __fastcall SetPictureNormalState(const Graphics::TBitmap* Value);
	void __fastcall SetSmallFont(const Graphics::TFont* Value);
	void __fastcall SetKeyboardType(const TKeyboardType Value);
	void __fastcall AddKey(System::ShortString &Caption, System::ShortString &ShiftCaption, System::ShortString &AltGrCaption, int KeyValue, int ShiftKeyValue, int AltGrKeyValue, int ImageIndex, int Width, int Height, int &X, int Y, TSpecialKey SpecialKey, Graphics::TColor Color = (Graphics::TColor)(0xc0c0c0));
	void __fastcall NewRow(int &X, int &Y, int Size);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall PostNormalKeys(int Index);
	void __fastcall PostSpecialKeys(System::Word Key, const Classes::TShiftState pShift, bool SpecialKey);
	HWND __fastcall GetKeybdInputHandle(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetAutoCapsDisplay(const bool Value);
	void __fastcall SetHighlightAltGr(const Graphics::TColor Value);
	void __fastcall SetHighlightCaps(const Graphics::TColor Value);
	void __fastcall SetKeyDistance(int Value);
	bool __fastcall IsCapsDown(void);
	
protected:
	void __fastcall ItemKeyDown(int Index);
	void __fastcall ItemKeyUp(int Index);
	void __fastcall SyncEqualKeys(int Index);
	void __fastcall TurnOffShifts(void);
	void __fastcall DrawKey(System::TObject* Sender, TAdvTouchKeyItem* Key, Graphics::TCanvas* Canvas, bool Down, const Types::TRect &Rect, bool &DefaultDraw);
	void __fastcall BuildQWERTYKeyBoard(void);
	void __fastcall BuildQWERTZKeyBoard(void);
	void __fastcall BuildAZERTYKeyBoard(void);
	void __fastcall BuildDVORAKKeyBoard(void);
	void __fastcall BuildNumericKeyBoard(void);
	void __fastcall BuildCellPhoneKeyboard(void);
	__property Classes::TShiftState Shift = {read=FShift, write=FShift, nodefault};
	__property HWND KeybdInputHandle = {read=GetKeybdInputHandle, nodefault};
	void __fastcall PaintAllKeys(void);
	virtual void __fastcall Paint(void);
	void __fastcall StartTimer(int index);
	void __fastcall StopTimer(void);
	void __fastcall RepeatTimerProc(System::TObject* Sender);
	void __fastcall CapsTimerProc(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvTouchKeyboard(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvTouchKeyboard(void);
	void __fastcall Zoom(double fhorz, double fvert, bool keysonly = false, bool absoluteZoom = false);
	void __fastcall SaveKeybdLayout(System::UnicodeString FileName);
	void __fastcall LoadKeybdLayout(System::UnicodeString FileName);
	void __fastcall PostKey(System::Word Key, const Classes::TShiftState pShift, bool ExtendedKeyBD, int Index);
	__property bool PostWMCharOnly = {read=FPostWMCharOnly, write=FPostWMCharOnly, nodefault};
	
__published:
	__property Align = {default=0};
	__property Font;
	__property Color = {default=-16777201};
	__property bool AutoPostKey = {read=FAutoPostKey, write=FAutoPostKey, default=1};
	__property bool AutoCapsDisplay = {read=FAutoCapsDisplay, write=SetAutoCapsDisplay, default=0};
	__property Graphics::TColor HighlightCaps = {read=FHighlightCaps, write=SetHighlightCaps, default=536870911};
	__property Graphics::TColor HighlightAltGr = {read=FHighlightAltGr, write=SetHighlightAltGr, default=536870911};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property TKeyboardType KeyboardType = {read=FKeyboardType, write=SetKeyboardType, nodefault};
	__property int KeyDistance = {read=FKeyDistance, write=SetKeyDistance, default=0};
	__property TAdvTouchKeyCollection* Keys = {read=FKeys, write=SetKeys};
	__property Graphics::TBitmap* PictureDownState = {read=FPictureDownState, write=SetPictureDownState};
	__property Graphics::TBitmap* PictureNormalState = {read=FPictureNormalState, write=SetPictureNormalState};
	__property Graphics::TFont* SmallFont = {read=FSmallFont, write=SetSmallFont};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property TTouchKeyEvent OnKeyClick = {read=FOnKeyClick, write=FOnKeyClick};
	__property Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property TDrawKeyEvent OnDrawKey = {read=FOnDrawKey, write=FOnDrawKey};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvTouchKeyboard(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


class DELPHICLASS TKeyboardToolForm;
class PASCALIMPLEMENTATION TKeyboardToolForm : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	bool FShowCaption;
	bool FShowClose;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
__published:
	__property bool ShowClose = {read=FShowClose, write=FShowClose, nodefault};
	__property bool ShowCaption = {read=FShowCaption, write=FShowCaption, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKeyboardToolForm(Classes::TComponent* AOwner) : Forms::TCustomForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKeyboardToolForm(Classes::TComponent* AOwner, int Dummy) : Forms::TCustomForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKeyboardToolForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TKeyboardToolForm(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvPopupTouchKeyBoard;
class PASCALIMPLEMENTATION TAdvPopupTouchKeyBoard : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Extctrls::TTimer* FTimer;
	TKeyboardToolForm* FFrm;
	TAdvTouchKeyboard* FKbd;
	Forms::TCustomForm* FOwnerform;
	bool FAutoCapsDisplay;
	bool FAutoPostKey;
	Graphics::TColor FHighlightCaps;
	TKeyboardType FKeyboardType;
	Graphics::TColor FHighlightAltGr;
	bool FAutoFollowFocus;
	bool FAutoHide;
	bool FShowCaption;
	bool FShowClose;
	bool FDisableSizing;
	Classes::TNotifyEvent FOnClose;
	Classes::TNotifyEvent FOnShow;
	Classes::TNotifyEvent FOnKeyboardCreated;
	int FLastX;
	int FLastY;
	void __fastcall SetAutoCapsDisplay(const bool Value);
	void __fastcall SetAutoPostKey(const bool Value);
	void __fastcall SetHighlightAltGr(const Graphics::TColor Value);
	void __fastcall SetHighlightCaps(const Graphics::TColor Value);
	void __fastcall SetKeyboardType(const TKeyboardType Value);
	void __fastcall KeyboardSizeChanged(System::TObject* Sender);
	
protected:
	void __fastcall TimerProc(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
public:
	__fastcall virtual TAdvPopupTouchKeyBoard(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPopupTouchKeyBoard(void);
	virtual void __fastcall CreateForm(void);
	void __fastcall Show(void);
	void __fastcall ShowAtXY(int x, int y)/* overload */;
	void __fastcall ShowAtXY(Forms::TCustomForm* AParent, int x, int y)/* overload */;
	void __fastcall Hide(void);
	__property TAdvTouchKeyboard* Keyboard = {read=FKbd};
	
__published:
	__property bool ShowCaption = {read=FShowCaption, write=FShowCaption, default=1};
	__property bool ShowClose = {read=FShowClose, write=FShowClose, default=1};
	__property bool AutoFollowFocus = {read=FAutoFollowFocus, write=FAutoFollowFocus, default=0};
	__property bool AutoHide = {read=FAutoHide, write=FAutoHide, default=0};
	__property bool AutoPostKey = {read=FAutoPostKey, write=SetAutoPostKey, default=1};
	__property bool AutoCapsDisplay = {read=FAutoCapsDisplay, write=SetAutoCapsDisplay, default=0};
	__property Graphics::TColor HighlightCaps = {read=FHighlightCaps, write=SetHighlightCaps, default=536870911};
	__property Graphics::TColor HighlightAltGr = {read=FHighlightAltGr, write=SetHighlightAltGr, default=536870911};
	__property TKeyboardType KeyboardType = {read=FKeyboardType, write=SetKeyboardType, nodefault};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
	__property Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property Classes::TNotifyEvent OnKeyboardCreated = {read=FOnKeyboardCreated, write=FOnKeyboardCreated};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x7;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advtouchkeyboard */
using namespace Advtouchkeyboard;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtouchkeyboardHPP
