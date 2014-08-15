// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advprogressbar.pas' rev: 21.00

#ifndef AdvprogressbarHPP
#define AdvprogressbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advprogressbar
{
//-- type declarations -------------------------------------------------------
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
	Graphics::TColor Level0BkColor;
	Graphics::TColor Level1BkColor;
	Graphics::TColor Level2BkColor;
	bool ShowBorder;
	bool Stacked;
	bool ShowPercentage;
	bool ShowPosition;
	Graphics::TFont* Font;
	bool CompletionSmooth;
	bool ShowGradient;
	int Steps;
	int Position;
	int Value;
	int Max;
	Graphics::TColor BackgroundColor;
	TGaugeOrientation Orientation;
	bool Rounded;
	Graphics::TColor ParentColor;
	System::UnicodeString Format;
	bool Infinite;
	int InfinitePos;
};


class DELPHICLASS TAdvProgressBar;
class PASCALIMPLEMENTATION TAdvProgressBar : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Graphics::TColor FLevel0Color;
	Graphics::TColor FLevel0ColorTo;
	Graphics::TColor FLevel1Color;
	Graphics::TColor FLevel1ColorTo;
	Graphics::TColor FLevel2Color;
	Graphics::TColor FLevel2ColorTo;
	Graphics::TColor FLevel3Color;
	Graphics::TColor FLevel3ColorTo;
	int FLevel1Perc;
	int FLevel2Perc;
	Graphics::TColor FBorderColor;
	bool FShowBorder;
	bool FStacked;
	bool FShowPercentage;
	Graphics::TFont* FFontPercentage;
	bool FCompletionSmooth;
	bool FShowGradient;
	int FSteps;
	int FPosition;
	Graphics::TColor FBackgroundColor;
	TGaugeOrientation FOrientation;
	bool FShowPosition;
	int FMin;
	int FMax;
	int FMaxIncrement;
	bool FRounded;
	System::UnicodeString FFormat;
	bool FAnimated;
	bool FInfinite;
	int FInfinitePos;
	bool FInfiniteInc;
	int FInfiniteInterval;
	int FOldBlockPos;
	int FOldPos;
	Extctrls::TTimer* FTimer;
	Graphics::TColor FLevel0BkColor;
	Graphics::TColor FLevel1BkColor;
	Graphics::TColor FLevel2BkColor;
	void __fastcall SetOrientation(TGaugeOrientation Value);
	void __fastcall SetBackgroundColor(Graphics::TColor Color);
	void __fastcall SetBorderColor(Graphics::TColor Color);
	void __fastcall SetCompletionSmooth(bool Value);
	HIDESBASE void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetLevel0Color(Graphics::TColor Color);
	void __fastcall SetLevel0ColorTo(Graphics::TColor Color);
	void __fastcall SetLevel1Color(Graphics::TColor Color);
	void __fastcall SetLevel1ColorTo(Graphics::TColor Color);
	void __fastcall SetLevel2Color(Graphics::TColor Color);
	void __fastcall SetLevel2ColorTo(Graphics::TColor Color);
	void __fastcall SetLevel3Color(Graphics::TColor Color);
	void __fastcall SetLevel3ColorTo(Graphics::TColor Color);
	void __fastcall SetLevel1Perc(int Percentage);
	void __fastcall SetLevel2Perc(int Percentage);
	void __fastcall SetPosition(int Value);
	void __fastcall SetShowBorder(bool Value);
	void __fastcall SetShowGradient(bool Value);
	void __fastcall SetShowPercentage(bool Value);
	void __fastcall SetStacked(bool Value);
	void __fastcall SetSteps(int Value);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall SetShowPosition(const bool Value);
	void __fastcall SetMax(const int Value);
	void __fastcall SetMin(const int Value);
	void __fastcall SetRounded(const bool Value);
	void __fastcall SetFormat(const System::UnicodeString Value);
	void __fastcall SetAnimated(const bool Value);
	void __fastcall SetInfinite(const bool Value);
	void __fastcall SetInfiniteInterval(const int Value);
	void __fastcall SetLevel0BkColor(const Graphics::TColor Value);
	void __fastcall SetLevel1BkColor(const Graphics::TColor Value);
	void __fastcall SetLevel2BkColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Paint(void);
	void __fastcall TimerProc(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvProgressBar(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvProgressBar(void);
	
__published:
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property bool Animated = {read=FAnimated, write=SetAnimated, default=0};
	__property Constraints;
	__property Graphics::TColor BackgroundColor = {read=FBackgroundColor, write=SetBackgroundColor, default=16777215};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=8421504};
	__property bool CompletionSmooth = {read=FCompletionSmooth, write=SetCompletionSmooth, default=0};
	__property Graphics::TFont* Font = {read=FFontPercentage, write=SetFont};
	__property System::UnicodeString Format = {read=FFormat, write=SetFormat};
	__property bool Infinite = {read=FInfinite, write=SetInfinite, default=0};
	__property int InfiniteInterval = {read=FInfiniteInterval, write=SetInfiniteInterval, default=50};
	__property Graphics::TColor Level0Color = {read=FLevel0Color, write=SetLevel0Color, default=65280};
	__property Graphics::TColor Level0ColorTo = {read=FLevel0ColorTo, write=SetLevel0ColorTo, nodefault};
	__property Graphics::TColor Level1Color = {read=FLevel1Color, write=SetLevel1Color, default=65535};
	__property Graphics::TColor Level1ColorTo = {read=FLevel1ColorTo, write=SetLevel1ColorTo, nodefault};
	__property Graphics::TColor Level2Color = {read=FLevel2Color, write=SetLevel2Color, nodefault};
	__property Graphics::TColor Level2ColorTo = {read=FLevel2ColorTo, write=SetLevel2ColorTo, nodefault};
	__property Graphics::TColor Level3Color = {read=FLevel3Color, write=SetLevel3Color, default=255};
	__property Graphics::TColor Level3ColorTo = {read=FLevel3ColorTo, write=SetLevel3ColorTo, nodefault};
	__property int Level1Perc = {read=FLevel1Perc, write=SetLevel1Perc, nodefault};
	__property int Level2Perc = {read=FLevel2Perc, write=SetLevel2Perc, nodefault};
	__property Graphics::TColor Level0BkColor = {read=FLevel0BkColor, write=SetLevel0BkColor, default=536870911};
	__property Graphics::TColor Level1BkColor = {read=FLevel1BkColor, write=SetLevel1BkColor, default=536870911};
	__property Graphics::TColor Level2BkColor = {read=FLevel2BkColor, write=SetLevel2BkColor, default=536870911};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Max = {read=FMax, write=SetMax, default=100};
	__property TGaugeOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property int Position = {read=FPosition, write=SetPosition, nodefault};
	__property bool Rounded = {read=FRounded, write=SetRounded, default=1};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, nodefault};
	__property bool ShowGradient = {read=FShowGradient, write=SetShowGradient, default=1};
	__property bool ShowPercentage = {read=FShowPercentage, write=SetShowPercentage, default=1};
	__property bool ShowPosition = {read=FShowPosition, write=SetShowPosition, default=1};
	__property bool Stacked = {read=FStacked, write=SetStacked, default=0};
	__property int Steps = {read=FSteps, write=SetSteps, default=8};
	__property ShowHint;
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property Visible = {default=1};
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advprogressbar */
using namespace Advprogressbar;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvprogressbarHPP
