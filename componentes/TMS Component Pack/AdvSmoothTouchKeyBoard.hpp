// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothtouchkeyboard.pas' rev: 21.00

#ifndef AdvsmoothtouchkeyboardHPP
#define AdvsmoothtouchkeyboardHPP

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
#include <Imglist.hpp>	// Pascal unit
#include <Dateutils.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothtouchkeyboard
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


#pragma option push -b-
enum TAdvSmoothCompletionRangeType { rtNumber, rtDateTime, rtCustom };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothCompletionStepType { stNumber, stSecond, stMinute, stHour, stDay, stMonth, stYear };
#pragma option pop

class DELPHICLASS TAdvSmoothCompletionCustomItem;
class DELPHICLASS TAdvSmoothCompletion;
class PASCALIMPLEMENTATION TAdvSmoothCompletionCustomItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Advgdip::TGPRectF FRect;
	TAdvSmoothCompletion* FOwner;
	double FValue;
	System::UnicodeString FText;
	int FImageIndex;
	System::UnicodeString FpictureName;
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetValue(const double Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetPictureName(const System::UnicodeString Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	
public:
	__fastcall virtual TAdvSmoothCompletionCustomItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothCompletionCustomItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property double Value = {read=FValue, write=SetValue};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property System::UnicodeString PictureName = {read=FpictureName, write=SetPictureName};
};


class DELPHICLASS TAdvSmoothCompletionCustomItems;
class PASCALIMPLEMENTATION TAdvSmoothCompletionCustomItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothCompletionCustomItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothCompletion* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothCompletionCustomItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothCompletionCustomItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothCompletionCustomItems(TAdvSmoothCompletion* AOwner);
	HIDESBASE TAdvSmoothCompletionCustomItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothCompletionCustomItem* __fastcall Insert(int Index);
	__property TAdvSmoothCompletionCustomItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothCompletionCustomItems(void) { }
	
};


class DELPHICLASS TAdvSmoothCompletionColumn;
class PASCALIMPLEMENTATION TAdvSmoothCompletionColumn : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::TDateTime FSaveDateRangeto;
	System::TDateTime FSaveDateRangeFrom;
	int FDrawIndex;
	double FSp;
	bool FAnimating;
	bool FAnimate;
	bool FMouseDown;
	bool FMouseUp;
	int FTimeStart;
	int FTimeStop;
	int FDragY;
	int FScrollY;
	int FClickX;
	int FClickY;
	int FCurrentScPos;
	int FScPosTo;
	TAdvSmoothCompletion* Fowner;
	bool FEnabled;
	bool FVisible;
	double FRangeFrom;
	double FRangeTo;
	double FSelectedValue;
	TAdvSmoothCompletionRangeType FRangeType;
	System::UnicodeString FHint;
	double FStep;
	System::UnicodeString FValueFormat;
	System::TDateTime FDateRangeTo;
	System::TDateTime FDateRangeFrom;
	System::UnicodeString FDateTimeValueFormat;
	TAdvSmoothCompletionStepType FStepType;
	TAdvSmoothCompletionCustomItems* FCustomItems;
	bool FCyclic;
	Graphics::TFont* FFont;
	int FWidth;
	Classes::TAlignment FTextAlign;
	bool FOnlyDate;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetRangeFrom(const double Value);
	void __fastcall SetRangeTo(const double Value);
	void __fastcall SetSelectedValue(const double Value);
	void __fastcall SetRangeType(const TAdvSmoothCompletionRangeType Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetStep(const double Value);
	void __fastcall SetValueFormat(const System::UnicodeString Value);
	void __fastcall SetDateRangeFrom(const System::TDateTime Value);
	void __fastcall SetDateRangeTo(const System::TDateTime Value);
	void __fastcall SetDateTimeValueFormat(const System::UnicodeString Value);
	void __fastcall SetStepType(const TAdvSmoothCompletionStepType Value);
	void __fastcall SetCustomItems(const TAdvSmoothCompletionCustomItems* Value);
	void __fastcall SetCyclic(const bool Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetWidth(const int Value);
	System::TDateTime __fastcall GetSelectedDateTime(void);
	void __fastcall SetSelectedDateTime(const System::TDateTime Value);
	void __fastcall SetTextAlign(const Classes::TAlignment Value);
	int __fastcall GetSelectedCustomIndex(void);
	void __fastcall SetSelectedCustomIndex(const int Value);
	void __fastcall SetOnlyDate(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall CustomItemsChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall SetAnimatedValue(void);
	Advgdip::TGPRectF __fastcall GetColumnRect(void);
	
public:
	__fastcall virtual TAdvSmoothCompletionColumn(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothCompletionColumn(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ScrollToValue(double Value, bool Animation = true, int AnimationSpeed = 0x4);
	void __fastcall Next(bool Animation = true);
	void __fastcall Previous(bool Animation = true);
	double __fastcall IncSteps(double StartValue, int nr);
	int __fastcall StepsFromTo(double StartValue, double EndValue);
	double __fastcall GetStep(void);
	int __fastcall GetRangeCount(void);
	double __fastcall GetRangeTo(void);
	double __fastcall GetRangeFrom(void);
	__property System::TDateTime SelectedDateTime = {read=GetSelectedDateTime, write=SetSelectedDateTime};
	__property int SelectedCustomIndex = {read=GetSelectedCustomIndex, write=SetSelectedCustomIndex, nodefault};
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property int Width = {read=FWidth, write=SetWidth, default=20};
	__property double RangeFrom = {read=FRangeFrom, write=SetRangeFrom};
	__property double RangeTo = {read=FRangeTo, write=SetRangeTo};
	__property System::TDateTime DateRangeFrom = {read=FDateRangeFrom, write=SetDateRangeFrom};
	__property System::TDateTime DateRangeTo = {read=FDateRangeTo, write=SetDateRangeTo};
	__property double Step = {read=FStep, write=SetStep};
	__property TAdvSmoothCompletionStepType StepType = {read=FStepType, write=SetStepType, default=0};
	__property double SelectedValue = {read=FSelectedValue, write=SetSelectedValue};
	__property System::UnicodeString ValueFormat = {read=FValueFormat, write=SetValueFormat};
	__property System::UnicodeString DateTimeValueFormat = {read=FDateTimeValueFormat, write=SetDateTimeValueFormat};
	__property TAdvSmoothCompletionRangeType RangeType = {read=FRangeType, write=SetRangeType, default=0};
	__property bool OnlyDate = {read=FOnlyDate, write=SetOnlyDate, default=0};
	__property TAdvSmoothCompletionCustomItems* CustomItems = {read=FCustomItems, write=SetCustomItems};
	__property bool Cyclic = {read=FCyclic, write=SetCyclic, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TAlignment TextAlign = {read=FTextAlign, write=SetTextAlign, default=2};
};


class DELPHICLASS TAdvSmoothCompletionColumns;
class PASCALIMPLEMENTATION TAdvSmoothCompletionColumns : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothCompletionColumn* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothCompletion* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothCompletionColumn* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothCompletionColumn* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothCompletionColumns(TAdvSmoothCompletion* AOwner);
	HIDESBASE TAdvSmoothCompletionColumn* __fastcall Add(void);
	HIDESBASE TAdvSmoothCompletionColumn* __fastcall Insert(int Index);
	__property TAdvSmoothCompletionColumn* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothCompletionColumns(void) { }
	
};


class DELPHICLASS TAdvSmoothCompletionColumnAppearance;
class PASCALIMPLEMENTATION TAdvSmoothCompletionColumnAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothCompletion* FOwner;
	bool FAutoSize;
	int FSpacing;
	Classes::TNotifyEvent FOnChange;
	Gdipfill::TGDIPFill* FFill;
	int FTextSpacing;
	Gdipfill::TGDIPFill* FDisabledFill;
	Gdipfill::TGDIPFill* FHoverFill;
	bool FAllowHovering;
	int FImageHeight;
	int FImageWidth;
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetTextSpacing(const int Value);
	void __fastcall SetDisabledFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHoverFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetAllowHovering(const bool Value);
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetImageHeight(const int Value);
	void __fastcall SetImageWidth(const int Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothCompletionColumnAppearance(TAdvSmoothCompletion* AOwner);
	__fastcall virtual ~TAdvSmoothCompletionColumnAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property bool AllowHovering = {read=FAllowHovering, write=SetAllowHovering, default=1};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=5};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Gdipfill::TGDIPFill* HoverFill = {read=FHoverFill, write=SetHoverFill};
	__property Gdipfill::TGDIPFill* DisabledFill = {read=FDisabledFill, write=SetDisabledFill};
	__property int TextSpacing = {read=FTextSpacing, write=SetTextSpacing, default=25};
	__property int ImageWidth = {read=FImageWidth, write=SetImageWidth, default=30};
	__property int ImageHeight = {read=FImageHeight, write=SetImageHeight, default=30};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


typedef void __fastcall (__closure *TAdvSmoothCompletionSelectedValueChangedEvent)(System::TObject* Sender, int Column, int SelectedCustomIndex, double SelectedValue, TAdvSmoothCompletionRangeType RangeType);

typedef void __fastcall (__closure *TAdvSmoothCompletionColumnHintEvent)(System::TObject* Sender, int Column, System::UnicodeString Hint);

class PASCALIMPLEMENTATION TAdvSmoothCompletion : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FUpdatecount;
	Types::TRect FRect;
	bool FFocused;
	bool FConstructed;
	int FFocusedColumn;
	Extctrls::TTimer* FAnimateTimer;
	bool FDesignTime;
	int FHoveredColumn;
	TAdvSmoothCompletionColumnAppearance* FColumnAppearance;
	Gdipfill::TGDIPFill* FFill;
	Gdipfill::TGDIPFill* FSelectedFill;
	int FSelectedHeight;
	TAdvSmoothCompletionColumns* FColumns;
	int FAnimationFactor;
	TAdvSmoothCompletionSelectedValueChangedEvent FOnSelectedValueChanged;
	TAdvSmoothCompletionColumnHintEvent FOnColumnHint;
	Gdippicturecontainer::TGDIPPictureContainer* FContainer;
	Imglist::TCustomImageList* FImages;
	bool FReadOnly;
	Gdipfill::TGDIPFill* FBottomLayerFill;
	Gdipfill::TGDIPFill* FTopLayerFill;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall SetColumnAppearance(const TAdvSmoothCompletionColumnAppearance* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSelectedFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSelectedHeight(const int Value);
	void __fastcall SetColumns(const TAdvSmoothCompletionColumns* Value);
	void __fastcall SetAnimationFactor(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetBottomLayerFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetTopLayerFill(const Gdipfill::TGDIPFill* Value);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall ColumnAppearanceChanged(System::TObject* Sender);
	void __fastcall ColumnsChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Types::TRect &r);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall DrawColumns(Advgdip::TGPGraphics* g);
	void __fastcall DrawTopLayer(Advgdip::TGPGraphics* g);
	void __fastcall DrawSelectedLayer(Advgdip::TGPGraphics* g);
	void __fastcall InitPreview(void);
	void __fastcall Animate(System::TObject* Sender);
	Types::TRect __fastcall InsideRect(void);
	Types::TRect __fastcall GetSelectedRect(void);
	int __fastcall GetVersionNr(void);
	int __fastcall XYToCustomItem(int X, int Y);
	
public:
	__fastcall virtual TAdvSmoothCompletion(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothCompletion(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	DYNAMIC void __fastcall MouseWheelHandler(Messages::TMessage &Message);
	int __fastcall XYToColumn(int X, int Y);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	
__published:
	__property int AnimationFactor = {read=FAnimationFactor, write=SetAnimationFactor, default=4};
	__property TAdvSmoothCompletionColumns* Columns = {read=FColumns, write=SetColumns};
	__property TAdvSmoothCompletionColumnAppearance* ColumnAppearance = {read=FColumnAppearance, write=SetColumnAppearance};
	__property Gdipfill::TGDIPFill* SelectedFill = {read=FSelectedFill, write=SetSelectedFill};
	__property int SelectedHeight = {read=FSelectedHeight, write=SetSelectedHeight, default=30};
	__property Gdipfill::TGDIPFill* TopLayerFill = {read=FTopLayerFill, write=SetTopLayerFill};
	__property Gdipfill::TGDIPFill* BottomLayerFill = {read=FBottomLayerFill, write=SetBottomLayerFill};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TAdvSmoothCompletionSelectedValueChangedEvent OnSelectedValueChanged = {read=FOnSelectedValueChanged, write=FOnSelectedValueChanged};
	__property TAdvSmoothCompletionColumnHintEvent OnColumnHint = {read=FOnColumnHint, write=FOnColumnHint};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property Enabled = {default=1};
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
	__property OnDblClick;
	__property OnClick;
	__property OnEnter;
	__property OnExit;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property Visible = {default=1};
	__property TabStop = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothCompletion(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothTouchKeyBoardAutoForm;
class DELPHICLASS TAdvSmoothTouchKeyBoard;
class PASCALIMPLEMENTATION TAdvSmoothTouchKeyBoardAutoForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	int FMmx;
	int FMmy;
	int FMdx;
	int FMdy;
	void *OldWndProc;
	void *NewWndProc;
	Advgdip::TGPBitmap* FMainBuffer;
	TAdvSmoothTouchKeyBoard* FKeyBoard;
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DoCreate(void);
	virtual void __fastcall DoDestroy(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall Draw(Advgdip::TGPGraphics* graphics);
	void __fastcall CreateMainBuffer(void);
	void __fastcall DestroyMainBuffer(void);
	void __fastcall ClearBuffer(Advgdip::TGPGraphics* graphics);
	Advgdip::TGPGraphics* __fastcall CreateGraphics(void);
	void __fastcall SetLayeredWindow(void);
	void __fastcall UpdateLayered(void);
	void __fastcall UpdateMainWindow(System::Byte Alpha);
	void __fastcall UpdateWindow(void);
	HIDESBASE void __fastcall SetPosition(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall HookWndProc(Messages::TMessage &Msg);
	
public:
	void __fastcall Init(void);
	__fastcall virtual TAdvSmoothTouchKeyBoardAutoForm(Classes::TComponent* AOwner, int Dummy);
	__property TAdvSmoothTouchKeyBoard* KeyBoard = {read=FKeyBoard, write=FKeyBoard};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmoothTouchKeyBoardAutoForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmoothTouchKeyBoardAutoForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothTouchKeyBoardAutoForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothTouchKeyBoardForm;
class DELPHICLASS TAdvSmoothTouchKeyItem;
class PASCALIMPLEMENTATION TAdvSmoothTouchKeyBoardForm : public Forms::TForm
{
	typedef Forms::TForm inherited;
	
private:
	void *OldWndProc;
	void *NewWndProc;
	Advgdip::TGPBitmap* FMainBuffer;
	TAdvSmoothTouchKeyBoard* FKeyBoard;
	TAdvSmoothTouchKeyItem* fKeyBoardItem;
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Messages::TWMMouseActivate &Msg);
	HIDESBASE MESSAGE void __fastcall WMActivate(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DoCreate(void);
	virtual void __fastcall DoDestroy(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall Draw(Advgdip::TGPGraphics* graphics);
	void __fastcall CreateMainBuffer(void);
	void __fastcall DestroyMainBuffer(void);
	void __fastcall ClearBuffer(Advgdip::TGPGraphics* graphics);
	Advgdip::TGPGraphics* __fastcall CreateGraphics(void);
	void __fastcall SetLayeredWindow(void);
	void __fastcall UpdateLayered(void);
	void __fastcall UpdateMainWindow(System::Byte Alpha);
	void __fastcall UpdateWindow(void);
	HIDESBASE void __fastcall SetPosition(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall HookWndProc(Messages::TMessage &Msg);
	
public:
	void __fastcall Init(void);
	__fastcall virtual TAdvSmoothTouchKeyBoardForm(Classes::TComponent* AOwner, int Dummy);
	__property TAdvSmoothTouchKeyBoard* KeyBoard = {read=FKeyBoard, write=FKeyBoard};
	__property TAdvSmoothTouchKeyItem* KeyBoardItem = {read=fKeyBoardItem, write=fKeyBoardItem};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmoothTouchKeyBoardForm(Classes::TComponent* AOwner) : Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmoothTouchKeyBoardForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothTouchKeyBoardForm(HWND ParentWindow) : Forms::TForm(ParentWindow) { }
	
};


#pragma option push -b-
enum TAdvSmoothTouchSpecialKey { skNone, skAlt, skAltGr, skShift, skCaps, skCtrl, skNum, skScroll, skReturn, skAdd, skDivide, skDecimal, skSubstract, skMultiply, skTab, skWin, skApp, skBackSpace, skSpaceBar, skLeft, skRight, skUp, skDown, skNext, skPrior, skHome, skEnd };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothTouchKeyEvent)(System::TObject* Sender, int Index);

typedef void __fastcall (__closure *TAdvSmoothTouchQueryWindowHandleEvent)(System::TObject* Sender, HWND &hw);

class DELPHICLASS TAdvSmoothSubKeyItem;
class PASCALIMPLEMENTATION TAdvSmoothSubKeyItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Advgdip::TGPRectF FSubKeyCaptionRect;
	Advgdip::TGPRectF FSubKeyRect;
	TAdvSmoothTouchKeyBoard* FOwner;
	System::UnicodeString FCaption;
	void __fastcall SetCaption(const System::UnicodeString Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	
public:
	__fastcall virtual TAdvSmoothSubKeyItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothSubKeyItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
};


class DELPHICLASS TAdvSmoothSubKeyCollection;
class PASCALIMPLEMENTATION TAdvSmoothSubKeyCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothSubKeyItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothTouchKeyBoard* FOwner;
	HIDESBASE TAdvSmoothSubKeyItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothSubKeyItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothSubKeyCollection(TAdvSmoothTouchKeyBoard* AOwner);
	HIDESBASE TAdvSmoothSubKeyItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothSubKeyItem* __fastcall Insert(int index);
	__property TAdvSmoothSubKeyItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothSubKeyCollection(void) { }
	
};


class PASCALIMPLEMENTATION TAdvSmoothTouchKeyItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvSmoothTouchKeyBoard* FOwner;
	double FOldW;
	double FOldH;
	double FOldX;
	double FOldY;
	bool FKeyNormalPosition;
	int FDownState;
	System::UnicodeString FAltGrCaption;
	Graphics::TColor FTextColor;
	int FAltGrKeyValue;
	int FWidth;
	Graphics::TColor FColor;
	System::UnicodeString FCaption;
	int FX;
	int FY;
	System::UnicodeString FShortCut;
	System::UnicodeString FShiftCaption;
	Graphics::TColor FTextColorDown;
	int FKeyValue;
	TAdvSmoothTouchSpecialKey FSpecialKey;
	int fShiftKeyValue;
	int FHeight;
	Graphics::TColor FColorDown;
	TAdvSmoothSubKeyCollection* FSubKeys;
	Advgdip::TAdvGDIPPicture* FImage;
	System::UnicodeString FImageName;
	int FImageIndex;
	bool FShowBackGround;
	void __fastcall SetAltGrCaption(const System::UnicodeString Value);
	void __fastcall SetAltGrKeyValue(const int Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetKeyvalue(const int Value);
	void __fastcall SetpecialKey(const TAdvSmoothTouchSpecialKey Value);
	void __fastcall SetShiftCaption(const System::UnicodeString Value);
	void __fastcall SetShiftKeyValue(const int Value);
	void __fastcall SetShortCut(const System::UnicodeString Value);
	void __fastcall SetTextColor(const Graphics::TColor Value);
	void __fastcall SetTextColorDown(const Graphics::TColor Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetX(const int Value);
	void __fastcall SetY(const int Value);
	void __fastcall SetSubKeys(const TAdvSmoothSubKeyCollection* Value);
	void __fastcall SetImage(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetImageName(const System::UnicodeString Value);
	void __fastcall SetShowBackGround(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall ImageChanged(System::TObject* Sender);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, Advgdip::TGPFont* f, Advgdip::TGPFont* fs, Advgdip::TGPStringFormat* sf, Advgdip::TGPStringFormat* sfs);
	void __fastcall DrawBG(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, Graphics::TColor c);
	double __fastcall GetWidthSubKeys(void);
	double __fastcall GetHeightSubKeys(void);
	void __fastcall InitKeys(int StartX, int StartY);
	int __fastcall XYToSubKey(int X, int Y);
	
public:
	__fastcall virtual TAdvSmoothTouchKeyItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothTouchKeyItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString ShiftCaption = {read=FShiftCaption, write=SetShiftCaption};
	__property System::UnicodeString AltGrCaption = {read=FAltGrCaption, write=SetAltGrCaption};
	__property int KeyValue = {read=FKeyValue, write=SetKeyvalue, nodefault};
	__property int ShiftKeyValue = {read=fShiftKeyValue, write=SetShiftKeyValue, nodefault};
	__property int AltGrKeyValue = {read=FAltGrKeyValue, write=SetAltGrKeyValue, nodefault};
	__property TAdvSmoothTouchSpecialKey SpecialKey = {read=FSpecialKey, write=SetpecialKey, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, default=8421504};
	__property Graphics::TColor TextColor = {read=FTextColor, write=SetTextColor, default=0};
	__property Graphics::TColor TextColorDown = {read=FTextColorDown, write=SetTextColorDown, default=0};
	__property System::UnicodeString ShortCut = {read=FShortCut, write=SetShortCut};
	__property int X = {read=FX, write=SetX, default=-1};
	__property int Y = {read=FY, write=SetY, default=-1};
	__property int Height = {read=FHeight, write=SetHeight, default=40};
	__property int Width = {read=FWidth, write=SetWidth, default=40};
	__property TAdvSmoothSubKeyCollection* SubKeys = {read=FSubKeys, write=SetSubKeys};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property System::UnicodeString ImageName = {read=FImageName, write=SetImageName};
	__property Advgdip::TAdvGDIPPicture* Image = {read=FImage, write=SetImage};
	__property bool ShowBackGround = {read=FShowBackGround, write=SetShowBackGround, default=1};
};


class DELPHICLASS TAdvSmoothTouchKeyCollection;
class PASCALIMPLEMENTATION TAdvSmoothTouchKeyCollection : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothTouchKeyItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothTouchKeyBoard* FOwner;
	HIDESBASE TAdvSmoothTouchKeyItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothTouchKeyItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothTouchKeyCollection(TAdvSmoothTouchKeyBoard* AOwner);
	HIDESBASE TAdvSmoothTouchKeyItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothTouchKeyItem* __fastcall Insert(int index);
	__property TAdvSmoothTouchKeyItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothTouchKeyCollection(void) { }
	
};


#pragma option push -b-
enum TAdvSmoothTouchKeyBoardType { ktQWERTY, ktAZERTY, ktDVORAK, ktNUMERIC, ktCELLPHONE, ktQWERTZ, ktCustom };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothTouchKeyBoardDrawKeyEvent)(System::TObject* Sender, TAdvSmoothTouchKeyItem* Key, Graphics::TCanvas* Canvas, bool Down, const Types::TRect &Rect, bool &DefaultDraw);

struct TKeyCachedBitmap
{
	
public:
	Advgdip::TGPBitmap* CachedBitmap;
	int ID;
	double Width;
	double Height;
};


#pragma option push -b-
enum TAdvSmoothTouchKeyBoardCompletionMode { cmNotVisible, cmAlwaysVisible, cmAutoVisible };
#pragma option pop

class DELPHICLASS TAdvSmoothTouchKeyBoardCompletion;
class PASCALIMPLEMENTATION TAdvSmoothTouchKeyBoardCompletion : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	System::UnicodeString FLookup;
	TAdvSmoothTouchKeyBoard* FOwner;
	TAdvSmoothCompletion* FCompletion;
	Classes::TStringList* FItems;
	TAdvSmoothTouchKeyBoardCompletionMode FMode;
	bool FLookupCaseSensitive;
	int FLookupFromChars;
	Graphics::TColor FColor;
	Graphics::TFont* FFont;
	void __fastcall SetItems(const Classes::TStringList* Value);
	void __fastcall SetMode(const TAdvSmoothTouchKeyBoardCompletionMode Value);
	void __fastcall SetLookupCaseSensitive(const bool Value);
	void __fastcall SetLookupFromChars(const int Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall ItemsChanged(System::TObject* Sender);
	void __fastcall CompletionChanged(System::TObject* Sender);
	void __fastcall UpdateCompletion(System::UnicodeString Filter = L"");
	
public:
	__fastcall TAdvSmoothTouchKeyBoardCompletion(TAdvSmoothTouchKeyBoard* AOwner);
	__fastcall virtual ~TAdvSmoothTouchKeyBoardCompletion(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall ApplySettings(void);
	
__published:
	__property Classes::TStringList* LookupList = {read=FItems, write=SetItems};
	__property int LookupFromChars = {read=FLookupFromChars, write=SetLookupFromChars, default=3};
	__property bool LookupCaseSensitive = {read=FLookupCaseSensitive, write=SetLookupCaseSensitive, default=0};
	__property TAdvSmoothTouchKeyBoardCompletionMode Mode = {read=FMode, write=SetMode, default=2};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
};


#pragma option push -b-
enum TAutoSizeLayout { aslKeys, aslKeyboard };
#pragma option pop

class PASCALIMPLEMENTATION TAdvSmoothTouchKeyBoard : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	typedef DynamicArray<TKeyCachedBitmap> _TAdvSmoothTouchKeyBoard__1;
	
	
private:
	TAdvSmoothTouchKeyBoardAutoForm* FAutoCompletionForm;
	_TAdvSmoothTouchKeyBoard__1 FCachedBitmaps;
	bool FMouseUp;
	bool FMouseDown;
	TAdvSmoothTouchKeyBoardForm* FSubKeyForm;
	TAdvSmoothTouchKeyItem* FDownKey;
	int FSubKeyTime;
	int FSubKeyCheck;
	Extctrls::TTimer* FTimer;
	Extctrls::TTimer* FCheckTimer;
	bool DoAutoZoom;
	int FOriginalW;
	int FOriginalH;
	TAdvSmoothTouchKeyCollection* FKeys;
	Controls::TKeyEvent FOnKeyDown;
	Graphics::TBitmap* FPictureNormalState;
	Graphics::TBitmap* FPictureDownState;
	Graphics::TFont* FSmallFont;
	TAdvSmoothTouchKeyBoardType FKeyboardType;
	Classes::TShiftState FShift;
	bool FAutoPostKey;
	Graphics::TColor FHighlightCaps;
	bool FAutoCapsDisplay;
	Graphics::TColor FHighlightAltGr;
	Extctrls::TTimer* FRepeatTimer;
	int FRepeatTimerCount;
	int FRepeatItemIndex;
	TAdvSmoothTouchKeyEvent FOnKeyClick;
	TAdvSmoothTouchQueryWindowHandleEvent FOnQueryWindowHandle;
	int FKeyDistance;
	int FOldW;
	int FOldH;
	bool FPostWMCharOnly;
	bool FCapsDown;
	Gdipfill::TGDIPFill* FFill;
	Gdippicturecontainer::TGDIPPictureContainer* FPictureContainer;
	TAdvSmoothTouchKeyBoardCompletion* FAutoCompletion;
	int FSubKeyHidePause;
	int FSubKeyShowPause;
	Controls::TImageList* FImages;
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall SetKeys(const TAdvSmoothTouchKeyCollection* Value);
	void __fastcall SetSmallFont(const Graphics::TFont* Value);
	void __fastcall SeTAdvSmoothTouchKeyBoardType(const TAdvSmoothTouchKeyBoardType Value);
	void __fastcall AddSubKey(System::UnicodeString Caption);
	void __fastcall AddKey(System::ShortString &Caption, System::ShortString &ShiftCaption, System::ShortString &AltGrCaption, int KeyValue, int ShiftKeyValue, int AltGrKeyValue, int ImageIndex, int Width, int Height, int &X, int Y, TAdvSmoothTouchSpecialKey SpecialKey, Graphics::TColor Color = (Graphics::TColor)(0xc0c0c0));
	void __fastcall NewRow(int &X, int &Y, int Size);
	void __fastcall PostNormalKeys(int Index);
	void __fastcall PosTAdvSmoothTouchSpecialKeys(System::Word Key, const Classes::TShiftState pShift, bool SpecialKey);
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
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetAutoPostKey(const bool Value);
	void __fastcall SetAutoCompletion(const TAdvSmoothTouchKeyBoardCompletion* Value);
	void __fastcall SetSubKeyHidePause(const int Value);
	void __fastcall SetSubKeyShowPause(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall DoSubKey(System::TObject* Sender);
	void __fastcall DoSubKeyCheck(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g);
	void __fastcall DrawKeys(Advgdip::TGPGraphics* g);
	void __fastcall ItemKeyDown(int Index);
	void __fastcall ItemKeyUp(int Index);
	void __fastcall SyncEqualKeys(int Index);
	void __fastcall TurnOffShifts(void);
	void __fastcall BuildQWERTYKeyBoard(void);
	void __fastcall BuildQWERTZKeyBoard(void);
	void __fastcall BuildAZERTYKeyBoard(void);
	void __fastcall BuildDVORAKKeyBoard(void);
	void __fastcall BuildNumericKeyBoard(void);
	void __fastcall BuildCellPhoneKeyboard(void);
	__property Classes::TShiftState Shift = {read=FShift, write=FShift, nodefault};
	__property HWND KeybdInputHandle = {read=GetKeybdInputHandle, nodefault};
	virtual void __fastcall Paint(void);
	void __fastcall StartTimer(int index);
	void __fastcall StopTimer(void);
	void __fastcall RepeatTimerProc(System::TObject* Sender);
	void __fastcall ShowForm(TAdvSmoothTouchKeyItem* Key);
	void __fastcall ShowAutoCompletionForm(void);
	bool __fastcall CheckAutoCompletionKey(TAdvSmoothTouchKeyItem* Key);
	bool __fastcall CheckAutoCompletionSubKey(TAdvSmoothSubKeyItem* SubKey);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
public:
	__fastcall virtual TAdvSmoothTouchKeyBoard(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothTouchKeyBoard(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AutoZoom(void);
	void __fastcall Zoom(double fhorz, double fvert, bool keysonly = false, bool absoluteZoom = false);
	void __fastcall SaveKeybdLayout(System::UnicodeString FileName);
	void __fastcall LoadKeybdLayout(System::UnicodeString FileName, TAutoSizeLayout AutoSize = (TAutoSizeLayout)(0x1));
	void __fastcall PostKey(System::Word Key, const Classes::TShiftState pShift, bool ExtendedKeyBD, int Index);
	__property bool PostWMCharOnly = {read=FPostWMCharOnly, write=FPostWMCharOnly, nodefault};
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	int __fastcall XYtoItem(int X, int Y);
	
__published:
	__property TAdvSmoothTouchKeyBoardCompletion* AutoCompletion = {read=FAutoCompletion, write=SetAutoCompletion};
	__property int SubKeyShowPause = {read=FSubKeyShowPause, write=SetSubKeyShowPause, default=1};
	__property int SubKeyHidePause = {read=FSubKeyHidePause, write=SetSubKeyHidePause, default=5};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property bool AutoPostKey = {read=FAutoPostKey, write=SetAutoPostKey, default=1};
	__property bool AutoCapsDisplay = {read=FAutoCapsDisplay, write=SetAutoCapsDisplay, default=0};
	__property Graphics::TColor HighlightCaps = {read=FHighlightCaps, write=SetHighlightCaps, default=536870911};
	__property Graphics::TColor HighlightAltGr = {read=FHighlightAltGr, write=SetHighlightAltGr, default=536870911};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FPictureContainer, write=FPictureContainer};
	__property Controls::TImageList* Images = {read=FImages, write=FImages};
	__property TAdvSmoothTouchKeyBoardType KeyboardType = {read=FKeyboardType, write=SeTAdvSmoothTouchKeyBoardType, nodefault};
	__property int KeyDistance = {read=FKeyDistance, write=SetKeyDistance, default=0};
	__property TAdvSmoothTouchKeyCollection* Keys = {read=FKeys, write=SetKeys};
	__property Graphics::TFont* SmallFont = {read=FSmallFont, write=SetSmallFont};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAdvSmoothTouchKeyEvent OnKeyClick = {read=FOnKeyClick, write=FOnKeyClick};
	__property Controls::TKeyEvent OnKeyDown = {read=FOnKeyDown, write=FOnKeyDown};
	__property TAdvSmoothTouchQueryWindowHandleEvent OnQueryWindowHandle = {read=FOnQueryWindowHandle, write=FOnQueryWindowHandle};
	__property Align = {default=0};
	__property Font;
	__property Visible = {default=1};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothTouchKeyBoard(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


class DELPHICLASS TAdvSmoothTouchKeyBoardToolForm;
class PASCALIMPLEMENTATION TAdvSmoothTouchKeyBoardToolForm : public Forms::TCustomForm
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
	/* TCustomForm.Create */ inline __fastcall virtual TAdvSmoothTouchKeyBoardToolForm(Classes::TComponent* AOwner) : Forms::TCustomForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAdvSmoothTouchKeyBoardToolForm(Classes::TComponent* AOwner, int Dummy) : Forms::TCustomForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAdvSmoothTouchKeyBoardToolForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothTouchKeyBoardToolForm(HWND ParentWindow) : Forms::TCustomForm(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothPopupTouchKeyBoard;
class PASCALIMPLEMENTATION TAdvSmoothPopupTouchKeyBoard : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Extctrls::TTimer* FTimer;
	TAdvSmoothTouchKeyBoardToolForm* FFrm;
	TAdvSmoothTouchKeyBoard* FKbd;
	Forms::TCustomForm* FOwnerform;
	bool FAutoCapsDisplay;
	bool FAutoPostKey;
	Graphics::TColor FHighlightCaps;
	TAdvSmoothTouchKeyBoardType FKeyboardType;
	Graphics::TColor FHighlightAltGr;
	bool FAutoFollowFocus;
	bool FAutoHide;
	bool FShowCaption;
	bool FShowClose;
	bool FDisableSizing;
	Classes::TNotifyEvent FOnClose;
	int FOldX;
	int FOldY;
	Graphics::TColor FBackGroundColor;
	void __fastcall SetAutoCapsDisplay(const bool Value);
	void __fastcall SetAutoPostKey(const bool Value);
	void __fastcall SetHighlightAltGr(const Graphics::TColor Value);
	void __fastcall SetHighlightCaps(const Graphics::TColor Value);
	void __fastcall SeTAdvSmoothTouchKeyBoardType(const TAdvSmoothTouchKeyBoardType Value);
	void __fastcall KeyboardSizeChanged(System::TObject* Sender);
	void __fastcall SetBackGroundColor(const Graphics::TColor Value);
	
protected:
	void __fastcall TimerProc(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
public:
	__fastcall virtual TAdvSmoothPopupTouchKeyBoard(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothPopupTouchKeyBoard(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall CreateForm(void);
	void __fastcall Show(void);
	void __fastcall ShowAtXY(int x, int y);
	void __fastcall Hide(void);
	__property TAdvSmoothTouchKeyBoard* Keyboard = {read=FKbd};
	
__published:
	__property Graphics::TColor BackGroundColor = {read=FBackGroundColor, write=SetBackGroundColor, default=-16777201};
	__property bool ShowCaption = {read=FShowCaption, write=FShowCaption, default=1};
	__property bool ShowClose = {read=FShowClose, write=FShowClose, default=1};
	__property bool AutoFollowFocus = {read=FAutoFollowFocus, write=FAutoFollowFocus, default=0};
	__property bool AutoHide = {read=FAutoHide, write=FAutoHide, default=0};
	__property bool AutoPostKey = {read=FAutoPostKey, write=SetAutoPostKey, default=1};
	__property bool AutoCapsDisplay = {read=FAutoCapsDisplay, write=SetAutoCapsDisplay, default=0};
	__property Graphics::TColor HighlightCaps = {read=FHighlightCaps, write=SetHighlightCaps, default=536870911};
	__property Graphics::TColor HighlightAltGr = {read=FHighlightAltGr, write=SetHighlightAltGr, default=536870911};
	__property TAdvSmoothTouchKeyBoardType KeyboardType = {read=FKeyboardType, write=SeTAdvSmoothTouchKeyBoardType, nodefault};
	__property Classes::TNotifyEvent OnClose = {read=FOnClose, write=FOnClose};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
static const Word WM_USERACTIVATE = 0x465;

}	/* namespace Advsmoothtouchkeyboard */
using namespace Advsmoothtouchkeyboard;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothtouchkeyboardHPP
