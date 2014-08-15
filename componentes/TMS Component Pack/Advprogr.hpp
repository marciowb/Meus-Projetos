// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advprogr.pas' rev: 21.00

#ifndef AdvprogrHPP
#define AdvprogrHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Comctrls.hpp>	// Pascal unit
#include <Commctrl.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advprogr
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TAdvProgress;
class PASCALIMPLEMENTATION TAdvProgress : public Comctrls::TProgressBar
{
	typedef Comctrls::TProgressBar inherited;
	
private:
	Graphics::TColor FBarColor;
	Graphics::TColor FBkColor;
	void __fastcall SetProBarColor(Graphics::TColor avalue);
	void __fastcall SetProBkColor(Graphics::TColor avalue);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	int __fastcall GetVersionNr(void);
	
protected:
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TAdvProgress(Classes::TComponent* aOwner);
	
__published:
	__property Graphics::TColor BarColor = {read=FBarColor, write=SetProBarColor, nodefault};
	__property Graphics::TColor BkColor = {read=FBkColor, write=SetProBkColor, nodefault};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TAdvProgress(HWND ParentWindow) : Comctrls::TProgressBar(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TAdvProgress(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Advprogr */
using namespace Advprogr;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvprogrHPP
