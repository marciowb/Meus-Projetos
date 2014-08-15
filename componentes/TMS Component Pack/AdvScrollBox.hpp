// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advscrollbox.pas' rev: 21.00

#ifndef AdvscrollboxHPP
#define AdvscrollboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Imglist.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advscrollbox
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


class DELPHICLASS TAdvScrollBox;
class PASCALIMPLEMENTATION TAdvScrollBox : public Forms::TScrollBox
{
	typedef Forms::TScrollBox inherited;
	
private:
	Graphics::TCanvas* FCanvas;
	Graphics::TColor FBorderColor;
	Classes::TNotifyEvent FOnVScroll;
	Classes::TNotifyEvent FOnHScroll;
	Classes::TNotifyEvent FOnHScrollEnd;
	Classes::TNotifyEvent FOnVScrollEnd;
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TWMEraseBkgnd &msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Messages::TMessage &Message);
	MESSAGE void __fastcall CMControlChange(Controls::TCMControlChange &Message);
	void __fastcall NCPaintProc(void);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetBorderColor(const Graphics::TColor Value);
	
protected:
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall PaintWindow(HDC DC);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall DrawBorder(void);
	__property Graphics::TCanvas* Canvas = {read=FCanvas};
	
public:
	__fastcall virtual TAdvScrollBox(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvScrollBox(void);
	int __fastcall GetVersionNr(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	
__published:
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion, stored=false};
	__property Graphics::TColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=12632256};
	__property Classes::TNotifyEvent OnVScroll = {read=FOnVScroll, write=FOnVScroll};
	__property Classes::TNotifyEvent OnHScroll = {read=FOnHScroll, write=FOnHScroll};
	__property Classes::TNotifyEvent OnVScrollEnd = {read=FOnVScrollEnd, write=FOnVScrollEnd};
	__property Classes::TNotifyEvent OnHScrollEnd = {read=FOnHScrollEnd, write=FOnHScrollEnd};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvScrollBox(HWND ParentWindow) : Forms::TScrollBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x1;

}	/* namespace Advscrollbox */
using namespace Advscrollbox;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvscrollboxHPP
