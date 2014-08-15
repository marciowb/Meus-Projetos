// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Gdipfill.pas' rev: 21.00

#ifndef GdipfillHPP
#define GdipfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Clipbrd.hpp>	// Pascal unit
#include <Inifiles.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Gdipfill
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGlowMode { gmNone, gmGradient, gmRadial, gmRadialGradient };
#pragma option pop

#pragma option push -b-
enum TFillPicturePosition { ppTopLeft, ppTopCenter, ppTopRight, ppBottomLeft, ppBottomCenter, ppBottomRight, ppTiled, ppStretched, ppCenterLeft, ppCenterCenter, ppCenterRight, ppCustom };
#pragma option pop

#pragma option push -b-
enum TFillRoundingType { rtNone, rtTop, rtBottom, rtBoth, rtLeft, rtRight };
#pragma option pop

#pragma option push -b-
enum TFillPictureSize { psOriginal, psCustom };
#pragma option pop

#pragma option push -b-
enum TFillPictureMode { pmInsideFill, pmOutsideFill };
#pragma option pop

#pragma option push -b-
enum TFillValueType { vtNormal, vtDateTime };
#pragma option pop

class DELPHICLASS TGDIPFill;
class PASCALIMPLEMENTATION TGDIPFill : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FBorderColor;
	System::Byte FOpacity;
	TFillPicturePosition FPicturePosition;
	Advgdip::TAdvGradientType FGradientType;
	System::Byte FOpacityTo;
	Advgdip::TAdvGDIPPicture* FPicture;
	Advgdip::HatchStyle FHatchStyle;
	Graphics::TColor FColor;
	int FShadowOffset;
	System::Byte FOpacityMirror;
	Advgdip::TAdvGradientType FGradientMirrorType;
	System::Byte FOpacityMirrorTo;
	int FRounding;
	Graphics::TColor FShadowColor;
	int FBorderWidth;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FColorTo;
	Classes::TNotifyEvent FOnChange;
	Advgdip::HatchStyle FHatchStyleMirror;
	int FPictureTop;
	int FPictureLeft;
	int FBackGroundPictureTop;
	int FBackGroundPictureLeft;
	TFillPicturePosition FBackGroundPicturePosition;
	Advgdip::TAdvGDIPPicture* FBackGroundPicture;
	int FpictureWidth;
	TFillPictureSize FpictureSize;
	int FpictureHeight;
	TFillRoundingType FRoundingType;
	int FUpdateCount;
	bool FFocus;
	Graphics::TColor FFocusColor;
	int FAngle;
	System::Byte FBorderOpacity;
	Advgdip::TGPRectF FFocusRect;
	TFillPictureMode FBackGroundPictureMode;
	Graphics::TColor FGlowGradientColor;
	TGlowMode FGlow;
	Graphics::TColor FGlowRadialColor;
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetGradientMirrorType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetHatchStyle(const Advgdip::HatchStyle Value);
	void __fastcall SetOpacity(const System::Byte Value);
	void __fastcall SetOpacityMirror(const System::Byte Value);
	void __fastcall SetOpacityMirrorTo(const System::Byte Value);
	void __fastcall SetOpacityTo(const System::Byte Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetPicturePosition(const TFillPicturePosition Value);
	void __fastcall SetRounding(const int Value);
	void __fastcall SetShadowColor(const Graphics::TColor Value);
	void __fastcall SetShadowOffset(const int Value);
	void __fastcall SetHatchStyleMirror(const Advgdip::HatchStyle Value);
	void __fastcall SetPictureLeft(const int Value);
	void __fastcall SetPictureTop(const int Value);
	void __fastcall SetBackGroundPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetBackGroundPictureLeft(const int Value);
	void __fastcall SetBackGroundPicturePosition(const TFillPicturePosition Value);
	void __fastcall SetBackGroundPictureTop(const int Value);
	void __fastcall SetPictureHeight(const int Value);
	void __fastcall SetPictureSize(const TFillPictureSize Value);
	void __fastcall SetPictureWidth(const int Value);
	void __fastcall SetRoundingType(const TFillRoundingType Value);
	void __fastcall SetFocus(const bool Value);
	void __fastcall SetFocusColor(const Graphics::TColor Value);
	void __fastcall SetAngle(const int Value);
	void __fastcall SetBorderOpacity(const System::Byte Value);
	void __fastcall SetBackGroundPictureMode(const TFillPictureMode Value);
	void __fastcall SetGlow(const TGlowMode Value);
	void __fastcall SetGlowGradientColor(const Graphics::TColor Value);
	void __fastcall SetGlowRadialColor(const Graphics::TColor Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall DrawGradientBackGround(Advgdip::TGPGraphics* Graphics, const Advgdip::TGPRectF &R, bool Mirror, System::Byte oc, System::Byte octo, System::Byte ocmr, System::Byte ocmrto);
	
public:
	__fastcall TGDIPFill(void);
	__fastcall virtual ~TGDIPFill(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	Advgdip::TGPRectF __fastcall Fill(Advgdip::TGPGraphics* Graphics, const Advgdip::TGPRectF &R, System::Byte ABorderOpacity = (System::Byte)(0xff), System::Byte AOpacity = (System::Byte)(0xff), System::Byte AOpacityTo = (System::Byte)(0xff), System::Byte AOpacityMirror = (System::Byte)(0xff), System::Byte AOpacityMirrorTo = (System::Byte)(0xff));
	void __fastcall DrawGlow(Advgdip::TGPGraphics* Graphics, const Advgdip::TGPRectF &R);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall SaveToClipBoard(void);
	void __fastcall LoadFromClipBoard(void);
	__property bool Focus = {read=FFocus, write=SetFocus, default=0};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=0};
	__property Advgdip::TGPRectF FocusRect = {read=FFocusRect, write=FFocusRect};
	void __fastcall SaveToFile(System::UnicodeString FileName, System::UnicodeString Section)/* overload */;
	void __fastcall SaveToFile(Inifiles::TIniFile* ini, System::UnicodeString Section)/* overload */;
	void __fastcall LoadFromFile(System::UnicodeString FileName, System::UnicodeString Section)/* overload */;
	void __fastcall LoadFromFile(Inifiles::TIniFile* ini, System::UnicodeString Section)/* overload */;
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=12632256};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, default=8421504};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, nodefault};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, nodefault};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=2};
	__property Advgdip::TAdvGradientType GradientMirrorType = {read=FGradientMirrorType, write=SetGradientMirrorType, default=0};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=SetHatchStyle, default=0};
	__property Advgdip::HatchStyle HatchStyleMirror = {read=FHatchStyleMirror, write=SetHatchStyleMirror, default=0};
	__property TFillPictureMode BackGroundPictureMode = {read=FBackGroundPictureMode, write=SetBackGroundPictureMode, default=1};
	__property Advgdip::TAdvGDIPPicture* BackGroundPicture = {read=FBackGroundPicture, write=SetBackGroundPicture};
	__property TFillPicturePosition BackGroundPicturePosition = {read=FBackGroundPicturePosition, write=SetBackGroundPicturePosition, default=0};
	__property int BackGroundPictureLeft = {read=FBackGroundPictureLeft, write=SetBackGroundPictureLeft, default=0};
	__property int BackGroundPictureTop = {read=FBackGroundPictureTop, write=SetBackGroundPictureTop, default=0};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property TFillPicturePosition PicturePosition = {read=FPicturePosition, write=SetPicturePosition, default=0};
	__property int PictureLeft = {read=FPictureLeft, write=SetPictureLeft, default=0};
	__property int PictureTop = {read=FPictureTop, write=SetPictureTop, default=0};
	__property TFillPictureSize PictureSize = {read=FpictureSize, write=SetPictureSize, default=0};
	__property int PictureWidth = {read=FpictureWidth, write=SetPictureWidth, default=50};
	__property int PictureHeight = {read=FpictureHeight, write=SetPictureHeight, default=50};
	__property System::Byte Opacity = {read=FOpacity, write=SetOpacity, default=255};
	__property System::Byte OpacityTo = {read=FOpacityTo, write=SetOpacityTo, default=255};
	__property System::Byte OpacityMirror = {read=FOpacityMirror, write=SetOpacityMirror, default=255};
	__property System::Byte OpacityMirrorTo = {read=FOpacityMirrorTo, write=SetOpacityMirrorTo, default=255};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property System::Byte BorderOpacity = {read=FBorderOpacity, write=SetBorderOpacity, default=255};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=1};
	__property int Rounding = {read=FRounding, write=SetRounding, nodefault};
	__property TFillRoundingType RoundingType = {read=FRoundingType, write=SetRoundingType, default=3};
	__property Graphics::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=8421504};
	__property int ShadowOffset = {read=FShadowOffset, write=SetShadowOffset, nodefault};
	__property int Angle = {read=FAngle, write=SetAngle, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TGlowMode Glow = {read=FGlow, write=SetGlow, default=0};
	__property Graphics::TColor GlowGradientColor = {read=FGlowGradientColor, write=SetGlowGradientColor, default=16777215};
	__property Graphics::TColor GlowRadialColor = {read=FGlowRadialColor, write=SetGlowRadialColor, default=16777215};
};


#pragma option push -b-
enum TGDIPButtonLayout { blPictureLeft, blPictureRight, blPictureBottom, blPictureTop, blNone };
#pragma option pop

typedef void __fastcall (__closure *TFontStoredEvent)(System::TObject* Sender, bool &IsStored);

class DELPHICLASS TGDIPButton;
class PASCALIMPLEMENTATION TGDIPButton : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FUpdateCount;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	Classes::TNotifyEvent FOnFontChange;
	TFontStoredEvent FOnIsFontStored;
	TGDIPButtonLayout FLayout;
	int FSpacing;
	int FShiftDown;
	Classes::TAlignment FAlignment;
	Graphics::TColor FFocusColor;
	Classes::TAlignment FPictureAlignment;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetLayout(const TGDIPButtonLayout Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetShiftDown(const int Value);
	bool __fastcall IsFontStored(void);
	void __fastcall SetAlignment(const Classes::TAlignment Value);
	void __fastcall SetFocusColor(const Graphics::TColor Value);
	void __fastcall SetPictureAlignment(const Classes::TAlignment Value);
	
protected:
	void __fastcall FontChanged(System::TObject* Sender);
	virtual void __fastcall Changed(void);
	
public:
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__fastcall virtual TGDIPButton(void);
	__fastcall virtual ~TGDIPButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Advgdip::TGPGraphics* g, System::UnicodeString Caption, int x, int y, int Width, int Height, int VerticalSpacing, int HorizontalSpacing, Graphics::TColor Color, Graphics::TColor ColorDown, Graphics::TColor BevelColor, bool Shadow, bool Down, bool Bevel, bool VerticalText, bool RightToLeft, TFillRoundingType RoundingType, Advgdip::TAdvGDIPPicture* Picture, int TextW, int TextH, bool WW);
	
__published:
	__property Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property Classes::TAlignment PictureAlignment = {read=FPictureAlignment, write=SetPictureAlignment, default=1};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont, stored=IsFontStored};
	__property TGDIPButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=3};
	__property int ShiftDown = {read=FShiftDown, write=SetShiftDown, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Classes::TNotifyEvent OnFontChange = {read=FOnFontChange, write=FOnFontChange};
	__property TFontStoredEvent OnIsFontStored = {read=FOnIsFontStored, write=FOnIsFontStored};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=0};
};


class DELPHICLASS TGDIPDialogButton;
class PASCALIMPLEMENTATION TGDIPDialogButton : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	TGDIPButtonLayout FLayout;
	int FSpacing;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetLayout(const TGDIPButtonLayout Value);
	void __fastcall SetSpacing(const int Value);
	
protected:
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall Changed(void);
	
public:
	__fastcall virtual TGDIPDialogButton(void);
	__fastcall virtual ~TGDIPDialogButton(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Advgdip::TGPGraphics* g, System::UnicodeString Caption, int x, int y, int Width, int Height, Graphics::TColor Color, Graphics::TColor BorderColor, int BorderWidth, System::Byte BorderOpacity, System::Byte Opacity, bool Border, bool Down, Advgdip::TAdvGDIPPicture* Picture, bool WW);
	
__published:
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property TGDIPButtonLayout Layout = {read=FLayout, write=SetLayout, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=3};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TGDIPStatus;
class PASCALIMPLEMENTATION TGDIPStatus : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FWidth;
	int FHeight;
	TGDIPFill* FFill;
	Graphics::TFont* FFont;
	Classes::TNotifyEvent FOnChange;
	bool FAutoSize;
	int FSpacing;
	bool FGlow;
	void __fastcall SetFill(const TGDIPFill* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetGlow(const bool Value);
	
protected:
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall Changed(void);
	
public:
	__fastcall TGDIPStatus(void);
	__fastcall virtual ~TGDIPStatus(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Advgdip::TGPGraphics* g, int x, int y, int Width, int Height, bool AutoSize, System::UnicodeString Caption);
	int __fastcall GetWidth(void);
	int __fastcall GetHeight(void);
	void __fastcall CalculateSize(Advgdip::TGPGraphics* g, System::UnicodeString Caption);
	
__published:
	__property TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=0};
	__property bool Glow = {read=FGlow, write=SetGlow, default=1};
};


#pragma option push -b-
enum TGDIPProgressValueType { vtPercentage, vtAbsolute };
#pragma option pop

#pragma option push -b-
enum TGDIPProgressValuePosition { vpProgressCenter, vpProgressRight, vpCenter, vpLeft, vpRight, vpCustom };
#pragma option pop

class DELPHICLASS TGDIPProgress;
class PASCALIMPLEMENTATION TGDIPProgress : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TGDIPFill* FBackGroundFill;
	System::UnicodeString FValueFormat;
	TGDIPProgressValueType FValueType;
	TGDIPFill* FProgressFill;
	int FValuePositionTop;
	int FValuePositionLeft;
	Graphics::TFont* FFont;
	TGDIPProgressValuePosition FValuePosition;
	Classes::TNotifyEvent FOnChange;
	bool FValueVisible;
	Graphics::TFont* FProgressFont;
	bool FTransparent;
	void __fastcall SetBackGroundFill(const TGDIPFill* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetProgressFill(const TGDIPFill* Value);
	void __fastcall SetValueFormat(const System::UnicodeString Value);
	void __fastcall SetValuePosition(const TGDIPProgressValuePosition Value);
	void __fastcall SetValuePositionLeft(const int Value);
	void __fastcall SetValuePositionTop(const int Value);
	void __fastcall SetValueType(const TGDIPProgressValueType Value);
	void __fastcall SetValueVisible(const bool Value);
	void __fastcall SetProgressFont(const Graphics::TFont* Value);
	void __fastcall SetTransparent(const bool Value);
	
protected:
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall Changed(void);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall DrawShadows(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r);
	void __fastcall DrawValue(Advgdip::TGPGraphics* g, const Types::TRect &r, double min, double max, double position);
	void __fastcall DrawProgress(Advgdip::TGPGraphics* g, const Types::TRect &r, double min, double max, double position);
	void __fastcall DrawOverLay(Advgdip::TGPGraphics* g, const Types::TRect &r);
	void __fastcall DrawGlow(Advgdip::TGPGraphics* g, const Types::TRect &r, double glowposition, double min, double max, double position);
	Types::TRect __fastcall InsideRect(const Types::TRect &r);
	void __fastcall GetTextSize(Advgdip::TGPGraphics* g, const Types::TRect &r, System::UnicodeString s, Graphics::TFont* ft, Advgdip::TGPRectF &sizer);
	
public:
	__fastcall TGDIPProgress(void);
	__fastcall virtual ~TGDIPProgress(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Types::TRect &r, double min, double max, double position);
	Advgdip::TGPRectF __fastcall GetInsideRectF(const Types::TRect &r);
	Advgdip::TGPRectF __fastcall CalculateProgressRectangle(const Types::TRect &r, double min, double max, double pos);
	
__published:
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property TGDIPFill* BackGroundFill = {read=FBackGroundFill, write=SetBackGroundFill};
	__property TGDIPFill* ProgressFill = {read=FProgressFill, write=SetProgressFill};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* ProgressFont = {read=FProgressFont, write=SetProgressFont};
	__property System::UnicodeString ValueFormat = {read=FValueFormat, write=SetValueFormat};
	__property TGDIPProgressValueType ValueType = {read=FValueType, write=SetValueType, default=1};
	__property TGDIPProgressValuePosition ValuePosition = {read=FValuePosition, write=SetValuePosition, default=2};
	__property int ValuePositionLeft = {read=FValuePositionLeft, write=SetValuePositionLeft, default=0};
	__property int ValuePositionTop = {read=FValuePositionTop, write=SetValuePositionTop, default=0};
	__property bool ValueVisible = {read=FValueVisible, write=SetValueVisible, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma option push -b-
enum TLegendPosition { lpTop, lpBottom };
#pragma option pop

typedef void __fastcall (__closure *TOnItemEvent)(System::TObject* Sender, int Index);

class DELPHICLASS TCapacityItem;
class PASCALIMPLEMENTATION TCapacityItem : public Classes::TCollectionItem
{
	typedef Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::UnicodeString FHint;
	Graphics::TColor FColor;
	int FTag;
	System::UnicodeString FDescription;
	double FValue;
	Graphics::TColor FColorTo;
	System::UnicodeString FLegendFormat;
	double FDisplayValue;
	Advgdip::TGPRectF FDesRect;
	Advgdip::TGPRectF FFormatRect;
	Types::TPoint FMarkPT;
	int FWidth;
	int FLeft;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetDescription(const System::UnicodeString Value);
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetTag(const int Value);
	void __fastcall SetValue(const double Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall SetIndex(int Value);
	void __fastcall Change(void);
	__property System::UnicodeString LegendFormat = {read=FLegendFormat, write=FLegendFormat};
	__property double DisplayValue = {read=FDisplayValue, write=FDisplayValue};
	__property int Left = {read=FLeft, write=FLeft, nodefault};
	__property int Width = {read=FWidth, write=FWidth, nodefault};
	
public:
	__fastcall virtual TCapacityItem(Classes::TCollection* Collection);
	__fastcall virtual ~TCapacityItem(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property double Value = {read=FValue, write=SetValue};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property System::UnicodeString Description = {read=FDescription, write=SetDescription};
	__property int Tag = {read=FTag, write=SetTag, default=0};
};


class DELPHICLASS TCapacityItems;
class PASCALIMPLEMENTATION TCapacityItems : public Classes::TCollection
{
	typedef Classes::TCollection inherited;
	
public:
	TCapacityItem* operator[](int Index) { return Items[Index]; }
	
private:
	Classes::TPersistent* FOwner;
	Classes::TNotifyEvent FOnChange;
	TOnItemEvent FOnDeleteItem;
	TCapacityItem* FDownItem;
	TOnItemEvent FOnCreateItem;
	HIDESBASE TCapacityItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, const TCapacityItem* Value);
	void __fastcall SetDownItem(const TCapacityItem* Value);
	
protected:
	void __fastcall Change(void);
	__property TCapacityItem* DownItem = {read=FDownItem, write=SetDownItem};
	
public:
	__fastcall TCapacityItems(Classes::TPersistent* AOwner);
	__property TCapacityItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	HIDESBASE TCapacityItem* __fastcall Add(void);
	HIDESBASE TCapacityItem* __fastcall Insert(int Index);
	DYNAMIC Classes::TPersistent* __fastcall GetOwner(void);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TOnItemEvent OnDeleteItem = {read=FOnDeleteItem, write=FOnDeleteItem};
	__property TOnItemEvent OnCreateItem = {read=FOnCreateItem, write=FOnCreateItem};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TCapacityItems(void) { }
	
};


typedef void __fastcall (__closure *TGetCapacityFormatEvent)(System::TObject* Sender, System::UnicodeString &Format, double &Capacity);

typedef void __fastcall (__closure *TGetLegendFormatEvent)(System::TObject* Sender, TCapacityItem* Item, System::UnicodeString &Format, double &Value);

class DELPHICLASS TGDIPCapacityBar;
class PASCALIMPLEMENTATION TGDIPCapacityBar : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TGDIPFill* FBackGroundFill;
	Graphics::TFont* FCapacityFont;
	Classes::TNotifyEvent FOnChange;
	Graphics::TFont* FLegendFont;
	bool FTransparent;
	System::UnicodeString FCapacityFormat;
	int FReflectionOpacityStart;
	bool FRounded;
	int FDivisions;
	int FReflectionAxis;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	int FReflectionOpacityEnd;
	System::UnicodeString FLegendFormat;
	bool FReflection;
	TLegendPosition FLegendPos;
	TGetLegendFormatEvent FOnGetLegendFormat;
	TGetCapacityFormatEvent FOnGetCapacityFormat;
	Advgdip::TGPRectF FCapDesRect;
	Advgdip::TGPRectF FCapFormatRect;
	Advgdip::TGPRectF FLegendRect;
	Advgdip::TGPRectF FBarRect;
	Types::TPoint FFreeMarkPT;
	Advgdip::TGPRectF FFreeDesRect;
	Advgdip::TGPRectF FFreeFormatRect;
	int FOffsetX;
	int FOffsetY;
	int FTextGap;
	int FMarkSize;
	double FFreeSpace;
	System::UnicodeString FFreeFormat;
	int FFreeLeft;
	int FFreeWidth;
	Advgdip::TGPBitmap* FReflectionPic;
	bool FUpdateReflection;
	void __fastcall SetBackGroundFill(const TGDIPFill* Value);
	void __fastcall SetCapacityFont(const Graphics::TFont* Value);
	void __fastcall SetLegendFont(const Graphics::TFont* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetCapacityFormat(const System::UnicodeString Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDivisions(const int Value);
	void __fastcall SetLegendFormat(const System::UnicodeString Value);
	void __fastcall SetLegendPos(const TLegendPosition Value);
	void __fastcall SetReflectionAxis(const int Value);
	void __fastcall SetReflectionOpacityEnd(const int Value);
	void __fastcall SetReflectionOpacityStart(const int Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetReflection(const bool Value);
	void __fastcall SetOffsetX(const int Value);
	void __fastcall SetOffsetY(const int Value);
	void __fastcall SetTextGap(const int Value);
	void __fastcall SetFreeFormat(const System::UnicodeString Value);
	
protected:
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall BackGroundFillChanged(System::TObject* Sender);
	void __fastcall Changed(void);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R);
	void __fastcall DrawCapacityDescription(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R, System::UnicodeString CapacityDes, System::UnicodeString DesFormat);
	void __fastcall DrawLegend(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R, TCapacityItems* Items, System::UnicodeString FreeDes, System::UnicodeString FreeDesFormat);
	void __fastcall DrawItem(Advgdip::TGPGraphics* g, TCapacityItem* Item)/* overload */;
	void __fastcall DrawItem(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &RF, Graphics::TColor Clr, Graphics::TColor ClrTo, int StartLeft)/* overload */;
	void __fastcall DrawBar(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &R, TCapacityItems* Items);
	Types::TRect __fastcall InsideRect(const Types::TRect &r);
	void __fastcall GetTextSize(Advgdip::TGPGraphics* g, const Types::TRect &r, System::UnicodeString s, Graphics::TFont* ft, Advgdip::TGPRectF &sizer);
	void __fastcall CalculateCapacityBarRect(Advgdip::TGPGraphics* g, const Types::TRect &R, double TotalCapacity, TCapacityItems* Items, System::UnicodeString CapacityDes, System::UnicodeString DesFormat, System::UnicodeString FreeDes, System::UnicodeString FreeDesFormat);
	TCapacityItem* __fastcall PtOnItem(const Types::TPoint &pt, TCapacityItems* Items);
	void __fastcall UpdateReflection(void);
	__property TGetCapacityFormatEvent OnGetCapacityFormat = {read=FOnGetCapacityFormat, write=FOnGetCapacityFormat};
	__property TGetLegendFormatEvent OnGetLegendFormat = {read=FOnGetLegendFormat, write=FOnGetLegendFormat};
	__property int ReflectionAxis = {read=FReflectionAxis, write=SetReflectionAxis, default=1};
	__property double FreeSpace = {read=FFreeSpace};
	__property int TextGap = {read=FTextGap, write=SetTextGap, default=3};
	
public:
	__fastcall TGDIPCapacityBar(void);
	__fastcall virtual ~TGDIPCapacityBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall Draw(Advgdip::TGPGraphics* g, const Types::TRect &r, double TotalCapacity, TCapacityItems* Items, System::UnicodeString CapacityDes, System::UnicodeString DesFormat, System::UnicodeString FreeDes, System::UnicodeString FreeDesFormat);
	Advgdip::TGPRectF __fastcall GetInsideRectF(const Types::TRect &r);
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
__published:
	__property TGDIPFill* BackGroundFill = {read=FBackGroundFill, write=SetBackGroundFill};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TFont* CapacityFont = {read=FCapacityFont, write=SetCapacityFont};
	__property System::UnicodeString CapacityFormat = {read=FCapacityFormat, write=SetCapacityFormat};
	__property System::UnicodeString FreeFormat = {read=FFreeFormat, write=SetFreeFormat};
	__property int Divisions = {read=FDivisions, write=SetDivisions, default=20};
	__property TLegendPosition LegendPos = {read=FLegendPos, write=SetLegendPos, default=1};
	__property System::UnicodeString LegendFormat = {read=FLegendFormat, write=SetLegendFormat};
	__property Graphics::TFont* LegendFont = {read=FLegendFont, write=SetLegendFont};
	__property bool Rounded = {read=FRounded, write=SetRounded, default=1};
	__property bool Reflection = {read=FReflection, write=SetReflection, default=1};
	__property int ReflectionOpacityStart = {read=FReflectionOpacityStart, write=SetReflectionOpacityStart, default=150};
	__property int ReflectionOpacityEnd = {read=FReflectionOpacityEnd, write=SetReflectionOpacityEnd, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property int OffsetX = {read=FOffsetX, write=SetOffsetX, default=15};
	__property int OffsetY = {read=FOffsetY, write=SetOffsetY, default=8};
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE System::Word CF_GDIPFILL;
extern PACKAGE void __fastcall DrawLed(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, TFillValueType ValueType, System::UnicodeString Format, System::UnicodeString TimeFormat, double Value, System::TDateTime TimeValue, Graphics::TColor ColorOff, System::Byte ColorOffOpacity, Graphics::TColor ColorStart, Graphics::TColor ColorEnd, System::Byte OpacityStart, System::Byte OpacityEnd, Advgdip::TAdvGradientType GradientType, int Angle, Advgdip::HatchStyle HatchStyle, Advgdip::TAdvGDIPPicture* Picture);
extern PACKAGE Advgdip::TGPGraphicsPath* __fastcall CreateRoundRectangle(const Advgdip::TGPRectF &R, int Radius, TFillRoundingType RoundingType, bool Mirror)/* overload */;

}	/* namespace Gdipfill */
using namespace Gdipfill;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// GdipfillHPP
