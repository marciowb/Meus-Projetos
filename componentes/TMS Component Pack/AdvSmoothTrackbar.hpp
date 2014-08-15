// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothtrackbar.pas' rev: 21.00

#ifndef AdvsmoothtrackbarHPP
#define AdvsmoothtrackbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothtrackbar
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
enum TAdvSmoothTrackBarDirection { dVertical, dHorizontal };
#pragma option pop

typedef void __fastcall (__closure *TAdvSmoothTrackBarValueChanged)(System::TObject* Sender, double Position);

typedef void __fastcall (__closure *TAdvSmoothTrackBarDrawNumber)(System::TObject* Sender, double value, System::UnicodeString &s, bool &AllowDrawText, bool &AllowDrawTickMark);

typedef void __fastcall (__closure *TAdvSmoothTrackBarGetToolTipText)(System::TObject* Sender, double Position, System::UnicodeString &ToolTipText);

class DELPHICLASS TAdvSmoothTrackBar;
class PASCALIMPLEMENTATION TAdvSmoothTrackBar : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	bool FPrevPosSet;
	double FPrevPos;
	bool FDoGlow;
	bool FFocused;
	int FGlowCount;
	double FGlowPos;
	Extctrls::TTimer* FAnimationTimer;
	bool FLoaded;
	bool FMouseDownOnSlider;
	int FSliderPos;
	bool FDesignTime;
	bool FResize;
	int FOldW;
	int FOldH;
	TAdvSmoothTrackBarDirection FDirection;
	Gdipfill::TGDIPFill* FFill;
	Gdipfill::TGDIPFill* FProgressFill;
	Graphics::TFont* FFont;
	Gdipfill::TGDIPFill* FThumbFill;
	double FMaximum;
	System::UnicodeString FFormat;
	double FMinimum;
	double FStep;
	int FThumbSize;
	double FPosition;
	int FTickMarkSize;
	bool FShowValues;
	bool FShowTickMarks;
	bool FSnapToTickMarks;
	double FSnapMargin;
	TAdvSmoothTrackBarValueChanged FOnPositionChanged;
	bool FGlowAnimation;
	bool FShowProgress;
	Graphics::TColor FTickMarkColor;
	Graphics::TFont* FProgressFont;
	unsigned FHToolTip;
	System::UnicodeString FToolTipText;
	TAdvSmoothTrackBarDrawNumber FOnDrawNumber;
	TAdvSmoothTrackBarValueChanged FOnPositionChanging;
	System::UnicodeString FPositionToolTipFormat;
	bool FPositionToolTip;
	TAdvSmoothTrackBarGetToolTipText FOnGetToolTipText;
	void __fastcall SetDirection(const TAdvSmoothTrackBarDirection Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetProgressFill(const Gdipfill::TGDIPFill* Value);
	HIDESBASE void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetThumbFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetFormat(const System::UnicodeString Value);
	void __fastcall SetMaximum(const double Value);
	void __fastcall SetMinimum(const double Value);
	void __fastcall SetStep(const double Value);
	void __fastcall setThumbSize(const int Value);
	void __fastcall SetPosition(const double Value);
	void __fastcall SetShowTickMarks(const bool Value);
	void __fastcall SetShowValues(const bool Value);
	void __fastcall SetTickMarkSize(const int Value);
	void __fastcall SetSnapToTickMarks(const bool Value);
	void __fastcall SetSnapMargin(const double Value);
	void __fastcall SetGlowAnimation(const bool Value);
	void __fastcall SetShowProgress(const bool Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetTickMarkColor(const Graphics::TColor Value);
	void __fastcall SetProgressFont(const Graphics::TFont* Value);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
protected:
	void __fastcall CreateToolTip(void);
	void __fastcall AddToolTip(int IconType, System::UnicodeString Text, System::UnicodeString Title);
	void __fastcall DestroyToolTip(void);
	void __fastcall UpdateToolTip(void);
	void __fastcall ClearToolTip(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall DrawBackGround(Advgdip::TGPGraphics* g);
	void __fastcall DrawOverlay(Advgdip::TGPGraphics* g);
	void __fastcall DrawProgress(Advgdip::TGPGraphics* g);
	void __fastcall DrawSlider(Advgdip::TGPGraphics* g);
	void __fastcall DrawNumbers(Advgdip::TGPGraphics* g);
	void __fastcall AnimateGlow(System::TObject* Sender);
	DYNAMIC void __fastcall DoExit(void);
	DYNAMIC void __fastcall DoEnter(void);
	bool __fastcall IsGlowAnimation(void);
	Types::TRect __fastcall InsideRect(void);
	Advgdip::TGPRectF __fastcall GetNumRect(void);
	Advgdip::TGPRectF __fastcall GetSliderRect(void);
	double __fastcall GetPosition(void)/* overload */;
	double __fastcall GetPosition(double XYPos)/* overload */;
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TAdvSmoothTrackBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothTrackBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall CreateWnd(void);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property TAdvSmoothTrackBarDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property Gdipfill::TGDIPFill* ProgressFill = {read=FProgressFill, write=SetProgressFill};
	__property Gdipfill::TGDIPFill* ThumbFill = {read=FThumbFill, write=SetThumbFill};
	__property int ThumbSize = {read=FThumbSize, write=setThumbSize, default=40};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TFont* ProgressFont = {read=FProgressFont, write=SetProgressFont};
	__property double Minimum = {read=FMinimum, write=SetMinimum};
	__property double Maximum = {read=FMaximum, write=SetMaximum};
	__property double Step = {read=FStep, write=SetStep};
	__property double Position = {read=FPosition, write=SetPosition};
	__property bool PositionToolTip = {read=FPositionToolTip, write=FPositionToolTip, default=0};
	__property System::UnicodeString PositionToolTipFormat = {read=FPositionToolTipFormat, write=FPositionToolTipFormat};
	__property System::UnicodeString ValueFormat = {read=FFormat, write=SetFormat};
	__property bool ShowValues = {read=FShowValues, write=SetShowValues, default=1};
	__property bool ShowTickMarks = {read=FShowTickMarks, write=SetShowTickMarks, default=1};
	__property int TickMarkSize = {read=FTickMarkSize, write=SetTickMarkSize, default=15};
	__property Graphics::TColor TickMarkColor = {read=FTickMarkColor, write=SetTickMarkColor, default=0};
	__property bool SnapToTickMarks = {read=FSnapToTickMarks, write=SetSnapToTickMarks, default=1};
	__property double SnapMargin = {read=FSnapMargin, write=SetSnapMargin};
	__property bool GlowAnimation = {read=FGlowAnimation, write=SetGlowAnimation, default=1};
	__property bool ShowProgress = {read=FShowProgress, write=SetShowProgress, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TAdvSmoothTrackBarValueChanged OnPositionChanged = {read=FOnPositionChanged, write=FOnPositionChanged};
	__property TAdvSmoothTrackBarValueChanged OnPositionChanging = {read=FOnPositionChanging, write=FOnPositionChanging};
	__property TAdvSmoothTrackBarDrawNumber OnDrawNumber = {read=FOnDrawNumber, write=FOnDrawNumber};
	__property TAdvSmoothTrackBarGetToolTipText OnGetToolTipText = {read=FOnGetToolTipText, write=FOnGetToolTipText};
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
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothTrackBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothtrackbar */
using namespace Advsmoothtrackbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothtrackbarHPP
