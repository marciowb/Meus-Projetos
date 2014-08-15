// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothprogressbar.pas' rev: 21.00

#ifndef AdvsmoothprogressbarHPP
#define AdvsmoothprogressbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothprogressbar
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


typedef void __fastcall (__closure *TAdvSmoothProgressBarPositionChanged)(System::TObject* Sender, double Value);

#pragma option push -b-
enum TProgressBarStyle { pbstNormal, pbstMarquee };
#pragma option pop

class DELPHICLASS TAdvSmoothProgressBar;
class PASCALIMPLEMENTATION TAdvSmoothProgressBar : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
private:
	double FPositionTo;
	double FPositionTemp;
	Types::TRect FRect;
	bool FDesignTime;
	bool FDoAnimation;
	bool FAnimate;
	int FGlowCount;
	double FGlowPos;
	Extctrls::TTimer* FAnimationTimer;
	Extctrls::TTimer* FMarqueeTimer;
	double FMaximum;
	Gdipfill::TGDIPProgress* FAppearance;
	bool FGlowAnimation;
	Classes::TNotifyEvent FOnChange;
	double FMinimum;
	bool FProgressAnimation;
	double FStep;
	double FPosition;
	TAdvSmoothProgressBarPositionChanged FOnPositionChanged;
	int FMarqueeInterval;
	TProgressBarStyle FStyle;
	Graphics::TColor FMarqueeColor;
	int FMarqueeSize;
	void __fastcall SetAppearance(const Gdipfill::TGDIPProgress* Value);
	void __fastcall SetGlowAnimation(const bool Value);
	void __fastcall SetMaximum(const double Value);
	void __fastcall SetMinimum(const double Value);
	void __fastcall SetProgressAnimation(const bool Value);
	void __fastcall SetStep(const double Value);
	void __fastcall SetPosition(const double Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	double __fastcall GetPosition(void);
	double __fastcall GetNextPosition(void);
	void __fastcall SetMarqueeInterval(const int Value);
	void __fastcall SetPBStyle(const TProgressBarStyle Value);
	void __fastcall SetMarqueeColor(const Graphics::TColor Value);
	void __fastcall SetMarqueeSize(const int Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall AppearanceChanged(System::TObject* Sender);
	void __fastcall AnimateProgress(System::TObject* Sender);
	void __fastcall MarqueeProgress(System::TObject* Sender);
	void __fastcall DrawGlow(Advgdip::TGPGraphics* g, const Types::TRect &r);
	void __fastcall SetStyle(Advstyleif::TTMSStyle AStyle, bool Selected);
	bool __fastcall IsProgressAnimation(void);
	bool __fastcall IsGlowAnimation(void);
	int __fastcall GetVersionNr(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	
public:
	__fastcall virtual TAdvSmoothProgressBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothProgressBar(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall Next(void)/* overload */;
	void __fastcall Previous(void)/* overload */;
	void __fastcall Next(double AStep)/* overload */;
	void __fastcall Previous(double AStep)/* overload */;
	void __fastcall GoToValue(double AValue);
	void __fastcall GoToEnd(void);
	void __fastcall GoToStart(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	bool __fastcall AnimationInProgress(void);
	__property double NextPosition = {read=GetNextPosition};
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	
__published:
	__property double Step = {read=FStep, write=SetStep};
	__property double Minimum = {read=FMinimum, write=SetMinimum};
	__property double Maximum = {read=FMaximum, write=SetMaximum};
	__property double Position = {read=GetPosition, write=SetPosition};
	__property bool GlowAnimation = {read=FGlowAnimation, write=SetGlowAnimation, default=1};
	__property bool ProgressAnimation = {read=FProgressAnimation, write=SetProgressAnimation, default=1};
	__property Gdipfill::TGDIPProgress* Appearance = {read=FAppearance, write=SetAppearance};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TProgressBarStyle Style = {read=FStyle, write=SetPBStyle, default=0};
	__property int MarqueeInterval = {read=FMarqueeInterval, write=SetMarqueeInterval, default=10};
	__property Graphics::TColor MarqueeColor = {read=FMarqueeColor, write=SetMarqueeColor, default=65280};
	__property int MarqueeSize = {read=FMarqueeSize, write=SetMarqueeSize, default=60};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TAdvSmoothProgressBarPositionChanged OnPositionChanged = {read=FOnPositionChanged, write=FOnPositionChanged};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property PopupMenu;
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnResize;
	__property OnDblClick;
	__property OnClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnStartDrag;
	__property OnEndDrag;
	__property Visible = {default=1};
	__property Hint;
	__property TabStop = {default=1};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothProgressBar(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
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
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothprogressbar */
using namespace Advsmoothprogressbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothprogressbarHPP
