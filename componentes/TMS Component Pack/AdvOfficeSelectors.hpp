// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advofficeselectors.pas' rev: 21.00

#ifndef AdvofficeselectorsHPP
#define AdvofficeselectorsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advofficeselectors
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvSelectorStyle { ssButton, ssCombo };
#pragma option pop

#pragma option push -b-
enum TGradientDirection { gdVertical, gdHorizontal };
#pragma option pop

#pragma option push -b-
enum TSelectorItemType { itAutoSizeButton, itFullWidthButton, itCaption };
#pragma option pop

#pragma option push -b-
enum TColorSelectionStyle { csDiscrete, csColorCube, csSpectrum };
#pragma option pop

#pragma option push -b-
enum TGripPosition { gpTop, gpBottom };
#pragma option pop

typedef ShortInt TNoOfButtons;

class DELPHICLASS TSelectorButtonSize;
class PASCALIMPLEMENTATION TSelectorButtonSize : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	int FHeight;
	int FWidth;
	void __fastcall Changed(void);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	
public:
	__fastcall TSelectorButtonSize(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSelectorButtonSize(void) { }
	
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
	Graphics::TColor FBorderColor;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDirection(const TGradientDirection Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	
public:
	__fastcall TGradientBackground(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property TGradientDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TGradientBackground(void) { }
	
};


class DELPHICLASS TGradientCaption;
class PASCALIMPLEMENTATION TGradientCaption : public TGradientBackground
{
	typedef TGradientBackground inherited;
	
private:
	Graphics::TColor FTextColor;
	Graphics::TColor FTextColorDown;
	Graphics::TColor FTextColorHot;
	Advglowbutton::TGlowButtonAppearance* FButtonAppearance;
	void __fastcall SetButtonAppearance(const Advglowbutton::TGlowButtonAppearance* Value);
	
public:
	__fastcall TGradientCaption(void);
	__fastcall virtual ~TGradientCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor TextColor = {read=FTextColor, write=FTextColor, nodefault};
	__property Graphics::TColor TextColorHot = {read=FTextColorHot, write=FTextColorHot, nodefault};
	__property Graphics::TColor TextColorDown = {read=FTextColorDown, write=FTextColorDown, nodefault};
	__property Advglowbutton::TGlowButtonAppearance* ButtonAppearance = {read=FButtonAppearance, write=SetButtonAppearance};
};


class DELPHICLASS TSimpleGradientCaption;
class PASCALIMPLEMENTATION TSimpleGradientCaption : public TGradientBackground
{
	typedef TGradientBackground inherited;
	
private:
	Graphics::TColor FTextColor;
	
public:
	__fastcall TSimpleGradientCaption(void);
	__fastcall virtual ~TSimpleGradientCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor TextColor = {read=FTextColor, write=FTextColor, nodefault};
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


class DELPHICLASS TVistaBackgroundHot;
class PASCALIMPLEMENTATION TVistaBackgroundHot : public TVistaBackground
{
	typedef TVistaBackground inherited;
	
private:
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorMirrorHot;
	Graphics::TColor FColorMirrorHotTo;
	Graphics::TColor FBorderColorHot;
	Advglowbutton::TGDIPGradient FGradientHot;
	Advglowbutton::TGDIPGradient FGradientMirrorHot;
	
public:
	__fastcall TVistaBackgroundHot(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=FBorderColorHot, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=FColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=FColorHotTo, nodefault};
	__property Graphics::TColor ColorMirrorHot = {read=FColorMirrorHot, write=FColorMirrorHot, nodefault};
	__property Graphics::TColor ColorMirrorHotTo = {read=FColorMirrorHotTo, write=FColorMirrorHotTo, nodefault};
	__property Advglowbutton::TGDIPGradient GradientHot = {read=FGradientHot, write=FGradientHot, nodefault};
	__property Advglowbutton::TGDIPGradient GradientMirrorHot = {read=FGradientMirrorHot, write=FGradientMirrorHot, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TVistaBackgroundHot(void) { }
	
};


class DELPHICLASS TSelectionAppearance;
class PASCALIMPLEMENTATION TSelectionAppearance : public Advglowbutton::TGlowButtonAppearance
{
	typedef Advglowbutton::TGlowButtonAppearance inherited;
	
private:
	Graphics::TColor FTextColor;
	Graphics::TColor FTextColorDisabled;
	Graphics::TColor FTextColorDown;
	Graphics::TColor FTextColorHot;
	Graphics::TColor FTextColorChecked;
	bool FRounded;
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetTextColorChecked(const Graphics::TColor Value);
	void __fastcall SetTextColorDisabled(const Graphics::TColor Value);
	void __fastcall SetTextColorDown(const Graphics::TColor Value);
	void __fastcall SetTextColorHot(const Graphics::TColor Value);
	void __fastcall SetRounded(const bool Value);
	
public:
	__fastcall TSelectionAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, nodefault};
	__property Graphics::TColor TextColorHot = {read=FTextColorHot, write=SetTextColorHot, nodefault};
	__property Graphics::TColor TextColorDown = {read=FTextColorDown, write=SetTextColorDown, nodefault};
	__property Graphics::TColor TextColorChecked = {read=FTextColorChecked, write=SetTextColorChecked, nodefault};
	__property Graphics::TColor TextColorDisabled = {read=FTextColorDisabled, write=SetTextColorDisabled, nodefault};
	__property bool Rounded = {read=FRounded, write=SetRounded, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSelectionAppearance(void) { }
	
};


class DELPHICLASS TAdvSelectorItem;
class PASCALIMPLEMENTATION TAdvSelectorItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Types::TRect FItemRect;
	System::UnicodeString FCaption;
	bool FEnable;
	int FImageIndex;
	System::UnicodeString FValue;
	System::UnicodeString FHint;
	Classes::TAlignment FCaptionAlignment;
	TSelectorItemType FItemType;
	Graphics::TColor FBackGroundColor;
	int FTag;
	void __fastcall SetEnable(const bool Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetValue(const System::UnicodeString Value);
	void __fastcall SetvCaptionAlignment(const Classes::TAlignment Value);
	void __fastcall SetItemType(const TSelectorItemType Value);
	void __fastcall SetBackGroundColor(const Graphics::TColor Value);
	void __fastcall SetTag(const int Value);
	
protected:
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	__property Types::TRect ItemRect = {read=FItemRect, write=FItemRect};
	HIDESBASE virtual void __fastcall Changed(void);
	
public:
	__fastcall virtual TAdvSelectorItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSelectorItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BackGroundColor = {read=FBackGroundColor, write=SetBackGroundColor, default=536870911};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetvCaptionAlignment, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property System::UnicodeString Value = {read=FValue, write=SetValue};
	__property bool Enable = {read=FEnable, write=SetEnable, nodefault};
	__property TSelectorItemType ItemType = {read=FItemType, write=SetItemType, default=0};
	__property int Tag = {read=FTag, write=SetTag, default=0};
};


class DELPHICLASS TAdvSelectorItems;
class PASCALIMPLEMENTATION TAdvSelectorItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSelectorItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FOwner;
	HIDESBASE TAdvSelectorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSelectorItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSelectorItems(Classes::TPersistent* AOwner);
	HIDESBASE TAdvSelectorItem* __fastcall Add(void);
	HIDESBASE TAdvSelectorItem* __fastcall Insert(int Index);
	__property TAdvSelectorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSelectorItems(void) { }
	
};


typedef void __fastcall (__closure *TChangeSelectionEvent)(int OldItemIndex, int NewItemIndex);

typedef void __fastcall (__closure *THotToolEvent)(System::TObject* Sender, int HotItemIndex);

class DELPHICLASS TAdvCustomSelectorPanel;
class DELPHICLASS TSelectorDropDownWindow;
class PASCALIMPLEMENTATION TAdvCustomSelectorPanel : public Extctrls::TCustomPanel
{
	typedef Extctrls::TCustomPanel inherited;
	
private:
	Classes::TComponent* FOwner;
	Graphics::TColor FColorTo;
	TGradientDirection FGradientDirection;
	Graphics::TColor FWindowBorderColor;
	Classes::TNotifyEvent FOnShouldHide;
	bool FAllowFloating;
	TVistaBackgroundHot* FDragGripAppearance;
	TGripPosition FGripPosition;
	bool FDragGripHot;
	bool FFloating;
	TGradientCaption* FCaptionAppearance;
	Classes::TNotifyEvent FOnFloating;
	bool FCloseBtnHot;
	bool FCloseBtnDown;
	Graphics::TColor FColorFloatingTo;
	Graphics::TColor FColorFloating;
	Classes::TNotifyEvent FOnCloseBtnClick;
	TSelectorDropDownWindow* FDropDownWindow;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetTGradientDirection(const TGradientDirection Value);
	void __fastcall SetWindowBorderColor(const Graphics::TColor Value);
	void __fastcall SetDragGripAppearance(const TVistaBackgroundHot* Value);
	void __fastcall SetCaptionAppearance(const TGradientCaption* Value);
	
protected:
	void __fastcall DrawCloseBtn(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ResetDown(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall Initialize(void);
	virtual int __fastcall GetVisibleHeight(void);
	virtual void __fastcall SetFloating(const bool Value);
	__property bool Floating = {read=FFloating, write=SetFloating, nodefault};
	Types::TRect __fastcall GetDragGripRect(void);
	Types::TRect __fastcall GetCaptionRect(void);
	Types::TRect __fastcall GetCloseBtnRect(void);
	void __fastcall InvalidateCloseBtn(void);
	void __fastcall InvalidateDragGrip(void);
	void __fastcall CloseBtnClick(void);
	__property TSelectorDropDownWindow* DropDownWindow = {read=FDropDownWindow, write=FDropDownWindow};
	__property Classes::TNotifyEvent OnShouldHide = {read=FOnShouldHide, write=FOnShouldHide};
	
public:
	__fastcall virtual TAdvCustomSelectorPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomSelectorPanel(void);
	
__published:
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor ColorFloating = {read=FColorFloating, write=FColorFloating, nodefault};
	__property Graphics::TColor ColorFloatingTo = {read=FColorFloatingTo, write=FColorFloatingTo, nodefault};
	__property Graphics::TColor WindowBorderColor = {read=FWindowBorderColor, write=SetWindowBorderColor, default=8421504};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetTGradientDirection, nodefault};
	__property bool AllowFloating = {read=FAllowFloating, write=FAllowFloating, nodefault};
	__property TGripPosition GripPosition = {read=FGripPosition, write=FGripPosition, nodefault};
	__property TVistaBackgroundHot* DragGripAppearance = {read=FDragGripAppearance, write=SetDragGripAppearance};
	__property TGradientCaption* CaptionAppearance = {read=FCaptionAppearance, write=SetCaptionAppearance};
	__property Classes::TNotifyEvent OnFloating = {read=FOnFloating, write=FOnFloating};
	__property Classes::TNotifyEvent OnCloseBtnClick = {read=FOnCloseBtnClick, write=FOnCloseBtnClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomSelectorPanel(HWND ParentWindow) : Extctrls::TCustomPanel(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TItemDrawEvent)(System::TObject* Sender, int Index, const Types::TRect &R);

typedef void __fastcall (__closure *TSelectEvent)(System::TObject* Sender, int Index, TAdvSelectorItem* Item);

typedef void __fastcall (__closure *TColorSelectEvent)(System::TObject* Sender, Graphics::TColor AColor);

typedef void __fastcall (__closure *TPenStyleSelectEvent)(System::TObject* Sender, Graphics::TPenStyle AStyle);

typedef void __fastcall (__closure *TBrushStyleSelectEvent)(System::TObject* Sender, Graphics::TBrushStyle AStyle);

typedef void __fastcall (__closure *TCharSelectEvent)(System::TObject* Sender, System::WideChar AChar);

typedef void __fastcall (__closure *TTableSizeSelectEvent)(System::TObject* Sender, int Columns, int Rows);

class DELPHICLASS TAdvSelectorPanel;
class PASCALIMPLEMENTATION TAdvSelectorPanel : public TAdvCustomSelectorPanel
{
	typedef TAdvCustomSelectorPanel inherited;
	
private:
	int FItemIndex;
	TAdvSelectorItems* FItems;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderDownColor;
	Graphics::TColor FColorHot;
	Graphics::TColor FBorderHotColor;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorDown;
	Imglist::TCustomImageList* FImages;
	int FHotItemIndex;
	int FDownItemIndex;
	int FButtonHeight;
	int FTopOffSet;
	int FLeftOffSet;
	TNoOfButtons FButtonsPerRow;
	TChangeSelectionEvent FOnChangeSelection;
	int FButtonMargin;
	bool FMouseDown;
	Classes::TNotifyEvent FOnSelect;
	Graphics::TColor FBorderSelectedColor;
	Graphics::TColor FColorSelected;
	Graphics::TColor FColorSelectedTo;
	THotToolEvent FOnHotTool;
	int FMaxCaptionLength;
	TItemDrawEvent FOnDrawItem;
	int FMinButtonWidth;
	int FMinButtonHeight;
	bool FNoPrefix;
	bool FTwoColorImages;
	TSelectionAppearance* FSelectionAppearance;
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetItems(const TAdvSelectorItems* Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetButtonsPerRow(const TNoOfButtons Value);
	void __fastcall SetButtonMargin(const int Value);
	void __fastcall SetMinButtonHeight(const int Value);
	void __fastcall SetMinButtonWidth(const int Value);
	void __fastcall SetTwoColorImages(const bool Value);
	void __fastcall SetSelectionAppearance(const TSelectionAppearance* Value);
	
protected:
	void __fastcall DrawItem(int Index, bool RefreshItem = false);
	virtual void __fastcall Paint(void);
	virtual void __fastcall ResetDown(void);
	void __fastcall SetItemsPosition(void);
	int __fastcall GetMaxWidth(void);
	int __fastcall TotalAutoSizeButtons(void);
	void __fastcall SetPanelHeight(void);
	void __fastcall AutoSizeBtnSize(int &W, int &H);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall SetFloating(const bool Value);
	__property int MinButtonWidth = {read=FMinButtonWidth, write=SetMinButtonWidth, default=16};
	__property int MinButtonHeight = {read=FMinButtonHeight, write=SetMinButtonHeight, default=16};
	__property bool NoPrefix = {read=FNoPrefix, write=FNoPrefix, nodefault};
	__property bool TwoColorImages = {read=FTwoColorImages, write=SetTwoColorImages, nodefault};
	
public:
	__fastcall virtual TAdvSelectorPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSelectorPanel(void);
	int __fastcall ItemAtPos(int X, int Y);
	__property TAdvSelectorItems* Items = {read=FItems, write=SetItems};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, nodefault};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BorderDownColor = {read=FBorderDownColor, write=FBorderDownColor, default=536870911};
	__property Graphics::TColor BorderHotColor = {read=FBorderHotColor, write=FBorderHotColor, default=536870911};
	__property Graphics::TColor BorderSelectedColor = {read=FBorderSelectedColor, write=FBorderSelectedColor, default=0};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=FColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=FColorDownTo, default=536870911};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=FColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=FColorHotTo, default=536870911};
	__property Graphics::TColor ColorSelected = {read=FColorSelected, write=FColorSelected, nodefault};
	__property Graphics::TColor ColorSelectedTo = {read=FColorSelectedTo, write=FColorSelectedTo, nodefault};
	__property TSelectionAppearance* SelectionAppearance = {read=FSelectionAppearance, write=SetSelectionAppearance};
	__property TNoOfButtons ButtonsPerRow = {read=FButtonsPerRow, write=SetButtonsPerRow, default=1};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property int ButtonMargin = {read=FButtonMargin, write=SetButtonMargin, default=3};
	__property TChangeSelectionEvent OnChangeSelection = {read=FOnChangeSelection, write=FOnChangeSelection};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property THotToolEvent OnHotTool = {read=FOnHotTool, write=FOnHotTool};
	__property TItemDrawEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSelectorPanel(HWND ParentWindow) : TAdvCustomSelectorPanel(ParentWindow) { }
	
};


struct TColorCubeCell
{
	
public:
	Types::TPoint CenterPos;
	Graphics::TColor Color;
};


class DELPHICLASS TAdvColorCubePanel;
class PASCALIMPLEMENTATION TAdvColorCubePanel : public TAdvCustomSelectorPanel
{
	typedef TAdvCustomSelectorPanel inherited;
	
private:
	StaticArray<TColorCubeCell, 127> FCubeCells;
	Types::TPoint FCubeSize;
	Graphics::TColor FSelectedColor;
	int FSelectedIndex;
	int FHotIndex;
	Classes::TNotifyEvent FOnSelect;
	bool FShowRGBHint;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall DrawColorCube(int Index);
	void __fastcall DrawAllColorCube(void);
	void __fastcall DrawSelectedBorder(void);
	void __fastcall DrawHotBorder(void);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	void __fastcall SetSelectedIndexAndColor(Graphics::TColor clr, int index = 0xffffffff);
	void __fastcall SetShowRGBHint(const bool Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	bool __fastcall PtInCell(int Index, const Types::TPoint &P);
	int __fastcall IndexOfCellAt(int X, int Y);
	void __fastcall DrawHexagon(Graphics::TCanvas* aCanvas, const Types::TPoint &P, int X, int Y);
	HIDESBASE void __fastcall Initialize(void);
	void __fastcall SetItemsPosition(void);
	void __fastcall SetPanelSize(void);
	
public:
	__fastcall virtual TAdvColorCubePanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvColorCubePanel(void);
	
__published:
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, nodefault};
	__property bool ShowRGBHint = {read=FShowRGBHint, write=SetShowRGBHint, nodefault};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvColorCubePanel(HWND ParentWindow) : TAdvCustomSelectorPanel(ParentWindow) { }
	
};


class DELPHICLASS TAdvColorSpectrumPanel;
class PASCALIMPLEMENTATION TAdvColorSpectrumPanel : public TAdvCustomSelectorPanel
{
	typedef TAdvCustomSelectorPanel inherited;
	
private:
	Extctrls::TImage* FSpectrumImage;
	Graphics::TColor FHotColor;
	Graphics::TColor FSelectedColor;
	Types::TRect FHotRect;
	Types::TRect FSelectedRect;
	Classes::TNotifyEvent FOnSelect;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SpectrumImageMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall SpectrumImageMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall SpectrumImageMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall DrawHotRect(void);
	void __fastcall DrawSelectedRect(void);
	void __fastcall DrawFocusPoint(void);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetItemsPosition(void);
	void __fastcall SetPanelSize(void);
	
public:
	__fastcall virtual TAdvColorSpectrumPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvColorSpectrumPanel(void);
	
__published:
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, nodefault};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvColorSpectrumPanel(HWND ParentWindow) : TAdvCustomSelectorPanel(ParentWindow) { }
	
};


class DELPHICLASS TAdvTableSelectorPanel;
class PASCALIMPLEMENTATION TAdvTableSelectorPanel : public TAdvCustomSelectorPanel
{
	typedef TAdvCustomSelectorPanel inherited;
	
private:
	Classes::TNotifyEvent FOnSelect;
	int FSelectedCols;
	int FSelectedRows;
	int FColCount;
	int FRowCount;
	int FCellSize;
	int FLeftMargin;
	int FTopMargin;
	int FCellSpace;
	int FLabelHeight;
	Graphics::TColor FSelectionColor;
	System::UnicodeString FTextTable;
	System::UnicodeString FTextCancel;
	void __fastcall SetColCount(const int Value);
	void __fastcall SetRowCount(const int Value);
	void __fastcall SetSelectedCols(const int Value);
	void __fastcall SetSelectedRows(const int Value);
	void __fastcall SetCellSize(const int Value);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall DrawAllCells(void);
	void __fastcall DrawLabel(void);
	void __fastcall InvalidateSelection(int OldSelectedCols, int OldSelectedRows);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetItemsPosition(void);
	void __fastcall SetPanelSize(void);
	
public:
	__fastcall virtual TAdvTableSelectorPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvTableSelectorPanel(void);
	
__published:
	__property int ColCount = {read=FColCount, write=SetColCount, default=5};
	__property int RowCount = {read=FRowCount, write=SetRowCount, default=4};
	__property int SelectedCols = {read=FSelectedCols, write=SetSelectedCols, default=0};
	__property int SelectedRows = {read=FSelectedRows, write=SetSelectedRows, default=0};
	__property int CellSize = {read=FCellSize, write=SetCellSize, default=16};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=FSelectionColor, default=8388608};
	__property System::UnicodeString TextTable = {read=FTextTable, write=FTextTable};
	__property System::UnicodeString TextCancel = {read=FTextCancel, write=FTextCancel};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvTableSelectorPanel(HWND ParentWindow) : TAdvCustomSelectorPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TSelectorDropDownWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	TAdvCustomSelectorPanel* FSelectorPanel;
	bool FHideOnDeActivate;
	bool FShowAbove;
	Classes::TComponent* FOwner;
	bool FShowFullBorder;
	Extctrls::TTimer* FHideTimer;
	bool FShowLeft;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Messages::TWMWindowPosMsg &Message);
	void __fastcall HideTimerOnTime(System::TObject* Sender);
	void __fastcall SetSelectorPanel(const TAdvCustomSelectorPanel* Value);
	
protected:
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	__property bool ShowAbove = {read=FShowAbove, write=FShowAbove, nodefault};
	__property bool ShowLeft = {read=FShowLeft, write=FShowLeft, default=0};
	__property bool ShowFullBorder = {read=FShowFullBorder, write=FShowFullBorder, nodefault};
	
public:
	__fastcall virtual TSelectorDropDownWindow(Classes::TComponent* AOwner);
	__fastcall virtual TSelectorDropDownWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TSelectorDropDownWindow(void);
	void __fastcall SetWindowSize(void);
	
__published:
	__property TAdvCustomSelectorPanel* SelectorPanel = {read=FSelectorPanel, write=SetSelectorPanel};
public:
	/* TWinControl.CreateParented */ inline __fastcall TSelectorDropDownWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TDrawToolEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int ItemIndex, const Types::TRect &R);

class DELPHICLASS TAdvCustomOfficeSelector;
class PASCALIMPLEMENTATION TAdvCustomOfficeSelector : public Advglowbutton::TAdvCustomGlowButton
{
	typedef Advglowbutton::TAdvCustomGlowButton inherited;
	
private:
	TSelectorDropDownWindow* FDropDownWindow;
	TAdvSelectorPanel* FSelectorPanel;
	bool FMouseInControl;
	bool FMouseDown;
	int FDropDownBtnWidth;
	bool FFlat;
	TAdvSelectorStyle FStyle;
	Imglist::TCustomImageList* FToolImages;
	Classes::TNotifyEvent FOnDropDown;
	Graphics::TColor FColorDropDownTo;
	Graphics::TColor FColorDropDown;
	Graphics::TColor FBorderDropDownColor;
	int FDropDownCount;
	TGradientDirection FGradientDirection;
	int FSelectedIndex;
	TAdvSelectorItems* FTools;
	TNoOfButtons FButtonsPerRow;
	THotToolEvent FOnHotTool;
	Classes::TNotifyEvent FOnClick;
	TSelectEvent FOnSelect;
	TDrawToolEvent FOnDrawTool;
	int FDupSelectedIndex;
	bool FTwoColorImages;
	Graphics::TColor FBackGroundImageColor;
	Graphics::TColor FForeGroundImageColor;
	Graphics::TColor FOldForeGroundImgColor;
	Graphics::TColor FOldBkGroundImgColor;
	bool FStretchImageDraw;
	TSelectionAppearance* FSelectionAppearance;
	bool FAllowFloating;
	TVistaBackgroundHot* FDragGripAppearance;
	bool FCloseOnSelect;
	TGripPosition FGripPosition;
	TGradientCaption* FCaptionAppearance;
	Graphics::TColor FColorDropDownFloatingTo;
	Graphics::TColor FColorDropDownFloating;
	Classes::TNotifyEvent FOnDropDownFloat;
	Classes::TNotifyEvent FOnDropDownClose;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall OnDropDownWindowHide(System::TObject* Sender);
	void __fastcall OnDropDownPanelShouldHide(System::TObject* Sender);
	void __fastcall OnDropDownPanelSelect(System::TObject* Sender);
	void __fastcall OnDropDownPanelHotTool(System::TObject* Sender, int HotItemIndex);
	void __fastcall OnDropDownPanelDrawTool(System::TObject* Sender, int ItemIndex, const Types::TRect &R);
	void __fastcall OnDropDownPanelFloating(System::TObject* Sender);
	void __fastcall OnDropDownPanelClose(System::TObject* Sender);
	void __fastcall OnSelectionAppearanceChanged(System::TObject* Sender);
	HIDESBASE void __fastcall PopupBtnDown(void);
	void __fastcall ButtonDown(void);
	HIDESBASE void __fastcall DoDropDown(void);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetToolImages(const Imglist::TCustomImageList* Value);
	HIDESBASE void __fastcall SetStyle(const TAdvSelectorStyle Value);
	void __fastcall SetColorDropDown(const Graphics::TColor Value);
	void __fastcall SetColorDropDownTo(const Graphics::TColor Value);
	void __fastcall SetDropDownCount(const int Value);
	void __fastcall SetTGradientDirection(const TGradientDirection Value);
	void __fastcall SetSelectedIndex(const int Value);
	void __fastcall SetTools(const TAdvSelectorItems* Value);
	int __fastcall GetSelectedIndex(void);
	void __fastcall SetButtonsPerRow(const TNoOfButtons Value);
	HIDESBASE System::UnicodeString __fastcall GetVersion(void);
	HIDESBASE void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetTwoColorImages(const bool Value);
	void __fastcall SetForeGroundImageColor(const Graphics::TColor Value);
	void __fastcall SetStretchImageDraw(const bool Value);
	void __fastcall SetSelectionAppearance(const TSelectionAppearance* Value);
	void __fastcall SetDragGripAppearance(const TVistaBackgroundHot* Value);
	void __fastcall SetCaptionAppearance(const TGradientCaption* Value);
	
protected:
	virtual void __fastcall OnToolSelect(void);
	virtual void __fastcall GetToolImage(Graphics::TBitmap* bmp);
	void __fastcall CopyPicture(Gdipicture::TGDIPPicture* Pic, Graphics::TBitmap* bmp);
	int __fastcall DrawGlyph(Graphics::TBitmap* aGlyph, const Types::TRect &aRect);
	virtual void __fastcall DrawGlyphAndCaption(Gdipicture::TGDIPPicture* Pic, const Types::TRect &R);
	void __fastcall DrawComboButton(void);
	Types::TRect __fastcall GetBtnRect(void);
	void __fastcall SetSelectorPanelItems(void);
	virtual void __fastcall SetSelectorPanel(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall DoSelect(int Index, TAdvSelectorItem* Item);
	virtual void __fastcall DropDownWindowClose(System::TObject* Sender, Forms::TCloseAction &Action);
	virtual void __fastcall Paint(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall ThemeAdapt(void);
	virtual int __fastcall GetVersionNr(void);
	void __fastcall ChangeImagesColor(Graphics::TColor ForeGColor, Graphics::TColor BkGColor);
	__property bool TwoColorImages = {read=FTwoColorImages, write=SetTwoColorImages, nodefault};
	__property Graphics::TColor OldForeGroundImgColor = {read=FOldForeGroundImgColor, nodefault};
	__property Graphics::TColor OldBkGroundImgColor = {read=FOldBkGroundImgColor, nodefault};
	__property Graphics::TColor ForeGroundImageColor = {read=FForeGroundImageColor, write=SetForeGroundImageColor, nodefault};
	__property Graphics::TColor BackGroundImageColor = {read=FBackGroundImageColor, write=FBackGroundImageColor, nodefault};
	__property bool StretchImageDraw = {read=FStretchImageDraw, write=SetStretchImageDraw, default=1};
	__property TNoOfButtons ButtonsPerRow = {read=FButtonsPerRow, write=SetButtonsPerRow, default=1};
	__property Graphics::TColor BorderDropDownColor = {read=FBorderDropDownColor, write=FBorderDropDownColor, default=8421504};
	__property Graphics::TColor ColorDropDown = {read=FColorDropDown, write=SetColorDropDown, nodefault};
	__property Graphics::TColor ColorDropDownTo = {read=FColorDropDownTo, write=SetColorDropDownTo, default=536870911};
	__property Graphics::TColor ColorDropDownFloating = {read=FColorDropDownFloating, write=FColorDropDownFloating, nodefault};
	__property Graphics::TColor ColorDropDownFloatingTo = {read=FColorDropDownFloatingTo, write=FColorDropDownFloatingTo, default=536870911};
	__property TSelectionAppearance* SelectionAppearance = {read=FSelectionAppearance, write=SetSelectionAppearance};
	__property TVistaBackgroundHot* DragGripAppearance = {read=FDragGripAppearance, write=SetDragGripAppearance};
	__property TGradientCaption* CaptionAppearance = {read=FCaptionAppearance, write=SetCaptionAppearance};
	__property int DropDownCount = {read=FDropDownCount, write=SetDropDownCount, nodefault};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetTGradientDirection, nodefault};
	__property Imglist::TCustomImageList* ToolImages = {read=FToolImages, write=SetToolImages};
	__property TAdvSelectorStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property TAdvSelectorItems* Tools = {read=FTools, write=SetTools};
	__property bool AllowFloating = {read=FAllowFloating, write=FAllowFloating, nodefault};
	__property bool CloseOnSelect = {read=FCloseOnSelect, write=FCloseOnSelect, nodefault};
	__property TGripPosition DragGripPosition = {read=FGripPosition, write=FGripPosition, nodefault};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Classes::TNotifyEvent OnDropDownFloat = {read=FOnDropDownFloat, write=FOnDropDownFloat};
	__property Classes::TNotifyEvent OnDropDownClose = {read=FOnDropDownClose, write=FOnDropDownClose};
	__property TSelectEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property THotToolEvent OnHotTool = {read=FOnHotTool, write=FOnHotTool};
	__property TDrawToolEvent OnDrawTool = {read=FOnDrawTool, write=FOnDrawTool};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	
public:
	__fastcall virtual TAdvCustomOfficeSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomOfficeSelector(void);
	DYNAMIC void __fastcall Click(void);
	void __fastcall ShowDropDown(void);
	void __fastcall HideDropDown(void);
	HIDESBASE void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__property int SelectedIndex = {read=GetSelectedIndex, write=SetSelectedIndex, nodefault};
	
__published:
	__property Action;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property ShowCaption = {default=0};
	__property DropDownSplit = {default=1};
	__property DropDownPosition = {default=0};
	__property Layout = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomOfficeSelector(HWND ParentWindow) : Advglowbutton::TAdvCustomGlowButton(ParentWindow) { }
	
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


class DELPHICLASS TAdvOfficeToolSelector;
class PASCALIMPLEMENTATION TAdvOfficeToolSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	int FToolWidth;
	int FToolHeight;
	
protected:
	virtual void __fastcall SetSelectorPanel(void);
	virtual void __fastcall GetToolImage(Graphics::TBitmap* bmp);
	
__published:
	__property AllowFloating;
	__property Appearance;
	__property BorderDropDownColor = {default=8421504};
	__property ButtonsPerRow = {default=1};
	__property Caption;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property Enabled = {default=1};
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property ToolImages;
	__property ShowHint;
	__property SelectedIndex;
	__property SelectionAppearance;
	__property Tools;
	__property int OwnerDrawToolWidth = {read=FToolWidth, write=FToolWidth, default=0};
	__property int OwnerDrawToolHeight = {read=FToolHeight, write=FToolHeight, default=0};
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property OnHotTool;
	__property OnDrawTool;
public:
	/* TAdvCustomOfficeSelector.Create */ inline __fastcall virtual TAdvOfficeToolSelector(Classes::TComponent* AOwner) : TAdvCustomOfficeSelector(AOwner) { }
	/* TAdvCustomOfficeSelector.Destroy */ inline __fastcall virtual ~TAdvOfficeToolSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeToolSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


#pragma option push -b-
enum TSelectionType { stOffice, stBorland };
#pragma option pop

class DELPHICLASS TAdvOfficePenStyleSelector;
class PASCALIMPLEMENTATION TAdvOfficePenStyleSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	TSelectionType FSelectionType;
	TPenStyleSelectEvent FOnSelectPenStyle;
	void __fastcall Initialize(void);
	Graphics::TPenStyle __fastcall GetSelectedPenStyle(void);
	void __fastcall SetSelectedPenStyle(const Graphics::TPenStyle Value);
	void __fastcall SetSelectionType(const TSelectionType Value);
	Graphics::TColor __fastcall GetPenColor(void);
	void __fastcall SetPenColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetSelectorPanel(void);
	virtual void __fastcall DoSelect(int Index, TAdvSelectorItem* Item);
	Graphics::TPenStyle __fastcall GetPenStyleAtIndex(int Index);
	int __fastcall GetIndexOfStyle(Graphics::TPenStyle APenStyle);
	
public:
	__fastcall virtual TAdvOfficePenStyleSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficePenStyleSelector(void);
	__property Graphics::TPenStyle SelectedPenStyle = {read=GetSelectedPenStyle, write=SetSelectedPenStyle, nodefault};
	
__published:
	__property AllowFloating;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property Appearance;
	__property BorderDropDownColor = {default=8421504};
	__property Caption;
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property Enabled = {default=1};
	__property Graphics::TColor PenColor = {read=GetPenColor, write=SetPenColor, nodefault};
	__property SelectedIndex;
	__property TSelectionType SelectionType = {read=FSelectionType, write=SetSelectionType, default=0};
	__property ShowHint;
	__property SelectionAppearance;
	__property Tools;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property TPenStyleSelectEvent OnSelectPenStyle = {read=FOnSelectPenStyle, write=FOnSelectPenStyle};
	__property OnHotTool;
	__property OnDrawTool;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficePenStyleSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficePenWidthSelector;
class PASCALIMPLEMENTATION TAdvOfficePenWidthSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	void __fastcall Initialize(void);
	
protected:
	virtual void __fastcall SetSelectorPanel(void);
	virtual int __fastcall GetSelectedPenWidth(void);
	virtual void __fastcall SetSelectedPenWidth(const int Value);
	
public:
	__fastcall virtual TAdvOfficePenWidthSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficePenWidthSelector(void);
	__property int SelectedPenWidth = {read=GetSelectedPenWidth, write=SetSelectedPenWidth, nodefault};
	
__published:
	__property AllowFloating;
	__property Appearance;
	__property BorderDropDownColor = {default=8421504};
	__property Caption;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property Enabled = {default=1};
	__property ShowHint;
	__property SelectedIndex;
	__property SelectionAppearance;
	__property Tools;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property OnHotTool;
	__property OnDrawTool;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficePenWidthSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeBrushStyleSelector;
class PASCALIMPLEMENTATION TAdvOfficeBrushStyleSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	TSelectionType FSelectionType;
	TBrushStyleSelectEvent FOnSelectBrushStyle;
	void __fastcall Initialize(void);
	Graphics::TBrushStyle __fastcall GetSelectedBrushStyle(void);
	void __fastcall SetSelectedBrushStyle(const Graphics::TBrushStyle Value);
	Graphics::TColor __fastcall GetBrushColor(void);
	void __fastcall SetBrushColor(const Graphics::TColor Value);
	void __fastcall SetSelectionType(const TSelectionType Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetSelectorPanel(void);
	virtual void __fastcall DoSelect(int Index, TAdvSelectorItem* Item);
	Graphics::TBrushStyle __fastcall GetBrushStyleAtIndex(int Index);
	int __fastcall GetIndexOfBrushStyle(Graphics::TBrushStyle ABrushStyle);
	
public:
	__fastcall virtual TAdvOfficeBrushStyleSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeBrushStyleSelector(void);
	__property Graphics::TBrushStyle SelectedBrushStyle = {read=GetSelectedBrushStyle, write=SetSelectedBrushStyle, nodefault};
	
__published:
	__property AllowFloating;
	__property Appearance;
	__property BorderDropDownColor = {default=8421504};
	__property Graphics::TColor BrushColor = {read=GetBrushColor, write=SetBrushColor, nodefault};
	__property Caption;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property Enabled = {default=1};
	__property TSelectionType SelectionType = {read=FSelectionType, write=SetSelectionType, default=0};
	__property SelectedIndex;
	__property ShowHint;
	__property SelectionAppearance;
	__property Tools;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property TBrushStyleSelectEvent OnSelectBrushStyle = {read=FOnSelectBrushStyle, write=FOnSelectBrushStyle};
	__property OnHotTool;
	__property OnDrawTool;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeBrushStyleSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeShadowSelector;
class PASCALIMPLEMENTATION TAdvOfficeShadowSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	void __fastcall Initialize(void);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetSelectorPanel(void);
	
public:
	__fastcall virtual TAdvOfficeShadowSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeShadowSelector(void);
	
__published:
	__property AllowFloating;
	__property Appearance;
	__property BorderDropDownColor = {default=8421504};
	__property Caption;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property Enabled = {default=1};
	__property ShowHint;
	__property SelectedIndex;
	__property SelectionAppearance;
	__property Tools;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property OnHotTool;
	__property OnDrawTool;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeShadowSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeTableBorderSelector;
class PASCALIMPLEMENTATION TAdvOfficeTableBorderSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	void __fastcall Initialize(void);
	
protected:
	virtual void __fastcall SetSelectorPanel(void);
	
public:
	__fastcall virtual TAdvOfficeTableBorderSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeTableBorderSelector(void);
	
__published:
	__property AllowFloating;
	__property Appearance;
	__property BorderDropDownColor = {default=8421504};
	__property Caption;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property Enabled = {default=1};
	__property ShowHint;
	__property SelectedIndex;
	__property SelectionAppearance;
	__property Tools;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property OnHotTool;
	__property OnDrawTool;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeTableBorderSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeGradientDirectionSelector;
class PASCALIMPLEMENTATION TAdvOfficeGradientDirectionSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	Graphics::TColor FStartColor;
	Graphics::TColor FEndColor;
	bool FShowSelectedGradient;
	void __fastcall SetEndColor(const Graphics::TColor Value);
	void __fastcall SetStartColor(const Graphics::TColor Value);
	void __fastcall SelectorPanelOnDrawItem(System::TObject* Sender, int Index, const Types::TRect &R);
	void __fastcall Initialize(void);
	void __fastcall SetShowSelectedGradient(const bool Value);
	
protected:
	virtual void __fastcall SetSelectorPanel(void);
	virtual void __fastcall GetToolImage(Graphics::TBitmap* bmp);
	virtual void __fastcall DrawGlyphAndCaption(Gdipicture::TGDIPPicture* Pic, const Types::TRect &R);
	
public:
	__fastcall virtual TAdvOfficeGradientDirectionSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeGradientDirectionSelector(void);
	
__published:
	__property AllowFloating;
	__property Appearance;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property Graphics::TColor StartColor = {read=FStartColor, write=SetStartColor, nodefault};
	__property Graphics::TColor EndColor = {read=FEndColor, write=SetEndColor, nodefault};
	__property BorderDropDownColor = {default=8421504};
	__property Caption;
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property Enabled = {default=1};
	__property SelectionAppearance;
	__property SelectedIndex;
	__property bool ShowSelectedGradient = {read=FShowSelectedGradient, write=SetShowSelectedGradient, default=1};
	__property Tools;
	__property ShowHint;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property OnHotTool;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeGradientDirectionSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvCustomOfficeColorSelector;
class PASCALIMPLEMENTATION TAdvCustomOfficeColorSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	TAdvColorCubePanel* FColorCubePanel;
	TAdvColorSpectrumPanel* FSpectrumPanel;
	TColorSelectionStyle FColorSelectionStyle;
	bool FShowSelectedColor;
	Graphics::TColor FSelectedColor;
	TColorSelectEvent FOnSelectColor;
	bool FShowRGBHint;
	void __fastcall SetColorSelectionStyle(const TColorSelectionStyle Value);
	void __fastcall SelectorPanelOnDrawItem(System::TObject* Sender, int Index, const Types::TRect &R);
	void __fastcall SetShowSelectedColor(const bool Value);
	void __fastcall OnColorCubeFloating(System::TObject* Sender);
	void __fastcall OnColorSpectrumFloating(System::TObject* Sender);
	void __fastcall OnColorSpectrumShouldHide(System::TObject* Sender);
	void __fastcall OnColorCubeShouldHide(System::TObject* Sender);
	void __fastcall CubePanelOnSelect(System::TObject* Sender);
	void __fastcall SpectrumPanelOnSelect(System::TObject* Sender);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetSelectedColor(void);
	
protected:
	virtual void __fastcall Initialize(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall OnToolSelect(void);
	virtual void __fastcall SetSelectorPanel(void);
	virtual void __fastcall DropDownWindowClose(System::TObject* Sender, Forms::TCloseAction &Action);
	virtual void __fastcall GetToolImage(Graphics::TBitmap* bmp);
	virtual void __fastcall DrawGlyphAndCaption(Gdipicture::TGDIPPicture* Pic, const Types::TRect &R);
	virtual void __fastcall DoSelect(int Index, TAdvSelectorItem* Item);
	
public:
	__fastcall virtual TAdvCustomOfficeColorSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomOfficeColorSelector(void);
	__property ButtonsPerRow = {default=1};
	__property TColorSelectionStyle SelectionStyle = {read=FColorSelectionStyle, write=SetColorSelectionStyle, default=0};
	__property bool ShowSelectedColor = {read=FShowSelectedColor, write=SetShowSelectedColor, default=1};
	__property Graphics::TColor SelectedColor = {read=GetSelectedColor, write=SetSelectedColor, nodefault};
	__property bool ShowRGBHint = {read=FShowRGBHint, write=FShowRGBHint, nodefault};
	__property TColorSelectEvent OnSelectColor = {read=FOnSelectColor, write=FOnSelectColor};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomOfficeColorSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeColorSelector;
class PASCALIMPLEMENTATION TAdvOfficeColorSelector : public TAdvCustomOfficeColorSelector
{
	typedef TAdvCustomOfficeColorSelector inherited;
	
protected:
	virtual void __fastcall Initialize(void);
	
__published:
	__property AllowFloating;
	__property CloseOnSelect;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property DragGripPosition;
	__property DropDownButton = {default=0};
	__property Enabled = {default=1};
	__property Appearance;
	__property SelectionStyle = {default=0};
	__property ShowSelectedColor = {default=1};
	__property SelectedColor;
	__property ShowRGBHint;
	__property BorderDropDownColor = {default=8421504};
	__property Caption;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property ShowHint;
	__property SelectionAppearance;
	__property Tools;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property OnSelectColor;
public:
	/* TAdvCustomOfficeColorSelector.Create */ inline __fastcall virtual TAdvOfficeColorSelector(Classes::TComponent* AOwner) : TAdvCustomOfficeColorSelector(AOwner) { }
	/* TAdvCustomOfficeColorSelector.Destroy */ inline __fastcall virtual ~TAdvOfficeColorSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeColorSelector(HWND ParentWindow) : TAdvCustomOfficeColorSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeTextColorSelector;
class PASCALIMPLEMENTATION TAdvOfficeTextColorSelector : public TAdvCustomOfficeColorSelector
{
	typedef TAdvCustomOfficeColorSelector inherited;
	
protected:
	virtual void __fastcall Initialize(void);
	
__published:
	__property AllowFloating;
	__property Appearance;
	__property BorderDropDownColor = {default=8421504};
	__property Caption;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property ShowHint;
	__property ShowSelectedColor = {default=1};
	__property SelectedColor;
	__property SelectionAppearance;
	__property Tools;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property OnSelect;
	__property OnSelectColor;
public:
	/* TAdvCustomOfficeColorSelector.Create */ inline __fastcall virtual TAdvOfficeTextColorSelector(Classes::TComponent* AOwner) : TAdvCustomOfficeColorSelector(AOwner) { }
	/* TAdvCustomOfficeColorSelector.Destroy */ inline __fastcall virtual ~TAdvOfficeTextColorSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeTextColorSelector(HWND ParentWindow) : TAdvCustomOfficeColorSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvCustomOfficeTableSelector;
class PASCALIMPLEMENTATION TAdvCustomOfficeTableSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	TAdvTableSelectorPanel* FTableSelectorPanel;
	int FSelectedColumns;
	int FSelectedRows;
	int FDefaultRowCount;
	int FDefaultColCount;
	Classes::TNotifyEvent FOnSelect;
	System::UnicodeString FTextTable;
	System::UnicodeString FTextCancel;
	TTableSizeSelectEvent FOnSelectTableSize;
	void __fastcall SetDefaultColCount(const int Value);
	void __fastcall SetDefaultRowCount(const int Value);
	void __fastcall TableSelectorOnSelect(System::TObject* Sender);
	
protected:
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetSelectorPanel(void);
	virtual void __fastcall DropDownWindowClose(System::TObject* Sender, Forms::TCloseAction &Action);
	__property int DefaultColCount = {read=FDefaultColCount, write=SetDefaultColCount, default=5};
	__property int DefaultRowCount = {read=FDefaultRowCount, write=SetDefaultRowCount, default=4};
	__property int SelectedColumns = {read=FSelectedColumns, default=0};
	__property int SelectedRows = {read=FSelectedRows, default=0};
	
public:
	__fastcall virtual TAdvCustomOfficeTableSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomOfficeTableSelector(void);
	__property System::UnicodeString TextTable = {read=FTextTable, write=FTextTable};
	__property System::UnicodeString TextCancel = {read=FTextCancel, write=FTextCancel};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property TTableSizeSelectEvent OnSelectTableSize = {read=FOnSelectTableSize, write=FOnSelectTableSize};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomOfficeTableSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeTableSelector;
class PASCALIMPLEMENTATION TAdvOfficeTableSelector : public TAdvCustomOfficeTableSelector
{
	typedef TAdvCustomOfficeTableSelector inherited;
	
public:
	__property SelectedColumns = {default=0};
	__property SelectedRows = {default=0};
	
__published:
	__property Appearance;
	__property Caption;
	__property DefaultColCount = {default=5};
	__property DefaultRowCount = {default=4};
	__property ShowHint;
	__property TextTable;
	__property TextCancel;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnClick;
	__property OnSelect;
	__property OnSelectTableSize;
public:
	/* TAdvCustomOfficeTableSelector.Create */ inline __fastcall virtual TAdvOfficeTableSelector(Classes::TComponent* AOwner) : TAdvCustomOfficeTableSelector(AOwner) { }
	/* TAdvCustomOfficeTableSelector.Destroy */ inline __fastcall virtual ~TAdvOfficeTableSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeTableSelector(HWND ParentWindow) : TAdvCustomOfficeTableSelector(ParentWindow) { }
	
};


class DELPHICLASS TAdvOfficeCharacterSelector;
class PASCALIMPLEMENTATION TAdvOfficeCharacterSelector : public TAdvCustomOfficeSelector
{
	typedef TAdvCustomOfficeSelector inherited;
	
private:
	Classes::TNotifyEvent FOnSelect;
	System::UnicodeString FCharacters;
	System::WideChar FSelectedChar;
	bool FAutoLoad;
	Graphics::TFont* FCharFont;
	TCharSelectEvent FOnSelectChar;
	void __fastcall AddItemsFromChars(void);
	void __fastcall LoadCharFromFont(void);
	void __fastcall SetCharacters(const System::UnicodeString Value);
	void __fastcall SetSelectedChar(const System::WideChar Value);
	void __fastcall SetAutoLoad(const bool Value);
	void __fastcall SetCharFont(const Graphics::TFont* Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoSelect(int Index, TAdvSelectorItem* Item);
	virtual void __fastcall OnToolSelect(void);
	virtual void __fastcall SetSelectorPanel(void);
	virtual void __fastcall GetToolImage(Graphics::TBitmap* bmp);
	virtual void __fastcall DrawGlyphAndCaption(Gdipicture::TGDIPPicture* Pic, const Types::TRect &R);
	
public:
	__fastcall virtual TAdvOfficeCharacterSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeCharacterSelector(void);
	__property Tools;
	
__published:
	__property AllowFloating;
	__property Appearance;
	__property bool AutoLoad = {read=FAutoLoad, write=SetAutoLoad, default=1};
	__property BorderDropDownColor = {default=8421504};
	__property ButtonsPerRow = {default=1};
	__property Caption;
	__property CaptionAppearance;
	__property DragGripAppearance;
	__property CloseOnSelect;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property ColorDropDownFloating;
	__property ColorDropDownFloatingTo = {default=536870911};
	__property System::UnicodeString Characters = {read=FCharacters, write=SetCharacters};
	__property Graphics::TFont* CharFont = {read=FCharFont, write=SetCharFont};
	__property DropDownButton = {default=0};
	__property DragGripPosition;
	__property ShowHint;
	__property System::WideChar SelectedChar = {read=FSelectedChar, write=SetSelectedChar, nodefault};
	__property SelectionAppearance;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDropDown;
	__property OnDropDownFloat;
	__property OnDropDownClose;
	__property OnClick;
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property TCharSelectEvent OnSelectChar = {read=FOnSelectChar, write=FOnSelectChar};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeCharacterSelector(HWND ParentWindow) : TAdvCustomOfficeSelector(ParentWindow) { }
	
};


class DELPHICLASS TSelectorScroller;
class PASCALIMPLEMENTATION TSelectorScroller : public System::TObject
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
	__fastcall TSelectorScroller(void);
	bool __fastcall CanGoForward(void);
	bool __fastcall CanGoBack(void);
	__property int Min = {read=FMin, write=SetMin, nodefault};
	__property int Max = {read=FMax, write=SetMax, nodefault};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool Visible = {read=FVisible, write=SetVisible, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TSelectorScroller(void) { }
	
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


class DELPHICLASS TAdvScrollSelectorItem;
class PASCALIMPLEMENTATION TAdvScrollSelectorItem : public TAdvSelectorItem
{
	typedef TAdvSelectorItem inherited;
	
private:
	int FRow;
	int FRow1;
	int FRow2;
	Types::TRect FItemRect1;
	Types::TRect FItemRect2;
	Gdipicture::TGDIPPicture* FIPicture;
	int FCol;
	int FCol1;
	int FCol2;
	bool FMenuItem;
	void __fastcall OnPictureChanged(System::TObject* Sender);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	
protected:
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
	virtual void __fastcall SetIndex(int Value);
	__property int Row = {read=FRow, write=FRow, nodefault};
	__property int Col = {read=FCol, write=FCol, nodefault};
	__property int Row1 = {read=FRow1, write=FRow1, nodefault};
	__property int Col1 = {read=FCol1, write=FCol1, nodefault};
	__property Types::TRect ItemRect1 = {read=FItemRect1, write=FItemRect1};
	__property int Row2 = {read=FRow2, write=FRow2, nodefault};
	__property int Col2 = {read=FCol2, write=FCol2, nodefault};
	__property Types::TRect ItemRect2 = {read=FItemRect2, write=FItemRect2};
	
public:
	__fastcall virtual TAdvScrollSelectorItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvScrollSelectorItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Changed(void);
	
__published:
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property bool MenuItem = {read=FMenuItem, write=FMenuItem, default=0};
};


class DELPHICLASS TAdvScrollSelectorItems;
class PASCALIMPLEMENTATION TAdvScrollSelectorItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvScrollSelectorItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvScrollSelectorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvScrollSelectorItem* Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	
public:
	__fastcall TAdvScrollSelectorItems(Classes::TPersistent* AOwner);
	HIDESBASE TAdvScrollSelectorItem* __fastcall Add(void);
	HIDESBASE TAdvScrollSelectorItem* __fastcall Insert(int Index);
	__property TAdvScrollSelectorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvScrollSelectorItems(void) { }
	
};


typedef void __fastcall (__closure *TScrollSelectEvent)(System::TObject* Sender, int Index, TAdvScrollSelectorItem* Item);

class DELPHICLASS TAdvCustomScrollSelectorPanel;
class PASCALIMPLEMENTATION TAdvCustomScrollSelectorPanel : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Classes::TComponent* FOwner;
	Graphics::TColor FColorTo;
	TGradientDirection FGradientDirection;
	Graphics::TColor FWindowBorderColor;
	Classes::TNotifyEvent FOnShouldHide;
	bool FShowBorder;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetTGradientDirection(const TGradientDirection Value);
	void __fastcall SetWindowBorderColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	__property Classes::TNotifyEvent OnShouldHide = {read=FOnShouldHide, write=FOnShouldHide};
	__property bool ShowBorder = {read=FShowBorder, write=FShowBorder, nodefault};
	
public:
	__fastcall virtual TAdvCustomScrollSelectorPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomScrollSelectorPanel(void);
	
__published:
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor WindowBorderColor = {read=FWindowBorderColor, write=SetWindowBorderColor, default=8421504};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetTGradientDirection, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomScrollSelectorPanel(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TScrollSelectorDropDownWindow;
class DELPHICLASS TAdvCustomOfficeScrollSelector;
class DELPHICLASS TAdvScrollSelectorPanel;
class PASCALIMPLEMENTATION TScrollSelectorDropDownWindow : public Forms::TCustomForm
{
	typedef Forms::TCustomForm inherited;
	
private:
	TAdvCustomScrollSelectorPanel* FSelectorPanel;
	bool FHideOnDeActivate;
	bool FShowAbove;
	Classes::TComponent* FOwner;
	bool FShowBorder;
	Extctrls::TTimer* FHideTimer;
	bool FShowLeft;
	TAdvCustomOfficeScrollSelector* FScrollSelector;
	Controls::TCursor FOldCursor;
	int FMouseX;
	int FMouseY;
	bool FResizing;
	bool FSizeGrip;
	System::UnicodeString FDropDownCaption;
	int FResizerHeight;
	int FCaptionHeight;
	int FDropDownBorderWidth;
	TAdvScrollSelectorPanel* FFullWidthSelector;
	Forms::TScrollBox* FScrollBox;
	TAdvScrollSelectorPanel* FItemsSelector;
	bool FInternalChange;
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TWMActivate &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	void __fastcall HideTimerOnTime(System::TObject* Sender);
	void __fastcall SetSelectorPanel(const TAdvCustomScrollSelectorPanel* Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall Paint(void);
	HWND __fastcall GetParentWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	Types::TRect __fastcall GetCaptionRect(void);
	Types::TRect __fastcall GetResizerRect(void);
	void __fastcall InvalidateResizer(void);
	void __fastcall InvalidateCaption(void);
	__property bool HideOnDeActivate = {read=FHideOnDeActivate, write=FHideOnDeActivate, nodefault};
	__property bool ShowAbove = {read=FShowAbove, write=FShowAbove, nodefault};
	__property bool ShowLeft = {read=FShowLeft, write=FShowLeft, default=0};
	__property bool ShowBorder = {read=FShowBorder, write=FShowBorder, nodefault};
	
public:
	__fastcall virtual TScrollSelectorDropDownWindow(Classes::TComponent* AOwner);
	__fastcall virtual TScrollSelectorDropDownWindow(Classes::TComponent* AOwner, int Dummy);
	__fastcall virtual ~TScrollSelectorDropDownWindow(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SetPositions(void);
	
__published:
	__property TAdvCustomScrollSelectorPanel* SelectorPanel = {read=FSelectorPanel, write=SetSelectorPanel};
	__property Forms::TScrollBox* ScrollBox = {read=FScrollBox, write=FScrollBox};
	__property TAdvCustomOfficeScrollSelector* ScrollSelector = {read=FScrollSelector, write=FScrollSelector};
	__property TAdvScrollSelectorPanel* FullWidthSelector = {read=FFullWidthSelector, write=FFullWidthSelector};
	__property TAdvScrollSelectorPanel* ItemsSelector = {read=FItemsSelector, write=FItemsSelector};
	__property bool SizeGrip = {read=FSizeGrip, write=FSizeGrip, nodefault};
	__property System::UnicodeString DropDownCaption = {read=FDropDownCaption, write=FDropDownCaption};
	__property int CaptionHeight = {read=FCaptionHeight, write=FCaptionHeight, nodefault};
	__property int ResizerHeight = {read=FResizerHeight, write=FResizerHeight, nodefault};
	__property int DropDownBorderWidth = {read=FDropDownBorderWidth, write=FDropDownBorderWidth, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TScrollSelectorDropDownWindow(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvScrollSelectorPanel : public TAdvCustomScrollSelectorPanel
{
	typedef TAdvCustomScrollSelectorPanel inherited;
	
private:
	int FItemIndex;
	Imglist::TCustomImageList* FImages;
	int FHotItemIndex;
	int FDownItemIndex;
	int FButtonHeight;
	int FTopOffSet;
	int FLeftOffSet;
	TChangeSelectionEvent FOnChangeSelection;
	int FButtonMargin;
	bool FMouseDown;
	Classes::TNotifyEvent FOnSelect;
	THotToolEvent FOnHotTool;
	int FMaxCaptionLength;
	TItemDrawEvent FOnDrawItem;
	int FMinButtonWidth;
	int FMinButtonHeight;
	bool FNoPrefix;
	bool FTwoColorImages;
	TSelectionAppearance* FSelectionAppearance;
	TSimpleGradientCaption* FCaptionAppearance;
	bool FAutoHeight;
	bool FShowAutoSizeButton;
	bool FShowCaptionItem;
	bool FShowFullWidthItem;
	TAdvCustomOfficeScrollSelector* FAdvOfficeScrollSelector;
	int FTopRow;
	int FVisibleRowCount;
	int FRowCount;
	int FRowHeight;
	bool FInternalUpdatingSize;
	Classes::TNotifyEvent FOnScroll;
	bool FIntegralRows;
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetButtonMargin(const int Value);
	void __fastcall SetMinButtonHeight(const int Value);
	void __fastcall SetMinButtonWidth(const int Value);
	void __fastcall SetTwoColorImages(const bool Value);
	void __fastcall SetSelectionAppearance(const TSelectionAppearance* Value);
	void __fastcall SetCaptionAppearance(const TSimpleGradientCaption* Value);
	TAdvScrollSelectorItems* __fastcall GetItems(void);
	TNoOfButtons __fastcall GetButtonsPerRow(void);
	int __fastcall GetHotItem(void);
	void __fastcall SetHotItem(const int Value);
	void __fastcall SetIntegralRows(const bool Value);
	
protected:
	void __fastcall DrawItem(int Index, bool RefreshItem = false, Advgdip::TGPGraphics* Graph = (Advgdip::TGPGraphics*)(0x0));
	virtual void __fastcall Paint(void);
	virtual void __fastcall ResetDown(void);
	void __fastcall SetItemsPosition(void);
	int __fastcall GetMaxWidth(void);
	int __fastcall TotalAutoSizeButtons(void);
	int __fastcall ItemAtPos(int X, int Y);
	void __fastcall SetPanelHeight(void);
	void __fastcall AutoSizeBtnSize(int &W, int &H);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	Types::TRect __fastcall GetItemRect(TAdvScrollSelectorItem* Item);
	int __fastcall GetItemRow(TAdvScrollSelectorItem* Item);
	int __fastcall GetItemCol(TAdvScrollSelectorItem* Item);
	bool __fastcall IsShowingIconBar(void);
	void __fastcall DoSelect(void);
	__property int MinButtonWidth = {read=FMinButtonWidth, write=SetMinButtonWidth, default=16};
	__property int MinButtonHeight = {read=FMinButtonHeight, write=SetMinButtonHeight, default=16};
	__property bool NoPrefix = {read=FNoPrefix, write=FNoPrefix, nodefault};
	__property bool TwoColorImages = {read=FTwoColorImages, write=SetTwoColorImages, nodefault};
	
public:
	__fastcall virtual TAdvScrollSelectorPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvScrollSelectorPanel(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property TAdvScrollSelectorItems* Items = {read=GetItems};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, nodefault};
	int __fastcall CanScrollUp(void);
	int __fastcall CanScrollDown(void);
	void __fastcall ScrollRows(int Value);
	void __fastcall ViewButton(int Index);
	void __fastcall ViewSelectedButton(void);
	void __fastcall SetTopRow(int Value);
	__property int HotItemIndex = {read=GetHotItem, write=SetHotItem, nodefault};
	int __fastcall FirstItemIndex(void);
	int __fastcall LastItemIndex(void);
	int __fastcall PreviousItemIndex(int Index);
	int __fastcall NextItemIndex(int Index);
	int __fastcall UpItemIndex(int Index);
	int __fastcall DownItemIndex(int Index);
	__property Classes::TNotifyEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	
__published:
	__property bool AutoHeight = {read=FAutoHeight, write=FAutoHeight, nodefault};
	__property TSelectionAppearance* SelectionAppearance = {read=FSelectionAppearance, write=SetSelectionAppearance};
	__property TSimpleGradientCaption* CaptionAppearance = {read=FCaptionAppearance, write=SetCaptionAppearance};
	__property TNoOfButtons ButtonsPerRow = {read=GetButtonsPerRow, nodefault};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property int ButtonMargin = {read=FButtonMargin, write=SetButtonMargin, nodefault};
	__property bool ShowAutoSizeButton = {read=FShowAutoSizeButton, write=FShowAutoSizeButton, nodefault};
	__property bool ShowCaptionItem = {read=FShowCaptionItem, write=FShowCaptionItem, nodefault};
	__property bool ShowFullWidthItem = {read=FShowFullWidthItem, write=FShowFullWidthItem, nodefault};
	__property int RowCount = {read=FRowCount, nodefault};
	__property int VisibleRowCount = {read=FVisibleRowCount, nodefault};
	__property int TopRow = {read=FTopRow, nodefault};
	__property bool IntegralRows = {read=FIntegralRows, write=SetIntegralRows, nodefault};
	__property TAdvCustomOfficeScrollSelector* AdvOfficeScrollSelector = {read=FAdvOfficeScrollSelector, write=FAdvOfficeScrollSelector};
	__property TChangeSelectionEvent OnChangeSelection = {read=FOnChangeSelection, write=FOnChangeSelection};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property THotToolEvent OnHotTool = {read=FOnHotTool, write=FOnHotTool};
	__property TItemDrawEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvScrollSelectorPanel(HWND ParentWindow) : TAdvCustomScrollSelectorPanel(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TAdvCustomOfficeScrollSelector : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TAdvScrollSelectorItems* FTools;
	TAdvScrollSelectorPanel* FScrollSelectorPanel;
	Graphics::TColor FColorDropDownTo;
	Graphics::TColor FColorDropDown;
	Graphics::TColor FColorTo;
	Graphics::TColor FBorderDropDownColor;
	Graphics::TColor FBorderColor;
	Imglist::TCustomImageList* FToolImages;
	TDrawToolEvent FOnDrawTool;
	TSimpleGradientCaption* FCaptionAppearance;
	TSimpleGradientCaption* FCaptionItemAppearance;
	TGradientDirection FGradientDirection;
	THotToolEvent FOnHotTool;
	Classes::TNotifyEvent FOnDropDown;
	TSelectionAppearance* FSelectionAppearance;
	bool FDropDownButton;
	bool FDropDownButtonDown;
	bool FDropDownButtonHot;
	TSelectorScroller* FSelectorScroller;
	TSelectionAppearance* FScrollerAppearance;
	bool FUpScrollerDown;
	bool FUpScrollerHot;
	bool FDownScrollerDown;
	bool FDownScrollerHot;
	TScrollSelectorDropDownWindow* FDropDownWindow;
	Forms::TScrollBox* FItemsScrollBox;
	TAdvScrollSelectorPanel* FDropDownItemsPanel;
	TAdvScrollSelectorPanel* FDropDownFullWidthItemPanel;
	TGradientBackground* FResizerAppearance;
	bool FDropDownSizeable;
	System::UnicodeString FDropDownCaption;
	TSelectorButtonSize* FButtonSize;
	TGradientBackground* FIconBarAppearance;
	int FIconBarWidth;
	TScrollSelectEvent FOnSelect;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnScrollDown;
	Classes::TNotifyEvent FOnScrollUp;
	Classes::TNotifyEvent FOnMouseEnter;
	Graphics::TColor FFocusColorTo;
	Graphics::TColor FFocusColor;
	bool FIntegralRows;
	int FOldDropDownHeight;
	int FOldDropDownWidth;
	int FDropDownHeight;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TWMSetFocus &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall DrawUpScroller(void);
	void __fastcall DrawDownScroller(void);
	void __fastcall DrawScroller(void);
	void __fastcall DrawDropDownButton(void);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	void __fastcall OnItemsChanged(System::TObject* Sender);
	void __fastcall OnScrollSelectorPanelScroll(System::TObject* Sender);
	void __fastcall OnDropDownWindowHide(System::TObject* Sender);
	void __fastcall OnDropDownWindowClose(System::TObject* Sender, Forms::TCloseAction &Action);
	void __fastcall OnDropDownPanelShouldHide(System::TObject* Sender);
	void __fastcall OnDropDownPanelSelect(System::TObject* Sender);
	void __fastcall OnDropDownPanelHotTool(System::TObject* Sender, int HotItemIndex);
	void __fastcall OnDropDownPanelDrawTool(System::TObject* Sender, int ItemIndex, const Types::TRect &R);
	void __fastcall ButtonSizeChanged(System::TObject* Sender);
	int __fastcall GetSelectedIndex(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetCaptionAppearance(const TSimpleGradientCaption* Value);
	void __fastcall SetCaptionItemAppearance(const TSimpleGradientCaption* Value);
	void __fastcall SetColorDropDown(const Graphics::TColor Value);
	void __fastcall SetColorDropDownTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetSelectedIndex(const int Value);
	void __fastcall SetSelectionAppearance(const TSelectionAppearance* Value);
	void __fastcall SetTGradientDirection(const TGradientDirection Value);
	void __fastcall SetToolImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetTools(const TAdvScrollSelectorItems* Value);
	void __fastcall SetDropDownButton(const bool Value);
	void __fastcall SetScrollerAppearance(const TSelectionAppearance* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetResizerAppearance(const TGradientBackground* Value);
	void __fastcall SetButtonSize(const TSelectorButtonSize* Value);
	void __fastcall SetIconBarAppearance(const TGradientBackground* Value);
	int __fastcall GetTopRow(void);
	void __fastcall SetTopRow(const int Value);
	Graphics::TColor __fastcall GetColor(void);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetIntegralRows(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Paint(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual int __fastcall GetVersionNr(void);
	virtual void __fastcall DoSelect(int Index, TAdvScrollSelectorItem* Item);
	virtual void __fastcall OnToolSelect(void);
	Types::TRect __fastcall ScrollSelectorPanelRect(void);
	void __fastcall SetScrollSelectorPanelPos(void);
	void __fastcall UpdateScrollSelectorPanel(void);
	void __fastcall UpdateScroller(void);
	Types::TRect __fastcall ScrollerRect(void);
	Types::TRect __fastcall ScrollerUpRect(void);
	Types::TRect __fastcall ScrollerDownRect(void);
	Types::TRect __fastcall DropDownBtnRect(void);
	void __fastcall InvalidateScroller(void);
	void __fastcall UpScrollerClick(void);
	void __fastcall DownScrollerClick(void);
	void __fastcall DropDownButtonClick(void);
	void __fastcall ShowDropDown(void);
	void __fastcall HideDropDown(void);
	int __fastcall CaptionItemCount(void);
	int __fastcall FullWidthButtonCount(void);
	int __fastcall AutoSizeButtonCount(void);
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderDropDownColor = {read=FBorderDropDownColor, write=FBorderDropDownColor, default=8421504};
	__property Graphics::TColor ColorDropDown = {read=FColorDropDown, write=SetColorDropDown, nodefault};
	__property Graphics::TColor ColorDropDownTo = {read=FColorDropDownTo, write=SetColorDropDownTo, default=536870911};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=FFocusColor, nodefault};
	__property Graphics::TColor FocusColorTo = {read=FFocusColorTo, write=FFocusColorTo, nodefault};
	__property TSelectionAppearance* SelectionAppearance = {read=FSelectionAppearance, write=SetSelectionAppearance};
	__property TSimpleGradientCaption* CaptionAppearance = {read=FCaptionAppearance, write=SetCaptionAppearance};
	__property TGradientBackground* ResizerAppearance = {read=FResizerAppearance, write=SetResizerAppearance};
	__property TSimpleGradientCaption* CaptionItemAppearance = {read=FCaptionItemAppearance, write=SetCaptionItemAppearance};
	__property TGradientDirection GradientDirection = {read=FGradientDirection, write=SetTGradientDirection, nodefault};
	__property Imglist::TCustomImageList* ToolImages = {read=FToolImages, write=SetToolImages};
	__property TAdvScrollSelectorItems* Tools = {read=FTools, write=SetTools};
	__property int SelectedIndex = {read=GetSelectedIndex, write=SetSelectedIndex, nodefault};
	__property TSelectionAppearance* ScrollerAppearance = {read=FScrollerAppearance, write=SetScrollerAppearance};
	__property bool DropDownButton = {read=FDropDownButton, write=SetDropDownButton, nodefault};
	__property int DropDownHeight = {read=FDropDownHeight, write=FDropDownHeight, default=250};
	__property bool DropDownSizeable = {read=FDropDownSizeable, write=FDropDownSizeable, nodefault};
	__property System::UnicodeString DropDownCaption = {read=FDropDownCaption, write=FDropDownCaption};
	__property TSelectorButtonSize* ButtonSize = {read=FButtonSize, write=SetButtonSize};
	__property int IconBarWidth = {read=FIconBarWidth, write=FIconBarWidth, nodefault};
	__property TGradientBackground* IconBarAppearance = {read=FIconBarAppearance, write=SetIconBarAppearance};
	__property int TopRow = {read=GetTopRow, write=SetTopRow, nodefault};
	__property bool IntegralRows = {read=FIntegralRows, write=SetIntegralRows, default=1};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property TScrollSelectEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property THotToolEvent OnHotTool = {read=FOnHotTool, write=FOnHotTool};
	__property TDrawToolEvent OnDrawTool = {read=FOnDrawTool, write=FOnDrawTool};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnScrollUp = {read=FOnScrollUp, write=FOnScrollUp};
	__property Classes::TNotifyEvent OnScrollDown = {read=FOnScrollDown, write=FOnScrollDown};
	
public:
	__fastcall virtual TAdvCustomOfficeScrollSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomOfficeScrollSelector(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomOfficeScrollSelector(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


class DELPHICLASS TAdvOfficeScrollSelector;
class PASCALIMPLEMENTATION TAdvOfficeScrollSelector : public TAdvCustomOfficeScrollSelector
{
	typedef TAdvCustomOfficeScrollSelector inherited;
	
public:
	__property TopRow;
	
__published:
	__property BorderColor;
	__property BorderDropDownColor = {default=8421504};
	__property ButtonSize;
	__property DropDownCaption;
	__property DropDownHeight = {default=250};
	__property DropDownSizeable;
	__property ColorDropDown;
	__property ColorDropDownTo = {default=536870911};
	__property Color;
	__property ColorTo;
	__property FocusColor;
	__property FocusColorTo;
	__property SelectionAppearance;
	__property CaptionAppearance;
	__property CaptionItemAppearance;
	__property GradientDirection;
	__property IconBarWidth;
	__property IconBarAppearance;
	__property IntegralRows = {default=1};
	__property ToolImages;
	__property Tools;
	__property SelectedIndex;
	__property ScrollerAppearance;
	__property ResizerAppearance;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property OnDropDown;
	__property OnSelect;
	__property OnHotTool;
	__property OnDrawTool;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnEnter;
	__property OnExit;
	__property OnMouseLeave;
	__property OnMouseEnter;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnScrollUp;
	__property OnScrollDown;
public:
	/* TAdvCustomOfficeScrollSelector.Create */ inline __fastcall virtual TAdvOfficeScrollSelector(Classes::TComponent* AOwner) : TAdvCustomOfficeScrollSelector(AOwner) { }
	/* TAdvCustomOfficeScrollSelector.Destroy */ inline __fastcall virtual ~TAdvOfficeScrollSelector(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeScrollSelector(HWND ParentWindow) : TAdvCustomOfficeScrollSelector(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MINBUTTONSIZE = 0x10;
static const ShortInt TABLECELLSIZE = 0x18;
static const ShortInt DRAGGRIP_HEIGHT = 0x8;
static const ShortInt CAPTION_HEIGHT = 0x14;
static const ShortInt SCROLLER_WIDTH = 0x10;
static const ShortInt DROPDOWN_KEY = 0x71;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advofficeselectors */
using namespace Advofficeselectors;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvofficeselectorsHPP
