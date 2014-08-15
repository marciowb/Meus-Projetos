// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothspinner.pas' rev: 21.00

#ifndef AdvsmoothspinnerHPP
#define AdvsmoothspinnerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Dateutils.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothspinner
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
enum TAdvSmoothSpinnerRangeType { rtNumber, rtDateTime, rtCustom };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothSpinnerStepType { stNumber, stSecond, stMinute, stHour, stDay, stMonth, stYear };
#pragma option pop

class DELPHICLASS TAdvSmoothSpinnerCustomItem;
class DELPHICLASS TAdvSmoothSpinner;
class PASCALIMPLEMENTATION TAdvSmoothSpinnerCustomItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvSmoothSpinner* FOwner;
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
	__fastcall virtual TAdvSmoothSpinnerCustomItem(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothSpinnerCustomItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property double Value = {read=FValue, write=SetValue};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property System::UnicodeString PictureName = {read=FpictureName, write=SetPictureName};
};


class DELPHICLASS TAdvSmoothSpinnerCustomItems;
class PASCALIMPLEMENTATION TAdvSmoothSpinnerCustomItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothSpinnerCustomItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothSpinner* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothSpinnerCustomItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothSpinnerCustomItem* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothSpinnerCustomItems(TAdvSmoothSpinner* AOwner);
	HIDESBASE TAdvSmoothSpinnerCustomItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothSpinnerCustomItem* __fastcall Insert(int Index);
	__property TAdvSmoothSpinnerCustomItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothSpinnerCustomItems(void) { }
	
};


class DELPHICLASS TAdvSmoothSpinnerColumn;
class PASCALIMPLEMENTATION TAdvSmoothSpinnerColumn : public Classes::TCollectionItem
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
	TAdvSmoothSpinner* Fowner;
	bool FEnabled;
	bool FVisible;
	double FRangeFrom;
	double FRangeTo;
	double FSelectedValue;
	TAdvSmoothSpinnerRangeType FRangeType;
	System::UnicodeString FHint;
	double FStep;
	System::UnicodeString FValueFormat;
	System::TDateTime FDateRangeTo;
	System::TDateTime FDateRangeFrom;
	System::UnicodeString FDateTimeValueFormat;
	TAdvSmoothSpinnerStepType FStepType;
	TAdvSmoothSpinnerCustomItems* FCustomItems;
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
	void __fastcall SetRangeType(const TAdvSmoothSpinnerRangeType Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetStep(const double Value);
	void __fastcall SetValueFormat(const System::UnicodeString Value);
	void __fastcall SetDateRangeFrom(const System::TDateTime Value);
	void __fastcall SetDateRangeTo(const System::TDateTime Value);
	void __fastcall SetDateTimeValueFormat(const System::UnicodeString Value);
	void __fastcall SetStepType(const TAdvSmoothSpinnerStepType Value);
	void __fastcall SetCustomItems(const TAdvSmoothSpinnerCustomItems* Value);
	void __fastcall SetCyclic(const bool Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetWidth(const int Value);
	System::TDateTime __fastcall GetSelectedDateTime(void);
	void __fastcall SetSelectedDateTime(const System::TDateTime Value);
	void __fastcall SetTextAlign(const Classes::TAlignment Value);
	int __fastcall GetSelectedCustomIndex(void);
	void __fastcall SetSelectedCustomIndex(const int Value);
	void __fastcall SetOnlyDate(const bool Value);
	double __fastcall GetSelectedValue(void);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall CustomItemsChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall SetAnimatedValue(void);
	Advgdip::TGPRectF __fastcall GetColumnRect(void);
	
public:
	__fastcall virtual TAdvSmoothSpinnerColumn(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothSpinnerColumn(void);
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
	__property TAdvSmoothSpinnerStepType StepType = {read=FStepType, write=SetStepType, default=0};
	__property double SelectedValue = {read=GetSelectedValue, write=SetSelectedValue};
	__property System::UnicodeString ValueFormat = {read=FValueFormat, write=SetValueFormat};
	__property System::UnicodeString DateTimeValueFormat = {read=FDateTimeValueFormat, write=SetDateTimeValueFormat};
	__property TAdvSmoothSpinnerRangeType RangeType = {read=FRangeType, write=SetRangeType, default=0};
	__property bool OnlyDate = {read=FOnlyDate, write=SetOnlyDate, default=0};
	__property TAdvSmoothSpinnerCustomItems* CustomItems = {read=FCustomItems, write=SetCustomItems};
	__property bool Cyclic = {read=FCyclic, write=SetCyclic, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TAlignment TextAlign = {read=FTextAlign, write=SetTextAlign, default=2};
};


class DELPHICLASS TAdvSmoothSpinnerColumns;
class PASCALIMPLEMENTATION TAdvSmoothSpinnerColumns : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothSpinnerColumn* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothSpinner* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothSpinnerColumn* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothSpinnerColumn* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothSpinnerColumns(TAdvSmoothSpinner* AOwner);
	HIDESBASE TAdvSmoothSpinnerColumn* __fastcall Add(void);
	HIDESBASE TAdvSmoothSpinnerColumn* __fastcall Insert(int Index);
	__property TAdvSmoothSpinnerColumn* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	virtual void __fastcall Update(Classes::TCollectionItem* Item);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothSpinnerColumns(void) { }
	
};


class DELPHICLASS TAdvSmoothSpinnerColumnAppearance;
class PASCALIMPLEMENTATION TAdvSmoothSpinnerColumnAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothSpinner* FOwner;
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
	__fastcall TAdvSmoothSpinnerColumnAppearance(TAdvSmoothSpinner* AOwner);
	__fastcall virtual ~TAdvSmoothSpinnerColumnAppearance(void);
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


typedef void __fastcall (__closure *TAdvSmoothSpinnerSelectedValueChangedEvent)(System::TObject* Sender, int Column, int SelectedCustomIndex, double SelectedValue, TAdvSmoothSpinnerRangeType RangeType);

typedef void __fastcall (__closure *TAdvSmoothSpinnerColumnHintEvent)(System::TObject* Sender, int Column, System::UnicodeString Hint);

class PASCALIMPLEMENTATION TAdvSmoothSpinner : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FFocused;
	bool FConstructed;
	int FFocusedColumn;
	Extctrls::TTimer* FAnimateTimer;
	bool FDesignTime;
	int FHoveredColumn;
	TAdvSmoothSpinnerColumnAppearance* FColumnAppearance;
	Gdipfill::TGDIPFill* FFill;
	Gdipfill::TGDIPFill* FSelectedFill;
	int FSelectedHeight;
	TAdvSmoothSpinnerColumns* FColumns;
	int FAnimationFactor;
	TAdvSmoothSpinnerSelectedValueChangedEvent FOnSelectedValueChanged;
	TAdvSmoothSpinnerColumnHintEvent FOnColumnHint;
	Gdippicturecontainer::TGDIPPictureContainer* FContainer;
	Imglist::TCustomImageList* FImages;
	bool FReadOnly;
	Gdipfill::TGDIPFill* FBottomLayerFill;
	Gdipfill::TGDIPFill* FTopLayerFill;
	bool FSmoothScrolling;
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall SetColumnAppearance(const TAdvSmoothSpinnerColumnAppearance* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSelectedFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSelectedHeight(const int Value);
	void __fastcall SetColumns(const TAdvSmoothSpinnerColumns* Value);
	void __fastcall SetAnimationFactor(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetReadOnly(const bool Value);
	void __fastcall SetBottomLayerFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetTopLayerFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetSmoothScrolling(const bool Value);
	
protected:
	virtual void __fastcall CreateWnd(void);
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
	void __fastcall DrawBackGround(void);
	void __fastcall DrawColumns(void);
	void __fastcall DrawTopLayer(void);
	void __fastcall DrawSelectedLayer(void);
	void __fastcall InitPreview(void);
	void __fastcall Animate(System::TObject* Sender);
	Types::TRect __fastcall InsideRect(void);
	Types::TRect __fastcall GetSelectedRect(void);
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TAdvSmoothSpinner(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothSpinner(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseWheelHandler(Messages::TMessage &Message);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	int __fastcall XYToColumn(int X, int Y);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property int AnimationFactor = {read=FAnimationFactor, write=SetAnimationFactor, default=4};
	__property TAdvSmoothSpinnerColumns* Columns = {read=FColumns, write=SetColumns};
	__property TAdvSmoothSpinnerColumnAppearance* ColumnAppearance = {read=FColumnAppearance, write=SetColumnAppearance};
	__property Gdipfill::TGDIPFill* SelectedFill = {read=FSelectedFill, write=SetSelectedFill};
	__property int SelectedHeight = {read=FSelectedHeight, write=SetSelectedHeight, default=30};
	__property Gdipfill::TGDIPFill* TopLayerFill = {read=FTopLayerFill, write=SetTopLayerFill};
	__property Gdipfill::TGDIPFill* BottomLayerFill = {read=FBottomLayerFill, write=SetBottomLayerFill};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Gdippicturecontainer::TGDIPPictureContainer* PictureContainer = {read=FContainer, write=FContainer};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property bool SmoothScrolling = {read=FSmoothScrolling, write=SetSmoothScrolling, default=0};
	__property TAdvSmoothSpinnerSelectedValueChangedEvent OnSelectedValueChanged = {read=FOnSelectedValueChanged, write=FOnSelectedValueChanged};
	__property TAdvSmoothSpinnerColumnHintEvent OnColumnHint = {read=FOnColumnHint, write=FOnColumnHint};
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
	__property TabStop = {default=1};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothSpinner(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothspinner */
using namespace Advsmoothspinner;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothspinnerHPP
