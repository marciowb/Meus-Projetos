// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advsmoothexpanderpanel.pas' rev: 21.00

#ifndef AdvsmoothexpanderpanelHPP
#define AdvsmoothexpanderpanelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Extctrls.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Comobj.hpp>	// Pascal unit
#include <Activex.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Gdippicturecontainer.hpp>	// Pascal unit
#include <Gdipfill.hpp>	// Pascal unit
#include <Advsmoothpanel.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advsmoothexpanderpanel
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvSmoothExpanderPanelShape { esRounded, esRoundRect, esRect };
#pragma option pop

class DELPHICLASS TAdvSmoothExpanderPanel;
class PASCALIMPLEMENTATION TAdvSmoothExpanderPanel : public Advsmoothpanel::TAdvSmoothPanel
{
	typedef Advsmoothpanel::TAdvSmoothPanel inherited;
	
private:
	bool DisableLine;
	bool FEnableResize;
	bool FDoAnimate;
	double FOldHeight;
	double FExpHeight;
	double FExpHeightTo;
	Extctrls::TTimer* FExpTimer;
	bool FDesignTime;
	bool FHover;
	bool FOldHover;
	bool FDown;
	Graphics::TColor FExpanderColor;
	bool FExpanded;
	TAdvSmoothExpanderPanelShape FExpanderShape;
	Graphics::TColor FExpanderHoverColor;
	Graphics::TColor FExpanderDownColor;
	int FExpanderSize;
	Graphics::TColor FExpanderBorderColor;
	Advsmoothpanel::TAdvSmoothPanelLocation FExpanderLocation;
	int FExpanderTop;
	int FExpanderLeft;
	int FAnimationFactor;
	int FMinimumPanelHeight;
	bool FShowExpander;
	Classes::TNotifyEvent FOnExpandPanel;
	void __fastcall SetExpanderColor(const Graphics::TColor Value);
	void __fastcall SetExpanderDownColor(const Graphics::TColor Value);
	void __fastcall SetExpanderHoverColor(const Graphics::TColor Value);
	void __fastcall SetExpanderShape(const TAdvSmoothExpanderPanelShape Value);
	void __fastcall SetExpanderSize(const int Value);
	void __fastcall SetExpanderBorderColor(const Graphics::TColor Value);
	void __fastcall SetExpanderLocation(const Advsmoothpanel::TAdvSmoothPanelLocation Value);
	void __fastcall SetExpanderLeft(const int Value);
	void __fastcall SetExpanderTop(const int Value);
	void __fastcall SetExpanded(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Messages::TWMWindowPosMsg &Message);
	MESSAGE void __fastcall WMGetDlgCode(Messages::TWMNoParams &Message);
	void __fastcall SetAnimationFactor(const int Value);
	void __fastcall SetMinimumPanelHeight(const int Value);
	void __fastcall SetShowExpander(const bool Value);
	
protected:
	HIDESBASE void __fastcall Changed(void);
	void __fastcall DrawExpander(Advgdip::TGPGraphics* g, const Advgdip::TGPRectF &r, bool Down, bool Hover);
	Types::TRect __fastcall InsideRect(void);
	Advgdip::TGPRectF __fastcall GetExpanderRect(void);
	virtual int __fastcall GetVersionNr(void);
	HIDESBASE void __fastcall GetPosition(double &x, double &y, const Advgdip::TGPRectF &rectangle, double objectwidth, double objectheight, Advsmoothpanel::TAdvSmoothPanelLocation location);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, Classes::TShiftState Shift);
	void __fastcall AnimateExpand(System::TObject* Sender);
	virtual void __fastcall GDIPPaint(Advgdip::TGPGraphics* g);
	bool __fastcall IsResizeEnabled(void);
	void __fastcall SetResizeEnabled(bool Resize);
	bool __fastcall PtInGPRect(const Advgdip::TGPRectF &r, const Types::TPoint &pt);
	virtual void __fastcall DefineProperties(Classes::TFiler* Filer);
	void __fastcall ReadCustomProperty(Classes::TReader* Reader);
	void __fastcall WriteCustomProperty(Classes::TWriter* Writer);
	
public:
	__fastcall virtual TAdvSmoothExpanderPanel(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvSmoothExpanderPanel(void);
	virtual void __fastcall Assign(Classes::TPersistent* Source);
	HIDESBASE void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	DYNAMIC void __fastcall Resize(void);
	virtual void __fastcall Loaded(void);
	void __fastcall Collapse(void);
	void __fastcall Expand(void);
	__property double ExpandedHeight = {read=FOldHeight, write=FOldHeight};
	
__published:
	__property int AnimationFactor = {read=FAnimationFactor, write=SetAnimationFactor, default=4};
	__property bool ShowExpander = {read=FShowExpander, write=SetShowExpander, default=1};
	__property Graphics::TColor ExpanderBorderColor = {read=FExpanderBorderColor, write=SetExpanderBorderColor, default=0};
	__property Advsmoothpanel::TAdvSmoothPanelLocation ExpanderLocation = {read=FExpanderLocation, write=SetExpanderLocation, default=2};
	__property int ExpanderLeft = {read=FExpanderLeft, write=SetExpanderLeft, default=0};
	__property int ExpanderTop = {read=FExpanderTop, write=SetExpanderTop, default=0};
	__property int ExpanderSize = {read=FExpanderSize, write=SetExpanderSize, default=16};
	__property bool Expanded = {read=FExpanded, write=SetExpanded, default=1};
	__property Graphics::TColor ExpanderColor = {read=FExpanderColor, write=SetExpanderColor, default=16777215};
	__property Graphics::TColor ExpanderDownColor = {read=FExpanderDownColor, write=SetExpanderDownColor, default=16777215};
	__property Graphics::TColor ExpanderHoverColor = {read=FExpanderHoverColor, write=SetExpanderHoverColor, default=16777215};
	__property TAdvSmoothExpanderPanelShape ExpanderShape = {read=FExpanderShape, write=SetExpanderShape, default=1};
	__property int MinimumPanelHeight = {read=FMinimumPanelHeight, write=SetMinimumPanelHeight, default=32};
	__property Classes::TNotifyEvent OnExpandPanel = {read=FOnExpandPanel, write=FOnExpandPanel};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvSmoothExpanderPanel(HWND ParentWindow) : Advsmoothpanel::TAdvSmoothPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x2;
static const ShortInt BLD_VER = 0x8;

}	/* namespace Advsmoothexpanderpanel */
using namespace Advsmoothexpanderpanel;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvsmoothexpanderpanelHPP
