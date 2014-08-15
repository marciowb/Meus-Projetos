// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advobj.pas' rev: 21.00

#ifndef AdvobjHPP
#define AdvobjHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Advxpvs.hpp>	// Pascal unit
#include <Actnlist.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advobj
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TObjStringGrid;
class PASCALIMPLEMENTATION TObjStringGrid : public Grids::TStringGrid
{
	typedef Grids::TStringGrid inherited;
	
public:
	/* TStringGrid.Create */ inline __fastcall virtual TObjStringGrid(Classes::TComponent* AOwner) : Grids::TStringGrid(AOwner) { }
	/* TStringGrid.Destroy */ inline __fastcall virtual ~TObjStringGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TObjStringGrid(HWND ParentWindow) : Grids::TStringGrid(ParentWindow) { }
	
};


#pragma option push -b-
enum TEditorType { edNormal, edSpinEdit, edComboEdit, edComboList, edEditBtn, edCheckBox, edDateEdit, edDateEditUpDown, edTimeEdit, edButton, edDataCheckBox, edNumeric, edPositiveNumeric, edFloat, edCapital, edMixedCase, edPassword, edUnitEditBtn, edLowerCase, edUpperCase, edFloatSpinEdit, edTimeSpinEdit, edDateSpinEdit, edNumericEditBtn, edFloatEditBtn, edCustom, edRichEdit, edNone, edDateTimeEdit, edValidChars, edTrackbarDropDown, edMemoDropDown, edCalculatorDropDown, edTimePickerDropDown, edDetailDropDown, edGridDropDown, edColorPickerDropDown, edImagePickerDropDown, edAdvGridDropDown };
#pragma option pop

#pragma option push -b-
enum TCellBorder { cbTop, cbLeft, cbRight, cbBottom };
#pragma option pop

typedef Set<TCellBorder, cbTop, cbBottom>  TCellBorders;

#pragma option push -b-
enum TCellGradientDirection { GradientVertical, GradientHorizontal };
#pragma option pop

typedef void __fastcall (__closure *TGetDisplTextEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &Value);

typedef void __fastcall (__closure *TFloatFormatEvent)(System::TObject* Sender, int ACol, int ARow, bool &IsFloat, System::UnicodeString &FloatFormat);

typedef void __fastcall (__closure *TOnResizeEvent)(System::TObject* Sender);

typedef void __fastcall (__closure *TColumnSizeEvent)(System::TObject* Sender, int ACol, bool &Allow);

typedef void __fastcall (__closure *TColumnSizingEvent)(System::TObject* Sender, int ACol, int ColumnSize);

typedef void __fastcall (__closure *TRowSizingEvent)(System::TObject* Sender, int ARow, int RowSize);

typedef void __fastcall (__closure *TRowSizeEvent)(System::TObject* Sender, int ARow, bool &Allow);

typedef void __fastcall (__closure *TEndColumnSizeEvent)(System::TObject* Sender, int ACol);

typedef void __fastcall (__closure *TUpdateColumnSizeEvent)(System::TObject* Sender, int ACol, int &AWidth);

typedef void __fastcall (__closure *TEndRowSizeEvent)(System::TObject* Sender, int ARow);

typedef void __fastcall (__closure *TClickCellEvent)(System::TObject* Sender, int ARow, int ACol);

typedef void __fastcall (__closure *TDblClickCellEvent)(System::TObject* Sender, int ARow, int ACol);

typedef void __fastcall (__closure *TCanEditCellEvent)(System::TObject* Sender, int ARow, int ACol, bool &CanEdit);

typedef void __fastcall (__closure *TScrollHintEvent)(System::TObject* Sender, int ARow, System::UnicodeString &hintstr);

typedef void __fastcall (__closure *TButtonClickEvent)(System::TObject* Sender, int ACol, int ARow);

typedef void __fastcall (__closure *TCheckBoxClickEvent)(System::TObject* Sender, int ACol, int ARow, bool State);

typedef void __fastcall (__closure *TGetEditorTypeEvent)(System::TObject* Sender, int ACol, int ARow, TEditorType &AEditor);

#pragma option push -b-
enum TSortStyle { ssAutomatic, ssAlphabetic, ssNumeric, ssDate, ssAlphaNoCase, ssAlphaCase, ssShortDateEU, ssShortDateUS, ssCustom, ssFinancial, ssAnsiAlphaCase, ssAnsiAlphaNoCase, ssRaw, ssHTML, ssImages, ssCheckBox, ssDateTime, ssTime, ssAlphaNumeric, ssAlphaNumericNoCase };
#pragma option pop

#pragma option push -b-
enum TVAlignment { vtaTop, vtaCenter, vtaBottom };
#pragma option pop

typedef void __fastcall (__closure *TCustomCellDrawEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, int ACol, int ARow, Grids::TGridDrawState AState, const Types::TRect &ARect, bool Printing);

typedef TVAlignment TAsgVAlignment;

typedef void __fastcall (__closure *TAnchorClickEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString Anchor, bool &AutoHandle);

typedef void __fastcall (__closure *TAnchorHintEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString &Anchor);

typedef void __fastcall (__closure *TAnchorEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString Anchor);

typedef void __fastcall (__closure *TClickSortEvent)(System::TObject* Sender, int ACol);

typedef void __fastcall (__closure *TCanSortEvent)(System::TObject* Sender, int ACol, bool &DoSort);

typedef void __fastcall (__closure *TCustomCompareEvent)(System::TObject* Sender, System::UnicodeString str1, System::UnicodeString str2, int &Res);

typedef void __fastcall (__closure *TRawCompareEvent)(System::TObject* Sender, int ACol, int Row1, int Row2, int &Res);

typedef void __fastcall (__closure *TGridFormatEvent)(System::TObject* Sender, int ACol, TSortStyle &AStyle, System::UnicodeString &aPrefix, System::UnicodeString &aSuffix);

typedef void __fastcall (__closure *TGridColorEvent)(System::TObject* Sender, int ARow, int ACol, Grids::TGridDrawState AState, Graphics::TBrush* ABrush, Graphics::TFont* AFont);

typedef void __fastcall (__closure *TGridGradientEvent)(System::TObject* Sender, int ARow, int ACol, Graphics::TColor &Color, Graphics::TColor &ColorTo, Graphics::TColor &ColorMirror, Graphics::TColor &ColorMirrorTo, TCellGradientDirection &GD);

typedef void __fastcall (__closure *TGridBorderEvent)(System::TObject* Sender, int ARow, int ACol, Graphics::TPen* APen, TCellBorders &Borders);

typedef void __fastcall (__closure *TGridBorderPropEvent)(System::TObject* Sender, int ARow, int ACol, Graphics::TPen* LeftPen, Graphics::TPen* TopPen, Graphics::TPen* RightPen, Graphics::TPen* BottomPen);

typedef void __fastcall (__closure *TGridAlignEvent)(System::TObject* Sender, int ARow, int ACol, Classes::TAlignment &HAlign, TVAlignment &VAlign);

typedef void __fastcall (__closure *TGridHintEvent)(System::TObject* Sender, int ARow, int ACol, System::UnicodeString &hintstr);

typedef void __fastcall (__closure *TEllipsClickEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &S);

typedef void __fastcall (__closure *TGridBalloonEvent)(System::TObject* Sender, int ACol, int ARow, System::UnicodeString &ATitle, System::UnicodeString &AText, int &AIcon);

typedef void __fastcall (__closure *TCanInsertRowEvent)(System::TObject* Sender, int ARow, bool &CanInsert);

typedef void __fastcall (__closure *TAutoInsertRowEvent)(System::TObject* Sender, int ARow);

typedef void __fastcall (__closure *TCanAddRowEvent)(System::TObject* Sender, bool &CanAdd);

typedef void __fastcall (__closure *TAutoAddRowEvent)(System::TObject* Sender, int ARow);

typedef void __fastcall (__closure *TCanDeleteRowEvent)(System::TObject* Sender, int ARow, bool &CanDelete);

typedef void __fastcall (__closure *TAutoDeleteRowEvent)(System::TObject* Sender, int ARow);

typedef void __fastcall (__closure *TAutoInsertColEvent)(System::TObject* Sender, int ACol);

typedef void __fastcall (__closure *TSearchEditChangeEvent)(System::TObject* Sender, System::UnicodeString Value, bool &DefaultSearch);

typedef void __fastcall (__closure *TSpinClickEvent)(System::TObject* Sender, int ACol, int ARow, int AValue, bool UpDown);

typedef void __fastcall (__closure *TOfficeHintEvent)(System::TObject* Sender, int ACol, int ARow, Advhintinfo::TAdvHintInfo* OfficeHint);

#pragma option push -b-
enum TArrowDirection { arrUp, arrDown, arrLeft, arrRight };
#pragma option pop

#pragma option push -b-
enum TAdvGridButtonStyle { tasButton, tasCheck };
#pragma option pop

typedef void __fastcall (__closure *TImageChangeEvent)(System::TObject* Sender, int Acol, int Arow);

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


class DELPHICLASS TPopupButton;
class PASCALIMPLEMENTATION TPopupButton : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	System::UnicodeString FCaption;
	Imglist::TCustomImageList* FImages;
	bool FFlat;
	Graphics::TColor FGradTo;
	Graphics::TColor FGradFrom;
	Graphics::TColor FGradMirrorTo;
	Graphics::TColor FGradMirrorFrom;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TPopupButton(Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateWnd(void);
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property bool Flat = {read=FFlat, write=FFlat, nodefault};
	__property Graphics::TColor GradFrom = {read=FGradFrom, write=FGradFrom, nodefault};
	__property Graphics::TColor GradTo = {read=FGradTo, write=FGradTo, nodefault};
	__property Graphics::TColor GradMirrorFrom = {read=FGradMirrorFrom, write=FGradMirrorFrom, nodefault};
	__property Graphics::TColor GradMirrorTo = {read=FGradMirrorTo, write=FGradMirrorTo, nodefault};
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TPopupButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPopupButton(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TIntList;
class PASCALIMPLEMENTATION TIntList : public Classes::TList
{
	typedef Classes::TList inherited;
	
public:
	int operator[](int index) { return Items[index]; }
	
private:
	TImageChangeEvent FOnChange;
	int FCol;
	int FRow;
	void __fastcall SetInteger(int Index, int Value);
	int __fastcall GetInteger(int Index);
	System::UnicodeString __fastcall GetStrValue(void);
	void __fastcall SetStrValue(const System::UnicodeString Value);
	
public:
	__fastcall TIntList(int Col, int Row);
	void __fastcall DeleteValue(int Value);
	bool __fastcall HasValue(int Value);
	__property int Items[int index] = {read=GetInteger, write=SetInteger/*, default*/};
	HIDESBASE void __fastcall Add(int Value);
	HIDESBASE void __fastcall Insert(int Index, int Value);
	HIDESBASE void __fastcall Delete(int Index);
	__property System::UnicodeString StrValue = {read=GetStrValue, write=SetStrValue};
	__property TImageChangeEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TList.Destroy */ inline __fastcall virtual ~TIntList(void) { }
	
};


class DELPHICLASS TSortIndexList;
class PASCALIMPLEMENTATION TSortIndexList : public TIntList
{
	typedef TIntList inherited;
	
private:
	int __fastcall GetSortColumns(int i);
	bool __fastcall GetSortDirections(int i);
	void __fastcall SetSortColumns(int i, const int Value);
	void __fastcall SetSortDirections(int i, const bool Value);
	
public:
	System::UnicodeString __fastcall SaveToString(void);
	void __fastcall LoadFromString(System::UnicodeString s);
	void __fastcall AddIndex(int ColumnIndex, bool Ascending);
	int __fastcall FindIndex(int ColumnIndex);
	void __fastcall ToggleIndex(int ColumnIndex);
	__property int SortColumns[int i] = {read=GetSortColumns, write=SetSortColumns};
	__property bool SortDirections[int i] = {read=GetSortDirections, write=SetSortDirections};
public:
	/* TIntList.Create */ inline __fastcall TSortIndexList(int Col, int Row) : TIntList(Col, Row) { }
	
public:
	/* TList.Destroy */ inline __fastcall virtual ~TSortIndexList(void) { }
	
};


class DELPHICLASS TControlItem;
class PASCALIMPLEMENTATION TControlItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FX;
	int FY;
	Controls::TControl* FObject;
	
public:
	__fastcall TControlItem(int AX, int AY, Controls::TControl* AObject);
	__property int X = {read=FX, write=FX, nodefault};
	__property int Y = {read=FY, write=FY, nodefault};
	__property Controls::TControl* Control = {read=FObject, write=FObject};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TControlItem(void) { }
	
};


class DELPHICLASS TControlList;
class PASCALIMPLEMENTATION TControlList : public Classes::TList
{
	typedef Classes::TList inherited;
	
private:
	TControlItem* __fastcall GetControl(int i);
	
public:
	void __fastcall AddControl(int X, int Y, Controls::TControl* AObject);
	void __fastcall RemoveControl(int i);
	int __fastcall ControlIndex(int X, int Y);
	__property TControlItem* Control[int i] = {read=GetControl};
	__fastcall virtual ~TControlList(void);
	bool __fastcall HasHandle(unsigned Handle);
public:
	/* TObject.Create */ inline __fastcall TControlList(void) : Classes::TList() { }
	
};


class DELPHICLASS TFilePicture;
class PASCALIMPLEMENTATION TFilePicture : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FFilename;
	int FWidth;
	int FHeight;
	Graphics::TPicture* FPicture;
	void __fastcall SetFileName(const System::UnicodeString Value);
	
public:
	void __fastcall DrawPicture(Graphics::TCanvas* Canvas, const Types::TRect &r);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Filename = {read=FFilename, write=SetFileName};
	__property int Width = {read=FWidth, nodefault};
	__property int Height = {read=FHeight, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TFilePicture(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TFilePicture(void) : Classes::TPersistent() { }
	
};


class DELPHICLASS TAdvGridButtonActionLink;
class DELPHICLASS TAdvGridButton;
class PASCALIMPLEMENTATION TAdvGridButtonActionLink : public Controls::TControlActionLink
{
	typedef Controls::TControlActionLink inherited;
	
protected:
	TAdvGridButton* FClient;
	virtual void __fastcall AssignClient(System::TObject* AClient);
	virtual bool __fastcall IsCaptionLinked(void);
	virtual bool __fastcall IsCheckedLinked(void);
	virtual bool __fastcall IsGroupIndexLinked(void);
	virtual void __fastcall SetGroupIndex(int Value);
	virtual void __fastcall SetChecked(bool Value);
	virtual void __fastcall SetCaption(const System::UnicodeString Value);
public:
	/* TBasicActionLink.Create */ inline __fastcall virtual TAdvGridButtonActionLink(System::TObject* AClient) : Controls::TControlActionLink(AClient) { }
	/* TBasicActionLink.Destroy */ inline __fastcall virtual ~TAdvGridButtonActionLink(void) { }
	
};


class PASCALIMPLEMENTATION TAdvGridButton : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FIsComCtl6;
	int FGroupIndex;
	Graphics::TBitmap* FGlyph;
	bool FDown;
	bool FDragging;
	bool FAllowAllUp;
	Buttons::TButtonLayout FLayout;
	int FSpacing;
	bool FTransparent;
	int FMargin;
	bool FFlat;
	bool FMouseInControl;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBorderDownColor;
	Graphics::TColor FBorderHotColor;
	Graphics::TBitmap* FGlyphDisabled;
	Graphics::TBitmap* FGlyphHot;
	Graphics::TBitmap* FGlyphDown;
	Graphics::TBitmap* FGlyphShade;
	bool FShaded;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	Graphics::TColor FColorChecked;
	Graphics::TColor FColorCheckedTo;
	TAdvGridButtonStyle FStyle;
	int FLook;
	bool FRounded;
	bool FDropDownButton;
	bool FAutoThemeAdapt;
	bool FAutoXPStyle;
	Classes::TNotifyEvent FOnDropDown;
	Menus::TPopupMenu* FDropDownMenu;
	bool FShowCaption;
	void __fastcall GlyphChanged(System::TObject* Sender);
	void __fastcall UpdateExclusive(void);
	void __fastcall SetGlyph(Graphics::TBitmap* Value);
	void __fastcall SetDown(bool Value);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetAllowAllUp(bool Value);
	void __fastcall SetGroupIndex(int Value);
	void __fastcall SetLayout(Buttons::TButtonLayout Value);
	void __fastcall SetSpacing(int Value);
	void __fastcall SetMargin(int Value);
	void __fastcall UpdateTracking(void);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMButtonPressed(Messages::TMessage &Message);
	MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMSysColorChange(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall SetGlyphDisabled(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphDown(const Graphics::TBitmap* Value);
	void __fastcall SetGlyphHot(const Graphics::TBitmap* Value);
	void __fastcall GenerateShade(void);
	void __fastcall SetShaded(const bool Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetColorChecked(const Graphics::TColor Value);
	void __fastcall SetColorCheckedTo(const Graphics::TColor Value);
	void __fastcall SetStyle(const TAdvGridButtonStyle Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetDropDownButton(const bool Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetLook(const int Value);
	Graphics::TColor __fastcall GetColor(void);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	
protected:
	Buttons::TButtonState FState;
	DYNAMIC Controls::TControlActionLinkClass __fastcall GetActionLinkClass(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall DrawButtonGlyph(Graphics::TCanvas* Canvas, const Types::TPoint &GlyphPos, Buttons::TButtonState State, bool Transparent);
	void __fastcall DrawButtonText(Graphics::TCanvas* Canvas, const System::UnicodeString Caption, const Types::TRect &TextBounds, Buttons::TButtonState State, int BiDiFlags);
	Types::TRect __fastcall DrawButton(Graphics::TCanvas* Canvas, const Types::TRect &Client, const Types::TPoint &Offset, const System::UnicodeString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, Buttons::TButtonState State, bool Transparent, int BiDiFlags);
	void __fastcall CalcButtonLayout(Graphics::TCanvas* Canvas, const Types::TRect &Client, const Types::TPoint &Offset, const System::UnicodeString Caption, Buttons::TButtonLayout Layout, int Margin, int Spacing, Types::TPoint &GlyphPos, Types::TRect &TextBounds, int BiDiFlags);
	virtual void __fastcall Paint(void);
	__property bool MouseInControl = {read=FMouseInControl, nodefault};
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall ThemeAdapt(void);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	
public:
	__fastcall virtual TAdvGridButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvGridButton(void);
	DYNAMIC void __fastcall Click(void);
	__property int Look = {read=FLook, write=SetLook, nodefault};
	
__published:
	__property Action;
	__property bool AllowAllUp = {read=FAllowAllUp, write=SetAllowAllUp, default=0};
	__property Anchors = {default=3};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, nodefault};
	__property bool AutoXPStyle = {read=FAutoXPStyle, write=FAutoXPStyle, nodefault};
	__property BiDiMode;
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=536870911};
	__property Graphics::TColor BorderDownColor = {read=FBorderDownColor, write=FBorderDownColor, default=536870911};
	__property Graphics::TColor BorderHotColor = {read=FBorderHotColor, write=FBorderHotColor, default=536870911};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, default=-16777201};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=536870911};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=FColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=FColorDownTo, default=536870911};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=FColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=FColorHotTo, default=536870911};
	__property Graphics::TColor ColorChecked = {read=FColorChecked, write=SetColorChecked, default=8421504};
	__property Graphics::TColor ColorCheckedTo = {read=FColorCheckedTo, write=SetColorCheckedTo, default=536870911};
	__property Constraints;
	__property int GroupIndex = {read=FGroupIndex, write=SetGroupIndex, default=0};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	__property bool DropDownButton = {read=FDropDownButton, write=SetDropDownButton, default=0};
	__property Menus::TPopupMenu* DropDownMenu = {read=FDropDownMenu, write=FDropDownMenu};
	__property Caption;
	__property Enabled = {default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=1};
	__property Font;
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property Graphics::TBitmap* GlyphHot = {read=FGlyphHot, write=SetGlyphHot};
	__property Graphics::TBitmap* GlyphDown = {read=FGlyphDown, write=SetGlyphDown};
	__property Graphics::TBitmap* GlyphDisabled = {read=FGlyphDisabled, write=SetGlyphDisabled};
	__property Buttons::TButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property bool Rounded = {read=FRounded, write=SetRounded, default=0};
	__property bool Shaded = {read=FShaded, write=SetShaded, default=1};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property ShowHint;
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
	__property TAdvGridButtonStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
};


class DELPHICLASS TFileStringList;
class PASCALIMPLEMENTATION TFileStringList : public Classes::TStringList
{
	typedef Classes::TStringList inherited;
	
private:
	int fp;
	System::UnicodeString cache;
	bool __fastcall GetEOF(void);
	
public:
	void __fastcall Reset(void);
	void __fastcall ReadLn(System::UnicodeString &s);
	void __fastcall Write(System::UnicodeString s);
	void __fastcall WriteLn(System::UnicodeString s);
	__property bool Eof = {read=GetEOF, nodefault};
public:
	/* TStringList.Create */ inline __fastcall TFileStringList(void)/* overload */ : Classes::TStringList() { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TFileStringList(void) { }
	
};


class DELPHICLASS TAdvCheckBox;
class PASCALIMPLEMENTATION TAdvCheckBox : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FDown;
	Stdctrls::TCheckBoxState FState;
	bool FFocused;
	bool FReturnIsTab;
	Stdctrls::TTextLayout FBtnVAlign;
	Classes::TAlignment FAlignment;
	bool FEllipsis;
	System::UnicodeString FCaption;
	bool FIsWinXP;
	bool FHot;
	bool FClicksDisabled;
	bool FReadOnly;
	bool FMouseDown;
	Graphics::TBitmap* FBkgBmp;
	bool FBkgCache;
	bool FTransparentCaching;
	bool FTransparent;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	void __fastcall SetState(Stdctrls::TCheckBoxState Value);
	void __fastcall SetChecked(bool Value);
	bool __fastcall GetChecked(void);
	void __fastcall SetCaption(System::UnicodeString Value);
	void __fastcall SetButtonVertAlign(const Stdctrls::TTextLayout Value);
	void __fastcall SetAlignment(const Classes::TLeftRight Value);
	void __fastcall SetEllipsis(const bool Value);
	void __fastcall DrawParentImage(Controls::TControl* Control, Graphics::TCanvas* Dest);
	void __fastcall SetTransparent(bool value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall SetDown(bool Value);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	__property bool ClicksDisabled = {read=FClicksDisabled, write=FClicksDisabled, nodefault};
	
public:
	__fastcall virtual TAdvCheckBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCheckBox(void);
	virtual void __fastcall Toggle(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	__property bool TransparentChaching = {read=FTransparentCaching, write=FTransparentCaching, nodefault};
	__property bool Down = {read=FDown, write=SetDown, default=0};
	
__published:
	__property Action;
	__property Anchors = {default=3};
	__property Constraints;
	__property Color = {default=-16777211};
	__property Classes::TLeftRight Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Stdctrls::TTextLayout ButtonVertAlign = {read=FBtnVAlign, write=SetButtonVertAlign, default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool Checked = {read=GetChecked, write=SetChecked, default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property bool Ellipsis = {read=FEllipsis, write=SetEllipsis, default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentFont = {default=1};
	__property ParentColor = {default=1};
	__property PopupMenu;
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property bool ReturnIsTab = {read=FReturnIsTab, write=FReturnIsTab, nodefault};
	__property ShowHint;
	__property Stdctrls::TCheckBoxState State = {read=FState, write=SetState, default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCheckBox(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


#pragma option push -b-
enum TSearchDirection { sdTopBottom, sdLeftRight };
#pragma option pop

class DELPHICLASS TSearchFooter;
class PASCALIMPLEMENTATION TSearchFooter : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FShowFindPrev;
	bool FShowFindNext;
	System::UnicodeString FFindNextCaption;
	System::UnicodeString FFindPrevCaption;
	Graphics::TColor FColorTo;
	Graphics::TColor FColor;
	Classes::TNotifyEvent FOnChange;
	bool FVisible;
	bool FAutoThemeAdapt;
	bool FShowClose;
	bool FShowHighLight;
	bool FShowMatchCase;
	System::UnicodeString FMatchCaseCaption;
	System::UnicodeString FHintClose;
	System::UnicodeString FHintFindPrev;
	System::UnicodeString FHintHighLight;
	System::UnicodeString FHintFindNext;
	bool FAutoSearch;
	System::UnicodeString FLastSearch;
	int FSearchColumn;
	bool FSearchActiveColumnOnly;
	bool FSearchMatchStart;
	bool FSearchFixedCells;
	bool FSearchHiddenRows;
	System::UnicodeString FHighLightCaption;
	bool FAlwaysHighLight;
	TSearchDirection FSearchDirection;
	Graphics::TFont* FFont;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetFindNextCaption(const System::UnicodeString Value);
	void __fastcall SetFindPrevCaption(const System::UnicodeString Value);
	void __fastcall SetShowFindNext(const bool Value);
	void __fastcall SetShowFindPrev(const bool Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetAutoThemeAdapt(const bool Value);
	void __fastcall SetShowClose(const bool Value);
	void __fastcall SetShowHighLight(const bool Value);
	void __fastcall SetShowMatchCase(const bool Value);
	void __fastcall SetMatchCaseCaption(const System::UnicodeString Value);
	void __fastcall SetHintClose(const System::UnicodeString Value);
	void __fastcall SetHintFindNext(const System::UnicodeString Value);
	void __fastcall SetHintFindPrev(const System::UnicodeString Value);
	void __fastcall SetHintHighlight(const System::UnicodeString Value);
	void __fastcall SetHighLightCaption(const System::UnicodeString Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TSearchFooter(Classes::TComponent* AOwner);
	__fastcall virtual ~TSearchFooter(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=SetAutoThemeAdapt, nodefault};
	__property System::UnicodeString LastSearch = {read=FLastSearch, write=FLastSearch};
	
__published:
	__property bool AlwaysHighLight = {read=FAlwaysHighLight, write=FAlwaysHighLight, default=0};
	__property bool AutoSearch = {read=FAutoSearch, write=FAutoSearch, default=1};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=16777215};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=-16777201};
	__property System::UnicodeString FindNextCaption = {read=FFindNextCaption, write=SetFindNextCaption};
	__property System::UnicodeString FindPrevCaption = {read=FFindPrevCaption, write=SetFindPrevCaption};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString HighLightCaption = {read=FHighLightCaption, write=SetHighLightCaption};
	__property System::UnicodeString HintClose = {read=FHintClose, write=SetHintClose};
	__property System::UnicodeString HintFindNext = {read=FHintFindNext, write=SetHintFindNext};
	__property System::UnicodeString HintFindPrev = {read=FHintFindPrev, write=SetHintFindPrev};
	__property System::UnicodeString HintHighlight = {read=FHintHighLight, write=SetHintHighlight};
	__property System::UnicodeString MatchCaseCaption = {read=FMatchCaseCaption, write=SetMatchCaseCaption};
	__property bool SearchActiveColumnOnly = {read=FSearchActiveColumnOnly, write=FSearchActiveColumnOnly, default=0};
	__property int SearchColumn = {read=FSearchColumn, write=FSearchColumn, default=-1};
	__property bool SearchMatchStart = {read=FSearchMatchStart, write=FSearchMatchStart, default=0};
	__property bool SearchFixedCells = {read=FSearchFixedCells, write=FSearchFixedCells, default=0};
	__property bool SearchHiddenRows = {read=FSearchHiddenRows, write=FSearchHiddenRows, default=0};
	__property TSearchDirection SearchDirection = {read=FSearchDirection, write=FSearchDirection, default=0};
	__property bool ShowClose = {read=FShowClose, write=SetShowClose, default=1};
	__property bool ShowFindNext = {read=FShowFindNext, write=SetShowFindNext, default=1};
	__property bool ShowFindPrev = {read=FShowFindPrev, write=SetShowFindPrev, default=1};
	__property bool ShowHighLight = {read=FShowHighLight, write=SetShowHighLight, default=1};
	__property bool ShowMatchCase = {read=FShowMatchCase, write=SetShowMatchCase, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum THomeEndAction { heFirstLastColumn, heFirstLastRow };
#pragma option pop

#pragma option push -b-
enum TClipboardPasteAction { paReplace, paInsert };
#pragma option pop

#pragma option push -b-
enum TAdvanceDirection { adLeftRight, adTopBottom };
#pragma option pop

#pragma option push -b-
enum TInsertPosition { pInsertBefore, pInsertAfter };
#pragma option pop

class DELPHICLASS TNavigation;
class PASCALIMPLEMENTATION TNavigation : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FAllowInsertRow;
	bool FAllowDeleteRow;
	bool FAdvanceOnEnter;
	bool FAdvanceInsert;
	bool FAutoGotoWhenSorted;
	bool FAutoGotoIncremental;
	bool FAutoComboDropSize;
	bool FAllowClipboardShortcuts;
	bool FAllowRTFClipboard;
	bool FAllowSmartClipboard;
	bool FAllowClipboardAlways;
	bool FAllowClipboardColGrow;
	bool FAllowClipboardRowGrow;
	TClipboardPasteAction FClipboardPasteAction;
	bool FCopyHTMLTagsToClipboard;
	TAdvanceDirection FAdvanceDirection;
	bool FAdvanceAuto;
	bool FAdvanceAutoEdit;
	bool FCursorWalkEditor;
	bool FCursorWalkAlwaysEdit;
	bool FMoveRowOnSort;
	bool FKeepScrollOnSort;
	bool FImproveMaskSel;
	bool FAlwaysEdit;
	TInsertPosition FInsertPosition;
	bool FLineFeedOnEnter;
	THomeEndAction FHomeEndKey;
	bool FKeepHorizScroll;
	bool FAllowFMTClipboard;
	bool FTabToNextAtEnd;
	bool FEditSelectAll;
	TAdvanceDirection FTabAdvanceDirection;
	bool FSkipFixedCells;
	bool FSkipDisabledRows;
	bool FAllowCtrlEnter;
	bool FAppendOnArrowDown;
	bool FLeftRightRowSelect;
	bool FMoveScrollOnly;
	bool FComboGetUpdown;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetAutoGoto(bool aValue);
	void __fastcall SetAdvanceDirection(const TAdvanceDirection Value);
	void __fastcall SetAdvanceInsert(const bool Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TNavigation(void);
	__fastcall virtual ~TNavigation(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property bool AllowInsertRow = {read=FAllowInsertRow, write=FAllowInsertRow, default=0};
	__property bool AllowDeleteRow = {read=FAllowDeleteRow, write=FAllowDeleteRow, default=0};
	__property bool AlwaysEdit = {read=FAlwaysEdit, write=FAlwaysEdit, default=0};
	__property bool AdvanceOnEnter = {read=FAdvanceOnEnter, write=FAdvanceOnEnter, default=0};
	__property bool AdvanceInsert = {read=FAdvanceInsert, write=SetAdvanceInsert, default=0};
	__property bool AdvanceAutoEdit = {read=FAdvanceAutoEdit, write=FAdvanceAutoEdit, default=1};
	__property bool AutoGotoWhenSorted = {read=FAutoGotoWhenSorted, write=SetAutoGoto, default=0};
	__property bool AutoGotoIncremental = {read=FAutoGotoIncremental, write=FAutoGotoIncremental, default=0};
	__property bool AutoComboDropSize = {read=FAutoComboDropSize, write=FAutoComboDropSize, default=0};
	__property TAdvanceDirection AdvanceDirection = {read=FAdvanceDirection, write=SetAdvanceDirection, default=0};
	__property bool AllowClipboardShortCuts = {read=FAllowClipboardShortcuts, write=FAllowClipboardShortcuts, default=0};
	__property bool AllowCtrlEnter = {read=FAllowCtrlEnter, write=FAllowCtrlEnter, default=1};
	__property bool AllowSmartClipboard = {read=FAllowSmartClipboard, write=FAllowSmartClipboard, default=0};
	__property bool AllowRTFClipboard = {read=FAllowRTFClipboard, write=FAllowRTFClipboard, default=0};
	__property bool AllowFmtClipboard = {read=FAllowFMTClipboard, write=FAllowFMTClipboard, default=0};
	__property bool AllowClipboardAlways = {read=FAllowClipboardAlways, write=FAllowClipboardAlways, default=0};
	__property bool AllowClipboardRowGrow = {read=FAllowClipboardRowGrow, write=FAllowClipboardRowGrow, default=1};
	__property bool AllowClipboardColGrow = {read=FAllowClipboardColGrow, write=FAllowClipboardColGrow, default=1};
	__property bool AdvanceAuto = {read=FAdvanceAuto, write=FAdvanceAuto, default=0};
	__property bool AppendOnArrowDown = {read=FAppendOnArrowDown, write=FAppendOnArrowDown, default=0};
	__property bool EditSelectAll = {read=FEditSelectAll, write=FEditSelectAll, default=1};
	__property TInsertPosition InsertPosition = {read=FInsertPosition, write=FInsertPosition, default=0};
	__property TClipboardPasteAction ClipboardPasteAction = {read=FClipboardPasteAction, write=FClipboardPasteAction, default=0};
	__property bool ComboGetUpDown = {read=FComboGetUpdown, write=FComboGetUpdown, default=1};
	__property bool CursorWalkEditor = {read=FCursorWalkEditor, write=FCursorWalkEditor, default=0};
	__property bool CursorWalkAlwaysEdit = {read=FCursorWalkAlwaysEdit, write=FCursorWalkAlwaysEdit, default=1};
	__property bool MoveRowOnSort = {read=FMoveRowOnSort, write=FMoveRowOnSort, default=0};
	__property bool KeepScrollOnSort = {read=FKeepScrollOnSort, write=FKeepScrollOnSort, default=0};
	__property bool MoveScrollOnly = {read=FMoveScrollOnly, write=FMoveScrollOnly, default=0};
	__property bool ImproveMaskSel = {read=FImproveMaskSel, write=FImproveMaskSel, default=0};
	__property bool LeftRightRowSelect = {read=FLeftRightRowSelect, write=FLeftRightRowSelect, default=1};
	__property bool CopyHTMLTagsToClipboard = {read=FCopyHTMLTagsToClipboard, write=FCopyHTMLTagsToClipboard, default=1};
	__property bool KeepHorizScroll = {read=FKeepHorizScroll, write=FKeepHorizScroll, default=0};
	__property bool LineFeedOnEnter = {read=FLineFeedOnEnter, write=FLineFeedOnEnter, default=0};
	__property THomeEndAction HomeEndKey = {read=FHomeEndKey, write=FHomeEndKey, default=0};
	__property bool SkipFixedCells = {read=FSkipFixedCells, write=FSkipFixedCells, default=1};
	__property bool SkipDisabledRows = {read=FSkipDisabledRows, write=FSkipDisabledRows, default=1};
	__property bool TabToNextAtEnd = {read=FTabToNextAtEnd, write=FTabToNextAtEnd, default=0};
	__property TAdvanceDirection TabAdvanceDirection = {read=FTabAdvanceDirection, write=FTabAdvanceDirection, default=0};
};


#pragma option push -b-
enum TGridFixedCellEdit { fceNone, fceDblClick, fceLeftClick, fceRightClick };
#pragma option pop

#pragma option push -b-
enum TWheelAction { waMoveSelection, waScroll };
#pragma option pop

typedef void __fastcall (__closure *TIsDesigningEvent)(System::TObject* Sender, bool &IsDesigning);

class DELPHICLASS TMouseActions;
class PASCALIMPLEMENTATION TMouseActions : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FColSelect;
	bool FRowSelect;
	bool FAllSelect;
	bool FDirectEdit;
	bool FDirectComboDrop;
	bool FDirectComboClose;
	bool FDirectDateClose;
	bool FDirectDateDrop;
	bool FDisjunctRowSelect;
	bool FDisjunctColSelect;
	bool FAllColumnSize;
	bool FAllRowSize;
	bool FCaretPositioning;
	bool FSizeFixedCol;
	bool FSizeFixedRow;
	bool FDisjunctCellSelect;
	TGridFixedCellEdit FFixedRowsEdit;
	TGridFixedCellEdit FFixedColsEdit;
	bool FHotmailRowSelect;
	bool FRangeSelectAndEdit;
	bool FNoAutoRangeScroll;
	bool FPreciseCheckBoxCheck;
	bool FPreciseNodeClick;
	bool FCheckAllCheck;
	bool FNodeAllExpandContract;
	bool FMoveRowOnNodeClick;
	bool FRowSelectPersistent;
	bool FSelectOnRightClick;
	bool FNoScrollOnPartialRow;
	int FWheelIncrement;
	TWheelAction FWheelAction;
	bool FAutoSizeColOnDblClick;
	bool FEditOnDblClickOnly;
	bool FDisjunctRowSelectNoCtrl;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnInvalidate;
	TIsDesigningEvent FOnIsDesigning;
	Classes::TNotifyEvent FOnDisableEdit;
	void __fastcall SetDisjunctColSelect(const bool AValue);
	void __fastcall SetDisjunctRowSelect(const bool AValue);
	void __fastcall SetDisjunctCellSelect(const bool AValue);
	void __fastcall SetHotmailRowSelect(const bool AValue);
	void __fastcall SetEditOnDblClickOnly(const bool AValue);
	void __fastcall SetWheelAction(const TWheelAction Value);
	
protected:
	void __fastcall Changed(void);
	bool __fastcall IsDesigning(void);
	
public:
	__fastcall TMouseActions(Classes::TComponent* AOwner);
	__fastcall virtual ~TMouseActions(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property bool DisjunctRowSelectDirect = {read=FDisjunctRowSelect, write=FDisjunctRowSelect, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TIsDesigningEvent OnIsDesigning = {read=FOnIsDesigning, write=FOnIsDesigning};
	__property Classes::TNotifyEvent OnInvalidate = {read=FOnInvalidate, write=FOnInvalidate};
	__property Classes::TNotifyEvent OnDisableEdit = {read=FOnDisableEdit, write=FOnDisableEdit};
	
__published:
	__property bool AllColumnSize = {read=FAllColumnSize, write=FAllColumnSize, default=0};
	__property bool AllRowSize = {read=FAllRowSize, write=FAllRowSize, default=0};
	__property bool AllSelect = {read=FAllSelect, write=FAllSelect, default=0};
	__property bool AutoSizeColOnDblClick = {read=FAutoSizeColOnDblClick, write=FAutoSizeColOnDblClick, default=1};
	__property bool CaretPositioning = {read=FCaretPositioning, write=FCaretPositioning, default=0};
	__property bool CheckAllCheck = {read=FCheckAllCheck, write=FCheckAllCheck, default=0};
	__property bool ColSelect = {read=FColSelect, write=FColSelect, default=0};
	__property bool DirectComboClose = {read=FDirectComboClose, write=FDirectComboClose, default=0};
	__property bool DirectComboDrop = {read=FDirectComboDrop, write=FDirectComboDrop, default=0};
	__property bool DirectDateClose = {read=FDirectDateClose, write=FDirectDateClose, default=0};
	__property bool DirectDateDrop = {read=FDirectDateDrop, write=FDirectDateDrop, default=0};
	__property bool DirectEdit = {read=FDirectEdit, write=FDirectEdit, default=0};
	__property bool DisjunctRowSelect = {read=FDisjunctRowSelect, write=SetDisjunctRowSelect, default=0};
	__property bool DisjunctRowSelectNoCtrl = {read=FDisjunctRowSelectNoCtrl, write=FDisjunctRowSelectNoCtrl, default=0};
	__property bool DisjunctColSelect = {read=FDisjunctColSelect, write=SetDisjunctColSelect, default=0};
	__property bool DisjunctCellSelect = {read=FDisjunctCellSelect, write=SetDisjunctCellSelect, default=0};
	__property bool EditOnDblClickOnly = {read=FEditOnDblClickOnly, write=SetEditOnDblClickOnly, default=0};
	__property TGridFixedCellEdit FixedRowsEdit = {read=FFixedRowsEdit, write=FFixedRowsEdit, default=0};
	__property TGridFixedCellEdit FixedColsEdit = {read=FFixedColsEdit, write=FFixedColsEdit, default=0};
	__property bool HotmailRowSelect = {read=FHotmailRowSelect, write=SetHotmailRowSelect, default=0};
	__property bool MoveRowOnNodeClick = {read=FMoveRowOnNodeClick, write=FMoveRowOnNodeClick, default=0};
	__property bool NoAutoRangeScroll = {read=FNoAutoRangeScroll, write=FNoAutoRangeScroll, default=0};
	__property bool NodeAllExpandContract = {read=FNodeAllExpandContract, write=FNodeAllExpandContract, default=0};
	__property bool NoScrollOnPartialRow = {read=FNoScrollOnPartialRow, write=FNoScrollOnPartialRow, default=0};
	__property bool PreciseCheckBoxCheck = {read=FPreciseCheckBoxCheck, write=FPreciseCheckBoxCheck, default=0};
	__property bool PreciseNodeClick = {read=FPreciseNodeClick, write=FPreciseNodeClick, default=1};
	__property bool RangeSelectAndEdit = {read=FRangeSelectAndEdit, write=FRangeSelectAndEdit, default=0};
	__property bool RowSelect = {read=FRowSelect, write=FRowSelect, default=0};
	__property bool RowSelectPersistent = {read=FRowSelectPersistent, write=FRowSelectPersistent, default=0};
	__property bool SelectOnRightClick = {read=FSelectOnRightClick, write=FSelectOnRightClick, default=0};
	__property bool SizeFixedCol = {read=FSizeFixedCol, write=FSizeFixedCol, default=0};
	__property bool SizeFixedRow = {read=FSizeFixedRow, write=FSizeFixedRow, default=0};
	__property int WheelIncrement = {read=FWheelIncrement, write=FWheelIncrement, default=0};
	__property TWheelAction WheelAction = {read=FWheelAction, write=SetWheelAction, default=0};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advobj */
using namespace Advobj;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvobjHPP
