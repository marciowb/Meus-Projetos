// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothledlabel.pas' rev: 21.00

#ifndef AdvsmoothledlabelHPP
#define AdvsmoothledlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothledlabel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvSmoothLedLabelBackGroundPosition { bpTopLeft, bpTopCenter, bpTopRight, bpBottomLeft, bpBottomCenter, bpBottomRight, bpTiled, bpStretched, bpCenterLeft, bpCenterCenter, bpCenterRight };
#pragma option pop

class DELPHICLASS TAdvSmoothLedLabel;
class DELPHICLASS TAdvSmoothLedLabelCaption;
class PASCALIMPLEMENTATION TAdvSmoothLedLabel : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	int FCount;
	bool FPainting;
	bool FDesignTime;
	TAdvSmoothLedLabelCaption* FCaption;
	bool FTransparent;
	Gdipfill::TGDIPFill* FFill;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetCaption(const TAdvSmoothLedLabelCaption* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall CaptionChanged(System::TObject* Sender);
	MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TAdvSmoothLedLabel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothLedLabel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	int __fastcall Getcount(void);
	bool __fastcall IsPainting(void);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	void __fastcall DrawLedLabel(Graphics::TCanvas* ACanvas);
	void __fastcall SaveToImage(System::UnicodeString Filename, int ImageWidth, int ImageHeight, Advgdip::TImageType ImageType = (Advgdip::TImageType)(0x1), int ImageQualityPercentage = 0x64);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property TAdvSmoothLedLabelCaption* Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Visible = {default=1};
	__property ShowHint;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseDown;
	__property OnResize;
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnMouseActivate;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property OnStartDock;
	__property OnStartDrag;
	__property PopupMenu;
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
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


#pragma option push -b-
enum TAdvSmoothLedLabelValueType { vtNormal, vtDateTime };
#pragma option pop

class PASCALIMPLEMENTATION TAdvSmoothLedLabelCaption : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothLedLabel* FOwner;
	Advgdip::TAdvGradientType FGradientType;
	Advgdip::TAdvGDIPPicture* FPicture;
	Graphics::TColor FEndColor;
	Advgdip::HatchStyle FHatchStyle;
	System::Byte FStartOpacity;
	double FValue;
	int FTop;
	int FLeft;
	System::Byte FEndOpacity;
	Graphics::TColor FStartColor;
	Classes::TNotifyEvent FOnChange;
	Graphics::TColor FColorOff;
	System::Byte FColorOffOpacity;
	int FAngle;
	System::UnicodeString FFormat;
	System::UnicodeString FTimeFormat;
	System::TDateTime FTimeValue;
	TAdvSmoothLedLabelValueType FValueType;
	void __fastcall SetEndColor(const Graphics::TColor Value);
	void __fastcall SetEndOpacity(const System::Byte Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetHatchStyle(const Advgdip::HatchStyle Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetStartColor(const Graphics::TColor Value);
	void __fastcall SetStartOpacity(const System::Byte Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetValue(const double Value);
	void __fastcall SetColorOff(const Graphics::TColor Value);
	void __fastcall SetColorOffOpacity(const System::Byte Value);
	void __fastcall SetAngle(const int Value);
	void __fastcall SetFormat(const System::UnicodeString Value);
	void __fastcall SetTimeFormat(const System::UnicodeString Value);
	void __fastcall SetTimeValue(const System::TDateTime Value);
	void __fastcall SetValueType(const TAdvSmoothLedLabelValueType Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall PictureChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothLedLabelCaption(TAdvSmoothLedLabel* AOwner);
	__fastcall virtual ~TAdvSmoothLedLabelCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property double Value = {read=FValue, write=SetValue};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property Graphics::TColor ColorStart = {read=FStartColor, write=SetStartColor, default=4227327};
	__property Graphics::TColor ColorEnd = {read=FEndColor, write=SetEndColor, default=255};
	__property Graphics::TColor ColorOff = {read=FColorOff, write=SetColorOff, default=8421504};
	__property System::Byte ColorOffOpacity = {read=FColorOffOpacity, write=SetColorOffOpacity, default=255};
	__property System::Byte OpacityStart = {read=FStartOpacity, write=SetStartOpacity, default=255};
	__property System::Byte OpacityEnd = {read=FEndOpacity, write=SetEndOpacity, default=255};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=2};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=SetHatchStyle, default=0};
	__property int Angle = {read=FAngle, write=SetAngle, default=0};
	__property System::UnicodeString Format = {read=FFormat, write=SetFormat};
	__property System::UnicodeString TimeFormat = {read=FTimeFormat, write=SetTimeFormat};
	__property TAdvSmoothLedLabelValueType ValueType = {read=FValueType, write=SetValueType, default=0};
	__property System::TDateTime TimeValue = {read=FTimeValue, write=SetTimeValue};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x2;

}	/* namespace Advsmoothledlabel */
using namespace Advsmoothledlabel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothledlabelHPP
