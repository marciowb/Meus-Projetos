// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Maskedex.pas' rev: 21.00

#ifndef MaskedexHPP
#define MaskedexHPP

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
#include <Forms.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Stdctrls.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Maskedex
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TMaskEditEx;
class PASCALIMPLEMENTATION TMaskEditEx : public Mask::TMaskEdit
{
	typedef Mask::TMaskEdit inherited;
	
private:
	bool FAutoTab;
	bool FEnterTab;
	Classes::TAlignment FAlignment;
	HIDESBASE void __fastcall SetAlignment(Classes::TAlignment value);
	System::UnicodeString __fastcall GetVersion(void);
	void __fastcall SetVersion(const System::UnicodeString Value);
	
protected:
	virtual int __fastcall GetVersionNr(void);
	DYNAMIC void __fastcall KeyUp(System::Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall DoEnter(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	
public:
	__fastcall virtual TMaskEditEx(Classes::TComponent* AOwner);
	
__published:
	__property bool AutoTab = {read=FAutoTab, write=FAutoTab, default=1};
	__property bool EnterTab = {read=FEnterTab, write=FEnterTab, default=1};
	__property Classes::TAlignment Alignement = {read=FAlignment, write=SetAlignment, default=0};
	__property System::UnicodeString Version = {read=GetVersion, write=SetVersion};
public:
	/* TWinControl.CreateParented */ inline __fastcall TMaskEditEx(HWND ParentWindow) : Mask::TMaskEdit(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TMaskEditEx(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const ShortInt MAJ_VER = 0x1;
static const ShortInt MIN_VER = 0x2;
static const ShortInt REL_VER = 0x0;
static const ShortInt BLD_VER = 0x0;

}	/* namespace Maskedex */
using namespace Maskedex;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// MaskedexHPP
