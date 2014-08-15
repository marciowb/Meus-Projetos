// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothdock.pas' rev: 21.00

#ifndef AdvsmoothdockHPP
#define AdvsmoothdockHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advsmoothdockdragdrop.hpp>	// Pascal unit
#include <Olectnrs.hpp>	// Pascal unit
#include <Shellapi.hpp>	// Pascal unit
#include <Axctrls.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothdock
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


class DELPHICLASS TAdvSmoothDockForm;
class DELPHICLASS TAdvSmoothDock;
class PASCALIMPLEMENTATION TAdvSmoothDockForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	bool FMouseEntered;
	void *OldWndProc;
	void *NewWndProc;
	Advgdip::TGPBitmap* FMainBuffer;
	TAdvSmoothDock* FDock;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	
protected:
	void __fastcall FormHookInit(void);
	void __fastcall FormHookDone(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DoCreate(void);
	virtual void __fastcall DoDestroy(void);
	DYNAMIC void __fastcall Paint(void);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall DragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall Draw(Advgdip::TGPGraphics* graphics);
	void __fastcall CreateMainBuffer(void);
	void __fastcall DestroyMainBuffer(void);
	void __fastcall ClearBuffer(Advgdip::TGPGraphics* graphics);
	Advgdip::TGPGraphics* __fastcall CreateGraphics(void);
	void __fastcall SetLayeredWindow(void);
	void __fastcall UpdateLayered(void);
	void __fastcall UpdateMainWindow(void);
	void __fastcall UpdateWindow(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall HookWndProc(Messages::TMessage &Msg);
	
public:
	void __fastcall Init(void);
	__fastcall virtual TAdvSmoothDockForm(Classes::TComponent* AOwner, int Dummy);
	__property TAdvSmoothDock* OwnerDock = {read=FDock, write=FDock};
	DYNAMIC void __fastcall DragDrop(System::TObject* Source, int X, int Y);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmoothDockForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmoothDockForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothDockForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


#pragma option push -b-
enum TAdvSmoothDockImageType { itPNG, itBMP, itJPEG, itTIFF, itGIF };
#pragma option pop

class DELPHICLASS TAdvSmoothDockStatus;
class PASCALIMPLEMENTATION TAdvSmoothDockStatus : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothDock* FOwner;
	int FOffsetTop;
	int FOffsetLeft;
	bool FVisible;
	System::UnicodeString FCaption;
	Gdipfill::TGDIPStatus* FAppearance;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetAppearance(const Gdipfill::TGDIPStatus* Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetOffsetLeft(const int Value);
	void __fastcall SetOffsetTop(const int Value);
	void __fastcall SetVisible(const bool Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothDockStatus(TAdvSmoothDock* AOwner);
	__fastcall virtual ~TAdvSmoothDockStatus(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int OffsetLeft = {read=FOffsetLeft, write=SetOffsetLeft, default=0};
	__property int OffsetTop = {read=FOffsetTop, write=SetOffsetTop, default=0};
	__property Gdipfill::TGDIPStatus* Appearance = {read=FAppearance, write=SetAppearance};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothDockItem;
class PASCALIMPLEMENTATION TAdvSmoothDockItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool dolastjumpdown;
	bool dolastjumpup;
	Advgdip::TGPRectF FItemRect;
	bool FInsertItem;
	bool FDoItemAnimation;
	TAdvSmoothDock* FOwner;
	double FJMP;
	double FJMPTO;
	double FHoverSizeW;
	double FHoverSizeToW;
	double FHoverSizeH;
	double FHoverSizeToH;
	Advgdip::TGPBitmap* FReflectionImage;
	Advgdip::TAdvGDIPPicture* FImage;
	bool FEnabled;
	bool FVisible;
	System::UnicodeString FCaption;
	System::UnicodeString FHint;
	bool FDoLastJump;
	bool FJump;
	bool FJumpUp;
	bool FJumpDown;
	Menus::TPopupMenu* FPopupMenu;
	TAdvSmoothDockStatus* FStatusIndicator;
	bool FSeparator;
	bool FShowCaption;
	int FProgressMaximum;
	int FProgressMinimum;
	int FProgressPosition;
	System::UnicodeString FFilePath;
	System::TObject* FObject;
	int FTag;
	System::UnicodeString FData;
	void __fastcall SetImage(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetJump(const bool Value);
	void __fastcall SetStatusIndicator(const TAdvSmoothDockStatus* Value);
	void __fastcall SetSeparator(const bool Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetProgressMaximum(const int Value);
	void __fastcall SetProgressMinimum(const int Value);
	void __fastcall SetProgressPosition(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall ImageChanged(System::TObject* Sender);
	void __fastcall StatusIndicatorChanged(System::TObject* Sender);
	void __fastcall UpdateReflection(void);
	Advgdip::TGPRectF __fastcall GetItemRect(void);
	Advgdip::TGPRectF __fastcall GetItemRectCenter(void);
	Advgdip::TGPRectF __fastcall GetHoverRect(void);
	Advgdip::TGPRectF __fastcall GetNormalRect(void);
	void __fastcall Popup(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvSmoothDockItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothDockItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::UnicodeString FilePath = {read=FFilePath, write=FFilePath};
	int __fastcall GetVisibleIndex(int Item);
	
__published:
	__property Advgdip::TAdvGDIPPicture* Image = {read=FImage, write=SetImage};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property System::UnicodeString Data = {read=FData, write=FData};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property System::TObject* ItemObject = {read=FObject, write=FObject};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property bool Jump = {read=FJump, write=SetJump, default=0};
	__property TAdvSmoothDockStatus* StatusIndicator = {read=FStatusIndicator, write=SetStatusIndicator};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=FPopupMenu};
	__property bool Separator = {read=FSeparator, write=SetSeparator, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property int ProgressMaximum = {read=FProgressMaximum, write=SetProgressMaximum, default=100};
	__property int ProgressMinimum = {read=FProgressMinimum, write=SetProgressMinimum, default=0};
	__property int ProgressPosition = {read=FProgressPosition, write=SetProgressPosition, default=0};
};


class DELPHICLASS TAdvSmoothDockItems;
class PASCALIMPLEMENTATION TAdvSmoothDockItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothDockItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothDock* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothDockItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothDockItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothDockItems(TAdvSmoothDock* AOwner);
	HIDESBASE TAdvSmoothDockItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothDockItem* __fastcall Insert(int Index);
	__property TAdvSmoothDockItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothDockItems(void) { }
	
};


class DELPHICLASS TAdvSmoothDockItemAppearance;
class PASCALIMPLEMENTATION TAdvSmoothDockItemAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothDock* FOwner;
	int FImageHeight;
	int FImageWidth;
	Classes::TNotifyEvent FOnChanged;
	int FSpacing;
	Gdipfill::TGDIPFill* FFill;
	int FMaxImageWidth;
	int FMaxImageHeight;
	bool FBackGroundVisible;
	int FReflectionSpacing;
	int FImageOffset;
	System::Byte FReflectionStart;
	System::Byte FReflectionEnd;
	int FReflectionSize;
	Gdipfill::TGDIPFill* FSelectionFill;
	Gdipfill::TGDIPFill* FCaptionFill;
	Graphics::TFont* FCaptionFont;
	int FSelectionSize;
	int FSelectionOffset;
	Gdipfill::TGDIPFill* FSelectedFill;
	Gdipfill::TGDIPFill* FHoverFill;
	Gdipfill::TGDIPFill* FDisabledFill;
	bool FItemFill;
	Gdipfill::TGDIPFill* FProgressFill;
	Gdipfill::TGDIPFill* FSeparatorFill;
	int FSeparatorSize;
	bool FAspectRatio;
	int FJumpMargin;
	int FAnimationSpan;
	bool FShowSelection;
	bool FPermanentCaption;
	void __fastcall SetImageHeight(const int Value);
	void __fastcall SetImageWidth(const int Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetMaxImageHeight(const int Value);
	void __fastcall SetMaxImageWidth(const int Value);
	void __fastcall SetReflectionSpacing(const int Value);
	void __fastcall SetImageOffset(const int Value);
	void __fastcall SetReflectionEnd(const System::Byte Value);
	void __fastcall SetReflectionStart(const System::Byte Value);
	void __fastcall SetReflectionSize(const int Value);
	void __fastcall SetSelectionFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetCaptionFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetSelectionSize(const int Value);
	void __fastcall SetSelectionOffset(const int Value);
	void __fastcall SetHoverFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSelectedFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDisabledFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetItemFill(const bool Value);
	void __fastcall SetProgressFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSeparatorFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSeparatorSize(const int Value);
	void __fastcall SetAspectRatio(const bool Value);
	void __fastcall SetJumpMargin(const int Value);
	void __fastcall SetAnimationSpan(const int Value);
	void __fastcall SetShowSelection(const bool Value);
	void __fastcall SetPermanentCaption(const bool Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall SeparatorChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothDockItemAppearance(TAdvSmoothDock* AOwner);
	__fastcall virtual ~TAdvSmoothDockItemAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int JumpMargin = {read=FJumpMargin, write=SetJumpMargin, default=40};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property bool AspectRatio = {read=FAspectRatio, write=SetAspectRatio, default=1};
	__property Gdipfill::TGDIPFill* HoverFill = {read=FHoverFill, write=SetHoverFill};
	__property Gdipfill::TGDIPFill* SelectedFill = {read=FSelectedFill, write=SetSelectedFill};
	__property Gdipfill::TGDIPFill* DisabledFill = {read=FDisabledFill, write=SetDisabledFill};
	__property bool ItemBackGround = {read=FItemFill, write=SetItemFill, default=0};
	__property int ImageWidth = {read=FImageWidth, write=SetImageWidth, default=50};
	__property int ImageHeight = {read=FImageHeight, write=SetImageHeight, default=50};
	__property int ImageOffset = {read=FImageOffset, write=SetImageOffset, default=40};
	__property int MaximumImageHeight = {read=FMaxImageHeight, write=SetMaxImageHeight, default=120};
	__property int MaximumImageWidth = {read=FMaxImageWidth, write=SetMaxImageWidth, default=120};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=40};
	__property Classes::TNotifyEvent OnChange = {read=FOnChanged, write=FOnChanged};
	__property int ReflectionSize = {read=FReflectionSize, write=SetReflectionSize, default=50};
	__property System::Byte ReflectionStart = {read=FReflectionStart, write=SetReflectionStart, default=100};
	__property System::Byte ReflectionEnd = {read=FReflectionEnd, write=SetReflectionEnd, default=0};
	__property int ReflectionSpacing = {read=FReflectionSpacing, write=SetReflectionSpacing, default=0};
	__property int AnimationSpan = {read=FAnimationSpan, write=SetAnimationSpan, default=400};
	__property Gdipfill::TGDIPFill* SelectionFill = {read=FSelectionFill, write=SetSelectionFill};
	__property int SelectionSize = {read=FSelectionSize, write=SetSelectionSize, default=20};
	__property int SelectionOffset = {read=FSelectionOffset, write=SetSelectionOffset, default=10};
	__property Gdipfill::TGDIPFill* CaptionFill = {read=FCaptionFill, write=SetCaptionFill};
	__property Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property Gdipfill::TGDIPFill* ProgressFill = {read=FProgressFill, write=SetProgressFill};
	__property Gdipfill::TGDIPFill* SeparatorFill = {read=FSeparatorFill, write=SetSeparatorFill};
	__property int SeparatorSize = {read=FSeparatorSize, write=SetSeparatorSize, default=10};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, default=0};
	__property bool PermanentCaption = {read=FPermanentCaption, write=SetPermanentCaption, default=0};
};


struct TAnimationPoint
{
	
public:
	Advgdip::TGPPointF pt;
	double factor;
};


typedef DynamicArray<TAdvSmoothDockItem*> TDockItemArray;

#pragma option push -b-
enum TAdvSmoothDockPosition { dpLeft, dpRight, dpTop, dpBottom };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothDockBeforeDragOver)(System::TObject* Sender, System::TObject* Source, TAdvSmoothDockItem* HoveredItem, bool &CreateNew);

typedef void __fastcall (__closure *TAdvSmoothDockDragOver)(System::TObject* Sender, System::TObject* Source, TAdvSmoothDockItem* DragItem, int X, int Y, Controls::TDragState State, bool &Accept);

typedef void __fastcall (__closure *TAdvSmoothDockDragDrop)(System::TObject* Sender, System::TObject* Source, TAdvSmoothDockItem* DragItem, int X, int Y);

typedef void __fastcall (__closure *TAdvSmoothDockItemHint)(System::TObject* Sender, int ItemIndex, System::UnicodeString &Hint);

typedef void __fastcall (__closure *TAdvSmoothDockItemClick)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothDockItemDblClick)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothDockItemSelected)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothDockItemHover)(System::TObject* Sender, int ItemIndex);

typedef void __fastcall (__closure *TAdvSmoothDockItemDragDelete)(System::TObject* Sender, int ItemIndex, bool &Allow);

typedef void __fastcall (__closure *TAdvSmoothDockDragInsert)(System::TObject* Sender, int PreviousItemIndex, int NextItemIndex, bool &AllowInsert);

typedef void __fastcall (__closure *TAdvSmoothDockItemStartDrag)(System::TObject* Sender, TAdvSmoothDockItem* DragItem, bool &Allow);

#pragma option push -b-
enum TAdvSmoothDockAlignDesktop { adBottom, adLeft, adRight, adTop };
#pragma option pop

class DELPHICLASS TAdvSmoothDockDropTarget;
class PASCALIMPLEMENTATION TAdvSmoothDockDropTarget : public Advsmoothdockdragdrop::TDockDropTarget
{
	typedef Advsmoothdockdragdrop::TDockDropTarget inherited;
	
private:
	TAdvSmoothDock* FDock;
	
public:
	__fastcall TAdvSmoothDockDropTarget(TAdvSmoothDock* ADock);
	virtual void __fastcall DropText(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropCol(const Types::TPoint &pt, int Col);
	virtual void __fastcall DropRTF(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DropFiles(const Types::TPoint &pt, Classes::TStrings* files);
	virtual void __fastcall DropURL(const Types::TPoint &pt, System::UnicodeString s);
	virtual void __fastcall DragMouseMove(const Types::TPoint &pt, bool &Allow, Advsmoothdockdragdrop::TDropFormats DropFormats);
	virtual void __fastcall DragMouseLeave(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TAdvSmoothDockDropTarget(void) { }
	
};


class DELPHICLASS TAdvSmoothDockArrowAppearance;
class PASCALIMPLEMENTATION TAdvSmoothDockArrowAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothDock* FOwner;
	System::Byte FOpacity;
	Graphics::TColor FBorderColor;
	Graphics::TColor FColor;
	bool FVisible;
	int FSize;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetVisibled(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TAdvSmoothDockArrowAppearance(TAdvSmoothDock* AOwner);
	__fastcall virtual ~TAdvSmoothDockArrowAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=200};
	__property int Size = {read=FSize, write=SetSize, default=35};
	__property bool Visible = {read=FVisible, write=SetVisibled, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


struct TCaptionSize
{
	
public:
	double w;
	double h;
};


struct TAdvSmoothDockBounds
{
	
public:
	int Start;
	int Stop;
};


class PASCALIMPLEMENTATION TAdvSmoothDock : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	typedef DynamicArray<TAnimationPoint> _TAdvSmoothDock__1;
	
	
private:
	Controls::TCursor FCur;
	int FTimeDownOnArrow;
	bool FAnimateMove;
	float FCurrentPos;
	float FPosTo;
	bool FArrowLeftHover;
	bool FArrowLeftDown;
	bool FArrowRightHover;
	bool FArrowRightDown;
	bool UpdateBounds;
	bool FMouseOnArrow;
	TAdvSmoothDockForm* frm;
	bool FFocused;
	int FSel;
	bool FDblClick;
	bool FOleDropTargetAssigned;
	TAdvSmoothDockDropTarget* FDockDropTarget;
	Classes::TMemoryStream* FSeparatorMemoryStream;
	Advgdip::TGPBitmap* FSeparatorImage;
	bool FConstructed;
	bool FMouseEntered;
	bool FStartPopupTimer;
	bool FDoPopup;
	int FPopupTime;
	bool FDesigntime;
	bool FMouseDown;
	bool FMouseCopy;
	bool FCreateNew;
	TAdvSmoothDockItem* FDragDropItem;
	TAdvSmoothDockItem* FHoveredDropItem;
	TAdvSmoothDockItem* FInsertDropItem;
	int FClickX;
	int FClickY;
	int FDragX;
	int FDragY;
	int FPrevX;
	int FPrevY;
	int FCurX;
	int FCurY;
	int FHintX;
	int FHintY;
	int FHoveredItemIndex;
	int FPopupClickIndex;
	int FUpdateCount;
	Extctrls::TTimer* FAnimate;
	_TAdvSmoothDock__1 FSin;
	Gdipfill::TGDIPFill* FFill;
	bool FTransparent;
	TAdvSmoothDockItems* FItems;
	TAdvSmoothDockItemAppearance* FItemAppearance;
	int FSelectedItemIndex;
	TAdvSmoothDockPosition FPosition;
	Gdipfill::TGDIPFill* FPlatformFill;
	int FPlatformSize;
	TAdvSmoothDockDragDrop FOnDragDrop;
	TAdvSmoothDockDragOver FOnDragOver;
	TAdvSmoothDockItemHint FOnItemHint;
	bool FPlatForm3D;
	bool FOleDragDrop;
	int FAnimationFactor;
	TAdvSmoothDockDragInsert FOnDragInsert;
	TAdvSmoothDockItemDblClick FOnItemDblClick;
	TAdvSmoothDockItemClick FOnItemClick;
	TAdvSmoothDockItemSelected FOnItemSelected;
	TAdvSmoothDockItemHover FOnItemHover;
	bool FFocus;
	Graphics::TColor FPlatForm3DColor;
	Graphics::TColor FPlatForm3DColorTo;
	System::Byte FPlatForm3DOpacity;
	System::Byte FPlatForm3DOpacityTo;
	bool FDockOnDeskTop;
	bool FDockVisible;
	TAdvSmoothDockArrowAppearance* FArrowAppearance;
	Classes::TNotifyEvent FOnScroll;
	TAdvSmoothDockItemStartDrag FOnItemStartDrag;
	TAdvSmoothDockItemDragDelete FOnItemDragDelete;
	bool FAutoSize;
	int FBackGroundSize;
	bool FBackGroundAutoSize;
	TAdvSmoothDockBeforeDragOver FOnBeforeDragOver;
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetTransparent(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMVisibleChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall SetItems(const TAdvSmoothDockItems* Value);
	void __fastcall SetItemAppearance(const TAdvSmoothDockItemAppearance* Value);
	void __fastcall SetSelectedItemIndex(const int Value);
	void __fastcall SetPosition(const TAdvSmoothDockPosition Value);
	void __fastcall SetPlatformFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetPlatformSize(const int Value);
	void __fastcall SetPlatForm3D(const bool Value);
	void __fastcall SetOleDragDrop(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetAnimationFactor(const int Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetPlatForm3DColor(const Graphics::TColor Value);
	void __fastcall SetPlatForm3DColorTo(const Graphics::TColor Value);
	void __fastcall SetPlatForm3DOpacity(const System::Byte Value);
	void __fastcall SetPlatForm3DOpacityTo(const System::Byte Value);
	void __fastcall SetDockOnDesktop(const bool Value);
	void __fastcall SetDockVisible(const bool Value);
	void __fastcall SetArrowAppearance(const TAdvSmoothDockArrowAppearance* Value);
	int __fastcall GetFirstIndex(void);
	int __fastcall GetVisibleItemCount(void);
	void __fastcall SetAS(const bool Value);
	void __fastcall SetBackGroundAutoSize(const bool Value);
	void __fastcall SetBackGroundSize(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall ItemAppearanceChanged(System::TObject* Sender);
	void __fastcall ArrowAppearanceChanged(System::TObject* Sender);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g, bool Control);
	void __fastcall DrawPlatForm(Advgdip::TGPGraphics* g);
	void __fastcall DrawItems(Advgdip::TGPGraphics* g);
	void __fastcall DrawCaption(Advgdip::TGPGraphics* g, int ItemIndex = 0xffffffff);
	void __fastcall DrawArrows(Advgdip::TGPGraphics* g);
	void __fastcall DrawIndicator(Advgdip::TGPGraphics* g, int ItemIndex);
	void __fastcall DoMouseEnter(Messages::TMessage &Msg);
	void __fastcall DoMouseLeave(Messages::TMessage &Msg);
	HIDESBASE void __fastcall DoMouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall DoMouseMove(Classes::TShiftState Shift, int X, int Y);
	HIDESBASE void __fastcall DoMouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall CalculateSin(void);
	void __fastcall Animate(System::TObject* Sender);
	void __fastcall DoDblClick(void);
	void __fastcall DoDrop(int X, int Y);
	void __fastcall DoDrag(int X, int Y, bool Copy);
	void __fastcall DoDragOver(System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall DoDragDrop(System::TObject* Source, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	void __fastcall GetAspectSize(int &w, int &h, double ow, double oh, double nw, double nh, bool Separator);
	double __fastcall FactorInSinus(int X, int Y, const Advgdip::TGPPointF &pt);
	Types::TRect __fastcall InsideRect(void);
	TAdvSmoothDockBounds __fastcall GetBounds(void);
	int __fastcall GetItemBounds(void);
	bool __fastcall IsItemBounds(int X, int Y);
	bool __fastcall IsMoving(int X, int Y);
	int __fastcall GetVersionNr(void);
	int __fastcall GetWidth(void);
	int __fastcall GetHeight(void);
	double __fastcall GetTotalSize(void);
	int __fastcall GetMinimumHeight(void);
	int __fastcall GetMinimumWidth(void);
	int __fastcall GetMaximumHeight(void);
	int __fastcall GetMaximumWidth(void);
	Advgdip::TGPRectF __fastcall GetItemsRectangle(void);
	Advgdip::TGPRectF __fastcall GetItemsMinimumRectangle(void);
	Advgdip::TGPRectF __fastcall GetArrowLeft(void);
	Advgdip::TGPRectF __fastcall GetArrowRight(void);
	bool __fastcall IsMouseOnArrow(int X, int Y);
	bool __fastcall PtInGPRect(const Advgdip::TGPRectF &r, const Types::TPoint &pt);
	Advgdip::TGPRectF __fastcall GetPlatFormRectangle(void);
	TCaptionSize __fastcall GetMaxSizeCaption(void);
	bool __fastcall IsJumping(void);
	void __fastcall DoArrowRightDown(void);
	void __fastcall DoArrowLeftDown(void);
	int __fastcall GetCountSelectable(void);
	int __fastcall MaxSel(void);
	int __fastcall MinSel(void);
	__property bool DockVisible = {read=FDockVisible, write=SetDockVisible, default=0};
	
public:
	__fastcall virtual TAdvSmoothDock(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothDock(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	virtual void __fastcall AlignDesktop(TAdvSmoothDockAlignDesktop Align);
	__property bool DockOnDeskTop = {read=FDockOnDeskTop, write=SetDockOnDesktop, default=0};
	DYNAMIC void __fastcall Resize(void);
	void __fastcall UpdateSize(void);
	void __fastcall AddImagesFromFolder(System::UnicodeString AFolder, bool SetImageCaption = false);
	void __fastcall AddFilesFromFolder(System::UnicodeString AFolder, bool SetImageCaption = false, bool SetFilePath = false, bool LoadIcon = false);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	int __fastcall XYToItem(int X, int Y, bool CountSeparator = false, bool DragDrop = false);
	void __fastcall ShowForm(void);
	__property int FirstVisibleIndex = {read=GetFirstIndex, nodefault};
	__property int VisibleItemCount = {read=GetVisibleItemCount, nodefault};
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	void __fastcall FormHookInit(void);
	void __fastcall FormHookDone(void);
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetAS, default=1};
	__property int AnimationFactor = {read=FAnimationFactor, write=SetAnimationFactor, default=2};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property bool BackGroundAutoSize = {read=FBackGroundAutoSize, write=SetBackGroundAutoSize, default=1};
	__property int BackGroundSize = {read=FBackGroundSize, write=SetBackGroundSize, default=200};
	__property Gdipfill::TGDIPFill* PlatformFill = {read=FPlatformFill, write=SetPlatformFill};
	__property int PlatformSize = {read=FPlatformSize, write=SetPlatformSize, default=60};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property TAdvSmoothDockItems* Items = {read=FItems, write=SetItems};
	__property TAdvSmoothDockItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
	__property int SelectedItemIndex = {read=FSelectedItemIndex, write=SetSelectedItemIndex, default=-1};
	__property TAdvSmoothDockPosition Position = {read=FPosition, write=SetPosition, default=3};
	__property bool PlatForm3D = {read=FPlatForm3D, write=SetPlatForm3D, default=1};
	__property Graphics::TColor PlatForm3DColor = {read=FPlatForm3DColor, write=SetPlatForm3DColor, default=16777215};
	__property Graphics::TColor PlatForm3DColorTo = {read=FPlatForm3DColorTo, write=SetPlatForm3DColorTo, default=16777215};
	__property System::Byte PlatForm3DOpacity = {read=FPlatForm3DOpacity, write=SetPlatForm3DOpacity, default=30};
	__property System::Byte PlatForm3DOpacityTo = {read=FPlatForm3DOpacityTo, write=SetPlatForm3DOpacityTo, default=100};
	__property TAdvSmoothDockArrowAppearance* ArrowAppearance = {read=FArrowAppearance, write=SetArrowAppearance};
	__property bool OleDragDrop = {read=FOleDragDrop, write=SetOleDragDrop, default=0};
	__property System::UnicodeString Version = {read=GetVersion};
	__property bool ShowFocus = {read=FFocus, write=SetShowFocus, default=1};
	__property TAdvSmoothDockBeforeDragOver OnBeforeDragOver = {read=FOnBeforeDragOver, write=FOnBeforeDragOver};
	__property TAdvSmoothDockDragOver OnDragOver = {read=FOnDragOver, write=FOnDragOver};
	__property TAdvSmoothDockDragDrop OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property TAdvSmoothDockItemHint OnItemHint = {read=FOnItemHint, write=FOnItemHint};
	__property TAdvSmoothDockItemClick OnItemClick = {read=FOnItemClick, write=FOnItemClick};
	__property TAdvSmoothDockItemDblClick OnItemDblClick = {read=FOnItemDblClick, write=FOnItemDblClick};
	__property TAdvSmoothDockItemHover OnItemHover = {read=FOnItemHover, write=FOnItemHover};
	__property TAdvSmoothDockDragInsert OnDragInsert = {read=FOnDragInsert, write=FOnDragInsert};
	__property TAdvSmoothDockItemSelected OnItemSelected = {read=FOnItemSelected, write=FOnItemSelected};
	__property TAdvSmoothDockItemStartDrag OnItemStartDrag = {read=FOnItemStartDrag, write=FOnItemStartDrag};
	__property TAdvSmoothDockItemDragDelete OnItemDragDelete = {read=FOnItemDragDelete, write=FOnItemDragDelete};
	__property Classes::TNotifyEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property Hint;
	__property OnDblClick;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property Visible = {default=1};
	__property TabStop = {default=1};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothDock(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;
static const ShortInt DRAGMARGIN = 0x5;
static const Word WM_USERACTIVATE = 0x464;

}	/* namespace Advsmoothdock */
using namespace Advsmoothdock;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothdockHPP
