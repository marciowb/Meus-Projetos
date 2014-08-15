// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advofficestatusbarstylers.pas' rev: 21.00

#ifndef AdvofficestatusbarstylersHPP
#define AdvofficestatusbarstylersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Advofficestatusbar.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advofficestatusbarstylers
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TOfficeStatusBarFantasyStyle { psArctic, psAquaBlue, psChocolate, psMacOS, psSilverFox, psSoftSand, psTerminalGreen, psTextured, psWindowsClassic, psUser };
#pragma option pop

#pragma option push -b-
enum TOfficeStatusBarStyle { psOffice2003Blue, psOffice2003Silver, psOffice2003Olive, psOffice2003Classic, psOffice2007Luna, psOffice2007Obsidian, psWindowsXP, psWhidbey, psCustom, psOffice2007Silver, psWindowsVista, psWindows7, psTerminal, psOffice2010Blue, psOffice2010Silver, psOffice2010Black };
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


class DELPHICLASS TAdvOfficeStatusBarOfficeStyler;
class PASCALIMPLEMENTATION TAdvOfficeStatusBarOfficeStyler : public Advofficestatusbar::TCustomAdvOfficeStatusBarStyler
{
	typedef Advofficestatusbar::TCustomAdvOfficeStatusBarStyler inherited;
	
private:
	TNotifierWindow* FNotifierWnd;
	TOfficeStatusBarStyle FOfficeStatusBarStyle;
	
protected:
	void __fastcall SetOfficeStatusBarStyle(const TOfficeStatusBarStyle Value);
	void __fastcall ThemeChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvOfficeStatusBarOfficeStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvOfficeStatusBarOfficeStyler(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property TOfficeStatusBarStyle Style = {read=FOfficeStatusBarStyle, write=SetOfficeStatusBarStyle, default=0};
	__property AutoThemeAdapt = {default=0};
	__property BorderColor;
	__property PanelAppearanceLight;
	__property PanelAppearanceDark;
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


class DELPHICLASS TAdvOfficeStatusBarFantasyStyler;
class PASCALIMPLEMENTATION TAdvOfficeStatusBarFantasyStyler : public Advofficestatusbar::TCustomAdvOfficeStatusBarStyler
{
	typedef Advofficestatusbar::TCustomAdvOfficeStatusBarStyler inherited;
	
private:
	TOfficeStatusBarFantasyStyle FOfficeStatusBarStyle;
	
protected:
	void __fastcall SetOfficeStatusBarStyle(const TOfficeStatusBarFantasyStyle Value);
	
public:
	__fastcall virtual TAdvOfficeStatusBarFantasyStyler(Classes::TComponent* AOwner);
	
__published:
	__property TOfficeStatusBarFantasyStyle Style = {read=FOfficeStatusBarStyle, write=SetOfficeStatusBarStyle, default=2};
	__property BorderColor;
	__property PanelAppearanceLight;
	__property PanelAppearanceDark;
public:
	/* TCustomAdvOfficeStatusBarStyler.Destroy */ inline __fastcall virtual ~TAdvOfficeStatusBarFantasyStyler(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advofficestatusbarstylers */
using namespace Advofficestatusbarstylers;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvofficestatusbarstylersHPP
