// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Todolist.pas' rev: 21.00

#ifndef TodolistHPP
#define TodolistHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Spin.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Todoxpvs.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Character.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Todolist
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TTodoData { tdSubject, tdCompletion, tdNotes, tdPriority, tdDueDate, tdStatus, tdImage, tdComplete, tdTotalTime, tdCompletionDate, tdCreationDate, tdResource, tdHandle, tdProject, tdCategory };
#pragma option pop

#pragma option push -b-
enum TCheckType { ctCheckBox, ctCheckMark, ctGlyph };
#pragma option pop

#pragma option push -b-
enum TSortDirection { sdAscending, sdDescending };
#pragma option pop

typedef void __fastcall (__closure *TCompleteClick)(System::TObject* Sender, int ItemIndex);

class DELPHICLASS TTodoDateTimePicker;
class PASCALIMPLEMENTATION TTodoDateTimePicker : public Comctrls::TDateTimePicker
{
	typedef Comctrls::TDateTimePicker inherited;
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
public:
	/* TDateTimePicker.Create */ inline __fastcall virtual TTodoDateTimePicker(Classes::TComponent* AOwner) : Comctrls::TDateTimePicker(AOwner) { }
	
public:
	/* TCommonCalendar.Destroy */ inline __fastcall virtual ~TTodoDateTimePicker(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTodoDateTimePicker(HWND ParentWindow) : Comctrls::TDateTimePicker(ParentWindow) { }
	
};


class DELPHICLASS TCompleteCheck;
class PASCALIMPLEMENTATION TCompleteCheck : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TBitmap* FUnCompletedGlyph;
	Graphics::TBitmap* FCompletedGlyph;
	TCheckType FCheckType;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetCheckType(const TCheckType Value);
	void __fastcall SetCompletedGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetUnCompletedGlyph(const Graphics::TBitmap* Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TCompleteCheck(void);
	__fastcall virtual ~TCompleteCheck(void);
	
__published:
	__property Graphics::TBitmap* CompletedGlyph = {read=FCompletedGlyph, write=SetCompletedGlyph};
	__property Graphics::TBitmap* UnCompletedGlyph = {read=FUnCompletedGlyph, write=SetUnCompletedGlyph};
	__property TCheckType CheckType = {read=FCheckType, write=SetCheckType, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TTodoListStyle { esOffice2003Blue, esOffice2003Silver, esOffice2003Olive, esOffice2003Classic, esOffice2007Luna, esOffice2007Obsidian, esWindowsXP, esWhidbey, esCustom, esOffice2007Silver, esWindowsVista, esWindows7, esTerminal, esOffice2010Blue, esOffice2010Silver, esOffice2010Black };
#pragma option pop

class DELPHICLASS TProgressLook;
class PASCALIMPLEMENTATION TProgressLook : public Classes::TPersistent
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
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TProgressLook(void);
	
__published:
	__property Graphics::TColor CompleteColor = {read=FCompleteColor, write=SetCompleteColor, nodefault};
	__property Graphics::TColor CompleteFontColor = {read=FCompleteFontColor, write=SetCompleteFontColor, nodefault};
	__property Graphics::TColor UnCompleteColor = {read=FUnCompleteColor, write=SetUnCompleteColor, nodefault};
	__property Graphics::TColor UnCompleteFontColor = {read=FUnCompleteFontColor, write=SetUnCompleteFontColor, nodefault};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Graphics::TColor Level0Color = {read=FLevel0Color, write=SetLevel0Color, nodefault};
	__property Graphics::TColor Level0ColorTo = {read=FLevel0ColorTo, write=SetLevel0ColorTo, nodefault};
	__property Graphics::TColor Level1Color = {read=FLevel1Color, write=SetLevel1Color, nodefault};
	__property Graphics::TColor Level1ColorTo = {read=FLevel1ColorTo, write=SetLevel1ColorTo, nodefault};
	__property Graphics::TColor Level2Color = {read=FLevel2Color, write=SetLevel2Color, nodefault};
	__property Graphics::TColor Level2ColorTo = {read=FLevel2ColorTo, write=SetLevel2ColorTo, nodefault};
	__property Graphics::TColor Level3Color = {read=FLevel3Color, write=SetLevel3Color, nodefault};
	__property Graphics::TColor Level3ColorTo = {read=FLevel3ColorTo, write=SetLevel3ColorTo, nodefault};
	__property int Level1Perc = {read=FLevel1Perc, write=SetLevel1Perc, nodefault};
	__property int Level2Perc = {read=FLevel2Perc, write=SetLevel2Perc, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, nodefault};
	__property bool Stacked = {read=FStacked, write=SetStacked, nodefault};
	__property bool ShowPercentage = {read=FShowPercentage, write=SetShowPercentage, nodefault};
	__property bool CompletionSmooth = {read=FCompletionSmooth, write=SetCompletionSmooth, nodefault};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, nodefault};
	__property int Steps = {read=FSteps, write=SetSteps, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TProgressLook(void) { }
	
};


class DELPHICLASS TTodoColumnItem;
class PASCALIMPLEMENTATION TTodoColumnItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FWidth;
	Classes::TAlignment FAlignment;
	Graphics::TFont* FFont;
	Graphics::TColor FColor;
	TTodoData FTodoData;
	System::UnicodeString FCaption;
	Classes::TNotifyEvent FOnChange;
	bool FEditable;
	bool FTag;
	int FImageIndex;
	int FMaxLength;
	void __fastcall SetWidth(const int value);
	void __fastcall SetAlignment(const Classes::TAlignment value);
	void __fastcall SetFont(const Graphics::TFont* value);
	void __fastcall SetColor(const Graphics::TColor value);
	void __fastcall SetTodoData(const TTodoData Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetImageIndex(const int Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	void __fastcall SaveToStream(Classes::TStream* S);
	void __fastcall LoadFromStream(Classes::TStream* S);
	
public:
	__fastcall virtual TTodoColumnItem(Classes::TCollection* Collection);
	__fastcall virtual ~TTodoColumnItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	HIDESBASE virtual void __fastcall Changed(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property bool Editable = {read=FEditable, write=FEditable, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property bool Tag = {read=FTag, write=FTag, nodefault};
	__property TTodoData TodoData = {read=FTodoData, write=SetTodoData, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property int MaxLength = {read=FMaxLength, write=FMaxLength, nodefault};
};


class DELPHICLASS TTodoColumnCollection;
class DELPHICLASS TTodoListBox;
class PASCALIMPLEMENTATION TTodoColumnCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TTodoColumnItem* operator[](int Index) { return Items[Index]; }
	
private:
	TTodoListBox* FOwner;
	HIDESBASE TTodoColumnItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TTodoColumnItem* Value);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
public:
	__fastcall TTodoColumnCollection(TTodoListBox* AOwner);
	void __fastcall Swap(TTodoColumnItem* Item1, TTodoColumnItem* Item2);
	HIDESBASE TTodoColumnItem* __fastcall Add(void);
	HIDESBASE TTodoColumnItem* __fastcall Insert(int Index);
	__property TTodoColumnItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TTodoColumnCollection(void) { }
	
};


#pragma option push -b-
enum TTodoStatus { tsNotStarted, tsCompleted, tsInProgress, tsDeferred };
#pragma option pop

#pragma option push -b-
enum TTodoPriority { tpLowest, tpLow, tpNormal, tpHigh, tpHighest };
#pragma option pop

class DELPHICLASS EConversionFunctionException;
class PASCALIMPLEMENTATION EConversionFunctionException : public Sysutils::Exception
{
	typedef Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EConversionFunctionException(const System::UnicodeString Msg) : Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EConversionFunctionException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	/* Exception.CreateRes */ inline __fastcall EConversionFunctionException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	/* Exception.CreateResFmt */ inline __fastcall EConversionFunctionException(int Ident, System::TVarRec const *Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	/* Exception.CreateHelp */ inline __fastcall EConversionFunctionException(const System::UnicodeString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EConversionFunctionException(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EConversionFunctionException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EConversionFunctionException(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EConversionFunctionException(void) { }
	
};


class DELPHICLASS TStatusStrings;
class DELPHICLASS TCustomTodoList;
class PASCALIMPLEMENTATION TStatusStrings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	typedef StaticArray<System::UnicodeString, 4> _TStatusStrings__1;
	
	
public:
	System::UnicodeString operator[](TTodoStatus Index) { return Items[Index]; }
	
private:
	TCustomTodoList* FOwner;
	_TStatusStrings__1 FStatusStrings;
	System::UnicodeString __fastcall GetStringD(void);
	void __fastcall SetStringD(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetStringC(void);
	void __fastcall SetStringC(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetStringI(void);
	void __fastcall SetStringI(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetStringN(void);
	void __fastcall SetStringN(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetString(TTodoStatus Index);
	void __fastcall SetString(TTodoStatus Index, const System::UnicodeString Value);
	
protected:
	__property TCustomTodoList* Owner = {read=FOwner};
	
public:
	__fastcall TStatusStrings(TCustomTodoList* AOwner);
	__property System::UnicodeString Items[TTodoStatus Index] = {read=GetString, write=SetString/*, default*/};
	
__published:
	__property System::UnicodeString Deferred = {read=GetStringD, write=SetStringD};
	__property System::UnicodeString NotStarted = {read=GetStringN, write=SetStringN};
	__property System::UnicodeString Completed = {read=GetStringC, write=SetStringC};
	__property System::UnicodeString InProgress = {read=GetStringI, write=SetStringI};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TStatusStrings(void) { }
	
};


class DELPHICLASS TPriorityStrings;
class PASCALIMPLEMENTATION TPriorityStrings : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	typedef StaticArray<System::UnicodeString, 5> _TPriorityStrings__1;
	
	
public:
	System::UnicodeString operator[](TTodoPriority Index) { return Items[Index]; }
	
private:
	TCustomTodoList* FOwner;
	_TPriorityStrings__1 FPriorityStrings;
	System::UnicodeString __fastcall GetStringH(void);
	System::UnicodeString __fastcall GetStringHS(void);
	System::UnicodeString __fastcall GetStringL(void);
	System::UnicodeString __fastcall GetStringLS(void);
	System::UnicodeString __fastcall GetStringN(void);
	void __fastcall SetStringH(const System::UnicodeString Value);
	void __fastcall SetStringHS(const System::UnicodeString Value);
	void __fastcall SetStringL(const System::UnicodeString Value);
	void __fastcall SetStringLS(const System::UnicodeString Value);
	void __fastcall SetStringN(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetString(TTodoPriority Index);
	void __fastcall SetString(TTodoPriority Index, const System::UnicodeString Value);
	
protected:
	__property TCustomTodoList* Owner = {read=FOwner};
	
public:
	__fastcall TPriorityStrings(TCustomTodoList* AOwner);
	__property System::UnicodeString Items[TTodoPriority Index] = {read=GetString, write=SetString/*, default*/};
	
__published:
	__property System::UnicodeString Lowest = {read=GetStringLS, write=SetStringLS};
	__property System::UnicodeString Low = {read=GetStringL, write=SetStringL};
	__property System::UnicodeString Normal = {read=GetStringN, write=SetStringN};
	__property System::UnicodeString High = {read=GetStringH, write=SetStringH};
	__property System::UnicodeString Highest = {read=GetStringHS, write=SetStringHS};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TPriorityStrings(void) { }
	
};


class DELPHICLASS TBackForeColors;
class DELPHICLASS TEditColors;
class PASCALIMPLEMENTATION TBackForeColors : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Controls::TWinControl* FColorControl;
	TEditColors* FOwner;
	void __fastcall SetFontColor(const Graphics::TColor Value);
	void __fastcall SetBackColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetBackColor(void);
	Graphics::TColor __fastcall GetFontColor(void);
	
public:
	__fastcall TBackForeColors(TEditColors* AOwner, Controls::TWinControl* AColorControl);
	__property Controls::TWinControl* ColorControl = {read=FColorControl, write=FColorControl};
	__property TEditColors* Owner = {read=FOwner};
	
__published:
	__property Graphics::TColor FontColor = {read=GetFontColor, write=SetFontColor, nodefault};
	__property Graphics::TColor BackColor = {read=GetBackColor, write=SetBackColor, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TBackForeColors(void) { }
	
};


class DELPHICLASS TDatePickerColors;
class PASCALIMPLEMENTATION TDatePickerColors : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TEditColors* FOwner;
	TTodoDateTimePicker* FColorControl;
	Graphics::TColor __fastcall GetBackColor(void);
	Graphics::TColor __fastcall GetFontColor(void);
	void __fastcall SetBackColor(const Graphics::TColor Value);
	void __fastcall SetFontColor(const Graphics::TColor Value);
	Comctrls::TMonthCalColors* __fastcall GetCalColors(void);
	void __fastcall SetCalColors(const Comctrls::TMonthCalColors* Value);
	
public:
	__fastcall TDatePickerColors(TEditColors* AOwner, TTodoDateTimePicker* AColorControl);
	__property TEditColors* Owner = {read=FOwner};
	
__published:
	__property Graphics::TColor BackColor = {read=GetBackColor, write=SetBackColor, nodefault};
	__property Graphics::TColor FontColor = {read=GetFontColor, write=SetFontColor, nodefault};
	__property Comctrls::TMonthCalColors* CalColors = {read=GetCalColors, write=SetCalColors};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TDatePickerColors(void) { }
	
};


class PASCALIMPLEMENTATION TEditColors : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TCustomTodoList* FOwner;
	TBackForeColors* FStringEditor;
	TBackForeColors* FMemoEditor;
	TBackForeColors* FIntegerEditor;
	TBackForeColors* FPriorityEditor;
	TBackForeColors* FStatusEditor;
	TDatePickerColors* FDefaultDateEditor;
	
public:
	__property TCustomTodoList* Owner = {read=FOwner};
	__fastcall TEditColors(TCustomTodoList* AOwner);
	__fastcall virtual ~TEditColors(void);
	
__published:
	__property TBackForeColors* StringEditor = {read=FStringEditor, write=FStringEditor};
	__property TBackForeColors* MemoEditor = {read=FMemoEditor, write=FMemoEditor};
	__property TBackForeColors* IntegerEditor = {read=FIntegerEditor, write=FIntegerEditor};
	__property TBackForeColors* PriorityEditor = {read=FPriorityEditor, write=FPriorityEditor};
	__property TBackForeColors* StatusEditor = {read=FStatusEditor, write=FStatusEditor};
	__property TDatePickerColors* DateEditor = {read=FDefaultDateEditor, write=FDefaultDateEditor};
};


class DELPHICLASS TInplaceSpinEdit;
class PASCALIMPLEMENTATION TInplaceSpinEdit : public Spin::TSpinEdit
{
	typedef Spin::TSpinEdit inherited;
	
private:
	TTodoListBox* FTodoList;
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	
public:
	__fastcall virtual TInplaceSpinEdit(Classes::TComponent* AOwner);
public:
	/* TSpinEdit.Destroy */ inline __fastcall virtual ~TInplaceSpinEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInplaceSpinEdit(HWND ParentWindow) : Spin::TSpinEdit(ParentWindow) { }
	
};


#pragma option push -b-
enum Todolist__31 { tbFocusRect, tbAllowTimer };
#pragma option pop

typedef Set<Todolist__31, tbFocusRect, tbAllowTimer>  TTimeSpinBtnState;

class DELPHICLASS TTimerSpinButton;
class PASCALIMPLEMENTATION TTimerSpinButton : public Buttons::TSpeedButton
{
	typedef Buttons::TSpeedButton inherited;
	
private:
	Extctrls::TTimer* FRepeatTimer;
	TTimeSpinBtnState FTimeBtnState;
	bool FHasMouse;
	void __fastcall TimerExpired(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TTimerSpinButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TTimerSpinButton(void);
	__property TTimeSpinBtnState TimeBtnState = {read=FTimeBtnState, write=FTimeBtnState, nodefault};
};


class DELPHICLASS TSpinSpeedButtons;
class PASCALIMPLEMENTATION TSpinSpeedButtons : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	TTimerSpinButton* FUpButton;
	TTimerSpinButton* FDownButton;
	Classes::TNotifyEvent FOnUpBtnClick;
	Classes::TNotifyEvent FOnDownBtnClick;
	HIDESBASE void __fastcall AdjustSize(int &W, int &H);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	void __fastcall UpBtnClick(System::TObject* Sender);
	void __fastcall DownBtnClick(System::TObject* Sender);
	
public:
	__fastcall virtual TSpinSpeedButtons(Classes::TComponent* aOwner);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property Classes::TNotifyEvent OnUpBtnClick = {read=FOnUpBtnClick, write=FOnUpBtnClick};
	__property Classes::TNotifyEvent OnDownBtnClick = {read=FOnDownBtnClick, write=FOnDownBtnClick};
public:
	/* TWinControl.CreateParented */ inline __fastcall TSpinSpeedButtons(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TSpinSpeedButtons(void) { }
	
};


class DELPHICLASS TInplaceFloatSpinEdit;
class PASCALIMPLEMENTATION TInplaceFloatSpinEdit : public Mask::TCustomMaskEdit
{
	typedef Mask::TCustomMaskEdit inherited;
	
private:
	TTodoListBox* FTodoList;
	TSpinSpeedButtons* FUpDownBtns;
	int FPrecision;
	double FIncrementFloat;
	System::WideChar FDecSep;
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMChar(Messages::TWMKey &Msg);
	void __fastcall SetEditRect(void);
	void __fastcall SetPrecision(const int Value);
	double __fastcall GetFloatValue(void);
	void __fastcall SetFloatValue(const double Value);
	void __fastcall UpClick(System::TObject* Sender);
	void __fastcall DownClick(System::TObject* Sender);
	
protected:
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	bool __fastcall IsValidChar(System::WideChar &Key);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	
public:
	__fastcall virtual TInplaceFloatSpinEdit(Classes::TComponent* AOwner);
	__fastcall virtual ~TInplaceFloatSpinEdit(void);
	
__published:
	__property int Precision = {read=FPrecision, write=SetPrecision, nodefault};
	__property double FloatValue = {read=GetFloatValue, write=SetFloatValue};
	__property double IncrementFloat = {read=FIncrementFloat, write=FIncrementFloat};
	__property System::WideChar DecSep = {read=FDecSep, write=FDecSep, nodefault};
	__property OnExit;
public:
	/* TWinControl.CreateParented */ inline __fastcall TInplaceFloatSpinEdit(HWND ParentWindow) : Mask::TCustomMaskEdit(ParentWindow) { }
	
};


class DELPHICLASS TInplaceListBox;
class PASCALIMPLEMENTATION TInplaceListBox : public Stdctrls::TListBox
{
	typedef Stdctrls::TListBox inherited;
	
private:
	int FOldItemIndex;
	Classes::TNotifyEvent FOnSelected;
	bool FMouseDown;
	TTodoListBox* FTodoList;
	int __fastcall GetItemIndexEx(void);
	void __fastcall SetItemIndexEx(const int Value);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
public:
	__fastcall virtual TInplaceListBox(Classes::TComponent* AOwner);
	
__published:
	__property Classes::TNotifyEvent OnSelected = {read=FOnSelected, write=FOnSelected};
	__property int ItemIndex = {read=GetItemIndexEx, write=SetItemIndexEx, nodefault};
public:
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TInplaceListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInplaceListBox(HWND ParentWindow) : Stdctrls::TListBox(ParentWindow) { }
	
};


class DELPHICLASS TInplaceODListBox;
class PASCALIMPLEMENTATION TInplaceODListBox : public TInplaceListBox
{
	typedef TInplaceListBox inherited;
	
private:
	Controls::TImageList* FImageList;
	TTodoListBox* FTodoList;
	
protected:
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	
public:
	__fastcall virtual TInplaceODListBox(Classes::TComponent* AOwner);
	
__published:
	__property Controls::TImageList* ImageList = {read=FImageList, write=FImageList};
public:
	/* TCustomListBox.Destroy */ inline __fastcall virtual ~TInplaceODListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TInplaceODListBox(HWND ParentWindow) : TInplaceListBox(ParentWindow) { }
	
};


class DELPHICLASS TInplaceMemo;
class PASCALIMPLEMENTATION TInplaceMemo : public Stdctrls::TMemo
{
	typedef Stdctrls::TMemo inherited;
	
private:
	Classes::TStringList* FOldText;
	TTodoListBox* FTodoList;
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
public:
	__fastcall virtual TInplaceMemo(Classes::TComponent* AOwner);
	__fastcall virtual ~TInplaceMemo(void);
	
__published:
	__property Classes::TStringList* OrigLines = {read=FOldText};
public:
	/* TWinControl.CreateParented */ inline __fastcall TInplaceMemo(HWND ParentWindow) : Stdctrls::TMemo(ParentWindow) { }
	
};


class DELPHICLASS TInplaceEdit;
class PASCALIMPLEMENTATION TInplaceEdit : public Stdctrls::TEdit
{
	typedef Stdctrls::TEdit inherited;
	
private:
	System::UnicodeString FOldText;
	TTodoListBox* FTodoList;
	bool FNumericOnly;
	HIDESBASE System::UnicodeString __fastcall GetText(void);
	HIDESBASE void __fastcall SetText(const System::UnicodeString Value);
	
protected:
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	__fastcall virtual TInplaceEdit(Classes::TComponent* AOwner);
	__property bool NumericOnly = {read=FNumericOnly, write=FNumericOnly, nodefault};
	
__published:
	__property System::UnicodeString Text = {read=GetText, write=SetText};
public:
	/* TWinControl.CreateParented */ inline __fastcall TInplaceEdit(HWND ParentWindow) : Stdctrls::TEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TInplaceEdit(void) { }
	
};


typedef ShortInt TCompletion;

class DELPHICLASS TTodoItem;
class PASCALIMPLEMENTATION TTodoItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	int FImageIndex;
	Classes::TStringList* FNotes;
	int FTag;
	double FTotalTime;
	System::UnicodeString FSubject;
	TCompletion FCompletion;
	System::TDateTime FDueDate;
	TTodoPriority FPriority;
	TTodoStatus FStatus;
	Classes::TNotifyEvent FOnChange;
	bool FComplete;
	System::TDateTime FCreationDate;
	System::TDateTime FCompletionDate;
	System::UnicodeString FResource;
	System::UnicodeString FDBKey;
	System::UnicodeString FProject;
	System::UnicodeString FCategory;
	void __fastcall SetImageIndex(const int value);
	void __fastcall StringsChanged(System::TObject* sender);
	void __fastcall SetCompletion(const TCompletion Value);
	void __fastcall SetDueDate(const System::TDateTime Value);
	void __fastcall SetNotes(const Classes::TStringList* Value);
	void __fastcall SetPriority(const TTodoPriority Value);
	void __fastcall SetStatus(const TTodoStatus Value);
	void __fastcall SetSubject(const System::UnicodeString Value);
	void __fastcall SetTotalTime(const double Value);
	void __fastcall SetComplete(const bool Value);
	void __fastcall SetCompletionDate(const System::TDateTime Value);
	void __fastcall SetCreationDate(const System::TDateTime Value);
	void __fastcall SetResource(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetNotesLine(void);
	void __fastcall SetProject(const System::UnicodeString Value);
	void __fastcall SetCategory(const System::UnicodeString Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TTodoItem(Classes::TCollection* Collection);
	__fastcall virtual ~TTodoItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	HIDESBASE virtual void __fastcall Changed(void);
	void __fastcall Select(void);
	void __fastcall UnSelect(void);
	void __fastcall SaveToStream(Classes::TStream* S);
	void __fastcall LoadFromStream(Classes::TStream* S);
	__property System::UnicodeString DBKey = {read=FDBKey, write=FDBKey};
	__property System::UnicodeString NotesLine = {read=GetNotesLine};
	
__published:
	__property System::UnicodeString Category = {read=FCategory, write=SetCategory};
	__property bool Complete = {read=FComplete, write=SetComplete, nodefault};
	__property TCompletion Completion = {read=FCompletion, write=SetCompletion, nodefault};
	__property System::TDateTime CompletionDate = {read=FCompletionDate, write=SetCompletionDate};
	__property System::TDateTime CreationDate = {read=FCreationDate, write=SetCreationDate};
	__property System::TDateTime DueDate = {read=FDueDate, write=SetDueDate};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, nodefault};
	__property Classes::TStringList* Notes = {read=FNotes, write=SetNotes};
	__property TTodoPriority Priority = {read=FPriority, write=SetPriority, nodefault};
	__property System::UnicodeString Project = {read=FProject, write=SetProject};
	__property System::UnicodeString Resource = {read=FResource, write=SetResource};
	__property TTodoStatus Status = {read=FStatus, write=SetStatus, nodefault};
	__property System::UnicodeString Subject = {read=FSubject, write=SetSubject};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property double TotalTime = {read=FTotalTime, write=SetTotalTime};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TTodoItemCollection;
class PASCALIMPLEMENTATION TTodoItemCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TTodoItem* operator[](int Index) { return Items[Index]; }
	
private:
	TTodoListBox* FOwner;
	HIDESBASE TTodoItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TTodoItem* Value);
	void __fastcall PasteItem(bool Position);
	
protected:
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	void __fastcall ItemChanged(int Index);
	
public:
	__fastcall TTodoItemCollection(TTodoListBox* AOwner);
	virtual Classes::TCollectionItemClass __fastcall GetItemClass(void);
	HIDESBASE virtual void __fastcall Changed(void);
	HIDESBASE TTodoItem* __fastcall Add(void);
	HIDESBASE TTodoItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	Types::TPoint __fastcall IndexOf(System::UnicodeString s);
	int __fastcall IndexInTodoOf(int col, System::UnicodeString s);
	int __fastcall IndexInRowOf(int row, System::UnicodeString s);
	void __fastcall CopyToClipboard(void);
	void __fastcall CutToClipboard(void);
	void __fastcall PasteFromClipboard(void);
	__property TTodoItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TTodoItemCollection(void) { }
	
};


class DELPHICLASS TTodoItemIO;
class PASCALIMPLEMENTATION TTodoItemIO : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
__published:
	TTodoItem* FItem;
	
public:
	__fastcall TTodoItemIO(TTodoItemCollection* AOwner);
	__fastcall virtual ~TTodoItemIO(void);
	
__published:
	__property TTodoItem* Item = {read=FItem, write=FItem};
public:
	/* TComponent.Create */ inline __fastcall virtual TTodoItemIO(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	
};


#pragma option push -b-
enum TGridLineStyle { glsNone, glsItems, glsAlways };
#pragma option pop

class PASCALIMPLEMENTATION TTodoListBox : public Stdctrls::TCustomListBox
{
	typedef Stdctrls::TCustomListBox inherited;
	
private:
	Controls::TWinControl* ActiveEditor;
	TTodoColumnItem* EditedColumn;
	TTodoItem* EditedItem;
	TInplaceEdit* StringEditor;
	TInplaceEdit* FNumericOnlyEditor;
	TInplaceMemo* StringListEditor;
	TTodoDateTimePicker* DefaultDateEditor;
	TInplaceSpinEdit* IntegerEditor;
	TInplaceFloatSpinEdit* FFloatEditor;
	TInplaceODListBox* PriorityEditor;
	TInplaceListBox* StatusEditor;
	Forms::TForm* EditorParent;
	TCustomTodoList* FOwner;
	Controls::TImageList* FImages;
	Controls::TImageList* FPriorityImageList;
	TTodoColumnCollection* FTodoColumns;
	TTodoItemCollection* FTodoItems;
	TGridLineStyle FGridLines;
	Graphics::TColor FGridLineColor;
	int FItemIndex;
	int FUpdateCount;
	int FSortTodo;
	bool FSortedEx;
	bool FLookupIncr;
	int FLookupTodo;
	System::UnicodeString FLookup;
	System::UnicodeString FDateFormat;
	Classes::TNotifyEvent FColumnsChanged;
	bool FPreview;
	Graphics::TFont* FPreviewFont;
	Graphics::TFont* FCompletionFont;
	TProgressLook* FProgressLook;
	bool FShowSelection;
	Graphics::TFont* FPriorityFont;
	bool FEditable;
	bool FEditSelectAll;
	Graphics::TColor FSelectionColor;
	Graphics::TColor FSelectionFontColor;
	int FFocusColumn;
	Classes::TNotifyEvent FOnSelectItem;
	Graphics::TColor FSelectionColorTo;
	Graphics::TColor FActiveColumnColor;
	bool FUseTab;
	bool FShowPriorityText;
	bool FIsWinXP;
	Classes::TNotifyEvent FOnHorizontalScroll;
	bool fScrollHorizontal;
	Graphics::TColor FActiveItemColorTo;
	Graphics::TColor FActiveItemColor;
	bool FMouseDownNotDone;
	Graphics::TBitmap* FHandleGlyph;
	Graphics::TColor FPreviewColorTo;
	Graphics::TColor FPreviewColor;
	bool FStretchLastColumn;
	System::UnicodeString FTotalTimeSuffix;
	void __fastcall EditorOnExit(System::TObject* Sender);
	void __fastcall EditorParentOnDeactivate(System::TObject* Sender);
	void __fastcall SetImages(const Controls::TImageList* Value);
	void __fastcall SetItemIndexEx(const int Value);
	int __fastcall GetItemIndexEx(void);
	void __fastcall SetGridLines(const TGridLineStyle Value);
	void __fastcall SynchItems(void);
	void __fastcall SynchColumns(void);
	bool __fastcall GetSortedEx(void);
	void __fastcall SetSortedEx(const bool Value);
	void __fastcall SetDateFormat(const System::UnicodeString Value);
	void __fastcall SetPreview(const bool Value);
	void __fastcall SetCompletionFont(const Graphics::TFont* Value);
	void __fastcall SetPreviewFont(const Graphics::TFont* Value);
	void __fastcall SetProgressLook(const TProgressLook* Value);
	void __fastcall ProgressLookChanged(System::TObject* Sender);
	void __fastcall SetShowSelection(const bool Value);
	void __fastcall SetPriorityFont(const Graphics::TFont* Value);
	HIDESBASE MESSAGE void __fastcall CNCommand(Messages::TWMCommand &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &WMScroll);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Controls::TCMHintShow &M);
	MESSAGE void __fastcall CMWantSpecialKey(Messages::TWMKey &Msg);
	bool __fastcall XYToColItem(const int X, const int Y, int &ColIdx, int &ItemIdx, Types::TRect &R);
	void __fastcall ColItemRect(int ColIdx, int ItemIdx, Types::TRect &R);
	bool __fastcall ClickedOnNotes(const bool CalcItem, const Types::TPoint &P, /* out */ int &ItemIdx, /* out */ Types::TRect &R);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	void __fastcall StartEdit(int Index, int Column, bool FromMouse, const Messages::TMessage &Msg, int X, int Y, System::WideChar ch);
	void __fastcall AdvanceEdit(void);
	void __fastcall SetSelectionColorTo(const Graphics::TColor Value);
	void __fastcall SetActiveColumnColor(const Graphics::TColor Value);
	void __fastcall SetShowPriorityText(const bool Value);
	void __fastcall SetScrollHorizontal(const bool Value);
	int __fastcall MaxHorizontalExtent(void);
	void __fastcall InputFromCSV(System::UnicodeString FileName, bool insertmode);
	void __fastcall OutputToCSV(System::UnicodeString FileName, bool appendmode);
	void __fastcall SetActiveItemColor(const Graphics::TColor Value);
	void __fastcall SetActiveItemColorTo(const Graphics::TColor Value);
	void __fastcall SetHandleGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetGridLineColor(const Graphics::TColor Value);
	void __fastcall SetPreviewColor(const Graphics::TColor Value);
	void __fastcall SetPreviewColorTo(const Graphics::TColor Value);
	void __fastcall SetStretchLastColumn(const bool Value);
	int __fastcall GetControlWidth(void);
	
protected:
	virtual void __fastcall MeasureItem(int Index, int &Height);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall UpdateHScrollExtent(int maxextent);
	virtual void __fastcall DrawItem(int Index, const Types::TRect &Rect, Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	__property Items;
	DYNAMIC void __fastcall DoEnter(void);
	void __fastcall SendClickMessage(const Messages::TMessage &Msg, int X, int Y);
	void __fastcall SetEditorFont(Controls::TWinControl* Editor, Graphics::TFont* Font);
	void __fastcall EditNotesInPreviewArea(int Idx, const Types::TRect &R, const Messages::TMessage &Msg, int X, int Y);
	void __fastcall ShowEditor(Controls::TWinControl* Editor, const Types::TRect &R, bool UseSeparateParent);
	void __fastcall RepaintItem(int Index);
	void __fastcall SetHorizontalScrollBar(void);
	void __fastcall DrawGrid(Graphics::TCanvas* ACanvas);
	
public:
	__fastcall virtual TTodoListBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TTodoListBox(void);
	virtual void __fastcall Loaded(void);
	__property Text;
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property Graphics::TColor ActiveColumnColor = {read=FActiveColumnColor, write=SetActiveColumnColor, nodefault};
	__property Graphics::TColor ActiveItemColor = {read=FActiveItemColor, write=SetActiveItemColor, nodefault};
	__property Graphics::TColor ActiveItemColorTo = {read=FActiveItemColorTo, write=SetActiveItemColorTo, nodefault};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Graphics::TFont* CompletionFont = {read=FCompletionFont, write=SetCompletionFont};
	__property Cursor = {default=0};
	__property Ctl3D;
	__property System::UnicodeString DateFormat = {read=FDateFormat, write=SetDateFormat};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property bool Editable = {read=FEditable, write=FEditable, nodefault};
	__property bool EditSelectAll = {read=FEditSelectAll, write=FEditSelectAll, nodefault};
	__property Enabled = {default=1};
	__property Font;
	__property TGridLineStyle GridLines = {read=FGridLines, write=SetGridLines, default=2};
	__property Graphics::TColor GridLineColor = {read=FGridLineColor, write=SetGridLineColor, nodefault};
	__property Graphics::TBitmap* HandleGlyph = {read=FHandleGlyph, write=SetHandleGlyph};
	__property Controls::TImageList* Images = {read=FImages, write=SetImages};
	__property IntegralHeight = {default=0};
	__property ItemHeight = {default=16};
	__property int ItemIndex = {read=GetItemIndexEx, write=SetItemIndexEx, nodefault};
	__property bool LookupIncr = {read=FLookupIncr, write=FLookupIncr, nodefault};
	__property int LookupTodo = {read=FLookupTodo, write=FLookupTodo, nodefault};
	__property MultiSelect = {default=0};
	__property ParentColor = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property bool Preview = {read=FPreview, write=SetPreview, nodefault};
	__property Graphics::TFont* PreviewFont = {read=FPreviewFont, write=SetPreviewFont};
	__property Graphics::TColor PreviewColor = {read=FPreviewColor, write=SetPreviewColor, default=536870911};
	__property Graphics::TColor PreviewColorTo = {read=FPreviewColorTo, write=SetPreviewColorTo, default=536870911};
	__property Graphics::TFont* PriorityFont = {read=FPriorityFont, write=SetPriorityFont};
	__property TProgressLook* ProgressLook = {read=FProgressLook, write=SetProgressLook};
	__property bool ScrollHorizontal = {read=fScrollHorizontal, write=SetScrollHorizontal, nodefault};
	__property Graphics::TColor SelectionColor = {read=FSelectionColor, write=SetSelectionColor, nodefault};
	__property Graphics::TColor SelectionColorTo = {read=FSelectionColorTo, write=SetSelectionColorTo, nodefault};
	__property Graphics::TColor SelectionFontColor = {read=FSelectionFontColor, write=SetSelectionFontColor, nodefault};
	__property ShowHint;
	__property bool ShowPriorityText = {read=FShowPriorityText, write=SetShowPriorityText, nodefault};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, nodefault};
	__property int SortTodo = {read=FSortTodo, write=FSortTodo, nodefault};
	__property bool Sorted = {read=GetSortedEx, write=SetSortedEx, nodefault};
	__property bool StretchLastColumn = {read=FStretchLastColumn, write=SetStretchLastColumn, default=1};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property TTodoColumnCollection* TodoColumns = {read=FTodoColumns, write=FTodoColumns};
	__property TTodoItemCollection* TodoItems = {read=FTodoItems, write=FTodoItems};
	__property bool UseTab = {read=FUseTab, write=FUseTab, nodefault};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDrawItem;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMeasureItem;
	__property OnStartDrag;
	__property Classes::TNotifyEvent OnHorizontalScroll = {read=FOnHorizontalScroll, write=FOnHorizontalScroll};
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property Classes::TNotifyEvent OnColumnsChanged = {read=FColumnsChanged, write=FColumnsChanged};
	__property Classes::TNotifyEvent OnSelectItem = {read=FOnSelectItem, write=FOnSelectItem};
	__property System::UnicodeString TotalTimeSuffix = {read=FTotalTimeSuffix, write=FTotalTimeSuffix};
public:
	/* TWinControl.CreateParented */ inline __fastcall TTodoListBox(HWND ParentWindow) : Stdctrls::TCustomListBox(ParentWindow) { }
	
};


#pragma option push -b-
enum TImagePosition { ipLeft, ipRight };
#pragma option pop

#pragma option push -b-
enum TVAlignment { vtaCenter, vtaTop, vtaBottom };
#pragma option pop

#pragma option push -b-
enum THeaderOrientation { hoHorizontal, hoVertical };
#pragma option pop

typedef void __fastcall (__closure *THeaderClickEvent)(System::TObject* Sender, int SectionIndex);

typedef void __fastcall (__closure *THeaderDragDropEvent)(System::TObject* Sender, int FromSection, int ToSection);

class DELPHICLASS TTodoHeader;
class PASCALIMPLEMENTATION TTodoHeader : public Extctrls::THeader
{
	typedef Extctrls::THeader inherited;
	
private:
	int FOffset;
	int FLeftPos;
	Classes::TAlignment FAlignment;
	TVAlignment FVAlignment;
	Graphics::TColor FColor;
	Graphics::TColor FLineColor;
	bool FFlat;
	Controls::TImageList* FImageList;
	Stdctrls::TMemo* FInplaceEdit;
	TImagePosition FImagePosition;
	THeaderClickEvent FOnClick;
	THeaderClickEvent FOnRightClick;
	THeaderDragDropEvent FOnDragDrop;
	THeaderOrientation FOrientation;
	bool FSectionDragDrop;
	bool FDragging;
	int FDragStart;
	int FEditSection;
	int FEditWidth;
	THeaderClickEvent FOnSectionEditEnd;
	THeaderClickEvent FOnSectionEditStart;
	bool FSectionEdit;
	int FItemHeight;
	int FTextHeight;
	int FSortedSection;
	TSortDirection FSortDirection;
	bool FSortShow;
	TCustomTodoList* FOwner;
	int FHScroll;
	Graphics::TColor FColorTo;
	Graphics::TColor FActiveColorTo;
	Graphics::TColor FActiveColor;
	int FActiveColumn;
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetImageList(const Controls::TImageList* Value);
	void __fastcall SetImagePosition(const TImagePosition Value);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonDown(Messages::TWMMouse &Message);
	void __fastcall SetOrientation(const THeaderOrientation Value);
	void __fastcall SetFlat(const bool Value);
	void __fastcall SetLineColor(const Graphics::TColor Value);
	void __fastcall SetVAlignment(const TVAlignment Value);
	void __fastcall InplaceExit(System::TObject* Sender);
	void __fastcall SetItemHeight(const int Value);
	void __fastcall SetTextHeight(const int Value);
	void __fastcall SetSortDirection(const TSortDirection Value);
	void __fastcall SetSortedSection(const int Value);
	void __fastcall DrawSortIndicator(Graphics::TCanvas* Canvas, int X, int Y);
	void __fastcall OwnOnDragDrop(System::TObject* Sender, int FromSection, int ToSection);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetActiveColor(const Graphics::TColor Value);
	void __fastcall SetActiveColorTo(const Graphics::TColor Value);
	void __fastcall SetActiveColumn(const int Value);
	
public:
	__fastcall virtual TTodoHeader(Classes::TComponent* AOwner);
	__fastcall virtual ~TTodoHeader(void);
	
protected:
	int __fastcall XYToSection(int X, int Y);
	Types::TRect __fastcall GetSectionRect(int X);
	virtual void __fastcall Paint(void);
	void __fastcall HorizontalScroll(int X);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property int ActiveColumn = {read=FActiveColumn, write=SetActiveColumn, nodefault};
	__property Graphics::TColor ActiveColor = {read=FActiveColor, write=SetActiveColor, nodefault};
	__property Graphics::TColor ActiveColorTo = {read=FActiveColorTo, write=SetActiveColorTo, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property Controls::TImageList* Images = {read=FImageList, write=SetImageList};
	__property TImagePosition ImagePosition = {read=FImagePosition, write=SetImagePosition, nodefault};
	__property int ItemHeight = {read=FItemHeight, write=SetItemHeight, nodefault};
	__property int TextHeight = {read=FTextHeight, write=SetTextHeight, nodefault};
	__property Graphics::TColor LineColor = {read=FLineColor, write=SetLineColor, nodefault};
	__property bool SectionDragDrop = {read=FSectionDragDrop, write=FSectionDragDrop, nodefault};
	__property bool SectionEdit = {read=FSectionEdit, write=FSectionEdit, nodefault};
	__property int SortedSection = {read=FSortedSection, write=SetSortedSection, nodefault};
	__property TSortDirection SortDirection = {read=FSortDirection, write=SetSortDirection, nodefault};
	__property bool SortShow = {read=FSortShow, write=FSortShow, nodefault};
	__property TVAlignment VAlignment = {read=FVAlignment, write=SetVAlignment, nodefault};
	__property THeaderOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property THeaderClickEvent OnClick = {read=FOnClick, write=FOnClick};
	__property THeaderDragDropEvent OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property THeaderClickEvent OnRightClick = {read=FOnRightClick, write=FOnRightClick};
	__property THeaderClickEvent OnSectionEditStart = {read=FOnSectionEditStart, write=FOnSectionEditStart};
	__property THeaderClickEvent OnSectionEditEnd = {read=FOnSectionEditEnd, write=FOnSectionEditEnd};
public:
	/* TWinControl.CreateParented */ inline __fastcall TTodoHeader(HWND ParentWindow) : Extctrls::THeader(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TStatusToStringEvent)(System::TObject* Sender, TTodoStatus AValue, System::UnicodeString &AString);

typedef void __fastcall (__closure *TStringToStatusEvent)(System::TObject* Sender, System::UnicodeString AString, TTodoStatus &AValue);

typedef void __fastcall (__closure *TPriorityToStringEvent)(System::TObject* Sender, TTodoPriority AValue, System::UnicodeString &AString);

typedef void __fastcall (__closure *TStringToPriorityEvent)(System::TObject* Sender, System::UnicodeString AString, TTodoPriority &AValue);

typedef void __fastcall (__closure *TTodoItemEvent)(System::TObject* Sender, TTodoItem* ATodoItem, bool &Allow);

typedef void __fastcall (__closure *TTodoItemSelectEvent)(System::TObject* Sender, TTodoItem* ATodoItem);

typedef void __fastcall (__closure *TListHeaderEvent)(System::TObject* Sender, int Column);

typedef void __fastcall (__closure *TOnHeaderDragDropEvent)(System::TObject* Sender, int FromCol, int ToCol);

class PASCALIMPLEMENTATION TCustomTodoList : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TTodoHeader* FTodoHeader;
	TTodoListBox* FTodoListBox;
	Forms::TFormBorderStyle FBorderStyle;
	Controls::TMouseEvent FOnMouseUp;
	Controls::TMouseEvent FOnMouseDown;
	Controls::TMouseMoveEvent FOnMouseMove;
	Controls::TKeyEvent FOnKeyDown;
	Controls::TKeyEvent FOnKeyUp;
	Controls::TKeyPressEvent FOnKeyPress;
	TPriorityToStringEvent FOnPriorityToString;
	TStatusToStringEvent FOnStatusToString;
	TStringToPriorityEvent FOnStringToPriority;
	TStringToStatusEvent FOnStringToStatus;
	int FPreviewHeight;
	int FItemHeight;
	TStatusStrings* FStatusStrings;
	TPriorityStrings* FPriorityStrings;
	TEditColors* FEditColors;
	TCompleteCheck* FCompleteCheck;
	Classes::TNotifyEvent FOnClick;
	Classes::TNotifyEvent FOnDblClick;
	Controls::TDragDropEvent FOnDragDrop;
	Controls::TEndDragEvent FOnEndDrag;
	Controls::TDragOverEvent FOnDragOver;
	Controls::TStartDragEvent FOnStartDrag;
	Classes::TNotifyEvent FOnEnter;
	Classes::TNotifyEvent FOnExit;
	bool FSorted;
	int FSortColumn;
	TSortDirection FSortDirection;
	int FNewIdx;
	TListHeaderEvent FOnHeaderRightClick;
	TListHeaderEvent FOnHeaderClick;
	bool FAutoInsertItem;
	bool FAutoDeleteItem;
	TTodoItemEvent FOnItemInsert;
	TTodoItemEvent FOnItemDelete;
	Classes::TNotifyEvent FOnEditStart;
	Classes::TNotifyEvent FOnEditDone;
	TTodoItemSelectEvent FOnItemSelect;
	TTodoItemSelectEvent FOnItemRightClick;
	bool FCompletionGraphic;
	bool FHintShowFullText;
	bool FHeaderDragDrop;
	TOnHeaderDragDropEvent FOnHeaderDragDrop;
	bool FAutoAdvanceEdit;
	int FStatusListWidth;
	int FPriorityListWidth;
	System::UnicodeString FNullDate;
	TCompleteClick FOnCompleteClick;
	Classes::TStringList* FCategory;
	TTodoListStyle FLook;
	bool FAutoThemeAdapt;
	System::UnicodeString FTotalTimeSuffix;
	void __fastcall NCPaintProc(void);
	Graphics::TColor __fastcall GetColor(void);
	HIDESBASE void __fastcall SetColor(const Graphics::TColor Value);
	Graphics::TFont* __fastcall GetFont(void);
	HIDESBASE void __fastcall SetFont(const Graphics::TFont* Value);
	TTodoItemCollection* __fastcall GetTodoItems(void);
	void __fastcall SetTodoItems(const TTodoItemCollection* Value);
	void __fastcall SetBorderStyle(const Forms::TBorderStyle Value);
	TTodoColumnCollection* __fastcall GetTodoColumns(void);
	void __fastcall SetTodoColumns(const TTodoColumnCollection* Value);
	void __fastcall SectionSized(System::TObject* Sender, int SectionIdx, int SectionWidth);
	System::UnicodeString __fastcall GetDateFormat(void);
	void __fastcall SetDateFormat(const System::UnicodeString Value);
	void __fastcall SetImages(const Controls::TImageList* Value);
	Controls::TImageList* __fastcall GetImages(void);
	TGridLineStyle __fastcall GetGridLines(void);
	void __fastcall SetGridLines(const TGridLineStyle Value);
	int __fastcall GetItemHeight(void);
	void __fastcall SetItemHeight(const int Value);
	bool __fastcall GetPreview(void);
	void __fastcall SetPreview(const bool Value);
	Graphics::TFont* __fastcall GetCompletionFont(void);
	Graphics::TFont* __fastcall GetPreviewFont(void);
	void __fastcall SetCompletionFont(const Graphics::TFont* Value);
	void __fastcall SetPreviewFont(const Graphics::TFont* Value);
	TProgressLook* __fastcall GetProgressLook(void);
	void __fastcall SetProgressLook(const TProgressLook* Value);
	Graphics::TFont* __fastcall GetPriorityFont(void);
	void __fastcall SetPriorityFont(const Graphics::TFont* Value);
	void __fastcall SetEditable(const bool Value);
	bool __fastcall GetEditable(void);
	bool __fastcall GetSelectAllInSubjectEdit(void);
	void __fastcall SetSelectAllInSubjectEdit(const bool Value);
	bool __fastcall GetShowSelection(void);
	void __fastcall SetShowSelection(const bool Value);
	void __fastcall SetPreviewHeight(const int Value);
	Graphics::TColor __fastcall GetSelectionColor(void);
	Graphics::TColor __fastcall GetSelectionFontColor(void);
	void __fastcall SetSelectionColor(const Graphics::TColor Value);
	void __fastcall SetSelectionFontColor(const Graphics::TColor Value);
	void __fastcall SetCompleteCheck(const TCompleteCheck* Value);
	Controls::TCursor __fastcall GetDragCursor(void);
	Controls::TDragKind __fastcall GetDragKind(void);
	HIDESBASE Controls::TDragMode __fastcall GetDragMode(void);
	void __fastcall SetDragCursor(const Controls::TCursor Value);
	void __fastcall SetDragKind(const Controls::TDragKind Value);
	void __fastcall SetDragModeEx(const Controls::TDragMode Value);
	void __fastcall SetSortColumn(const int Value);
	void __fastcall SetSortDirection(const TSortDirection Value);
	void __fastcall SetSorted(const bool Value);
	TTodoItem* __fastcall GetSelected(void);
	Graphics::TFont* __fastcall GetHeaderFont(void);
	void __fastcall SetHeaderFont(const Graphics::TFont* Value);
	int __fastcall GetEditColumn(void);
	void __fastcall SetEditColumn(const int Value);
	bool __fastcall GetTabStopEx(void);
	void __fastcall SetTabStopEx(const bool Value);
	int __fastcall GetTabOrderEx(void);
	void __fastcall SetTabOrderEx(const int Value);
	void __fastcall SetCompletionGraphic(const bool Value);
	void __fastcall SetHeaderDragDrop(const bool Value);
	void __fastcall SetHintShowFullText(const bool Value);
	void __fastcall SetNullDate(const System::UnicodeString Value);
	TTodoItem* __fastcall GetEditItem(void);
	Graphics::TColor __fastcall GetSelectionColorTo(void);
	void __fastcall SetSelectionColorTo(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetActiveColumnColor(void);
	void __fastcall SetActiveColumnColor(const Graphics::TColor Value);
	bool __fastcall GetUseTab(void);
	void __fastcall SetUseTab(const bool Value);
	bool __fastcall GetMultiSelect(void);
	void __fastcall SetMultiSelect(const bool Value);
	int __fastcall GetSelCount(void);
	bool __fastcall GetItemSelected(int Index);
	void __fastcall SetItemSelected(int Index, const bool Value);
	bool __fastcall GetShowPriorityText(void);
	void __fastcall SetShowPriorityText(const bool Value);
	void __fastcall LisBoxHorizontalScroll(System::TObject* Sender);
	void __fastcall SetCategory(const Classes::TStringList* Value);
	Graphics::TColor __fastcall GetActiveItemColor(void);
	Graphics::TColor __fastcall GetActiveItemColorTo(void);
	void __fastcall SetActiveItemColor(const Graphics::TColor Value);
	void __fastcall SetActiveItemColorTo(const Graphics::TColor Value);
	bool __fastcall GetScrollHorizontal(void);
	void __fastcall SetScrollHorizontal(const bool Value);
	Graphics::TColor __fastcall GetHeaderColor(void);
	Graphics::TColor __fastcall GetHeaderColorTo(void);
	void __fastcall SetHeaderColor(const Graphics::TColor Value);
	void __fastcall SetHeaderColorTo(const Graphics::TColor Value);
	Graphics::TBitmap* __fastcall GetHandleGlyph(void);
	void __fastcall SetHandleGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetHeaderImages(const Controls::TImageList* Value);
	Controls::TImageList* __fastcall GetHeaderImages(void);
	int __fastcall GetHeaderHeight(void);
	void __fastcall SetHeaderHeight(const int Value);
	Graphics::TColor __fastcall GetGridLineColor(void);
	void __fastcall SetGridLineColor(const Graphics::TColor Value);
	Graphics::TColor __fastcall GetPreviewColor(void);
	Graphics::TColor __fastcall GetPreviewColorTo(void);
	void __fastcall SetPreviewColor(const Graphics::TColor Value);
	void __fastcall SetPreviewColorTo(const Graphics::TColor Value);
	bool __fastcall GetStretchLastColumn(void);
	void __fastcall SetStretchLastColumn(const bool Value);
	Graphics::TColor __fastcall GetHeaderActiveColor(void);
	Graphics::TColor __fastcall GetHeaderActiveColorTo(void);
	void __fastcall SetHeaderActiveColor(const Graphics::TColor Value);
	void __fastcall SetHeaderActiveColorTo(const Graphics::TColor Value);
	void __fastcall SetLook(const TTodoListStyle Value);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall ThemeAdapt(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetTotalTimeSuffix(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	void __fastcall ListMouseMove(System::TObject* Sender, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListMouseUp(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall ListKeyUp(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ListKeyDown(System::TObject* Sender, System::Word &Key, Classes::TShiftState Shift);
	void __fastcall ListKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall ListClick(System::TObject* Sender);
	void __fastcall ListDblClick(System::TObject* Sender);
	void __fastcall ListDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall ListDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, Controls::TDragState State, bool &Accept);
	void __fastcall ListStartDrag(System::TObject* Sender, Controls::TDragObject* &DragObject);
	void __fastcall ListEndDrag(System::TObject* Sender, System::TObject* Target, int X, int Y);
	void __fastcall ListEnter(System::TObject* Sender);
	void __fastcall ListExit(System::TObject* Sender);
	void __fastcall ListSelect(System::TObject* Sender);
	void __fastcall HeaderClick(System::TObject* Sender, int Section);
	void __fastcall HeaderRightClick(System::TObject* Sender, int Section);
	void __fastcall CheckChanged(System::TObject* Sender);
	int __fastcall CompareItems(int A, int B);
	void __fastcall SwapItems(int A, int B);
	void __fastcall QuickSortItems(int Left, int Right);
	virtual bool __fastcall AllowAutoDelete(TTodoItem* ATodoItem);
	virtual bool __fastcall AllowAutoInsert(TTodoItem* ATodoItem);
	virtual void __fastcall ItemSelect(TTodoItem* ATodoItem);
	virtual void __fastcall EditDone(TTodoData Data, TTodoItem* EditItem);
	void __fastcall CompleteClick(int ItemIndex);
	virtual void __fastcall EditStart(void);
	__property TTodoListBox* TodoListBox = {read=FTodoListBox};
	void __fastcall ColumnsChanged(System::TObject* Sender);
	System::UnicodeString __fastcall FormatDateTimeEx(System::UnicodeString Format, System::TDateTime dt);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual int __fastcall GetVersionNr(void);
	virtual System::UnicodeString __fastcall GetVersionString(void);
	
public:
	__fastcall virtual TCustomTodoList(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomTodoList(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall SetFocus(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	virtual System::UnicodeString __fastcall StatusToString(TTodoStatus AValue);
	virtual TTodoStatus __fastcall StringToStatus(System::UnicodeString AValue);
	virtual System::UnicodeString __fastcall PriorityToString(TTodoPriority AValue);
	virtual TTodoPriority __fastcall StringToPriority(System::UnicodeString AValue);
	virtual System::UnicodeString __fastcall StatusCommaText(void);
	virtual System::UnicodeString __fastcall PriorityCommaText(void);
	void __fastcall SaveToStream(Classes::TStream* S);
	void __fastcall LoadFromStream(Classes::TStream* S);
	virtual void __fastcall ImportFromCSV(System::UnicodeString FileName);
	void __fastcall ExportToCSV(System::UnicodeString FileName);
	void __fastcall SaveToFile(System::UnicodeString FileName);
	void __fastcall LoadFromFile(System::UnicodeString FileName);
	void __fastcall SaveColumns(System::UnicodeString FileName);
	void __fastcall LoadColumns(System::UnicodeString FileName);
	void __fastcall Sort(void);
	void __fastcall HideEditor(void);
	void __fastcall ShowEditor(int Index, int Column);
	void __fastcall SelectAll(void);
	__property int VersionNr = {read=GetVersionNr, nodefault};
	__property System::UnicodeString VersionString = {read=GetVersionString};
	__property TTodoListBox* List = {read=FTodoListBox};
	__property TTodoItem* Selected = {read=GetSelected};
	__property bool ItemSelected[int Index] = {read=GetItemSelected, write=SetItemSelected};
	__property int EditColumn = {read=GetEditColumn, write=SetEditColumn, nodefault};
	__property TTodoItem* EditItem = {read=GetEditItem};
	void __fastcall AddColumn(TTodoData Data, System::UnicodeString ACaption);
	void __fastcall RemoveColumn(TTodoData Data);
	__property Graphics::TColor ActiveColumnColor = {read=GetActiveColumnColor, write=SetActiveColumnColor, nodefault};
	__property Graphics::TColor ActiveItemColor = {read=GetActiveItemColor, write=SetActiveItemColor, nodefault};
	__property Graphics::TColor ActiveItemColorTo = {read=GetActiveItemColorTo, write=SetActiveItemColorTo, nodefault};
	__property Align = {default=0};
	__property bool AutoAdvanceEdit = {read=FAutoAdvanceEdit, write=FAutoAdvanceEdit, nodefault};
	__property bool AutoInsertItem = {read=FAutoInsertItem, write=FAutoInsertItem, default=1};
	__property bool AutoDeleteItem = {read=FAutoDeleteItem, write=FAutoDeleteItem, default=1};
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, default=0};
	__property Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property Classes::TStringList* Category = {read=FCategory, write=SetCategory};
	__property Graphics::TColor Color = {read=GetColor, write=SetColor, nodefault};
	__property TTodoColumnCollection* Columns = {read=GetTodoColumns, write=SetTodoColumns};
	__property TCompleteCheck* CompleteCheck = {read=FCompleteCheck, write=SetCompleteCheck};
	__property Graphics::TFont* CompletionFont = {read=GetCompletionFont, write=SetCompletionFont};
	__property bool CompletionGraphic = {read=FCompletionGraphic, write=SetCompletionGraphic, default=1};
	__property Cursor = {default=0};
	__property System::UnicodeString DateFormat = {read=GetDateFormat, write=SetDateFormat};
	__property Controls::TCursor DragCursor = {read=GetDragCursor, write=SetDragCursor, nodefault};
	__property Controls::TDragMode DragMode = {read=GetDragMode, write=SetDragModeEx, nodefault};
	__property Controls::TDragKind DragKind = {read=GetDragKind, write=SetDragKind, nodefault};
	__property bool Editable = {read=GetEditable, write=SetEditable, nodefault};
	__property TEditColors* EditColors = {read=FEditColors, write=FEditColors};
	__property bool EditSelectAll = {read=GetSelectAllInSubjectEdit, write=SetSelectAllInSubjectEdit, nodefault};
	__property Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property TGridLineStyle GridLines = {read=GetGridLines, write=SetGridLines, default=2};
	__property Graphics::TColor GridLineColor = {read=GetGridLineColor, write=SetGridLineColor, nodefault};
	__property Graphics::TBitmap* HandleGlyph = {read=GetHandleGlyph, write=SetHandleGlyph};
	__property Graphics::TColor HeaderColor = {read=GetHeaderColor, write=SetHeaderColor, nodefault};
	__property Graphics::TColor HeaderColorTo = {read=GetHeaderColorTo, write=SetHeaderColorTo, nodefault};
	__property Graphics::TColor HeaderActiveColor = {read=GetHeaderActiveColor, write=SetHeaderActiveColor, nodefault};
	__property Graphics::TColor HeaderActiveColorTo = {read=GetHeaderActiveColorTo, write=SetHeaderActiveColorTo, nodefault};
	__property bool HeaderDragDrop = {read=FHeaderDragDrop, write=SetHeaderDragDrop, default=0};
	__property Graphics::TFont* HeaderFont = {read=GetHeaderFont, write=SetHeaderFont};
	__property int HeaderHeight = {read=GetHeaderHeight, write=SetHeaderHeight, nodefault};
	__property Controls::TImageList* HeaderImages = {read=GetHeaderImages, write=SetHeaderImages};
	__property bool HintShowFullText = {read=FHintShowFullText, write=SetHintShowFullText, default=0};
	__property Controls::TImageList* Images = {read=GetImages, write=SetImages};
	__property TTodoItemCollection* Items = {read=GetTodoItems, write=SetTodoItems};
	__property int ItemHeight = {read=GetItemHeight, write=SetItemHeight, nodefault};
	__property TTodoListStyle Look = {read=FLook, write=SetLook, default=0};
	__property bool MultiSelect = {read=GetMultiSelect, write=SetMultiSelect, nodefault};
	__property System::UnicodeString NullDate = {read=FNullDate, write=SetNullDate};
	__property bool Preview = {read=GetPreview, write=SetPreview, nodefault};
	__property Graphics::TFont* PreviewFont = {read=GetPreviewFont, write=SetPreviewFont};
	__property Graphics::TColor PreviewColor = {read=GetPreviewColor, write=SetPreviewColor, nodefault};
	__property Graphics::TColor PreviewColorTo = {read=GetPreviewColorTo, write=SetPreviewColorTo, nodefault};
	__property int PreviewHeight = {read=FPreviewHeight, write=SetPreviewHeight, nodefault};
	__property Graphics::TFont* PriorityFont = {read=GetPriorityFont, write=SetPriorityFont};
	__property TPriorityStrings* PriorityStrings = {read=FPriorityStrings, write=FPriorityStrings};
	__property int PriorityListWidth = {read=FPriorityListWidth, write=FPriorityListWidth, nodefault};
	__property TProgressLook* ProgressLook = {read=GetProgressLook, write=SetProgressLook};
	__property bool ScrollHorizontal = {read=GetScrollHorizontal, write=SetScrollHorizontal, nodefault};
	__property int SelCount = {read=GetSelCount, nodefault};
	__property Graphics::TColor SelectionColor = {read=GetSelectionColor, write=SetSelectionColor, nodefault};
	__property Graphics::TColor SelectionColorTo = {read=GetSelectionColorTo, write=SetSelectionColorTo, nodefault};
	__property Graphics::TColor SelectionFontColor = {read=GetSelectionFontColor, write=SetSelectionFontColor, nodefault};
	__property bool ShowPriorityText = {read=GetShowPriorityText, write=SetShowPriorityText, nodefault};
	__property bool ShowSelection = {read=GetShowSelection, write=SetShowSelection, nodefault};
	__property bool Sorted = {read=FSorted, write=SetSorted, nodefault};
	__property TSortDirection SortDirection = {read=FSortDirection, write=SetSortDirection, nodefault};
	__property int SortColumn = {read=FSortColumn, write=SetSortColumn, nodefault};
	__property TStatusStrings* StatusStrings = {read=FStatusStrings, write=FStatusStrings};
	__property int StatusListWidth = {read=FStatusListWidth, write=FStatusListWidth, nodefault};
	__property bool StretchLastColumn = {read=GetStretchLastColumn, write=SetStretchLastColumn, nodefault};
	__property bool TabStop = {read=GetTabStopEx, write=SetTabStopEx, nodefault};
	__property int TabOrder = {read=GetTabOrderEx, write=SetTabOrderEx, nodefault};
	__property bool UseTab = {read=GetUseTab, write=SetUseTab, nodefault};
	__property Classes::TNotifyEvent OnClick = {read=FOnClick, write=FOnClick};
	__property TCompleteClick OnCompleteClick = {read=FOnCompleteClick, write=FOnCompleteClick};
	__property Classes::TNotifyEvent OnDblClick = {read=FOnDblClick, write=FOnDblClick};
	__property Controls::TDragDropEvent OnDragDrop = {read=FOnDragDrop, write=FOnDragDrop};
	__property Controls::TDragOverEvent OnDragOver = {read=FOnDragOver, write=FOnDragOver};
	__property Classes::TNotifyEvent OnEditDone = {read=FOnEditDone, write=FOnEditDone};
	__property Classes::TNotifyEvent OnEditStart = {read=FOnEditStart, write=FOnEditStart};
	__property Classes::TNotifyEvent OnExit = {read=FOnExit, write=FOnExit};
	__property Classes::TNotifyEvent OnEnter = {read=FOnEnter, write=FOnEnter};
	__property TListHeaderEvent OnHeaderClick = {read=FOnHeaderClick, write=FOnHeaderClick};
	__property TOnHeaderDragDropEvent OnHeaderDragDrop = {read=FOnHeaderDragDrop, write=FOnHeaderDragDrop};
	__property TListHeaderEvent OnHeaderRightClick = {read=FOnHeaderRightClick, write=FOnHeaderRightClick};
	__property TTodoItemEvent OnItemDelete = {read=FOnItemDelete, write=FOnItemDelete};
	__property TTodoItemEvent OnItemInsert = {read=FOnItemInsert, write=FOnItemInsert};
	__property TTodoItemSelectEvent OnItemSelect = {read=FOnItemSelect, write=FOnItemSelect};
	__property TTodoItemSelectEvent OnItemRightClick = {read=FOnItemRightClick, write=FOnItemRightClick};
	__property Controls::TStartDragEvent OnStartDrag = {read=FOnStartDrag, write=FOnStartDrag};
	__property Controls::TEndDragEvent OnEndDrag = {read=FOnEndDrag, write=FOnEndDrag};
	__property Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property Controls::TKeyEvent OnKeyUp = {read=FOnKeyUp, write=FOnKeyUp};
	__property Controls::TKeyPressEvent OnKeyPress = {read=FOnKeyPress, write=FOnKeyPress};
	__property Controls::TMouseMoveEvent OnMouseMove = {read=FOnMouseMove, write=FOnMouseMove};
	__property Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
	__property TStatusToStringEvent OnStatusToString = {read=FOnStatusToString, write=FOnStatusToString};
	__property TStringToStatusEvent OnStringToStatus = {read=FOnStringToStatus, write=FOnStringToStatus};
	__property TPriorityToStringEvent OnPriorityToString = {read=FOnPriorityToString, write=FOnPriorityToString};
	__property TStringToPriorityEvent OnStringToPriority = {read=FOnStringToPriority, write=FOnStringToPriority};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property System::UnicodeString TotalTimeSuffix = {read=FTotalTimeSuffix, write=SetTotalTimeSuffix};
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomTodoList(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


class DELPHICLASS TTodoList;
class PASCALIMPLEMENTATION TTodoList : public TCustomTodoList
{
	typedef TCustomTodoList inherited;
	
__published:
	__property ActiveColumnColor;
	__property ActiveItemColor;
	__property ActiveItemColorTo;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property AutoAdvanceEdit;
	__property AutoInsertItem = {default=1};
	__property AutoDeleteItem = {default=1};
	__property AutoThemeAdapt = {default=0};
	__property BorderStyle = {default=1};
	__property Category;
	__property Color;
	__property Columns;
	__property CompleteCheck;
	__property CompletionFont;
	__property CompletionGraphic = {default=1};
	__property Cursor = {default=0};
	__property DateFormat;
	__property DragCursor;
	__property DragMode;
	__property DragKind;
	__property Editable;
	__property EditColors;
	__property EditSelectAll;
	__property Font;
	__property GridLines = {default=2};
	__property GridLineColor;
	__property HandleGlyph;
	__property HeaderActiveColor;
	__property HeaderActiveColorTo;
	__property HeaderColor;
	__property HeaderColorTo;
	__property HeaderDragDrop = {default=0};
	__property HeaderFont;
	__property HeaderHeight;
	__property HeaderImages;
	__property HintShowFullText = {default=0};
	__property Images;
	__property ItemHeight;
	__property Items;
	__property Look = {default=0};
	__property NullDate;
	__property MultiSelect;
	__property PopupMenu;
	__property Preview;
	__property PreviewFont;
	__property PreviewColor;
	__property PreviewColorTo;
	__property PreviewHeight;
	__property PriorityFont;
	__property PriorityStrings;
	__property PriorityListWidth;
	__property ProgressLook;
	__property ScrollHorizontal;
	__property SelCount;
	__property SelectionColor;
	__property SelectionColorTo;
	__property SelectionFontColor;
	__property ShowPriorityText;
	__property ShowSelection;
	__property Sorted;
	__property SortDirection;
	__property SortColumn;
	__property StatusStrings;
	__property StatusListWidth;
	__property StretchLastColumn;
	__property TabOrder;
	__property TabStop;
	__property UseTab;
	__property OnClick;
	__property OnCompleteClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEditDone;
	__property OnEditStart;
	__property OnEnter;
	__property OnExit;
	__property OnHeaderClick;
	__property OnHeaderDragDrop;
	__property OnHeaderRightClick;
	__property OnItemDelete;
	__property OnItemInsert;
	__property OnItemSelect;
	__property OnItemRightClick;
	__property OnStartDrag;
	__property OnEndDrag;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnStatusToString;
	__property OnStringToStatus;
	__property OnPriorityToString;
	__property OnStringToPriority;
	__property Version;
	__property TotalTimeSuffix;
public:
	/* TCustomTodoList.Create */ inline __fastcall virtual TTodoList(Classes::TComponent* AOwner) : TCustomTodoList(AOwner) { }
	/* TCustomTodoList.Destroy */ inline __fastcall virtual ~TTodoList(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTodoList(HWND ParentWindow) : TCustomTodoList(ParentWindow) { }
	
};


#pragma option push -b-
enum TGaugeOrientation { goHorizontal, goVertical };
#pragma option pop

struct TGaugeSettings
{
	
public:
	Graphics::TColor Level0Color;
	Graphics::TColor Level0ColorTo;
	Graphics::TColor Level1Color;
	Graphics::TColor Level1ColorTo;
	Graphics::TColor Level2Color;
	Graphics::TColor Level2ColorTo;
	Graphics::TColor Level3Color;
	Graphics::TColor Level3ColorTo;
	int Level1Perc;
	int Level2Perc;
	Graphics::TColor BorderColor;
	bool ShowBorder;
	bool Stacked;
	bool ShowPercentage;
	Graphics::TFont* Font;
	bool CompletionSmooth;
	bool ShowGradient;
	int Steps;
	int Position;
	Graphics::TColor BackgroundColor;
	TGaugeOrientation Orientation;
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt CHECKBOXSIZE = 0xe;
static const ShortInt STRSIZE = 0x2;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
#define DATE_VER L"May, 2010"
extern PACKAGE System::Word CF_TODOITEM;
extern PACKAGE void __fastcall CSVToLineFeeds(System::UnicodeString &s);
extern PACKAGE System::UnicodeString __fastcall DoubleToSingleChar(System::WideChar ch, const System::UnicodeString s);
extern PACKAGE int __fastcall SinglePos(System::WideChar p, System::UnicodeString s, int &sp);
extern PACKAGE int __fastcall VarCharPos(System::WideChar ch, const System::UnicodeString s, int &Res);
extern PACKAGE void __fastcall DrawGauge(Graphics::TCanvas* Canvas, const Types::TRect &R, int Position, const TGaugeSettings &Settings);
extern PACKAGE void __fastcall SaveProperty(Classes::TStream* S, System::Byte ID, void * Buffer, System::Word Size);
extern PACKAGE void __fastcall WriteInteger(Classes::TStream* S, int Value);
extern PACKAGE bool __fastcall ReadBoolean(Classes::TStream* S);
extern PACKAGE System::Byte __fastcall ReadByte(Classes::TStream* S);
extern PACKAGE System::TDateTime __fastcall ReadDateTime(Classes::TStream* S);
extern PACKAGE System::UnicodeString __fastcall ReadString(Classes::TStream* S, int Size);
extern PACKAGE System::Word __fastcall ReadWord(Classes::TStream* S);
extern PACKAGE int __fastcall ReadInteger(Classes::TStream* S);
extern PACKAGE double __fastcall ReadDouble(Classes::TStream* S);

}	/* namespace Todolist */
using namespace Todolist;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TodolistHPP
