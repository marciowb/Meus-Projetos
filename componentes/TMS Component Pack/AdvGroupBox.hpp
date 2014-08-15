// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advgroupbox.pas' rev: 21.00

#ifndef AdvgroupboxHPP
#define AdvgroupboxHPP

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
#include <Stdctrls.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Menus.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advgroupbox
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TCaptionPosition { cpTopLeft, cpTopRight, cpTopCenter, cpBottomLeft, cpBottomRight, cpBottomCenter };
#pragma option pop

#pragma option push -b-
enum TBorderStyle { bsNone, bsSingle, bsDouble };
#pragma option pop

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


class DELPHICLASS TAdvCustomGroupBox;
class PASCALIMPLEMENTATION TAdvCustomGroupBox : public Stdctrls::TCustomGroupBox
{
	typedef Stdctrls::TCustomGroupBox inherited;
	
private:
	bool FTransparent;
	Graphics::TColor FBorderColor;
	int FImageIndex;
	Imglist::TCustomImageList* FImages;
	TBorderStyle FBorderStyle;
	TCaptionPosition FCaptionPosition;
	bool FRoundEdges;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &msg);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Messages::TMessage &Message);
	void __fastcall SetTransparent(const bool Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetImages(const Imglist::TCustomImageList* Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetBorderStyle(const TBorderStyle Value);
	void __fastcall SetCaptionPosition(const TCaptionPosition Value);
	void __fastcall SetRoundEdges(const bool Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall PaintTransparency(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	virtual void __fastcall AdjustClientRect(Types::TRect &Rect);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	int __fastcall GetCaptionHeight(void);
	Types::TRect __fastcall GetCaptionRect(void);
	int __fastcall GetBorderWidth(void);
	Types::TRect __fastcall GetBorderRect(void);
	__property TCaptionPosition CaptionPosition = {read=FCaptionPosition, write=SetCaptionPosition, default=0};
	__property TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12632256};
	__property Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property bool RoundEdges = {read=FRoundEdges, write=SetRoundEdges, default=0};
	
public:
	__fastcall virtual TAdvCustomGroupBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvCustomGroupBox(void);
	int __fastcall GetVersionNr(void);
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvCustomGroupBox(HWND ParentWindow) : Stdctrls::TCustomGroupBox(ParentWindow) { }
	
};


class DELPHICLASS TAdvGroupBox;
class PASCALIMPLEMENTATION TAdvGroupBox : public TAdvCustomGroupBox
{
	typedef TAdvCustomGroupBox inherited;
	
__published:
	__property BorderColor = {default=12632256};
	__property BorderStyle = {default=1};
	__property CaptionPosition = {default=0};
	__property Images;
	__property ImageIndex = {default=-1};
	__property Transparent = {default=1};
	__property RoundEdges = {default=0};
	__property Version;
	__property Align = {default=0};
	__property Anchors = {default=3};
	__property BiDiMode;
	__property Caption;
	__property Color = {default=-16777211};
	__property Constraints;
	__property Ctl3D = {default=0};
	__property DockSite = {default=0};
	__property DragCursor = {default=-12};
	__property DragKind = {default=0};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentBackground = {default=1};
	__property ParentBiDiMode = {default=1};
	__property ParentColor = {default=1};
	__property ParentCtl3D = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnDragOver;
	__property OnEndDock;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnGetSiteInfo;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnStartDrag;
	__property OnUnDock;
public:
	/* TAdvCustomGroupBox.Create */ inline __fastcall virtual TAdvGroupBox(Classes::TComponent* AOwner) : TAdvCustomGroupBox(AOwner) { }
	/* TAdvCustomGroupBox.Destroy */ inline __fastcall virtual ~TAdvGroupBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvGroupBox(HWND ParentWindow) : TAdvCustomGroupBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x0;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x2;

}	/* namespace Advgroupbox */
using namespace Advgroupbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvgroupboxHPP
