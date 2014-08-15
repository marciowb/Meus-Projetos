// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcalculatordropdown.pas' rev: 21.00

#ifndef AdvcalculatordropdownHPP
#define AdvcalculatordropdownHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advdropdown.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Atxpvs.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcalculatordropdown
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TButtonPanelType { plCalculator, plCustom };
#pragma option pop

typedef void __fastcall (__closure *TCalculatorButtonClickEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TButtonItem;
class PASCALIMPLEMENTATION TButtonItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Controls::TCaption FCaption;
	int FImageIndex;
	bool FEnabled;
	Graphics::TPicture* FImage;
	int FTag;
	int FHeight;
	int FLeft;
	int FWidth;
	int FTop;
	System::UnicodeString FName;
	Graphics::TColor FCaptionColor;
	bool FSpecial;
	void __fastcall SetCaption(const Controls::TCaption Value);
	void __fastcall SetImage(const Graphics::TPicture* Value);
	void __fastcall SetTag(const int Value);
	Types::TRect __fastcall GetRect(void);
	void __fastcall SetCaptionColor(const Graphics::TColor Value);
	
protected:
	__property Types::TRect Rect = {read=GetRect};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property int Left = {read=FLeft, write=FLeft, nodefault};
	__property int Top = {read=FTop, write=FTop, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	__property int Height = {read=FHeight, write=FHeight, nodefault};
	__property bool Special = {read=FSpecial, write=FSpecial, default=0};
	
public:
	__fastcall virtual TButtonItem(Classes::TCollection* Collection);
	__fastcall virtual ~TButtonItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Controls::TCaption Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor CaptionColor = {read=FCaptionColor, write=SetCaptionColor, default=16777215};
	__property int ImageIndex = {read=FImageIndex, write=FImageIndex, default=-1};
	__property Graphics::TPicture* Image = {read=FImage, write=SetImage};
	__property int Tag = {read=FTag, write=SetTag, default=0};
};


class DELPHICLASS TButtonItems;
class PASCALIMPLEMENTATION TButtonItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TButtonItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FMyOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TButtonItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TButtonItem* Value);
	
public:
	__fastcall TButtonItems(Classes::TPersistent* AOwner);
	__property TButtonItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TButtonItem* __fastcall Add(void);
	HIDESBASE TButtonItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TButtonItems(void) { }
	
};


class DELPHICLASS TButtonAppearance;
class PASCALIMPLEMENTATION TButtonAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderColorHot;
	Graphics::TColor FBorderColorDown;
	Graphics::TColor FBorderColorChecked;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorCheckedTo;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FColorDisabledTo;
	Graphics::TColor FColorChecked;
	Graphics::TFont* FFont;
	Graphics::TColor FShineColor;
	Graphics::TColor FGlowColorHot;
	Graphics::TColor FGlowColorDown;
	Graphics::TColor FTextColor;
	Graphics::TColor FSpecialTextColor;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorChecked(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorChecked(const Graphics::TColor Value);
	void __fastcall SetColorCheckedTo(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetShineColor(const Graphics::TColor Value);
	void __fastcall SetSpecialTextColor(const Graphics::TColor Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	__property Graphics::TColor BorderColorChecked = {read=FBorderColorChecked, write=SetBorderColorChecked, default=16711680};
	__property Graphics::TColor ColorChecked = {read=FColorChecked, write=SetColorChecked, nodefault};
	__property Graphics::TColor ColorCheckedTo = {read=FColorCheckedTo, write=SetColorCheckedTo, nodefault};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, nodefault};
	__property Graphics::TColor ColorDisabledTo = {read=FColorDisabledTo, write=SetColorDisabledTo, nodefault};
	
public:
	__fastcall TButtonAppearance(void);
	__fastcall virtual ~TButtonAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, default=0};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=SetBorderColorDown, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, nodefault};
	__property Graphics::TColor GlowColorHot = {read=FGlowColorHot, write=FGlowColorHot, nodefault};
	__property Graphics::TColor GlowColorDown = {read=FGlowColorDown, write=FGlowColorDown, nodefault};
	__property Graphics::TColor ShineColor = {read=FShineColor, write=SetShineColor, default=16777215};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, default=0};
	__property Graphics::TColor SpecialTextColor = {read=FSpecialTextColor, write=SetSpecialTextColor, default=128};
};


class DELPHICLASS TCustomButtonPanel;
class PASCALIMPLEMENTATION TCustomButtonPanel : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TButtonItems* FButtons;
	Advdropdown::TItemLayout FButtonLayout;
	Advdropdown::TSelectionColorStyle FItemColorStyle;
	int FButtonHot;
	int FOffSetX;
	int FOffSetY;
	int FButtonOffSetX;
	int FButtonOffSetY;
	Imglist::TCustomImageList* FImages;
	int FCaptionGap;
	Stdctrls::TCustomEdit* FEdit;
	TButtonPanelType FButtonPanelType;
	TButtonAppearance* FButtonAppearance;
	int FButtonDown;
	Advdropdown::TAdvCustomDropDown* FAdvDropDown;
	TCalculatorButtonClickEvent FOnButtonClick;
	bool FIsWinXP;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall OnButtonsChanged(System::TObject* Sender);
	void __fastcall OnButtonAppearanceChanged(System::TObject* Sender);
	void __fastcall SetButtons(const TButtonItems* Value);
	void __fastcall SetButtonLayout(const Advdropdown::TItemLayout Value);
	void __fastcall SetItemColorStyle(const Advdropdown::TSelectionColorStyle Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetButtonOffSetX(const int Value);
	void __fastcall SetButtonOffSetY(const int Value);
	void __fastcall SetCaptionGap(const int Value);
	void __fastcall SetButtonHot(const int Value);
	void __fastcall SetEdit(const Stdctrls::TCustomEdit* Value);
	void __fastcall SetButtonPanelType(const TButtonPanelType Value);
	void __fastcall SetButtonAppearance(const TButtonAppearance* Value);
	void __fastcall SetButtonDown(const int Value);
	void __fastcall SetAdvDropDown(const Advdropdown::TAdvCustomDropDown* Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall Paint(void);
	void __fastcall DrawButtons(Graphics::TCanvas* aCanvas, bool DrawHot = true);
	virtual void __fastcall DrawButton(int Index, Graphics::TCanvas* aCanvas);
	virtual Types::TRect __fastcall GetInnerRect(void);
	virtual tagSIZE __fastcall GetMaxButtonSize(void);
	virtual void __fastcall ClearButtons(void);
	virtual void __fastcall ReInitialize(void);
	virtual void __fastcall Initialize(void);
	virtual void __fastcall ArrangeButtons(void);
	virtual void __fastcall InvalidateButton(int Index);
	virtual void __fastcall ButtonClick(int Index);
	int __fastcall ButtonAtPos(int X, int Y);
	Types::TRect __fastcall GetButtonRect(int Index);
	bool __fastcall DoVisualStyles(void);
	__property int ButtonOffSetX = {read=FButtonOffSetX, write=SetButtonOffSetX, default=4};
	__property int ButtonOffSetY = {read=FButtonOffSetY, write=SetButtonOffSetY, default=4};
	__property int CaptionGap = {read=FCaptionGap, write=SetCaptionGap, default=4};
	__property int ButtonHot = {read=FButtonHot, write=SetButtonHot, default=-1};
	__property int ButtonDown = {read=FButtonDown, write=SetButtonDown, default=-1};
	__property Advdropdown::TAdvCustomDropDown* AdvDropDown = {read=FAdvDropDown, write=SetAdvDropDown};
	
public:
	__fastcall virtual TCustomButtonPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomButtonPanel(void);
	__property TButtonItems* Buttons = {read=FButtons, write=SetButtons};
	__property TButtonAppearance* ButtonAppearance = {read=FButtonAppearance, write=SetButtonAppearance};
	__property Advdropdown::TItemLayout ButtonLayout = {read=FButtonLayout, write=SetButtonLayout, default=1};
	__property TButtonPanelType ButtonPanelType = {read=FButtonPanelType, write=SetButtonPanelType, default=0};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Advdropdown::TSelectionColorStyle ItemColorStyle = {read=FItemColorStyle, write=SetItemColorStyle, nodefault};
	__property Stdctrls::TCustomEdit* Edit = {read=FEdit, write=SetEdit};
	__property TCalculatorButtonClickEvent OnButtonClick = {read=FOnButtonClick, write=FOnButtonClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomButtonPanel(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvButtonPanel;
class PASCALIMPLEMENTATION TAdvButtonPanel : public TCustomButtonPanel
{
	typedef TCustomButtonPanel inherited;
	
__published:
	__property ButtonAppearance;
	__property Buttons;
	__property ButtonLayout = {default=1};
	__property ButtonPanelType = {default=0};
	__property Images;
public:
	/* TCustomButtonPanel.Create */ inline __fastcall virtual TAdvButtonPanel(Classes::TComponent* AOwner) : TCustomButtonPanel(AOwner) { }
	/* TCustomButtonPanel.Destroy */ inline __fastcall virtual ~TAdvButtonPanel(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvButtonPanel(HWND ParentWindow) : TCustomButtonPanel(ParentWindow) { }
	
};


class DELPHICLASS TAdvCalculatorDropdown;
class PASCALIMPLEMENTATION TAdvCalculatorDropdown : public Advdropdown::TAdvCustomDropDown
{
	typedef Advdropdown::TAdvCustomDropDown inherited;
	
private:
	TCustomButtonPanel* FAdvButtonPanel;
	int FDecim;
	bool FNewval;
	System::Extended FPrevval;
	int FPrevop;
	bool FCalcClosed;
	TButtonAppearance* FCalcButtonAppearance;
	System::Extended FMVal;
	bool FShowThousandSeparator;
	void __fastcall OnAdvButtonClick(System::TObject* Sender, int Index);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	void __fastcall HandleKeyPress(System::WideChar &Key);
	void __fastcall DoCalc(void);
	void __fastcall DoPlus(void);
	void __fastcall DoMin(void);
	void __fastcall DoMul(void);
	void __fastcall DoDiv(void);
	void __fastcall DoEq(void);
	void __fastcall DoPerc(void);
	System::Extended __fastcall GetValue(void);
	void __fastcall SetValue(const System::Extended Value);
	void __fastcall SetCalcButtonAppearance(const TButtonAppearance* Value);
	void __fastcall SetShowThousandSeparator(const bool Value);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &key);
	virtual void __fastcall CalcChange(void);
	virtual void __fastcall CreateDropDownForm(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall OnHideDropDown(void);
	virtual void __fastcall OnDropDownFormKeyPress(System::WideChar &Key);
	virtual void __fastcall OnDropDownFormKeyDown(System::Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall DoHideDropDown(bool Canceled);
	
public:
	__fastcall virtual TAdvCalculatorDropdown(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCalculatorDropdown(void);
	virtual void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall CalcResult(void);
	__property System::Extended Value = {read=GetValue, write=SetValue};
	
__published:
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
	__property ImeMode = {default=3};
	__property ImeName;
	__property MaxLength = {default=0};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property Precision;
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property DropDownColor = {default=16777215};
	__property DropDownBorderColor = {default=0};
	__property DropDownBorderWidth = {default=1};
	__property DropDownShadow = {default=1};
	__property DropDownWidth = {default=0};
	__property DropDownHeight = {default=0};
	__property DropPosition = {default=0};
	__property DropDownButtonWidth = {default=17};
	__property DropDownButtonHint;
	__property DropDownSizeable = {default=1};
	__property Enabled = {default=1};
	__property EditorEnabled = {default=1};
	__property Font;
	__property DropDownButtonGlyph;
	__property Images;
	__property Version;
	__property ReadOnly = {default=0};
	__property Text;
	__property ButtonAppearance;
	__property TButtonAppearance* CalcButtonAppearance = {read=FCalcButtonAppearance, write=SetCalcButtonAppearance};
	__property DropDownHeader;
	__property DropDownFooter;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property bool ShowThousandSeparator = {read=FShowThousandSeparator, write=SetShowThousandSeparator, default=0};
	__property TabStop = {default=1};
	__property TabOrder = {default=-1};
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvCalculatorDropdown(HWND ParentWindow) : Advdropdown::TAdvCustomDropDown(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt BP_BUTTONGLOWSIZE = 0x8;

}	/* namespace Advcalculatordropdown */
using namespace Advcalculatordropdown;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcalculatordropdownHPP
