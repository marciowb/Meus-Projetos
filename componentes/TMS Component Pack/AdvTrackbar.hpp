// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advtrackbar.pas' rev: 21.00

#ifndef AdvtrackbarHPP
#define AdvtrackbarHPP

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
#include <Dialogs.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advtrackbar
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical, gdHorizontalInOut, gdVerticalInOut };
#pragma option pop

#pragma option push -b-
enum TThumbShape { tsPointer, tsRectangle, tsRoundRect, tsRound, tsLine, tsPointerLeftUp, tsPointerRightUp, tsTriangle, tsTriangleLeft, tsTriangleRight };
#pragma option pop

#pragma option push -b-
enum TThumbStyle { tstOffice2007, tstCustom };
#pragma option pop

#pragma option push -b-
enum TShapeDir { sdLeft, sdRight, sdTop, sdBottom, sdLeftRight, sdTopBottom };
#pragma option pop

#pragma option push -b-
enum TTrackButtonShape { bsRound, bsRectangle };
#pragma option pop

#pragma option push -b-
enum TGDIPGradient { ggRadial, ggVertical, ggDiagonalForward, ggDiagonalBackward };
#pragma option pop

#pragma option push -b-
enum TLabelPosition { lpTopCenter, lpTopLeft, lpTopRight, lpBottomCenter, lpBottomLeft, lpBottomRight };
#pragma option pop

#pragma option push -b-
enum TThumbOverlap { tolNone, tolLeftUp, tolRightUp };
#pragma option pop

#pragma option push -b-
enum TThumbPointer { tpLeft, tpCenter, tpRight };
#pragma option pop

#pragma option push -b-
enum TMoveOnClick { mcStep, mcMove };
#pragma option pop

class DELPHICLASS TTrackBarThumb;
class DELPHICLASS TCustomTrackBar;
class PASCALIMPLEMENTATION TTrackBarThumb : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSteps;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FBorderColorHot;
	int FWidth;
	Graphics::TColor FColorDisabledTo;
	Graphics::TColor FBorderColorDown;
	Graphics::TColor FBorderColorDisabled;
	Graphics::TColor FColorDown;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorDisabled;
	Gdipicture::TGDIPPicture* FIPicture;
	TThumbShape FShape;
	TThumbStyle FStyle;
	Gdipicture::TGDIPPicture* FIPictureDisabled;
	Gdipicture::TGDIPPicture* FIPictureDown;
	Gdipicture::TGDIPPicture* FIPictureHot;
	Graphics::TColor FColorMirrorHot;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FColorMirrorDisabledTo;
	Graphics::TColor FColorMirrorDisabled;
	Graphics::TColor FColorMirrorHotTo;
	Graphics::TColor FColorMirrorDown;
	Graphics::TColor FColorMirrorDownTo;
	TGDIPGradient FGradient;
	TGDIPGradient FGradientMirror;
	bool FPictureStretched;
	TCustomTrackBar* FAdvTrackBar;
	int FSize;
	bool FShowAtMinMax;
	TThumbPointer FThumbPointer;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetBorderColorDisabled(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetShape(const TThumbShape Value);
	void __fastcall SetStyle(const TThumbStyle Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetPictureDisabled(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPictureDown(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPictureHot(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetColorMirrorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorMirrorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorMirror(const Graphics::TColor Value);
	void __fastcall SetColorMirrorTo(const Graphics::TColor Value);
	void __fastcall SetGradientMirror(const TGDIPGradient Value);
	void __fastcall SetGradient(const TGDIPGradient Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetShowAtMinMax(const bool Value);
	void __fastcall SetThumbPointer(TThumbPointer Value);
	
protected:
	void __fastcall Changed(void);
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	__property TThumbStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property TCustomTrackBar* AdvTrackBar = {read=FAdvTrackBar, write=FAdvTrackBar};
	
public:
	__fastcall TTrackBarThumb(void);
	__fastcall virtual ~TTrackBarThumb(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, nodefault};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=SetBorderColorDown, nodefault};
	__property Graphics::TColor BorderColorDisabled = {read=FBorderColorDisabled, write=SetBorderColorDisabled, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, nodefault};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, nodefault};
	__property Graphics::TColor ColorDisabledTo = {read=FColorDisabledTo, write=SetColorDisabledTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=SetColorMirror, nodefault};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=SetColorMirrorTo, nodefault};
	__property Graphics::TColor ColorMirrorHot = {read=FColorMirrorHot, write=FColorMirrorHot, nodefault};
	__property Graphics::TColor ColorMirrorHotTo = {read=FColorMirrorHotTo, write=FColorMirrorHotTo, nodefault};
	__property Graphics::TColor ColorMirrorDown = {read=FColorMirrorDown, write=FColorMirrorDown, nodefault};
	__property Graphics::TColor ColorMirrorDownTo = {read=FColorMirrorDownTo, write=FColorMirrorDownTo, nodefault};
	__property Graphics::TColor ColorMirrorDisabled = {read=FColorMirrorDisabled, write=SetColorMirrorDisabled, nodefault};
	__property Graphics::TColor ColorMirrorDisabledTo = {read=FColorMirrorDisabledTo, write=SetColorMirrorDisabledTo, nodefault};
	__property TGDIPGradient Gradient = {read=FGradient, write=SetGradient, nodefault};
	__property TGDIPGradient GradientMirror = {read=FGradientMirror, write=SetGradientMirror, nodefault};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property Gdipicture::TGDIPPicture* PictureHot = {read=FIPictureHot, write=SetPictureHot};
	__property Gdipicture::TGDIPPicture* PictureDown = {read=FIPictureDown, write=SetPictureDown};
	__property Gdipicture::TGDIPPicture* PictureDisabled = {read=FIPictureDisabled, write=SetPictureDisabled};
	__property bool ShowAtMinMax = {read=FShowAtMinMax, write=SetShowAtMinMax, default=1};
	__property int Size = {read=FSize, write=SetSize, default=15};
	__property int Width = {read=FWidth, write=SetWidth, default=10};
	__property TThumbShape Shape = {read=FShape, write=SetShape, nodefault};
	__property TThumbPointer ThumbPointer = {read=FThumbPointer, write=SetThumbPointer, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TTrackBarSlider;
class PASCALIMPLEMENTATION TTrackBarSlider : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSteps;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	TGradientDirection FDirection;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	bool FRounded;
	bool FBorder3D;
	Gdipicture::TGDIPPicture* FIPicture;
	Graphics::TColor FColorDisabledTo;
	Graphics::TColor FBorderColorDisabled;
	Graphics::TColor FColorDisabled;
	Gdipicture::TGDIPPicture* FIPictureDisabled;
	int FSize;
	bool FVisible;
	bool FPictureStretched;
	Graphics::TColor FColorCompletedDisabledTo;
	Graphics::TColor FColorCompletedTo;
	Graphics::TColor FColorCompleted;
	Graphics::TColor FColorCompletedDisabled;
	Gdipicture::TGDIPPicture* FPictureCompletedDisabled;
	Gdipicture::TGDIPPicture* FPictureCompleted;
	int FOffset;
	TCustomTrackBar* FAdvTrackBar;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDirection(const TGradientDirection Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorder3D(const bool Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetBorderColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetPictureDisabled(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetPictureStretched(const bool Value);
	void __fastcall SetColorCompleted(const Graphics::TColor Value);
	void __fastcall SetColorCompletedDisabled(const Graphics::TColor Value);
	void __fastcall SetColorCompletedDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorCompletedTo(const Graphics::TColor Value);
	void __fastcall SetPictureCompleted(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPictureCompletedDisabled(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetOffset(const int Value);
	
protected:
	void __fastcall Changed(void);
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	
public:
	__fastcall TTrackBarSlider(void);
	__fastcall virtual ~TTrackBarSlider(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	__property TCustomTrackBar* AdvTrackBar = {read=FAdvTrackBar, write=FAdvTrackBar};
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderColorDisabled = {read=FBorderColorDisabled, write=SetBorderColorDisabled, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, nodefault};
	__property Graphics::TColor ColorDisabledTo = {read=FColorDisabledTo, write=SetColorDisabledTo, nodefault};
	__property Graphics::TColor ColorCompleted = {read=FColorCompleted, write=SetColorCompleted, nodefault};
	__property Graphics::TColor ColorCompletedTo = {read=FColorCompletedTo, write=SetColorCompletedTo, nodefault};
	__property Graphics::TColor ColorCompletedDisabled = {read=FColorCompletedDisabled, write=SetColorCompletedDisabled, nodefault};
	__property Graphics::TColor ColorCompletedDisabledTo = {read=FColorCompletedDisabledTo, write=SetColorCompletedDisabledTo, nodefault};
	__property TGradientDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property Gdipicture::TGDIPPicture* PictureDisabled = {read=FIPictureDisabled, write=SetPictureDisabled};
	__property Gdipicture::TGDIPPicture* PictureCompleted = {read=FPictureCompleted, write=SetPictureCompleted};
	__property Gdipicture::TGDIPPicture* PictureCompletedDisabled = {read=FPictureCompletedDisabled, write=SetPictureCompletedDisabled};
	__property bool PictureStretched = {read=FPictureStretched, write=SetPictureStretched, default=0};
	__property int Size = {read=FSize, write=SetSize, default=2};
	__property bool Border3D = {read=FBorder3D, write=SetBorder3D, default=1};
	__property bool Rounded = {read=FRounded, write=SetRounded, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property int Offset = {read=FOffset, write=SetOffset, default=10};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TTrackBarTick;
class PASCALIMPLEMENTATION TTrackBarTick : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FColor;
	Classes::TNotifyEvent FOnChange;
	Gdipicture::TGDIPPicture* FIPicture;
	Graphics::TColor FColorDisabled;
	Gdipicture::TGDIPPicture* FIPictureDisabled;
	Comctrls::TTickMark FPosition;
	Comctrls::TTickStyle FStyle;
	bool FShowText;
	Graphics::TFont* FFont;
	bool FLine3D;
	bool FShowImageAtThumbOnly;
	int FShowImageAtSteps;
	int FSpacing;
	int FSize;
	bool FRotateFontVert;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall OnFontChanged(System::TObject* Sender);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetPictureDisabled(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPosition(const Comctrls::TTickMark Value);
	void __fastcall SetStyle(const Comctrls::TTickStyle Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetShowText(const bool Value);
	void __fastcall SetLine3D(const bool Value);
	void __fastcall SetShowImageAtThumbOnly(const bool Value);
	void __fastcall SetShowImageAtSteps(const int Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetRotateFontVert(const bool Value);
	
protected:
	void __fastcall Changed(void);
	
public:
	__fastcall TTrackBarTick(void);
	__fastcall virtual ~TTrackBarTick(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, nodefault};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property bool Line3D = {read=FLine3D, write=SetLine3D, default=0};
	__property Gdipicture::TGDIPPicture* Picture = {read=FIPicture, write=SetPicture};
	__property Gdipicture::TGDIPPicture* PictureDisabled = {read=FIPictureDisabled, write=SetPictureDisabled};
	__property Comctrls::TTickMark Position = {read=FPosition, write=SetPosition, default=0};
	__property bool RotateFontVert = {read=FRotateFontVert, write=SetRotateFontVert, default=1};
	__property Comctrls::TTickStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property bool ShowText = {read=FShowText, write=SetShowText, default=0};
	__property bool ShowImageAtThumbOnly = {read=FShowImageAtThumbOnly, write=SetShowImageAtThumbOnly, default=0};
	__property int ShowImageAtSteps = {read=FShowImageAtSteps, write=SetShowImageAtSteps, default=1};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=8};
	__property int Size = {read=FSize, write=SetSize, default=4};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TTrackBarButtons;
class PASCALIMPLEMENTATION TTrackBarButtons : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FVisible;
	Graphics::TColor FColorHot;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorDownTo;
	Graphics::TColor FColorDown;
	Graphics::TColor FBorderColorDown;
	Graphics::TColor FBorderColorHot;
	Graphics::TColor FBorderColor;
	Gdipicture::TGDIPPicture* FIMaxPictureHot;
	Gdipicture::TGDIPPicture* FIMaxPictureDown;
	Gdipicture::TGDIPPicture* FIMinPicture;
	Gdipicture::TGDIPPicture* FIMaxPicture;
	Gdipicture::TGDIPPicture* FIMinPictureHot;
	Gdipicture::TGDIPPicture* FIMinPictureDown;
	Classes::TNotifyEvent FOnChange;
	TTrackButtonShape FShape;
	Graphics::TColor FColorMirror;
	Graphics::TColor FColorMirrorTo;
	Graphics::TColor FColorMirrorHot;
	Graphics::TColor FColorMirrorDownTo;
	Graphics::TColor FColorMirrorHotTo;
	Graphics::TColor FColorMirrorDown;
	TGDIPGradient FGradientMirror;
	TGDIPGradient FGradient;
	int FCornerRadius;
	bool FRepeatClick;
	int FInitRepeatPause;
	int FRepeatPause;
	int FSize;
	TCustomTrackBar* FAdvTrackBar;
	int FSpacing;
	int FStep;
	bool FRotateText;
	void __fastcall PictureChanged(System::TObject* Sender);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorDown(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorDown(const Graphics::TColor Value);
	void __fastcall SetColorDownTo(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetMaxPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetMaxPictureDown(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetMaxPictureHot(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetMinPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetMinPictureDown(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetMinPictureHot(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetShape(const TTrackButtonShape Value);
	void __fastcall SetCornerRadius(const int Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetGradient(const TGDIPGradient Value);
	void __fastcall SetGradientMirror(const TGDIPGradient Value);
	void __fastcall SetSpacing(const int Value);
	void __fastcall SetRotateText(const bool Value);
	
protected:
	void __fastcall Changed(void);
	__property int CornerRadius = {read=FCornerRadius, write=SetCornerRadius, nodefault};
	__property TCustomTrackBar* AdvTrackBar = {read=FAdvTrackBar, write=FAdvTrackBar};
	
public:
	__fastcall TTrackBarButtons(void);
	__fastcall virtual ~TTrackBarButtons(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, nodefault};
	__property Graphics::TColor BorderColorDown = {read=FBorderColorDown, write=SetBorderColorDown, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, nodefault};
	__property Graphics::TColor ColorDown = {read=FColorDown, write=SetColorDown, nodefault};
	__property Graphics::TColor ColorDownTo = {read=FColorDownTo, write=SetColorDownTo, nodefault};
	__property Graphics::TColor ColorMirror = {read=FColorMirror, write=FColorMirror, default=12632256};
	__property Graphics::TColor ColorMirrorTo = {read=FColorMirrorTo, write=FColorMirrorTo, default=16777215};
	__property Graphics::TColor ColorMirrorHot = {read=FColorMirrorHot, write=FColorMirrorHot, nodefault};
	__property Graphics::TColor ColorMirrorHotTo = {read=FColorMirrorHotTo, write=FColorMirrorHotTo, nodefault};
	__property Graphics::TColor ColorMirrorDown = {read=FColorMirrorDown, write=FColorMirrorDown, nodefault};
	__property Graphics::TColor ColorMirrorDownTo = {read=FColorMirrorDownTo, write=FColorMirrorDownTo, nodefault};
	__property TGDIPGradient Gradient = {read=FGradient, write=SetGradient, default=1};
	__property TGDIPGradient GradientMirror = {read=FGradientMirror, write=SetGradientMirror, nodefault};
	__property Gdipicture::TGDIPPicture* MinPicture = {read=FIMinPicture, write=SetMinPicture};
	__property Gdipicture::TGDIPPicture* MinPictureHot = {read=FIMinPictureHot, write=SetMinPictureHot};
	__property Gdipicture::TGDIPPicture* MinPictureDown = {read=FIMinPictureDown, write=SetMinPictureDown};
	__property Gdipicture::TGDIPPicture* MaxPicture = {read=FIMaxPicture, write=SetMaxPicture};
	__property Gdipicture::TGDIPPicture* MaxPictureHot = {read=FIMaxPictureHot, write=SetMaxPictureHot};
	__property Gdipicture::TGDIPPicture* MaxPictureDown = {read=FIMaxPictureDown, write=SetMaxPictureDown};
	__property int InitRepeatPause = {read=FInitRepeatPause, write=FInitRepeatPause, default=400};
	__property int RepeatPause = {read=FRepeatPause, write=FRepeatPause, default=100};
	__property bool RepeatClick = {read=FRepeatClick, write=FRepeatClick, default=1};
	__property bool RotateText = {read=FRotateText, write=SetRotateText, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property int Size = {read=FSize, write=SetSize, default=20};
	__property TTrackButtonShape Shape = {read=FShape, write=SetShape, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=2};
	__property int Step = {read=FStep, write=FStep, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TTrackBarLabel;
class PASCALIMPLEMENTATION TTrackBarLabel : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	bool FVisible;
	System::UnicodeString FFormat;
	Graphics::TFont* FFont;
	TLabelPosition FPosition;
	Classes::TNotifyEvent FOnChange;
	int FSpacing;
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetFormat(const System::UnicodeString Value);
	void __fastcall SetPosition(const TLabelPosition Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall Changed(void);
	void __fastcall OnFontChanged(System::TObject* Sender);
	void __fastcall SetSpacing(const int Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TTrackBarLabel(void);
	__fastcall virtual ~TTrackBarLabel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=0};
	__property TLabelPosition Position = {read=FPosition, write=SetPosition, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString Format = {read=FFormat, write=SetFormat};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=4};
};


class DELPHICLASS TTrackHintWindow;
class PASCALIMPLEMENTATION TTrackHintWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	int FTextHeight;
	int FTextWidth;
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	virtual void __fastcall ActivateHint(const Types::TRect &Rect, const System::UnicodeString AHint);
	virtual Types::TRect __fastcall CalcHintRect(int MaxWidth, const System::UnicodeString AHint, void * AData);
public:
	/* THintWindow.Create */ inline __fastcall virtual TTrackHintWindow(Classes::TComponent* AOwner) : Controls::THintWindow(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TTrackHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTrackHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TDrawTickEvent)(System::TObject* Sender, Graphics::TCanvas* Canvas, const Types::TPoint &Location, int Position, Comctrls::TTickMark TickPos, int &Length, Graphics::TColor &Color, Graphics::TColor &TextColor, System::UnicodeString &Text, bool &DefaultDraw);

typedef void __fastcall (__closure *TGetTrackHintEvent)(System::TObject* Sender, int Position, System::UnicodeString &HintStr);

typedef void __fastcall (__closure *TGetTrackLabelEvent)(System::TObject* Sender, int Position, System::UnicodeString &value);

typedef void __fastcall (__closure *TGetTickMarkTextEvent)(System::TObject* Sender, int Index, System::UnicodeString &value);

class PASCALIMPLEMENTATION TCustomTrackBar : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	TTrackBarThumb* FThumb;
	TTrackBarSlider* FSlider;
	TTrackBarTick* FTickMark;
	int FMax;
	int FMin;
	Comctrls::TTrackBarOrientation FOrientation;
	int FPageSize;
	int FPosition;
	bool FSliding;
	Classes::TNotifyEvent FOnChange;
	TDrawTickEvent FOnDrawTick;
	Graphics::TColor FColorDisabled;
	Graphics::TColor FColorTo;
	Graphics::TColor FBorderColorDisabled;
	Graphics::TColor FBorderColor;
	Graphics::TColor FColorDisabledTo;
	Gdipicture::TGDIPPicture* FIBackGround;
	TGradientDirection FDirection;
	bool FTransparent;
	int FSliderTickOffset;
	int FOffset;
	int FTickTextOffset;
	bool FThumbHot;
	bool FThumbDown;
	Imglist::TCustomImageList* FImages;
	Gdipicture::TGDIPPicture* FIRateInActive;
	Gdipicture::TGDIPPicture* FIRateActive;
	Gdipicture::TGDIPPicture* FIBackGroundDisabled;
	TTrackBarButtons* FButtons;
	int FBorderWidth;
	bool FMinButtonHot;
	bool FMinButtonDown;
	bool FMaxButtonHot;
	bool FMaxButtonDown;
	bool FSliderButtonDown;
	Types::TPoint FSliderDownPt;
	int FTextHeight;
	Extctrls::TTimer* FRepeatTimer;
	bool FTrackHint;
	TGetTrackHintEvent FOnGetTrackHint;
	bool FBackGroundStretched;
	int FHintTickIndex;
	TTrackHintWindow* FTrackHintWnd;
	bool FTrackHintShow;
	bool FShowFocus;
	TMoveOnClick FMoveOnClick;
	TTrackBarLabel* FTrackLabel;
	TGetTrackLabelEvent FOnGetTrackLabelText;
	TGetTickMarkTextEvent FOnGetTickMarkText;
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Controls::TCMFocusChanged &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Messages::TMessage &Message);
	void __fastcall BackGroundChanged(System::TObject* Sender);
	void __fastcall OnThumbChanged(System::TObject* Sender);
	void __fastcall OnSliderChanged(System::TObject* Sender);
	void __fastcall OnTickMarkChanged(System::TObject* Sender);
	void __fastcall OnRatePictureChanged(System::TObject* Sender);
	void __fastcall OnButtonsChanged(System::TObject* Sender);
	void __fastcall OnTrackLabelChanged(System::TObject* Sender);
	void __fastcall SetMax(int Value);
	void __fastcall SetMin(int Value);
	void __fastcall SetOrientation(Comctrls::TTrackBarOrientation Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabled(const Graphics::TColor Value);
	void __fastcall SetColorDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDirection(const TGradientDirection Value);
	void __fastcall SetBackGround(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetSlider(const TTrackBarSlider* Value);
	void __fastcall SetThumb(const TTrackBarThumb* Value);
	void __fastcall SetTickMark(const TTrackBarTick* Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	void __fastcall SetRateActive(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetRateInActive(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetBackGroundDisabled(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetButtons(const TTrackBarButtons* Value);
	HIDESBASE void __fastcall SetBorderWidth(const int Value);
	void __fastcall SetBackGroundStretched(const bool Value);
	void __fastcall SetTrackLabel(const TTrackBarLabel* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetThumbPointerPos(void);
	
protected:
	int __fastcall GetVersionNr(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall DoEnter(void);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC bool __fastcall DoMouseWheelDown(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(Classes::TShiftState Shift, const Types::TPoint &MousePos);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	virtual void __fastcall SetPosition(int Value);
	virtual void __fastcall RepeatTimerExpired(System::TObject* Sender);
	virtual bool __fastcall CanMoveOnTickClick(void);
	virtual System::UnicodeString __fastcall GetTrackLabelText(void);
	virtual TTrackBarSlider* __fastcall CreateTrackBarSlider(void);
	virtual bool __fastcall CanClipThumb(void);
	virtual bool __fastcall CanMovePosition(int Value);
	virtual int __fastcall GetPosiblePositionMin(void);
	virtual int __fastcall GetPosiblePositionMax(void);
	Types::TRect __fastcall InternalClientRect(void);
	Types::TRect __fastcall TrackClientRect(void);
	virtual Types::TRect __fastcall TickMarkTopRect(void);
	virtual Types::TRect __fastcall TickMarkBottomRect(void);
	Types::TRect __fastcall SliderRect(void);
	virtual Types::TRect __fastcall ThumbRect(bool ConsiderOverlap = false);
	Types::TRect __fastcall TrackingRect(void);
	Types::TRect __fastcall TrackLabelRect(bool TextRect = false);
	virtual bool __fastcall IsGetTrackLabelAssigned(void);
	tagSIZE __fastcall RateSize(void);
	Types::TRect __fastcall RateRect(int Index);
	int __fastcall IndexOfRate(int X, int Y);
	Types::TRect __fastcall MinButtonRect(void);
	Types::TRect __fastcall MaxButtonRect(void);
	int __fastcall ButtonWidth(void);
	virtual void __fastcall ClickMinButton(void);
	virtual void __fastcall ClickMaxButton(void);
	virtual void __fastcall ClickSlider(void);
	virtual int __fastcall GetThumbWidth(void);
	virtual bool __fastcall CanChangeThumbPointer(TTrackBarThumb* aThumb, TThumbPointer &Value);
	int __fastcall IndexOfTickAt(int X, int Y);
	double __fastcall GetTickMarkGap(void);
	void __fastcall DrawBackGround(void);
	virtual void __fastcall DrawSlider(void);
	void __fastcall DrawTickMarks(void);
	void __fastcall DrawInternalThumb(TTrackBarThumb* Thumb, const Types::TRect &R, bool ThumbHot, bool ThumbDown, int Position);
	virtual void __fastcall DrawThumb(void);
	void __fastcall DrawTrackLabel(void);
	void __fastcall DrawRate(int Index);
	void __fastcall DrawRates(void);
	void __fastcall DrawMinButton(void);
	void __fastcall DrawMaxButton(void);
	void __fastcall DrawButtons(void);
	bool __fastcall IsRating(void);
	virtual void __fastcall InvalidateTrackLabel(void);
	__property int Max = {read=FMax, write=SetMax, default=10};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property Comctrls::TTrackBarOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property int PageSize = {read=FPageSize, write=FPageSize, default=1};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderColorDisabled = {read=FBorderColorDisabled, write=SetBorderColorDisabled, nodefault};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=1};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorDisabled = {read=FColorDisabled, write=SetColorDisabled, nodefault};
	__property Graphics::TColor ColorDisabledTo = {read=FColorDisabledTo, write=SetColorDisabledTo, nodefault};
	__property TGradientDirection Direction = {read=FDirection, write=SetDirection, nodefault};
	__property Gdipicture::TGDIPPicture* BackGround = {read=FIBackGround, write=SetBackGround};
	__property Gdipicture::TGDIPPicture* BackGroundDisabled = {read=FIBackGroundDisabled, write=SetBackGroundDisabled};
	__property bool BackGroundStretched = {read=FBackGroundStretched, write=SetBackGroundStretched, default=0};
	__property TMoveOnClick MoveOnClick = {read=FMoveOnClick, write=FMoveOnClick, default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property TTrackBarThumb* Thumb = {read=FThumb, write=SetThumb};
	__property TTrackBarSlider* Slider = {read=FSlider, write=SetSlider};
	__property bool ShowFocus = {read=FShowFocus, write=FShowFocus, default=0};
	__property bool TrackHint = {read=FTrackHint, write=FTrackHint, nodefault};
	__property TTrackBarTick* TickMark = {read=FTickMark, write=SetTickMark};
	__property Imglist::TCustomImageList* TickImages = {read=FImages, write=SetImages};
	__property Gdipicture::TGDIPPicture* RateActive = {read=FIRateActive, write=SetRateActive};
	__property Gdipicture::TGDIPPicture* RateInActive = {read=FIRateInActive, write=SetRateInActive};
	__property TTrackBarButtons* Buttons = {read=FButtons, write=SetButtons};
	__property TTrackBarLabel* TrackLabel = {read=FTrackLabel, write=SetTrackLabel};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TGetTrackHintEvent OnGetTrackHint = {read=FOnGetTrackHint, write=FOnGetTrackHint};
	__property TDrawTickEvent OnDrawTick = {read=FOnDrawTick, write=FOnDrawTick};
	__property TGetTrackLabelEvent OnGetTrackLabelText = {read=FOnGetTrackLabelText, write=FOnGetTrackLabelText};
	__property TGetTickMarkTextEvent OnGetTickMarkText = {read=FOnGetTickMarkText, write=FOnGetTickMarkText};
	
public:
	__fastcall virtual TCustomTrackBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomTrackBar(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
public:
	/* TWinControl.CreateParented */ inline __fastcall TCustomTrackBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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


class DELPHICLASS TAdvTrackBar;
class PASCALIMPLEMENTATION TAdvTrackBar : public TCustomTrackBar
{
	typedef TCustomTrackBar inherited;
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BackGroundStretched = {default=0};
	__property BackGround;
	__property BackGroundDisabled;
	__property BorderColor;
	__property BorderColorDisabled;
	__property Buttons;
	__property ColorTo;
	__property ColorDisabled;
	__property ColorDisabledTo;
	__property Ctl3D;
	__property Direction;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Constraints;
	__property Color = {default=-16777211};
	__property HelpContext = {default=0};
	__property Hint;
	__property Max = {default=10};
	__property Min = {default=0};
	__property MoveOnClick = {default=0};
	__property Orientation = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PageSize = {default=1};
	__property PopupMenu;
	__property Position = {default=0};
	__property RateActive;
	__property RateInActive;
	__property ShowHint;
	__property Slider;
	__property ShowFocus = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Thumb;
	__property TickMark;
	__property TickImages;
	__property TrackHint;
	__property TrackLabel;
	__property Transparent = {default=1};
	__property Version;
	__property Visible = {default=1};
	__property OnContextPopup;
	__property OnChange;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDrawTick;
	__property OnGetTrackHint;
	__property OnGetTrackLabelText;
	__property OnGetTickMarkText;
public:
	/* TCustomTrackBar.Create */ inline __fastcall virtual TAdvTrackBar(Classes::TComponent* AOwner) : TCustomTrackBar(AOwner) { }
	/* TCustomTrackBar.Destroy */ inline __fastcall virtual ~TAdvTrackBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvTrackBar(HWND ParentWindow) : TCustomTrackBar(ParentWindow) { }
	
};


class DELPHICLASS TRangeSliderSlider;
class PASCALIMPLEMENTATION TRangeSliderSlider : public TTrackBarSlider
{
	typedef TTrackBarSlider inherited;
	
private:
	Graphics::TColor FColorRemainingDisabledTo;
	Graphics::TColor FColorRemainingDisabled;
	Graphics::TColor FColorRemainingTo;
	Graphics::TColor FColorRemaining;
	Gdipicture::TGDIPPicture* FIPictureRemaining;
	Gdipicture::TGDIPPicture* FIPictureRemainingDisabled;
	void __fastcall SetColorRemaining(const Graphics::TColor Value);
	void __fastcall SetColorRemainingDisabled(const Graphics::TColor Value);
	void __fastcall SetColorRemainingDisabledTo(const Graphics::TColor Value);
	void __fastcall SetColorRemainingTo(const Graphics::TColor Value);
	void __fastcall SetPictureRemaining(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetPictureRemainingDisabled(const Gdipicture::TGDIPPicture* Value);
	
public:
	__fastcall TRangeSliderSlider(void);
	__fastcall virtual ~TRangeSliderSlider(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor ColorRemaining = {read=FColorRemaining, write=SetColorRemaining, nodefault};
	__property Graphics::TColor ColorRemainingTo = {read=FColorRemainingTo, write=SetColorRemainingTo, nodefault};
	__property Graphics::TColor ColorRemainingDisabled = {read=FColorRemainingDisabled, write=SetColorRemainingDisabled, nodefault};
	__property Graphics::TColor ColorRemainingDisabledTo = {read=FColorRemainingDisabledTo, write=SetColorRemainingDisabledTo, nodefault};
	__property Gdipicture::TGDIPPicture* PictureRemaining = {read=FIPictureRemaining, write=SetPictureRemaining};
	__property Gdipicture::TGDIPPicture* PictureRemainingDisabled = {read=FIPictureRemainingDisabled, write=SetPictureRemainingDisabled};
};


#pragma option push -b-
enum TActiveThumb { atLeft, atRight };
#pragma option pop

typedef void __fastcall (__closure *TGetSliderLabelEvent)(System::TObject* Sender, int PosLeft, int PosRight, System::UnicodeString &value);

class DELPHICLASS TAdvRangeSlider;
class PASCALIMPLEMENTATION TAdvRangeSlider : public TCustomTrackBar
{
	typedef TCustomTrackBar inherited;
	
private:
	bool FThumbOverlap;
	TActiveThumb FActiveThumb;
	int FPositionRight;
	TTrackBarThumb* FThumbRight;
	bool FThumbRightHot;
	bool FThumbRightDown;
	bool FSlidingRight;
	TThumbOverlap FOverlapThumb;
	TGetSliderLabelEvent FOnGetSliderLabel;
	void __fastcall OnThumbRightChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Messages::TWMMouseWheel &Message);
	int __fastcall GetPositionLeft(void);
	int __fastcall GetPositionRight(void);
	TTrackBarThumb* __fastcall GetThumbLeft(void);
	TTrackBarThumb* __fastcall GetThumbRight(void);
	void __fastcall SetPositionLeft(const int Value);
	void __fastcall SetPositionRight(int Value);
	void __fastcall SetThumbLeft(const TTrackBarThumb* Value);
	void __fastcall SetThumbRight(const TTrackBarThumb* Value);
	TRangeSliderSlider* __fastcall GetRangeSlider(void);
	void __fastcall SetRangeSlider(const TRangeSliderSlider* Value);
	
protected:
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Loaded(void);
	TThumbOverlap __fastcall GetThumbOverlap(void);
	virtual void __fastcall SetPosition(int Value);
	virtual bool __fastcall CanMoveOnTickClick(void);
	virtual System::UnicodeString __fastcall GetTrackLabelText(void);
	virtual bool __fastcall CanClipThumb(void);
	virtual TTrackBarSlider* __fastcall CreateTrackBarSlider(void);
	bool __fastcall CanClipRightThumb(void);
	virtual bool __fastcall CanMovePosition(int Value);
	bool __fastcall CanMovePositionRight(int Value);
	virtual void __fastcall DrawSlider(void);
	void __fastcall DrawThumbRight(void);
	virtual void __fastcall DrawThumb(void);
	virtual Types::TRect __fastcall ThumbRect(bool ConsiderOverlap = false);
	Types::TRect __fastcall ThumbRightRect(bool ConsiderOverlap = false);
	virtual int __fastcall GetPosiblePositionMin(void);
	virtual int __fastcall GetPosiblePositionMax(void);
	int __fastcall GetPosiblePositionRightMin(void);
	int __fastcall GetPosiblePositionRightMax(void);
	virtual void __fastcall InvalidateTrackLabel(void);
	virtual bool __fastcall IsGetTrackLabelAssigned(void);
	int __fastcall GetRightThumbPointerPos(void);
	virtual Types::TRect __fastcall TickMarkTopRect(void);
	virtual Types::TRect __fastcall TickMarkBottomRect(void);
	virtual int __fastcall GetThumbWidth(void);
	int __fastcall GetThumbRightWidth(void);
	virtual bool __fastcall CanChangeThumbPointer(TTrackBarThumb* aThumb, TThumbPointer &Value);
	
public:
	__fastcall virtual TAdvRangeSlider(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvRangeSlider(void);
	HIDESBASE void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BackGroundStretched = {default=0};
	__property BackGround;
	__property BackGroundDisabled;
	__property BorderColor;
	__property BorderColorDisabled;
	__property ColorTo;
	__property ColorDisabled;
	__property ColorDisabledTo;
	__property Ctl3D;
	__property Direction;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Constraints;
	__property Color = {default=-16777211};
	__property HelpContext = {default=0};
	__property Hint;
	__property Max = {default=10};
	__property Min = {default=0};
	__property Orientation = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentShowHint = {default=1};
	__property PageSize = {default=1};
	__property PopupMenu;
	__property int PositionLeft = {read=GetPositionLeft, write=SetPositionLeft, default=0};
	__property int PositionRight = {read=GetPositionRight, write=SetPositionRight, default=8};
	__property ShowHint;
	__property TRangeSliderSlider* Slider = {read=GetRangeSlider, write=SetRangeSlider};
	__property ShowFocus = {default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property TTrackBarThumb* ThumbLeft = {read=GetThumbLeft, write=SetThumbLeft};
	__property TTrackBarThumb* ThumbRight = {read=GetThumbRight, write=SetThumbRight};
	__property TickMark;
	__property TickImages;
	__property TrackHint;
	__property TrackLabel;
	__property Transparent = {default=1};
	__property Version;
	__property Visible = {default=1};
	__property OnContextPopup;
	__property OnChange;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnDrawTick;
	__property OnGetTrackHint;
	__property TGetSliderLabelEvent OnGetTrackLabel = {read=FOnGetSliderLabel, write=FOnGetSliderLabel};
	__property OnGetTickMarkText;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvRangeSlider(HWND ParentWindow) : TCustomTrackBar(ParentWindow) { }
	
};


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


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x6;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advtrackbar */
using namespace Advtrackbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvtrackbarHPP
