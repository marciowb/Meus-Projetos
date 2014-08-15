// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcircularprogress.pas' rev: 21.00

#ifndef AdvcircularprogressHPP
#define AdvcircularprogressHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcircularprogress
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

class DELPHICLASS TProgressAppearance;
class PASCALIMPLEMENTATION TProgressAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FBackGroundColor;
	Graphics::TColor FActiveSegmentColor;
	Graphics::TColor FTransitionSegmentColor;
	Graphics::TColor FInActiveSegmentColor;
	Graphics::TColor FProgressSegmentColor;
	void __fastcall Changed(void);
	void __fastcall SetBackGroundColor(const Graphics::TColor Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetActiveSegmentColor(const Graphics::TColor Value);
	void __fastcall SetInActiveSegmentColor(const Graphics::TColor Value);
	void __fastcall SetProgressSegmentColor(const Graphics::TColor Value);
	void __fastcall SetTransitionSegmentColor(const Graphics::TColor Value);
	
protected:
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TProgressAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BackGroundColor = {read=FBackGroundColor, write=SetBackGroundColor, nodefault};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor ActiveSegmentColor = {read=FActiveSegmentColor, write=SetActiveSegmentColor, nodefault};
	__property Graphics::TColor InActiveSegmentColor = {read=FInActiveSegmentColor, write=SetInActiveSegmentColor, nodefault};
	__property Graphics::TColor TransitionSegmentColor = {read=FTransitionSegmentColor, write=SetTransitionSegmentColor, nodefault};
	__property Graphics::TColor ProgressSegmentColor = {read=FProgressSegmentColor, write=SetProgressSegmentColor, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TProgressAppearance(void) { }
	
};


class DELPHICLASS TAdvCircularProgress;
class PASCALIMPLEMENTATION TAdvCircularProgress : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	StaticArray<Advgdip::TGPGraphicsPath*, 12> FSegPath;
	Advgdip::TGPRegion* FInnerCircleRgn;
	Classes::TNotifyEvent FOnMouseLeave;
	Classes::TNotifyEvent FOnMouseEnter;
	TProgressAppearance* FAppearance;
	Extctrls::TTimer* FTimer;
	int FPosition;
	int FMin;
	int FMax;
	int FTransitionSegment;
	bool FActiveBehind;
	Classes::TNotifyEvent FOnProgressUpdate;
	bool FClipDraw;
	int FStep;
	MESSAGE void __fastcall WMSize(Messages::TWMSize &Message);
	MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	void __fastcall OnTimer(System::TObject* Sender);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetAppearance(const TProgressAppearance* Value);
	unsigned __fastcall GetInterval(void);
	void __fastcall SetInterval(const unsigned Value);
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetPosition(const int Value);
	
protected:
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	void __fastcall DrawSegments(void);
	void __fastcall DrawSegment(int Seg, Advgdip::TGPGraphics* graphics);
	void __fastcall IncreaseByOne(void);
	int __fastcall GetProgressSegment(void);
	Types::TRect __fastcall GetMyClientRect(void);
	Types::TRect __fastcall GetInnerCircleRect(void);
	void __fastcall CalculateSegmentSize(void);
	void __fastcall ClearSegmentSize(void);
	
public:
	__fastcall virtual TAdvCircularProgress(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCircularProgress(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	int __fastcall GetVersionNr(void);
	void __fastcall Stepit(void);
	void __fastcall StepBy(int delta);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property Enabled = {default=1};
	__property Font;
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property int Position = {read=FPosition, write=SetPosition, default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentBiDiMode = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property int Step = {read=FStep, write=FStep, default=10};
	__property Visible = {default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property TProgressAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property unsigned Interval = {read=GetInterval, write=SetInterval, nodefault};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Classes::TNotifyEvent OnProgressUpdate = {read=FOnProgressUpdate, write=FOnProgressUpdate};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt SEGMENT_COUNT = 0xc;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x1;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advcircularprogress */
using namespace Advcircularprogress;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcircularprogressHPP
