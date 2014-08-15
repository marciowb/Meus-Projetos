// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothlabel.pas' rev: 21.00

#ifndef AdvsmoothlabelHPP
#define AdvsmoothlabelHPP

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
#include <Activex.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothlabel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvSmoothLabelLocation { plTopLeft, plTopCenter, plTopRight, plCenterLeft, plCenterCenter, plCenterRight, plBottomLeft, plBottomCenter, plBottomRight, plCustom };
#pragma option pop

#pragma option push -b-
enum TAdvSmoothLabelBackGroundPosition { bpTopLeft, bpTopCenter, bpTopRight, bpBottomLeft, bpBottomCenter, bpBottomRight, bpTiled, bpStretched, bpCenterLeft, bpCenterCenter, bpCenterRight };
#pragma option pop

#pragma option push -b-
enum TTextRenderingHint { tAntiAlias, tClearType };
#pragma option pop

class DELPHICLASS TAdvSmoothLabel;
class DELPHICLASS TAdvSmoothLabelCaption;
class PASCALIMPLEMENTATION TAdvSmoothLabel : public Controls::TGraphicControl
{
	typedef Controls::TGraphicControl inherited;
	
private:
	TAdvSmoothLabelCaption* FCaption;
	bool FTransparent;
	Gdipfill::TGDIPFill* FFill;
	bool FWordWrap;
	Classes::TNotifyEvent FOnChange;
	TTextRenderingHint FTextRendering;
	TAdvSmoothLabelCaption* FCaptionShadow;
	bool FCaptionShadowVisible;
	int FCaptionShadowOffsetTop;
	int FCaptionShadowOffsetLeft;
	void __fastcall SetCaption(const TAdvSmoothLabelCaption* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetFill(const Gdipfill::TGDIPFill* Value);
	void __fastcall SetWordWrap(const bool Value);
	void __fastcall SetTextRendering(const TTextRenderingHint Value);
	void __fastcall SetCaptionShadow(const TAdvSmoothLabelCaption* Value);
	void __fastcall SetCaptionShadowOffsetLeft(const int Value);
	void __fastcall SetCaptionShadowOffsetTop(const int Value);
	void __fastcall SetCaptionShadowVisible(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall FillChanged(System::TObject* Sender);
	void __fastcall CaptionChanged(System::TObject* Sender);
	MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	void __fastcall GetPosition(double &x, double &y, const Advgdip::TGPRectF &rectangle, double objectwidth, double objectheight, TAdvSmoothLabelLocation location);
	void __fastcall InitPreview(void);
	int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TAdvSmoothLabel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothLabel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	virtual void __fastcall Paint(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	void __fastcall SaveToTheme(System::UnicodeString FileName);
	void __fastcall LoadFromTheme(System::UnicodeString FileName);
	System::UnicodeString __fastcall GetThemeID(void);
	void __fastcall DrawLabel(Graphics::TCanvas* ACanvas);
	void __fastcall DrawCaption(TAdvSmoothLabelCaption* c, Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, int OffsetX, int OffsetY);
	void __fastcall SaveToImage(System::UnicodeString Filename, int ImageWidth, int ImageHeight, Advgdip::TImageType ImageType = (Advgdip::TImageType)(0x1), int ImageQualityPercentage = 0x64);
	
__published:
	__property Gdipfill::TGDIPFill* Fill = {read=FFill, write=SetFill};
	__property TAdvSmoothLabelCaption* Caption = {read=FCaption, write=SetCaption};
	__property TAdvSmoothLabelCaption* CaptionShadow = {read=FCaptionShadow, write=SetCaptionShadow};
	__property bool CaptionShadowVisible = {read=FCaptionShadowVisible, write=SetCaptionShadowVisible, default=0};
	__property int CaptionShadowOffsetLeft = {read=FCaptionShadowOffsetLeft, write=SetCaptionShadowOffsetLeft, default=1};
	__property int CaptionShadowOffsetTop = {read=FCaptionShadowOffsetTop, write=SetCaptionShadowOffsetTop, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=0};
	__property TTextRenderingHint TextRendering = {read=FTextRendering, write=SetTextRendering, default=0};
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


class PASCALIMPLEMENTATION TAdvSmoothLabelCaption : public Classes::TPersistent
{
	typedef Classes::TPersistent inherited;
	
private:
	TAdvSmoothLabel* FOwner;
	Advgdip::TAdvGradientType FGradientType;
	TAdvSmoothLabelLocation FLocation;
	Advgdip::TAdvGDIPPicture* FPicture;
	Graphics::TColor FEndColor;
	Advgdip::HatchStyle FHatchStyle;
	Graphics::TFont* FFont;
	System::Byte FStartOpacity;
	System::UnicodeString FText;
	int FTop;
	int FLeft;
	System::Byte FEndOpacity;
	Graphics::TColor FStartColor;
	Classes::TNotifyEvent FOnChange;
	void __fastcall SetEndColor(const Graphics::TColor Value);
	void __fastcall SetEndOpacity(const System::Byte Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetGradientType(const Advgdip::TAdvGradientType Value);
	void __fastcall SetHatchStyle(const Advgdip::HatchStyle Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetLocation(const TAdvSmoothLabelLocation Value);
	void __fastcall SetPicture(const Advgdip::TAdvGDIPPicture* Value);
	void __fastcall SetStartColor(const Graphics::TColor Value);
	void __fastcall SetStartOpacity(const System::Byte Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetTop(const int Value);
	
protected:
	void __fastcall Changed(void);
	void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall PictureChanged(System::TObject* Sender);
	
public:
	__fastcall TAdvSmoothLabelCaption(TAdvSmoothLabel* AOwner);
	__fastcall virtual ~TAdvSmoothLabelCaption(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property TAdvSmoothLabelLocation Location = {read=FLocation, write=SetLocation, default=4};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property Advgdip::TAdvGDIPPicture* Picture = {read=FPicture, write=SetPicture};
	__property Graphics::TColor ColorStart = {read=FStartColor, write=SetStartColor, default=16769183};
	__property Graphics::TColor ColorEnd = {read=FEndColor, write=SetEndColor, default=7687936};
	__property System::Byte OpacityStart = {read=FStartOpacity, write=SetStartOpacity, default=255};
	__property System::Byte OpacityEnd = {read=FEndOpacity, write=SetEndOpacity, default=255};
	__property Advgdip::TAdvGradientType GradientType = {read=FGradientType, write=SetGradientType, default=2};
	__property Advgdip::HatchStyle HatchStyle = {read=FHatchStyle, write=SetHatchStyle, default=0};
	__property Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x5;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advsmoothlabel */
using namespace Advsmoothlabel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothlabelHPP
