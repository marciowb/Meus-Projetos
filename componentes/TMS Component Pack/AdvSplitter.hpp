// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsplitter.pas' rev: 21.00

#ifndef AdvsplitterHPP
#define AdvsplitterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsplitter
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TGradientDirection { gdHorizontal, gdVertical };
#pragma option pop

#pragma option push -b-
enum TDirectionType { dtFixed, dtAuto, dtAutoInvers };
#pragma option pop

#pragma option push -b-
enum TSplitterGripStyle { sgDots, sgSingleLine, sgDoubleLine, sgFlatDots, sgNone };
#pragma option pop

class DELPHICLASS TSplitterAppearance;
class PASCALIMPLEMENTATION TSplitterAppearance : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	int FSteps;
	Graphics::TColor FColor;
	Graphics::TColor FColorTo;
	TGradientDirection FDirection;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FBorderColor;
	Graphics::TColor FColorHotTo;
	Graphics::TColor FColorHot;
	Graphics::TColor FBorderColorHot;
	TDirectionType FDirectionType;
	void __fastcall SetColor(const Graphics::TColor Value);
	void __fastcall SetColorTo(const Graphics::TColor Value);
	void __fastcall SetDirection(const TGradientDirection Value);
	void __fastcall SetSteps(const int Value);
	void __fastcall Changed(void);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetBorderColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHot(const Graphics::TColor Value);
	void __fastcall SetColorHotTo(const Graphics::TColor Value);
	void __fastcall SetDirectionType(const TDirectionType Value);
	
protected:
	__property int Steps = {read=FSteps, write=SetSteps, default=64};
	
public:
	__fastcall TSplitterAppearance(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, nodefault};
	__property Graphics::TColor BorderColorHot = {read=FBorderColorHot, write=SetBorderColorHot, nodefault};
	__property Graphics::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Graphics::TColor ColorTo = {read=FColorTo, write=SetColorTo, nodefault};
	__property Graphics::TColor ColorHot = {read=FColorHot, write=SetColorHot, nodefault};
	__property Graphics::TColor ColorHotTo = {read=FColorHotTo, write=SetColorHotTo, nodefault};
	__property TGradientDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property TDirectionType DirectionType = {read=FDirectionType, write=SetDirectionType, default=1};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSplitterAppearance(void) { }
	
};


class DELPHICLASS TAdvCustomSplitter;
class PASCALIMPLEMENTATION TAdvCustomSplitter : public Extctrls::TSplitter
{
	typedef Extctrls::TSplitter inherited;
	
private:
	TSplitterAppearance* FAppearance;
	Graphics::TBitmap* FGlyph;
	bool FMouseInControl;
	TSplitterGripStyle FGripStyle;
	int FDefaultSize;
	MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	void __fastcall OnAppearanceChanged(System::TObject* Sender);
	void __fastcall OnGlyphChanged(System::TObject* Sender);
	void __fastcall AdjustNeighbourControl(void);
	void __fastcall SetAppearance(const TSplitterAppearance* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetGripStyle(const TSplitterGripStyle Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall DblClick(void);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	__property TSplitterAppearance* Appearance = {read=FAppearance, write=SetAppearance};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property TSplitterGripStyle GripStyle = {read=FGripStyle, write=SetGripStyle, nodefault};
	
public:
	__fastcall virtual TAdvCustomSplitter(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomSplitter(void);
	HIDESBASE Controls::TControl* __fastcall FindControl(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	int __fastcall GetVersionNr(void);
	__property int DefaultSize = {read=FDefaultSize, write=FDefaultSize, default=0};
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


class DELPHICLASS TAdvSplitter;
class PASCALIMPLEMENTATION TAdvSplitter : public TAdvCustomSplitter
{
	typedef TAdvCustomSplitter inherited;
	
__published:
	__property Appearance;
	__property DefaultSize = {default=0};
	__property Glyph;
	__property GripStyle;
	__property ShowHint;
	__property Version;
	__property OnClick;
	__property OnDblClick;
public:
	/* TAdvCustomSplitter.Create */ inline __fastcall virtual TAdvSplitter(Classes::TComponent* AOwner) : TAdvCustomSplitter(AOwner) { }
	/* TAdvCustomSplitter.Destroy */ inline __fastcall virtual ~TAdvSplitter(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x3;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsplitter */
using namespace Advsplitter;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsplitterHPP
