// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advofficetabsetstylers.pas' rev: 21.00

#ifndef AdvofficetabsetstylersHPP
#define AdvofficetabsetstylersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Advofficetabset.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advofficetabsetstylers
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TOfficeTabSetFantasyStyle { tsArctic, tsAquaBlue, tsChocolate, tsMacOS, tsSilverFox, tsSoftSand, tsTerminalGreen, tsTextured, tsWindowsClassic, tsUser };
#pragma option pop

#pragma option push -b-
enum TOfficeTabSetStyle { tsOffice2003Blue, tsOffice2003Silver, tsOffice2003Olive, tsOffice2003Classic, tsOffice2007Luna, tsOffice2007Obsidian, tsWindowsXP, tsWhidbey, tsCustom, tsOffice2007Silver, tsWindowsVista, tsWindows7, tsTerminal, tsOffice2010Blue, tsOffice2010Silver, tsOffice2010Black };
#pragma option pop

class DELPHICLASS TNotifierWindow;
class PASCALIMPLEMENTATION TNotifierWindow : public Controls::TWinControl
{
	typedef Controls::TWinControl inherited;
	
private:
	Classes::TNotifyEvent FOnThemeChange;
	
protected:
	virtual void __fastcall WndProc(Messages::TMessage &Msg);
	
__published:
	__property Classes::TNotifyEvent OnThemeChange = {read=FOnThemeChange, write=FOnThemeChange};
public:
	/* TWinControl.Create */ inline __fastcall virtual TNotifierWindow(Classes::TComponent* AOwner) : Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TNotifierWindow(HWND ParentWindow) : Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TNotifierWindow(void) { }
	
};


class DELPHICLASS TAdvOfficeTabSetOfficeStyler;
class PASCALIMPLEMENTATION TAdvOfficeTabSetOfficeStyler : public Advofficetabset::TCustomAdvOfficeTabSetStyler
{
	typedef Advofficetabset::TCustomAdvOfficeTabSetStyler inherited;
	
private:
	TNotifierWindow* FNotifierWnd;
	TOfficeTabSetStyle FOfficeTabSetStyle;
	
protected:
	void __fastcall SetOfficeTabSetStyle(const TOfficeTabSetStyle Value);
	void __fastcall ThemeChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvOfficeTabSetOfficeStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeTabSetOfficeStyler(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property AutoThemeAdapt = {default=0};
	__property ButtonBorderColor;
	__property GlowButtonAppearance;
	__property TOfficeTabSetStyle Style = {read=FOfficeTabSetStyle, write=SetOfficeTabSetStyle, default=0};
	__property TabAppearance;
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


class DELPHICLASS TAdvOfficeTabSetFantasyStyler;
class PASCALIMPLEMENTATION TAdvOfficeTabSetFantasyStyler : public Advofficetabset::TCustomAdvOfficeTabSetStyler
{
	typedef Advofficetabset::TCustomAdvOfficeTabSetStyler inherited;
	
private:
	TOfficeTabSetFantasyStyle FOfficeTabSetStyle;
	
protected:
	void __fastcall SetOfficeTabSetStyle(const TOfficeTabSetFantasyStyle Value);
	
public:
	__fastcall virtual TAdvOfficeTabSetFantasyStyler(Classes::TComponent* AOwner);
	
__published:
	__property ButtonBorderColor;
	__property GlowButtonAppearance;
	__property TOfficeTabSetFantasyStyle Style = {read=FOfficeTabSetStyle, write=SetOfficeTabSetStyle, default=2};
	__property TabAppearance;
public:
	/* TCustomAdvOfficeTabSetStyler.Destroy */ inline __fastcall virtual ~TAdvOfficeTabSetFantasyStyler(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advofficetabsetstylers */
using namespace Advofficetabsetstylers;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvofficetabsetstylersHPP
