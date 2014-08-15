// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothjogwheel.pas' rev: 21.00

#ifndef AdvsmoothjogwheelHPP
#define AdvsmoothjogwheelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothjogwheel
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
enum TAdvSmoothJogWheelDirection { wdHorizontal, wdVertical };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothJogWheelModeType { wmContinuous, wmCue, wmAutoCue };
#pragma option pop

typedef Set<TAdvSmoothJogWheelModeType, wmContinuous, wmAutoCue>  TAdvSmoothJogWheelModes;

typedef void __fastcall (__closure *TAdvSmoothJogWheelValueChanged)(System::TObject* Sender, double Value, TAdvSmoothJogWheelModeType CurrentMode);

typedef void __fastcall (__closure *TAdvSmoothJogWheelModeChanged)(System::TObject* Sender, TAdvSmoothJogWheelModeType Mode);

#pragma option push -b-
enum TAdvSmoothJogWheelIndicatorShape { wsLine, wsCircle, wsTriangle, wsSquare, wsDiamond, wsNone };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothJogWheelIndicatorPosition { wpCenter, wpTop, wpBottom };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothJogWheelLocation { wlTopLeft, wlTopCenter, wlTopRight, wlCenterLeft, wlCenterCenter, wlCenterRight, wlBottomLeft, wlBottomCenter, wlBottomRight, wlCustom };
#pragma option pop

class DELPHICLASS TAdvSmoothJogWheelIndicator;
class DELPHICLASS TAdvSmoothJogWheel;
class PASCALIMPLEMENTATION TAdvSmoothJogWheelIndicator : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	TAdvSmoothJogWheel* FOwner;
	Advgdip::TAdvGDIPPicture* FPicture;
	int FWidth;
	TAdvSmoothJogWheelIndicatorShape FShape;
	Graphics::TColor FColor;
	bool FVisible;
	int FSize;
	TAdvSmoothJogWheelIndicatorPosition FPosition;
	int FImageIndex;
	int FPictureWidth;
	int FPictureHeight;
	double FValue;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetPosition(const TAdvSmoothJogWheelIndicatorPosition Value);
	void __fastcall SetShape(const TAdvSmoothJogWheelIndicatorShape Value);
	void __fastcall SetSize(const int Value);
	void __fastcall SetVisible(const bool Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetPictureHeight(const int Value);
	void __fastcall SetPictureWidth(const int Value);
	void __fastcall SetValue(const double Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothJogWheelIndicator(TAdvSmoothJogWheel* AOwner);
	__fastcall virtual ~TAdvSmoothJogWheelIndicator(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=255};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property int PictureHeight = {read=FPictureHeight, write=SetPictureHeight, default=15};
	__property int PictureWidth = {read=FPictureWidth, write=SetPictureWidth, default=15};
	__property TAdvSmoothJogWheelIndicatorShape Shape = {read=FShape, write=SetShape, default=0};
	__property int Size = {read=FSize, write=SetSize, default=15};
	__property int Width = {read=FWidth, write=SetWidth, default=2};
	__property TAdvSmoothJogWheelIndicatorPosition Position = {read=FPosition, write=SetPosition, default=0};
	__property double Value = {read=FValue, write=SetValue};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class DELPHICLASS TAdvSmoothJogWheelMode;
class PASCALIMPLEMENTATION TAdvSmoothJogWheelMode : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothJogWheel* FOwner;
	Graphics::TColor FColor;
	TAdvSmoothJogWheelIndicator* FIndicator;
	Classes::TNotifyEvent FOnChange;
	double FBrightness;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetIndicator(const TAdvSmoothJogWheelIndicator* Value);
	void __fastcall SetBrightness(const double Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall IndicatorChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothJogWheelMode(TAdvSmoothJogWheel* AOwner);
	__fastcall virtual ~TAdvSmoothJogWheelMode(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property double Brightness = {read=FBrightness, write=SetBrightness};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, default=0};
	__property TAdvSmoothJogWheelIndicator* Indicator = {read=FIndicator, write=SetIndicator};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


class PASCALIMPLEMENTATION TAdvSmoothJogWheel : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FLoaded;
	bool FFocused;
	int FModeCount;
	bool StartModeTimer;
	TAdvSmoothJogWheelModeType FCurrentMode;
	Extctrls::TTimer* FAnimationTimer;
	bool FAnimating;
	bool FAnimate;
	bool FMouseDown;
	bool FMouseUp;
	double FSp;
	int FTimeStop;
	int FCurrentScPos;
	int FScPosTo;
	int FTimeStart;
	int FDragXY;
	int FScrollXY;
	int FClickX;
	int FClickY;
	bool FResize;
	int FOldW;
	int FOldH;
	int FGripSpacing;
	int FGripSize;
	TAdvSmoothJogWheelDirection FDirection;
	double FValue;
	double FStep;
	TAdvSmoothJogWheelMode* FModeAutoCue;
	TAdvSmoothJogWheelMode* FModeContinuous;
	TAdvSmoothJogWheelMode* FModeCue;
	TAdvSmoothJogWheelModes FModes;
	TAdvSmoothJogWheelValueChanged FOnValueChanged;
	int FApperture;
	int FAnimationFactor;
	Imglist::TCustomImageList* FImages;
	double FModeChangeDelay;
	TAdvSmoothJogWheelModeChanged FOnModeChanged;
	Graphics::TColor FFocusColor;
	bool FEnabled;
	double FMaximumValue;
	double FMinimumValue;
	double FSingleClickStep;
	double FMouseWheelStep;
	Graphics::TFont* FValueFont;
	System::UnicodeString FValueFormat;
	bool FShowValue;
	int FValueTop;
	int FValueLeft;
	TAdvSmoothJogWheelLocation FValueLocation;
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	void __fastcall SetGripSpacing(const int Value);
	void __fastcall SetGripSize(const int Value);
	void __fastcall SetDirection(const TAdvSmoothJogWheelDirection Value);
	void __fastcall SetStep(const double Value);
	void __fastcall SetValue(const double Value);
	void __fastcall SetModeAutoCue(const TAdvSmoothJogWheelMode* Value);
	void __fastcall SetModeContinuous(const TAdvSmoothJogWheelMode* Value);
	void __fastcall SetModeCue(const TAdvSmoothJogWheelMode* Value);
	void __fastcall SetModes(const TAdvSmoothJogWheelModes Value);
	void __fastcall SetApperture(const int Value);
	void __fastcall SetCurrentMode(const TAdvSmoothJogWheelModeType Value);
	void __fastcall SetAnimationFactor(const int Value);
	void __fastcall SetModeChangeDelay(const double Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetFocusColor(const Graphics::TColor Value);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall SetMaximumValue(const double Value);
	void __fastcall SetMinimumValue(const double Value);
	void __fastcall SetSingleClickStep(const double Value);
	void __fastcall SetMouseWheelStep(const double Value);
	void __fastcall SetShowValue(const bool Value);
	void __fastcall SetValueFont(const Graphics::TFont* Value);
	void __fastcall SetValueFormat(const System::UnicodeString Value);
	void __fastcall SetValueLeft(const int Value);
	void __fastcall SetValueLocation(const TAdvSmoothJogWheelLocation Value);
	void __fastcall SetValueTop(const int Value);
	
protected:
	virtual void __fastcall SetEnabled(bool Value);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	HIDESBASE void __fastcall Changed(void);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall ModeChanged(System::TObject* Sender);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g);
	void __fastcall DrawGloss(Advgdip::TGPGraphics* g);
	void __fastcall DrawOverlay(Advgdip::TGPGraphics* g);
	void __fastcall DrawValue(Advgdip::TGPGraphics* g);
	void __fastcall DrawGrips(Advgdip::TGPGraphics* g);
	void __fastcall DrawIndicator(Advgdip::TGPGraphics* g);
	void __fastcall DrawGrip(Advgdip::TGPGraphics* g, double Position);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	void __fastcall Animate(System::TObject* Sender);
	bool __fastcall IsMode(void);
	Graphics::TColor __fastcall GetColor(int Delta);
	int __fastcall GetPosition(void);
	int __fastcall GetPositionTo(void);
	int __fastcall GetVersionNr(void);
	void __fastcall GetLabelPosition(double &x, double &y, const Advgdip::TGPRectF &rectangle, double objectwidth, double objectheight, TAdvSmoothJogWheelLocation location);
	
public:
	__fastcall virtual TAdvSmoothJogWheel(Classes::TComponent* AComponent);
	__fastcall virtual ~TAdvSmoothJogWheel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	DYNAMIC void __fastcall MouseWheelHandler(Messages::TMessage &Message);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall CreateWnd(void);
	
__published:
	__property int AnimationFactor = {read=FAnimationFactor, write=SetAnimationFactor, default=5};
	__property double ModeChangeDelay = {read=FModeChangeDelay, write=SetModeChangeDelay};
	__property bool ShowValue = {read=FShowValue, write=SetShowValue, default=0};
	__property Graphics::TFont* ValueFont = {read=FValueFont, write=SetValueFont};
	__property System::UnicodeString ValueFormat = {read=FValueFormat, write=SetValueFormat};
	__property TAdvSmoothJogWheelLocation ValueLocation = {read=FValueLocation, write=SetValueLocation, default=3};
	__property int ValueLeft = {read=FValueLeft, write=SetValueLeft, default=0};
	__property int ValueTop = {read=FValueTop, write=SetValueTop, default=0};
	__property int GripSpacing = {read=FGripSpacing, write=SetGripSpacing, default=20};
	__property int GripSize = {read=FGripSize, write=SetGripSize, default=15};
	__property double Step = {read=FStep, write=SetStep};
	__property double SingleClickStep = {read=FSingleClickStep, write=SetSingleClickStep};
	__property double MouseWheelStep = {read=FMouseWheelStep, write=SetMouseWheelStep};
	__property double Value = {read=FValue, write=SetValue};
	__property TAdvSmoothJogWheelDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property TAdvSmoothJogWheelMode* ModeContinuous = {read=FModeContinuous, write=SetModeContinuous};
	__property TAdvSmoothJogWheelMode* ModeCue = {read=FModeCue, write=SetModeCue};
	__property TAdvSmoothJogWheelMode* ModeAutoCue = {read=FModeAutoCue, write=SetModeAutoCue};
	__property TAdvSmoothJogWheelModes Modes = {read=FModes, write=SetModes, nodefault};
	__property double MaximumValue = {read=FMaximumValue, write=SetMaximumValue};
	__property double MinimumValue = {read=FMinimumValue, write=SetMinimumValue};
	__property int Apperture = {read=FApperture, write=SetApperture, default=80};
	__property TAdvSmoothJogWheelModeType Mode = {read=FCurrentMode, write=SetCurrentMode, default=0};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=FImages};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Graphics::TColor FocusColor = {read=FFocusColor, write=SetFocusColor, default=16777215};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property TAdvSmoothJogWheelValueChanged OnValueChanged = {read=FOnValueChanged, write=FOnValueChanged};
	__property TAdvSmoothJogWheelModeChanged OnModeChanged = {read=FOnModeChanged, write=FOnModeChanged};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property TabOrder = {default=-1};
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
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothJogWheel(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x5;

}	/* namespace Advsmoothjogwheel */
using namespace Advsmoothjogwheel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothjogwheelHPP
