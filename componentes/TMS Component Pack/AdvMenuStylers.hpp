// CodeGear C++Builder
// Copyright (c) 1995, 2009 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Advmenustylers.pas' rev: 21.00

#ifndef AdvmenustylersHPP
#define AdvmenustylersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member functions
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <Sysinit.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Advmenus.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Advstyleif.hpp>	// Pascal unit
#include <Advgdip.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Advmenustylers
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TOfficeStyle { osOffice2003Blue, osOffice2003Silver, osOffice2003Olive, osOfficeXP, osOffice2007Luna, osOffice2007Obsidian, osCustom, osOffice2007Silver, osVista, osWhidbey, osWindows7, osTerminal, osOffice2010Blue, osOffice2010Silver, osOffice2010Black };
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


class DELPHICLASS TAdvMenuOfficeStyler;
class PASCALIMPLEMENTATION TAdvMenuOfficeStyler : public Advmenus::TCustomAdvMenuStyler
{
	typedef Advmenus::TCustomAdvMenuStyler inherited;
	
private:
	TNotifierWindow* FNotifierWnd;
	TOfficeStyle FStyle;
	bool FAutoThemeAdapt;
	void __fastcall SetStyle(const TOfficeStyle Value);
	
protected:
	void __fastcall ThemeChanged(System::TObject* Sender);
	
public:
	__fastcall virtual TAdvMenuOfficeStyler(Classes::TComponent* AOwner);
	__fastcall virtual ~TAdvMenuOfficeStyler(void);
	virtual void __fastcall Loaded(void);
	void __fastcall SetComponentStyle(Advstyleif::TTMSStyle AStyle);
	
__published:
	__property AntiAlias;
	__property bool AutoThemeAdapt = {read=FAutoThemeAdapt, write=FAutoThemeAdapt, nodefault};
	__property TOfficeStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property Background;
	__property ButtonAppearance;
	__property IconBar;
	__property SelectedItem;
	__property RootItem;
	__property Glyphs;
	__property SideBar;
	__property Separator;
	__property Font;
	__property NotesFont;
	__property UseSystemFont = {default=1};
	__property MenuBorderColor = {default=8158356};
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


#pragma option push -b-
enum TFantasyStyle { fsArctic, fsAquaBlue, fsChocolate, fsMacOS, fsSilverFox, fsSoftSand, fsTerminalGreen, fsTextured, fsWindowsClassic, fsWhidbey, fsCustom };
#pragma option pop

class DELPHICLASS TAdvMenuFantasyStyler;
class PASCALIMPLEMENTATION TAdvMenuFantasyStyler : public Advmenus::TCustomAdvMenuStyler
{
	typedef Advmenus::TCustomAdvMenuStyler inherited;
	
private:
	TFantasyStyle FStyle;
	void __fastcall SetStyle(const TFantasyStyle Value);
	
public:
	__fastcall virtual TAdvMenuFantasyStyler(Classes::TComponent* AOwner);
	
__published:
	__property AntiAlias;
	__property TFantasyStyle Style = {read=FStyle, write=SetStyle, nodefault};
	__property Background;
	__property ButtonAppearance;
	__property IconBar;
	__property SelectedItem;
	__property RootItem;
	__property Glyphs;
	__property SideBar;
	__property Separator;
	__property Font;
	__property NotesFont;
	__property UseSystemFont = {default=1};
	__property MenuBorderColor = {default=8158356};
public:
	/* TCustomAdvMenuStyler.Destroy */ inline __fastcall virtual ~TAdvMenuFantasyStyler(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Advmenustylers */
using namespace Advmenustylers;
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AdvmenustylersHPP
