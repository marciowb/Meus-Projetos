// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advcardliststyler.pas' rev: 21.00

#ifndef AdvcardliststylerHPP
#define AdvcardliststylerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advcardlist.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advcardliststyler
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TAdvCardListStyle { clsXPBlue, clsAquaBlue, clsSilverFox, clsBasicBeige, clsTerminalGreen2, clsMacOS, clsOffice2003, clsOffice2007Luna, clsOffice2007Obsidian, clsWhidbey, clsOffice2007Silver, clsTerminal, clsWindowsVista, clsWindows7, clsOffice2010Blue, clsOffice2010Silver, clsOffice2010Black, clsCustom };
#pragma option pop

class DELPHICLASS TAdvCustomCardListStyler;
class PASCALIMPLEMENTATION TAdvCustomCardListStyler : public Classes::TComponent
{
	typedef Classes::TComponent inherited;
	
private:
	Advcardlist::TCustomAdvCardList* FCardList;
	void __fastcall SetCardList(const Advcardlist::TCustomAdvCardList* Value);
	
protected:
	virtual void __fastcall ApplyStyle(void);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation AOperation);
	
__published:
	__property Advcardlist::TCustomAdvCardList* CardList = {read=FCardList, write=SetCardList};
public:
	/* TComponent.Create */ inline __fastcall virtual TAdvCustomCardListStyler(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TAdvCustomCardListStyler(void) { }
	
};


class DELPHICLASS TAdvCardListStyler;
class PASCALIMPLEMENTATION TAdvCardListStyler : public TAdvCustomCardListStyler
{
	typedef TAdvCustomCardListStyler inherited;
	
private:
	TAdvCardListStyle FStyle;
	void __fastcall SetStyle(const TAdvCardListStyle Value);
	
protected:
	virtual void __fastcall ApplyStyle(void);
	
public:
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property TAdvCardListStyle Style = {read=FStyle, write=SetStyle, default=0};
public:
	/* TComponent.Create */ inline __fastcall virtual TAdvCardListStyler(Classes::TComponent* AOwner) : TAdvCustomCardListStyler(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TAdvCardListStyler(void) { }
	
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


//-- var, const, procedure ---------------------------------------------------
static const ShortInt TMS_COLOR_MENUBAR = 0x1e;
static const unsigned clSystemColor = 0xff000000;
static const Graphics::TColor clMenuBar = -16777186;
static const Graphics::TColor clCream = 15793151;

}	/* namespace Advcardliststyler */
using namespace Advcardliststyler;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvcardliststylerHPP
