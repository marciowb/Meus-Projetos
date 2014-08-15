// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothtimeline.pas' rev: 21.00

#ifndef AdvsmoothtimelineHPP
#define AdvsmoothtimelineHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Dateutils.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothtimeline
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
enum TAdvSmoothTimeLineCaptionLocation { cpTopLeft, cpTopCenter, cpTopRight, cpCenterLeft, cpCenterCenter, cpCenterRight, cpBottomLeft, cpBottomCenter, cpBottomRight, cpCustom };
#pragma option pop

class DELPHICLASS TAdvSmoothSectionHint;
class DELPHICLASS TAdvSmoothTimeLine;
class PASCALIMPLEMENTATION TAdvSmoothSectionHint : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	Advgdip::TGPBitmap* FMainBuffer;
	TAdvSmoothTimeLine* FTimeLine;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Messages::TWMNCHitTest &Msg);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Messages::TWMKey &Msg);
	
public:
	__fastcall virtual TAdvSmoothSectionHint(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothSectionHint(void);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall UpdateButtons(void);
	void __fastcall Draw(Advgdip::TGPGraphics* Graphics);
	void __fastcall CreateMainBuffer(void);
	void __fastcall DestroyMainBuffer(void);
	void __fastcall ClearBuffer(Advgdip::TGPGraphics* Graphics);
	Advgdip::TGPGraphics* __fastcall CreateGraphics(void);
	void __fastcall SetLayeredWindow(void);
	void __fastcall UpdateLayered(void);
	void __fastcall UpdateMainWindow(void);
	void __fastcall UpdateWindow(void);
	
public:
	void __fastcall Init(void);
	__property TAdvSmoothTimeLine* TimeLine = {read=FTimeLine, write=FTimeLine};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothSectionHint(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


class DELPHICLASS TAdvSmoothTimeLineRangeAppearance;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineRangeAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothTimeLine* FOwner;
	Graphics::TColor FSubDivisionTickMarkColor;
	Graphics::TColor FDivisionTickMarkColor;
	Graphics::TFont* FSubDivisionFont;
	Graphics::TFont* FDivisionFont;
	int FSubDivisionTickMarkSize;
	int FDivisionTickMarkSize;
	Classes::TNotifyEvent FOnChange;
	int FSubDivisionTickMarkWidth;
	int FDivisionTickMarkWidth;
	System::UnicodeString FDivisionFormat;
	System::UnicodeString FSubDivisionFormat;
	int FIndentSpacing;
	bool FShowSubDivisionValue;
	bool FShowDivisionValue;
	void __fastcall SetDivisionTickMarkColor(const Graphics::TColor Value);
	void __fastcall SetDivisionFont(const Graphics::TFont* Value);
	void __fastcall SetSubDivisionFont(const Graphics::TFont* Value);
	void __fastcall SetSubDivisionTickMarkColor(const Graphics::TColor Value);
	void __fastcall SetDivisionTickMarkSize(const int Value);
	void __fastcall SetSubDivisionTickMarkSize(const int Value);
	void __fastcall SetDivisionTickMarkWidth(const int Value);
	void __fastcall SetSubDivisionTickMarkWidth(const int Value);
	void __fastcall SetDivisionFormat(const System::UnicodeString Value);
	void __fastcall SetSubDivisionFormat(const System::UnicodeString Value);
	void __fastcall SetIndentSpacing(const int Value);
	void __fastcall SetShowDivisionValue(const bool Value);
	void __fastcall SetShowSubDivisionValue(const bool Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothTimeLineRangeAppearance(TAdvSmoothTimeLine* AOwner);
	__fastcall virtual ~TAdvSmoothTimeLineRangeAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TFont* DivisionFont = {read=FDivisionFont, write=SetDivisionFont};
	__property Graphics::TFont* SubDivisionFont = {read=FSubDivisionFont, write=SetSubDivisionFont};
	__property Graphics::TColor DivisionTickMarkColor = {read=FDivisionTickMarkColor, write=SetDivisionTickMarkColor, default=0};
	__property Graphics::TColor SubDivisionTickMarkColor = {read=FSubDivisionTickMarkColor, write=SetSubDivisionTickMarkColor, default=0};
	__property int DivisionTickMarkSize = {read=FDivisionTickMarkSize, write=SetDivisionTickMarkSize, default=10};
	__property int SubDivisionTickMarkSize = {read=FSubDivisionTickMarkSize, write=SetSubDivisionTickMarkSize, default=8};
	__property int DivisionTickMarkWidth = {read=FDivisionTickMarkWidth, write=SetDivisionTickMarkWidth, default=2};
	__property int SubDivisionTickMarkWidth = {read=FSubDivisionTickMarkWidth, write=SetSubDivisionTickMarkWidth, default=1};
	__property System::UnicodeString DivisionFormat = {read=FDivisionFormat, write=SetDivisionFormat};
	__property System::UnicodeString SubDivisionFormat = {read=FSubDivisionFormat, write=SetSubDivisionFormat};
	__property int IndentSpacing = {read=FIndentSpacing, write=SetIndentSpacing, default=20};
	__property bool ShowDivisionValue = {read=FShowDivisionValue, write=SetShowDivisionValue, default=1};
	__property bool ShowSubDivisionValue = {read=FShowSubDivisionValue, write=SetShowSubDivisionValue, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TAdvsmoothTimelineDivisionType { dtFixedNumber, dtMilliSecond, dtSecond, dtMinute, dtHour, dtDay, dtMonth, dtYear };
#pragma option pop

class DELPHICLASS TAdvSmoothTimeLineRange;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineRange : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FDoAnimateRange;
	bool FAnimateRangeFrom;
	bool FAnimateRangeTo;
	System::TDateTime FRangeFromAnim;
	System::TDateTime FRangeToAnim;
	TAdvSmoothTimeLine* FOwner;
	System::TDateTime FRangeFrom;
	System::TDateTime FOldRangeFrom;
	System::TDateTime FRangeTo;
	System::TDateTime FOldRangeTo;
	int FSubDivisions;
	int FDivisions;
	Classes::TNotifyEvent FOnChange;
	bool FAllowScrolling;
	System::TDateTime FMaximumRange;
	System::TDateTime FMinimumRange;
	bool FAllowZooming;
	TAdvsmoothTimelineDivisionType FDivisionType;
	bool FAutomaticScrolling;
	bool FAllowPartialZooming;
	int FScrollStep;
	void __fastcall SetRangeFrom(const System::TDateTime Value);
	void __fastcall SetRangeTo(const System::TDateTime Value);
	void __fastcall SetDivisions(const int Value);
	void __fastcall SetSubDivisions(const int Value);
	void __fastcall SetAllowScrolling(const bool Value);
	void __fastcall SetMaximumRange(const System::TDateTime Value);
	void __fastcall SetMinimumRange(const System::TDateTime Value);
	void __fastcall SetAllowZooming(const bool Value);
	void __fastcall SetDivisionType(const TAdvsmoothTimelineDivisionType Value);
	void __fastcall SetAutomaticScrolling(const bool Value);
	void __fastcall SetAllowPartialZooming(const bool Value);
	void __fastcall SetScrollStep(const int Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall ResetScrollStatus(void);
	void __fastcall FixDivisions(int dv);
	
public:
	__fastcall TAdvSmoothTimeLineRange(TAdvSmoothTimeLine* AOwner);
	__fastcall virtual ~TAdvSmoothTimeLineRange(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::TDateTime MinimumRange = {read=FMinimumRange, write=SetMinimumRange};
	__property System::TDateTime MaximumRange = {read=FMaximumRange, write=SetMaximumRange};
	__property System::TDateTime RangeTo = {read=FRangeTo, write=SetRangeTo};
	__property System::TDateTime RangeFrom = {read=FRangeFrom, write=SetRangeFrom};
	__property bool AllowPartialZooming = {read=FAllowPartialZooming, write=SetAllowPartialZooming, default=1};
	__property bool AllowScrolling = {read=FAllowScrolling, write=SetAllowScrolling, default=1};
	__property int ScrollStep = {read=FScrollStep, write=SetScrollStep, default=5};
	__property bool AllowZooming = {read=FAllowZooming, write=SetAllowZooming, default=1};
	__property bool AutomaticScrolling = {read=FAutomaticScrolling, write=SetAutomaticScrolling, default=1};
	__property int Divisions = {read=FDivisions, write=SetDivisions, default=2};
	__property int SubDivisions = {read=FSubDivisions, write=SetSubDivisions, default=5};
	__property TAdvsmoothTimelineDivisionType DivisionType = {read=FDivisionType, write=SetDivisionType, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TAdvSmoothTimeLineBarIndicatorShape { isTriangleUp, isTriangleDown, isSquare, isDiamond, isCircle, isNone, isPicture };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothTimeLineBarAnnotationPosition { apOnTop, apAtBottom };
#pragma option pop

class DELPHICLASS TAdvSmoothTimeLineBarIndicator;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineBarIndicator : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	TAdvSmoothTimeLine* FOwner;
	System::TDateTime FPosition;
	TAdvSmoothTimeLineBarIndicatorShape FShape;
	Graphics::TColor FBorderColor;
	Advgdip::TAdvGradientType FGradientType;
	System::Byte FOpacity;
	System::Byte FOpacityTo;
	int FAngle;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	System::Byte FBorderOpacity;
	int FBorderWidth;
	Advgdip::TAdvGDIPPicture* FPicture;
	int FSize;
	System::UnicodeString FHint;
	int FTickMarkSize;
	bool FShowTickMark;
	int FTickMarkWidth;
	Graphics::TColor FTickMarkColor;
	Menus::TPopupMenu* FPopupMenu;
	bool FFixed;
	System::UnicodeString FAnnotation;
	Graphics::TColor FAnnotationColor;
	TAdvSmoothTimeLineBarAnnotationPosition FAnnotationPosition;
	Graphics::TColor FAnnotationLineColor;
	System::Byte FAnnotationOpacity;
	System::Byte FAnnotationLineOpacity;
	int FAnnotationImageIndex;
	bool FAnnotationRounded;
	System::TObject* FItemObject;
	int FTag;
	Graphics::TColor FAnnotationTextColor;
	void __fastcall SetPosition(const System::TDateTime Value);
	void __fastcall SetShape(const TAdvSmoothTimeLineBarIndicatorShape Value);
	void __fastcall SetAngle(const int Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderOpacity(const System::Byte Value);
	void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetOpacityTo(const System::Byte Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetShowTickMark(const bool Value);
	void __fastcall SetTickMarkColor(const Graphics::TColor Value);
	void __fastcall SetTickMarkSize(const int Value);
	void __fastcall SetTickMarkWidth(const int Value);
	void __fastcall SetFixed(const bool Value);
	void __fastcall SetAnnotation(const System::UnicodeString Value);
	void __fastcall SetAnnotationColor(const Graphics::TColor Value);
	void __fastcall SetAnnotationPostion(const TAdvSmoothTimeLineBarAnnotationPosition Value);
	void __fastcall SetAnnotationLineColor(const Graphics::TColor Value);
	void __fastcall SetAnnotationLineOpacity(const System::Byte Value);
	void __fastcall SetAnnotationOpacity(const System::Byte Value);
	void __fastcall SetAnnotationImageIndex(const int Value);
	System::TDateTime __fastcall GetPosition(void);
	void __fastcall SetAnnotationRounded(const bool Value);
	void __fastcall SetAnnotationTextColor(const Graphics::TColor Value);
	
protected:
	System::UnicodeString FDBKeyValue;
	HIDESBASE void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	Advgdip::TGPRectF __fastcall CalculateAnnotation(Advgdip::TGPGraphics* g, Advgdip::TGPFont* f, Advgdip::TGPStringFormat* sf, int I);
	void __fastcall DrawAnnotation(Advgdip::TGPGraphics* g, Advgdip::TGPFont* f, Advgdip::TGPStringFormat* sf, Advgdip::TGPSolidBrush* bText, const Advgdip::TGPRectF &r);
	void __fastcall DrawAnnotationLine(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, TAdvSmoothTimeLineBarAnnotationPosition AnnotationPosition);
	
public:
	__fastcall virtual TAdvSmoothTimeLineBarIndicator(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothTimeLineBarIndicator(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall AssignVisuals(Classes::TPersistent* Source);
	Advgdip::TGPRectF __fastcall GetIndicatorRect(void);
	__property System::UnicodeString DBKeyValue = {read=FDBKeyValue};
	
__published:
	__property System::UnicodeString Annotation = {read=FAnnotation, write=SetAnnotation};
	__property Graphics::TColor AnnotationColor = {read=FAnnotationColor, write=SetAnnotationColor, default=12632256};
	__property Graphics::TColor AnnotationTextColor = {read=FAnnotationTextColor, write=SetAnnotationTextColor, default=536870911};
	__property System::Byte AnnotationOpacity = {read=FAnnotationOpacity, write=SetAnnotationOpacity, default=255};
	__property Graphics::TColor AnnotationLineColor = {read=FAnnotationLineColor, write=SetAnnotationLineColor, default=0};
	__property System::Byte AnnotationLineOpacity = {read=FAnnotationLineOpacity, write=SetAnnotationLineOpacity, default=255};
	__property TAdvSmoothTimeLineBarAnnotationPosition AnnotationPosition = {read=FAnnotationPosition, write=SetAnnotationPostion, default=0};
	__property int AnnotationImageIndex = {read=FAnnotationImageIndex, write=SetAnnotationImageIndex, default=-1};
	__property bool AnnotationRounded = {read=FAnnotationRounded, write=SetAnnotationRounded, default=0};
	__property System::TDateTime Position = {read=GetPosition, write=SetPosition};
	__property TAdvSmoothTimeLineBarIndicatorShape Shape = {read=FShape, write=SetShape, default=3};
	__property bool Fixed = {read=FFixed, write=SetFixed, default=0};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=8421504};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=12632256};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=255};
	__property System::Byte OpacityTo = {read=FOpacityTo, write=SetOpacityTo, default=255};
	__property int Angle = {read=FAngle, write=SetAngle, default=0};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=4};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property System::Byte BorderOpacity = {read=FBorderOpacity, write=SetBorderOpacity, default=255};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=1};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property int Size = {read=FSize, write=SetSize, default=15};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property bool ShowTickMark = {read=FShowTickMark, write=SetShowTickMark, default=1};
	__property int TickMarkSize = {read=FTickMarkSize, write=SetTickMarkSize, default=10};
	__property int TickMarkWidth = {read=FTickMarkWidth, write=SetTickMarkWidth, default=1};
	__property Graphics::TColor TickMarkColor = {read=FTickMarkColor, write=SetTickMarkColor, default=0};
	__property Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=FPopupMenu};
	__property System::TObject* ItemObject = {read=FItemObject, write=FItemObject};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


class DELPHICLASS TAdvSmoothTimeLineBarIndicators;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineBarIndicators : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothTimeLineBarIndicator* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothTimeLine* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothTimeLineBarIndicator* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothTimeLineBarIndicator* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothTimeLineBarIndicators(TAdvSmoothTimeLine* AOwner);
	HIDESBASE TAdvSmoothTimeLineBarIndicator* __fastcall Add(void);
	HIDESBASE TAdvSmoothTimeLineBarIndicator* __fastcall Insert(int Index);
	__property TAdvSmoothTimeLineBarIndicator* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothTimeLineBarIndicators(void) { }
	
};


class DELPHICLASS TAdvSmoothTimeLineBarSection;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineBarSection : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	bool FInList;
	Advgdip::TGPRectF FSectionRect;
	bool FSizeHandleAnimationStarted;
	bool FSizeHandleAnimation;
	bool FDoSizeHandleAnimation;
	System::Byte FSizeHandleOpacity;
	System::Byte FSizeHandleOpacityTo;
	TAdvSmoothTimeLine* FOwner;
	System::TDateTime FStartTime;
	System::TDateTime FEndTime;
	Gdipfill::TGDIPFill* FFill;
	System::UnicodeString FHint;
	Gdipfill::TGDIPFill* FHintFill;
	Graphics::TFont* FHintFont;
	bool FHintAutoSize;
	int FHintWidth;
	int FHintHeight;
	int FHandleSize;
	Graphics::TColor FHandleColor;
	int FCaptionTop;
	int FCaptionLeft;
	System::UnicodeString FCaption;
	TAdvSmoothTimeLineCaptionLocation FCaptionLocation;
	bool FFixedSize;
	bool FFixedPosition;
	System::TObject* FItemObject;
	int FTag;
	void __fastcall SetEndTime(const System::TDateTime Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetStartTime(const System::TDateTime Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetHintFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHintFont(const Graphics::TFont* Value);
	void __fastcall SetHintAutoSize(const bool Value);
	void __fastcall SetHintHeight(const int Value);
	void __fastcall SetHintWidth(const int Value);
	void __fastcall SetHandleColor(const Graphics::TColor Value);
	void __fastcall SetHandleSize(const int Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetCaptionLeft(const int Value);
	void __fastcall SetCaptionLocation(const TAdvSmoothTimeLineCaptionLocation Value);
	void __fastcall SetCaptionTop(const int Value);
	void __fastcall SetFixedPosition(const bool Value);
	void __fastcall SetFixedSize(const bool Value);
	
protected:
	System::UnicodeString FDBKeyValue;
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	Advgdip::TGPRectF __fastcall GetSectionRect(void);
	
public:
	__fastcall virtual TAdvSmoothTimeLineBarSection(Classes::TCollection* Collection);
	__fastcall virtual ~TAdvSmoothTimeLineBarSection(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property System::UnicodeString DBKeyValue = {read=FDBKeyValue};
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property TAdvSmoothTimeLineCaptionLocation CaptionLocation = {read=FCaptionLocation, write=SetCaptionLocation, default=3};
	__property int CaptionLeft = {read=FCaptionLeft, write=SetCaptionLeft, default=0};
	__property int CaptionTop = {read=FCaptionTop, write=SetCaptionTop, default=0};
	__property int HandleSize = {read=FHandleSize, write=SetHandleSize, default=6};
	__property Graphics::TColor HandleColor = {read=FHandleColor, write=SetHandleColor, default=-16777203};
	__property bool FixedSize = {read=FFixedSize, write=SetFixedSize, default=0};
	__property bool FixedPosition = {read=FFixedPosition, write=SetFixedPosition, default=0};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property System::TDateTime StartTime = {read=FStartTime, write=SetStartTime};
	__property System::TDateTime EndTime = {read=FEndTime, write=SetEndTime};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property Gdipfill::TGDIPFill* HintFill = {read=FHintFill, write=SetHintFill};
	__property Graphics::TFont* HintFont = {read=FHintFont, write=SetHintFont};
	__property bool HintAutoSize = {read=FHintAutoSize, write=SetHintAutoSize, default=1};
	__property int HintWidth = {read=FHintWidth, write=SetHintWidth, default=50};
	__property int HintHeight = {read=FHintHeight, write=SetHintHeight, default=20};
	__property System::TObject* ItemObject = {read=FItemObject, write=FItemObject};
	__property int Tag = {read=FTag, write=FTag, nodefault};
};


typedef DynamicArray<TAdvSmoothTimeLineBarSection*> TSortSectionArray;

class DELPHICLASS TAdvSmoothTimeLineBarSections;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineBarSections : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothTimeLineBarSection* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothTimeLine* FOwner;
	Classes::TNotifyEvent FOnChange;
	HIDESBASE TAdvSmoothTimeLineBarSection* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothTimeLineBarSection* Value);
	
protected:
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TAdvSmoothTimeLineBarSections(TAdvSmoothTimeLine* AOwner);
	HIDESBASE TAdvSmoothTimeLineBarSection* __fastcall Add(void);
	HIDESBASE TAdvSmoothTimeLineBarSection* __fastcall Insert(int Index);
	__property TAdvSmoothTimeLineBarSection* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE void __fastcall Delete(int Index);
	
__published:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothTimeLineBarSections(void) { }
	
};


#pragma option push -b-
enum TAnnotationAutoPosition { apNone, apLeft, apRight };
#pragma option pop

class DELPHICLASS TAdvSmoothTimeLineBar;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineBar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothTimeLine* FOwner;
	TAdvSmoothTimeLineBarSections* FSections;
	Gdipfill::TGDIPFill* FFill;
	int FHeight;
	Classes::TNotifyEvent FOnChange;
	Graphics::TFont* FAnnotationFont;
	Graphics::TFont* FSectionCaptionFont;
	TAnnotationAutoPosition FAnnotationAutoPosition;
	bool FOverlappingSections;
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetAnnotationFont(const Graphics::TFont* Value);
	void __fastcall SetSectionCaptionFont(const Graphics::TFont* Value);
	void __fastcall SetAnnotationAutoPosition(const TAnnotationAutoPosition Value);
	void __fastcall SetOverlappingSections(const bool Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall SectionsChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothTimeLineBar(TAdvSmoothTimeLine* AOwner);
	__fastcall virtual ~TAdvSmoothTimeLineBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property int Height = {read=FHeight, write=SetHeight, default=10};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Graphics::TFont* AnnotationFont = {read=FAnnotationFont, write=SetAnnotationFont};
	__property TAnnotationAutoPosition AnnotationAutoPosition = {read=FAnnotationAutoPosition, write=SetAnnotationAutoPosition, default=0};
	__property Graphics::TFont* SectionCaptionFont = {read=FSectionCaptionFont, write=SetSectionCaptionFont};
	__property bool OverlappingSections = {read=FOverlappingSections, write=SetOverlappingSections, default=1};
};


typedef void __fastcall (__closure *TAdvSmoothTimeLineDivisionText)(System::TObject* Sender, System::TDateTime DivisionValue, System::UnicodeString &DivisionValueString);

typedef void __fastcall (__closure *TAdvSmoothTimeLineIndicatorClick)(System::TObject* Sender, TAdvSmoothTimeLineBarIndicator* indicator);

typedef void __fastcall (__closure *TAdvSmoothTimeLineSectionClick)(System::TObject* Sender, TAdvSmoothTimeLineBarSection* section);

typedef void __fastcall (__closure *TAdvSmoothTimeLineIndicatorPosition)(System::TObject* Sender, TAdvSmoothTimeLineBarIndicator* indicator, System::TDateTime Position);

typedef void __fastcall (__closure *TAdvSmoothTimeLineSectionPosition)(System::TObject* Sender, TAdvSmoothTimeLineBarSection* section, System::TDateTime StartTime, System::TDateTime EndTime);

typedef void __fastcall (__closure *TAdvSmoothTimeLineIndicatorHint)(System::TObject* Sender, TAdvSmoothTimeLineBarIndicator* indicator, System::UnicodeString &Hint);

class DELPHICLASS TAdvSmoothTimeLineAnnotationItem;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineAnnotationItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	Advgdip::TGPRectF FRectangle;
	TAdvSmoothTimeLineBarIndicator* FIndicator;
	
public:
	__property Advgdip::TGPRectF AnnotationRect = {read=FRectangle, write=FRectangle};
	__property TAdvSmoothTimeLineBarIndicator* indicator = {read=FIndicator, write=FIndicator};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TAdvSmoothTimeLineAnnotationItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TAdvSmoothTimeLineAnnotationItem(void) { }
	
};


class DELPHICLASS TAdvSmoothTimeLineAnnotationList;
class PASCALIMPLEMENTATION TAdvSmoothTimeLineAnnotationList : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TAdvSmoothTimeLineAnnotationItem* operator[](int Index) { return Items[Index]; }
	
private:
	TAdvSmoothTimeLine* FOwner;
	HIDESBASE void __fastcall SetItem(int Index, const TAdvSmoothTimeLineAnnotationItem* Value);
	
protected:
	virtual int __fastcall Compare(TAdvSmoothTimeLineAnnotationItem* Item1, TAdvSmoothTimeLineAnnotationItem* Item2);
	void __fastcall QuickSort(int L, int r);
	
public:
	__fastcall TAdvSmoothTimeLineAnnotationList(TAdvSmoothTimeLine* AOwner);
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE TAdvSmoothTimeLineAnnotationItem* __fastcall Add(void);
	HIDESBASE TAdvSmoothTimeLineAnnotationItem* __fastcall Insert(int Index);
	HIDESBASE void __fastcall Delete(int Index);
	HIDESBASE TAdvSmoothTimeLineAnnotationItem* __fastcall GetItem(int index);
	__property TAdvSmoothTimeLineAnnotationItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAdvSmoothTimeLineAnnotationList(void) { }
	
};


#pragma option push -b-
enum TTimeLineValueType { vtDivision, vtSubDivision };
#pragma option pop

struct TTimeLineValue
{
	
public:
	System::TDateTime d;
	System::UnicodeString str;
	Advgdip::TGPPointF postext;
	Advgdip::TGPRectF recttext;
	TTimeLineValueType tp;
	int indent;
};


typedef DynamicArray<TTimeLineValue> TTimeLineValueArray;

typedef void __fastcall (__closure *TAdvSmoothTimeLineDrawEvent)(System::TObject* Sender, Graphics::TCanvas* ACanvas, const Types::TRect &ARect);

typedef void __fastcall (__closure *TAdvSmoothTimeLineScrollEvent)(System::TObject* Sender, System::TDateTime CurrentRangeFrom, System::TDateTime CurrentRangeTo, System::TDateTime NextRangeFrom, System::TDateTime NextRangeTo);

class PASCALIMPLEMENTATION TAdvSmoothTimeLine : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	int FPrevHandle;
	int FStartIndent;
	TTimeLineValue FOldStartVal;
	int FTotalIndent;
	TTimeLineValueArray FTimeLineValues;
	bool FAllowAnimation;
	double FSp;
	int FStartTime;
	int FStopTime;
	bool FScrollTimeLine;
	double FScrollDif;
	int FUpdateCount;
	bool FReBuildLists;
	TAdvSmoothTimeLineAnnotationList* FAnnotationListTop;
	TAdvSmoothTimeLineAnnotationList* FAnnotationListBottom;
	Extctrls::TTimer* FTimer;
	bool FDesignTime;
	bool FMbRight;
	int FMx;
	int FMy;
	int FCx;
	int FCy;
	int FPx;
	int FPy;
	double FSecStartX;
	double FSecEndX;
	bool FMouseMovedOnIndicator;
	bool FMouseMovedOnSection;
	bool FMouseMovedOnTimeLine;
	bool FMouseDownOnIndicator;
	bool FMouseDownOnSection;
	bool FMouseDownOnStartSection;
	bool FMouseDownOnEndSection;
	bool FMouseDownOnTimeLine;
	bool FhintSizeCalculated;
	TAdvSmoothSectionHint* Fh;
	int FHoveredSection;
	int FHoveredIndicator;
	int FSelectedIndicator;
	int FSelectedSection;
	TAdvSmoothTimeLineRange* FRange;
	TAdvSmoothTimeLineRangeAppearance* FRangeAppearance;
	Gdipfill::TGDIPFill* FFill;
	TAdvSmoothTimeLineBar* FTimeLineBar;
	TAdvSmoothTimeLineBarSections* FTimeLineBarSections;
	Gdipfill::TGDIPFill* FDefaultHintFill;
	Gdipfill::TGDIPFill* FDefaultSectionFill;
	int FVerticalMargin;
	int FHorizontalMargin;
	TAdvSmoothTimeLineDivisionText FOnSubDivisionText;
	TAdvSmoothTimeLineDivisionText FOnDivisionText;
	TAdvSmoothTimeLineBarIndicators* FTimeLineIndicators;
	TAdvSmoothTimeLineIndicatorClick FOnIndicatorClick;
	TAdvSmoothTimeLineIndicatorPosition FOnIndicatorPositionChanged;
	TAdvSmoothTimeLineIndicatorHint FOnIndicatorHint;
	TAdvSmoothTimeLineBarIndicators* FDefaultIndicators;
	TAdvSmoothTimeLineBarIndicator* FDefaultIndicator;
	TAdvSmoothTimeLineIndicatorPosition FOnIndicatorPositionChanging;
	TAdvSmoothTimeLineSectionPosition FOnSectionPositionChanging;
	TAdvSmoothTimeLineSectionPosition FOnSectionPositionChanged;
	TAdvSmoothTimeLineSectionClick FOnSectionClick;
	Imglist::TCustomImageList* FImageList;
	bool FReadOnly;
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothTimeLineDrawEvent FOnDrawTimeLine;
	TAdvSmoothTimeLineScrollEvent FOnScrollTimeLine;
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall SetRange(const TAdvSmoothTimeLineRange* Value);
	void __fastcall SetRangeAppearance(const TAdvSmoothTimeLineRangeAppearance* Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetTimeLineBar(const TAdvSmoothTimeLineBar* Value);
	void __fastcall SetTimeLineBarSections(const TAdvSmoothTimeLineBarSections* Value);
	void __fastcall SetDefaultHintFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetDefaultSectionFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetHorizontalMargin(const int Value);
	void __fastcall SetVerticalMargin(const int Value);
	void __fastcall SetTimeLineIndicators(const TAdvSmoothTimeLineBarIndicators* Value);
	void __fastcall SetDefaultIndicator(const TAdvSmoothTimeLineBarIndicator* Value);
	void __fastcall SetImageList(const Imglist::TCustomImageList* Value);
	void __fastcall SetReadOnly(const bool Value);
	
protected:
	void __fastcall AnimateTimeLine(System::TObject* Sender);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall RangeChanged(System::TObject* Sender);
	void __fastcall RangeAppearanceChanged(System::TObject* Sender);
	void __fastcall TimeLineBarChanged(System::TObject* Sender);
	void __fastcall TimeLineBarSectionsChanged(System::TObject* Sender);
	void __fastcall TimeLineBarIndicatorsChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall DrawBackground(Advgdip::TGPGraphics* g);
	void __fastcall DrawTimeLineValues(Advgdip::TGPGraphics* g);
	void __fastcall DrawTimeLineTickMarks(Advgdip::TGPGraphics* g);
	void __fastcall DrawTimeBarIndicators(Advgdip::TGPGraphics* g);
	void __fastcall DrawTimeBar(Advgdip::TGPGraphics* g);
	void __fastcall DrawTimeBarSections(Advgdip::TGPGraphics* g);
	void __fastcall DrawSectionHint(Advgdip::TGPGraphics* g);
	void __fastcall CalculateHintSize(TAdvSmoothSectionHint* h);
	Types::TRect __fastcall InsideRect(void);
	Advgdip::TGPRectF __fastcall GetTimeLineBarRect(void);
	Advgdip::TGPRectF __fastcall GetTimeLineRect(void);
	double __fastcall GetRange(void);
	int __fastcall SectionAtXY(int X, int Y);
	int __fastcall SectionMoveAtXY(int X, int Y);
	int __fastcall SectionSizeStartAtXY(int X, int Y);
	int __fastcall SectionSizeEndAtXY(int X, int Y);
	int __fastcall SectionAnimateHandles(int X, int Y);
	int __fastcall IndicatorAtXY(int X, int Y, bool &OnAnnotation, int StartIndex = 0x0);
	int __fastcall GetTotalCountIndicatorsAtXY(int X, int Y);
	bool __fastcall PtInGPRect(const Advgdip::TGPRectF &r, const Types::TPoint &pt);
	double __fastcall GetXPosition(System::TDateTime Value);
	System::TDateTime __fastcall GetValuePosition(double X);
	void __fastcall GetListRectanglesIntersect(TAdvSmoothTimeLineBarSection* ASection, TSortSectionArray &arrVal);
	double __fastcall GetAnimatedMargin(TAdvsmoothTimelineDivisionType DivisionType);
	double __fastcall GetDivisionValue(TAdvsmoothTimelineDivisionType DivisionType);
	System::TDateTime __fastcall GetDeltaDatetime(TAdvsmoothTimelineDivisionType DivisionType, int Divisions, int DivisionCount = 0x0);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall BuildAnnotations(void);
	void __fastcall BuildTimeLineValues(void);
	void __fastcall BuildSections(void);
	bool __fastcall IsPartialZoomingAllowed(double Dif);
	bool __fastcall IsPartialZoomingAllowedAnimated(double Dif);
	int __fastcall GetTotalIndent(void);
	int __fastcall GetDivisions(void);
	int __fastcall GetSubDivisions(void);
	virtual void __fastcall DoSectionPositionChanged(System::TObject* Sender, TAdvSmoothTimeLineBarSection* section, System::TDateTime StartTime, System::TDateTime EndTime);
	virtual void __fastcall DoIndicatorPositionChanged(System::TObject* Sender, TAdvSmoothTimeLineBarIndicator* indicator, System::TDateTime Position);
	virtual void __fastcall DoIndicatorDown(System::TObject* Sender, TAdvSmoothTimeLineBarIndicator* indicator);
	virtual void __fastcall DoSectionDown(System::TObject* Sender, TAdvSmoothTimeLineBarSection* section);
	
public:
	__fastcall virtual TAdvSmoothTimeLine(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothTimeLine(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	System::TDateTime __fastcall XToDateTime(double X);
	double __fastcall DateTimeToX(System::TDateTime Value);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	DYNAMIC void __fastcall MouseWheelHandler(Messages::TMessage &Message);
	void __fastcall SetTimeLineRange(System::TDateTime ARangeFrom, System::TDateTime ARangeTo)/* overload */;
	void __fastcall SetTimeLineRange(System::TDateTime ARangeFrom, System::TDateTime ARangeTo, System::TDateTime AMinimumRange, System::TDateTime AMaximumRange)/* overload */;
	void __fastcall DrawTimeLine(Graphics::TCanvas* ACanvas);
	void __fastcall SaveToImage(System::UnicodeString FileName, int ImageWidth, int ImageHeight, Advgdip::TImageType ImageType = (Advgdip::TImageType)(0x1), int ImageQualityPercentage = 0x64);
	
__published:
	__property Gdipfill::TGDIPFill* DefaultHintFill = {read=FDefaultHintFill, write=SetDefaultHintFill};
	__property Gdipfill::TGDIPFill* DefaultSectionFill = {read=FDefaultSectionFill, write=SetDefaultSectionFill};
	__property TAdvSmoothTimeLineBarIndicator* DefaultIndicator = {read=FDefaultIndicator, write=SetDefaultIndicator};
	__property TAdvSmoothTimeLineRange* Range = {read=FRange, write=SetRange};
	__property TAdvSmoothTimeLineRangeAppearance* RangeAppearance = {read=FRangeAppearance, write=SetRangeAppearance};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property int VerticalMargin = {read=FVerticalMargin, write=SetVerticalMargin, default=10};
	__property int HorizontalMargin = {read=FHorizontalMargin, write=SetHorizontalMargin, default=25};
	__property TAdvSmoothTimeLineBar* TimeLineBar = {read=FTimeLineBar, write=SetTimeLineBar};
	__property TAdvSmoothTimeLineBarSections* TimeLineSections = {read=FTimeLineBarSections, write=SetTimeLineBarSections};
	__property TAdvSmoothTimeLineBarIndicators* TimeLineIndicators = {read=FTimeLineIndicators, write=SetTimeLineIndicators};
	__property Imglist::TCustomImageList* ImageList = {read=FImageList, write=SetImageList};
	__property TAdvSmoothTimeLineIndicatorHint OnIndicatorHint = {read=FOnIndicatorHint, write=FOnIndicatorHint};
	__property TAdvSmoothTimeLineIndicatorPosition OnIndicatorPositionChanged = {read=FOnIndicatorPositionChanged, write=FOnIndicatorPositionChanged};
	__property TAdvSmoothTimeLineSectionPosition OnSectionPositionChanged = {read=FOnSectionPositionChanged, write=FOnSectionPositionChanged};
	__property TAdvSmoothTimeLineIndicatorPosition OnIndicatorPositionChanging = {read=FOnIndicatorPositionChanging, write=FOnIndicatorPositionChanging};
	__property TAdvSmoothTimeLineSectionPosition OnSectionPositionChanging = {read=FOnSectionPositionChanging, write=FOnSectionPositionChanging};
	__property TAdvSmoothTimeLineIndicatorClick OnIndicatorClick = {read=FOnIndicatorClick, write=FOnIndicatorClick};
	__property TAdvSmoothTimeLineSectionClick OnSectionClick = {read=FOnSectionClick, write=FOnSectionClick};
	__property TAdvSmoothTimeLineDivisionText OnDivisionText = {read=FOnDivisionText, write=FOnDivisionText};
	__property TAdvSmoothTimeLineDivisionText OnSubDivisionText = {read=FOnSubDivisionText, write=FOnSubDivisionText};
	__property TAdvSmoothTimeLineDrawEvent OnDrawTimeLine = {read=FOnDrawTimeLine, write=FOnDrawTimeLine};
	__property TAdvSmoothTimeLineScrollEvent OnScrollTimeLine = {read=FOnScrollTimeLine, write=FOnScrollTimeLine};
	__property bool ReadOnly = {read=FReadOnly, write=SetReadOnly, default=0};
	__property Visible = {default=1};
	__property ShowHint;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseDown;
	__property OnClick;
	__property OnKeyDown;
	__property OnKeyUp;
	__property OnKeyPress;
	__property Enabled = {default=1};
	__property TabStop = {default=1};
	__property OnGesture;
	__property Touch;
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothTimeLine(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt MAJ_VER = 0x2;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advsmoothtimeline */
using namespace Advsmoothtimeline;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothtimelineHPP
