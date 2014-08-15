// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advofficehint.pas' rev: 21.00

#ifndef AdvofficehintHPP
#define AdvofficehintHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Advhintinfo.hpp>	// Pascal unit
#include <Typinfo.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Gdipicture.hpp>	// Pascal unit
#include <Math.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Appevnts.hpp>	// Pascal unit
#include <Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advofficehint
{
//-- type declarations -------------------------------------------------------
typedef Controls::THintInfo THintInfo;

typedef Controls::PHintInfo PHintInfo;

typedef void __fastcall (__closure *TBeforeShowHint)(System::TObject* Sender, Controls::TControl* AControl, Advhintinfo::TAdvHintInfo* AHintInfo, bool &UseOfficeHint);

class DELPHICLASS TAdvOfficeHint;
class PASCALIMPLEMENTATION TAdvOfficeHint : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Advhintinfo::TAdvHintInfo* FHintInfo;
	Controls::TControl* FHintControl;
	Graphics::TFont* FFont;
	int FHintWidth;
	System::UnicodeString FHintHelpText;
	Gdipicture::TGDIPPicture* FHintHelpPicture;
	Graphics::TColor FHintColor;
	Graphics::TColor FHintColorTo;
	Graphics::TColor FHintHelpLineColor;
	bool FUseOfficeHint;
	bool FIsOfficeHint;
	bool FSystemFont;
	Classes::TBiDiMode FBiDiMode;
	TBeforeShowHint FOnBeforeShowHint;
	void __fastcall SetHintHelpPicture(const Gdipicture::TGDIPPicture* Value);
	void __fastcall SetFont(const Graphics::TFont* Value);
	void __fastcall SetSystemFont(const bool Value);
	
protected:
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	void __fastcall GetHintInfo(System::UnicodeString &HintStr, bool &CanShow, Controls::THintInfo &HintInfo);
	__property Controls::TControl* HintControl = {read=FHintControl, write=FHintControl};
	
public:
	__fastcall virtual TAdvOfficeHint(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeHint(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property Classes::TBiDiMode BiDiMode = {read=FBiDiMode, write=FBiDiMode, default=0};
	__property Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Graphics::TColor HintColor = {read=FHintColor, write=FHintColor, default=16777215};
	__property Graphics::TColor HintColorTo = {read=FHintColorTo, write=FHintColorTo, default=15718858};
	__property int HintWidth = {read=FHintWidth, write=FHintWidth, default=200};
	__property System::UnicodeString HintHelpText = {read=FHintHelpText, write=FHintHelpText};
	__property Gdipicture::TGDIPPicture* HintHelpPicture = {read=FHintHelpPicture, write=SetHintHelpPicture};
	__property Graphics::TColor HintHelpLineColor = {read=FHintHelpLineColor, write=FHintHelpLineColor, default=16762522};
	__property bool SystemFont = {read=FSystemFont, write=SetSystemFont, default=1};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
	__property TBeforeShowHint OnBeforeShowHint = {read=FOnBeforeShowHint, write=FOnBeforeShowHint};
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


class DELPHICLASS TAdvOfficeHintWindow;
class PASCALIMPLEMENTATION TAdvOfficeHintWindow : public Controls::THintWindow
{
	typedef Controls::THintWindow inherited;
	
private:
	bool FIsPainting;
	bool FIsActivating;
	TAdvOfficeHint* FHint;
	TAdvOfficeHint* __fastcall FindHintControl(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Messages::TMessage &Message);
	
protected:
	bool __fastcall GetPointIfOnPager(Controls::TControl* Ctrl, Types::TPoint &P);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	
public:
	virtual void __fastcall ActivateHint(const Types::TRect &Rect, const System::UnicodeString AHint);
	virtual bool __fastcall ShouldHideHint(void);
public:
	/* THintWindow.Create */ inline __fastcall virtual TAdvOfficeHintWindow(Classes::TComponent* AOwner) : Controls::THintWindow(AOwner) { }
	
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TAdvOfficeHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvOfficeHintWindow(HWND ParentWindow) : Controls::THintWindow(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt HINTROUNDING = 0x4;
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x4;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advofficehint */
using namespace Advofficehint;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvofficehintHPP
