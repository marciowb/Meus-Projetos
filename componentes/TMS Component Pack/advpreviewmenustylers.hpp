// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advpreviewmenustylers.pas' rev: 21.00

#ifndef AdvpreviewmenustylersHPP
#define AdvpreviewmenustylersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Sysutils.hpp>	// Pascal unit
#include <Advpreviewmenu.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advglowbutton.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advpreviewmenustylers
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TPreviewMenuStyle { psOffice2003Blue, psOffice2003Silver, psOffice2003Olive, psOffice2003Classic, psOffice2007Luna, psOffice2007Obsidian, psWindowsXP, psWhidbeyStyle, psCustom, psOfficeXP, psOffice2007Silver, psWindowsVista, psWindows7, psTerminal, psOffice2010Blue, psOffice2010Silver, psOffice2010Black };
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


class DELPHICLASS TAdvPreviewMenuOfficeStyler;
class PASCALIMPLEMENTATION TAdvPreviewMenuOfficeStyler : public Advpreviewmenu::TAdvCustomPreviewMenuStyler
{
	typedef Advpreviewmenu::TAdvCustomPreviewMenuStyler inherited;
	
private:
	TNotifierWindow* FNotifierWnd;
	TPreviewMenuStyle FStyle;
	void __fastcall SetStyle(const TPreviewMenuStyle Value);
	
protected:
	void __fastcall ThemeChanged(System::TObject* Sender);
	void __fastcall ChangeStyle(bool AWin7, int AStyle);
	void __fastcall ChangeMenu(Graphics::TColor AColor);
	void __fastcall UpdateMenu(void);
	void __fastcall HideMenu(void);
	void __fastcall ShowMenuShortCuts(void);
	void __fastcall HideMenuShortCuts(void);
	
public:
	__fastcall virtual TAdvPreviewMenuOfficeStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvPreviewMenuOfficeStyler(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property FrameAppearance;
	__property LeftFrameColor;
	__property RightFrameColor;
	__property MenuItemAppearance;
	__property ButtonAppearance;
	__property TPreviewMenuStyle Style = {read=FStyle, write=SetStyle, nodefault};
private:
	void *__IWinStyle;	/* Advgdip::IWinStyle */
	void *__ITMSStyle;	/* Advstyleif::ITMSStyle */
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	operator Advgdip::_di_IWinStyle()
	{
		Advgdip::_di_IWinStyle intf;
		GetInterface(intf);
		return intf;
	}
	#else
	operator IWinStyle*(void) { return (IWinStyle*)&__IWinStyle; }
	#endif
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


class DELPHICLASS TAdvPreviewMenuFantasyStyler;
class PASCALIMPLEMENTATION TAdvPreviewMenuFantasyStyler : public Advpreviewmenu::TAdvCustomPreviewMenuStyler
{
	typedef Advpreviewmenu::TAdvCustomPreviewMenuStyler inherited;
	
public:
	__fastcall virtual TAdvPreviewMenuFantasyStyler(Classes::TComponent* AOwner);
	
__published:
	__property FrameAppearance;
	__property LeftFrameColor;
	__property RightFrameColor;
	__property MenuItemAppearance;
	__property ButtonAppearance;
public:
	/* TAdvCustomPreviewMenuStyler.Destroy */ inline __fastcall virtual ~TAdvPreviewMenuFantasyStyler(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advpreviewmenustylers */
using namespace Advpreviewmenustylers;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvpreviewmenustylersHPP
