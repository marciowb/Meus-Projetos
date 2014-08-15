// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advfocushelper.pas' rev: 21.00

#ifndef AdvfocushelperHPP
#define AdvfocushelperHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advfocushelper
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFocusWindow;
class PASCALIMPLEMENTATION TFocusWindow : public Controls::TCustomControl
{
	typedef Controls::TCustomControl inherited;
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TFocusWindow(Classes::TComponent* AOwner);
	virtual void __fastcall CreateWnd(void);
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TFocusWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFocusWindow(HWND ParentWindow) : Controls::TCustomControl(ParentWindow) { }
	
};


#pragma option push -b-
enum TIncludeControl { icEdit, icMemo, icListBox, icComboBox, icDateTimePicker, icTagValue };
#pragma option pop

#pragma option push -b-
enum TExcludeControl { ecButton, ecCheckBox, ecRadioButton, ecTagValue };
#pragma option pop

typedef Set<TIncludeControl, icEdit, icTagValue>  TIncludeControls;

typedef Set<TExcludeControl, ecButton, ecTagValue>  TExcludeControls;

#pragma option push -b-
enum TGlyphPosition { gpAfterControl, gpBeforeControl };
#pragma option pop

typedef void __fastcall (__closure *TOnShowFocusEvent)(System::TObject* Sender, Controls::TWinControl* Control, bool &ShowFocus);

class DELPHICLASS TAdvFocusHelper;
class PASCALIMPLEMENTATION TAdvFocusHelper : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	bool FHasHook;
	TFocusWindow* FW;
	unsigned FocusControl;
	int FocusHeight;
	int FocusWidth;
	Graphics::TColor FColor;
	int FSize;
	Graphics::TBitmap* FGlyph;
	int FBlur;
	System::Byte FOpacity;
	System::Byte FRounding;
	TGlyphPosition FGlyphPosition;
	TOnShowFocusEvent FOnShowFocus;
	TExcludeControls FExcludeControls;
	TIncludeControls FIncludeControls;
	int FControlTag;
	bool FActive;
	void __fastcall SetGlyph(const Graphics::TBitmap* Value);
	void __fastcall SetBlur(const int Value);
	void __fastcall SetSize(const int Value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	void __fastcall SetActive(const bool Value);
	
protected:
	virtual bool __fastcall AcceptControl(Controls::TWinControl* wc, Controls::TWinControl* wcp);
	virtual void __fastcall InitHook(void);
	virtual void __fastcall Unhook(void);
	virtual int __fastcall GetVersionNr(void);
	
public:
	__fastcall virtual TAdvFocusHelper(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvFocusHelper(void);
	void __fastcall ShowHelper(void);
	void __fastcall HideHelper(void);
	void __fastcall MoveHelper(const Types::TRect &R);
	void __fastcall ShowHelperOnControl(const Types::TRect &R);
	void __fastcall UpdateHelper(void);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=1};
	__property int Blur = {read=FBlur, write=SetBlur, default=3};
	__property Graphics::TColor Color = {read=FColor, write=FColor, default=16634775};
	__property int ControlTag = {read=FControlTag, write=FControlTag, default=0};
	__property TExcludeControls ExcludeControls = {read=FExcludeControls, write=FExcludeControls, nodefault};
	__property TIncludeControls IncludeControls = {read=FIncludeControls, write=FIncludeControls, nodefault};
	__property int Size = {read=FSize, write=SetSize, default=4};
	__property Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property TGlyphPosition GlyphPosition = {read=FGlyphPosition, write=FGlyphPosition, default=0};
	__property System::Byte Opacity = {read=FOpacity, write=FOpacity, default=180};
	__property System::Byte Rounding = {read=FRounding, write=FRounding, default=5};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TOnShowFocusEvent OnShowFocus = {read=FOnShowFocus, write=FOnShowFocus};
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x1;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;
extern PACKAGE void __fastcall DrawRoundRect(Graphics::TBitmap* Bitmap, int W, int H, int BMPW, TGlyphPosition BMPPos, int Thickness, int Radius, double Blur);

}	/* namespace Advfocushelper */
using namespace Advfocushelper;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvfocushelperHPP
