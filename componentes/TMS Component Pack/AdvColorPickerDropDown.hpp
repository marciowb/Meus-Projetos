// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcolorpickerdropdown.pas' rev: 21.00

#ifndef AdvcolorpickerdropdownHPP
#define AdvcolorpickerdropdownHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advdropdown.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Graphutil.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcolorpickerdropdown
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TColorSelectionStyle { csList, csDiscrete, csColorCube, csSpectrum };
#pragma option pop

#pragma option push -b-
enum TItemPos { ipStandAlone, ipTop, ipMiddle, ipBottom };
#pragma option pop

class DELPHICLASS TColorItem;
class PASCALIMPLEMENTATION TColorItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	Graphics::TColor FColor;
	bool FEnabled;
	Types::TRect FRect;
	System::UnicodeString FHint;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	__property Types::TRect Rect = {read=FRect, write=FRect};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	
public:
	__fastcall virtual TColorItem(Classes::TCollection* Collection);
	__fastcall virtual ~TColorItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
};


class DELPHICLASS TColorItems;
class PASCALIMPLEMENTATION TColorItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TColorItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TColorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TColorItem* Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TColorItems(Classes::TPersistent* AOwner);
	__property TColorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TColorItem* __fastcall Add(void);
	HIDESBASE TColorItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TColorItems(void) { }
	
};


class DELPHICLASS TAdvCustomColorSelectorPanel;
class PASCALIMPLEMENTATION TAdvCustomColorSelectorPanel : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	Classes::TNotifyEvent FOnShouldHide;
	
protected:
	__property Classes::TNotifyEvent OnShouldHide = {read=FOnShouldHide, write=FOnShouldHide};
public:
	/* TCustomControl.Create */ inline __fastcall virtual TAdvCustomColorSelectorPanel(Classes::TComponent* AOwner) : Controls::TCustomControl(AOwner) { }
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TAdvCustomColorSelectorPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomColorSelectorPanel(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


struct TColorCubeCell
{
	
public:
	Types::TPoint CenterPos;
	Graphics::TColor Color;
};


class DELPHICLASS TAdvColorCubePanel;
class PASCALIMPLEMENTATION TAdvColorCubePanel : public TAdvCustomColorSelectorPanel
{
	typedef TAdvCustomColorSelectorPanel inherited;
	
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
	void __fastcall Initialize(void);
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvColorCubePanel(HWND ParentWindow) : TAdvCustomColorSelectorPanel(ParentWindow) { }
	
};


class DELPHICLASS TAdvColorSpectrumPanel;
class PASCALIMPLEMENTATION TAdvColorSpectrumPanel : public TAdvCustomColorSelectorPanel
{
	typedef TAdvCustomColorSelectorPanel inherited;
	
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvColorSpectrumPanel(HWND ParentWindow) : TAdvCustomColorSelectorPanel(ParentWindow) { }
	
};


class DELPHICLASS TColorBoxAppearance;
class PASCALIMPLEMENTATION TColorBoxAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FOuterBorderColorHot;
	Graphics::TColor FInnerBorderColorHot;
	Graphics::TColor FOuterBorderColorSelected;
	Graphics::TColor FInnerBorderColorSelected;
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TColorBoxAppearance(void);
	__fastcall virtual ~TColorBoxAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=FBorderColor, default=12632256};
	__property Graphics::TColor OuterBorderColorHot = {read=FOuterBorderColorHot, write=FOuterBorderColorHot, nodefault};
	__property Graphics::TColor InnerBorderColorHot = {read=FInnerBorderColorHot, write=FInnerBorderColorHot, nodefault};
	__property Graphics::TColor OuterBorderColorSelected = {read=FOuterBorderColorSelected, write=FOuterBorderColorSelected, nodefault};
	__property Graphics::TColor InnerBorderColorSelected = {read=FInnerBorderColorSelected, write=FInnerBorderColorSelected, nodefault};
};


class DELPHICLASS TColorBoxItem;
class PASCALIMPLEMENTATION TColorBoxItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Graphics::TColor FColor;
	bool FEnabled;
	Types::TRect FRect;
	TItemPos FColorBoxPos;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorBoxPos(const TItemPos Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	__property Types::TRect Rect = {read=FRect, write=FRect};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	
public:
	__fastcall virtual TColorBoxItem(Classes::TCollection* Collection);
	__fastcall virtual ~TColorBoxItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=536870911};
	__property TItemPos ColorBoxPos = {read=FColorBoxPos, write=SetColorBoxPos, default=0};
};


class DELPHICLASS TColorBoxItems;
class PASCALIMPLEMENTATION TColorBoxItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TColorBoxItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TColorBoxItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TColorBoxItem* Value);
	
protected:
	void __fastcall Change(void);
	
public:
	__fastcall TColorBoxItems(Classes::TPersistent* AOwner);
	__property TColorBoxItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TColorBoxItem* __fastcall Add(void);
	HIDESBASE TColorBoxItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TColorBoxItems(void) { }
	
};


class DELPHICLASS TCustomColorSelector;
class PASCALIMPLEMENTATION TCustomColorSelector : public TAdvCustomColorSelectorPanel
{
	typedef TAdvCustomColorSelectorPanel inherited;
	
private:
	int FItemIndex;
	int FItemHot;
	int FOffSetX;
	int FOffSetY;
	Classes::TNotifyEvent FOnItemSelect;
	int FColumns;
	int FColumnGap;
	int FColorBoxHeight;
	int FColorBoxWidth;
	TColorBoxAppearance* FColorBoxAppearance;
	TColorBoxItems* FItems;
	Advdropdown::TSelectionColorStyle FItemColorStyle;
	Graphics::TColor FSelectedColor;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetItemHot(const int Value);
	void __fastcall SetColorBoxAppearance(const TColorBoxAppearance* Value);
	void __fastcall SetColorBoxHeight(const int Value);
	void __fastcall SetColorBoxWidth(const int Value);
	void __fastcall SetColumnGap(const int Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetItemColorStyle(const Advdropdown::TSelectionColorStyle Value);
	void __fastcall SetItems(const TColorBoxItems* Value);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall Paint(void);
	void __fastcall DrawItems(Graphics::TCanvas* aCanvas);
	virtual void __fastcall DrawItem(int Index, Graphics::TCanvas* aCanvas);
	virtual Types::TRect __fastcall GetInnerRect(void);
	virtual tagSIZE __fastcall GetItemSize(void);
	virtual void __fastcall UpdateRectAndSize(void);
	virtual void __fastcall InvalidateItem(int Index);
	int __fastcall ItemAtPos(int X, int Y);
	Types::TRect __fastcall GetItemRect(int Index);
	void __fastcall CreateDefaultColors(void);
	void __fastcall HandleKey(System::Word Key, bool EditorEnabled, bool DroppedDown);
	HIDESBASE void __fastcall SelectFirst(void);
	void __fastcall SelectLast(void);
	void __fastcall SelectPrevious(void);
	HIDESBASE void __fastcall SelectNext(void);
	void __fastcall HotPrevious(void);
	void __fastcall HotNext(void);
	__property int ItemHot = {read=FItemHot, write=SetItemHot, default=-1};
	
public:
	__fastcall virtual TCustomColorSelector(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomColorSelector(void);
	__property TColorBoxAppearance* ColorBoxAppearance = {read=FColorBoxAppearance, write=SetColorBoxAppearance};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property TColorBoxItems* Items = {read=FItems, write=SetItems};
	__property int ColumnGap = {read=FColumnGap, write=SetColumnGap, nodefault};
	__property int Columns = {read=FColumns, write=SetColumns, nodefault};
	__property Advdropdown::TSelectionColorStyle ItemColorStyle = {read=FItemColorStyle, write=SetItemColorStyle, nodefault};
	__property int ColorBoxHeight = {read=FColorBoxHeight, write=SetColorBoxHeight, nodefault};
	__property int ColorBoxWidth = {read=FColorBoxWidth, write=SetColorBoxWidth, nodefault};
	__property Classes::TNotifyEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomColorSelector(HWND ParentWindow) : TAdvCustomColorSelectorPanel(ParentWindow) { }
	
};


#pragma option push -b-
enum TColorValueText { cvtNone, cvtHex, cvtWebName, cvtRGB, cvtHTML };
#pragma option pop

class DELPHICLASS TAdvColorPickerDropDown;
class PASCALIMPLEMENTATION TAdvColorPickerDropDown : public Advdropdown::TAdvCustomDropDown
{
	typedef Advdropdown::TAdvCustomDropDown inherited;
	
private:
	Advdropdown::TAdvCustomItemSelector* FItemSelector;
	TAdvColorCubePanel* FColorCubePanel;
	TAdvColorSpectrumPanel* FSpectrumPanel;
	TCustomColorSelector* FColorSelector;
	int FColumns;
	Advdropdown::TItemLayout FLayout;
	TColorItems* FColors;
	int FItemIndex;
	Classes::TNotifyEvent FOnSelect;
	int FColorBoxWidth;
	int FColorBoxHeight;
	TColorSelectionStyle FColorSelectionStyle;
	Graphics::TColor FSelectedColor;
	bool FShowText;
	Advdropdown::TOnDrawSelectedItem FOnDrawSelectedColor;
	Advdropdown::TItemAppearance* FItemAppearance;
	bool FInternalCall;
	Extctrls::TTimer* FKeyTimer;
	System::UnicodeString FCurSearch;
	int FOldItemIndex;
	Graphics::TColor FOldSelectedColor;
	Advdropdown::TDrawItemEvent FOnDrawColor;
	bool FDesignTime;
	TColorValueText FColorValueText;
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	void __fastcall DrawSelectedItem(void);
	void __fastcall OnItemsChanged(System::TObject* Sender);
	void __fastcall OnSelectorItemSelect(System::TObject* Sender);
	void __fastcall CubePanelOnSelect(System::TObject* Sender);
	void __fastcall SpectrumPanelOnSelect(System::TObject* Sender);
	void __fastcall ColorSelectorOnItemSelect(System::TObject* Sender);
	void __fastcall OnItemSelectorDrawItem(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TRect &R, int Index);
	void __fastcall OnKeyTimerTime(System::TObject* Sender);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetLayout(const Advdropdown::TItemLayout Value);
	void __fastcall SetColors(const TColorItems* Value);
	void __fastcall AssignedItemsToItemSelector(void);
	void __fastcall SetSelectorProperties(void);
	void __fastcall SetColorBoxHeight(const int Value);
	void __fastcall SetColorBoxWidth(const int Value);
	void __fastcall SetColorSelectionStyle(const TColorSelectionStyle Value);
	void __fastcall SetSelectedColor(const Graphics::TColor Value);
	void __fastcall CreateItemListPanel(void);
	void __fastcall CreateColorCubePanel(void);
	void __fastcall CreateSpectrumPanel(void);
	void __fastcall CreateColorSelectorPanel(void);
	void __fastcall SetShowText(const bool Value);
	void __fastcall SetItemAppearance(const Advdropdown::TItemAppearance* Value);
	
protected:
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall UpdateDropDownSize(void);
	virtual void __fastcall DoHideDropDown(bool Canceled);
	virtual void __fastcall OnDestroyDropDownForm(void);
	virtual void __fastcall SetEditRect(void);
	virtual void __fastcall SetSelectionColorStyle(const Advdropdown::TSelectionColorStyle Value);
	virtual void __fastcall SetCenterControl(void);
	virtual void __fastcall HandleMouseWheelDown(void);
	virtual void __fastcall HandleMouseWheelUp(void);
	virtual void __fastcall DrawBackGround(void);
	HIDESBASE void __fastcall SelectFirst(void);
	void __fastcall SelectLast(void);
	HIDESBASE void __fastcall SelectNext(void);
	void __fastcall SelectPrevious(void);
	virtual System::UnicodeString __fastcall GetSelectedColorText(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	
public:
	__fastcall virtual TAdvColorPickerDropDown(Classes::TComponent* AOwner);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	__fastcall virtual ~TAdvColorPickerDropDown(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall AddDefaultColors(void);
	__property Graphics::TColor SelectedColor = {read=FSelectedColor, write=SetSelectedColor, default=536870911};
	__property System::UnicodeString SelectedColorText = {read=GetSelectedColorText};
	
__published:
	__property int Columns = {read=FColumns, write=SetColumns, default=1};
	__property TColorItems* Colors = {read=FColors, write=SetColors};
	__property int ItemIndex = {read=FItemIndex, write=SetItemIndex, default=-1};
	__property int ColorBoxHeight = {read=FColorBoxHeight, write=SetColorBoxHeight, default=14};
	__property int ColorBoxWidth = {read=FColorBoxWidth, write=SetColorBoxWidth, default=14};
	__property Advdropdown::TItemLayout Layout = {read=FLayout, write=SetLayout, default=1};
	__property Advdropdown::TItemAppearance* ItemAppearance = {read=FItemAppearance, write=SetItemAppearance};
	__property TColorValueText ColorValueText = {read=FColorValueText, write=FColorValueText, default=0};
	__property TColorSelectionStyle ColorSelectionStyle = {read=FColorSelectionStyle, write=SetColorSelectionStyle, default=0};
	__property bool ShowText = {read=FShowText, write=SetShowText, default=1};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BevelEdges = {default=15};
	__property BevelInner = {index=0, default=2};
	__property BevelKind = {default=0};
	__property BevelOuter = {index=1, default=1};
	__property BevelWidth = {default=1};
	__property BiDiMode;
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D;
	__property Cursor = {default=-2};
	__property ImeMode = {default=3};
	__property ImeName;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property DropDownColor = {default=16777215};
	__property DropDownBorderColor = {default=0};
	__property DropDownBorderWidth = {default=1};
	__property DropDownShadow = {default=1};
	__property DropDownWidth = {default=0};
	__property DropDownHeight = {default=200};
	__property DropPosition = {default=0};
	__property DropDownButtonWidth = {default=17};
	__property DropDownButtonHint;
	__property DropDownButtonGlyph;
	__property DropDownSizeable = {default=1};
	__property Enabled = {default=1};
	__property Font;
	__property Images;
	__property Version;
	__property ButtonAppearance;
	__property DropDownHeader;
	__property DropDownFooter;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
	__property Classes::TNotifyEvent OnSelect = {read=FOnSelect, write=FOnSelect};
	__property Advdropdown::TOnDrawSelectedItem OnDrawSelectedColor = {read=FOnDrawSelectedColor, write=FOnDrawSelectedColor};
	__property Advdropdown::TDrawItemEvent OnDrawColor = {read=FOnDrawColor, write=FOnDrawColor};
	__property OnEnter;
	__property OnExit;
	__property OnChange;
	__property OnClick;
	__property OnDblClick;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnBeforeDropDown;
	__property OnDropDown;
	__property OnDropUp;
	__property OnDropDownHeaderButtonClick;
	__property OnDropDownFooterButtonClick;
	__property OnDrawHeader;
	__property OnDrawFooter;
	__property OnGetHeaderText;
	__property OnGetFooterText;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvColorPickerDropDown(HWND ParentWindow) : Advdropdown::TAdvCustomDropDown(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advcolorpickerdropdown */
using namespace Advcolorpickerdropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcolorpickerdropdownHPP
